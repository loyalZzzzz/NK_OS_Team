#ifndef __KERN_MM_KMALLOC_H__
#define __KERN_MM_KMALLOC_H__

#include <defs.h> // 1. 包含 <stddef.h> 以使用 size_t

/*
 * 2. 核心 API 函数原型
 */

/**
 * @brief 初始化 kmalloc 系统
 * * 创建一系列通用的 SLUB 缓存 (kmalloc-32, kmalloc-64, etc.)
 * 必须在 pmm_init() 成功调用之后执行。
 */
void kmalloc_init(void);

/**
 * @brief 分配一块任意大小的内存
 * * @param size 请求的内存大小 (in bytes)
 * @return 指向已分配内存的指针，如果失败则返回 NULL
 */
void *kmalloc(size_t size);

/**
 * @brief 释放一块由 kmalloc 分配的内存
 * * @param ptr 指向由 kmalloc() 返回的内存块的指针
 */
void kfree(void *ptr);

/**
 * @brief SLUB/kmalloc 系统的自检函数
 * 用于验证 kmalloc 和 kfree 的正确性。
 */
void kmalloc_check(void);


#endif /* !__KERN_MM_KMALLOC_H__ */
