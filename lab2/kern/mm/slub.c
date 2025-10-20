#include <slub.h>
#include <pmm.h>         // 1. 包含 pmm.h, 用于 alloc_pages/free_pages
#include <memlayout.h>   // 2. 包含 memlayout.h, 用于 PGSIZE, page2kva, pa2page, PADDR
#include <string.h>      // 3. 包含 string.h, 用于 strncpy, memset
#include <defs.h>        // 4. 包含 defs.h, 用于 assert, container_of, ROUNDDOWN
#include <error.h>       // 5. 包含 error.h, 用于 -E_NO_MEM
#include <stdio.h>       // 6. 包含 stdio.h, 用于 cprintf (调试)

// 宏：从 list_entry_t 节点获取其宿主 slab_t 结构体
#define le2slab(le, link) container_of(le, struct slab_t, link)
#define KADDR(pa) ((void *)((uintptr_t)(pa) + va_pa_offset))
#define page2kva(page) KADDR(page2pa(page))
#define container_of(ptr, type, member) \
    ((type *)((char *)(ptr) - offsetof(type, member)))
/*
 * -----------------------------------------------------------------------------
 * 内部辅助函数 (Internal Helper Functions)
 * -----------------------------------------------------------------------------
 */

/**
 * @brief kmem_cache_grow (内部 static 函数)
 * * 为指定的 cache 分配一个新的、空的 slab。
 * 这是 SLUB 系统的“进货”操作。
 *
 * @param cache 需要增长的 cache "工厂"
 * @return 0 表示成功, -E_NO_MEM 表示内存不足
 */
static int
kmem_cache_grow(struct kmem_cache_t *cache) {
    // 1. 调用 alloc_pages() 申请一个或多个物理页
    size_t num_pages = 1 << cache->slab_order;
    struct Page *page = alloc_pages(num_pages);
    if (page == NULL) {
        cprintf("kmem_cache_grow: failed to alloc %d pages for cache %s\n", num_pages, cache->name);
        return -E_NO_MEM;
    }

    // 2. 获取新分配页的内核虚拟地址
    void *slab_va = page2kva(page);

    // 3. 在这块新内存的开头初始化 struct slab_t 管理头
    struct slab_t *slab = (struct slab_t *)slab_va;
    slab->cache = cache;    // 设置反向指针
    slab->inuse = 0;      // 初始时 0 个对象被使用
    slab->freelist = NULL; // 稍后构建
    // s_mem 指向 slab_t 结构体 *之后* 的第一个可用地址
    slab->s_mem = (void *)(slab + 1);

    // 4. 将剩余的内存空间分割成 N 个对象，并将它们串联到 freelist 中
    // 我们从 s_mem 开始，将所有对象槽位（它们现在是空闲的）
    // 强制转换为 free_object 结构体，并链接成一个单向链表。
    void *obj_ptr = slab->s_mem;
    for (size_t i = 0; i < cache->num_per_slab; i++) {
        struct free_object *free_obj = (struct free_object *)obj_ptr;
        
        // 将此空闲对象插入到 freelist 的头部
        free_obj->next = slab->freelist;
        slab->freelist = free_obj;

        // 移动指针到下一个对象槽的起始位置
        obj_ptr = (void *)((char *)obj_ptr + cache->obj_size);
    }

    // 5. 将这个新 slab_t 加入到 cache 的 slabs_empty 链表中
    list_add_before(&(cache->slabs_empty), &(slab->slab_link));

    // 6. (可选) 更新统计信息
    cache->total_slabs++;
    cache->total_objs += cache->num_per_slab;

    return 0; // 成功
}

/**
 * @brief obj_to_slab (内部 static 函数)
 *
 * 根据一个对象指针，找到它所属的 slab_t 管理头。
 * 这是一个简化的实现，依赖于几个关键假设：
 * 1. slab_order == 0 (一个 slab 恰好占用一个物理页)
 * 2. slab_t 管理头位于该页的起始位置
 *
 * @param obj 指向 slab 内部某个对象的指针
 * @return 指向该对象所属的 slab_t 管理头
 */
