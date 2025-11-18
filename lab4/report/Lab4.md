---
title: Lab4

---

# Lab4
## 练习1：分配并初始化一个进程控制块（需要编码）
>alloc_proc函数（位于kern/process/proc.c中）负责分配并返回一个新的struct proc_struct结构，用于存储新建立的内核线程的管理信息。ucore需要对这个结构进行最基本的初始化，你需要完成这个初始化过程。

>请在实验报告中简要说明你的设计实现过程。请回答如下问题：

>* 请说明proc_struct中struct context context和struct trapframe *tf成员变量含义和在本实验中的作用是啥？（提示通过看代码和编程调试可以判断出来）

alloc_proc 函数的初始化过程：
1. 初始化进程状态为 PROC_UNINIT（未初始化状态）。
2. 初始化进程pid为 -1,表示该进程尚未分配。
3. runs（运行次数）初始化为0.
4. kstack（内核栈地址）初始化为0，内核栈需要通过 setup_kstack 函数单独分配（分配连续物理页并映射到内核虚拟地址），此处暂不设置。
5. need_resched（调度标志）初始化为0.
6. parent（父进程指针）初始化为 NULL。
7. mm初始化为 NULL。
8. context（上下文结构）通过 memset 清零。
9. tf（陷阱帧指针）初始化为 NULL。
10. pgdir（页目录物理地址）：初始化为 boot_pgdir_pa（系统启动阶段的页目录物理地址）。内核线程运行在内核态，使用启动页目录可以访问内核地址空间。
11. flags（进程标志）初始化为 0。
12. name（进程名）通过 memset 清零。

```
static struct proc_struct *
alloc_proc(void)
{
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
    if (proc != NULL)
    {
        proc->state = PROC_UNINIT;  
        proc->pid = -1;             
        proc->runs = 0;             
        proc->kstack = 0;           
        proc->need_resched = 0; 
        proc->parent = NULL;        
        proc->mm = NULL;           
        memset(&proc->context, 0, sizeof(struct context)); 
        proc->tf = NULL;            
        proc->pgdir = boot_pgdir_pa;            
        proc->flags = 0;            
        memset(proc->name, 0, PROC_NAME_LEN + 1);  
    }
    return proc;
}
```

### struct context context 成员变量的含义与作用
**含义：**  struct context是用于保存和恢复进程上下文的结构体，包含进程切换时需要保存的关键寄存器（返回地址 ra、栈指针 sp、保存寄存器 s0-s11 ）。这些寄存器是进程执行状态的核心，决定了进程切换后能从断点继续执行。
**作用：** 在本实验中，当通过 switch_to 函数进行进程切换时，当前进程的寄存器状态会被保存到 from->context，而目标进程的寄存器状态会从 to->context 中恢复。对于新创建的内核线程，alloc_proc 会将其 context 初始化为零（通过 memset），后续在 copy_thread 中会进一步设置 context.ra（指向 forkret 函数，作为线程首次执行的入口）和 context.sp（指向内核栈上的陷阱帧地址），确保线程被调度时能正确启动。
### struct trapframe *tf成员变量含义和作用
**含义：** struct trapframe 是一个用于保存陷阱（trap）发生时完整寄存器状态的数据结构，包含以下核心信息：
* 所有通用寄存器（gpr[0..31]）：如 a0（返回值）、sp（栈指针）、ra（返回地址）等。
* sstatus（控制 CPU 特权级、中断使能）、sepc（异常返回地址，即陷阱发生前执行的下一条指令地址）
* scause（陷阱原因）、stval（陷阱相关值）。

**作用：** 
* 保存了进程的中断帧。当进程从用户空间跳进内核空间的时候，进程的执行状态被保存在了中断帧中。系统调用可能会改变用户寄存器的值，我们可以通过调整中断帧来使得系统调用返回特定的值。
* 所有进程的上下文（包括寄存器状态）都通过中断帧来保存。当新进程创建时，我们需要复制当前进程的中断帧，以确保新进程能够继承父进程的状态，保证了每个进程都可以独立运行并且正确地处理中断和上下文切换。

