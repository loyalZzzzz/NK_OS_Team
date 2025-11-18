---
title: Lab3

---

# Lab3
## 练习1：完善中断处理 （需要编程）
> 请编程完善trap.c中的中断处理函数trap，在对时钟中断进行处理的部分填写kern/trap/trap.c函数中处理时钟中断的部分，使操作系统每遇到100次时钟中断后，调用print_ticks子程序，向屏幕上打印一行文字”100 ticks”，在打印完10行后调用sbi.h中的shut_down()函数关机。

> 要求完成问题1提出的相关函数实现，提交改进后的源代码包（可以编译执行），并在实验报告中简要说明实现过程和定时器中断中断处理的流程。实现要求的部分代码后，运行整个系统，大约每1秒会输出一次”100 ticks”，输出10行。

### 实现过程
```
case IRQ_S_TIMER:
            // "All bits besides SSIP and USIP in the sip register are
            // read-only." -- privileged spec1.9.1, 4.1.4, p59
            // In fact, Call sbi_set_timer will clear STIP, or you can clear it
            // directly.
            // cprintf("Supervisor timer interrupt\n");
             /* LAB3 EXERCISE1   YOUR CODE :  */
            /*(1)设置下次时钟中断- clock_set_next_event()
             *(2)计数器（ticks）加一
             *(3)当计数器加到100的时候，我们会输出一个`100ticks`表示我们触发了100次时钟中断，同时打印次数（num）加一
            * (4)判断打印次数，当打印次数为10时，调用<sbi.h>中的关机函数关机
            */
            // 设置下次时钟中断
            clock_set_next_event();
            // 计数器（ticks）加一
            ticks++;
            // 静态变量用于记录打印次数
             static int print_count = 0;
            // 当计数器达到100时
             if (ticks % TICK_NUM==0) {
                // 调用print_ticks打印"100 ticks"
                 print_ticks();
                // 打印次数加一
                print_count++;
                // 重置ticks计数器，用于下一次计数
                ticks = 0;
                // 当打印次数达到10时，调用关机函数
                if (print_count >= 10) {
                sbi_shutdown();
                }
            }
            break;
```
在clock.c中clock_init函数的一行代码用来**初始化**第一次时钟中断
`clock_set_next_event();`
出现**时钟中断**后，我们调用了中断/异常的处理程序，判断中断/异常类型为时钟中断，执行处理时钟中断程序。这里，我们需要设置下一次时钟中断的时间`clock_set_next_event();`,时钟中断计数器tick加一，根据实验要求，判断时钟中断计数器的次数是否是100的整数倍，`if (ticks % TICK_NUM==0)`,如果是，调用打印函数，打印次数加一，当打印次数大于等于10时，调用`sbi_shutdown()`函数关机。
### 定时器中断中断处理流程
1. 把不同种类的中断映射到对应的中断处理程序
**中断向量表的作用就是把不同种类的中断映射到对应的中断处理程序**。如果只有一个中断处理程序，那么可以让stvec直接指向那个中断处理程序的地址。
在idt_init中把所有中断都映射到了__alltraps函数：
```
extern void __alltraps(void);
write_csr(stvec, &__alltraps);  // 将__alltraps的地址写入stvec寄存器
```
2. 保存上下文
我们定义一个汇编宏 **SAVE_ALL**, 用来保存所有寄存器到栈顶，这里调用这个宏来保存上下文
```
 .globl __alltraps
    .align(2)
__alltraps:
    SAVE_ALL
```
3. 跳转到中断处理程序
```
 move  a0, sp
    jal trap
    # sp should be the same as before "jal trap"
```
这里a0是trap函数的参数
trap函数首先根据trapframe（a0地址的数据）的scause的数值的正负将控制流分为了中断处理和异常处理程序，这里时钟中断需调用中断处理程序。
```
    if ((intptr_t)tf->cause < 0) {
        // interrupts
        interrupt_handler(tf);
    } else {
        // exceptions
        exception_handler(tf);
    }
```
接着，根据scause的数值调用对应的处理程序，这里调用时钟中断处理程序。
4. 恢复上下文并回到正常执行状态
```
  .globl __trapret
__trapret:
    RESTORE_ALL
    # return from supervisor call
    sret
```
调用RESTORE_ALL宏，恢复所有寄存器和控制状态。执行sret时，处理器会：1）从 sepc 寄存器读取返回地址；2）恢复 sstatus 寄存器的状态；3）跳转到返回地址，继续执行异常发生前的代码。

