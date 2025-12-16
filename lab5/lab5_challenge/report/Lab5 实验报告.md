---
title: Lab5 实验报告

---

# Lab5 实验报告

## 练习1：加载应用程序并执行（需要编码）

> do_execve函数调用load_icode（位于kern/process/proc.c中）来加载并解析一个处于内存中的ELF执行文件格式的应用程序。你需要补充load_icode的第6步，建立相应的用户内存空间来放置应用程序的代码段、数据段等，且要设置好proc_struct结构中的成员变量trapframe中的内容，确保在执行此进程后，能够从应用程序设定的起始执行地址开始执行。需设置正确的trapframe内容。

### 设计实现过程

`load_icode` 的主要功能是为一个新进程建立虚拟内存空间，加载 ELF 格式的二进制代码，并设置好执行环境。第 6 步的核心任务是构造 `trapframe`（中断帧），以便内核在执行 `sret` 指令返回用户态时，CPU 能够跳转到应用程序的入口点，并且拥有正确的栈指针和特权级。

代码实现逻辑如下：
1.  **设置用户栈指针 (sp)**：将 `tf->gpr.sp` 设置为 `USTACKTOP`。这是用户地址空间中用户栈的顶部地址。
2.  **设置程序入口地址 (epc)**：将 `tf->epc` 设置为 ELF 头中记录的入口地址 `elf->e_entry`。当发生中断返回时，PC 指针将跳转到这里。
3.  **设置状态寄存器 (status)**：
    *   清除 `SSTATUS_SPP` 位：将其置为 0，表示通过 `sret` 返回后，CPU 的特权级将切换到 User Mode（用户模式）。
    *   设置 `SSTATUS_SPIE` 位：将其置为 1，表示在从内核态返回用户态后，开启中断响应（User Mode 下允许中断）。

```c
struct trapframe *tf = current->tf;
// 保持 sstatus 的其他位不变
uintptr_t sstatus = tf->status; 
memset(tf, 0, sizeof(struct trapframe));

// 1. 设置用户栈顶
tf->gpr.sp = USTACKTOP;
// 2. 设置 ELF 入口点
tf->epc = elf->e_entry;
// 3. 设置特权级为用户态，并开启中断
// SSTATUS_SPP = 0 (User Mode), SSTATUS_SPIE = 1 (Enable Interrupts)
tf->status = (read_csr(sstatus) & ~SSTATUS_SPP) | SSTATUS_SPIE;
```

### 用户态进程被ucore选择占用CPU执行到执行第一条指令的经过

1.  **调度器选择**：ucore 的调度器（`schedule`）从就绪队列中选择该进程（状态为 `PROC_RUNNABLE`）。
2.  **上下文切换**：调用 `switch_to`，CPU 切换到该进程的内核栈，恢复内核上下文（`context`），跳转到 `proc->context.ra` 指向的地址，即 `forkret` 函数。
3.  **跳转到中断返回点**：`forkret` 调用 `forkrets(current->tf)`，该函数接收构造好的 `trapframe` 指针。
4.  **恢复现场**：代码跳转到 `__trapret`（在 `trapentry.S` 中），在此处执行 `RESTORE_ALL`，将 `trapframe` 中的通用寄存器值恢复到 CPU 寄存器中（此时 `sp` 变为 `USTACKTOP`）。
5.  **特权级切换**：执行 `sret` 指令。CPU 根据 `sstatus`（SPP=0）切换到用户态，并跳转到 `sepc` 指向的地址（即 `elf->e_entry`）。
6.  **执行第一条指令**：此时 PC 指向应用程序入口，CPU 处于用户态，开始执行用户程序的第一条指令。

---

## 练习2：父进程复制自己的内存空间给子进程（需要编码）

> 创建子进程的函数do_fork在执行中将拷贝当前进程（即父进程）的用户内存地址空间中的合法内容到新进程中（子进程），完成内存资源的复制。具体是通过copy_range函数（位于kern/mm/pmm.c中）实现的，请补充copy_range的实现，确保能够正确执行。

### 设计实现过程

`copy_range` 函数的作用是将父进程某一段虚拟内存地址范围内的内容复制给子进程。如果不采用 Copy-on-Write (COW)，则需要进行物理内存的“深拷贝”。

实现步骤：
1.  **遍历页表**：以 `PGSIZE` 为步长，遍历指定范围 `[start, end)`。
2.  **查找源页表项**：通过 `get_pte` 获取父进程在当前地址 `start` 的页表项 `ptep`。
3.  **检查有效性**：如果 `ptep` 存在且有效（`PTE_V`），说明该页被占用。
4.  **分配新页**：为子进程分配一个新的物理页 `npage`。
5.  **复制内容**：
    *   通过 `page2kva` 获取父进程物理页的内核虚拟地址 `src_kvaddr`。
    *   通过 `page2kva` 获取子进程新页的内核虚拟地址 `dst_kvaddr`。
    *   调用 `memcpy(dst_kvaddr, src_kvaddr, PGSIZE)` 复制整页数据。
