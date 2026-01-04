---
title: Lab8 report

---

# Lab8 实验报告
## 练习1 完成读文件操作的实现（需要编码）
>首先了解打开文件的处理流程，然后参考本实验后续的文件读写操作的过程分析，填写在 `kern/fs/sfs/sfs_inode.c`中 的`sfs_io_nolock()`函数，实现读文件中数据的代码。

首先我们需要知道`sfs_io_nolock` 函数的核心逻辑。该函数负责在**内存缓冲区**和**磁盘块**之间传输数据（读或写）。由于文件数据在磁盘上是按**块（Block）存储的（通常为 4KB），而用户的读写请求可以是任意字节（Byte）偏移量和长度，因此必须处理不对齐**的情况。

以下是该设计思路的详细解析和代码的逐步介绍。

### 一、 设计思路 (Design Ideas)

文件读写操作的核心难点在于**逻辑地址与物理块的映射**以及**不对齐边界的处理**。为了高效且正确地处理任意长度的读写，我们将操作分为三个阶段：**Head（头部）、Body（中间主体）、Tail（尾部）**。

#### 1. 核心概念

* **SFS_BLKSIZE**: 文件系统的块大小（通常是 4096 字节）。
* **不对齐 (Unaligned)**: 读写的起始位置不是块的开头，或者结束位置不是块的结尾。
* **逻辑块号 (blkno)**: 文件内部的第几个块（0, 1, 2...）。
* **物理块号 (ino)**: 磁盘上的实际块索引。

#### 2. 三段式处理策略

为了简化逻辑，我们将读写范围 `[offset, endpos)` 拆解为三部分：

1. **Head (处理起始非对齐部分)**:
* 如果 `offset` 不在块的边界上（例如 offset=100），我们需要处理从 100 到该块结束（4096）的数据，或者如果数据很短，直接处理到 `endpos`。
* 这部分需要使用支持页内偏移的操作函数（`sfs_buf_op`）。


2. **Body (处理中间对齐的全块)**:
* 当处理完 Head 后，当前的 `offset` 必然对齐到了下一个块的起始位置。
* 此时，只要剩余数据量大于等于一个完整的块大小，就可以按块进行批量处理。
* 这部分使用块操作函数（`sfs_block_op`），效率较高。


3. **Tail (处理末尾非对齐部分)**:
* 处理完 Body 后，可能还剩下不足一个块的数据。
* 这部分数据从块的起始位置开始，直到 `endpos`。
* 同样使用支持页内偏移的操作函数（`sfs_buf_op`）。


---

### 二、 代码详细介绍

下面是对我们设计的代码片段的逐行解析。

#### 0. 准备工作

```c
// Use uint8_t ptr for arithmetic
uint8_t *data = (uint8_t *)buf; 

```

* **解释**: 将 `void *buf` 转换为 `uint8_t *`。这是因为 `void *` 指针不能直接进行加减运算，而我们需要移动指针来追踪读写进度（每次移动多少字节）。

#### 1. STEP 1: 处理头部 (Handle Head)

这一步处理读写请求中**第一个块**的数据，特别是当起始位置不在块边界时。

```c
    // 计算块内偏移量：当前 offset 在该块内的第几个字节
    blkoff = offset % SFS_BLKSIZE;

    // 如果 blkoff 不为 0，说明起始位置不对齐，需要特殊处理
    if (blkoff != 0) {
        // 计算 Head 部分需要读/写的大小
        // nblks != 0 意味着跨越了多个块：读取当前块剩余的所有字节 (BLKSIZE - blkoff)
        // nblks == 0 意味着读写范围很小，都在同一个块内：只读取 (endpos - offset)
        size = (nblks != 0) ? (SFS_BLKSIZE - blkoff) : (endpos - offset);

        // 获取逻辑块号 blkno 对应的物理磁盘块号 ino
        if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0) {
            goto out;
        }
        
        // 执行读/写操作。sfs_buf_op 会处理块内的偏移 blkoff
        if ((ret = sfs_buf_op(sfs, data, size, ino, blkoff)) != 0) {
            goto out;
        }
        
        // 更新状态：
        alen += size;       // 增加已处理的字节数
        data += size;       // 移动内存缓冲区指针
        offset += size;     // 移动文件偏移量（此时 offset 必定对齐到下一个块的开头）
        blkno++;            // 逻辑块号 +1（进入下一个块）
        nblks--;            // 剩余需要处理的完整块数估算 -1
    }

```

#### 2. STEP 2: 处理中间主体 (Handle Body)

经过 Step 1，`offset` 现在一定是块对齐的（即 `offset % 4096 == 0`）。这一步循环处理所有完整的块。

```c
    // 只要剩余数据量还够一个完整的块，就进入循环
    // offset + SFS_BLKSIZE <= endpos 是判断是否还有一个整块最直观的方法
    while (offset + SFS_BLKSIZE <= endpos) {
        // 获取当前逻辑块对应的物理块号
        if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0) {
            goto out;
        }

        // 使用 sfs_block_op 进行整块操作
        // 注意：这里不需要传入块内偏移，因为默认是从 0 开始，长度为 1 个块
        if ((ret = sfs_block_op(sfs, data, ino, 1)) != 0) {
            goto out;
        }

        // 更新状态：推进一个块的大小
        alen += SFS_BLKSIZE;
        data += SFS_BLKSIZE;
        offset += SFS_BLKSIZE;
        blkno++;
    }

```

