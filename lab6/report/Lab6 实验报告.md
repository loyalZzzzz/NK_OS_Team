---
title: Lab6 实验报告

---

# Lab6 实验报告

## 练习1：理解调度器框架的实现（不需要编码）

> 请仔细阅读和分析调度器框架的相关代码，特别是以下两个关键部分的实现：
> 1. 调度类结构体 `sched_class` 的分析。
> 2. 运行队列结构体 `run_queue` 的分析。
> 3. 调度器框架函数分析。
> 
> 对于调度器框架的使用流程，请在实验报告中完成以下分析：
> 1. 调度类的初始化流程。
> 2. 进程调度流程。
> 3. 调度算法的切换机制。

### 1. 调度类结构体 `sched_class` 分析

`sched_class` 结构体定义在 `kern/schedule/sched.h` 中，它通过定义一组标准的函数指针接口，可以调用具体的调度策略（如 Round Robin 或 Stride）。

`sched_class` 包含以下关键函数指针：

*   **`init`**:
    *   **作用**: 初始化运行队列（run queue）结构体。
    *   **调用时机**: 在内核启动时的 `sched_init` 函数中调用，确立具体的调度算法环境。
*   **`enqueue`**:
    *   **作用**: 将一个处于 `PROC_RUNNABLE` 状态的进程加入到运行队列中。
    *   **调用时机**: 当进程被创建（`do_fork`）、被唤醒（`wakeup_proc`）或从运行状态被抢占放回队列时调用。
*   **`dequeue`**:
    *   **作用**: 将一个进程从运行队列中移除。
    *   **调用时机**: 当进程的时间片耗尽、被选中运行、或者进程状态变为非 `PROC_RUNNABLE`（如睡眠、退出）时调用。
*   **`pick_next`**:
    *   **作用**: 根据特定的调度策略，从运行队列中选择下一个最应该获得 CPU 的进程。
    *   **调用时机**: 在核心调度函数 `schedule` 中调用，用于确定下一个运行的进程。
*   **`proc_tick`**:
    *   **作用**: 响应时钟中断，更新当前进程的时间片计数或其他统计信息。
    *   **调用时机**: 每次时钟中断发生时，在 `interrupt_handler` 中被调用。

**为什么使用函数指针？**
这是一种在 C 语言中模拟**面向对象接口**的常用技术。通过让 `sched_class` 指向不同的实现实例（如 `default_sched_class` 或 `stride_sched_class`），内核可以在不修改上层代码的情况下，灵活地替换底层的调度算法，甚至支持在运行时动态切换。

### 2. 运行队列结构体 `run_queue` 分析

**Lab5 与 Lab6 的差异**:
*   **Lab 5**: 并没有显式的复杂 `run_queue` 结构，进程管理较为简单，可能仅通过全局链表 `proc_list` 进行管理。
*   **Lab 6**: 引入了结构化的 `run_queue`，以支持更复杂的调度需求：
    ```c
    struct run_queue {
        list_entry_t run_list;
        unsigned int proc_num;
        int max_time_slice;
        // For LAB6 ONLY
        skew_heap_entry_t *lab6_run_pool;
    };
    ```

**为什么需要两种数据结构（链表和斜堆）？**
这是为了同时支持两种不同的调度算法：
*   **链表 (`run_list`)**: 用于实现 **Round Robin (RR)** 调度算法。RR 只需要简单的 FIFO 操作（队尾入队，队头出队），链表操作复杂度为 $O(1)$，非常高效。
*   **斜堆 (`lab6_run_pool`)**: 用于实现 **Stride Scheduling**。Stride 算法需要频繁查找步长（stride）最小的进程。使用优先级队列（这里实现为斜堆 Skew Heap）可以将插入、删除和查找最小值的操作复杂度控制在 $O(\log N)$，相比于链表的线性查找 $O(N)$ 有极大的性能优势。

### 3. 调度器框架函数分析