static struct slab_t *
obj_to_slab(void *obj) {
    // 将对象地址向下舍入到最近的页边界
    // 这个页边界就是该页的起始地址，也就是 slab_t 结构体的地址
    uintptr_t obj_addr = (uintptr_t)obj;
    uintptr_t slab_addr = ROUNDDOWN(obj_addr, PGSIZE);
    
    return (struct slab_t *)slab_addr;
}


/*
 * -----------------------------------------------------------------------------
 * 核心 API 函数 (Core API Functions)
 * -----------------------------------------------------------------------------
 */

/**
 * 1. kmem_cache_create() 的实现
 */
struct kmem_cache_t *
kmem_cache_create(const char *name, size_t size, size_t slab_order) {
    // 这个实现存在一个“先有鸡还是先有蛋”的引导问题：
    // kmem_cache_t 结构体本身需要内存。在 kmalloc 可用之前，
    // 我们必须使用 pmm.h 中的 alloc_pages() 来为它分配。
    // 这会浪费一整页，但在引导阶段这是唯一可用的方法。
    
    struct Page *page = alloc_pages(1);
    if (page == NULL) {
        cprintf("kmem_cache_create: no memory for cache struct %s\n", name);
        return NULL;
    }
    struct kmem_cache_t *cache = (struct kmem_cache_t *)page2kva(page);
    
    // 清理分配的内存
    memset(cache, 0, PGSIZE);

    // 填充 cache 结构体
    strncpy(cache->name, name, KMEM_CACHE_NAME_LEN - 1);
    cache->name[KMEM_CACHE_NAME_LEN - 1] = '\0';
    cache->obj_size = size;
    cache->slab_order = slab_order;

    // --- 简化实现：断言 slab_order 为 0 ---
    // 这个简化的实现假定一个 slab 总是 1 页。
    // 一个更完整的实现需要处理多页 slab。
    if (slab_order != 0) {
        cprintf("kmem_cache_create: ERROR! Simplified SLUB only supports slab_order = 0.\n");
        free_pages(page, 1);
        return NULL;
    }
    // --- 简化结束 ---

    // 计算每个 slab 能容纳多少个对象
    size_t slab_size = (1 << slab_order) * PGSIZE;
    size_t available_space = slab_size - sizeof(struct slab_t);
    cache->num_per_slab = available_space / size;

    if (cache->num_per_slab == 0) {
        cprintf("kmem_cache_create: Object size %d too large for a single slab!\n", size);
        free_pages(page, 1);
        return NULL;
    }

    // 初始化三个 slab 链表
    list_init(&(cache->slabs_full));
    list_init(&(cache->slabs_partial));
    list_init(&(cache->slabs_empty));

    // 统计信息已在 memset 中清零

    cprintf("kmem_cache_create: created cache %s (obj_size=%d, num_per_slab=%d)\n",
            cache->name, cache->obj_size, cache->num_per_slab);

    return cache;
}

/**
 * 2. kmem_cache_alloc() 的实现
 */
