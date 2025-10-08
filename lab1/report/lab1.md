---
title: lab1

---

# lab1
## 练习1：理解内核启动中的程序入口操作
**实验内容**
阅读 kern/init/entry.S内容代码，结合操作系统内核启动流程，说明指令 la sp, bootstacktop 完成了什么操作，目的是什么？ tail kern_init 完成了什么操作，目的是什么？
**操作系统内核启动流程**
1. ***硬件初始化和固件启动***。当计算机接通电源时，硬件首先触发加电复位，这CPU 的程序计数器（PC）自动跳转到固件（Firmware）的固化复位地址，完成硬件初始化。
2. ***引导程序（Bootloader）内核加载***。将Bootloader加载到内存并执行，Bootloader将操作系统内核镜像加载到内存的指定地址，并将CPU控制权交换内核。
3. ***内核启动执行***。从内核的入口函数开始执行，入口函数设置内核栈指针，为C语言函数调用分配栈空间，准备C语言运行环境，进而调用一系列子模块完成内核的初始化。

**kern/init/entry.S代码**
```
```Assembly Language
#include <mmu.h>
#include <memlayout.h>

    .section .text,"ax",%progbits
    .globl kern_entry
kern_entry:
    la sp, bootstacktop

    tail kern_init

.section .data
    # .align 2^12
    .align PGSHIFT
    .global bootstack
bootstack:
    .space KSTACKSIZE
    .global bootstacktop
bootstacktop:
```
**指令 la sp, bootstacktop 完成了什么操作，目的是什么？**
```
bootstack:
    .space KSTACKSIZE
    .global bootstacktop
```
这段代码分配了<u>KSTACKSIZE</u>大小的栈内存空间，将bootstack设置为栈底，bootstacktop设置为栈顶。
kern_entry是内核的入口函数,la sp, bootstacktop将bootstacktop对应的栈顶地址赋值给sp寄存器，目的是初始化栈，为栈分配内存空间,为c语言准备了运行环境。
**tail kern_init 完成了什么操作，目的是什么？**
tail kern_init 会将 kern_init 函数的地址加载到程序计数器（pc）中，实现跳转到 kern_init 执行，并且tail 跳转不会保存当前指令的返回地址到 $ra 寄存器（返回地址寄存器），也就是不会再回到当前位置执行了。
kern_init函数在kern/init/init.c里
```
#include <stdio.h>
#include <string.h>
#include <sbi.h>
int kern_init(void) __attribute__((noreturn));

int kern_init(void) {
    extern char edata[], end[];
    memset(edata, 0, end - edata);

    const char *message = "(THU.CST) os is loading ...\n";
    cprintf("%s\n\n", message);
   while (1)
        ;
}
```
这段代码的作用是将C语言中未初始化的全局 / 静态变量默认值为 0，通过这一步确保其初始值正确，输出启动信息"(THU.CST) os is loading ...\n"，进入无限循环，维持内核运行状态。
***tail kern_init 目的是***跳转到内核初始化函数，让内核从启动准备阶段进入真正的初始化阶段，同时避免冗余的资源消耗。
## 练习2: 使用GDB验证启动流程
**实验内容**
为了熟悉使用 QEMU 和 GDB 的调试方法，请使用 GDB 跟踪 QEMU 模拟的 RISC-V 从加电开始，直到执行内核第一条指令（跳转到 0x80200000）的整个过程。通过调试，请思考并回答：RISC-V 硬件加电后最初执行的几条指令位于什么地址？它们主要完成了哪些功能？请在报告中简要记录你的调试过程、观察结果和问题的答案。

首先，启动qemu,在lab1的源码的目录下执行命令`make qemu`
- [ ] ![12](https://hackmd.io/_uploads/rk4_aIT2xe.jpg)
说明我们的makefile是正确的
接下来，我们使用GDB进行调试
输入指令`x/10i $pc`查看接下来要执行的10条汇编指令：
```
0x0000000000001000 in ?? ()
(gdb) x/10i $pc
=> 0x1000:      auipc   t0,0x0
   0x1004:      addi    a1,t0,32
   0x1008:      csrr    a0,mhartid
   0x100c:      ld      t0,24(t0)
   0x1010:      jr      t0
   0x1014:      unimp
   0x1016:      unimp
   0x1018:      unimp
   0x101a:      0x8000
   0x101c:      unimp