*   **`sched_init()`**:
    *   **实现变化**: Lab6 中，此函数不仅初始化 Timer 列表，还负责设置全局变量 `sched_class`（决定使用哪个调度器），并调用该调度器的 `init` 函数初始化 `run_queue`。
*   **`wakeup_proc()`**:
    *   **实现变化**: 不再硬编码入队逻辑，而是调用 `sched_class_enqueue(proc)`。这实际上是一个封装宏或内联函数，最终调用 `sched_class->enqueue(rq, proc)`，将入队细节交给具体算法处理。
*   **`schedule()`**:
    *   **实现变化**: 核心逻辑变为“标准化流程”：
        1.  如果当前进程还处于 `RUNNABLE`，调用 `sched_class_enqueue` 放回队列。
        2.  调用 `sched_class_pick_next` 选择新进程。
        3.  调用 `sched_class_dequeue` 将新进程移出队列。
        4.  调用 `proc_run` 切换上下文。
    *   这种设计完全屏蔽了具体算法的差异。

### 4. 调度器框架使用流程分析

#### (1) 调度类的初始化流程
1.  **内核启动**: `kern_init` 开始执行。
2.  **调用**: `kern_init` 调用 `sched_init`。
3.  **绑定算法**: 在 `sched_init` 中，将全局指针 `sched_class` 指向具体的实现结构体。
    *   默认情况：`sched_class = &default_sched_class;` (RR)
    *   Stride 实验：`sched_class = &stride_sched_class;`
4.  **初始化队列**: 调用 `sched_class->init(rq)`，根据算法需求初始化链表或斜堆。

#### (2) 进程调度流程图
1.  **时钟中断**: 硬件触发 Timer Interrupt -> `trap()` -> `trap_dispatch()` -> `interrupt_handler()`。
2.  **Tick 处理**: `interrupt_handler` 调用 `sched_class_proc_tick(current)`。
    *   具体算法（如 RR）递减 `current->time_slice`。
    *   如果 `time_slice` 减为 0，设置 `current->need_resched = 1`。
3.  **调度触发**:
    *   中断处理结束，准备返回前，检查 `need_resched` 标志。
    *   如果为 1，调用 `schedule()`。
4.  **调度执行 (`schedule`)**:
    *   `sched_class->enqueue(current)`: 把当前进程放回就绪队列。
    *   `sched_class->pick_next(rq)`: 挑选下一个最该运行的进程 `next`。
    *   `sched_class->dequeue(next)`: 把 `next` 从队列拿出来。
    *   `proc_run(next)`: 切换上下文，CPU 开始执行 `next`。

**need_resched 标志位的作用**:
它实现了**被动/延迟抢占**。中断处理程序（ISR）运行在内核态，通常不建议直接在 ISR 中进行耗时的上下文切换，或者此时并不在合适的安全点。通过设置标志位，告诉内核：“当前进程时间片已用完，请在最近的一个调度点（如中断返回或系统调用返回前）主动让出 CPU”。

#### (3) 调度算法的切换机制
如果要添加一个新的调度算法（如 Stride），只需：
1.  **实现接口**: 定义一个新的 `struct sched_class` 实例（如 `stride_sched_class`），并实现其中的函数指针。
2.  **修改初始化**: 在 `kern/schedule/sched.c` 的 `sched_init` 函数中，修改一行代码：
    ```c
    // sched_class = &default_sched_class;
    sched_class = &stride_sched_class;
    ```
**为什么容易？** 因为调度框架只依赖于 `sched_class` 定义的抽象接口，而不依赖具体实现。这种**面向接口编程**的设计模式使得替换算法就像更换插件一样简单。

---

## 练习2：实现 Round Robin 调度算法（需要编码）

> 比较 Lab5 和 Lab6 实现不同的函数，分析原因。
> 描述实现每个函数的具体思路和方法。
> 展示 make grade 输出和 QEMU 现象。
> 分析 RR 算法优缺点及时间片影响。

