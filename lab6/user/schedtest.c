#include <stdio.h>
#include <ulib.h>
#include <string.h>

const int MAX_TIME = 100000000;

// 模拟 CPU 密集型任务
void cpu_bound_task(int pid, int duration) {
    int i;
    // 使用 volatile 防止编译器优化掉循环
    volatile int k = 0; 
    cprintf("Process %d (CPU-bound) started.\n", pid);
    for (i = 0; i < duration; i++) {
        k++;
    }
    cprintf("Process %d (CPU-bound) finished.\n", pid);
}

// 模拟 I/O 密集型任务 (频繁让出 CPU)
void io_bound_task(int pid, int duration) {
    int i;
    cprintf("Process %d (I/O-bound) started.\n", pid);
    for (i = 0; i < duration / 10; i++) {
        yield(); // 主动让出 CPU，模拟等待 I/O
    }
    cprintf("Process %d (I/O-bound) finished.\n", pid);
}

int main(void) {
    int start_time = gettime_msec(); // 需要在 ulib 中实现或使用系统 tick 估算
    int pids[5];
    
    // 创建混合负载
    // 0, 1: 长作业 (CPU 密集)
    // 2, 3, 4: 短作业 (可以理解为 I/O 密集或只需很短 CPU)
    
    int i;
    for (i = 0; i < 5; i++) {
        if ((pids[i] = fork()) == 0) {
            // 子进程
            int current_pid = getpid();
            if (i < 2) {
                // 长作业
                cpu_bound_task(current_pid, MAX_TIME);
            } else {
                // 短作业
                cpu_bound_task(current_pid, MAX_TIME / 10);
            }
            exit(0);
        }
    }

    // 父进程等待并统计
    for (i = 0; i < 5; i++) {
        wait();
    }
    
    cprintf("All processes finished.\n");
    return 0;
}