#### 3. STEP 3: 处理尾部 (Handle Tail)

处理完所有整块后，可能还剩下一小截数据（不足一个块）。

```c
    // 如果 offset 还没到达 endpos，说明还有尾巴数据没处理
    if (offset < endpos) {
        // 计算剩余大小
        size = endpos - offset;

        // 获取物理块号
        if ((ret = sfs_bmap_load_nolock(sfs, sin, blkno, &ino)) != 0) {
            goto out;
        }

        // 执行读/写操作
        // 注意：因为前面已经对齐了，所以这里的块内偏移量必定是 0
        if ((ret = sfs_buf_op(sfs, data, size, ino, 0)) != 0) {
            goto out;
        }
        
        // 更新已处理长度
        alen += size;
    }

```

### 总结

这段代码非常经典地展示了操作系统中**Block I/O**的处理范式：

1. **对齐处理 (Alignment)**: 通过 Step 1 将不对齐的指针“修正”为对齐。
2. **快速路径 (Fast Path)**: Step 2 利用对齐特性，按块批量传输，提高吞吐量。
3. **收尾处理 (Cleanup)**: Step 3 处理剩余的碎片。

这种设计确保了无论用户传入什么奇怪的 `offset` 和 `length`，文件系统都能正确地将数据映射到磁盘的固定大小块上。

---

## 练习2 完成基于文件系统的执行程序机制的实现（需要编码）
>改写`proc.c`中的`load_icode`函数和其他相关函数，实现基于文件系统的执行程序机制。执行：`make qemu`。如果能看看到sh用户程序的执行界面，则基本成功了。如果在sh用户界面上可以执行`exit, hello`（更多用户程序放在user目录下）等其他放置在sfs文件系统中的其他执行程序，则可以认为本实验基本成功。

### **一、 设计思路 (Design Idea)**

`load_icode` 函数是内核将当前进程的内存空间替换为从文件系统中读取的新可执行程序（ELF 二进制文件）的核心机制。它实际上实现了 `execve` 系统调用的后端逻辑。

整体流程遵循以下关键步骤：

1. **创建新内存空间 (Memory Space Creation)**：
* 由于进程正在切换运行的程序，它需要一个全新的环境。函数创建了一个新的内存管理结构（`mm_struct`）和一个新的页目录表（PDT）。这确保了新程序在一个隔离且干净的虚拟地址空间中运行。


2. **解析 ELF 头 (ELF Header Parsing)**：
* 函数从文件中读取 ELF 头，验证它是否为有效的可执行文件（通过检查 Magic Number）。
* 它获取“程序头（Program Headers）”信息，这些信息描述了如何将文件段加载到内存中。


3. **加载段 (Segment Loading - TEXT/DATA/BSS)**：
* 代码遍历所有程序头。
* **LOAD 段**（代码/数据）：使用 `mm_map` 映射到虚拟地址空间。
* 分配物理页，并将文件的实际内容读取到这些页面中。
* **BSS 处理**：这是关键点。BSS 段包含未初始化的全局变量。ELF 文件为了节省空间，不会在磁盘上存储这些 0，只记录它们的大小。内核必须显式地将 `p_memsz` 大于 `p_filesz` 的内存范围**清零**。


4. **设置用户栈 (User Stack Setup)**：
* 在用户地址空间的顶部（`USTACKTOP`）分配用户栈。
* 将命令行参数（`argc`, `argv`）压入此栈，以便新程序的 `main` 函数可以访问它们。
* *自我修正/细节*：RISC-V 要求栈进行严格的 **16 字节对齐**。代码专门处理了这种对齐，以防止进入用户模式时发生崩溃。


5. **上下文切换 (Context Switching)**：
* 更新进程的内存管理指针（`current->mm`）和硬件页表基址寄存器（CR3/SATP），使其指向新的内存空间。


6. **初始化中断帧 (Trapframe Initialization)**：
* 重置 Trapframe 以确保进程干净地以**用户模式**启动。
* `sp`（栈指针）设置为新的用户栈顶。
* `epc`（异常程序计数器）设置为 ELF 的入口点（`e_entry`）。
* `a0` 和 `a1` 寄存器分别设置为 `argc` 和 `argv`，用于向新程序传递参数。



---

### **二、 代码详细介绍**

#### 代码分模块详细解析
##### 1. 内存空间（mm_struct）初始化
```c
// 1. Create mm
if ((mm = mm_create()) == NULL) {
    return -E_NO_MEM;
}
// 2. Setup pgdir
if (setup_pgdir(mm) != 0) {
    mm_destroy(mm);
    return -E_NO_MEM;
}
```
- **作用**：为新进程创建独立的内存管理结构体 `mm_struct`，并初始化页目录（pgdir）。
  - `mm_create()`：分配并初始化 `mm_struct`（包含页目录指针、内存区域描述等）。
  - `setup_pgdir(mm)`：为该进程创建页目录（页表的根节点），建立地址转换的基础。
- **错误处理**：若创建/初始化失败，释放已分配资源并返回内存不足错误 `-E_NO_MEM`。