### 1. Lab5 和 Lab6 函数差异分析

以 `schedule` 函数为例：
*   **Lab 5**: 调度算法为FIFO。
*   **Lab 6**: 
    ```c
    if ((next = sched_class_pick_next()) != NULL) {
        sched_class_dequeue(next);
    }
    ```
**改动原因**: 将**调度策略**（Policy，谁该运行）从**调度机制**（Mechanism，如何切换）中分离出来。如果不改动，每次更换算法都要重写 `schedule` 函数，代码耦合度太高，难以维护和扩展。Lab 6 的设计使得 `schedule` 成为一个通用的框架函数。

### 2. 代码实现思路 (`kern/schedule/default_sched.c`)

*   **`RR_init`**:
    *   使用 `list_init(&(rq->run_list))` 初始化运行队列链表。
    *   将进程计数 `rq->proc_num` 置为 0。
*   **`RR_enqueue`**:
    *   **思路**: RR 是先来先服务，新进程应加到队尾。
    *   **实现**: 使用 `list_add_before(&(rq->run_list), &(proc->run_link))`。`run_list` 是头节点，在头节点之前插入即是在循环链表的尾部插入。
    *   **边界处理**: 检查 `proc->time_slice`，如果为 0 或超限，重置为 `rq->max_time_slice`。
*   **`RR_dequeue`**:
    *   **思路**: 从队列中移除指定进程。
    *   **实现**: 使用 `list_del_init(&(proc->run_link))`，并减少 `proc_num`。
*   **`RR_pick_next`**:
    *   **思路**: RR 总是选择队头的进程。
    *   **实现**: 使用 `list_next(&(rq->run_list))` 获取第一个节点。
    *   **边界处理**: 必须检查链表是否为空（即 `list_next` 是否指向头节点本身）。如果是空返回 `NULL`。
*   **`RR_proc_tick`**:
    *   **思路**: 每次时钟中断减少时间片。
    *   **实现**: `proc->time_slice--`。
    *   **调度触发**: 当 `time_slice <= 0` 时，设置 `proc->need_resched = 1`，请求调度器介入。

### 3. Make Grade 与 QEMU 现象

**QEMU 现象**:
在运行 QEMU 时，我们可以看到多个进程交替输出信息。在 `priority` 测试中，虽然设置了不同优先级，但所有子进程的输出频率和运行时间基本一致，这正是 Round Robin 公平调度的体现。

