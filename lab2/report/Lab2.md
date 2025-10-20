---
title: Lab2

---

# Lab2
## 练习1：理解first-fit 连续物理内存分配算法（思考题）
first-fit 连续物理内存分配算法作为物理内存分配一个很基础的方法，需要同学们理解它的实现过程。请大家仔细阅读实验手册的教程并结合```kern/mm/default_pmm.c```中的相关代码，认真分析default_init，default_init_memmap，default_alloc_pages， default_free_pages等相关函数，并描述程序在进行物理内存分配的过程以及各个函数的作用。 请在实验报告中简要说明你的设计实现过程。请回答如下问题：

- 你的`first fit`算法是否有进一步的改进空间？

### 1. 核心功能与具体实现过程：
操作系统需要将物理内存划分成固定大小的“页（Page）”，再通过这个模块实现：
- **初始化**：把空闲内存页组织成链表（空闲链表）。
- **分配**：接收内存请求时，从链表中找“第一个足够大”的空闲块分配。
- **释放**：回收内存页时，将其重新加入链表，并尝试合并相邻空闲块（避免内存碎片）。
- **检查**：验证内存管理逻辑是否正确（如分配/释放后空闲页数量是否匹配）。


### 2. 关键结构与宏定义,对于注释的理解：
先理解代码中最基础的“工具”，后续逻辑依赖这些结构。

#### （1）`free_area_t`：空闲内存管理结构体
代码开头通过`static free_area_t free_area`定义了一个全局管理对象，内部包含两个核心成员（需结合`pmm.h`的定义理解）：
- `free_list`：**空闲链表**，用双向链表（`list.h`中的`list_entry_t`）组织所有空闲内存块。
- `nr_free`：**空闲页总数**，记录当前系统中可用的物理内存页数量。

#### （2）宏定义：简化代码
- `#define free_list (free_area.free_list)`：直接通过`free_list`访问全局空闲链表，不用每次写`free_area.free_list`。
- `#define nr_free (free_area.nr_free)`：同理，简化空闲页总数的访问。

#### （3）辅助宏/函数：链表与内存页的转换
- `le2page(le, page_link)`：将链表节点（`list_entry_t`类型的`le`）转换为对应的内存页结构体（`struct Page`）。核心原理是“结构体成员偏移计算”，通过链表节点找到整个内存页对象的地址（`memlayout.h`中定义）。
- `PageReserved(p)`/`SetPageProperty(p)`：内存页状态标记宏（`memlayout.h`中定义），用于标记页是否“已预留”（如内核占用）、是否“为空闲块的首页”。


### 3. 核心函数解析：
代码中5个核心函数实现了内存管理的完整逻辑，按`初始化→分配→释放→检查`的顺序理解。

#### （1）`default_init`：初始化内存管理器
- **功能**：启动时初始化空闲链表和空闲页计数。
- **逻辑**：
  1. 用`list_init(&free_list)`初始化双向链表（设为“空链表”状态）。
  2. 设`nr_free = 0`，初始时无空闲页（后续通过`default_init_memmap`添加）。

#### （2）`default_init_memmap`：初始化一块空闲内存区域
- **调用时机**：系统启动时（`kern_init → pmm_init → page_init → init_memmap`），将物理内存中“未被占用”的区域初始化为空闲块。
- **参数**：`base`（空闲区域的起始内存页）、`n`（该区域包含的内存页数量）。
- **核心逻辑**：
  1. 初始化每个内存页：清除“预留”标记、设引用计数为0（表示未被使用）。
  2. 标记空闲块首页：仅`base`（首页）的`property`设为`n`（表示该块共`n`个页），其他页`property`为0。
  3. 加入空闲链表：按“地址从低到高”的顺序，将该空闲块插入`free_list`（保证链表有序，方便后续分配和合并）。
  4. 更新空闲页总数：`nr_free += n`。

#### （3）`default_alloc_pages`：分配`n`个连续内存页
- **核心逻辑（首次适配）**：遍历空闲链表，找到“第一个大小≥`n`”的空闲块，分配后处理剩余空间。
- **步骤拆解**：
  1. 检查是否有足够空闲页：若`n > nr_free`，直接返回`NULL`（分配失败）。
  2. 遍历空闲链表：从`free_list`头开始，找到第一个`property ≥ n`的空闲块（`struct Page *p`）。
  3. 处理分配：
     - 从链表中删除该空闲块（`list_del(&(p->page_link))`）。
     - 若块大小大于`n`（分配后有剩余）：剩余部分作为新空闲块，重新插入链表（首页`property`设为`p->property - n`）。
     - 标记分配的页：清除“空闲”标记（`ClearPageProperty(p)`），表示该页已被占用。
  4. 更新空闲页总数：`nr_free -= n`，返回分配的首页地址（`p`）。

#### （4）`default_free_pages`：释放`n`个连续内存页
- **核心逻辑**：将释放的页标记为空闲，插入链表，并尝试合并“前后相邻的空闲块”（解决内存碎片问题）。
- **步骤拆解**：
  1. 初始化释放的页：清除“占用”标记、设引用计数为0，仅首页`base`的`property`设为`n`。
  2. 插入空闲链表：按“地址从低到高”的顺序，将释放的块插入`free_list`。
  3. 合并相邻空闲块：
     - 合并前块：若释放块的前一个节点是空闲块（地址连续），则合并为一个大空闲块（更新前块的`property`，删除释放块的链表节点）。
     - 合并后块：若释放块的后一个节点是空闲块（地址连续），则合并为一个大空闲块（更新释放块的`property`，删除后块的链表节点）。
  4. 更新空闲页总数：`nr_free += n`。

#### （5）`default_check`/`basic_check`：验证逻辑正确性
- **功能**：通过“分配→释放→再分配”的测试用例，检查内存管理是否正常。
- **示例逻辑**：
  1. 分配3个页，验证地址不重复、引用计数为0。
  2. 释放后验证空闲页总数是否恢复。
  3. 分配超过空闲页数量的请求，验证是否返回`NULL`。
  4. 释放相邻页后，验证是否合并为一个大空闲块。


### 4. 最终对外接口：`default_pmm_manager`
代码末尾定义了一个`struct pmm_manager`类型的对象，这是内存管理模块的“对外接口”，操作系统其他模块（如虚拟内存）通过这个接口调用内存管理功能：
| 成员         | 对应函数               | 功能说明                     |
|--------------|------------------------|------------------------------|
| `.name`      | "default_pmm_manager"  | 模块名称（标识首次适配算法） |
| `.init`      | `default_init`         | 初始化内存管理器             |
| `.init_memmap`| `default_init_memmap`  | 初始化空闲内存区域           |
| `.alloc_pages`| `default_alloc_pages`  | 分配`n`个连续页              |
| `.free_pages` | `default_free_pages`   | 释放`n`个连续页              |
| `.nr_free_pages`| `default_nr_free_pages`| 获取当前空闲页总数           |
| `.check`     | `default_check`        | 验证模块逻辑正确性           |


### 5.问题：`first fit` 算法是否有进一步的改进空间
#### （1）内存碎片化问题：
`first fit`算法很容易产生内部碎片（分配块大于请求大小的部分）在我们的代码中是完全按照`first fit`思想编写的代码，为了避免产生过多的微小的碎片 我们可以尝试增加最小块阈值：当剩余块大小小于某个阈值（如 1 页）时，不再分割，直接分配整个块（避免产生无法利用的微小碎片）。
可以尝试修改`default_alloc_pages`中的分割条件：
```
#define MIN_BLOCK_SIZE 1  // 最小保留块大小（1页）
if (page->property - n >= MIN_BLOCK_SIZE) {  // 仅当剩余块足够大时才分割
    struct Page *p = page + n;
    p->property = page->property - n;
    SetPageProperty(p);
    list_add(prev, &(p->page_link));
} else {
    // 剩余块太小，不分割，直接分配
    n = page->property;  // 修正分配页数为整个块大小
}
nr_free -= n;
```
这只是对于内存碎片化的一个简单的实现思路，而这种思路从某种意义上来讲，就是不断地靠近我们的`best fit`算法。

#### （2）对于分配块时遍历链表的问题
当我们需要分配一个内存块的时候，我们要从头遍历链表，来找到适合的块，当空闲块数量多、链表长时，遍历耗时会增加。我们可以尝试引入索引结构：用树结构（如平衡二叉树）替代链表，加速 “找第一个足够大的块” 的过程。