## 扩展练习 Challenge1：描述与理解中断流程
> 回答：描述ucore中处理中断异常的流程（从异常的产生开始），其中mov a0，sp的目的是什么？SAVE_ALL中寄寄存器保存在栈中的位置是什么确定的？对于任何中断，__alltraps 中都需要保存所有寄存器吗？请说明理由。

### 处理中断异常的流程：
1. 异常触发：当 CPU 执行过程中发生中断（如时钟中断）或异常（如非法指令）时，完成以下操作：
* 根据stvec寄存器（Supervisor Trap Vector Base Address）的值，跳转到中断向量表入口（即__alltraps）。
2. 保存上下文
我们定义一个汇编宏 **SAVE_ALL**, 用来保存所有寄存器到栈顶，这里调用这个宏来保存上下文
```
 .globl __alltraps
    .align(2)
__alltraps:
    SAVE_ALL
```
3. 跳转到中断处理程序
trap函数调用trap_dispatch，根据scause寄存器判断是中断（cause < 0）还是异常（cause >= 0）,调用interrupt_handler（处理中断，如时钟中断）或exception_handler（处理异常，如非法指令）。
4. 恢复上下文并回到正常执行状态
```
  .globl __trapret
__trapret:
    RESTORE_ALL
    # return from supervisor call
    sret
```
调用RESTORE_ALL宏，恢复所有寄存器和控制状态。执行sret时，处理器会：1）从 sepc 寄存器读取返回地址；2）恢复 sstatus 寄存器的状态；3）跳转到返回地址，继续执行异常发生前的代码。
### mov a0, sp的目的
在 RISC-V 架构中，函数调用的第一个参数通过寄存器a0传递。__alltraps中执行mov a0, sp的目的是：将栈指针（sp）的值（即栈中struct trapframe的起始地址）作为参数传递给 C 函数trap，使得trap函数能够通过该指针访问被保存的寄存器状态、epc、cause等信息，从而完成中断 / 异常的具体处理。
### SAVE_ALL中寄存器在栈中的位置的确定
SAVE_ALL中寄存器在栈中的保存顺序由struct trapframe中的struct pushregs结构定义（见lab3/kern/trap/trap.h）。
```
struct pushregs {
    uintptr_t zero;  // Hard-wired zero
    uintptr_t ra;    // Return address
    uintptr_t sp;    // Stack pointer
    uintptr_t gp;    // Global pointer
    uintptr_t tp;    // Thread pointer
    uintptr_t t0;    // Temporary
    uintptr_t t1;    // Temporary
    uintptr_t t2;    // Temporary
    uintptr_t s0;    // Saved register/frame pointer
    uintptr_t s1;    // Saved register
    uintptr_t a0;    // Function argument/return value
    uintptr_t a1;    // Function argument/return value
    uintptr_t a2;    // Function argument
    uintptr_t a3;    // Function argument
    uintptr_t a4;    // Function argument
    uintptr_t a5;    // Function argument
    uintptr_t a6;    // Function argument
    uintptr_t a7;    // Function argument
    uintptr_t s2;    // Saved register
    uintptr_t s3;    // Saved register
    uintptr_t s4;    // Saved register
    uintptr_t s5;    // Saved register
    uintptr_t s6;    // Saved register
    uintptr_t s7;    // Saved register
    uintptr_t s8;    // Saved register
    uintptr_t s9;    // Saved register
    uintptr_t s10;   // Saved register
    uintptr_t s11;   // Saved register
    uintptr_t t3;    // Temporary
    uintptr_t t4;    // Temporary
    uintptr_t t5;    // Temporary
    uintptr_t t6;    // Temporary
};

struct trapframe {
    struct pushregs gpr;
    uintptr_t status;
    uintptr_t epc;
    uintptr_t badvaddr;
    uintptr_t cause;
};
```
### __alltraps中是否需要保存所有寄存器？理由是什么？
**需要保存所有寄存器。**
理由：中断 / 异常可能在程序执行的任意时刻发生，被中断的程序可能正在使用任何通用寄存器（如a0用于传参、s0-s11用于保存局部变量等）。如果__alltraps不保存所有寄存器，中断处理程序可能会修改这些寄存器的值，导致被中断程序恢复执行时因寄存器状态被破坏而出现错误（如数据丢失、跳转地址错误等）。
保存所有寄存器可以确保现场的完整性，使得中断处理完成后，被中断程序能从断点处正确继续执行。
## 扩增练习 Challenge2：理解上下文切换机制
> 回答：在trapentry.S中汇编代码 csrw sscratch, sp；csrrw s0, sscratch, x0实现了什么操作，目的是什么？save all里面保存了stval scause这些csr，而在restore all里面却不还原它们？那这样store的意义何在呢？