**Make Grade 输出**:
![image](https://hackmd.io/_uploads/BkqG7SSEWg.png)


### 4. RR 算法分析

*   **优点**:
    *   **公平性**: 每个进程都有平等的机会获得 CPU，防止饥饿。
    *   **响应性**: 对于分时系统，能够保证每个用户/进程在一定时间内都能得到响应。
*   **缺点**:
    *   **平均周转时间较长**: 如果所有进程长度相同，RR 的平均周转时间是最差的。
    *   **性能波动**: 性能高度依赖时间片的大小。
*   **时间片调整**:
    *   **过小**: 上下文切换过于频繁，CPU 浪费在保存/恢复寄存器和刷新 Cache 上，系统吞吐量下降。
    *   **过大**: 退化为 FCFS (先来先服务) 算法，短任务的响应时间变长，用户体验变差。
*   **need_resched 的必要性**: 
    在 `proc_tick` 中我们处于中断上下文，此时进行上下文切换是不安全的（或者逻辑非常复杂）。通过设置标志位，我们将实际的切换动作推迟到中断返回前的安全点执行，既保证了逻辑正确性，又实现了抢占。

### 5. 拓展思考

*   **优先级 RR**: 可以维护一个数组 `list_entry_t run_lists[MAX_PRIO]`。`pick_next` 时从高优先级的链表开始查找，如果非空则取出一个运行；如果空则查下一级。
*   **多核调度**:
    *   当前的 `run_queue` 是全局共享的，如果直接用于多核，需要加一把大锁（Global Lock），这会成为性能瓶颈。
    *   **改进**: 每个 CPU 核心（Hart）应当维护自己独立的 `run_queue` (Per-CPU Runqueue)。调度时优先在本地队列查找。如果本地空闲，则需要实现 **Work Stealing (任务窃取)** 机制，从其他忙碌核心的队列中“偷”进程过来运行，以实现负载均衡。

---

## 扩展练习 Challenge 1: 实现 Stride Scheduling 调度算法

### 1. 设计概要

Stride Scheduling 是一种确定性的**比例份额（Proportional Share）**调度算法，旨在让进程获得的 CPU 时间与其优先级成正比。

*   **核心概念**:
    *   **Pass (当前步长/行程)**: 进程已经执行的“虚拟时间”，用 `lab6_stride` 表示。
    *   **Stride (步进)**: 进程每运行一个时间片，Pass 增加的值。计算公式：$Stride = \frac{\text{BigConstant}}{\text{Priority}}$。优先级越高，Stride 越小。
*   **调度逻辑**:
    1.  每次调度器选择 Pass 值**最小**的进程运行。
    2.  该进程运行一个时间片。
    3.  更新该进程的 Pass 值：$Pass = Pass + Stride$。
    4.  将进程重新放回就绪队列。
*   **数据结构**: 为了高效地查找最小值，使用**斜堆 (Skew Heap)** 替代链表作为运行队列。斜堆是一种自调整的二叉堆，支持 $O(\log N)$ 的插入、删除和合并。

### 2. 证明：时间片分配与优先级成正比

假设有两个进程 $P_A$ 和 $P_B$，优先级分别为 $Pri_A$ 和 $Pri_B$。
常数 $K = \text{BigConstant}$。
步进分别为 $S_A = K / Pri_A$ 和 $S_B = K / Pri_B$。

在一段较长的时间 $T$ 内，假设 $P_A$ 被调度了 $N_A$ 次，$P_B$ 被调度了 $N_B$ 次。
由于调度算法总是维持所有进程的 Pass 值大致相等（因为总是挑最小的追赶），我们可以得出：
$$ N_A \times S_A \approx N_B \times S_B $$

代入 $S$ 的定义：
$$ N_A \times \frac{K}{Pri_A} \approx N_B \times \frac{K}{Pri_B} $$

消去 $K$ 并移项：
$$ \frac{N_A}{N_B} \approx \frac{Pri_A}{Pri_B} $$

**结论**: 进程获得的调度次数（即时间片数量）与其优先级成正比。

### 3. 实现过程说明

实现主要集中在 `kern/schedule/default_sched_stride.c` 文件中。

1.  **定义常量**: 
    ```c
    #define BIG_STRIDE 0x7FFFFFFF /* 2^31 - 1 */
    ```
    选择最大正整数是为了让 Stride 计算有足够的精度，同时尽量延后溢出。

2.  **比较函数 `proc_stride_comp_f`**:
    这是斜堆排序的依据。比较两个进程的 `lab6_stride` 值。
    ```c
    // 如果 p->lab6_stride < q->lab6_stride，返回 -1 (p 优先级高/Pass 小)
    int32_t c = p->lab6_stride - q->lab6_stride;
    ```

3.  **`stride_init`**: 
    初始化斜堆根节点为空：`rq->lab6_run_pool = NULL`。

4.  **`stride_enqueue`**:
    *   调用 `skew_heap_insert` 将进程插入斜堆。这是 ucore 提供的库函数，它会根据比较函数自动调整堆结构。
    *   初始化时间片 `proc->time_slice`。
    *   更新进程总数。

5.  **`stride_pick_next` (核心逻辑)**:
    *   **查找**: 如果 `rq->lab6_run_pool` 不为空，直接取堆顶（根节点），它一定是 Pass 最小的进程。
    *   **更新 Pass**: 选中进程后，立即更新其 stride：
        ```c
        uint32_t priority = p->lab6_priority;
        if (priority == 0) priority = 1; // 防止除零
        p->lab6_stride += BIG_STRIDE / priority;
        ```
    *   **注意**: 这里的更新是在 `pick_next` 中进行的，这意味着进程一旦被选中，其虚拟时间就增加了。这保证了下次调度时它不再是最小的（除非它是唯一的）。

6.  **`stride_dequeue`**:
    调用 `skew_heap_remove` 从斜堆中移除指定进程。

### 4. 实验结果验证

在 `make qemu` 运行 `priority` 测试程序时，我们观察到了如下输出：

![image](https://hackmd.io/_uploads/HJFwQBBEZg.png)


**分析**:
*   `pid 7` (Priority 5) 的运行计数 `acc` (1328000) 明显高于 `pid 3` (Priority 1) 的计数 (448000)。
*   这验证了高优先级的进程确实获得了更多的 CPU 时间，Stride 调度算法实现正确。

---

## 扩展练习 Challenge 2：调度算法的对比分析

### 1. 实验目标
设计测试用例，定量分析 FIFO、RR（时间片轮转）和 Stride（步长调度）三种算法在**周转时间**、**响应时间**及**公平性**上的差异，从而得出不同算法的适用范围。

### 2. FIFO 调度算法的实现
FIFO (First-In First-Out) 是一种非抢占式的调度算法。实现的核心逻辑在于：
1.  **入队 (`enqueue`)**：新进程直接加入运行队列的尾部。
2.  **出队 (`dequeue`)**：移除指定的进程。
3.  **选择 (`pick_next`)**：总是选择运行队列头部的进程。
4.  **时钟中断 (`proc_tick`)**：**关键点**。在 FIFO 算法中，时钟中断函数体为空。这意味着即使时间片耗尽，也不会设置 `need_resched` 标志，进程不会被强制剥夺 CPU，直到其主动放弃（如等待 I/O 或退出）。

### 3. 测试用例设计
为了验证调度器的行为，设计了 `user/schedtest.c` 测试程序（RR 和 Stride 使用此测试），以及利用原有的 `user/priority.c`（FIFO 使用此测试）。

*   **`schedtest.c` 负载特征**：
    *   创建 5 个子进程。
    *   前 2 个（Pid 3, 4）为**长作业**（CPU 密集型，模拟繁重计算）。
    *   后 3 个（Pid 5, 6, 7）为**短作业**（模拟 IO 密集型或交互任务）。
*   **`priority.c` 负载特征**：
    *   创建 5 个子进程，每个进程都在死循环中从系统获取时间并累加计数，用于测量各自获得的 CPU 时间片总和。

### 4. 实验结果与定量分析

#### (1) Round Robin (RR) 调度算法
**测试日志分析 (`schedtest`)**：
```text
sched class: RR_scheduler
...
Process 3 (CPU-bound) started.  <-- 长作业开始
Process 4 (CPU-bound) started.
Process 5 (CPU-bound) started.  <-- 短作业开始
...
Process 5 (CPU-bound) finished. <-- 短作业先结束
Process 6 (CPU-bound) finished.
Process 7 (CPU-bound) finished.
Process 3 (CPU-bound) finished. <-- 长作业后结束
Process 4 (CPU-bound) finished.
```
*   **现象**：所有进程几乎同时“started”（响应快）。虽然 Pid 3 和 4 先被创建，但 Pid 5, 6, 7 这些短作业却先完成了。
*   **分析**：RR 算法通过时间片轮转强制抢占，防止了长作业独占 CPU。长作业被切碎成小的时间片执行，中间穿插了短作业的执行。
*   **结论**：RR 极大地优化了**响应时间**，避免了短作业被长作业阻塞（护航效应），适合分时交互系统。

#### (2) Stride 调度算法
**测试日志分析 (`schedtest`)**：
```text
sched class: stride_scheduler
Process 7 (CPU-bound) started.
Process 7 (CPU-bound) finished.
Process 6 (CPU-bound) started.
Process 6 (CPU-bound) finished.
Process 5 (CPU-bound) started.
Process 5 (CPU-bound) finished.
Process 4 (CPU-bound) started.
Process 3 (CPU-bound) started.
Process 3 (CPU-bound) finished.
Process 4 (CPU-bound) finished.
```
*   **现象**：在默认优先级相同的情况下，Stride 算法也表现出了让短作业（Pid 5, 6, 7）先于长作业（Pid 3, 4）结束的特性。
*   **分析**：Stride 算法本质上是一种比例份额调度。在同等优先级下，它能保证各进程进度的相对公平。测试中短作业迅速完成，说明它们在获得相应的份额后很快就退出了，没有被长作业长时间阻塞。

#### (3) FIFO 调度算法
**测试日志分析 (`priority`)**：
为了更直观地展示 FIFO 的非抢占特性，使用了 `priority` 程序进行压力测试。
```text
sched class: FIFO_scheduler
...
main: fork ok,now need to wait pids.
set priority to 1
child pid 3, acc 4292000, time 2010  <-- 获得巨大的 CPU 时间
set priority to 2
child pid 4, acc 4000, time 2010     <-- 几乎饿死
child pid 5, acc 4000, time 2010
...
sched result: 1 0 0 0 0
```
*   **现象**：第一个运行的子进程（Pid 3）获得了 `4292000` 的累积计数，而后续的 Pid 4, 5, 6, 7 仅有 `4000`（这通常是进程创建/销毁时的微小开销）。
*   **分析**：这是典型的**饥饿现象**。Pid 3 一旦获得 CPU，由于 FIFO 不会在时钟中断时抢占，它一直运行直到测试程序设定的时间结束（或者在真实场景中直到死循环结束）。其他进程只能一直等待。
*   **结论**：FIFO 算法在存在长作业时，会导致**响应时间极差**和严重的**护航效应**。

### 5. 综合对比与适用范围

根据实验数据，三种算法的对比如下表：

| 指标 | FIFO (先来先服务) | RR (时间片轮转) | Stride (步长调度) |
| :--- | :--- | :--- | :--- |
| **平均周转时间** | **最差**（若长作业在先）<br>短作业需等待长作业完全结束。 | **中等**<br>所有作业并发推进，长作业结束时间比 FIFO 晚。 | **可控**<br>取决于优先级设置。 |
| **平均响应时间** | **极差**<br>后来的进程必须等待前面的全部执行完。 | **优**<br>所有进程在极短时间内都能获得时间片。 | **优**<br>高优先级进程响应更快。 |
| **公平性** | **差**<br>CPU 时间完全取决于进入队列的顺序和任务长度。 | **好**<br>强制均分 CPU 时间。 | **可控**<br>严格按照设定权重的比例分配。 |
| **适用场景** | 批处理系统（后台计算，无交互需求）。 | 分时操作系统（桌面/服务器，需兼顾交互）。 | 多媒体/实时系统（需保证关键任务资源份额）。 |

### 6. 实验结论
通过本次 Challenge，我们验证了：
1.  **抢占机制的重要性**：RR 和 Stride 通过时钟中断强制切换，保证了系统的响应性，这是现代操作系统的基石。
2.  **FIFO 的局限性**：FIFO 实现最简单，但极易导致短作业被长作业阻塞（护航效应），在多任务环境中不可行。
3.  **调度策略的影响**：不同的调度算法对系统吞吐量和用户体验（响应时间）有决定性的影响。RR 牺牲了一定的上下文切换开销，换取了公平性和响应速度；Stride 则在公平性的基础上提供了更精细的控制能力。 