##### 2. ELF 文件头部解析与合法性校验
```c
// 3. Read ELF Header
if ((ret = load_icode_read(fd, elf, sizeof(struct elfhdr), 0)) != 0) {
    goto bad_mm;
}
if (elf->e_magic != ELF_MAGIC) {
    ret = -E_INVAL_ELF;
    goto bad_mm;
}
```
- **作用**：读取 ELF 文件头部并验证文件合法性。
  - `load_icode_read(fd, elf, ...)`：从文件描述符 `fd` 的偏移 0 处读取 ELF 头部到 `elf` 结构体。
  - `elf->e_magic != ELF_MAGIC`：校验 ELF 魔数（固定为 `0x7f454c46`），确保是合法的 ELF 可执行文件。
- **错误处理**：读取失败或魔数不匹配时，跳转到 `bad_mm` 标签释放内存并返回错误。

##### 3. ELF 程序段（Program Header）加载（TEXT/DATA/BSS）
这是核心逻辑，遍历 ELF 的程序段，仅处理可加载段（`ELF_PT_LOAD`）：
```c
for (int i = 0; i < elf->e_phnum; i++) {
    // 读取程序段头部
    if ((ret = load_icode_read(fd, ph, sizeof(struct proghdr), elf->e_phoff + i * sizeof(struct proghdr))) != 0) {
        goto bad_mm;
    }
    if (ph->p_type != ELF_PT_LOAD) {
        continue;
    }
    // 校验 filesz <= memsz（文件大小不能超过内存大小）
    if (ph->p_filesz > ph->p_memsz) {
        ret = -E_INVAL_ELF;
        goto bad_mm;
    }
```

###### 3.1 权限与内存映射设置
```c
// 解析 ELF 段权限（读/写/执行），转换为虚拟内存标志（vm_flags）和页表项权限（perm）
uint32_t vm_flags = 0, perm = PTE_U | PTE_V;
if (ph->p_flags & ELF_PF_X) vm_flags |= VM_EXEC;
if (ph->p_flags & ELF_PF_W) vm_flags |= VM_WRITE;
if (ph->p_flags & ELF_PF_R) vm_flags |= VM_READ;
if (vm_flags & VM_READ) perm |= PTE_R;
if (vm_flags & VM_WRITE) perm |= PTE_W;
if (vm_flags & VM_EXEC) perm |= PTE_X;

// 为该段的虚拟地址范围建立内存映射（mm_struct 中记录内存区域）
if ((ret = mm_map(mm, ph->p_va, ph->p_memsz, vm_flags, NULL)) != 0) {
    goto bad_mm;
}
```
- `vm_flags`：标记内存区域的属性（读/写/执行/栈），用于内存管理。
- `perm`：页表项的权限（PTE_U：用户态可访问，PTE_V：有效，PTE_R/W/X：读/写/执行），是硬件页表的权限控制。
- `mm_map()`：在进程的地址空间中，为 `ph->p_va` 开始的 `ph->p_memsz` 大小的虚拟地址范围注册映射关系。

###### 3.2 加载文件内容（TEXT/DATA 段）
```c
uintptr_t start = ph->p_va;
uintptr_t end = start + ph->p_filesz;
uintptr_t la = ROUNDDOWN(start, PGSIZE);

ret = -E_NO_MEM;
while (start < end) {
    // 分配物理页，并映射到虚拟地址 la，设置页表权限 perm
    if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL) {
        goto bad_mm;
    }
    // 计算文件偏移、本次读取的大小、页内偏移
    off_t offset = ph->p_offset + (start - ph->p_va);
    size_t size = end - start;
    size_t page_off = start - la;
    size_t chunk = PGSIZE - page_off;

    if (size > chunk) {
        size = chunk;
    }

    // 从文件读取内容到物理页的对应位置
    if ((ret = load_icode_read(fd, page2kva(page) + page_off, size, offset)) != 0) {
        goto bad_mm;
    }
    start += size;
    if (start < end && start >= la + PGSIZE) {
        la += PGSIZE;
    }
}
```
- **核心逻辑**：按页粒度分配物理内存，将 ELF 文件中的代码/数据段内容读取到对应物理页。
  - `ROUNDDOWN(start, PGSIZE)`：将虚拟地址向下对齐到页大小（如 4KB），确保按页操作。
  - `pgdir_alloc_page()`：分配物理页，建立虚拟地址 `la` 到物理页的映射，并设置页表权限。
  - `page2kva(page)`：将物理页结构体转换为内核虚拟地址（便于内核访问）。
  - 分段读取：若一段内容跨多个页，分多次读取到对应页的对应偏移位置。

###### 3.3 处理 BSS 段（清零未初始化数据）
```c
uintptr_t end_mem = ph->p_va + ph->p_memsz;
if (end < end_mem) {
    // 情况1：当前页剩余部分清零（若数据段未填满当前页）
    size_t page_off = start & (PGSIZE - 1);
    if (page_off != 0) {
        pte_t *pte = get_pte(mm->pgdir, start, 0);
        if (pte && (*pte & PTE_V)) {
            page = pte2page(*pte);
            memset(page2kva(page) + page_off, 0, PGSIZE - page_off);
        }
        start = ROUNDUP(start, PGSIZE);
    }
    
    // 情况2：为剩余 BSS 分配新页并清零
    while (start < end_mem) {
        if ((page = pgdir_alloc_page(mm->pgdir, start, perm)) == NULL) {
            ret = -E_NO_MEM;
            goto bad_mm;
        }
        memset(page2kva(page), 0, PGSIZE);
        start += PGSIZE;
    }
}
```
- **BSS 段特性**：ELF 文件中不存储 BSS 段内容（仅记录大小），需要在内存中清零。
  - 先清零当前页未填充的部分，再为剩余 BSS 分配新页并整体清零，确保 BSS 段全为 0。