```
1. auipc 是 RISC-V 的 “add upper immediate to program counter” 指令，功能是将立即数（这里是 0x0）左移 12 位后，与当前 $pc（0x1000）相加，结果存入寄存器 t0。
2. addi 是 “add immediate” 指令，将寄存器 t0 的值（0x1000）加上立即数 32，结果存入寄存器 a1。计算：a1 = 0x1000 + 32 = 0x1020。
3. csrr 是 “control and status register read” 指令，用于读取控制状态寄存器（CSR）的值。这里读取 mhartid（机器模式下的硬件线程 ID），存入寄存器 a0（通常用作函数第一个参数）。目的是获取当前 CPU 核心的 ID。
4. ld 是 “load doubleword” 指令，从内存中读取 64 位数据。地址为 t0（0x1000）加上偏移量 24（即 0x1000 + 24 = 0x1018），将该地址的值加载到 t0 中。
5. jr 是 “jump register” 指令，跳转到寄存器 t0 所指向的地址（即上一步从 0x1018 加载的值）。
6. unimp 是 “unimplemented” 的缩写，未实现指令。
```
(gdb) si
0x0000000000001004 in ?? ()
(gdb) si
0x0000000000001008 in ?? ()
(gdb) si
0x000000000000100c in ?? ()
(gdb) i r t0
t0             0x1000   4096
(gdb) si
0x0000000000001010 in ?? ()
(gdb) i r t0
t0             0x80000000       2147483648
(gdb) si
0x0000000080000000 in ?? ()
```
单步执行，查看t0寄存器的值，可以看到t0的值在pc=0x1010时为0x80000000
所以PC跳转到0x80000000处执行指令。
使用`watch *0x80200000`观察内核加载瞬间，避免单步跟踪大量代码。

## 实验中遇到的问题
**1.输入指令 make qemu 时报错如下**
```
zhangos@zhang:/opt/0SLab/lab1$sudo make qemu
/bin/sh:1:riscv64-unknown-elf-gcc:not found
make: *** Deleting file 'obj/kern/driver/console .d'
/bin/sh:1:riscv64-unknown-elf-gcc: not found
make: *** Deleting file 'obj/kern/libs/stdio.d/
bin/sh:1:riscv64-unknown-elf-gcc:not found
make: *** Deleting file 'obj/kern/init/init.d'
/bin/sh:1:riscv64-unknown-elf-gcc:not found
make: *** Deleting file 'obj/kern/init/entry.d
/bin/sh:1:riscv64-unknown-elf-gcc:not found
make: *** Deleting file 'obj/libs/string .d'
/bin/sh:1:riscv64-unknown-elf-gcc:not found
make: *** Deleting file 'obj/libs/sbi.d'
/bin/sh:1:riscv64-unknown-elf-gcc:not found
make: *** Deleting file 'obj/libs/readline.d'
/bin/sh:1:riscv64-unknown-elf-gcc:not found
make: *** Deleting file 'obj/libs/printfmt.d'
+ cc kern/init/entry.S
make: riscv64-unknown-elf-gcc:No such file or directory
make:***[Makefile:112:obj/kern/init/entry.o]Error 127