## 练习二
>创建一个内核线程需要分配和设置好很多资源。kernel_thread函数通过调用do_fork函数完成具体内核线程的创建工作。do_kernel函数会调用alloc_proc函数来分配并初始化一个进程控制块，但alloc_proc只是找到了一小块内存用以记录进程的必要信息，并没有实际分配这些资源。ucore一般通过do_fork实际创建新的内核线程。do_fork的作用是，创建当前内核线程的一个副本，它们的执行上下文、代码、数据都一样，但是存储位置不同。因此，我们实际需要"fork"的东西就是stack和trapframe。在这个过程中，需要给新内核线程分配资源，并且复制原进程的状态。你需要完成在kern/process/proc.c中的do_fork函数中的处理过程。它的大致执行步骤包括：
>* 调用alloc_proc，首先获得一块用户信息块。
>* 为进程分配一个内核栈。
>* 复制原进程的内存管理信息到新进程（但内核线程不必做此事）
>* 复制原进程上下文到新进程
>* 将新进程添加到进程列表
>* 唤醒新进程
>* 返回新进程号

>请在实验报告中简要说明你的设计实现过程。请回答如下问题：
>* 请说明ucore是否做到给每个新fork的线程一个唯一的id？请说明你的分析和理由。

do_fork函数实现过程：
* 分配进程控制块（PCB）：调用 alloc_proc 函数分配并初始化 struct proc_struct 结构体
* 分配内核栈：调用 setup_kstack 为新线程分配独立的内核栈
* 调用 copy_mm 根据 clone_flags 处理内存空间 —— 内核线程无需用户态内存，因此 copy_mm 会将新线程的 mm 字段设为 NULL（共享内核地址空间，不复制独立内存）。
* 调用 copy_thread 在新线程内核栈顶部构建陷阱帧（trapframe），复制父线程的寄存器状态，并设置新线程的上下文（context.ra 指向 forkret 作为启动入口，context.sp 指向陷阱帧地址），确保新线程被调度时能正确启动。
* 调用 get_pid 为新线程分配唯一进程 ID（PID），并将新线程的 parent 字段设为当前线程（current），建立父子进程关系。
* 将新线程的 list_link 节点加入全局进程链表（proc_list），便于遍历所有进程；同时调用 hash_proc 将其加入 PID 哈希表（hash_list），便于通过 PID 快速查找。
* 系统进程数（nr_process）加 1， 将新线程状态设为 PROC_RUNNABLE（可运行态），使其能被调度器选中执行。
* 将新线程的 PID 作为返回值，父线程通过该返回值感知子线程的创建结果。
* 若某步骤失败，则通过 goto 语句跳转到对应清理标签，释放已分配的资源（如内核栈、PCB），避免内存泄漏。
```
int do_fork(uint32_t clone_flags, uintptr_t stack, struct trapframe *tf)
{
    int ret = -E_NO_FREE_PROC;
    struct proc_struct *proc;
    if (nr_process >= MAX_PROCESS)
    {
        goto fork_out;
    }
    ret = -E_NO_MEM;
    if ((proc = alloc_proc()) == NULL)
        goto fork_out;
    if (setup_kstack(proc) != 0)
        goto bad_fork_cleanup_proc;
    if (copy_mm(clone_flags, proc) != 0)
        goto bad_fork_cleanup_kstack;
    copy_thread(proc, stack, tf);
    proc->pid = get_pid();
    proc->parent = current; 
    proc->state = PROC_RUNNABLE;
    list_add(&proc_list, &(proc->list_link));
    hash_proc(proc);
    nr_process++; 
    ret = proc->pid;
fork_out:
    return ret;
bad_fork_cleanup_kstack:
    put_kstack(proc);
bad_fork_cleanup_proc:
    kfree(proc);
    goto fork_out;
}
```
### ucore 是否为每个新 fork 线程分配唯一 ID？
ucore 能够做到给每个新 fork 的线程分配唯一的 ID（PID），在 do_fork 中，新线程的 PID 通过 proc->pid = get_pid() 分配，而 get_pid 仅在找到未被占用的 PID 时才返回，确保每个新线程的 PID 在分配时即不与已有进程冲突。

## 练习三
>proc_run用于将指定的进程切换到CPU上运行。它的大致执行步骤包括：
>* 检查要切换的进程是否与当前正在运行的进程相同，如果相同则不需要切换
>* 禁用中断。你可以使用/kern/sync/sync.h中定义好的宏local_intr_save(x)和local_intr_restore(x)来实现关、开中断。
>* 切换当前进程为要运行的进程。
>* 切换页表，以便使用新进程的地址空间。/libs/riscv.h中提供了lsatp(unsigned int pgdir)函数，可实现修改SATP寄存器值的功能。
>* 实现上下文切换。/kern/process中已经预先编写好了switch.S，其中定义了switch_to()函数。可实现两个进程的context切换。
>* 允许中断。

>请回答如下问题：
>* 在本实验的执行过程中，创建且运行了几个内核线程？

>完成代码编写后，编译并运行代码：make qemu