##### 4. 用户栈初始化
```c
// 5. Setup User Stack
// 映射栈的虚拟地址范围（USTACKTOP - USTACKSIZE 到 USTACKTOP）
if ((ret = mm_map(mm, USTACKTOP - USTACKSIZE, USTACKSIZE, VM_READ | VM_WRITE | VM_STACK, NULL)) != 0) {
    goto bad_mm;
}
// 预分配栈的前 4 页（避免首次访问栈时缺页异常）
assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-PGSIZE , PTE_USER) != NULL);
assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-2*PGSIZE , PTE_USER) != NULL);
assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-3*PGSIZE , PTE_USER) != NULL);
assert(pgdir_alloc_page(mm->pgdir, USTACKTOP-4*PGSIZE , PTE_USER) != NULL);
```
- **栈地址布局**：RISC-V 中用户栈从 `USTACKTOP`（如 0x7fffffff）向下生长，`USTACKSIZE` 是栈的总大小。
- `PTE_USER`：等价于 `PTE_U | PTE_V | PTE_R | PTE_W`，用户态可读写的页权限。
- 预分配栈页：提前分配栈的前 4 页，避免程序执行时首次访问栈触发缺页异常（简化实现）。

##### 5. 命令行参数入栈（RISC-V 栈对齐要求）
这部分是为用户程序传递 `argc` 和 `argv`，严格遵循 RISC-V 16 字节栈对齐规则：

###### 5.1 推送参数字符串到栈
```c
// 6.1 Push strings
for (int i = 0; i < argc; i++) {
    int len = strnlen(kargv[i], EXEC_MAX_ARG_LEN + 1);
    stacktop -= (len + 1); // 栈向下生长，预留字符串+结束符空间
    
    uintptr_t current_sp = stacktop;
    uintptr_t end_sp = current_sp + len + 1;
    
    while(current_sp < end_sp) {
        pte_t *pte = get_pte(mm->pgdir, current_sp, 0);
        struct Page *p = pte2page(*pte);
        uintptr_t off = current_sp % PGSIZE;
        size_t chunk = PGSIZE - off;
        if (chunk > (end_sp - current_sp)) chunk = end_sp - current_sp;
        // 将内核参数字符串拷贝到用户栈的对应位置
        memcpy((char*)page2kva(p) + off, kargv[i] + (current_sp - stacktop), chunk);
        current_sp += chunk;
    }
    user_vaddr_argv[i] = (char *)stacktop; // 记录每个参数的用户态虚拟地址
}
```
- 栈向下生长：每次为参数字符串预留 `len+1` 字节（+1 是字符串结束符 `\0`）。
- 按页拷贝：若字符串跨页，分多次拷贝到对应物理页的对应偏移。

###### 5.2 栈对齐 + 推送 argv 数组
```c
// 6.2 16 字节对齐栈指针（RISC-V ABI 要求）
stacktop = (stacktop - (argc + 1) * sizeof(uintptr_t)) & ~(0xF);
uargv = (char **)stacktop;

// 6.3 写入 argv 数组（每个元素是参数字符串的地址）
for (int i = 0; i < argc; i++) {
    pte_t *pte = get_pte(mm->pgdir, (uintptr_t)(uargv + i), 0);
    struct Page *p = pte2page(*pte);
    uintptr_t off = (uintptr_t)(uargv + i) % PGSIZE;
    *(uintptr_t *)(page2kva(p) + off) = (uintptr_t)user_vaddr_argv[i];
}

// 6.4 写入 argv 数组的 NULL 终止符
pte_t *pte = get_pte(mm->pgdir, (uintptr_t)(uargv + argc), 0);
struct Page *p = pte2page(*pte);
uintptr_t off = (uintptr_t)(uargv + argc) % PGSIZE;
*(uintptr_t *)(page2kva(p) + off) = 0;
```
- **16 字节对齐**：`& ~(0xF)` 是将栈指针低 4 位清零，满足 RISC-V ABI 对栈的对齐要求。
- `argv` 数组布局：栈中先存储参数字符串，再存储 `argv` 数组（数组元素是字符串的地址），最后以 `NULL` 结尾。

