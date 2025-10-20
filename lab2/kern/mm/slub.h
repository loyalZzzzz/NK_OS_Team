#ifndef __KERN_MM_SLUB_H__
#define __KERN_MM_SLUB_H__

#include <list.h> // 1. 包含 <list.h> 以使用 list_entry_t
#include <defs.h> // 2. 包含 <defs.h> 以使用 size_t

// 当一个对象槽空闲时，它的内存被用作一个指向下一个空闲对象的指针
struct free_object {
    struct free_object *next;
};

// 前向声明，因为 slab_t 需要引用 kmem_cache_t
struct kmem_cache_t;

/*
 * 3. struct slab_t 的结构体定义 (Slab 管理头)
 *
 * 位于每个 slab (一个或多个物理页) 的起始位置，
 * 之后的内存被分割成一个个的对象。
 */
struct slab_t {
    list_entry_t slab_link;       // 用于将此 slab 链接到 cache 的 full/partial/empty 链表
    struct kmem_cache_t *cache;   // 反向指针，指向拥有此 slab 的“工厂”
    size_t inuse;                 // 此 slab 中已分配对象的数量
    struct free_object *freelist; // 指向此 slab 内部的第一个空闲对象
    void *s_mem;                  // 指向此 slab 中第一个对象的起始地址 (跳过 slab_t 自身)
};

// 定义 cache 名称的最大长度
#define KMEM_CACHE_NAME_LEN 32

/*
 * 4. struct kmem_cache_t 的结构体定义 (Slab "工厂")
 *
 * 管理一种特定大小的所有对象和 slabs。
 */
struct kmem_cache_t {
    char name[KMEM_CACHE_NAME_LEN]; // cache 的名称，用于调试

    // 核心属性
    size_t obj_size;       // 此 cache 管理的对象的大小
    size_t num_per_slab;   // 每个 slab 能容纳的对象数量
    size_t slab_order;     // 每个 slab 的大小 (2^slab_order 个物理页)

    // 三个核心链表头，用于分类管理所有 slabs
    list_entry_t slabs_full;
    list_entry_t slabs_partial;
    list_entry_t slabs_empty;

    // (可选) 统计信息，用于调试
    size_t total_slabs;   // 此 cache 拥有的 slab 总数
    size_t total_objs;    // 此 cache 拥有的对象总数
    size_t active_objs;   // 此 cache 中已分配的对象总数
};

/*
 * 5. 核心 API 函数原型
 */

/**
 * @brief 创建一个新的 SLUB 缓存 ("工厂")
 * @param name 缓存的名称 (用于调试)
 * @param size 此缓存中每个对象的大小 (in bytes)
 * @param slab_order 每个 slab 的大小，以 2^order 个页为单位 (通常为 0，即 1 页)
 * @return 指向新创建的 kmem_cache_t 的指针，失败则返回 NULL
 */
struct kmem_cache_t *kmem_cache_create(const char *name, size_t size, size_t slab_order);

/**
 * @brief 销毁一个 SLUB 缓存
 * @param cache 指向要销毁的 cache
 * @note 必须确保所有对象都已释放，所有 slab 都已回收
 */
void kmem_cache_destroy(struct kmem_cache_t *cache);

/**
 * @brief 从指定的缓存中分配一个对象
 * @param cache 指向要从中分配的 cache
 * @return 指向已分配对象的指针，失败则返回 NULL
 */
void *kmem_cache_alloc(struct kmem_cache_t *cache);

/**
 * @brief 将一个对象归还给其所属的缓存
 * @param cache 指向该对象所属的 cache (理论上可以从 obj 推断，但传入 cache 更简单高效)
 * @param obj 指向要释放的对象的指针
 */
void kmem_cache_free(struct kmem_cache_t *cache, void *obj);


#endif /* !__KERN_MM_SLUB_H__ */