```
总之，意思就是找不到我的```riscv64-unknown-elf-gcc```工具，但是在做实验之前，我都是按着手册一步一步配置好实验环境的，所以这里这个错误应该是有问题的，我问了AI之后，也是没有什么头绪，大概都是让我重新配置环境重新下载对应工具之类的，我后面又请教了助教学长，并且检查了我的```~/.bashrc```,发现PATH是没有错误的，虽然我没有在```home```文件夹下，但是应该不会出错，后面我有去询问了AI，然后发现了一个很巧妙地地方可能会出错，在尝试后发现，解决了这个问题，AI的原话是这样说的：
```PATH``` 环境变量在 ```sudo``` 下的差异
```sudo``` 以超级用户```（root）```身份执行命令，默认情况下，```root``` 用户的 ```PATH``` 环境变量和普通用户的 ```PATH``` 环境变量可能不同。虽然普通用户的 ```PATH``` 中已经包含了 ```RISC - V``` 工具链路径，但 ```root``` 用户的 ```PATH``` 中可能没有。
解决方法：可以临时将普通用户的 ```PATH``` 变量设置给 ```root```，在执行 ```sudo``` 命令前，先执行：
```sudo env PATH="$PATH" make qemu```
这会让 ```sudo``` 在执行 ```make qemu``` 时，使用当前普通用户的 ```PATH``` 环境变量，从而找到 ```RISC - V``` 交叉编译器。
再尝试了该方法之后，确实可以正常运行的我的```qemu```了。

**2.使用`watch *0x80200000`指令时发生错误**
对于实验要求中的练习2而言，要求我们跟踪指令从```0x1000```到指令```0x80200000```的整个过程，但是在实验过程中，我使用```si```指令执行单步调试，可以发现，在指令执行过程中，很快就跳转到了```0x80000000```但是迟迟也跳转不到```0x80200000```在实验文档中可以看到，提到了使用```watch```指令，也就是在使用该指令时遇到了困难。
在使用```watch```指令标记```0x80200000```后，我们按下```c```后继续执行，等到该地址发生变化，即可停止，但是一直不停下，说明我们遇到了问题，我们按下```Ctrl + c```后，发现是因为我们陷入了```while(1)```循环。但是此时我有一个很大的疑惑，按理说我们的启动内核的步骤不应该是这样的么：


<div style="
  width: 500px;       /* 容器宽度 */
  margin: 0 auto;     /* 左右自动外边距，实现水平居中 */
  overflow-x: auto;   /* 水平滚动 */
  overflow-y: hidden;
  white-space: nowrap;
  border: 1px solid #ddd;
  padding: 10px;
">
    
    加电复位 → CPU从0x1000进入MROM → 跳转到0x80000000(OpenSBI) → OpenSBI初始化并加载内核到0x80200000 → 跳转到entry.S → 调用kern_init() → 输出信息 → 结束
    
</div>

也就是说，我们要先跳转到```0x80000000```处，这和上面我们分析的一样，指令会执行到这里，然后加载内核到```0x80200000```处，后面才会有跳转到```entry.S```,而后的```kern_init()```里面才是```while(1)```循环，所以我们应该是可以先观察到```0x80200000```的地址变化的，才能进循环，但是这里却直接进入循环了，对此AI的回答是这样的：
你的观察点 ```watch *0x80200000``` 是在程序启动后才设置的，但 ```0x80200000 ```的内容修改发生在更早的阶段：
若你在 ```GDB``` 中是先启动程序（run），再设置观察点，那么内核加载到 ```0x80200000``` 的过程已经完成，观察点自然不会触发。
即使你先设置观察点再启动程序，若硬件加载内核的操作发生在 ```GDB``` 监控之前（比如某些启动流程中，内核加载由固件完成，```GDB``` 从内核开始执行时才接管），观察点也会错过修改时机。
最终程序进入``` while(1)``` 循环后，```0x80200000``` 的内容（内核代码）不会再被修改，因此观察点永远不会触发，看起来就像 “卡在循环中”。

后面我又进行了思考，由于我们在执行```watch```指令之前，只执行了```make debug```和```make gdb```指令，那说明我们在执行这两条指令的时候，内核就已经被加载到```0x80200000```了，后面该地址的内容没有被修改。但是我觉得这是说的**错误的！**，因为在我们单步调试的时候是可以观察到从```0x1000```跳转到```0x80000000(OpenSBI)```的，说明我们还没开始加载内核，所以AI的解答是有问题的，后面还需要再想助教请教一下。

## 实验总结
对于此次实验而言，只是本学期实验的开始，相对比较简单，只是对于内核启动过程的的学习与了解，但是在实验中也遇到了大大小小的问题，甚至还没有解决的问题，但是这也使我们更加深刻的理解了内核的启动过程，通过思考和讨论练习题，我们更进一步的了解本次实验的核心内容，受益匪浅！