**csrw sscratch, sp；csrrw s0, sscratch, x0实现了什么操作，目的是什么？**
* csrw sscratch, sp：将当前栈指针（sp）的值写入 sscratch 寄存器（Supervisor Scratch 寄存器，用于临时存储数据）。
* csrrw s0, sscratch, x0：原子交换 sscratch 和 x0 的值（x0 是 0 寄存器）。执行后，sscratch 被设为 0，而 s0 寄存器得到了之前存储在 sscratch 中的 sp 值。
* 目的：安全保存中断发生前的栈指针（sp），为后续上下文保存做准备。csrrw s0, sscratch, x0 将暂存的 sp 从 sscratch 转移到 s0（s0 是保存寄存器，中断处理中不会被临时使用），同时清空 sscratch 以备后续使用。

**不还原 stval/scause 的原因**：
* **scause**：记录中断 / 异常的类型（如时钟中断、非法指令异常等）。
* **stval**：记录与异常相关的地址（如访问错误的内存地址）。
stval 和 scause 是中断 / 异常发生时的临时信息，不属于被中断程序的执行状态。被中断的程序在正常执行时，不会依赖 stval 或 scause 的值。

**store的意义**
  在 SAVE_ALL 中，这些寄存器被保存到栈上的 struct trapframe 中（见 trap.h 中 trapframe 的 badvaddr（对应 stval）和 cause（对应 scause）字段），目的是让 C 语言中断处理函数（如 trap、interrupt_handler）能够访问这些信息，以判断中断类型并进行针对性处理。
## 扩展练习Challenge3：完善异常中断
> 编程完善在触发一条非法指令异常 mret后，在 kern/trap/trap.c的异常处理函数中捕获，并对其进行处理，简单输出异常类型和异常指令触发地址，即“Illegal instruction caught at 0x(地址)”，“ebreak caught at 0x（地址）”与“Exception type:Illegal instruction"，“Exception type: breakpoint”。

```
        case CAUSE_ILLEGAL_INSTRUCTION:
            cprintf("Exception type:Illegal instruction\n");  // 输出异常类型
            cprintf("Illegal instruction caught at 0x%8x\n", tf->epc);  // 输出异常地址
            tf->epc += 4;  // 跳过当前4字节非法指令，避免重复触发
            break;
        case CAUSE_BREAKPOINT:
            cprintf("Exception type: breakpoint\n");  // 输出异常类型
            cprintf("ebreak caught at 0x%8x\n", tf->epc);  // 输出异常地址
            tf->epc += 2;  // 跳过2字节ebreak指令，避免重复触发
            break;
```
在init.c的while循环前加上
```
    asm("mret");
    asm("ebreak");
```
输出![image](https://hackmd.io/_uploads/S1Km6411-l.png)
异常必须在`idt_init();`调用之后才会正确执行，因为在该函数中设置
stvec的值，在这之前不会跳转到我们定义的异常处理程序。

