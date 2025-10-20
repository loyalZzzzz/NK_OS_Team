/*
 * kern/mm/kmalloc.c
 *
 * (c) 2025 (Your Name/Group)
 *
 * General Purpose Kernel Malloc Implementation
 *
 * This file implements the frontend for the SLUB allocator, providing
 * a generic kmalloc/kfree interface.
 */

#include <kmalloc.h>
#include <slub.h>         // 1. 关键：使用 slub.h 作为后端
#include <pmm.h>
#include <memlayout.h>
#include <stdio.h>
#include <assert.h>
#include <string.h>

/*
 * -----------------------------------------------------------------------------
 * 静态辅助函数 (Static Helper Functions for bit manipulation)
 * -----------------------------------------------------------------------------
 */

/**
 * ffs (find first set bit) - 查找最低位的 '1' 在第几位 (从1开始)
 */
static int
ffs(int i) {
    if (i == 0) return 0;
    int n = 1;
    while ((i & 1) == 0) {
        i >>= 1;
        n++;
    }
    return n;
}

/**
 * fls (find last set bit) - 查找最高位的 '1' 在第几位 (从1开始)
 *
 * (一个比注释中更健壮、更高效的实现)
 */
static int
fls(int i) {
    if (i == 0) return 0;
    int n = 0;
    // 使用32位整数的假设（对于size_t可能是64位，但这用于计算2的幂，足够了）
    if (i & 0xFFFF0000) { n += 16; i >>= 16; }
    if (i & 0x0000FF00) { n += 8;  i >>= 8;  }
    if (i & 0x000000F0) { n += 4;  i >>= 4;  }
    if (i & 0x0000000C) { n += 2;  i >>= 2;  }
    if (i & 0x00000002) { n += 1;  i >>= 1;  }
    if (i & 0x00000001) { n += 1; }
    return n;
}
/*
 * -----------------------------------------------------------------------------
 * 定义通用缓存 (Defining the General Purpose Caches)
 * -----------------------------------------------------------------------------
 */

// 定义我们支持的最小和最大 kmalloc 大小 (2的幂)
#define KMALLOC_MIN_SIZE_LOG2   5  // 2^5 = 32 bytes
#define KMALLOC_MAX_SIZE_LOG2  11  // 2^11 = 2048 bytes

// 计算通用缓存的数量
#define KMALLOC_CACHES_COUNT (KMALLOC_MAX_SIZE_LOG2 - KMALLOC_MIN_SIZE_LOG2 + 1)

// 2. 静态数组，用于存放一系列“通用工厂”
static struct kmem_cache_t *kmalloc_caches[KMALLOC_CACHES_COUNT];

// 辅助函数：根据 size 获取对应的 cache 索引
static inline size_t
size_to_index(size_t size) {
    if (size == 0) return -1; // 无效大小
    
    // 向上取整到最近的 2 的幂
    size_t rounded_size = 1 << (fls(size - 1)); // fls: find last set bit (在 string.h 中实现)
    if (rounded_size < (1 << KMALLOC_MIN_SIZE_LOG2)) {
        rounded_size = (1 << KMALLOC_MIN_SIZE_LOG2);
    }

    if (rounded_size > (1 << KMALLOC_MAX_SIZE_LOG2)) {
        return -1; // 请求的大小过大
    }

    // 计算索引
    return (ffs(rounded_size) - 1) - KMALLOC_MIN_SIZE_LOG2; // ffs: find first set bit
}

/*
 * -----------------------------------------------------------------------------
 * 核心 API 函数 (Core API Functions)
 * -----------------------------------------------------------------------------
 */

/**
 * 3. kmalloc_init() 的实现
 */
void 
kmalloc_init(void) {
    cprintf("kmalloc_init: initializing general purpose SLUB caches\n");

    for (int i = 0; i < KMALLOC_CACHES_COUNT; i++) {
        size_t obj_size = 1 << (i + KMALLOC_MIN_SIZE_LOG2);
        char name[KMEM_CACHE_NAME_LEN];
        
        // 创建一个名称，例如 "kmalloc-64"
        snprintf(name, sizeof(name), "kmalloc-%d", obj_size);

        // 调用 slub.c 中的函数来创建“工厂”
        // 假设所有 kmalloc 的 slab 都只占 1 页 (slab_order = 0)
        kmalloc_caches[i] = kmem_cache_create(name, obj_size, 0);

        if (kmalloc_caches[i] == NULL) {
            panic("kmalloc_init: failed to create cache %s\n", name);
        }
    }
    cprintf("kmalloc_init: initialization complete.\n");
}

/**
 * 4. kmalloc(size_t size) 的实现
 */