6.  **建立映射**：调用 `page_insert` 将新页 `npage` 映射到子进程的页表 `to` 中，线性地址为 `start`，权限位 `perm` 与父进程保持一致（从 `*ptep` 获取）。

```c
// 关键代码片段
void *src_kvaddr = page2kva(page);
void *dst_kvaddr = page2kva(npage);
memcpy(dst_kvaddr, src_kvaddr, PGSIZE);
ret = page_insert(to, npage, start, perm);
```

### 如何设计实现 Copy on Write (COW) 机制？

**概要设计：**

1.  **修改 `do_fork` 中的内存复制逻辑**：
    *   在 `copy_mm` -> `dup_mmap` -> `copy_range` 阶段，不再申请新的物理页并进行内存拷贝。
    *   而是将子进程的页表项（PTE）指向父进程相同的物理页。
    *   **关键点**：将父进程和子进程的对应 PTE 的权限都设置为 **只读 (Read-only)**，即清除 `PTE_W` 位。同时，需要在页结构的元数据（如 `Page` 结构体）中维护引用计数。

2.  **处理 Page Fault (缺页异常)**：
    *   当父进程或子进程尝试写入这些只读页面时，CPU 会触发 Store/AMO Page Fault 异常。
    *   在 `do_pgfault` 函数中检测异常原因：
        *   如果异常是由写操作引起的（`cause` 为写异常）。
        *   并且该页在 VMA 记录中是可写的（`VM_WRITE`）。
        *   并且该页目前的 PTE 是只读的。
    *   **执行写时复制**：
        *   分配一个新的物理页。
        *   将原物理页的内容拷贝到新页中。
        *   更新触发异常进程的 PTE，使其指向新页，并恢复 **可写 (Read/Write)** 权限。
        *   递减原物理页的引用计数。如果引用计数减为 1，则原拥有者也可以恢复该页的可写权限（优化）。

3.  **引用计数管理**：需要确保物理页的引用计数（`page->ref`）准确反映共享该页的进程数量。

---

## 练习3：阅读分析源代码，理解进程执行 fork/exec/wait/exit 的实现

### fork/exec/wait/exit 的执行流程分析

1.  **fork (创建进程)**
    *   **用户态**：调用 `sys_fork`，执行 `ecall` 指令陷入内核。
    *   **内核态**：`trap` 分发到 `syscall`，调用 `do_fork`。
        *   分配 PCB，分配内核栈。
        *   复制内存（`copy_mm`）和上下文（`copy_thread`）。
        *   在 `copy_thread` 中，将子进程的 `tf->a0` (返回值) 设置为 0。
        *   将子进程加入就绪队列。
        *   父进程 `do_fork` 返回子进程 PID。
    *   **返回**：父进程返回 PID，子进程被调度后返回 0。

2.  **exec (加载程序)**
    *   **用户态**：调用 `sys_exec`，提供程序路径/参数。
    *   **内核态**：调用 `do_execve`。
        *   回收当前进程的内存空间（`exit_mmap`）。
        *   调用 `load_icode` 加载新二进制程序，重新建立内存映射，重置 `trapframe`（如练习1所述）。
    *   **返回**：不返回原程序，而是通过 `sret` 跳转到新程序的入口点执行。

3.  **wait (等待子进程)**
    *   **用户态**：调用 `sys_wait`。
    *   **内核态**：调用 `do_wait`。
        *   查找是否有子进程处于 `PROC_ZOMBIE` 状态。
        *   如果有僵尸子进程，回收其剩余资源（内核栈、PCB），返回子进程 PID 和退出码。
        *   如果没有僵尸子进程但有运行中的子进程，将当前进程状态设为 `PROC_SLEEPING` 并调用 `schedule` 让出 CPU。
    *   **返回**：被唤醒后返回处理掉的子进程 PID。

4.  **exit (进程退出)**
    *   **用户态**：调用 `sys_exit`。
    *   **内核态**：调用 `do_exit`。
        *   释放虚拟内存空间（`mm_destroy`）。
        *   设置状态为 `PROC_ZOMBIE`。
        *   如果有父进程在等待（`WT_CHILD`），唤醒父进程。
        *   调用 `schedule` 切换到其他进程（不再返回）。