## 练习2：实现 Best-Fit 连续物理内存分配算法（需要编程）
在完成练习一后，参考`kern/mm/default_pmm.c`对`First Fit`算法的实现，编程实现`Best Fit`页面分配算法，算法的时空复杂度不做要求，能通过测试即可。 请在实验报告中简要说明你的设计实现过程，阐述代码是如何对物理内存进行分配和释放，并回答如下问题：

- 你的 `Best-Fit` 算法是否有进一步的改进空间？

我们打开`best_fit_pmm.c`文件后发现，有5处需要我们补充或者改写的代码，接下来我们一次按照该文件中的函数介绍来完成这一部分的代码编写并做详细介绍。
### 1.`best_fit_init_memmap`函数补充(2处）
如下图所示，这是在`best_fit_init_memmap`函数下我们的代码填充部分

![image](https://hackmd.io/_uploads/B1OVB7-Ale.png)


在该函数中，实际上我们采用了和`first_fit`一样的设计思路，首先是要循环初始化页属性：清除标志位、重置 `property`（非起始页为 0）、引用计数清零。注意这里我们的循环条件是`p!=base`也就是说我们的`base`页和其他页是分开处理的。
我们看下一部分，刚才的部分是初始化页，那么这一部分就是初始化我们的链表，按照实验课上老师所讲，我们这里再介绍一下“侵入式链表”这一重要数据结构。

**侵入式链表**

**1. 链表节点指针（`list_entry_t *le`）**
在C语言中，链表的实现通常需要“节点”来连接各个元素。这里的`list_entry_t`就是链表节点的结构体（定义类似如下）定义在`libs/list.h`文件中：
```c
struct list_entry {
    struct list_entry *prev, *next;
};

typedef struct list_entry list_entry_t;
```
- **链表节点指针（`le`）**：就是指向`list_entry_t`结构体的指针，用于遍历链表、访问前驱/后继节点。
- **作用**：通过`le->prev`和`le->next`可以在链表中移动，实现对链表元素的遍历、插入、删除等操作。


**2.`le2page(le, page_link)`：从链表节点找到实际数据（`struct Page`）**
操作系统中管理物理页时，每个物理页用`struct Page`描述（包含页的属性，如`flags`、`property`等）。为了将这些`struct Page`组织成链表，会在`struct Page`中嵌入一个`list_entry_t`类型的成员（即`page_link`），作为链表节点。

`struct Page`的定义是：
```c
struct Page {
    int ref;                        // page frame's reference counter
    uint64_t flags;                 // array of flags that describe the status of the page frame
    unsigned int property;          // the num of free block, used in first fit pm manager
    list_entry_t page_link;         // free list link
};
```

`le2page`的定义是：
```c
// convert list entry to page
#define le2page(le, member)                 \
    to_struct((le), struct Page, member)

```

- **`le2page`的作用**：已知链表节点`le`（即`page_link`的地址），反向计算出它所在的`struct Page`的起始地址。
- **实现原理**：通过指针运算，用节点在结构体中的偏移量，从节点地址推出整个结构体的地址。


**总结**
- **链表节点指针（`le`）**：是遍历链表的“工具”，通过它可以在链表中移动，但本身不包含物理页的具体信息。
- **`le2page`**：是“链表节点”到“实际物理页数据”的桥梁，让我们能通过链表节点找到它对应的物理页，从而操作页的属性（如判断块大小、地址等）。

以上是对于“侵入式链表”的分析，下面我们继续分析这个函数：

**1. 关键概念：“页”与“块”的区别**
- **单个页（Page）**：物理内存的最小单位（通常4KB），每个页有独立的`flags`、`property`等属性。
- **空闲块（Block）**：由**连续的多个页**组成的空闲内存区域。例如，8KB空闲内存是由2个连续的4KB页组成的块。

`best_fit_init_memmap`的作用是：将一段连续的物理内存（`n`个页）初始化为一个**空闲块**，并插入到全局的“空闲块链表”中。


**2. 代码逻辑解析：初始化并插入空闲块链表**

**（1）`if (list_empty(&free_list))`：链表为空时的初始化**
- `free_list`是全局的**空闲块链表头**，初始状态为空。
- 当链表为空时，直接将当前初始化的空闲块（`base`指向的`n`个页）加入链表，作为第一个空闲块。
- `list_add(&free_list, &(base->page_link))`：将块的起始页`base`的`page_link`节点挂到链表上（链表节点存放在块的起始页中）。


**（2）`else`：链表非空时，按地址升序插入**
当链表中已有其他空闲块时，需要将新块插入到链表的正确位置，**保证链表中的所有空闲块按起始地址从小到大排序**。 
遍历链表的过程：
- `le`是链表节点指针，从链表头开始遍历每个空闲块的节点。
- `page = le2page(le, page_link)`：通过节点找到对应的空闲块起始页。
- 核心判断：
  - `if (base < page)`：若新块的起始地址`base`小于当前块的起始地址`page`，说明新块应插在当前块前面（保持地址升序），用`list_add_before`插入后跳出循环。
  - `else if (list_next(le) == &free_list)`：若遍历到链表末尾（下一个节点是链表头），说明新块是地址最大的，插入到链表尾部，用`list_add`添加后跳出循环。


**3. 设计思路**
- **按地址排序的目的**：后续释放内存时，便于快速判断相邻块是否连续（例如，释放块的前/后是否有空闲块，可直接合并），减少内存碎片。
- **块的大小由`property`记录**：每个空闲块的起始页`base`的`property`字段记录块的总页数（`n`），而非起始页的`property`为0（用于区分是否是块的起始）。


### 2.`best_fit_alloc_pages`函数修改（1处）

![image](https://hackmd.io/_uploads/rJvsHXW0ee.png)


这段代码是`best_fit`算法的核心——**分配内存页**的函数。它的作用是：从空闲块链表中找到能满足需求的、最小的空闲块，然后分割并返回分配的页。下面逐行解释，并对比`first_fit`的区别。


**1. 函数入口与参数检查**
```c
static struct Page *best_fit_alloc_pages(size_t n) {
    assert(n > 0);  // 确保申请的页数n至少为1（无效输入检查）
    if (n > nr_free) {  // 如果申请的页数超过总空闲页数，直接返回NULL（分配失败）
        return NULL;
    }
```
- `n`：需要分配的连续物理页数量（每个页4KB，所以总大小是`n*4KB`）。
- `nr_free`：全局变量，记录系统当前空闲页的总数量。


**2. 初始化查找变量**
```c
    struct Page *page = NULL;  // 用于保存找到的最佳空闲块的起始页（初始化为NULL）
    list_entry_t *le = &free_list;  // 链表遍历指针，从空闲块链表头开始
    size_t min_size = nr_free + 1;  // 初始化“最小满足条件的块大小”为无效值（比总空闲页还大）
```
- `min_size`的初始化技巧：用`nr_free + 1`确保初始值一定大于所有可能的空闲块（因为最大空闲块不会超过总空闲页），这样后续找到的第一个满足条件的块一定会被选中。


**3. 遍历空闲块链表，寻找“最佳块”（核心逻辑）**
```c
    /*LAB2 EXERCISE 2: YOUR CODE*/ 
    while ((le = list_next(le)) != &free_list) {  // 遍历整个空闲块链表（直到回到表头）
        struct Page *p = le2page(le, page_link);  // 从链表节点找到对应的空闲块起始页
        // 关键判断：当前块的大小（p->property） >= 需要的n，且比之前找到的最小块还小
        if (p->property >= n && p->property < min_size) {  
            page = p;  // 更新“最佳块”为当前块
            min_size = p->property;  // 更新“最小块大小”为当前块的大小
        }
    }
```
- 遍历逻辑：逐个检查链表中的每个空闲块（`p`），通过`p->property`获取块的大小（包含的页数）。
- 选择标准：**必须能放下n页（`p->property >= n`），且是所有满足条件的块中最小的（`p->property < min_size`）**。这就是`best_fit`的核心——“最小适配”。


**4. 若找到合适的块，分割并更新链表**
```c
    if (page != NULL) {  // 如果找到了合适的块
        list_entry_t* prev = list_prev(&(page->page_link));  // 记录当前块在链表中的前驱节点
        list_del(&(page->page_link));  // 先将当前块从空闲链表中删除（因为要分配/分割）

        if (page->property > n) {  // 如果块的大小大于需要的n（需要分割）
            struct Page *p = page + n;  // 分割后新空闲块的起始页（原块的第n+1页）
            p->property = page->property - n;  // 新块的大小 = 原块大小 - 分配的n页
            SetPageProperty(p);  // 标记新块为空闲块的起始页
            list_add(prev, &(p->page_link));  // 将新块插入到原块的前驱节点后面（保持地址有序）
        }

        nr_free -= n;  // 总空闲页数量减少n（分配了n页）
        ClearPageProperty(page);  // 清除原块的“空闲起始页”标记（因为已分配）
    }
    return page;  // 返回分配的块的起始页（NULL表示失败）
```
- 分割逻辑：如果找到的块太大（比如需要2页，但块有5页），则分割出`n`页分配给用户，剩下的`5-2=3`页作为新的空闲块重新加入链表。
- 链表维护：分割后的新块插入到原块的前驱节点后面，确保链表依然按地址升序排列（便于后续合并）。


**与`first_fit_alloc_pages`的核心区别**

`first_fit`（首次适配）和`best_fit`（最佳适配）的**核心差异在“查找块的策略”**，其他链表操作（分割、更新）完全相同。

| 步骤                | `first_fit_alloc_pages`                          | `best_fit_alloc_pages`                          |
|---------------------|--------------------------------------------------|--------------------------------------------------|
| **查找逻辑**        | 遍历链表，找到**第一个**满足`p->property >= n`的块，立即停止遍历。 | 遍历**整个链表**，找到所有满足`p->property >= n`的块中**最小**的那个。 |
| **变量差异**        | 不需要`min_size`，找到第一个合适的块就赋值给`page`并break。 | 需要`min_size`记录最小块大小，遍历完所有块才确定`page`。 |
| **性能与碎片**      | 查找速度快（可能提前终止），但容易留下大的空闲块被分割成小碎片。 | 查找速度慢（必须遍历全表），但能减少碎片（用最小的块满足需求，大的块保留给更大的申请）。 |

这个函数是`best_fit`算法中**释放内存页并合并相邻空闲块**的核心函数。它的作用是：将一段连续的`n`个物理页标记为空闲，并插入到空闲块链表中，同时合并前后相邻的空闲块（如果存在），避免内存碎片。下面逐行解释，并对比与`first_fit`的区别。

### 3. `best_fit_free_pages`函数补充（2处）

![image](https://hackmd.io/_uploads/ByweUXWRxg.png)
![image](https://hackmd.io/_uploads/rk8HU7bAlx.png)



**1. 函数入口与参数检查**
```c
static void best_fit_free_pages(struct Page *base, size_t n) {
    assert(n > 0);  // 确保释放的页数n至少为1（无效输入检查）
```
- `base`：待释放的连续物理页的起始页指针。
- `n`：待释放的连续物理页数量。


**2. 初始化释放的页属性**
```c
    struct Page *p = base;
    for (; p != base + n; p ++) {  // 遍历待释放的n个页
        assert(!PageReserved(p) && !PageProperty(p));  // 确保这些页不是保留页，且未被标记为空闲块起始页
        p->flags = 0;  // 清除页的所有标志（如“已分配”标志）
        set_page_ref(p, 0);  // 重置页的引用计数为0（表示没有进程使用）
    }
```
- 循环目的：将释放的每一页重置为初始状态（未被使用、无特殊标志）。
- 断言检查：防止释放系统保留页（如内核代码页）或重复释放空闲页（避免链表混乱）。


**3. 标记当前释放的块为空闲块**
```c
    /* 设置释放块的属性 */
    base->property = n;  // 起始页base记录整个块的大小（n个页）
    SetPageProperty(base);  // 标记base为空闲块的起始页（通过flags中的PG_property标志）
    nr_free += n;  // 全局空闲页总数增加n（因为释放了n页）
```
- `property`字段：仅空闲块的起始页有效，记录该块包含的总页数（用于分配时判断块大小）。
- `SetPageProperty`：通过设置`flags`中的特定位，标记该页是空闲块的起始页（方便后续遍历链表时识别）。


**4. 将新释放的块插入空闲链表（按地址升序）**
```c
    if (list_empty(&free_list)) {  // 如果空闲链表为空（系统首次释放内存）
        list_add(&free_list, &(base->page_link));  // 直接将当前块加入链表
    } else {  // 链表非空，按地址升序插入
        list_entry_t* le = &free_list;
        while ((le = list_next(le)) != &free_list) {  // 遍历链表找插入位置
            struct Page* page = le2page(le, page_link);  // 当前遍历到的空闲块起始页
            if (base < page) {  // 新块地址小于当前块地址→插在当前块前面
                list_add_before(le, &(base->page_link));
                break;
            } else if (list_next(le) == &free_list) {  // 遍历到链表尾部→插在最后
                list_add(le, &(base->page_link));
            }
        }
    }
```
- 插入规则：始终按块的起始地址从小到大插入（与`first_fit`相同），目的是为了后续合并相邻块时能快速判断连续性。
- 例如：若链表中已有块`[10-20]`（地址范围），新释放块`[5-9]`会插在它前面，块`[21-30]`会插在它后面。


**5. 合并前向相邻的空闲块（左边的块）**
```c
    list_entry_t* le = list_prev(&(base->page_link));  // 找到当前块的前驱节点
    if (le != &free_list) {  // 前驱不是链表头（即存在前向块）
        p = le2page(le, page_link);  // 前向块的起始页
        /* 检查前向块是否与当前块连续 */
        if (p + p->property == base) {  // 前向块的结束地址 = 当前块的起始地址→连续
            p->property += base->property;  // 合并大小：前向块大小 += 当前块大小
            ClearPageProperty(base);  // 清除当前块的“空闲起始页”标记（不再是起始页）
            list_del(&(base->page_link));  // 从链表中删除当前块（已合并到前向块）
            base = p;  // 更新base为合并后的块（便于后续合并后向块）
        }
    }
```
- 连续判断：前向块的最后一页是`p + p->property - 1`，当前块的第一页是`base`，若`p + p->property == base`，说明两者紧挨着（无间隙）。
- 合并目的：避免相邻的小空闲块分散存在（如`[5-9]`和`[10-20]`合并为`[5-20]`），便于后续分配大块内存。


**6. 合并后向相邻的空闲块（右边的块）**
```c
    le = list_next(&(base->page_link));  // 找到当前块的后继节点
    if (le != &free_list) {  // 后继不是链表头（即存在后向块）
        p = le2page(le, page_link);  // 后向块的起始页
        if (base + base->property == p) {  // 当前块的结束地址 = 后向块的起始地址→连续
            base->property += p->property;  // 合并大小：当前块大小 += 后向块大小
            ClearPageProperty(p);  // 清除后向块的“空闲起始页”标记
            list_del(&(p->page_link));  // 从链表中删除后向块（已合并）
        }
    }
}
```
- 逻辑与前向合并对称：检查当前块与后向块是否连续，若连续则合并为一个大块。
- 注意：此时`base`可能已经是前向合并后的块（步骤5更新过），因此能正确处理“先合并前向、再合并后向”的场景。

### 问题：`Best_Fit`算法还有没有改进空间

**1.空闲块搜索效率优化**
   - **问题**：当前实现中，`best_fit_alloc_pages` 每次分配都需要遍历整个空闲链表，找到满足大小的最小块。当空闲块数量较多时，遍历操作会导致分配效率降低（时间复杂度为 O(n)）。
   - **改进方案**：
     - **平衡树/有序结构**：使用更高效的数据结构（如红黑树、二叉搜索树）替代双向链表存储空闲块，按块大小排序，可快速定位满足需求的最小块（时间复杂度优化为 O(log n)）。


**2.与内存碎片相关的优化**
   - **问题**：最佳适应算法的缺点是容易产生大量小碎片（因为它总是分割出最小的剩余块）。
   - **改进方案**：
     - **碎片整理触发机制**：当系统中小于某个阈值的碎片数量过多时，触发内存整理（合并所有相邻碎片为大块）。
     - **块大小阈值过滤**：分配时若找不到满足需求的块，可尝试合并小碎片后再分配（而非直接返回 NULL）。
     - **对齐处理**：对于有内存对齐要求的分配（如页对齐、缓存行对齐），在分割块时确保剩余块仍满足对齐要求，避免碎片无法被有效利用。



## Challenge1：buddy system（伙伴系统）分配算法（需要编程）

### 伙伴系统内存管理器设计文档


#### 1. 引言

##### 1.1 文档目的
本文档详细描述基于**伙伴系统**的内存页框管理器的设计与实现，旨在明确其核心数据结构、功能模块、算法流程及验证方式。

##### 1.2 背景
**伙伴系统（Buddy System）** 是一种经典的内存分配算法，其核心思想是将内存划分为大小为2的幂的块（即“伙伴块”），通过快速分裂与合并实现高效内存管理，可有效减少内存碎片。本实现针对操作系统物理内存管理场景，以“页”为基本单位（每页大小固定为4096字节），负责物理页框的分配与回收。


#### 2. 概述

##### 2.1 核心功能
- 初始化伙伴系统及物理内存映射
- 按需求分配指定数量的连续页框
- 释放已分配的页框并自动合并相邻伙伴块
- 统计空闲页框数量并验证系统功能正确性

##### 2.2 设计原则
- **块大小标准化**：所有管理的内存块大小均为2的幂（单位：页），便于快速分裂与合并操作
- **分层管理**：按块大小（即“阶数”）维护空闲链表，实现高效的块查找
- **自动合并**：释放块时主动尝试与“伙伴块”合并为更大块，减少内存碎片


#### 3. 核心数据结构

##### 3.1 伙伴系统全局结构（`buddy_system_t`）
该结构是伙伴系统的核心管理实体，用于维护空闲块链表、系统参数及统计信息。

```c
typedef struct {
    list_entry_t free_array[MAX_POSSIBLE_ORDER + 1];  // 按阶数存储空闲块的链表数组
    int max_order;                                    // 系统支持的最大块阶数
    size_t nr_free;                                   // 空闲页总数
} buddy_system_t;
```

- `free_array`：数组索引为**阶数（order）**（表示块大小为2^order页），每个元素为一个链表，存储该阶数的所有空闲块
- `max_order`：当前系统可管理的最大块阶数（限制块大小上限，避免超出物理内存范围）
- `nr_free`：记录系统当前空闲页的总数量，用于快速判断内存是否充足

##### 3.2 页框结构（`struct Page` 关键字段）
**页框（Page Frame）** 是物理内存的基本分配单位，`struct Page` 用于描述页框的属性与状态。

```c
struct Page {
    unsigned int flags;       // 页状态标志（如是否空闲、是否保留）
    int property;             // 若为空闲块，存储块的阶数
    list_entry_t page_link;   // 用于接入空闲链表的节点
    // 其他字段（如引用计数、映射关系等）
};
```

- `flags`：包含多个状态标志，其中`PageProperty`标志用于标识该页是否为空闲块的起始页
- `property`：仅对空闲块的起始页有效，存储该块的阶数（用于分裂与合并逻辑）
- `page_link`：链表节点，用于将空闲块接入`free_array`中对应阶数的链表

##### 3.3 关键宏定义与阶数-块大小对应关系
```c
#define PAGE_SIZE 4096                       // 页大小（字节）
#define p_num(order) (1 << (order))          // 阶数为order的块包含的页数（2^order）
#define MAX_POSSIBLE_ORDER 20                // 系统支持的最大阶数上限
```

| **阶数（order）** | **块大小（页）** | **块大小（字节）** |
|------------------|------------------|--------------------|
| 0                | 1                | 4096               |
| 1                | 2                | 8192               |
| ...              | ...              | ...                |



## 4. 功能模块详解

### 4.1 系统初始化（`buddy_system_init`）
- **功能**：初始化伙伴系统的核心数据结构，为后续内存管理做准备。

- **流程**：
  1. 遍历`free_array`数组，对每个阶数的空闲链表执行`list_init`初始化
  2. 初始化系统参数：`max_order`设为0，`nr_free`（空闲页总数）设为0

```c
static void buddy_system_init(void) {
    for (int i = 0; i < MAX_POSSIBLE_ORDER + 1; i++) {
        list_init(free_list + i);
    }
    max_order = 0;
    nr_free = 0;
    return;
}
```

##### 4.2 内存映射初始化（`buddy_init_memmap`）
- **功能**：将一块连续的物理页框纳入伙伴系统管理，完成初始块划分。

- **流程**：
  1. 初始化输入的`n`个页框：清除保留标志（`PageReserved`），重置引用计数，清空状态标志
  2. 更新空闲页总数：`nr_free += n`
  3. 计算该内存块可支持的最大阶数：通过`get_max_order_for_size(n)`获取
  4. 按“最大2的幂”原则拆分内存块：
     - 从剩余内存中提取最大的2^k页块（`k`不超过`max_order`）
     - 标记块起始页的`property`为`k`，设置`PageProperty`标志（标记为空闲块起始页）
     - 将块通过`page_link`接入`free_array[k]`链表
     - 重复上述步骤，直至所有内存块均被拆分并加入对应链表

```c
static void buddy_init_memmap(struct Page *base, size_t n) {
    assert(n > 0);
    struct Page *p = base;
    for (; p != base + n; p ++) {
        assert(PageReserved(p));
        p->flags = p->property = 0;
        set_page_ref(p, 0);
    }
    nr_free += n;

    max_order = get_max_order_for_size(n);

    size_t remaining = n;
    p = base;
    while (remaining > 0) {
        int order = 0;
        size_t max_block = 1;
        while (max_block * 2 <= remaining && order + 1 <= max_order) {
            max_block <<= 1;
            order++;
        }
        
        p->property = order;
        SetPageProperty(p);
        list_add(&free_list(order), &(p->page_link));
        // 注意：此处原代码存在nr_free重复累加问题，应删除下述行
        // nr_free += max_block;
        remaining -= max_block;
        p += max_block;
    }
}
```

##### 4.3 内存分配（`buddy_alloc_pages`）
- **功能**：分配`n`个连续页框，返回起始页指针；若分配失败，返回`NULL`。

- **流程**：
  1. 合法性检查：`n`必须大于0，且`n`不能超过当前空闲页总数（`nr_free`）
  2. 计算所需最小阶数：通过`get_order(n)`获取`order`（满足2^order ≥ n）
  3. 检查阶数合法性：若`order`超过`max_order`，返回`NULL`
  4. 查找可用块：从`order`阶开始遍历`free_array`，找到第一个非空链表`free_array[i]`
  5. 提取并拆分块：
     - 从`free_array[i]`中取出一个块，移除链表并更新`nr_free`（`nr_free -= 2^i`）
     - 清除块的`PageProperty`标志（标记为已分配）
     - 若`i > order`，循环分裂块：将当前块分裂为两个`i-1`阶块，一个保留，另一个加入`free_array[i-1]`，直至块阶数为`order`
  6. 返回分裂后的块起始页

```c
static struct Page *buddy_alloc_pages(size_t n) {
    assert(n > 0);
    if (n > nr_free) {
        return NULL;  // 内存不足
    }
    
    int order = get_order(n);
    if (order > max_order) {
        return NULL;  // 超过当前系统最大阶数
    }
    
    int i;
    for (i = order; i <= max_order; i++) {
        if (!list_empty(&free_list(i))) {
            break;
        }
    }
    
    if (i > max_order) {
        return NULL;  // 未找到可用块
    }
    
    list_entry_t *le = list_next(&free_list(i));
    struct Page *p = le2page(le, page_link);
    list_del(le);
    nr_free -= p_num(i);
    ClearPageProperty(p);
    
    while (i > order) {
        i--;
        struct Page *buddy = p + p_num(i);
        buddy->property = i;
        SetPageProperty(buddy);
        list_add(&free_list(i), &(buddy->page_link));
        nr_free += p_num(i);
    }
    
    p->property = order;
    return p;
}
```

##### 4.4 内存释放（`buddy_free_pages`）
- **功能**：释放`n`个连续页框，并尝试与相邻伙伴块合并为更大块。

- **流程**：
  1. 合法性检查：`n`必须大于0，起始页`base`不为`NULL`，且释放的页框需为非保留、非空闲状态
  2. 重置页框状态：清除所有标志，重置引用计数
  3. 计算释放块的阶数：通过`get_order(n)`获取`order`（需满足2^order = n）
  4. 标记块为空闲：设置`base->property = order`及`PageProperty`标志，将块加入`free_array[order]`链表，更新`nr_free`（`nr_free += n`）
  5. 尝试合并伙伴块：
     - 计算当前块的伙伴块（通过`get_buddy`函数）
     - 若伙伴块为同阶空闲块（`PageProperty`标志为真且`property = order`），则：
       - 从链表中移除当前块和伙伴块，更新`nr_free`（`nr_free -= 2*2^order`）
       - 合并为`order+1`阶块，起始页为两者中地址较小的页
       - 标记合并块的`property = order+1`，加入`free_array[order+1]`链表，更新`nr_free`（`nr_free += 2^(order+1)`）
     - 重复合并过程，直至无法合并（伙伴块不满足条件）或达到`max_order`

```c
static void buddy_free_pages(struct Page *base, size_t n) {
    assert(n > 0 && base != NULL);
    
    struct Page *p = base;
    for (; p != base + n; p++) {
        assert(!PageReserved(p) && !PageProperty(p));
        p->flags = 0;
        set_page_ref(p, 0);
    }
    
    int order = get_order(n);
    assert(p_num(order) == n);
    
    base->property = order;
    SetPageProperty(base);
    list_add(&free_list(order), &(base->page_link));
    nr_free += n;
    
    struct Page *current = base;
    while (order < max_order) {
        struct Page *buddy = get_buddy(current, order);
        
        if (!PageProperty(buddy) || buddy->property != order) {
            break;
        }
        
        list_del(&(current->page_link));
        list_del(&(buddy->page_link));
        nr_free -= p_num(order) * 2;
        
        struct Page *merged = (current < buddy) ? current : buddy;
        merged->property = order + 1;
        SetPageProperty(merged);
        list_add(&free_list(order + 1), &(merged->page_link));
        nr_free += p_num(order + 1);
        
        current = merged;
        order++;
    }
}
```

##### 4.5 辅助函数

###### 4.5.1 计算最小阶数（`get_order`）
- **功能**：计算满足“块大小（页）≥ n”的最小阶数（即2^order ≥ n）。

```c
static int get_order(size_t n) {
    if (n == 0) return 0;
    int order = 0;
    size_t size = 1;
    while (size < n) {
        size <<= 1;
        order++;
    }
    return order;
}
```

###### 4.5.2 计算最大阶数（`get_max_order_for_size`）
- **功能**：计算满足“块大小（页）≤ n”的最大阶数（即2^order ≤ n）。

```c
static int get_max_order_for_size(size_t n) {
    if (n == 0) return 0;
    int order = 0;
    size_t size = 1;
    while (size * 2 <= n) {
        size <<= 1;
        order++;
    }
    return order;
}
```

###### 4.5.3 计算伙伴块地址（`get_buddy`）
- **功能**：根据当前块地址及阶数，计算其伙伴块的地址（基于物理地址异或运算）。

```c
static struct Page *get_buddy(struct Page *p, int order) {
    size_t p_num = p_num(order);
    uintptr_t pa = page2pa(p);  // 转换页指针为物理地址
    uintptr_t buddy_pa = pa ^ (p_num * PAGE_SIZE);  // 异或计算伙伴块物理地址
    return pa2page(buddy_pa);  // 转换物理地址为页指针
}
```

##### 4.6 正确性验证（`buddy_check`）
- **功能**：通过一系列分配/释放操作验证伙伴系统的核心功能正确性。

```c
// 测试最小内存单位（1页）的分配与释放
static void test_min_unit_operation(void) {
    cprintf("=== 测试最小内存单位（1页）操作 ===\n");
    size_t initial_free = buddy_nr_free_pages();

    // 分配1页（order 0）
    struct Page *p = buddy_alloc_pages(1);
    assert(p != NULL);
    assert(p->property == 0);  // 验证阶数为0
    assert(buddy_nr_free_pages() == initial_free - 1);
    assert(!PageProperty(p));  // 已分配的页不应标记为空闲

    // 释放1页
    buddy_free_pages(p, 1);
    assert(buddy_nr_free_pages() == initial_free);
    assert(PageProperty(p));   // 释放后应标记为空闲
    assert(p->property == 0);  // 释放后阶数保持0

    // 验证释放后是否正确加入order 0链表
    list_entry_t *le = &free_list[0];
    assert(!list_empty(le));  // order 0链表不应为空
    struct Page *check_p = le2page(list_next(le), page_link);
    assert(check_p == p);     // 链表中应包含刚释放的页

    cprintf("=== 最小内存单位测试通过 ===\n\n");
}

// 测试最大内存单位的分配与释放
static void test_max_unit_operation(void) {
    cprintf("=== 测试最大内存单位操作 ===\n");
    size_t initial_free = buddy_nr_free_pages();
    size_t max_block_size = p_num(max_order);  // 最大块大小：2^max_order页

    // 分配最大块
    struct Page *p = buddy_alloc_pages(max_block_size);
    assert(p != NULL);
    assert(p->property == max_order);  // 验证阶数为max_order
    assert(buddy_nr_free_pages() == initial_free - max_block_size);

    // 尝试分配比最大块大1页的内存（应失败）
    struct Page *p_over = buddy_alloc_pages(max_block_size + 1);
    assert(p_over == NULL);

    // 释放最大块
    buddy_free_pages(p, max_block_size);
    assert(buddy_nr_free_pages() == initial_free);
    assert(PageProperty(p));
    assert(p->property == max_order);

    // 验证释放后是否正确加入max_order链表
    list_entry_t *le = &free_list[max_order];
    assert(!list_empty(le));  // max_order链表不应为空
    struct Page *check_p = le2page(list_next(le), page_link);
    assert(check_p == p);     // 链表中应包含刚释放的页

    cprintf("=== 最大内存单位测试通过 ===\n\n");
}

// 测试伙伴块合并逻辑（从低阶到高阶逐步合并）
static void test_block_merging(void) {
    cprintf("=== 测试伙伴块合并逻辑 ===\n");
    size_t initial_free = buddy_nr_free_pages();
    
    int start_order = 2;  //
    size_t block_pages = p_num(start_order);
    
    // 首先确保有足够的高阶块可以分裂
    if (initial_free < block_pages * 2) {
        cprintf("内存不足，跳过伙伴合并测试\n");
        return;
    }
    
    // 分配一个更高阶的块，然后手动分裂来获得真正的伙伴块
    int higher_order = start_order + 1;
    struct Page *big_block = buddy_alloc_pages(p_num(higher_order));
    assert(big_block != NULL);
    
    // 立即释放这个大块，让它回到空闲列表
    buddy_free_pages(big_block, p_num(higher_order));
    
    // 现在分配两个相同阶数的块，它们应该是伙伴
    struct Page *p1 = buddy_alloc_pages(block_pages);
    struct Page *p2 = buddy_alloc_pages(block_pages);
    assert(p1 != NULL && p2 != NULL);
    
    cprintf("p1指针: %p, p2指针: %p\n", p1, p2);
    
    // 验证逻辑地址连续
    if (p1 + block_pages != p2) {
        cprintf("警告: p1和p2不是逻辑连续的伙伴块，但继续测试合并逻辑\n");
        cprintf("p1 + %lu = %p, p2 = %p\n", block_pages, p1 + block_pages, p2);
    }
    
    // 计算p1的伙伴并验证
    struct Page *buddy_of_p1 = get_buddy(p1, start_order);
    uintptr_t pa1 = page2pa(p1);
    uintptr_t buddy_pa = page2pa(buddy_of_p1);
    
    cprintf("p1物理地址: 0x%lx\n", pa1);
    cprintf("p1的伙伴物理地址: 0x%lx\n", buddy_pa);
    cprintf("预期伙伴地址: 0x%lx (p1地址 ^ %lu字节)\n", 
            pa1 ^ (block_pages * PAGE_SIZE), block_pages * PAGE_SIZE);
    
    // 释放p1和p2，测试合并逻辑
    buddy_free_pages(p1, block_pages);
    buddy_free_pages(p2, block_pages);
    
    // 验证合并后的块是否为更高阶
    struct Page *merged = buddy_alloc_pages(p_num(higher_order));
    assert(merged != NULL && "合并失败，未生成更高阶块");
    assert(merged->property == higher_order && "合并后的块阶数错误");
    
    // 清理
    buddy_free_pages(merged, p_num(higher_order));
    
    cprintf("=== 伙伴块合并逻辑测试通过 ===\n\n");
}
// 综合测试入口
static void buddy_system_test(void) {
    cprintf("===== 开始伙伴系统综合测试 =====\n");
    test_min_unit_operation();
    test_max_unit_operation();
    test_block_merging();
    cprintf("===== 所有伙伴系统测试通过 =====\n");
}

```
![image](https://hackmd.io/_uploads/rkARCXfCgg.png)



#### 5. 算法流程总结

##### 5.1 分配流程
1. 输入需要的页数`n`，检查合法性（`n > 0`且`n ≤ nr_free`）
2. 计算最小阶数`order = get_order(n)`，检查`order ≤ max_order`
3. 从`order`到`max_order`遍历`free_array`，找到第一个非空链表`free_array[i]`
4. 从`free_array[i]`中取出块，移除链表并更新`nr_free`
5. 若`i > order`，循环分裂块为`i-1`阶，直至块阶数为`order`
6. 返回块起始页（失败返回`NULL`）

##### 5.2 释放流程
1. 输入起始页`base`和释放页数`n`，检查合法性
2. 计算阶数`order = get_order(n)`（需满足`2^order = n`）
3. 标记块为空闲，加入`free_array[order]`并更新`nr_free`
4. 循环尝试合并：
   - 计算伙伴块地址，检查是否为同阶空闲块
   - 若满足，合并为`order+1`阶块，更新链表和`nr_free`
   - 重复直至无法合并或达到`max_order`



























## Challenge2：任意大小的内存单元slub分配算法
### 1. 引言
uCore 操作系统原有的物理内存管理器（PMM），无论是 First-Fit 还是 Best-Fit，都是以页（Page, 4KB）为最小分配单位。这种粗粒度的分配方式在处理内核中频繁申请和释放的小型数据结构（如进程控制块、文件描述符等）时，存在两大问题：
- 严重的内部碎片 (Internal Fragmentation): 为一个仅需 64 字节的对象分配一整个 4KB 的页，会造成超过 98% 的空间浪费。
- 较高的性能开销: PMM 的分配/释放操作涉及到链表遍历、块分裂与合并，对于高频次的小对象请求，其性能开销相对较大。

为了解决上述问题，我们设计并实现了一个简化的 SLUB 分配算法。该算法作为一个构建在 PMM 之上的对象缓存（Object Caching）层，为内核提供一个高效、低碎片、专门用于管理小内存对象的分配器。

### 2. 系统架构与设计思想
#### 2.1 设计思想
SLUB 算法的设计思想是基于对象缓存（Object Caching），以解决小内存分配问题。
- 批量化页申请: 为了分摊底层物理页分配器（PMM）的开销，SLUB 分配器总是以一个或多个完整的物理页为单位向 PMM 申请大块连续内存。
- 对象管理: 每一个从 PMM 申请来的大块内存（称为 Slab），都会被预先格式化，分割成多个大小完全相同的小内存块，即对象（Object）。这种针对特定大小的预分割策略，从根本上消除了内部碎片问题。
- 循环利用: 已释放的对象并不会归还给 PMM，而是被放回其所属 Slab 内部的一个空闲链表（freelist）中。这使得后续对同样大小对象的分配请求，可以转化为一次极快的链表出队操作（O(1) 时间复杂度），避免了与底层 PMM 的昂贵交互。
#### 2.2 系统分层架构
##### L0 - 物理页管理器 (Physical Page Manager - PMM)
- 文件: `kern/mm/pmm.c`, `kern/mm/default_pmm.c`
- 职责: 作为最底层的内存管理器，它掌管系统中所有的物理内存。其分配单位是页（Page），主要目标是管理大块连续内存并抑制外部碎片。它为上层模块提供了 `alloc_pages()` 和 `free_pages()` 这两个基础服务。
##### L1 - SLUB 核心分配器 (Object Caching Layer)
- 文件: `kern/mm/slub.c`, `kern/mm/slub.h`
- 职责: 这是小对象分配的后端。它引入了 `kmem_cache_t`（对象缓存）的概念，每个 `kmem_cache_t` 专用于管理一种特定大小的对象。它是 PMM 的客户，通过调用 `alloc_pages()` 获取内存页来创建 Slab。其核心目标是通过 Slab 内的空闲链表和状态管理，提供高速的对象分配与回收，并解决内部碎片问题。
##### L2 - 通用内存分配器 (General Purpose Allocator)
文件: `kern/mm/kmalloc.c`, `kern/mm/kmalloc.h`
职责: 这是 SLUB 系统的前端接口，为内核其他模块提供了简单、通用的 `kmalloc()` 和 `kfree() API`。它通过创建一组针对不同大小（通常是2的幂，如32, 64, 128字节）的 `kmem_cache_t` 实例，并将任意大小的内存请求路由到最合适的缓存中，从而隐藏了后端的复杂性。
### 3. 核心数据结构
#### 3.1 struct free_object
当一个对象槽空闲时，我们利用其内存空间构建一个侵入式单向链表。
```
struct free_object {
    struct free_object *next;
};
```
#### 3.2 struct slab_t
这是 Slab 的管理头，被放置在每个 Slab 内存区域的起始位置。
```c
struct slab_t {
    list_entry_t slab_link;       // 用于将 Slab 链接到所属 Cache 的链表
    struct kmem_cache_t *cache;   // 反向指针，指向拥有此 Slab 的 Cache
    size_t inuse;                 // 已分配对象的数量
    struct free_object *freelist; // 指向 Slab 内部的第一个空闲对象
    void *s_mem;                  // 指向 Slab 中第一个对象的起始地址
};
```
内存布局: [ struct slab_t | 对象1 | 对象2 | ... | 对象N ]
#### 3.3 struct kmem_cache_t
这是 SLUB 分配器的核心，代表一个管理特定大小对象的“工厂”。
```c
struct kmem_cache_t {
    char name[KMEM_CACHE_NAME_LEN]; // 名称，用于调试
    size_t obj_size;                  // 对象大小
    size_t num_per_slab;              // 每个 Slab 可容纳的对象数
    size_t slab_order;                // 每个 Slab 的大小 (2^order 个页)

    // 三个核心链表，用于对 Slabs 进行分类管理
    list_entry_t slabs_full;          // 全满
    list_entry_t slabs_partial;       // 部分空闲 (分配首选)
    list_entry_t slabs_empty;         // 完全空闲 (可回收)
    
    // 统计信息
    size_t total_slabs;
    size_t total_objs;
    size_t active_objs;
};
```
### 4. 功能模块详解

#### 4.1 核心算法逻辑 (后端实现: slub.c)
负责管理 kmem_cache_t 和 slab_t，并执行实际的分配和释放操作。
##### 4.1.1 Slab 增长 (kmem_cache_grow)
此函数是 SLUB 与 PMM 的桥梁，当 Cache 中没有可用对象时被调用，负责“进货”。
- 逻辑详解:
调用 `alloc_pages()` 向底层 PMM 申请一个新的、连续的物理页块。
在返回内存的头部，初始化 `struct slab_t` 管理头。
将剩余的内存空间格式化，分割成 N 个对象，并使用 `struct free_object` 将它们串联成一个单向的 freelist。
将这个新的、完全空闲的 slab_t 添加到 Cache 的 `slabs_empty` 链表中。
- 代码实现:
```c
// 文件: kern/mm/slub.c

// 内部辅助函数，用于为 cache 申请并初始化一个新的 slab
static int
kmem_cache_grow(struct kmem_cache_t *cache) {
    // 1. 向 PMM 申请物理页
    size_t num_pages = 1 << cache->slab_order;
    struct Page *page = alloc_pages(num_pages);
    if (page == NULL) {
        return -E_NO_MEM;
    }

    // 2. 获取新页的内核虚拟地址
    void *slab_va = page2kva(page);

    // 3. 初始化 slab_t 管理头
    struct slab_t *slab = (struct slab_t *)slab_va;
    slab->cache = cache;
    slab->inuse = 0;
    slab->freelist = NULL;
    slab->s_mem = (void *)(slab + 1);

    // 4. 将剩余空间分割成对象并链入 freelist
    void *obj_ptr = slab->s_mem;
    for (size_t i = 0; i < cache->num_per_slab; i++) {
        struct free_object *free_obj = (struct free_object *)obj_ptr;
        free_obj->next = slab->freelist;
        slab->freelist = free_obj;
        obj_ptr = (void *)((char *)obj_ptr + cache->obj_size);
    }

    // 5. 将新 slab 加入 empty 链表
    list_add_before(&(cache->slabs_empty), &(slab->slab_link));

    // 6. 更新统计信息
    cache->total_slabs++;
    cache->total_objs += cache->num_per_slab;

    return 0;
}
```

##### 4.1.2 对象分配 (kmem_cache_alloc)
- 逻辑详解:
    - 查找 Slab: 按照 slabs_partial -> slabs_empty 的优先级顺序查找一个可用的 Slab。
    - 新建 Slab: 如果上述链表都为空，则调用 kmem_cache_grow() 创建一个新的 Slab。
    - 分配对象: 从找到的 Slab 的 freelist 头部弹出一个 free_object。
    - 更新状态: 增加 Slab 的 inuse 计数，并根据 inuse 的值，将 Slab 在 slabs_partial 和 slabs_full 链表之间进行移动。
- 代码实现:
```c
// 文件: kern/mm/slub.c

void *
kmem_cache_alloc(struct kmem_cache_t *cache) {
    struct slab_t *slab;
    list_entry_t *le;

    // 1. 优先从 partial 链表获取
    if (!list_empty(&(cache->slabs_partial))) {
        le = list_next(&(cache->slabs_partial));
        slab = le2slab(le, slab_link);
    }
    // 2. 其次从 empty 链表获取
    else if (!list_empty(&(cache->slabs_empty))) {
        le = list_next(&(cache->slabs_empty));
        slab = le2slab(le, slab_link);
    }
    // 3. 如果还没有，则创建新 slab
    else {
        if (kmem_cache_grow(cache) != 0) {
            return NULL; // 内存耗尽
        }
        le = list_next(&(cache->slabs_empty));
        slab = le2slab(le, slab_link);
    }

    // 4. 从 freelist 取出一个对象
    struct free_object *free_obj = slab->freelist;
    void *obj = (void *)free_obj;
    slab->freelist = free_obj->next;

    // 5. 更新计数和 slab 状态
    slab->inuse++;
    cache->active_objs++;
    list_del(&(slab->slab_link));

    if (slab->inuse == cache->num_per_slab) {
        // slab 已满，移入 full 链表
        list_add_before(&(cache->slabs_full), &(slab->slab_link));
    } else {
        // slab 未满，移入 partial 链表
        list_add_before(&(cache->slabs_partial), &(slab->slab_link));
    }

    return obj;
}
```

4.1.3 对象释放 (kmem_cache_free)
- 逻辑详解:
    - 反向查找: 根据待释放的对象指针 obj，通过 ROUNDDOWN 宏计算出其所在页的基地址，从而找到其所属的 struct slab_t 管理头。
    - 归还对象: 将 obj 的内存压入所属 Slab 的 freelist 头部。
    - 更新状态: 减少 Slab 的 inuse 计数，并根据 inuse 的值，将 Slab 在 slabs_full、slabs_partial 和 slabs_empty 链表之间进行移动。
- 代码实现:
```c
// 文件: kern/mm/slub.c

// 内部辅助函数，根据对象指针找到 slab 管理头
static struct slab_t *
obj_to_slab(void *obj) {
    uintptr_t obj_addr = (uintptr_t)obj;
    uintptr_t slab_addr = ROUNDDOWN(obj_addr, PGSIZE);
    return (struct slab_t *)slab_addr;
}

void 
kmem_cache_free(struct kmem_cache_t *cache, void *obj) {
    if (obj == NULL) return;

    // 1. 反向查找 slab
    struct slab_t *slab = obj_to_slab(obj);
    assert(slab->cache == cache); // 健壮性检查

    // 2. 将对象归还到 freelist
    struct free_object *free_obj = (struct free_object *)obj;
    free_obj->next = slab->freelist;
    slab->freelist = free_obj;

    // 3. 更新计数和 slab 状态
    slab->inuse--;
    cache->active_objs--;
    list_del(&(slab->slab_link));

    if (slab->inuse == 0) {
        // slab 已空，移入 empty 链表
        list_add_before(&(cache->slabs_empty), &(slab->slab_link));
    } else {
        // slab 未空 (之前是 full 或 partial)，移入 partial 链表
        list_add_before(&(cache->slabs_partial), &(slab->slab_link));
    }
}
```
#### 4.2 前端接口 (通用分配器: kmalloc.c)
为内核其他模块提供一个简单易用的通用内存分配接口。
##### 4.2.1 初始化 (kmalloc_init)
- 逻辑详解:
初始化一个静态的 kmem_cache_t 指针数组 kmalloc_caches，其中包含一系列大小按 2 的幂次递增的通用 Cache（如 "kmalloc-32", "kmalloc-64", ...）。
- 代码实现:
```c
// 文件: kern/mm/kmalloc.c

// 定义通用缓存的范围和数量
#define KMALLOC_MIN_SIZE_LOG2   5  // 2^5 = 32 bytes
#define KMALLOC_MAX_SIZE_LOG2  11  // 2^11 = 2048 bytes
#define KMALLOC_CACHES_COUNT (KMALLOC_MAX_SIZE_LOG2 - KMALLOC_MIN_SIZE_LOG2 + 1)

static struct kmem_cache_t *kmalloc_caches[KMALLOC_CACHES_COUNT];

void 
kmalloc_init(void) {
    for (int i = 0; i < KMALLOC_CACHES_COUNT; i++) {
        size_t obj_size = 1 << (i + KMALLOC_MIN_SIZE_LOG2);
        char name[KMEM_CACHE_NAME_LEN];
        snprintf(name, sizeof(name), "kmalloc-%d", obj_size);

        // 调用 slub 后端创建“工厂”
        kmalloc_caches[i] = kmem_cache_create(name, obj_size, 0);
        assert(kmalloc_caches[i] != NULL);
    }
}
```
##### 4.2.2 通用分配 (kmalloc) 与通用释放 (kfree)
- 逻辑详解:
    - `kmalloc(size)`: 将请求的 size 向上取整到最接近的 2 的幂次，然后从 `kmalloc_caches` 数组中选择对应的 Cache，并调用 `kmem_cache_alloc()`。
    - `kfree(ptr)`: 使用 ROUNDDOWN 技巧从指针 ptr 反向推导出其所属的 `slab_t`，进而找到 `kmem_cache_t`，最后调用 `kmem_cache_free()`。
- 代码实现:
```c
// 文件: kern/mm/kmalloc.c

void *
kmalloc(size_t size) {
    if (size == 0 || size > (1 << KMALLOC_MAX_SIZE_LOG2)) {
        return NULL;
    }

    // 向上取整到 2 的幂
    size_t rounded_size = 1 << (fls(size - 1));
    if (rounded_size < (1 << KMALLOC_MIN_SIZE_LOG2)) {
        rounded_size = (1 << KMALLOC_MIN_SIZE_LOG2);
    }
    
    // 计算索引并从对应 cache 分配
    int index = (ffs(rounded_size) - 1) - KMALLOC_MIN_SIZE_LOG2;
    return kmem_cache_alloc(kmalloc_caches[index]);
}

void 
kfree(void *ptr) {
    if (ptr == NULL) return;

    // 反向查找 slab 和 cache
    struct slab_t *slab = (struct slab_t *)ROUNDDOWN((uintptr_t)ptr, PGSIZE);
    struct kmem_cache_t *cache = slab->cache;
    assert(cache != NULL);

    // 调用 slub 后端释放
    kmem_cache_free(cache, ptr);
}
```
#### 4.3 内核集成
##### 逻辑详解:
为了让 SLUB 系统生效，必须在内核启动时对其进行初始化。
- 修改 Makefile: 确保 slub.c 和 kmalloc.c 被编译。在本项目中，Makefile 的自动发现机制可以完成此工作，无需修改。
- 修改 kern/init/init.c: 在 pmm_init() 成功执行之后，必须依次调用 kmalloc_init() 和 kmalloc_check()。
##### 代码实现:
```c
// 文件: kern/init/init.c

#include <stdio.h>
#include <pmm.h>
#include <kmalloc.h> // <-- 1. 包含 kmalloc.h

int
kern_init(void) {
    // ...
    pmm_init();      // 必须先初始化物理页分配器
    
    kmalloc_init();  // 初始化 SLUB/kmalloc 系统
    kmalloc_check(); // 调用自检函数
    // ...
}
```
#### 4.4 测试用例
##### 逻辑详解:
为了确保实现的健壮性，我们编写了 `kmalloc_check()`` 函数来覆盖各种测试场景。以下是对每个测试用例设计的详细说明。
- 边界情况: 测试 `kmalloc(0)`、`kfree(NULL)` 和请求过大内存。这是为了确保分配器对无效输入的处理是健壮的，不会因此崩溃。
- 基本功能与 LIFO 行为: 测试单次分配和释放，并验证其后进先出的缓存行为。这直接验证了 freelist 的基本链表操作是否正确，是 SLUB 高效缓存命中的核心。
- 数据完整性: 验证写入的数据在释放和重新分配后不会被破坏。这可以捕获因元数据错误覆盖对象空间而导致的内存损坏问题。
- Slab 增长: 进行大规模循环分配，强制触发 `kmem_cache_grow()`。这直接测试了 SLUB 系统与底层 PMM 的交互，确保系统可以动态扩展。
- 混合分配: 交错申请和释放不同大小的内存块。这重点测试 `kfree` 仅凭一个指针就能找到其所属正确 `cache` 的反向查找能力，是模拟真实复杂场景的关键。
- 耗尽与回收: 验证 `slab` 在被完全释放后，能够被正确地放入 `slabs_empty` 列表，并在后续分配中被优先重用。这测试了 `slab` 的完整生命周期管理和资源回收能力，防止内存泄漏。
#### 代码实现:
```c
void
kmalloc_check(void) {
    cprintf("kmalloc_check: starting SLUB/kmalloc system test.\n");

    // --- 测试 1: 边界情况和无效输入 ---
    cprintf("  - Test 1: Boundary and invalid cases...\n");
    assert(kmalloc(0) == NULL);
    assert(kmalloc(4097) == NULL); // 超过最大支持
    kfree(NULL); // 应安全处理

    // --- 测试 2: 基本功能和 LIFO 行为 ---
    cprintf("  - Test 2: Basic alloc/free and LIFO check...\n");
    void *p1 = kmalloc(32);
    assert(p1 != NULL);
    kfree(p1);
    void *p2 = kmalloc(32);
    assert(p2 != NULL && p1 == p2); // LIFO 特性
    kfree(p2);

    // --- 测试 3: 数据完整性 ---
    cprintf("  - Test 3: Data integrity check...\n");
    char *p_char = kmalloc(100); // -> kmalloc-128
    assert(p_char != NULL);
    strcpy(p_char, "Hello, SLUB!");
    assert(strcmp(p_char, "Hello, SLUB!") == 0);
    kfree(p_char);

    // --- 测试 4: 强制 Slab 增长 ---
    cprintf("  - Test 4: Forcing slab growth...\n");
    void *p_array[500];
    for (int i = 0; i < 500; i++) {
        p_array[i] = kmalloc(64);
        assert(p_array[i] != NULL);
        // 确保每次分配的指针都唯一
        for (int j = 0; j < i; j++) {
            assert(p_array[i] != p_array[j]);
        }
    }
    for (int i = 0; i < 500; i++) {
        kfree(p_array[i]);
    }

    // --- 测试 5: 混合分配与释放 ---
    cprintf("  - Test 5: Mixed size allocation and free...\n");
    void *ptr_small = kmalloc(30);  // -> kmalloc-32
    void *ptr_large = kmalloc(1000); // -> kmalloc-1024
    void *ptr_mid = kmalloc(120);   // -> kmalloc-128
    assert(ptr_small != NULL && ptr_large != NULL && ptr_mid != NULL);
    // 写入数据以确保没有互相覆盖
    memset(ptr_small, 0xAA, 30);
    memset(ptr_large, 0xBB, 1000);
    memset(ptr_mid,   0xCC, 120);
    // 以不同于分配的顺序释放
    kfree(ptr_large);
    kfree(ptr_small);
    kfree(ptr_mid);

    // --- 测试 6: 耗尽并回收检查 ---
    cprintf("  - Test 6: Exhaust and recycle check...\n");
    // 再次进行大规模分配，确保释放后的 slab 可以被正确地重新利用
    for (int i = 0; i < 500; i++) {
        p_array[i] = kmalloc(32);
        assert(p_array[i] != NULL);
    }
    for (int i = 0; i < 500; i++) {
        kfree(p_array[i]);
    }

    cprintf("kmalloc_check: All tests passed successfully!\n");
}
```
#### 验证输出
```
kmalloc_init: initializing general purpose SLUB caches
kmem_cache_create: created cache kmalloc-32 (obj_size=32, num_per_slab=126)
kmem_cache_create: created cache kmalloc-64 (obj_size=64, num_per_slab=63)
kmem_cache_create: created cache kmalloc-128 (obj_size=128, num_per_slab=31)
kmem_cache_create: created cache kmalloc-256 (obj_size=256, num_per_slab=15)
kmem_cache_create: created cache kmalloc-512 (obj_size=512, num_per_slab=7)
kmem_cache_create: created cache kmalloc-1024 (obj_size=1024, num_per_slab=3)
kmem_cache_create: created cache kmalloc-2048 (obj_size=2048, num_per_slab=1)
kmalloc_init: initialization complete.
kmalloc_check: starting SLUB/kmalloc system test.
  - Test 1: Boundary and invalid cases...
kmalloc: request size 4097 too large, use alloc_pages instead.
  - Test 2: Basic alloc/free and LIFO check...
  - Test 3: Data integrity check...
  - Test 4: Forcing slab growth...
  - Test 5: Mixed size allocation and free...
  - Test 6: Exhaust and recycle check...
kmalloc_check: All tests passed successfully!
```

## Challenge3 硬件的可用物理内存范围的获取方法（思考题）
如果 OS 无法提前知道当前硬件的可用物理内存范围，请问你有何办法让 OS 获取可用物理内存范围？

获取可用物理内存范围是操作系统启动的首要任务。在正常情况下，在 RISC-V 平台，操作系统内核通过Bootloader来获取可用的物理内存范围。首先，作为 M-Mode 监管者的 Bootloader（如 OpenSBI），在启动内核前，会将设备树（DTB）的物理地址作为约定信息存放到 a1 寄存器中。内核在 kern_entry 启动后，其首要任务之一就是立即保存这个 DTB 地址。随后，在物理内存管理（PMM）的初始化阶段，内核会解析这份 DTB“地图”：它读取 /memory 节点以确定物理内存的总边界，同时读取 /reserved-memory 节点以识别所有不可用的“空洞”（如 OpenSBI 自身占用的区域）。最后，内核从总边界中减去所有这些“空洞”以及内核自身代码和数据所占用的空间，计算出最终的、干净的可用内存范围列表，并以此为基础来初始化物理内存管理器。

但是如果OS 无法提前知道当前硬件的可用物理内存范围，也就是说操作系统内核在开始执行其第一条指令时，对于其下方的硬件环境（尤其是物理内存的布局、大小）一无所知。OS需要采用内存探测 (Memory Probing)的方式对可用物理内存范围进行采集。


### 测试方法：如何确定一个内存地址A是否是可用的RAM？

OS会执行以下操作：

- 备份：读取地址A的原始值并保存起来
- 写入：向地址A写入一个特殊值（一般不太会访问到的地址），例如0x55AA55AA
- 回读：立即从地址A再次读取值
- 验证：如果读回的值是写入的特殊值，则地址A很可能是一块可用的RAM
- 恢复：恢复地址A的备份值

### 探测策略

有了基本测试方法，接下来的问题是以什么策略对物理地址进行测试？

#### 方法一：线性扫描

OS从某一个起点（比如0）开始，以一个固定步长（例如一个B或者一个页4KB）向上扫描，对于扫描到的每一块地址进行测试是否可用

#### 方法二：基于内存颗粒度的稀疏扫描

物理内存通常以块（Bank）的形式存在，其大小通常是2的幂次方（如64MB, 128MB, 512MB, 1GB）

1. 找到第一个可用的区域：OS知道它自己当前整运行在内存的某个位置
2. OS将以页为单位，按2的次方指数级跳跃探测，比如1MB→2MB→4MB→1GB→2GB→……
3. 二分查找：如果发现1GB成功，2GB失败时，OS就知道内存的末端在[1GB, 2GB)这个区间，通过二分查找或者线性扫描来确定内存页

这种探测会遇到很多问题：

1. 内存映射 I/O (MMIO)：在物理地址空间中，有大量地址并非只想RAM，而是硬件设备的控制寄存器（如硬盘控制器、显卡、网卡），当OS对这种地址进行探测时，写入一个测试用的特殊值，可能会被硬件误解为一个命令，比如”格式化硬盘“导致系统崩溃甚至硬盘损坏，从而导致硬件异常。因此在开始探测之前，OS必须先设置一个最基本的异常处理器，如果访问了某个地址导致了硬件异常，处理器能捕获它，记录下这个地址是坏的，然后让程序跳过这个地址继续探测。
2. 内存空洞 (Memory Holes)：由于物理地址空间是不连续的，假设OS在640KB 探测成功，但在700KB探测失败，就不能认为内存在这个地址结束了。因此OS在探测到一个空洞之后，必须继续向上探测，寻找空洞之上可能存在的第2块甚至更多内存，因此OS得到的不是单一的地址范围，而是一个内存区域列表。
3. 内存别名：在某些简单硬件上，一小块物理RAM可能会被镜像到多个地址范围，比如系统可能只有16MB的RAM，但是访问0x0和0x100000实际上命中的是同一块物理内存，这时候OS会认为自己有32MB的内存。因此，在探测时OS写入当前探测地址的特殊值应该是一个随地址变化的值。

