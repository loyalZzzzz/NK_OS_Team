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