##### 6. 进程上下文与陷阱帧设置
```c
// 7. Context Switch Setup
mm_count_inc(mm);
current->mm = mm;
current->pgdir = PADDR(mm->pgdir);
lsatp(current->pgdir); // 加载页目录到 satp 寄存器，启用地址转换

// 8. Trapframe Setup
struct trapframe *tf = current->tf;
uintptr_t sstatus = tf->status;
memset(tf, 0, sizeof(struct trapframe));

// 设置状态寄存器：用户态、开启中断
tf->status = (sstatus & ~SSTATUS_SPP) | SSTATUS_SPIE;
tf->gpr.sp = stacktop; // 设置用户态栈指针
tf->epc = elf->e_entry; // 设置程序入口地址（ELF 头部的 e_entry）
tf->gpr.a0 = argc;     // a0 寄存器传递 argc
tf->gpr.a1 = (uintptr_t)uargv; // a1 寄存器传递 argv
```
- **地址转换启用**：`lsatp()` 将页目录的物理地址写入 RISC-V 的 `satp` 寄存器，CPU 从此使用该页表进行地址转换。
- **陷阱帧（trapframe）**：保存进程的寄存器状态，是内核态切换到用户态的关键：
  - `SSTATUS_SPP`：清零表示下一条指令在用户态执行。
  - `SSTATUS_SPIE`：开启中断（用户态可响应中断）。
  - `epc`：程序计数器，指向 ELF 入口 `e_entry`，CPU 恢复执行时会跳转到这里。
  - `a0/a1`：RISC-V 中函数调用的前两个参数寄存器，传递 `argc` 和 `argv`。

##### 7. 错误处理与资源释放
```c
bad_mm:
if (ret != 0) {
    if (mm) {
        mm_destroy(mm);
        current->mm = NULL;
    }
}
return ret;
```
- 所有错误都会跳转到 `bad_mm` 标签，释放已分配的 `mm_struct` 和物理内存，避免内存泄漏。

### 三、总结
#### 核心设计思路
1. **内存隔离**：为每个进程创建独立的 `mm_struct` 和页目录，实现地址空间隔离。
2. **ELF 解析**：按 ELF 格式规范解析程序段，区分代码段（TEXT）、数据段（DATA）、未初始化数据段（BSS），分别处理加载和清零逻辑。
3. **栈构建**：严格遵循 RISC-V ABI 要求（16 字节对齐），将命令行参数字符串和 `argv` 数组依次入栈，通过寄存器传递 `argc/argv`。
4. **上下文切换**：设置 `satp` 寄存器启用页表，初始化陷阱帧指定用户态栈指针、程序入口，完成内核态到用户态的切换。

## Challenge1 完成基于“UNIX的PIPE机制”的设计方案
### 1. 概述
#### 1.1 Unix系统中关于管道的处理
在 Linux 和其他类 Unix 操作系统中，Pipe是一种进程间通信机制。它允许将一个命令的输出直接作为另一个命令的输入，通过将多个命令连接在一起，使得数据可以在命令之间流动，从而实现复杂的数据处理任务。
- 表现形式：在 Shell 命令行中，管道使用竖线符号 | 表示。
- 功能定义：它将前一个命令的标准输出（stdout）连接到后一个命令的标准输入（stdin），形成数据流。

#### 1.2 工作原理
管道本质上是内核维护的一个单向数据通道。虽然对用户而言它像是一个文件，但在底层实现中，管道并不对应磁盘上的物理文件，而是通过在内核中创建一个内存缓冲区来实现数据的传递。

其基本工作流程如下：
- 创建管道：当用户在程序中调用 pipe() 系统调用时，内核会分配一个缓冲区。
- 写入数据：生产者进程（或第一个命令）的标准输出通过文件描述符写入到这个内核缓冲区中。
- 读取数据：消费者进程（或第二个命令）的标准输入通过另一个文件描述符从该缓冲区中读取数据。
#### 1.3 ucore 中的设计目标
我们的目标是在 ucore 操作系统中实现这一机制。为了融入 ucore 现有的VFS架构，我们将管道设计为一种基于内存的虚拟设备。
### 2. 核心数据结构设计
管道在Unix系统中的实现方式是一个文件，在ucore中，我们设计一个结构体来管理管道的状态、数据缓冲区和同步互斥机制，定义为`pipe_state`
```C++
struct pipe_state {
    char buffer[PIPE_SIZE];        // 内存缓存区
    off_t head;                    // 写入位置
    off_t tail;                    // 读取位置
    
    // 状态标志
    bool is_closed;                // 管道是否已经被完全关闭
    int readers;                   // 当前持有的读取段fd数量（注：fd是文件描述符）
    int writers;                   // 当前持有的写入段fd数量
    
    // 同步互斥机制
    semaohore_t mutex;             // 互斥锁：用于保护 buffer, head, tail的原子操作
    wait_queue_t wait_reader;      // 读等待队列
    wait_queue_t wait_writer;      // 写等待队列
}
```
在ucore中`struct inode` 使用`union in_info`来存储具体文件系统的信息，当前的`inode`定义如下：
```C++
    struct inode {
    // ... 通用信息略
    union { 
        struct device __device_info;       // 如果是设备，用这个
        struct sfs_inode __sfs_inode_info; // 如果是SFS文件，用这个
    } in_info;
};
```
我们需要扩展这个`union`，加入`struct pipe_state *__pipe_info;`管道这个结构体。这样当创建一个管道时，分配好的`pipe_state`会挂载到`inode->in_info.__pipe_info`上。
### 3. 接口设计
在 ucore 的文件系统架构中，管道被设计为一种特殊的字符设备。为了接入现有的虚拟文件系统，我们利用 VFS 的多态机制，通过定义一组专门针对管道的 inode_ops 操作函数表，将通用的文件读写操作映射为对内核内存缓冲区的操作。