void *
kmalloc(size_t size) {
    if (size == 0) {
        return NULL;
    }

    // 1. 检查 size 是否过大，超过了 kmalloc 的管理能力
    // 对于更大的内存请求，应该直接使用 alloc_pages()
    if (size > (1 << KMALLOC_MAX_SIZE_LOG2)) {
        cprintf("kmalloc: request size %d too large, use alloc_pages instead.\n", size);
        return NULL;
    }

    // 2. 找到一个最“合身”的 cache
    // 向上取整到最接近的 2 的幂
    size_t rounded_size = 1 << (fls(size - 1));
    if (rounded_size < (1 << KMALLOC_MIN_SIZE_LOG2)) {
        rounded_size = (1 << KMALLOC_MIN_SIZE_LOG2);
    }
    
    // 计算这个大小对应的 cache 在数组中的索引
    // ffs(find first set bit) - 1 即可得到 log2(size)
    int index = (ffs(rounded_size) - 1) - KMALLOC_MIN_SIZE_LOG2;

    if (index < 0 || index >= KMALLOC_CACHES_COUNT) {
        // 理论上不应该发生，除非 size 超大
        return NULL;
    }

    // 3. 调用 kmem_cache_alloc() 并返回结果
    // cprintf("kmalloc: size=%d -> rounded=%d, using cache '%s'\n", 
    //         size, rounded_size, kmalloc_caches[index]->name);
    return kmem_cache_alloc(kmalloc_caches[index]);
}

/**
 * 5. kfree(void *ptr) 的实现
 */
void 
kfree(void *ptr) {
    if (ptr == NULL) {
        return;
    }

    // 1. 这是最难的部分：根据 ptr 指针反向推导出它属于哪个 kmem_cache_t
    // (简化实现：假设所有 kmalloc 的 slab 都是单页的)
    
    // a. 通过 ptr 找到它所在的页的基地址 (也就是 slab 的起始地址)
    //    这个宏在 slub.c 中实现，但我们可以在这里重新使用其逻辑
    uintptr_t ptr_addr = (uintptr_t)ptr;
    uintptr_t slab_addr = ROUNDDOWN(ptr_addr, PGSIZE);
    
    struct slab_t *slab = (struct slab_t *)slab_addr;

    // b. 从 slab_t 管理头中直接获取其所属的 cache
    struct kmem_cache_t *cache = slab->cache;
    
    // c. (健壮性检查)
    if (cache == NULL) {
        panic("kfree: trying to free a pointer %p with no associated cache!\n", ptr);
    }

    // 2. 调用 kmem_cache_free(cache, ptr)
    // cprintf("kfree: ptr=%p belongs to cache '%s'\n", ptr, cache->name);
    kmem_cache_free(cache, ptr);
}

/*
 * -----------------------------------------------------------------------------
 * kmalloc 自检函数 (Self-Checking Function)
 * -----------------------------------------------------------------------------
 */