**内核态与用户态的交错执行：**
程序主要运行在用户态，当需要操作系统服务（如创建进程、IO）或发生中断（时钟中断）时，通过 `ecall` 或硬件中断机制切换到内核态。内核完成服务后，通过 `sret` 指令恢复上下文返回用户态。

**内核态执行结果返回给用户程序：**
通过 `trapframe` 中的寄存器传递。在 RISC-V 中，返回值通常存放在 `a0` 寄存器中。内核修改 `tf->gpr.a0` 的值，当 `sret` 恢复上下文时，用户程序就能在 `a0` 寄存器看到返回值。

### 用户态进程执行状态生命周期图

```text
       alloc_proc                                 schedule()
           +                                     +-->--+
           |                                     |     |
           V                                     +--<--+
      PROC_UNINIT -- proc_init/wakeup_proc --> PROC_RUNNABLE --+
                                                 A             | try_free_pages
                                                 |             | do_wait
                                     wakeup_proc |             | do_sleep
                                                 |             V
                                           PROC_SLEEPING <-----+
                                                 |
                                                 | do_exit
                                                 V
                                            PROC_ZOMBIE
                                                 |
                                                 | do_wait (by parent)
                                                 V
                                               (Dead / Struct Freed)
```
make grade结果：
![image](https://hackmd.io/_uploads/Skn-0srGWe.png)

---

## 扩展练习 Challenge：Copy on Write (COW) 机制实验报告

### 1. 总体设计思路

Copy-on-Write (COW) 是一种内存管理优化技术。在 ucore 中，默认的 `fork` 操作会调用 `copy_range` 进行内存的“深拷贝”（即分配新页并复制内容）。实现 COW 后，`fork` 变为“浅拷贝”：
1.  **Fork 阶段**：父子进程共享物理页，将双方页表项（PTE）的写权限（PTE_W）全部去除，标记为只读，并增加物理页引用计数。
2.  **运行阶段**：如果进程仅读取数据，则继续共享，无额外开销。
3.  **写异常阶段**：当任一进程尝试写入只读页时，CPU 触发缺页异常（Page Fault）。内核捕获异常，检测到是 COW 场景，分配新物理页，拷贝数据，将新页映射给当前进程并恢复写权限。

---

### 2. 实现源码

需要修改两个核心文件：`kern/mm/pmm.c`（修改复制逻辑）和 `kern/mm/vmm.c`（增加写异常处理）。

### (1) 修改 `kern/mm/pmm.c`

重写 `copy_range` 函数。不再分配新内存，而是建立共享映射并移除写权限。

```c
// kern/mm/pmm.c

int copy_range(pde_t *to, pde_t *from, uintptr_t start, uintptr_t end,
               bool share) {
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
    assert(USER_ACCESS(start, end));
    
    do {
        // 获取父进程的页表项
        pte_t *ptep = get_pte(from, start, 0);
        if (ptep == NULL) {
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
            continue;
        }
        
        if (*ptep & PTE_V) {
            // 获取物理页结构
            struct Page *page = pte2page(*ptep);
            // 获取原权限
            uint32_t perm = (*ptep & PTE_USER);

            // [COW 核心逻辑 1]：如果页面原本可写，则需要移除父子进程的写权限
            if (perm & PTE_W) {
                // 移除权限变量中的写标记
                perm &= ~PTE_W;
                // 移除父进程页表项的写标记
                *ptep = *ptep & ~PTE_W;
                // 必须刷新父进程的 TLB，否则 CPU 缓存的快表仍允许写入
                tlb_invalidate(from, start);
            }
            
            // [COW 核心逻辑 2]：将该页映射到子进程，权限为只读 (无 PTE_W)
            // page_insert 内部会自动执行 page_ref_inc(page)，增加引用计数
            int ret = page_insert(to, page, start, perm);
            assert(ret == 0);
        }
        start += PGSIZE;
    } while (start != 0 && start < end);
    return 0;
}
```

#### (2) 修改 `kern/mm/vmm.c`

修改 `do_pgfault` 函数。在进行默认的页分配前，拦截“写只读页”的异常。

```c
// kern/mm/vmm.c

int do_pgfault(struct mm_struct *mm, uint32_t error_code, uintptr_t addr) {
    int ret = -E_INVAL;
    struct vma_struct *vma = find_vma(mm, addr);
    pgfault_num++;
    
    if (vma == NULL || vma->vm_start > addr) {
        cprintf("not valid addr %x, and can not find it in vma\n", addr);
        goto failed;
    }

    // [COW 核心逻辑 3]：处理写时复制异常
    // 计算页对齐地址
    uintptr_t page_addr = ROUNDDOWN(addr, PGSIZE);
    
    // 构造基于 VMA 属性的权限（用于恢复写权限）
    uint32_t perm = PTE_U;
    if (vma->vm_flags & VM_WRITE) perm |= (PTE_R | PTE_W);
    
    pte_t *ptep = get_pte(mm->pgdir, page_addr, 0);

    // 判定条件：PTE存在且有效 + PTE不可写 + VMA标记可写
    if (ptep != NULL && (*ptep & PTE_V) && !(*ptep & PTE_W) && (vma->vm_flags & VM_WRITE)) {
        struct Page *page = pte2page(*ptep);

        // 情况 A: 引用计数 > 1，说明页面被共享，必须复制
        if (page_ref(page) > 1) {
            struct Page *npage = alloc_page(); // 分配新页
            if (npage == NULL) goto failed;
            
            // 拷贝内容
            memcpy(page2kva(npage), page2kva(page), PGSIZE);
            
            // 建立新映射，赋予写权限。page_insert 会自动减少原 page 的引用计数
            if (page_insert(mm->pgdir, npage, page_addr, perm) != 0) {
                free_page(npage);
                goto failed;
            }
        }
        // 情况 B: 引用计数 == 1，说明是最后一个持有者，直接恢复权限
        else {
            // 重新插入自身，更新权限位（增加 PTE_W）
            if (page_insert(mm->pgdir, page, page_addr, perm) != 0) {
                goto failed;
            }
        }
        // COW 处理完毕
        return 0;
    }
    
    // ... [后续代码保持不变，处理普通缺页] ...
    
    perm = PTE_U;
    if (vma->vm_flags & VM_WRITE) perm |= PTE_W;
    if (vma->vm_flags & VM_READ) perm |= PTE_R;
    if (vma->vm_flags & VM_EXEC) perm |= PTE_X;
    
    if (pgdir_alloc_page(mm->pgdir, addr, perm) == NULL) {
        cprintf("pgdir_alloc_page in do_pgfault failed\n");
        goto failed;
    }
    return 0;

failed:
    return ret;
}
```

---

### 3. 测试用例

创建 `user/cowtest.c`，通过父子进程修改共享数据来验证内存隔离和写时复制是否生效。

```c
#include <stdio.h>
#include <ulib.h>

int main(void) {
    cprintf("COW Test Start...\n");
    // 1. 定义一个初始值，位于数据段/BSS段
    static volatile int shared_data = 100;
    
    int pid = fork();

    if (pid == 0) {
        // ==== 子进程 ====
        // 此时应共享物理页，shared_data 读取无误
        assert(shared_data == 100);
        cprintf("Child:  Initial read OK. Now writing...\n");
        
        // 2. 尝试写入，触发 Write Page Fault -> COW 发生
        shared_data = 200; 
        
        cprintf("Child:  Write finished. Value = %d\n", shared_data);
        assert(shared_data == 200);
        exit(0);
    } else {
        // ==== 父进程 ====
        if (wait() != 0) panic("wait failed");

        // 3. 检查父进程的数据是否被污染
        cprintf("Parent: Child exited. My value = %d\n", shared_data);
        
        // 如果 COW 成功，父进程的值应仍为 100
        if (shared_data == 100) {
             cprintf("COW Test Passed! Parent memory was protected.\n");
        } else {
             cprintf("COW Test Failed! Value changed to %d.\n", shared_data);
        }
    }
    return 0;
}
```
![image](https://hackmd.io/_uploads/By0z52BGbl.png)


#### 结果分析


1.  **`kernel_execve: pid = 2, name = "cowtest".`**
    *   内核成功加载并启动了我们编写的测试程序 `cowtest`。

2.  **`Child: Initial read OK. Now writing...`**
    *   **现象**：子进程成功读取了 `shared_data` 的初始值（100）。
    *   **COW 原理**：此时，父子进程的页表项（PTE）都指向同一个物理页，且都标记为**只读**。因为只是读取操作，不触发异常，直接从共享物理页读取数据。

3.  **`Child: Write finished. Value = 200`**
    *   **现象**：子进程成功将 `shared_data` 修改为 200。
    *   **COW 原理**：
        1.  当子进程尝试写入变量时，由于 PTE 是只读的，CPU 触发了 **Store Page Fault**（写缺页异常）。
        2.  进入 `do_pgfault` 函数，检测到这是一个 COW 场景（VMA 可写但 PTE 只读）。
        3.  内核分配了一个**新的物理页**。
        4.  内核将原物理页的内容（100）拷贝到新页中。
        5.  内核将子进程的 PTE 指向新页，并**开启写权限**。
        6.  异常处理结束，子进程重试写操作，这次成功写入新页，值为 200。

4.  **`Parent: Child exited. My value = 100`**
    *   **现象**：父进程读取 `shared_data`，值依然是 100。
    *   **COW 原理**：父进程的页表项依然指向**旧的物理页**。因为子进程写的时候已经发生了“分裂”（Copy），子进程写的是新页，父进程读的是旧页。这证明了内存隔离成功，父进程的数据未被污染。

5.  **`COW Test Passed! Parent memory was protected.`**
    *   测试逻辑验证通过。

6.  **`init check memory pass.`**
    *   表明所有的引用计数管理（`page_ref`）也是正确的，没有发生内存泄漏。


### 4. COW 状态转换设计 (有限状态机)

我们可以将物理页的状态视为一个有限状态机 (FSM)。状态由 **引用计数 (`ref`)** 和 **页表项写权限 (`PTE_W`)** 决定。

#### 状态定义
1.  **独占可写状态 (Exclusive-RW)**
    *   特征：`page->ref == 1` 且 `PTE_W == 1`。
    *   含义：物理页仅被一个进程映射，且该进程拥有写权限。这是正常的内存使用状态。
2.  **共享只读状态 (Shared-RO / COW)**
    *   特征：`page->ref >= 1` 且 `PTE_W == 0` (即便 VMA 标记为可写)。
    *   含义：物理页可能被多个进程映射（也可能只有一个，如 fork 后父进程还未写），所有映射都强制只读。

#### 状态转换图与事件

```text
       [Init/Alloc]
            |
            V
  +----------------------+
  | State: Exclusive-RW  | <--------------------------------+
  | (ref=1, W=1)         |                                  |
  +----------------------+                                  |
            |                                               |
      Event: Fork()                                         |
            |                                               |
            V                                               |
  +----------------------+                           Event: Write Fault
  | State: Shared-RO     | ----------------------+   (ref == 1)
  | (ref >= 1, W=0)      |                       |   [Optimization]
  +----------------------+                       |   Restore W bit
            |                                    |          |
      Event: Write Fault                         |          |
      (ref > 1)                                  +----------+
            |
            V
    [Action: Copy Page]
            |
            V
    Current Process -> Goto Exclusive-RW (New Page)
    Other Processes -> Stay Shared-RO (Old Page, ref--)
```

**详细说明：**
*   **Fork() 事件**：将父进程原本的 Exclusive-RW 状态转变为 Shared-RO。子进程也进入 Shared-RO 指向同一页。引用计数增加。
*   **Read 事件**：在任何状态下读取，状态保持不变。
*   **Write Fault 事件 (当处于 Shared-RO 时)**：
    *   **分支 A (ref > 1)**：通过 `alloc_page` 创建新页，拷贝数据。当前进程脱离共享，指向新页并进入 Exclusive-RW 状态。原物理页引用计数减 1。
    *   **分支 B (ref == 1)**：这是 COW 的优化路径。说明其他共享者已退出或已拷贝分离。不需要拷贝，直接将当前页的权限恢复为 PTE_W，回到 Exclusive-RW 状态。

---

### 5. 关于 Dirty COW 漏洞的分析

#### 漏洞原理
Dirty COW (CVE-2016-5195) 是 Linux 内核中的一个竞态条件漏洞。攻击者利用 COW 逻辑中的非原子性操作：
1.  **线程 A**：写入只读页，触发缺页异常，内核准备执行 COW（获取原页 -> 准备复制）。
2.  **线程 B**：同时调用 `madvise(MADV_DONTNEED)`，告诉内核丢弃该内存映射。
3.  **结果**：由于时序问题，内核可能会错误地将写操作直接作用在**原物理页**（例如只读文件的页缓存）上，而不是新分配的副本页上，导致只读文件被修改。

### ucore 中的模拟与解释
在目前的 ucore Lab 5 环境中，模拟 Dirty COW 是极其困难的，原因如下：
*   **单核/无抢占**：ucore Lab 5 的内核态通常是不可抢占的，且没有实现复杂的多线程内存管理（如 `madvise`）。
*   **缺乏并发原语**：没有足够复杂的锁机制来构造出这种微秒级的竞态窗口。

**如果在 ucore 中模拟（理论层面）：**
我们需要引入多线程和内核抢占。假设有两个内核线程操作同一个 `mm_struct`：
1.  Thread 1 进入 `do_pgfault`，检测到 COW，判断 `ref > 1`。
2.  **中断发生，切换到 Thread 2**。
3.  Thread 2 执行 `exit` 或 `munmap`，释放了该页，导致 `ref` 变为 1。
4.  **切回 Thread 1**。Thread 1 仍持有旧的 `page` 指针，如果它没有重新检查状态，可能会继续执行拷贝逻辑，或者如果逻辑有误，可能会破坏页表引用。

#### 解决方案
防止此类漏洞的核心在于 **保证原子性（Atomicity）**：
1.  **加锁**：在 `do_pgfault` 处理 COW 的整个过程中，必须持有 `mm->mm_lock`。这确保了在处理缺页时，没有其他线程可以修改页表结构或 VMA 属性。
    ```c
    lock_mm(mm);
    // ... 执行 COW 检查、分配、拷贝、映射 ...
    unlock_mm(mm);
    ```
2.  **严格的引用计数检查**：在执行关键写操作前，确保引用的物理页依然是预期的那个，且状态未被并发修改。

---

### 6. 关于用户程序加载机制的回答

**问题：说明该用户程序是何时被预先加载到内存中的？与我们常用操作系统的加载有何区别，原因是什么？**

#### (1) 何时被加载？
在 Lab 5 中，用户程序是在 **内核启动时（Boot time）** 就已经存在于物理内存中了，随后在 `do_execve` -> `load_icode` 阶段被**拷贝**到用户进程的虚拟地址空间。

具体机制是：
*   用户程序（如 `hello.c`）被编译为二进制文件。
*   通过链接器（`ld`）脚本和 `Makefile`，这些二进制文件被直接嵌入到了 **内核镜像（Kernel Image）** 的 `.data` 段中。
*   代码中通过 `_binary_obj___user_hello_out_start` 这样的符号直接访问这些内存块。

#### (2) 与常用操作系统（如 Linux/Windows）的区别
*   **常用 OS (按需分页/Demand Paging)**：
    *   程序存储在磁盘（硬盘/SSD）的文件系统中。
    *   执行 `exec` 时，操作系统只读取 ELF 头，建立虚拟内存映射（VMA），**不**立即将代码加载到物理内存。
    *   当程序真正执行到某行代码时，触发缺页异常，OS 才从磁盘将该页数据读取到内存（Lazy Loading）。
*   **ucore Lab 5**：
    *   程序“寄生”在内核内存中。
    *   执行 `exec` 时，`load_icode` 会直接申请物理内存，并将代码段、数据段从内核数据区 **一次性完整拷贝** 到进程内存中（类似 memcpy）。

#### (3) 原因是什么？
主要原因是 **文件系统尚未实现**。
*   在 Lab 5 阶段，操作系统还没有文件系统（File System）模块，无法从磁盘读取文件。
*   为了测试进程管理（Fork/Exec）功能，必须用这种“硬编码链接”的方式将用户程序打包进内核，以便内核能直接在内存中找到并运行它们。


---

## 分支任务：gdb 调试页表查询过程


### 1. 调试策略
    1.  **终端 1**：运行 `make debug` 启动 QEMU。
    2.  **终端 2 (QEMU GDB)**：Attach 到 QEMU 进程，设置断点 `break get_physical_address`，用于观察硬件模拟行为。
    3.  **终端 3 (ucore GDB)**：make gdb ,设置断点 `break pmm_init`,finish
### 2. 调试过程追踪分析

本次调试捕获了对虚拟地址 **`0xffffffffc0200100`** 进行物理地址翻译的完整过程。以下是基于 GDB 日志的详细分析：

#### 2.1 环境初始化与模式检查
进入 `get_physical_address` 函数后，QEMU 首先读取 `satp` 寄存器并检查分页模式：

```c
184             base = get_field(env->satp, SATP_PPN) << PGSHIFT; // 获取页表基址
186             vm = get_field(env->satp, SATP_MODE);             // 获取分页模式
187             switch (vm) {
191               levels = 3; ptidxbits = 9; ptesize = 8; break;  // 确认 SV39 模式，3级页表
```
*   **分析**：代码确认当前处于 SV39 模式，将页表层级 `levels` 设为 3。

#### 2.2 页表遍历循环 (The Page Walk)
代码进入核心的页表遍历循环（Line 237），模拟硬件查找 PTE：

```c
237         for (i = 0; i < levels; i++, ptshift -= ptidxbits) {
242             target_ulong pte_addr = base + idx * ptesize;     // 计算 PTE 物理地址
252             target_ulong pte = ldq_phys(cs->as, pte_addr);    // 【关键】读取物理内存中的 PTE
```
*   **分析**：此时 `i=0`，对应第一级页表（Level 2）。`ldq_phys` 函数模拟了硬件向总线发起读请求，获取页表项内容。

#### 2.3 巨型页（Huge Page）的发现
在获取 PTE 后，代码进行了一系列的有效性和权限检查：

```c
256             if (!(pte & PTE_V)) { ... }                       // 检查有效位，跳过（说明有效）
259             } else if (!(pte & (PTE_R | PTE_W | PTE_X))) {    // 检查是否为指向下一级的指针
                    // 如果这一行成立，代码会 continue 继续循环。
                    // 但日志显示并未进入此分支，而是直接跳过了！
262             } else ...
```
*   **关键发现**：在 SV39 标准中，如果 PTE 的 R/W/X 位不全为 0，则该 PTE 为**叶子节点**（Leaf PTE）。
*   **推论**：日志显示循环并没有执行第二次（没有回到 Line 237），而是直接往下执行到了 Line 333。这意味着在 Level 2（顶级页表）就找到了叶子节点。这说明 ucore 使用了 **1GB 的巨型页（Gigabyte Huge Page）** 来映射内核空间。

#### 2.4 物理地址计算
找到叶子节点后，QEMU 计算最终的物理地址：

```c
333                 target_ulong vpn = addr >> PGSHIFT;
334                 *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
349                 return TRANSLATE_SUCCESS;
```
*   **结果**：将 PTE 中的物理页号（PPN）与虚拟地址中的偏移量组合，得到物理地址，翻译成功结束。
![image](https://hackmd.io/_uploads/SJCPp6CMbg.png)。

---

## 分支任务：gdb 调试系统调用以及返回


### 1. 调试系统调用（ecall指令）
![image](https://hackmd.io/_uploads/S1SoLR0zWg.png)

#### 1.1 触发系统调用 (ucore 侧)
在 ucore 的 GDB 中，我们将断点设置在 `user/libs/syscall.c` 的内联汇编处。通过单步指令 (`si`)，我们停在了触发系统调用的关键指令上：

```asm
0x800104 <syscall+44>:       ecall
```
此时，CPU 处于用户态 (U-Mode)，即将请求内核服务（退出进程）。

#### 1.2 捕获异常分发 (QEMU 侧)
当 ucore 执行 `ecall` 时，QEMU 的 TCG 引擎检测到异常指令，暂停了当前的执行流（TranslationBlock），并跳转到异常处理函数。我们在 QEMU GDB 中捕获到了这一刻：

```gdb
Thread 2 "qemu-system-ris" hit Breakpoint 1, riscv_cpu_do_interrupt (cs=0x601006b88650)
    at /opt/riscv/qemu-4.1.1/target/riscv/cpu_helper.c:507
```

#### 1.3 `riscv_cpu_do_interrupt` 源码解析
通过单步调试 (`n`)，我们完整观测了硬件（由软件模拟）是如何处理这次系统调用的：

1.  **识别异常原因**：
    ```c
    514     target_ulong cause = cs->exception_index & RISCV_EXCP_INT_MASK;
    ```
    GDB 显示 `cause` 的值为 **8** (`RISCV_EXCP_U_ECALL`)，明确标识这是来自 User Mode 的系统调用。

2.  **特权级检查与委托**：
    代码检查 `mideleg` 和 `medeleg`，决定该异常是由 M 模式处理还是 S 模式处理。日志显示代码进入了 `if (env->priv <= PRV_S)` 分支，说明将交由 S 模式处理。

3.  **更新 CSR 寄存器 (硬件上下文保存)**：
    这是操作系统能够正确处理中断的基础，QEMU 模拟了以下原子操作：
    *   **`mstatus` 更新** (Lines 556-560)：
        *   保存当前中断使能状态到 `SPIE`。
        *   保存当前特权级（User Mode）到 `SPP`。
        *   关闭中断 (`SIE = 0`)，保证中断处理原子性。
    *   **`scause` 更新** (Line 561)：
        *   写入异常原因（User Ecall）。
    *   **`sepc` 更新** (Line 562)：
        *   `env->sepc = env->pc`。将 `ecall` 指令的地址（或下一条）保存，以便 `sret` 返回。

4.  **控制流跳转 (PC 修改)**：
    ```c
    564     env->pc = (env->stvec >> 2 << 2) + ...
    ```
    QEMU 读取 `stvec` 寄存器（中断向量表基址），计算出内核中断入口地址，并强制修改 PC。当 `riscv_cpu_do_interrupt` 返回后，CPU 下一条取指就会从内核的 `__alltraps` 开始。

5.  **特权级切换**：
    ```c
    566     riscv_cpu_set_mode(env, PRV_S);
    ```
    CPU 正式从用户态切换到内核态。

#### 1.4 异常处理循环 (TCG Loop)
日志的最后展示了 QEMU 的主执行循环 `cpu_exec` -> `tcg_cpu_exec`。这揭示了 QEMU 的运行机制：它不断在一个 `while` 循环中执行翻译好的代码块，直到遇到异常（如 `ecall`）或中断，跳出循环处理事件，然后再回到循环中。
### 2 调试系统调用返回 (`sret` 指令)
在观察完系统调用的进入过程后，我们继续追踪从内核态返回用户态的过程。这对应于汇编指令 `sret` (Supervisor Return)。
![image](https://hackmd.io/_uploads/SycLJ1km-x.png)
**2.1 定位返回指令 (ucore 侧)**


由于直接反汇编虚拟地址出现了大量 `unimp`（GDB 读取虚拟内存失败），我们通过 `break __trapret`,停在 __trapret 后，此时是在恢复寄存器：
```gdb
x /20i 0xffffffffc0200f2e  # (根据物理地址推算的虚拟地址)
...
0xffffffffc0200f40 <__trapret+84>:   ld      sp,16(sp)  # 恢复栈指针
0xffffffffc0200f42 <__trapret+86>:   sret               返回指令
```
我们在 `0xffffffffc0200f42` 处设置断点，并使用 `si` 单步执行，从而触发 QEMU 侧的捕获。

**2.2 捕获指令模拟 (QEMU 侧)**
当 ucore 执行 `sret` 时，QEMU 再次暂停，断点停在 `target/riscv/op_helper.c` 中的 `helper_sret` 函数：
```gdb
Thread 2 "qemu-system-ris" hit Breakpoint 1, helper_sret (env=0x581cb681e060, ...)
    at /opt/riscv/qemu-4.1.1/target/riscv/op_helper.c:76
```

**2.3 `helper_sret` 源码解析**
通过单步调试 (`n`)，我们清晰地观察到了硬件“撤销”中断上下文的过程，这与 `riscv_cpu_do_interrupt` 的逻辑正好相反：

1.  **特权级检查**：
    ```c
    76      if (!(env->priv >= PRV_S)) { ... }
    ```
    QEMU 首先检查当前特权级。只有在 S 模式或 M 模式下才能执行 `sret`，如果在 U 模式执行则会触发非法指令异常。

2.  **恢复程序计数器 (PC)**：
    ```c
    80      target_ulong retpc = env->sepc;
    ```
    从 `sepc` 寄存器中读回之前保存的用户程序断点地址（即 `ecall` 的下一条指令）。

3.  **恢复特权级与中断状态 (mstatus)**：
    这是上下文切换的核心：
    ```c
    91      target_ulong prev_priv = get_field(mstatus, MSTATUS_SPP);
    96      mstatus = set_field(mstatus, MSTATUS_SPIE, 0);
    98      riscv_cpu_set_mode(env, prev_priv);
    ```
    *   **SPP (Supervisor Previous Privilege)**：读取之前保存的特权级（此处为 User Mode）。
    *   **SPIE -> SIE**：虽然日志中未直接显示 SIE 的置位，但硬件逻辑是将 SPIE 的值恢复给 SIE，从而恢复中断使能。
    *   **Mode Switch**：调用 `riscv_cpu_set_mode`，CPU 正式从 S 模式切回 U 模式。

4.  **返回目标地址**：
    函数最终返回 `retpc`。TCG 引擎随后会更新 PC，下一条执行的指令将回到用户程序的地址空间。
### 3. TCG 指令翻译技术与思考
在调试中我注意到，QEMU 并不是像解释器一样逐条解释 RISC-V 指令，而是使用 **TCG (Tiny Code Generator)**。
*   **原理**：QEMU 将 RISC-V 指令（Guest）翻译成中间代码（IR），再编译成宿主机（x86_64）的机器码执行。
*   **`ecall` 的特殊性**：`ecall` 被标记为 "End of Translation Block"（TB 结束）。当 TCG 执行到 `ecall` 时，它不能简单地“翻译”成一条 x86 指令，而是必须退出当前的执行块，调用 C 语言编写的 Helper 函数（即我们调试的 `riscv_cpu_do_interrupt`）来改变 CPU 的全局状态。
*   **关联**：这与之前调试“页表查询”类似。普通访存指令在 TCG 中会被翻译成调用 SoftMMU 的 Helper 函数（如 `ldq_phys`），从而在软件层面模拟硬件的查表行为。

### 4. 实验中的抓马细节与知识点
*   刚开始 `break user/libs/syscall.c` 报错 `No source file`，我以为是编译错了。实际上是因为 ucore 这种将用户程序作为二进制“链接”进内核的非主流方式，导致 GDB 默认没有加载用户态符号。
*   **`ecall` 不是函数调用**：在汇编层面看，`ecall` 没有任何参数，也没有跳转地址。在 QEMU 中看到它实际上是触发了一个 "Exception"，这让我深刻理解了为什么系统调用被称为“陷阱（Trap）”——它是程序主动触发的异常。


---