系统流程如下：
- 用户态: 通过标准文件描述符（fd）调用通用文件系统接口，包括`read`,`write`,`close`
- 虚拟文件系统层：根据`fd`找到对应的`struct file`和`struct inode`，调用`inode->in_ops`中定义的特定函数
- 管道实现层：执行具体的内存拷贝、循环缓冲区管理以及进程间的同步与唤醒

#### 3.1 pipe操作接口表 `struct inode_ops`
在我们的定义中由于管道的数据存储在内核内存（struct pipe_state）中，而非磁盘块上，因此不能复用 SFS 文件系统的操作函数。我们需要定义一组专用的操作接口`pipe_node_ops`:
```C++
static const struct inode_ops pipe_node_ops = {
    .vop_magic  = VOP_MAGIC,
    .vop_read   = pipe_read,   // 管道读
    .vop_write  = pipe_write,  // 管道写
    .vop_close  = pipe_close,  // 管道关闭
};
```
当通过 pipe() 系统调用创建管道时，内核会将新生成的 inode 的 in_ops 指针指向此表，从而实现具体行为的动态绑定。
#### 3.2 核心函数
##### 3.2.1 创建管道 `sys_pipe`
该接口用于初始化管道资源并建立文件描述符映射。

- 输入：`int *fd_store` (用于返回两个文件描述符的数组)。
- 执行流程：
    1. 资源分配：在内核堆中申请 `struct pipe_state`，初始化缓冲区 `head=0`, `tail=0`，**初始化互斥锁 `mutex` 及读写等待队列**。设置初始引用计数 `readers=1`, `writers=1`。
    2. Inode 构造：分配新的 `struct inode`，将其 `in_ops` 指向 `pipe_node_ops`，并将 `in_info` 关联到上述 `pipe_state`。
    3. 文件对象创建：分配两个 `struct file` 对象。
        - file[0] (读端)：标记为 `readable=1, writable=0`。
        - file[1] (写端)：标记为 `readable=0, writable=1`。
    4. fd 映射：在当前进程的 `fd_array` 中寻找两个空闲槽位，分别指向这两个 file 对象，并将索引填入用户传入的 `fd_store` 数组。
##### 3.2.2 读管道 `pipe_read`
该函数实现了从内核循环缓冲区读取数据到用户空间的逻辑，核心在于处理“空缓冲区”的阻塞情况。
- 同步互斥逻辑：
    1. 加锁：`down(&state->mutex)` 进入临界区。
    2. 循环检查状态：
        - 若缓冲区非空：执行内存拷贝，将数据从 `buffer[tail]` 复制到用户空间，更新 `tail` 指针。
        - 若缓冲区为空：
            - 检查 `state->writers`。若为 0（写端已全关闭），则视为 EOF，返回 0 结束读取。
            - 若 `writers > 0`，说明数据可能随后到来。调用 `wait_current_set` 将当前进程加入 wait_reader 队列，释放锁 up(&state->mutex) 并调用 schedule() 让出 CPU。被唤醒后，重新获取锁并再次检查缓冲区状态。
    3. 唤醒与返回：
        - 数据读取完成后，缓冲区产生了空闲空间。调用 `wakeup_queue(&state->wait_writer) `唤醒可能因缓冲区满而阻塞的写进程。
        - 释放锁 up(&state->mutex)，返回实际读取字节数。
##### 3.3.3 写管道 `pipe_write`
该函数实现了将用户数据写入内核循环缓冲区的逻辑，核心在于处理“满缓冲区”的阻塞及“读端关闭”的异常。
- 同步互斥逻辑：
    1. 加锁：`down(&state->mutex)`。
    2. 有效性检查：检查 `state->readers`。若为 0,则读端已全关闭，写入操作无效。返回 `-E_PIPE `错误。
    3. 循环写入：计算剩余空间 `space = PIPE_SIZE - (head - tail)`。
        - 若 `space > 0`：将数据写入 `buffer[head]`，更新 head 指针。
        - 若 `space == 0` (缓冲区满)：将当前进程加入 wait_writer 队列，释放锁 并调用 schedule() 阻塞等待。被唤醒后重新获取锁重试。
    4. 唤醒与返回：
        - 数据写入后，缓冲区有了新数据。调用 `wakeup_queue(&state->wait_reader) `唤醒可能因缓冲区空而阻塞的读进程。
        - 释放锁 `up(&state->mutex)`。
##### 3.3.4 关闭管道 `pipe_close`
该函数负责资源的清理及相关进程的通知。
- 执行流程：
    1. 加锁保护状态结构。
    2. 更新计数：根据被关闭的文件描述符属性（只读或只写），递减 `state->readers` 或 `state->writers`。
    3. 状态通知：
        - 若关闭的是写端：必须唤醒 `wait_reader` 中的进程，让它们从阻塞中返回并检测到 EOF。
        - 若关闭的是读端：必须唤醒 `wait_writer` 中的进程，让它们从阻塞中返回并检测到 `-E_PIPE` 错误。
    4. 资源回收：检查 `readers` 和 `writers` 是否均为 0。如果是，说明管道已彻底断开，释放 `pipe_state` 占用的内存缓冲区及结构体。
    5. 释放锁。

## Challenge 2：UNIX 软/硬链接机制设计方案