void *
kmem_cache_alloc(struct kmem_cache_t *cache) {
    assert(cache != NULL);

    struct slab_t *slab;
    list_entry_t *le;

    // 1. 优先从 slabs_partial (部分空闲) 链表获取
    if (!list_empty(&(cache->slabs_partial))) {
        le = list_next(&(cache->slabs_partial));
        slab = le2slab(le, slab_link);
    }
    // 2. 其次从 slabs_empty (完全空闲) 链表获取
    else if (!list_empty(&(cache->slabs_empty))) {
        le = list_next(&(cache->slabs_empty));
        slab = le2slab(le, slab_link);
    }
    // 3. 如果还没有，就调用 kmem_cache_grow() 创建新 slab
    else {
        if (kmem_cache_grow(cache) != 0) {
            return NULL; // 彻底没内存了
        }
        // grow 成功后，slabs_empty 链表必定不再为空
        assert(!list_empty(&(cache->slabs_empty)));
        le = list_next(&(cache->slabs_empty));
        slab = le2slab(le, slab_link);
    }

    // 此时, `slab` 指向一个至少有一个空闲对象的 slab
    // 4. 从 slab_t 的 freelist 中取出一个对象
    assert(slab->freelist != NULL);
    struct free_object *free_obj = slab->freelist;
    void *obj = (void *)free_obj;
    
    // 将 freelist 指向下一个空闲对象
    slab->freelist = free_obj->next;

    // 5. 更新 inuse 计数，并检查是否需要移动链表
    slab->inuse++;
    cache->active_objs++;

    // 从原链表（partial 或 empty）中移除
    list_del(&(slab->slab_link));

    if (slab->inuse == cache->num_per_slab) {
        // 刚刚分配了最后一个对象，slab 变满了
        list_add_before(&(cache->slabs_full), &(slab->slab_link));
    } else {
        // 还有空闲对象，slab 处于 partial 状态
        list_add_before(&(cache->slabs_partial), &(slab->slab_link));
    }

    // 返回分配的对象指针
    return obj;
}

/**
 * 3. kmem_cache_free() 的实现
 */
void 
kmem_cache_free(struct kmem_cache_t *cache, void *obj) {
    if (obj == NULL) {
        return;
    }

    // 1. 根据 obj 指针找到它所属的 slab_t
    // (使用我们简化的辅助函数)
    struct slab_t *slab = obj_to_slab(obj);

    // (健壮性检查) 确保这个 slab 确实属于这个 cache
    if (slab->cache != cache) {
        panic("kmem_cache_free: object %p does not belong to cache %s\n", obj, cache->name);
    }
    assert(slab->inuse > 0);

    // 2. 将对象归还到 slab_t 的 freelist
    // 将这块内存强制转换为空闲对象指针
    struct free_object *free_obj = (struct free_object *)obj;
    
    // 插入到 freelist 头部
    free_obj->next = slab->freelist;
    slab->freelist = free_obj;

    // 3. 更新 inuse 计数，并检查是否需要移动链表
    slab->inuse--;
    cache->active_objs--;

    // 从原链表（full 或 partial）中移除
    list_del(&(slab->slab_link));

    if (slab->inuse == 0) {
        // 刚刚释放了最后一个对象，slab 变空了
        list_add_before(&(cache->slabs_empty), &(slab->slab_link));
    } else {
        // 之前是 full，现在是 partial
        // 或者之前是 partial，现在还是 partial
        list_add_before(&(cache->slabs_partial), &(slab->slab_link));
    }
}

/**
 * 4. kmem_cache_destroy() 的实现
 */
void 
kmem_cache_destroy(struct kmem_cache_t *cache) {
    assert(cache != NULL);

    // 1. 检查：必须确保所有对象都已释放
    if (cache->active_objs != 0) {
        panic("kmem_cache_destroy: attempting to destroy cache %s with %d active objects\n",
              cache->name, cache->active_objs);
    }
    assert(list_empty(&(cache->slabs_full)));
    assert(list_empty(&(cache->slabs_partial)));

    // FIX 3: 使用一个更简单的、安全的遍历方式
    list_entry_t *le = list_next(&(cache->slabs_empty));
    while (le != &(cache->slabs_empty)) {
        struct slab_t *slab = le2slab(le, slab_link);
        list_entry_t *next_le = list_next(le); // 提前保存下一个节点
        
        list_del(le);

        struct Page *page = pa2page(PADDR(slab));
        free_pages(page, 1 << cache->slab_order);

        le = next_le;
    }

    // FIX 4: 修正 'cache_page' 未定义的错误
    struct Page *cache_page = pa2page(PADDR(cache));
    free_pages(cache_page, 1);
}