void
kmalloc_check(void) {
    cprintf("kmalloc_check: starting SLUB/kmalloc system test.\n");
    cprintf("\n");
    void *p_array[500];
    int slab_count;
    void *current_slab_addr;

    // --- 测试 1: 边界情况和无效输入 ---
    cprintf("  - Test 1: Boundary and invalid cases...\n");
    void *res0 = kmalloc(0);
    cprintf("    kmalloc(0) returned: %p\n", res0);
    assert(res0 == NULL);
    void *res_large = kmalloc(4097);
    cprintf("    kmalloc(4097) returned: %p\n", res_large);
    assert(res_large == NULL);
    cprintf("    Calling kfree(NULL)...\n");
    kfree(NULL);
    cprintf("    kfree(NULL) completed without panic.\n");
    cprintf("\n");

    // --- 测试 2: 基本功能和 LIFO 行为 ---
    cprintf("  - Test 2: Basic alloc/free and LIFO check...\n");
    void *p1 = kmalloc(32);
    cprintf("    1. Allocated p1 at address: %p\n", p1);
    assert(p1 != NULL);
    cprintf("    2. Freed p1. This address should now be at the top of the freelist.\n");
    kfree(p1);
    void *p2 = kmalloc(32);
    cprintf("    3. Allocated p2 at address: %p\n", p2);
    assert(p2 != NULL);
    cprintf("    4. Checking if p1 (%p) == p2 (%p) to confirm LIFO behavior...\n", p1, p2);
    assert(p1 == p2);
    cprintf("       LIFO behavior confirmed: The same address was returned.\n");
    kfree(p2);
    cprintf("\n");

    // --- 测试 3: 数据完整性 ---
    cprintf("  - Test 3: Data integrity check...\n");
    char *p_char = kmalloc(100);
    assert(p_char != NULL);
    strcpy(p_char, "Hello, SLUB!");
    assert(strcmp(p_char, "Hello, SLUB!") == 0);
    kfree(p_char);
    cprintf("\n");

    // --- 测试 4: 强制 Slab 增长 ---
    cprintf("  - Test 4: Forcing slab growth...\n");
    current_slab_addr = NULL; // 重置跟踪变量
    slab_count = 0;           // 重置跟踪变量
    cprintf("    Allocating 500 objects of size 64. Expecting multiple slab creations.\n");
    for (int i = 0; i < 500; i++) {
        p_array[i] = kmalloc(64); // 使用在顶部声明的 p_array
        assert(p_array[i] != NULL);
        void *new_slab_addr = (void *)ROUNDDOWN((uintptr_t)p_array[i], PGSIZE);
        if (new_slab_addr != current_slab_addr) {
            current_slab_addr = new_slab_addr;
            slab_count++;
            cprintf("    Allocation %d: Switched to a NEW slab (Slab #%d) at %p\n", i, slab_count, current_slab_addr);
        }
        for (int j = 0; j < i; j++) {
            assert(p_array[i] != p_array[j]);
        }
    }
    cprintf("    Successfully allocated 500 objects across %d slabs.\n", slab_count);
    cprintf("    Now freeing all 500 objects from Test 4...\n");
    for (int i = 0; i < 500; i++) {
        kfree(p_array[i]);
    }
    cprintf("    All objects from Test 4 freed.\n");
    cprintf("\n");

    // --- 测试 5: 混合分配与释放 ---
    cprintf("  - Test 5: Mixed size allocation and free...\n");
    cprintf("    1. Allocating objects of different sizes...\n");
    void *ptr_small = kmalloc(30);
    cprintf("       - kmalloc(30)  -> should be routed to kmalloc-32 cache, got ptr: %p\n", ptr_small);
    assert(ptr_small != NULL);
    void *ptr_large = kmalloc(1000);
    cprintf("       - kmalloc(1000) -> should be routed to kmalloc-1024 cache, got ptr: %p\n", ptr_large);
    assert(ptr_large != NULL);
    void *ptr_mid = kmalloc(120);
    cprintf("       - kmalloc(120)  -> should be routed to kmalloc-128 cache, got ptr: %p\n", ptr_mid);
    assert(ptr_mid != NULL);
    assert(ptr_small != ptr_large && ptr_small != ptr_mid && ptr_large != ptr_mid);
    cprintf("    2. Writing distinct data patterns to each block...\n");
    memset(ptr_small, 0xAA, 30);
    memset(ptr_large, 0xBB, 1000);
    memset(ptr_mid,   0xCC, 120);
    cprintf("       Data written successfully.\n");
    cprintf("    3. Freeing blocks in a different order (large, small, mid)...\n");
    kfree(ptr_large);
    kfree(ptr_small);
    kfree(ptr_mid);
    cprintf("       All mixed-size blocks freed successfully.\n");
    cprintf("\n");

    // --- 测试 6: 耗尽并回收检查 ---
    cprintf("  - Test 6: Exhaust and Recycle check...\n");
    cprintf("    Phase 1: Allocating 500 objects to create and fill slabs...\n");
    void *slab_addrs[20];
    slab_count = 0; // 使用在顶部声明的 slab_count
    memset(slab_addrs, 0, sizeof(slab_addrs));
    for (int i = 0; i < 500; i++) {
        p_array[i] = kmalloc(32); // 使用在顶部声明的 p_array
        assert(p_array[i] != NULL);
        void *current_slab = (void *)ROUNDDOWN((uintptr_t)p_array[i], PGSIZE);
        int found = 0;
        for (int j = 0; j < slab_count; j++) {
            if (slab_addrs[j] == current_slab) {
                found = 1;
                break;
            }
        }
        if (!found && slab_count < 20) {
            slab_addrs[slab_count++] = current_slab;
        }
    }
    cprintf("    Phase 1: Finished. Populated %d unique slabs for 'kmalloc-32'.\n", slab_count);
    cprintf("    Phase 2: Freeing all 500 objects...\n");
    for (int i = 0; i < 500; i++) {
        kfree(p_array[i]);
    }
    cprintf("    Phase 2: Finished. Slabs are now available for recycling.\n");
    cprintf("    Phase 3: Re-allocating 500 objects to verify recycling...\n");
    void* first_recycled_obj = kmalloc(32);
    assert(first_recycled_obj != NULL);
    void* first_recycled_slab = (void*)ROUNDDOWN((uintptr_t)first_recycled_obj, PGSIZE);
    int is_recycled = 0;
    for(int i = 0; i < slab_count; i++) {
        if(slab_addrs[i] == first_recycled_slab) {
            is_recycled = 1;
            cprintf("    SUCCESS: First re-allocated object is from a recycled slab at %p.\n", first_recycled_slab);
            break;
        }
    }
    assert(is_recycled);
    kfree(first_recycled_obj);
    for (int i = 0; i < 500; i++) {
        p_array[i] = kmalloc(32);
        assert(p_array[i] != NULL);
    }
    for (int i = 0; i < 500; i++) {
        kfree(p_array[i]);
    }
    cprintf("    Phase 3: Finished. Recycling mechanism verified.\n");

    cprintf("kmalloc_check: All tests passed successfully!\n");
}