### 1. 概述
在 Linux 和其他类 Unix 操作系统中，文件链接机制允许同一个文件被多个路径名访问。为了在 ucore 中实现这一功能，我们首先需要理解硬链接（Hard Link）和软链接（Symbolic Link / Soft Link）的核心区别与工作原理。
#### 1.1 硬链接与软链接的特性对比

| 特性 | 硬链接 (Hard Link) | 软链接 (Symbolic Link) |
| --- | --- | --- |
| **Inode 号** | 与原始文件共享相同的 inode 号。实际上是同一个物理文件的不同“别名”。 | 拥有独立的 inode 号。它是一个全新的文件 |
| **数据存储** | 不占用独立的数据块，共享原始文件的数据块 | 占用独立的数据块，数据块的内容是指向目标文件的路径字符串 |
| **文件系统范围** | 只能在同一个文件系统中创建，不能跨分区 | 可以跨越不同的文件系统 |
| **目录支持** | 通常不允许对目录创建硬链接，防止文件系统出现环路 | 允许为目录创建软链接 |
| **生命周期** | 删除原始文件不会导致数据丢失，只有当所有硬链接都被删除时，数据才会被释放。 | 删除原始文件会导致软链接失效，访问时会报错“文件不存在” |
| **透明性** | 对程序完全透明，与原文件在功能上无区别。 | 需要文件系统在解析路径时进行特殊处理，即重定向 |

### 2. 设计目标 
#### 2.1 硬链接机制
* **实现多重文件名映射**：系统应支持多个不同的目录项指向同一个物理索引节点（Inode），从而实现文件数据的共享而无需物理拷贝。
* **基于引用的生命周期管理**：系统需保证文件数据存在的持久性取决于硬链接的数量。必须确保只有在指向该文件的最后一个硬链接被删除，且无进程占用时，物理资源才被回收。
#### 2.2 软链接机制
* **支持路径级间接引用**：系统应引入一种独立的文件类型，其核心功能是存储指向另一个文件或目录的路径，允许跨文件系统的引用。
* **透明的路径解析**：在路径查找过程中，系统应能自动识别软链接并解析其指向的目标路径，使用户能够像访问普通文件一样通过软链接访问目标文件，同时具备防止无限递归死锁的能力。
#### 2.3 接口与同步要求
* **系统调用**：实现 `sys_link`（建立硬链接）、`sys_symlink`（建立软链接）和 `sys_unlink`（解除链接）等接口。
* **并发控制**：在修改目录项和 Inode 引用计数时，必须使用信号量（Semaphore）或锁机制，确保文件系统元数据的一致性，防止多进程并发操作导致的数据损坏或资源泄露。

这是为您重写的“核心数据结构设计”部分，侧重于对比分析和具体的结构定义，更加符合操作系统实验报告的规范。

---

### 3. 核心数据结构设计

#### 3.1 现有结构分析

在 ucore 的 Simple File System (SFS) 中，核心数据结构是 `sfs_disk_inode`，用于描述磁盘上的文件元数据。为了支持 UNIX 的两种链接机制，我们需要对现有的数据结构使用方式进行特定的调整：

**A. 硬链接 (Hard Link) 的修改策略**

* **结构复用**：不需要修改 `sfs_disk_inode` 的内存布局。
* **字段激活**：SFS 中已定义的 `nlinks` 字段（硬链接计数）目前未被充分利用。实现硬链接的核心在于正确维护此字段：
    * 当 `link` 创建新链接时，不分配新 inode，而是让新目录项指向原 inode 编号，并将该 inode 的 `nlinks` 加 1。
    * 当 `unlink` 删除链接时，将 `nlinks` 减 1。只有当 `nlinks` 为 0 时，才执行资源释放。

**B. 软链接 (Symbolic Link) 的修改策略**

* **类型扩展**：需要在 inode 的 `type` 字段中新增一种类型标识，用于告诉 VFS “这是一个软链接，不要直接读取数据，而要读取路径”。
* **数据重定义**：对于软链接 inode，其数据块（`direct` 数组指向的块）不再存储文件内容的二进制数据，而是存储目标文件的**路径字符串**。

根据上面的分析，ucore的硬链接和软链接机制是基于已有的数据结构进行修改的，具体如下：

#### 3.2 扩展 Inode 类型定义

我们在 `kern/fs/sfs/sfs.h` 中扩展文件类型的宏定义，增加软链接类型。同时，为了防止软链接循环引用（如 A->B->A）导致的无限递归，需要定义最大递归深度。

```c
/* kern/fs/sfs/sfs.h */

// 现有的文件类型
#define SFS_TYPE_INVAL  0       // 无效类型
#define SFS_TYPE_FILE   1       // 普通文件
#define SFS_TYPE_DIR    2       // 目录

// [新增] 软链接类型
#define SFS_TYPE_LINK   3       // 符号链接 (Symbolic Link)

// [新增] 软链接查找的最大递归深度（防止死循环）
#define MAX_SYMLINK_DEPTH 5 

```
#### 3.3 磁盘索引节点 (`sfs_disk_inode`) 设计
`sfs_disk_inode` 是描述文件实体的核心结构。虽然不需要增加新的成员变量，但我们需要明确各个字段在链接机制下的新语义。
```c
/* kern/fs/sfs/sfs.h */

struct sfs_disk_inode {
    uint32_t size;              // [软链接]：存储目标路径字符串的长度
    uint16_t type;              // [软链接]：赋值为 SFS_TYPE_LINK
    uint16_t nlinks;            // [硬链接]：核心字段。记录指向该 inode 的目录项数量。
                                //           创建硬链接时++，删除时--。
    uint32_t blocks;            // [软链接]：占用的块数（通常为1，因为路径很短）
    uint32_t direct[SFS_NDIRECT]; // [软链接]：数据块中存储的是目标文件的路径字符串
                                  //           (例如: "../../bin/ls")
    uint32_t indirect;          // [软链接]：通常用不到间接索引，除非路径极长
};

```
### 4 接口语义与操作逻辑