```
void proc_run(struct proc_struct *proc)
{
    if (proc != current)
    {
        struct proc_struct *prev = current; 
        current = proc;                     
        bool intr_flag;
        local_intr_save(intr_flag);
        lsatp(proc->pgdir);
        flush_tlb()
        switch_to(&(prev->context), &(proc->context));
        local_intr_restore(intr_flag);
    }
}
```

### 在本实验的执行过程中，创建且运行了几个内核线程
在本实验的执行过程中，共创建并运行了 2 个核心内核线程，分别是 idleproc（空闲线程）和 initproc（初始化线程）。

1. idleproc是系统启动后第一个被创建的内核线程,始终处于可运行态（PROC_RUNNABLE），是调度器的 “兜底线程”—— 当系统中无其他可运行线程时，调度器会选择 idleproc 运行。
2. initproc（PID=1，初始化线程）在 proc_init 函数中，由 idleproc 通过 kernel_thread(init_main, NULL, 0) 调用 do_fork 创建

schedule() 的执行逻辑可以概括为以下几步：
1. 将当前内核线程 current->need_resched 置为 0。
2. 在 proc_list 链表中查找下一个处于 PROC_RUNNABLE 状态的线程或进程 next。
3. 找到合适的进程后，调用 proc_run() 函数，保存当前进程current的执行现场（进程上下文），恢复新进程的执行现场，完成进程切换。

其中，在 proc_list 中查找下一个就绪进程时，会有三种情况：

1. 当前进程不是 idleproc：从当前进程的下一个位置开始查找，实现 Round-Robin 轮转调度。
2. 当前进程是 idleproc：从链表头开始查找，给所有进程平等机会。
3. 找不到就绪进程：遍历整个链表都没找到，则最后使用 idleproc 保底。

### make qemu结果
![image](https://hackmd.io/_uploads/Hkvqy3beWe.png)

## 扩展练习 Challenge：
### 1. 说明语句local_intr_save(intr_flag);....local_intr_restore(intr_flag);是如何实现开关中断的？

`local_intr_save(intr_flag);`记录当前中断是否处于 “使能状态”，并将结果存入intr_flag。
`local_intr_restore(intr_flag);`根据 local_intr_save 保存的 intr_flag，恢复 CPU 的中断状态。
### 2.深入理解不同分页模式的工作原理（思考题）
>get_pte()函数（位于kern/mm/pmm.c）用于在页表中查找或创建页表项，从而实现对指定线性地址对应的物理页的访问和映射操作。这在操作系统中的分页机制下，是实现虚拟内存与物理内存之间映射关系非常重要的内容。
>* get_pte()函数中有两段形式类似的代码， 结合sv32，sv39，sv48的异同，解释这两段代码为什么如此相像。
>* 目前get_pte()函数将页表项的查找和页表项的分配合并在一个函数里，你认为这种写法好吗？有没有必要把两个功能拆开？

#### get_pte()函数中有两段形式类似的代码， 结合sv32，sv39，sv48的异同，解释这两段代码为什么如此相像。

get_pte的核心目标是 “从虚拟地址出发，找到最终的 PTE（页表项）；若中间某级页表未分配，则创建该级页表”。由于 Sv32/Sv39/Sv48 均采用 “多级索引 + 逐级查找” 的架构，只是级数不同，因此代码会呈现 “多段形式相像的逻辑”,具体如下：
1. 从虚拟地址中提取当前级的索引；
2. 通过索引定位当前级页表中的页表项（PTE）
3. 判断该 PTE 是否有效（是否已分配下级页表）
 * 若有效：直接通过 PTE 找到下级页表的基址，进入下一级查找；
 * 若无效：调用内存分配函数（如alloc_page）创建一页物理内存作为下级页表，将该页表的基址写入当前 PTE（设置有效位），再进入下一级查找；
4.重复上述步骤，直到遍历完所有级数，最终返回最末级的 PTE（即对应虚拟地址的页表项）。

#### 目前get_pte()函数将页表项的查找和页表项的分配合并在一个函数里，你认为这种写法好吗？有没有必要把两个功能拆开？
这种写法不好，有必要将两个功能拆开。
理由：
1. 当两个 CPU 核同时调用 get_pte(pgdir, la, true)：如果页表项还没创建，两个核都可能分配新页表页，然后互相覆盖，导致内存泄漏。
2. 当只想读取页表项时，查询虚拟地址对应的页表项是否存在，可能会创建一个新页表项
3. 一旦分配失败（alloc_page() 返回 NULL），你必须在同一个函数里判断：
是否要回滚前面分配的页；是否要释放部分成功分配的中间页表；是否要返回错误码或 NULL。调用方错误处理变得模糊。





