我们需要实现三个核心操作：`link`（创建硬链接）、`symlink`（创建软链接）和 `unlink`（删除链接）。此外，必须修改核心的查找函数 `vfs_lookup`。

#### 4.1 硬链接接口: `sys_link**`
* **语义**：`int link(const char *oldpath, const char *newpath);`
* **实现逻辑**：
    1. 调用 `vfs_lookup(oldpath)` 找到源文件的 inode (`old_inode`)。
    2. 检查 `old_inode` 类型：通常禁止对目录创建硬链接（防止文件系统出现环路）。
    3. 调用 `vfs_lookup_parent(newpath)` 找到目标目录的 inode (`dir_inode`)。
    4. 在 `dir_inode` 下创建一个新目录项（entry），名称为 `newpath` 的文件名部分，inode 编号指向 `old_inode` 的编号。
    5. 将 `old_inode->nlinks` 加 1，并标记 `old_inode` 为 dirty（需要写回磁盘）。
    6. 互斥：操作期间需持有 `old_inode` 和 `dir_inode` 的锁。
#### 4.2 软链接接口: `sys_symlink**`
* **语义**：`int symlink(const char *target, const char *linkpath);`
* **实现逻辑**：
    1. 调用 `vfs_lookup_parent(linkpath)` 找到父目录。
    2. 在父目录下创建一个新文件（inode）。
    3. 设置新 inode 的 `type` 为 `SFS_TYPE_LINK`。
    4. 将 `target` 字符串的内容写入新 inode 的数据块中。
    5. 设置 `nlinks = 1`。
#### 4.3 删除链接接口: `sys_unlink**`
* **语义**：`int unlink(const char *path);`
* **实现逻辑**：
    1. 查找 `path` 对应的目录项及其 inode。
    2. 从父目录中删除该目录项。
    3. 将该 inode 的 `nlinks` 减 1。
    4. 资源回收：如果 `nlinks == 0` 且内存引用 `ref_count == 0`，即没有进程打开该文件，则调用 `sfs_reclaim` 释放 inode 和数据块；否则，仅减少计数，文件数据保留直到最后一个引用消失。

#### 4.4 修改查找逻辑: `vfs_lookup`

这是最复杂的部分。原有的 `vfs_lookup` 只是简单地找名字，现在需要支持“跳转”。

* **修改后的逻辑**：
    1. 找到路径分量对应的 inode。
    2. 检查 `inode->type`。
    3. 如果是 `SFS_TYPE_LINK`：
        * 检查递归深度计数器，以防止死循环。
        * 读取 inode 的数据内容，即目标路径。
        * 如果目标路径以 `/` 开头，从根目录重新开始查找。
        * 如果目标路径是相对路径，从当前目录继续查找。
        * 替换当前正在处理的 inode 为新找到的 inode。
    4. 重复上述过程，直到找到非 LINK 类型的 inode 或到达路径末尾。
### 5 同步互斥问题的处理
在 ucore 中，文件系统的并发访问主要通过信号量来控制。针对我们设计的链接机制，需要特别注意以下几点：
1. **Inode 锁 (`sin->sem`)**：
    * **硬链接**：当修改 `nlinks` 字段时，必须持有该 inode 的锁。
```c
lock_sin(sin);
sin->din->nlinks++;
sin->dirty = 1;
unlock_sin(sin);
```
2. **软链接**：读取软链接内容进行路径解析时，虽然是读操作，但为了防止此时有别的进程正在修改或删除该软链接，最好也持有锁，或者依赖 VFS 层的引用计数保护。
3. **目录锁**：
* 在目录中创建新项（`link`/`symlink`）或删除项（`unlink`）时，必须持有父目录 inode*的锁，防止同一目录下发生并发写入导致目录数据损坏。

4. **死锁预防**：
    * 在 `link(oldpath, newpath)` 中，可能需要同时持有 `old_inode` 和 `new_dir_inode` 的锁。
    * **处理方案**：必须规定加锁顺序（例如按 inode 编号大小顺序加锁，或者先锁目录再锁文件），防止两个进程互相等待。
    * **Unlink 时的竞争**：当一个进程正在 `unlink` 一个文件，而另一个进程正在 `open` 它。依赖 ucore 现有的 `open_count` 和 `nlinks` 双重检查机制：`unlink` 只是减少 `nlinks`，只要 `open_count > 0`，文件在内存中依然有效，只有当两者都为 0 时才物理删除。
5. **VFS 层面的引用计数 (`vop_ref_inc` / `vop_ref_dec`)**：
* 在进行软链接递归查找时，中间经过的 inode 需要正确地增加和减少引用计数，防止在解析过程中 inode 被回收。


