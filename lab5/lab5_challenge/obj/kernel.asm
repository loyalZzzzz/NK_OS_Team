
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
    .globl kern_entry
kern_entry:
    # a0: hartid
    # a1: dtb physical address
    # save hartid and dtb address
    la t0, boot_hartid
ffffffffc0200000:	0000b297          	auipc	t0,0xb
ffffffffc0200004:	00028293          	mv	t0,t0
    sd a0, 0(t0)
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc020b000 <boot_hartid>
    la t0, boot_dtb
ffffffffc020000c:	0000b297          	auipc	t0,0xb
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc020b008 <boot_dtb>
    sd a1, 0(t0)
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)
    # t0 := 三级页表的虚拟地址
    lui     t0, %hi(boot_page_table_sv39)
ffffffffc0200018:	c020a2b7          	lui	t0,0xc020a
    # t1 := 0xffffffff40000000 即虚实映射偏移量
    li      t1, 0xffffffffc0000000 - 0x80000000
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
    # t0 减去虚实映射偏移量 0xffffffff40000000，变为三级页表的物理地址
    sub     t0, t0, t1
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
    # t0 >>= 12，变为三级页表的物理页号
    srli    t0, t0, 12
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc

    # t1 := 8 << 60，设置 satp 的 MODE 字段为 Sv39
    li      t1, 8 << 60
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
    # 将刚才计算出的预设三级页表物理页号附加到 satp 中
    or      t0, t0, t1
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
    # 将算出的 t0(即新的MODE|页表基址物理页号) 覆盖到 satp 中
    csrw    satp, t0
ffffffffc0200034:	18029073          	csrw	satp,t0
    # 使用 sfence.vma 指令刷新 TLB
    sfence.vma
ffffffffc0200038:	12000073          	sfence.vma
    # 从此，我们给内核搭建出了一个完美的虚拟内存空间！
    #nop # 可能映射的位置有些bug。。插入一个nop
    
    # 我们在虚拟内存空间中：随意将 sp 设置为虚拟地址！
    lui sp, %hi(bootstacktop)
ffffffffc020003c:	c020a137          	lui	sp,0xc020a

    # 我们在虚拟内存空间中：随意跳转到虚拟地址！
    # 跳转到 kern_init
    lui t0, %hi(kern_init)
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
    addi t0, t0, %lo(kern_init)
ffffffffc0200044:	04a28293          	addi	t0,t0,74 # ffffffffc020004a <kern_init>
    jr t0
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <kern_init>:
void grade_backtrace(void);

int kern_init(void)
{
    extern char edata[], end[];
    memset(edata, 0, end - edata);
ffffffffc020004a:	000b1517          	auipc	a0,0xb1
ffffffffc020004e:	2d650513          	addi	a0,a0,726 # ffffffffc02b1320 <buf>
ffffffffc0200052:	000b5617          	auipc	a2,0xb5
ffffffffc0200056:	77a60613          	addi	a2,a2,1914 # ffffffffc02b57cc <end>
{
ffffffffc020005a:	1141                	addi	sp,sp,-16
    memset(edata, 0, end - edata);
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
{
ffffffffc0200060:	e406                	sd	ra,8(sp)
    memset(edata, 0, end - edata);
ffffffffc0200062:	642050ef          	jal	ra,ffffffffc02056a4 <memset>
    dtb_init();
ffffffffc0200066:	598000ef          	jal	ra,ffffffffc02005fe <dtb_init>
    cons_init(); // init the console
ffffffffc020006a:	522000ef          	jal	ra,ffffffffc020058c <cons_init>

    const char *message = "(THU.CST) os is loading ...";
    cprintf("%s\n\n", message);
ffffffffc020006e:	00005597          	auipc	a1,0x5
ffffffffc0200072:	66258593          	addi	a1,a1,1634 # ffffffffc02056d0 <etext+0x2>
ffffffffc0200076:	00005517          	auipc	a0,0x5
ffffffffc020007a:	67a50513          	addi	a0,a0,1658 # ffffffffc02056f0 <etext+0x22>
ffffffffc020007e:	116000ef          	jal	ra,ffffffffc0200194 <cprintf>

    print_kerninfo();
ffffffffc0200082:	19a000ef          	jal	ra,ffffffffc020021c <print_kerninfo>

    // grade_backtrace();

    pmm_init(); // init physical memory management
ffffffffc0200086:	6c8020ef          	jal	ra,ffffffffc020274e <pmm_init>

    pic_init(); // init interrupt controller
ffffffffc020008a:	131000ef          	jal	ra,ffffffffc02009ba <pic_init>
    idt_init(); // init interrupt descriptor table
ffffffffc020008e:	12f000ef          	jal	ra,ffffffffc02009bc <idt_init>

    vmm_init();  // init virtual memory management
ffffffffc0200092:	195030ef          	jal	ra,ffffffffc0203a26 <vmm_init>
    proc_init(); // init process table
ffffffffc0200096:	561040ef          	jal	ra,ffffffffc0204df6 <proc_init>

    clock_init();  // init clock interrupt
ffffffffc020009a:	4a0000ef          	jal	ra,ffffffffc020053a <clock_init>
    intr_enable(); // enable irq interrupt
ffffffffc020009e:	111000ef          	jal	ra,ffffffffc02009ae <intr_enable>

    cpu_idle(); // run idle process
ffffffffc02000a2:	6ed040ef          	jal	ra,ffffffffc0204f8e <cpu_idle>

ffffffffc02000a6 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
ffffffffc02000a6:	715d                	addi	sp,sp,-80
ffffffffc02000a8:	e486                	sd	ra,72(sp)
ffffffffc02000aa:	e0a6                	sd	s1,64(sp)
ffffffffc02000ac:	fc4a                	sd	s2,56(sp)
ffffffffc02000ae:	f84e                	sd	s3,48(sp)
ffffffffc02000b0:	f452                	sd	s4,40(sp)
ffffffffc02000b2:	f056                	sd	s5,32(sp)
ffffffffc02000b4:	ec5a                	sd	s6,24(sp)
ffffffffc02000b6:	e85e                	sd	s7,16(sp)
    if (prompt != NULL) {
ffffffffc02000b8:	c901                	beqz	a0,ffffffffc02000c8 <readline+0x22>
ffffffffc02000ba:	85aa                	mv	a1,a0
        cprintf("%s", prompt);
ffffffffc02000bc:	00005517          	auipc	a0,0x5
ffffffffc02000c0:	63c50513          	addi	a0,a0,1596 # ffffffffc02056f8 <etext+0x2a>
ffffffffc02000c4:	0d0000ef          	jal	ra,ffffffffc0200194 <cprintf>
readline(const char *prompt) {
ffffffffc02000c8:	4481                	li	s1,0
    while (1) {
        c = getchar();
        if (c < 0) {
            return NULL;
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000ca:	497d                	li	s2,31
            cputchar(c);
            buf[i ++] = c;
        }
        else if (c == '\b' && i > 0) {
ffffffffc02000cc:	49a1                	li	s3,8
            cputchar(c);
            i --;
        }
        else if (c == '\n' || c == '\r') {
ffffffffc02000ce:	4aa9                	li	s5,10
ffffffffc02000d0:	4b35                	li	s6,13
            buf[i ++] = c;
ffffffffc02000d2:	000b1b97          	auipc	s7,0xb1
ffffffffc02000d6:	24eb8b93          	addi	s7,s7,590 # ffffffffc02b1320 <buf>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000da:	3fe00a13          	li	s4,1022
        c = getchar();
ffffffffc02000de:	12e000ef          	jal	ra,ffffffffc020020c <getchar>
        if (c < 0) {
ffffffffc02000e2:	00054a63          	bltz	a0,ffffffffc02000f6 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc02000e6:	00a95a63          	bge	s2,a0,ffffffffc02000fa <readline+0x54>
ffffffffc02000ea:	029a5263          	bge	s4,s1,ffffffffc020010e <readline+0x68>
        c = getchar();
ffffffffc02000ee:	11e000ef          	jal	ra,ffffffffc020020c <getchar>
        if (c < 0) {
ffffffffc02000f2:	fe055ae3          	bgez	a0,ffffffffc02000e6 <readline+0x40>
            return NULL;
ffffffffc02000f6:	4501                	li	a0,0
ffffffffc02000f8:	a091                	j	ffffffffc020013c <readline+0x96>
        else if (c == '\b' && i > 0) {
ffffffffc02000fa:	03351463          	bne	a0,s3,ffffffffc0200122 <readline+0x7c>
ffffffffc02000fe:	e8a9                	bnez	s1,ffffffffc0200150 <readline+0xaa>
        c = getchar();
ffffffffc0200100:	10c000ef          	jal	ra,ffffffffc020020c <getchar>
        if (c < 0) {
ffffffffc0200104:	fe0549e3          	bltz	a0,ffffffffc02000f6 <readline+0x50>
        else if (c >= ' ' && i < BUFSIZE - 1) {
ffffffffc0200108:	fea959e3          	bge	s2,a0,ffffffffc02000fa <readline+0x54>
ffffffffc020010c:	4481                	li	s1,0
            cputchar(c);
ffffffffc020010e:	e42a                	sd	a0,8(sp)
ffffffffc0200110:	0ba000ef          	jal	ra,ffffffffc02001ca <cputchar>
            buf[i ++] = c;
ffffffffc0200114:	6522                	ld	a0,8(sp)
ffffffffc0200116:	009b87b3          	add	a5,s7,s1
ffffffffc020011a:	2485                	addiw	s1,s1,1
ffffffffc020011c:	00a78023          	sb	a0,0(a5)
ffffffffc0200120:	bf7d                	j	ffffffffc02000de <readline+0x38>
        else if (c == '\n' || c == '\r') {
ffffffffc0200122:	01550463          	beq	a0,s5,ffffffffc020012a <readline+0x84>
ffffffffc0200126:	fb651ce3          	bne	a0,s6,ffffffffc02000de <readline+0x38>
            cputchar(c);
ffffffffc020012a:	0a0000ef          	jal	ra,ffffffffc02001ca <cputchar>
            buf[i] = '\0';
ffffffffc020012e:	000b1517          	auipc	a0,0xb1
ffffffffc0200132:	1f250513          	addi	a0,a0,498 # ffffffffc02b1320 <buf>
ffffffffc0200136:	94aa                	add	s1,s1,a0
ffffffffc0200138:	00048023          	sb	zero,0(s1)
            return buf;
        }
    }
}
ffffffffc020013c:	60a6                	ld	ra,72(sp)
ffffffffc020013e:	6486                	ld	s1,64(sp)
ffffffffc0200140:	7962                	ld	s2,56(sp)
ffffffffc0200142:	79c2                	ld	s3,48(sp)
ffffffffc0200144:	7a22                	ld	s4,40(sp)
ffffffffc0200146:	7a82                	ld	s5,32(sp)
ffffffffc0200148:	6b62                	ld	s6,24(sp)
ffffffffc020014a:	6bc2                	ld	s7,16(sp)
ffffffffc020014c:	6161                	addi	sp,sp,80
ffffffffc020014e:	8082                	ret
            cputchar(c);
ffffffffc0200150:	4521                	li	a0,8
ffffffffc0200152:	078000ef          	jal	ra,ffffffffc02001ca <cputchar>
            i --;
ffffffffc0200156:	34fd                	addiw	s1,s1,-1
ffffffffc0200158:	b759                	j	ffffffffc02000de <readline+0x38>

ffffffffc020015a <cputch>:
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt)
{
ffffffffc020015a:	1141                	addi	sp,sp,-16
ffffffffc020015c:	e022                	sd	s0,0(sp)
ffffffffc020015e:	e406                	sd	ra,8(sp)
ffffffffc0200160:	842e                	mv	s0,a1
    cons_putc(c);
ffffffffc0200162:	42c000ef          	jal	ra,ffffffffc020058e <cons_putc>
    (*cnt)++;
ffffffffc0200166:	401c                	lw	a5,0(s0)
}
ffffffffc0200168:	60a2                	ld	ra,8(sp)
    (*cnt)++;
ffffffffc020016a:	2785                	addiw	a5,a5,1
ffffffffc020016c:	c01c                	sw	a5,0(s0)
}
ffffffffc020016e:	6402                	ld	s0,0(sp)
ffffffffc0200170:	0141                	addi	sp,sp,16
ffffffffc0200172:	8082                	ret

ffffffffc0200174 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int vcprintf(const char *fmt, va_list ap)
{
ffffffffc0200174:	1101                	addi	sp,sp,-32
ffffffffc0200176:	862a                	mv	a2,a0
ffffffffc0200178:	86ae                	mv	a3,a1
    int cnt = 0;
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc020017a:	00000517          	auipc	a0,0x0
ffffffffc020017e:	fe050513          	addi	a0,a0,-32 # ffffffffc020015a <cputch>
ffffffffc0200182:	006c                	addi	a1,sp,12
{
ffffffffc0200184:	ec06                	sd	ra,24(sp)
    int cnt = 0;
ffffffffc0200186:	c602                	sw	zero,12(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc0200188:	0f8050ef          	jal	ra,ffffffffc0205280 <vprintfmt>
    return cnt;
}
ffffffffc020018c:	60e2                	ld	ra,24(sp)
ffffffffc020018e:	4532                	lw	a0,12(sp)
ffffffffc0200190:	6105                	addi	sp,sp,32
ffffffffc0200192:	8082                	ret

ffffffffc0200194 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int cprintf(const char *fmt, ...)
{
ffffffffc0200194:	711d                	addi	sp,sp,-96
    va_list ap;
    int cnt;
    va_start(ap, fmt);
ffffffffc0200196:	02810313          	addi	t1,sp,40 # ffffffffc020a028 <boot_page_table_sv39+0x28>
{
ffffffffc020019a:	8e2a                	mv	t3,a0
ffffffffc020019c:	f42e                	sd	a1,40(sp)
ffffffffc020019e:	f832                	sd	a2,48(sp)
ffffffffc02001a0:	fc36                	sd	a3,56(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc02001a2:	00000517          	auipc	a0,0x0
ffffffffc02001a6:	fb850513          	addi	a0,a0,-72 # ffffffffc020015a <cputch>
ffffffffc02001aa:	004c                	addi	a1,sp,4
ffffffffc02001ac:	869a                	mv	a3,t1
ffffffffc02001ae:	8672                	mv	a2,t3
{
ffffffffc02001b0:	ec06                	sd	ra,24(sp)
ffffffffc02001b2:	e0ba                	sd	a4,64(sp)
ffffffffc02001b4:	e4be                	sd	a5,72(sp)
ffffffffc02001b6:	e8c2                	sd	a6,80(sp)
ffffffffc02001b8:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
ffffffffc02001ba:	e41a                	sd	t1,8(sp)
    int cnt = 0;
ffffffffc02001bc:	c202                	sw	zero,4(sp)
    vprintfmt((void *)cputch, &cnt, fmt, ap);
ffffffffc02001be:	0c2050ef          	jal	ra,ffffffffc0205280 <vprintfmt>
    cnt = vcprintf(fmt, ap);
    va_end(ap);
    return cnt;
}
ffffffffc02001c2:	60e2                	ld	ra,24(sp)
ffffffffc02001c4:	4512                	lw	a0,4(sp)
ffffffffc02001c6:	6125                	addi	sp,sp,96
ffffffffc02001c8:	8082                	ret

ffffffffc02001ca <cputchar>:

/* cputchar - writes a single character to stdout */
void cputchar(int c)
{
    cons_putc(c);
ffffffffc02001ca:	a6d1                	j	ffffffffc020058e <cons_putc>

ffffffffc02001cc <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int cputs(const char *str)
{
ffffffffc02001cc:	1101                	addi	sp,sp,-32
ffffffffc02001ce:	e822                	sd	s0,16(sp)
ffffffffc02001d0:	ec06                	sd	ra,24(sp)
ffffffffc02001d2:	e426                	sd	s1,8(sp)
ffffffffc02001d4:	842a                	mv	s0,a0
    int cnt = 0;
    char c;
    while ((c = *str++) != '\0')
ffffffffc02001d6:	00054503          	lbu	a0,0(a0)
ffffffffc02001da:	c51d                	beqz	a0,ffffffffc0200208 <cputs+0x3c>
ffffffffc02001dc:	0405                	addi	s0,s0,1
ffffffffc02001de:	4485                	li	s1,1
ffffffffc02001e0:	9c81                	subw	s1,s1,s0
    cons_putc(c);
ffffffffc02001e2:	3ac000ef          	jal	ra,ffffffffc020058e <cons_putc>
    while ((c = *str++) != '\0')
ffffffffc02001e6:	00044503          	lbu	a0,0(s0)
ffffffffc02001ea:	008487bb          	addw	a5,s1,s0
ffffffffc02001ee:	0405                	addi	s0,s0,1
ffffffffc02001f0:	f96d                	bnez	a0,ffffffffc02001e2 <cputs+0x16>
    (*cnt)++;
ffffffffc02001f2:	0017841b          	addiw	s0,a5,1
    cons_putc(c);
ffffffffc02001f6:	4529                	li	a0,10
ffffffffc02001f8:	396000ef          	jal	ra,ffffffffc020058e <cons_putc>
    {
        cputch(c, &cnt);
    }
    cputch('\n', &cnt);
    return cnt;
}
ffffffffc02001fc:	60e2                	ld	ra,24(sp)
ffffffffc02001fe:	8522                	mv	a0,s0
ffffffffc0200200:	6442                	ld	s0,16(sp)
ffffffffc0200202:	64a2                	ld	s1,8(sp)
ffffffffc0200204:	6105                	addi	sp,sp,32
ffffffffc0200206:	8082                	ret
    while ((c = *str++) != '\0')
ffffffffc0200208:	4405                	li	s0,1
ffffffffc020020a:	b7f5                	j	ffffffffc02001f6 <cputs+0x2a>

ffffffffc020020c <getchar>:

/* getchar - reads a single non-zero character from stdin */
int getchar(void)
{
ffffffffc020020c:	1141                	addi	sp,sp,-16
ffffffffc020020e:	e406                	sd	ra,8(sp)
    int c;
    while ((c = cons_getc()) == 0)
ffffffffc0200210:	3b2000ef          	jal	ra,ffffffffc02005c2 <cons_getc>
ffffffffc0200214:	dd75                	beqz	a0,ffffffffc0200210 <getchar+0x4>
        /* do nothing */;
    return c;
}
ffffffffc0200216:	60a2                	ld	ra,8(sp)
ffffffffc0200218:	0141                	addi	sp,sp,16
ffffffffc020021a:	8082                	ret

ffffffffc020021c <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void print_kerninfo(void)
{
ffffffffc020021c:	1141                	addi	sp,sp,-16
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
ffffffffc020021e:	00005517          	auipc	a0,0x5
ffffffffc0200222:	4e250513          	addi	a0,a0,1250 # ffffffffc0205700 <etext+0x32>
{
ffffffffc0200226:	e406                	sd	ra,8(sp)
    cprintf("Special kernel symbols:\n");
ffffffffc0200228:	f6dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  entry  0x%08x (virtual)\n", kern_init);
ffffffffc020022c:	00000597          	auipc	a1,0x0
ffffffffc0200230:	e1e58593          	addi	a1,a1,-482 # ffffffffc020004a <kern_init>
ffffffffc0200234:	00005517          	auipc	a0,0x5
ffffffffc0200238:	4ec50513          	addi	a0,a0,1260 # ffffffffc0205720 <etext+0x52>
ffffffffc020023c:	f59ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  etext  0x%08x (virtual)\n", etext);
ffffffffc0200240:	00005597          	auipc	a1,0x5
ffffffffc0200244:	48e58593          	addi	a1,a1,1166 # ffffffffc02056ce <etext>
ffffffffc0200248:	00005517          	auipc	a0,0x5
ffffffffc020024c:	4f850513          	addi	a0,a0,1272 # ffffffffc0205740 <etext+0x72>
ffffffffc0200250:	f45ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  edata  0x%08x (virtual)\n", edata);
ffffffffc0200254:	000b1597          	auipc	a1,0xb1
ffffffffc0200258:	0cc58593          	addi	a1,a1,204 # ffffffffc02b1320 <buf>
ffffffffc020025c:	00005517          	auipc	a0,0x5
ffffffffc0200260:	50450513          	addi	a0,a0,1284 # ffffffffc0205760 <etext+0x92>
ffffffffc0200264:	f31ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  end    0x%08x (virtual)\n", end);
ffffffffc0200268:	000b5597          	auipc	a1,0xb5
ffffffffc020026c:	56458593          	addi	a1,a1,1380 # ffffffffc02b57cc <end>
ffffffffc0200270:	00005517          	auipc	a0,0x5
ffffffffc0200274:	51050513          	addi	a0,a0,1296 # ffffffffc0205780 <etext+0xb2>
ffffffffc0200278:	f1dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("Kernel executable memory footprint: %dKB\n",
            (end - kern_init + 1023) / 1024);
ffffffffc020027c:	000b6597          	auipc	a1,0xb6
ffffffffc0200280:	94f58593          	addi	a1,a1,-1713 # ffffffffc02b5bcb <end+0x3ff>
ffffffffc0200284:	00000797          	auipc	a5,0x0
ffffffffc0200288:	dc678793          	addi	a5,a5,-570 # ffffffffc020004a <kern_init>
ffffffffc020028c:	40f587b3          	sub	a5,a1,a5
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200290:	43f7d593          	srai	a1,a5,0x3f
}
ffffffffc0200294:	60a2                	ld	ra,8(sp)
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc0200296:	3ff5f593          	andi	a1,a1,1023
ffffffffc020029a:	95be                	add	a1,a1,a5
ffffffffc020029c:	85a9                	srai	a1,a1,0xa
ffffffffc020029e:	00005517          	auipc	a0,0x5
ffffffffc02002a2:	50250513          	addi	a0,a0,1282 # ffffffffc02057a0 <etext+0xd2>
}
ffffffffc02002a6:	0141                	addi	sp,sp,16
    cprintf("Kernel executable memory footprint: %dKB\n",
ffffffffc02002a8:	b5f5                	j	ffffffffc0200194 <cprintf>

ffffffffc02002aa <print_stackframe>:
 * jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the
 * boundary.
 * */
void print_stackframe(void)
{
ffffffffc02002aa:	1141                	addi	sp,sp,-16
    panic("Not Implemented!");
ffffffffc02002ac:	00005617          	auipc	a2,0x5
ffffffffc02002b0:	52460613          	addi	a2,a2,1316 # ffffffffc02057d0 <etext+0x102>
ffffffffc02002b4:	04f00593          	li	a1,79
ffffffffc02002b8:	00005517          	auipc	a0,0x5
ffffffffc02002bc:	53050513          	addi	a0,a0,1328 # ffffffffc02057e8 <etext+0x11a>
{
ffffffffc02002c0:	e406                	sd	ra,8(sp)
    panic("Not Implemented!");
ffffffffc02002c2:	1cc000ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02002c6 <mon_help>:
    }
}

/* mon_help - print the information about mon_* functions */
int mon_help(int argc, char **argv, struct trapframe *tf)
{
ffffffffc02002c6:	1141                	addi	sp,sp,-16
    int i;
    for (i = 0; i < NCOMMANDS; i++)
    {
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc02002c8:	00005617          	auipc	a2,0x5
ffffffffc02002cc:	53860613          	addi	a2,a2,1336 # ffffffffc0205800 <etext+0x132>
ffffffffc02002d0:	00005597          	auipc	a1,0x5
ffffffffc02002d4:	55058593          	addi	a1,a1,1360 # ffffffffc0205820 <etext+0x152>
ffffffffc02002d8:	00005517          	auipc	a0,0x5
ffffffffc02002dc:	55050513          	addi	a0,a0,1360 # ffffffffc0205828 <etext+0x15a>
{
ffffffffc02002e0:	e406                	sd	ra,8(sp)
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
ffffffffc02002e2:	eb3ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc02002e6:	00005617          	auipc	a2,0x5
ffffffffc02002ea:	55260613          	addi	a2,a2,1362 # ffffffffc0205838 <etext+0x16a>
ffffffffc02002ee:	00005597          	auipc	a1,0x5
ffffffffc02002f2:	57258593          	addi	a1,a1,1394 # ffffffffc0205860 <etext+0x192>
ffffffffc02002f6:	00005517          	auipc	a0,0x5
ffffffffc02002fa:	53250513          	addi	a0,a0,1330 # ffffffffc0205828 <etext+0x15a>
ffffffffc02002fe:	e97ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc0200302:	00005617          	auipc	a2,0x5
ffffffffc0200306:	56e60613          	addi	a2,a2,1390 # ffffffffc0205870 <etext+0x1a2>
ffffffffc020030a:	00005597          	auipc	a1,0x5
ffffffffc020030e:	58658593          	addi	a1,a1,1414 # ffffffffc0205890 <etext+0x1c2>
ffffffffc0200312:	00005517          	auipc	a0,0x5
ffffffffc0200316:	51650513          	addi	a0,a0,1302 # ffffffffc0205828 <etext+0x15a>
ffffffffc020031a:	e7bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    }
    return 0;
}
ffffffffc020031e:	60a2                	ld	ra,8(sp)
ffffffffc0200320:	4501                	li	a0,0
ffffffffc0200322:	0141                	addi	sp,sp,16
ffffffffc0200324:	8082                	ret

ffffffffc0200326 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int mon_kerninfo(int argc, char **argv, struct trapframe *tf)
{
ffffffffc0200326:	1141                	addi	sp,sp,-16
ffffffffc0200328:	e406                	sd	ra,8(sp)
    print_kerninfo();
ffffffffc020032a:	ef3ff0ef          	jal	ra,ffffffffc020021c <print_kerninfo>
    return 0;
}
ffffffffc020032e:	60a2                	ld	ra,8(sp)
ffffffffc0200330:	4501                	li	a0,0
ffffffffc0200332:	0141                	addi	sp,sp,16
ffffffffc0200334:	8082                	ret

ffffffffc0200336 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int mon_backtrace(int argc, char **argv, struct trapframe *tf)
{
ffffffffc0200336:	1141                	addi	sp,sp,-16
ffffffffc0200338:	e406                	sd	ra,8(sp)
    print_stackframe();
ffffffffc020033a:	f71ff0ef          	jal	ra,ffffffffc02002aa <print_stackframe>
    return 0;
}
ffffffffc020033e:	60a2                	ld	ra,8(sp)
ffffffffc0200340:	4501                	li	a0,0
ffffffffc0200342:	0141                	addi	sp,sp,16
ffffffffc0200344:	8082                	ret

ffffffffc0200346 <kmonitor>:
{
ffffffffc0200346:	7115                	addi	sp,sp,-224
ffffffffc0200348:	ed5e                	sd	s7,152(sp)
ffffffffc020034a:	8baa                	mv	s7,a0
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc020034c:	00005517          	auipc	a0,0x5
ffffffffc0200350:	55450513          	addi	a0,a0,1364 # ffffffffc02058a0 <etext+0x1d2>
{
ffffffffc0200354:	ed86                	sd	ra,216(sp)
ffffffffc0200356:	e9a2                	sd	s0,208(sp)
ffffffffc0200358:	e5a6                	sd	s1,200(sp)
ffffffffc020035a:	e1ca                	sd	s2,192(sp)
ffffffffc020035c:	fd4e                	sd	s3,184(sp)
ffffffffc020035e:	f952                	sd	s4,176(sp)
ffffffffc0200360:	f556                	sd	s5,168(sp)
ffffffffc0200362:	f15a                	sd	s6,160(sp)
ffffffffc0200364:	e962                	sd	s8,144(sp)
ffffffffc0200366:	e566                	sd	s9,136(sp)
ffffffffc0200368:	e16a                	sd	s10,128(sp)
    cprintf("Welcome to the kernel debug monitor!!\n");
ffffffffc020036a:	e2bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("Type 'help' for a list of commands.\n");
ffffffffc020036e:	00005517          	auipc	a0,0x5
ffffffffc0200372:	55a50513          	addi	a0,a0,1370 # ffffffffc02058c8 <etext+0x1fa>
ffffffffc0200376:	e1fff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    if (tf != NULL)
ffffffffc020037a:	000b8563          	beqz	s7,ffffffffc0200384 <kmonitor+0x3e>
        print_trapframe(tf);
ffffffffc020037e:	855e                	mv	a0,s7
ffffffffc0200380:	025000ef          	jal	ra,ffffffffc0200ba4 <print_trapframe>
ffffffffc0200384:	00005c17          	auipc	s8,0x5
ffffffffc0200388:	5b4c0c13          	addi	s8,s8,1460 # ffffffffc0205938 <commands>
        if ((buf = readline("K> ")) != NULL)
ffffffffc020038c:	00005917          	auipc	s2,0x5
ffffffffc0200390:	56490913          	addi	s2,s2,1380 # ffffffffc02058f0 <etext+0x222>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc0200394:	00005497          	auipc	s1,0x5
ffffffffc0200398:	56448493          	addi	s1,s1,1380 # ffffffffc02058f8 <etext+0x22a>
        if (argc == MAXARGS - 1)
ffffffffc020039c:	49bd                	li	s3,15
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc020039e:	00005b17          	auipc	s6,0x5
ffffffffc02003a2:	562b0b13          	addi	s6,s6,1378 # ffffffffc0205900 <etext+0x232>
        argv[argc++] = buf;
ffffffffc02003a6:	00005a17          	auipc	s4,0x5
ffffffffc02003aa:	47aa0a13          	addi	s4,s4,1146 # ffffffffc0205820 <etext+0x152>
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc02003ae:	4a8d                	li	s5,3
        if ((buf = readline("K> ")) != NULL)
ffffffffc02003b0:	854a                	mv	a0,s2
ffffffffc02003b2:	cf5ff0ef          	jal	ra,ffffffffc02000a6 <readline>
ffffffffc02003b6:	842a                	mv	s0,a0
ffffffffc02003b8:	dd65                	beqz	a0,ffffffffc02003b0 <kmonitor+0x6a>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc02003ba:	00054583          	lbu	a1,0(a0)
    int argc = 0;
ffffffffc02003be:	4c81                	li	s9,0
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc02003c0:	e1bd                	bnez	a1,ffffffffc0200426 <kmonitor+0xe0>
    if (argc == 0)
ffffffffc02003c2:	fe0c87e3          	beqz	s9,ffffffffc02003b0 <kmonitor+0x6a>
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc02003c6:	6582                	ld	a1,0(sp)
ffffffffc02003c8:	00005d17          	auipc	s10,0x5
ffffffffc02003cc:	570d0d13          	addi	s10,s10,1392 # ffffffffc0205938 <commands>
        argv[argc++] = buf;
ffffffffc02003d0:	8552                	mv	a0,s4
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc02003d2:	4401                	li	s0,0
ffffffffc02003d4:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc02003d6:	274050ef          	jal	ra,ffffffffc020564a <strcmp>
ffffffffc02003da:	c919                	beqz	a0,ffffffffc02003f0 <kmonitor+0xaa>
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc02003dc:	2405                	addiw	s0,s0,1
ffffffffc02003de:	0b540063          	beq	s0,s5,ffffffffc020047e <kmonitor+0x138>
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc02003e2:	000d3503          	ld	a0,0(s10)
ffffffffc02003e6:	6582                	ld	a1,0(sp)
    for (i = 0; i < NCOMMANDS; i++)
ffffffffc02003e8:	0d61                	addi	s10,s10,24
        if (strcmp(commands[i].name, argv[0]) == 0)
ffffffffc02003ea:	260050ef          	jal	ra,ffffffffc020564a <strcmp>
ffffffffc02003ee:	f57d                	bnez	a0,ffffffffc02003dc <kmonitor+0x96>
            return commands[i].func(argc - 1, argv + 1, tf);
ffffffffc02003f0:	00141793          	slli	a5,s0,0x1
ffffffffc02003f4:	97a2                	add	a5,a5,s0
ffffffffc02003f6:	078e                	slli	a5,a5,0x3
ffffffffc02003f8:	97e2                	add	a5,a5,s8
ffffffffc02003fa:	6b9c                	ld	a5,16(a5)
ffffffffc02003fc:	865e                	mv	a2,s7
ffffffffc02003fe:	002c                	addi	a1,sp,8
ffffffffc0200400:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200404:	9782                	jalr	a5
            if (runcmd(buf, tf) < 0)
ffffffffc0200406:	fa0555e3          	bgez	a0,ffffffffc02003b0 <kmonitor+0x6a>
}
ffffffffc020040a:	60ee                	ld	ra,216(sp)
ffffffffc020040c:	644e                	ld	s0,208(sp)
ffffffffc020040e:	64ae                	ld	s1,200(sp)
ffffffffc0200410:	690e                	ld	s2,192(sp)
ffffffffc0200412:	79ea                	ld	s3,184(sp)
ffffffffc0200414:	7a4a                	ld	s4,176(sp)
ffffffffc0200416:	7aaa                	ld	s5,168(sp)
ffffffffc0200418:	7b0a                	ld	s6,160(sp)
ffffffffc020041a:	6bea                	ld	s7,152(sp)
ffffffffc020041c:	6c4a                	ld	s8,144(sp)
ffffffffc020041e:	6caa                	ld	s9,136(sp)
ffffffffc0200420:	6d0a                	ld	s10,128(sp)
ffffffffc0200422:	612d                	addi	sp,sp,224
ffffffffc0200424:	8082                	ret
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc0200426:	8526                	mv	a0,s1
ffffffffc0200428:	266050ef          	jal	ra,ffffffffc020568e <strchr>
ffffffffc020042c:	c901                	beqz	a0,ffffffffc020043c <kmonitor+0xf6>
ffffffffc020042e:	00144583          	lbu	a1,1(s0)
            *buf++ = '\0';
ffffffffc0200432:	00040023          	sb	zero,0(s0)
ffffffffc0200436:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc0200438:	d5c9                	beqz	a1,ffffffffc02003c2 <kmonitor+0x7c>
ffffffffc020043a:	b7f5                	j	ffffffffc0200426 <kmonitor+0xe0>
        if (*buf == '\0')
ffffffffc020043c:	00044783          	lbu	a5,0(s0)
ffffffffc0200440:	d3c9                	beqz	a5,ffffffffc02003c2 <kmonitor+0x7c>
        if (argc == MAXARGS - 1)
ffffffffc0200442:	033c8963          	beq	s9,s3,ffffffffc0200474 <kmonitor+0x12e>
        argv[argc++] = buf;
ffffffffc0200446:	003c9793          	slli	a5,s9,0x3
ffffffffc020044a:	0118                	addi	a4,sp,128
ffffffffc020044c:	97ba                	add	a5,a5,a4
ffffffffc020044e:	f887b023          	sd	s0,-128(a5)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL)
ffffffffc0200452:	00044583          	lbu	a1,0(s0)
        argv[argc++] = buf;
ffffffffc0200456:	2c85                	addiw	s9,s9,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL)
ffffffffc0200458:	e591                	bnez	a1,ffffffffc0200464 <kmonitor+0x11e>
ffffffffc020045a:	b7b5                	j	ffffffffc02003c6 <kmonitor+0x80>
ffffffffc020045c:	00144583          	lbu	a1,1(s0)
            buf++;
ffffffffc0200460:	0405                	addi	s0,s0,1
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL)
ffffffffc0200462:	d1a5                	beqz	a1,ffffffffc02003c2 <kmonitor+0x7c>
ffffffffc0200464:	8526                	mv	a0,s1
ffffffffc0200466:	228050ef          	jal	ra,ffffffffc020568e <strchr>
ffffffffc020046a:	d96d                	beqz	a0,ffffffffc020045c <kmonitor+0x116>
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL)
ffffffffc020046c:	00044583          	lbu	a1,0(s0)
ffffffffc0200470:	d9a9                	beqz	a1,ffffffffc02003c2 <kmonitor+0x7c>
ffffffffc0200472:	bf55                	j	ffffffffc0200426 <kmonitor+0xe0>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
ffffffffc0200474:	45c1                	li	a1,16
ffffffffc0200476:	855a                	mv	a0,s6
ffffffffc0200478:	d1dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc020047c:	b7e9                	j	ffffffffc0200446 <kmonitor+0x100>
    cprintf("Unknown command '%s'\n", argv[0]);
ffffffffc020047e:	6582                	ld	a1,0(sp)
ffffffffc0200480:	00005517          	auipc	a0,0x5
ffffffffc0200484:	4a050513          	addi	a0,a0,1184 # ffffffffc0205920 <etext+0x252>
ffffffffc0200488:	d0dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    return 0;
ffffffffc020048c:	b715                	j	ffffffffc02003b0 <kmonitor+0x6a>

ffffffffc020048e <__panic>:
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void __panic(const char *file, int line, const char *fmt, ...)
{
    if (is_panic)
ffffffffc020048e:	000b5317          	auipc	t1,0xb5
ffffffffc0200492:	2ba30313          	addi	t1,t1,698 # ffffffffc02b5748 <is_panic>
ffffffffc0200496:	00033e03          	ld	t3,0(t1)
{
ffffffffc020049a:	715d                	addi	sp,sp,-80
ffffffffc020049c:	ec06                	sd	ra,24(sp)
ffffffffc020049e:	e822                	sd	s0,16(sp)
ffffffffc02004a0:	f436                	sd	a3,40(sp)
ffffffffc02004a2:	f83a                	sd	a4,48(sp)
ffffffffc02004a4:	fc3e                	sd	a5,56(sp)
ffffffffc02004a6:	e0c2                	sd	a6,64(sp)
ffffffffc02004a8:	e4c6                	sd	a7,72(sp)
    if (is_panic)
ffffffffc02004aa:	020e1a63          	bnez	t3,ffffffffc02004de <__panic+0x50>
    {
        goto panic_dead;
    }
    is_panic = 1;
ffffffffc02004ae:	4785                	li	a5,1
ffffffffc02004b0:	00f33023          	sd	a5,0(t1)

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
ffffffffc02004b4:	8432                	mv	s0,a2
ffffffffc02004b6:	103c                	addi	a5,sp,40
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02004b8:	862e                	mv	a2,a1
ffffffffc02004ba:	85aa                	mv	a1,a0
ffffffffc02004bc:	00005517          	auipc	a0,0x5
ffffffffc02004c0:	4c450513          	addi	a0,a0,1220 # ffffffffc0205980 <commands+0x48>
    va_start(ap, fmt);
ffffffffc02004c4:	e43e                	sd	a5,8(sp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
ffffffffc02004c6:	ccfff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    vcprintf(fmt, ap);
ffffffffc02004ca:	65a2                	ld	a1,8(sp)
ffffffffc02004cc:	8522                	mv	a0,s0
ffffffffc02004ce:	ca7ff0ef          	jal	ra,ffffffffc0200174 <vcprintf>
    cprintf("\n");
ffffffffc02004d2:	00006517          	auipc	a0,0x6
ffffffffc02004d6:	5b650513          	addi	a0,a0,1462 # ffffffffc0206a88 <default_pmm_manager+0x578>
ffffffffc02004da:	cbbff0ef          	jal	ra,ffffffffc0200194 <cprintf>
#endif
}

static inline void sbi_shutdown(void)
{
	SBI_CALL_0(SBI_SHUTDOWN);
ffffffffc02004de:	4501                	li	a0,0
ffffffffc02004e0:	4581                	li	a1,0
ffffffffc02004e2:	4601                	li	a2,0
ffffffffc02004e4:	48a1                	li	a7,8
ffffffffc02004e6:	00000073          	ecall
    va_end(ap);

panic_dead:
    // No debug monitor here
    sbi_shutdown();
    intr_disable();
ffffffffc02004ea:	4ca000ef          	jal	ra,ffffffffc02009b4 <intr_disable>
    while (1)
    {
        kmonitor(NULL);
ffffffffc02004ee:	4501                	li	a0,0
ffffffffc02004f0:	e57ff0ef          	jal	ra,ffffffffc0200346 <kmonitor>
    while (1)
ffffffffc02004f4:	bfed                	j	ffffffffc02004ee <__panic+0x60>

ffffffffc02004f6 <__warn>:
    }
}

/* __warn - like panic, but don't */
void __warn(const char *file, int line, const char *fmt, ...)
{
ffffffffc02004f6:	715d                	addi	sp,sp,-80
ffffffffc02004f8:	832e                	mv	t1,a1
ffffffffc02004fa:	e822                	sd	s0,16(sp)
    va_list ap;
    va_start(ap, fmt);
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc02004fc:	85aa                	mv	a1,a0
{
ffffffffc02004fe:	8432                	mv	s0,a2
ffffffffc0200500:	fc3e                	sd	a5,56(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200502:	861a                	mv	a2,t1
    va_start(ap, fmt);
ffffffffc0200504:	103c                	addi	a5,sp,40
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc0200506:	00005517          	auipc	a0,0x5
ffffffffc020050a:	49a50513          	addi	a0,a0,1178 # ffffffffc02059a0 <commands+0x68>
{
ffffffffc020050e:	ec06                	sd	ra,24(sp)
ffffffffc0200510:	f436                	sd	a3,40(sp)
ffffffffc0200512:	f83a                	sd	a4,48(sp)
ffffffffc0200514:	e0c2                	sd	a6,64(sp)
ffffffffc0200516:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc0200518:	e43e                	sd	a5,8(sp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
ffffffffc020051a:	c7bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    vcprintf(fmt, ap);
ffffffffc020051e:	65a2                	ld	a1,8(sp)
ffffffffc0200520:	8522                	mv	a0,s0
ffffffffc0200522:	c53ff0ef          	jal	ra,ffffffffc0200174 <vcprintf>
    cprintf("\n");
ffffffffc0200526:	00006517          	auipc	a0,0x6
ffffffffc020052a:	56250513          	addi	a0,a0,1378 # ffffffffc0206a88 <default_pmm_manager+0x578>
ffffffffc020052e:	c67ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    va_end(ap);
}
ffffffffc0200532:	60e2                	ld	ra,24(sp)
ffffffffc0200534:	6442                	ld	s0,16(sp)
ffffffffc0200536:	6161                	addi	sp,sp,80
ffffffffc0200538:	8082                	ret

ffffffffc020053a <clock_init>:
 * and then enable IRQ_TIMER.
 * */
void clock_init(void) {
    // divided by 500 when using Spike(2MHz)
    // divided by 100 when using QEMU(10MHz)
    timebase = 1e7 / 100;
ffffffffc020053a:	67e1                	lui	a5,0x18
ffffffffc020053c:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_obj___user_exit_out_size+0xd578>
ffffffffc0200540:	000b5717          	auipc	a4,0xb5
ffffffffc0200544:	20f73c23          	sd	a5,536(a4) # ffffffffc02b5758 <timebase>
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200548:	c0102573          	rdtime	a0
	SBI_CALL_1(SBI_SET_TIMER, stime_value);
ffffffffc020054c:	4581                	li	a1,0
    ticks = 0;

    cprintf("++ setup timer interrupts\n");
}

void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc020054e:	953e                	add	a0,a0,a5
ffffffffc0200550:	4601                	li	a2,0
ffffffffc0200552:	4881                	li	a7,0
ffffffffc0200554:	00000073          	ecall
    set_csr(sie, MIP_STIP);
ffffffffc0200558:	02000793          	li	a5,32
ffffffffc020055c:	1047a7f3          	csrrs	a5,sie,a5
    cprintf("++ setup timer interrupts\n");
ffffffffc0200560:	00005517          	auipc	a0,0x5
ffffffffc0200564:	46050513          	addi	a0,a0,1120 # ffffffffc02059c0 <commands+0x88>
    ticks = 0;
ffffffffc0200568:	000b5797          	auipc	a5,0xb5
ffffffffc020056c:	1e07b423          	sd	zero,488(a5) # ffffffffc02b5750 <ticks>
    cprintf("++ setup timer interrupts\n");
ffffffffc0200570:	b115                	j	ffffffffc0200194 <cprintf>

ffffffffc0200572 <clock_set_next_event>:
    __asm__ __volatile__("rdtime %0" : "=r"(n));
ffffffffc0200572:	c0102573          	rdtime	a0
void clock_set_next_event(void) { sbi_set_timer(get_cycles() + timebase); }
ffffffffc0200576:	000b5797          	auipc	a5,0xb5
ffffffffc020057a:	1e27b783          	ld	a5,482(a5) # ffffffffc02b5758 <timebase>
ffffffffc020057e:	953e                	add	a0,a0,a5
ffffffffc0200580:	4581                	li	a1,0
ffffffffc0200582:	4601                	li	a2,0
ffffffffc0200584:	4881                	li	a7,0
ffffffffc0200586:	00000073          	ecall
ffffffffc020058a:	8082                	ret

ffffffffc020058c <cons_init>:

/* serial_intr - try to feed input characters from serial port */
void serial_intr(void) {}

/* cons_init - initializes the console devices */
void cons_init(void) {}
ffffffffc020058c:	8082                	ret

ffffffffc020058e <cons_putc>:
#include <riscv.h>
#include <assert.h>

static inline bool __intr_save(void)
{
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020058e:	100027f3          	csrr	a5,sstatus
ffffffffc0200592:	8b89                	andi	a5,a5,2
	SBI_CALL_1(SBI_CONSOLE_PUTCHAR, ch);
ffffffffc0200594:	0ff57513          	zext.b	a0,a0
ffffffffc0200598:	e799                	bnez	a5,ffffffffc02005a6 <cons_putc+0x18>
ffffffffc020059a:	4581                	li	a1,0
ffffffffc020059c:	4601                	li	a2,0
ffffffffc020059e:	4885                	li	a7,1
ffffffffc02005a0:	00000073          	ecall
    return 0;
}

static inline void __intr_restore(bool flag)
{
    if (flag)
ffffffffc02005a4:	8082                	ret

/* cons_putc - print a single character @c to console devices */
void cons_putc(int c) {
ffffffffc02005a6:	1101                	addi	sp,sp,-32
ffffffffc02005a8:	ec06                	sd	ra,24(sp)
ffffffffc02005aa:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02005ac:	408000ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc02005b0:	6522                	ld	a0,8(sp)
ffffffffc02005b2:	4581                	li	a1,0
ffffffffc02005b4:	4601                	li	a2,0
ffffffffc02005b6:	4885                	li	a7,1
ffffffffc02005b8:	00000073          	ecall
    local_intr_save(intr_flag);
    {
        sbi_console_putchar((unsigned char)c);
    }
    local_intr_restore(intr_flag);
}
ffffffffc02005bc:	60e2                	ld	ra,24(sp)
ffffffffc02005be:	6105                	addi	sp,sp,32
    {
        intr_enable();
ffffffffc02005c0:	a6fd                	j	ffffffffc02009ae <intr_enable>

ffffffffc02005c2 <cons_getc>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02005c2:	100027f3          	csrr	a5,sstatus
ffffffffc02005c6:	8b89                	andi	a5,a5,2
ffffffffc02005c8:	eb89                	bnez	a5,ffffffffc02005da <cons_getc+0x18>
	return SBI_CALL_0(SBI_CONSOLE_GETCHAR);
ffffffffc02005ca:	4501                	li	a0,0
ffffffffc02005cc:	4581                	li	a1,0
ffffffffc02005ce:	4601                	li	a2,0
ffffffffc02005d0:	4889                	li	a7,2
ffffffffc02005d2:	00000073          	ecall
ffffffffc02005d6:	2501                	sext.w	a0,a0
    {
        c = sbi_console_getchar();
    }
    local_intr_restore(intr_flag);
    return c;
}
ffffffffc02005d8:	8082                	ret
int cons_getc(void) {
ffffffffc02005da:	1101                	addi	sp,sp,-32
ffffffffc02005dc:	ec06                	sd	ra,24(sp)
        intr_disable();
ffffffffc02005de:	3d6000ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc02005e2:	4501                	li	a0,0
ffffffffc02005e4:	4581                	li	a1,0
ffffffffc02005e6:	4601                	li	a2,0
ffffffffc02005e8:	4889                	li	a7,2
ffffffffc02005ea:	00000073          	ecall
ffffffffc02005ee:	2501                	sext.w	a0,a0
ffffffffc02005f0:	e42a                	sd	a0,8(sp)
        intr_enable();
ffffffffc02005f2:	3bc000ef          	jal	ra,ffffffffc02009ae <intr_enable>
}
ffffffffc02005f6:	60e2                	ld	ra,24(sp)
ffffffffc02005f8:	6522                	ld	a0,8(sp)
ffffffffc02005fa:	6105                	addi	sp,sp,32
ffffffffc02005fc:	8082                	ret

ffffffffc02005fe <dtb_init>:

// 保存解析出的系统物理内存信息
static uint64_t memory_base = 0;
static uint64_t memory_size = 0;

void dtb_init(void) {
ffffffffc02005fe:	7119                	addi	sp,sp,-128
    cprintf("DTB Init\n");
ffffffffc0200600:	00005517          	auipc	a0,0x5
ffffffffc0200604:	3e050513          	addi	a0,a0,992 # ffffffffc02059e0 <commands+0xa8>
void dtb_init(void) {
ffffffffc0200608:	fc86                	sd	ra,120(sp)
ffffffffc020060a:	f8a2                	sd	s0,112(sp)
ffffffffc020060c:	e8d2                	sd	s4,80(sp)
ffffffffc020060e:	f4a6                	sd	s1,104(sp)
ffffffffc0200610:	f0ca                	sd	s2,96(sp)
ffffffffc0200612:	ecce                	sd	s3,88(sp)
ffffffffc0200614:	e4d6                	sd	s5,72(sp)
ffffffffc0200616:	e0da                	sd	s6,64(sp)
ffffffffc0200618:	fc5e                	sd	s7,56(sp)
ffffffffc020061a:	f862                	sd	s8,48(sp)
ffffffffc020061c:	f466                	sd	s9,40(sp)
ffffffffc020061e:	f06a                	sd	s10,32(sp)
ffffffffc0200620:	ec6e                	sd	s11,24(sp)
    cprintf("DTB Init\n");
ffffffffc0200622:	b73ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("HartID: %ld\n", boot_hartid);
ffffffffc0200626:	0000b597          	auipc	a1,0xb
ffffffffc020062a:	9da5b583          	ld	a1,-1574(a1) # ffffffffc020b000 <boot_hartid>
ffffffffc020062e:	00005517          	auipc	a0,0x5
ffffffffc0200632:	3c250513          	addi	a0,a0,962 # ffffffffc02059f0 <commands+0xb8>
ffffffffc0200636:	b5fff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("DTB Address: 0x%lx\n", boot_dtb);
ffffffffc020063a:	0000b417          	auipc	s0,0xb
ffffffffc020063e:	9ce40413          	addi	s0,s0,-1586 # ffffffffc020b008 <boot_dtb>
ffffffffc0200642:	600c                	ld	a1,0(s0)
ffffffffc0200644:	00005517          	auipc	a0,0x5
ffffffffc0200648:	3bc50513          	addi	a0,a0,956 # ffffffffc0205a00 <commands+0xc8>
ffffffffc020064c:	b49ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    
    if (boot_dtb == 0) {
ffffffffc0200650:	00043a03          	ld	s4,0(s0)
        cprintf("Error: DTB address is null\n");
ffffffffc0200654:	00005517          	auipc	a0,0x5
ffffffffc0200658:	3c450513          	addi	a0,a0,964 # ffffffffc0205a18 <commands+0xe0>
    if (boot_dtb == 0) {
ffffffffc020065c:	120a0463          	beqz	s4,ffffffffc0200784 <dtb_init+0x186>
        return;
    }
    
    // 转换为虚拟地址
    uintptr_t dtb_vaddr = boot_dtb + PHYSICAL_MEMORY_OFFSET;
ffffffffc0200660:	57f5                	li	a5,-3
ffffffffc0200662:	07fa                	slli	a5,a5,0x1e
ffffffffc0200664:	00fa0733          	add	a4,s4,a5
    const struct fdt_header *header = (const struct fdt_header *)dtb_vaddr;
    
    // 验证DTB
    uint32_t magic = fdt32_to_cpu(header->magic);
ffffffffc0200668:	431c                	lw	a5,0(a4)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020066a:	00ff0637          	lui	a2,0xff0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020066e:	6b41                	lui	s6,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200670:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200674:	0187969b          	slliw	a3,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200678:	0187d51b          	srliw	a0,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020067c:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200680:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200684:	8df1                	and	a1,a1,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200686:	8ec9                	or	a3,a3,a0
ffffffffc0200688:	0087979b          	slliw	a5,a5,0x8
ffffffffc020068c:	1b7d                	addi	s6,s6,-1
ffffffffc020068e:	0167f7b3          	and	a5,a5,s6
ffffffffc0200692:	8dd5                	or	a1,a1,a3
ffffffffc0200694:	8ddd                	or	a1,a1,a5
    if (magic != 0xd00dfeed) {
ffffffffc0200696:	d00e07b7          	lui	a5,0xd00e0
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020069a:	2581                	sext.w	a1,a1
    if (magic != 0xd00dfeed) {
ffffffffc020069c:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfe2a721>
ffffffffc02006a0:	10f59163          	bne	a1,a5,ffffffffc02007a2 <dtb_init+0x1a4>
        return;
    }
    
    // 提取内存信息
    uint64_t mem_base, mem_size;
    if (extract_memory_info(dtb_vaddr, header, &mem_base, &mem_size) == 0) {
ffffffffc02006a4:	471c                	lw	a5,8(a4)
ffffffffc02006a6:	4754                	lw	a3,12(a4)
    int in_memory_node = 0;
ffffffffc02006a8:	4c81                	li	s9,0
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006aa:	0087d59b          	srliw	a1,a5,0x8
ffffffffc02006ae:	0086d51b          	srliw	a0,a3,0x8
ffffffffc02006b2:	0186941b          	slliw	s0,a3,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006b6:	0186d89b          	srliw	a7,a3,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006ba:	01879a1b          	slliw	s4,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006be:	0187d81b          	srliw	a6,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006c2:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006c6:	0106d69b          	srliw	a3,a3,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006ca:	0105959b          	slliw	a1,a1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006ce:	0107d79b          	srliw	a5,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006d2:	8d71                	and	a0,a0,a2
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006d4:	01146433          	or	s0,s0,a7
ffffffffc02006d8:	0086969b          	slliw	a3,a3,0x8
ffffffffc02006dc:	010a6a33          	or	s4,s4,a6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02006e0:	8e6d                	and	a2,a2,a1
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02006e2:	0087979b          	slliw	a5,a5,0x8
ffffffffc02006e6:	8c49                	or	s0,s0,a0
ffffffffc02006e8:	0166f6b3          	and	a3,a3,s6
ffffffffc02006ec:	00ca6a33          	or	s4,s4,a2
ffffffffc02006f0:	0167f7b3          	and	a5,a5,s6
ffffffffc02006f4:	8c55                	or	s0,s0,a3
ffffffffc02006f6:	00fa6a33          	or	s4,s4,a5
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02006fa:	1402                	slli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc02006fc:	1a02                	slli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc02006fe:	9001                	srli	s0,s0,0x20
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200700:	020a5a13          	srli	s4,s4,0x20
    const char *strings_base = (const char *)(dtb_vaddr + strings_offset);
ffffffffc0200704:	943a                	add	s0,s0,a4
    const uint32_t *struct_ptr = (const uint32_t *)(dtb_vaddr + struct_offset);
ffffffffc0200706:	9a3a                	add	s4,s4,a4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200708:	00ff0c37          	lui	s8,0xff0
        switch (token) {
ffffffffc020070c:	4b8d                	li	s7,3
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020070e:	00005917          	auipc	s2,0x5
ffffffffc0200712:	35a90913          	addi	s2,s2,858 # ffffffffc0205a68 <commands+0x130>
ffffffffc0200716:	49bd                	li	s3,15
        switch (token) {
ffffffffc0200718:	4d91                	li	s11,4
ffffffffc020071a:	4d05                	li	s10,1
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc020071c:	00005497          	auipc	s1,0x5
ffffffffc0200720:	34448493          	addi	s1,s1,836 # ffffffffc0205a60 <commands+0x128>
        uint32_t token = fdt32_to_cpu(*struct_ptr++);
ffffffffc0200724:	000a2703          	lw	a4,0(s4)
ffffffffc0200728:	004a0a93          	addi	s5,s4,4
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020072c:	0087569b          	srliw	a3,a4,0x8
ffffffffc0200730:	0187179b          	slliw	a5,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200734:	0187561b          	srliw	a2,a4,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200738:	0106969b          	slliw	a3,a3,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020073c:	0107571b          	srliw	a4,a4,0x10
ffffffffc0200740:	8fd1                	or	a5,a5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200742:	0186f6b3          	and	a3,a3,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200746:	0087171b          	slliw	a4,a4,0x8
ffffffffc020074a:	8fd5                	or	a5,a5,a3
ffffffffc020074c:	00eb7733          	and	a4,s6,a4
ffffffffc0200750:	8fd9                	or	a5,a5,a4
ffffffffc0200752:	2781                	sext.w	a5,a5
        switch (token) {
ffffffffc0200754:	09778c63          	beq	a5,s7,ffffffffc02007ec <dtb_init+0x1ee>
ffffffffc0200758:	00fbea63          	bltu	s7,a5,ffffffffc020076c <dtb_init+0x16e>
ffffffffc020075c:	07a78663          	beq	a5,s10,ffffffffc02007c8 <dtb_init+0x1ca>
ffffffffc0200760:	4709                	li	a4,2
ffffffffc0200762:	00e79763          	bne	a5,a4,ffffffffc0200770 <dtb_init+0x172>
ffffffffc0200766:	4c81                	li	s9,0
ffffffffc0200768:	8a56                	mv	s4,s5
ffffffffc020076a:	bf6d                	j	ffffffffc0200724 <dtb_init+0x126>
ffffffffc020076c:	ffb78ee3          	beq	a5,s11,ffffffffc0200768 <dtb_init+0x16a>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
        // 保存到全局变量，供 PMM 查询
        memory_base = mem_base;
        memory_size = mem_size;
    } else {
        cprintf("Warning: Could not extract memory info from DTB\n");
ffffffffc0200770:	00005517          	auipc	a0,0x5
ffffffffc0200774:	37050513          	addi	a0,a0,880 # ffffffffc0205ae0 <commands+0x1a8>
ffffffffc0200778:	a1dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    }
    cprintf("DTB init completed\n");
ffffffffc020077c:	00005517          	auipc	a0,0x5
ffffffffc0200780:	39c50513          	addi	a0,a0,924 # ffffffffc0205b18 <commands+0x1e0>
}
ffffffffc0200784:	7446                	ld	s0,112(sp)
ffffffffc0200786:	70e6                	ld	ra,120(sp)
ffffffffc0200788:	74a6                	ld	s1,104(sp)
ffffffffc020078a:	7906                	ld	s2,96(sp)
ffffffffc020078c:	69e6                	ld	s3,88(sp)
ffffffffc020078e:	6a46                	ld	s4,80(sp)
ffffffffc0200790:	6aa6                	ld	s5,72(sp)
ffffffffc0200792:	6b06                	ld	s6,64(sp)
ffffffffc0200794:	7be2                	ld	s7,56(sp)
ffffffffc0200796:	7c42                	ld	s8,48(sp)
ffffffffc0200798:	7ca2                	ld	s9,40(sp)
ffffffffc020079a:	7d02                	ld	s10,32(sp)
ffffffffc020079c:	6de2                	ld	s11,24(sp)
ffffffffc020079e:	6109                	addi	sp,sp,128
    cprintf("DTB init completed\n");
ffffffffc02007a0:	bad5                	j	ffffffffc0200194 <cprintf>
}
ffffffffc02007a2:	7446                	ld	s0,112(sp)
ffffffffc02007a4:	70e6                	ld	ra,120(sp)
ffffffffc02007a6:	74a6                	ld	s1,104(sp)
ffffffffc02007a8:	7906                	ld	s2,96(sp)
ffffffffc02007aa:	69e6                	ld	s3,88(sp)
ffffffffc02007ac:	6a46                	ld	s4,80(sp)
ffffffffc02007ae:	6aa6                	ld	s5,72(sp)
ffffffffc02007b0:	6b06                	ld	s6,64(sp)
ffffffffc02007b2:	7be2                	ld	s7,56(sp)
ffffffffc02007b4:	7c42                	ld	s8,48(sp)
ffffffffc02007b6:	7ca2                	ld	s9,40(sp)
ffffffffc02007b8:	7d02                	ld	s10,32(sp)
ffffffffc02007ba:	6de2                	ld	s11,24(sp)
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02007bc:	00005517          	auipc	a0,0x5
ffffffffc02007c0:	27c50513          	addi	a0,a0,636 # ffffffffc0205a38 <commands+0x100>
}
ffffffffc02007c4:	6109                	addi	sp,sp,128
        cprintf("Error: Invalid DTB magic number: 0x%x\n", magic);
ffffffffc02007c6:	b2f9                	j	ffffffffc0200194 <cprintf>
                int name_len = strlen(name);
ffffffffc02007c8:	8556                	mv	a0,s5
ffffffffc02007ca:	639040ef          	jal	ra,ffffffffc0205602 <strlen>
ffffffffc02007ce:	8a2a                	mv	s4,a0
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02007d0:	4619                	li	a2,6
ffffffffc02007d2:	85a6                	mv	a1,s1
ffffffffc02007d4:	8556                	mv	a0,s5
                int name_len = strlen(name);
ffffffffc02007d6:	2a01                	sext.w	s4,s4
                if (strncmp(name, "memory", 6) == 0) {
ffffffffc02007d8:	691040ef          	jal	ra,ffffffffc0205668 <strncmp>
ffffffffc02007dc:	e111                	bnez	a0,ffffffffc02007e0 <dtb_init+0x1e2>
                    in_memory_node = 1;
ffffffffc02007de:	4c85                	li	s9,1
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + name_len + 4) & ~3);
ffffffffc02007e0:	0a91                	addi	s5,s5,4
ffffffffc02007e2:	9ad2                	add	s5,s5,s4
ffffffffc02007e4:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc02007e8:	8a56                	mv	s4,s5
ffffffffc02007ea:	bf2d                	j	ffffffffc0200724 <dtb_init+0x126>
                uint32_t prop_len = fdt32_to_cpu(*struct_ptr++);
ffffffffc02007ec:	004a2783          	lw	a5,4(s4)
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc02007f0:	00ca0693          	addi	a3,s4,12
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02007f4:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02007f8:	01879a9b          	slliw	s5,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02007fc:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200800:	0107171b          	slliw	a4,a4,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200804:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200808:	00caeab3          	or	s5,s5,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020080c:	01877733          	and	a4,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200810:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200814:	00eaeab3          	or	s5,s5,a4
ffffffffc0200818:	00fb77b3          	and	a5,s6,a5
ffffffffc020081c:	00faeab3          	or	s5,s5,a5
ffffffffc0200820:	2a81                	sext.w	s5,s5
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc0200822:	000c9c63          	bnez	s9,ffffffffc020083a <dtb_init+0x23c>
                struct_ptr = (const uint32_t *)(((uintptr_t)struct_ptr + prop_len + 3) & ~3);
ffffffffc0200826:	1a82                	slli	s5,s5,0x20
ffffffffc0200828:	00368793          	addi	a5,a3,3
ffffffffc020082c:	020ada93          	srli	s5,s5,0x20
ffffffffc0200830:	9abe                	add	s5,s5,a5
ffffffffc0200832:	ffcafa93          	andi	s5,s5,-4
        switch (token) {
ffffffffc0200836:	8a56                	mv	s4,s5
ffffffffc0200838:	b5f5                	j	ffffffffc0200724 <dtb_init+0x126>
                uint32_t prop_nameoff = fdt32_to_cpu(*struct_ptr++);
ffffffffc020083a:	008a2783          	lw	a5,8(s4)
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020083e:	85ca                	mv	a1,s2
ffffffffc0200840:	e436                	sd	a3,8(sp)
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200842:	0087d51b          	srliw	a0,a5,0x8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200846:	0187d61b          	srliw	a2,a5,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020084a:	0187971b          	slliw	a4,a5,0x18
ffffffffc020084e:	0105151b          	slliw	a0,a0,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200852:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200856:	8f51                	or	a4,a4,a2
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200858:	01857533          	and	a0,a0,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020085c:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200860:	8d59                	or	a0,a0,a4
ffffffffc0200862:	00fb77b3          	and	a5,s6,a5
ffffffffc0200866:	8d5d                	or	a0,a0,a5
                const char *prop_name = strings_base + prop_nameoff;
ffffffffc0200868:	1502                	slli	a0,a0,0x20
ffffffffc020086a:	9101                	srli	a0,a0,0x20
                if (in_memory_node && strcmp(prop_name, "reg") == 0 && prop_len >= 16) {
ffffffffc020086c:	9522                	add	a0,a0,s0
ffffffffc020086e:	5dd040ef          	jal	ra,ffffffffc020564a <strcmp>
ffffffffc0200872:	66a2                	ld	a3,8(sp)
ffffffffc0200874:	f94d                	bnez	a0,ffffffffc0200826 <dtb_init+0x228>
ffffffffc0200876:	fb59f8e3          	bgeu	s3,s5,ffffffffc0200826 <dtb_init+0x228>
                    *mem_base = fdt64_to_cpu(reg_data[0]);
ffffffffc020087a:	00ca3783          	ld	a5,12(s4)
                    *mem_size = fdt64_to_cpu(reg_data[1]);
ffffffffc020087e:	014a3703          	ld	a4,20(s4)
        cprintf("Physical Memory from DTB:\n");
ffffffffc0200882:	00005517          	auipc	a0,0x5
ffffffffc0200886:	1ee50513          	addi	a0,a0,494 # ffffffffc0205a70 <commands+0x138>
           fdt32_to_cpu(x >> 32);
ffffffffc020088a:	4207d613          	srai	a2,a5,0x20
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020088e:	0087d31b          	srliw	t1,a5,0x8
           fdt32_to_cpu(x >> 32);
ffffffffc0200892:	42075593          	srai	a1,a4,0x20
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200896:	0187de1b          	srliw	t3,a5,0x18
ffffffffc020089a:	0186581b          	srliw	a6,a2,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc020089e:	0187941b          	slliw	s0,a5,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008a2:	0107d89b          	srliw	a7,a5,0x10
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008a6:	0187d693          	srli	a3,a5,0x18
ffffffffc02008aa:	01861f1b          	slliw	t5,a2,0x18
ffffffffc02008ae:	0087579b          	srliw	a5,a4,0x8
ffffffffc02008b2:	0103131b          	slliw	t1,t1,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008b6:	0106561b          	srliw	a2,a2,0x10
ffffffffc02008ba:	010f6f33          	or	t5,t5,a6
ffffffffc02008be:	0187529b          	srliw	t0,a4,0x18
ffffffffc02008c2:	0185df9b          	srliw	t6,a1,0x18
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008c6:	01837333          	and	t1,t1,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008ca:	01c46433          	or	s0,s0,t3
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008ce:	0186f6b3          	and	a3,a3,s8
ffffffffc02008d2:	01859e1b          	slliw	t3,a1,0x18
ffffffffc02008d6:	01871e9b          	slliw	t4,a4,0x18
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008da:	0107581b          	srliw	a6,a4,0x10
ffffffffc02008de:	0086161b          	slliw	a2,a2,0x8
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc02008e2:	8361                	srli	a4,a4,0x18
ffffffffc02008e4:	0107979b          	slliw	a5,a5,0x10
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc02008e8:	0105d59b          	srliw	a1,a1,0x10
ffffffffc02008ec:	01e6e6b3          	or	a3,a3,t5
ffffffffc02008f0:	00cb7633          	and	a2,s6,a2
ffffffffc02008f4:	0088181b          	slliw	a6,a6,0x8
ffffffffc02008f8:	0085959b          	slliw	a1,a1,0x8
ffffffffc02008fc:	00646433          	or	s0,s0,t1
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200900:	0187f7b3          	and	a5,a5,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc0200904:	01fe6333          	or	t1,t3,t6
    return ((x & 0xff) << 24) | (((x >> 8) & 0xff) << 16) | 
ffffffffc0200908:	01877c33          	and	s8,a4,s8
           (((x >> 16) & 0xff) << 8) | ((x >> 24) & 0xff);
ffffffffc020090c:	0088989b          	slliw	a7,a7,0x8
ffffffffc0200910:	011b78b3          	and	a7,s6,a7
ffffffffc0200914:	005eeeb3          	or	t4,t4,t0
ffffffffc0200918:	00c6e733          	or	a4,a3,a2
ffffffffc020091c:	006c6c33          	or	s8,s8,t1
ffffffffc0200920:	010b76b3          	and	a3,s6,a6
ffffffffc0200924:	00bb7b33          	and	s6,s6,a1
ffffffffc0200928:	01d7e7b3          	or	a5,a5,t4
ffffffffc020092c:	016c6b33          	or	s6,s8,s6
ffffffffc0200930:	01146433          	or	s0,s0,a7
ffffffffc0200934:	8fd5                	or	a5,a5,a3
           fdt32_to_cpu(x >> 32);
ffffffffc0200936:	1702                	slli	a4,a4,0x20
ffffffffc0200938:	1b02                	slli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc020093a:	1782                	slli	a5,a5,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc020093c:	9301                	srli	a4,a4,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc020093e:	1402                	slli	s0,s0,0x20
           fdt32_to_cpu(x >> 32);
ffffffffc0200940:	020b5b13          	srli	s6,s6,0x20
    return ((uint64_t)fdt32_to_cpu(x & 0xffffffff) << 32) | 
ffffffffc0200944:	0167eb33          	or	s6,a5,s6
ffffffffc0200948:	8c59                	or	s0,s0,a4
        cprintf("Physical Memory from DTB:\n");
ffffffffc020094a:	84bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        cprintf("  Base: 0x%016lx\n", mem_base);
ffffffffc020094e:	85a2                	mv	a1,s0
ffffffffc0200950:	00005517          	auipc	a0,0x5
ffffffffc0200954:	14050513          	addi	a0,a0,320 # ffffffffc0205a90 <commands+0x158>
ffffffffc0200958:	83dff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        cprintf("  Size: 0x%016lx (%ld MB)\n", mem_size, mem_size / (1024 * 1024));
ffffffffc020095c:	014b5613          	srli	a2,s6,0x14
ffffffffc0200960:	85da                	mv	a1,s6
ffffffffc0200962:	00005517          	auipc	a0,0x5
ffffffffc0200966:	14650513          	addi	a0,a0,326 # ffffffffc0205aa8 <commands+0x170>
ffffffffc020096a:	82bff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        cprintf("  End:  0x%016lx\n", mem_base + mem_size - 1);
ffffffffc020096e:	008b05b3          	add	a1,s6,s0
ffffffffc0200972:	15fd                	addi	a1,a1,-1
ffffffffc0200974:	00005517          	auipc	a0,0x5
ffffffffc0200978:	15450513          	addi	a0,a0,340 # ffffffffc0205ac8 <commands+0x190>
ffffffffc020097c:	819ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("DTB init completed\n");
ffffffffc0200980:	00005517          	auipc	a0,0x5
ffffffffc0200984:	19850513          	addi	a0,a0,408 # ffffffffc0205b18 <commands+0x1e0>
        memory_base = mem_base;
ffffffffc0200988:	000b5797          	auipc	a5,0xb5
ffffffffc020098c:	dc87bc23          	sd	s0,-552(a5) # ffffffffc02b5760 <memory_base>
        memory_size = mem_size;
ffffffffc0200990:	000b5797          	auipc	a5,0xb5
ffffffffc0200994:	dd67bc23          	sd	s6,-552(a5) # ffffffffc02b5768 <memory_size>
    cprintf("DTB init completed\n");
ffffffffc0200998:	b3f5                	j	ffffffffc0200784 <dtb_init+0x186>

ffffffffc020099a <get_memory_base>:

uint64_t get_memory_base(void) {
    return memory_base;
}
ffffffffc020099a:	000b5517          	auipc	a0,0xb5
ffffffffc020099e:	dc653503          	ld	a0,-570(a0) # ffffffffc02b5760 <memory_base>
ffffffffc02009a2:	8082                	ret

ffffffffc02009a4 <get_memory_size>:

uint64_t get_memory_size(void) {
    return memory_size;
}
ffffffffc02009a4:	000b5517          	auipc	a0,0xb5
ffffffffc02009a8:	dc453503          	ld	a0,-572(a0) # ffffffffc02b5768 <memory_size>
ffffffffc02009ac:	8082                	ret

ffffffffc02009ae <intr_enable>:
#include <intr.h>
#include <riscv.h>

/* intr_enable - enable irq interrupt */
void intr_enable(void) { set_csr(sstatus, SSTATUS_SIE); }
ffffffffc02009ae:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc02009b2:	8082                	ret

ffffffffc02009b4 <intr_disable>:

/* intr_disable - disable irq interrupt */
void intr_disable(void) { clear_csr(sstatus, SSTATUS_SIE); }
ffffffffc02009b4:	100177f3          	csrrci	a5,sstatus,2
ffffffffc02009b8:	8082                	ret

ffffffffc02009ba <pic_init>:
#include <picirq.h>

void pic_enable(unsigned int irq) {}

/* pic_init - initialize the 8259A interrupt controllers */
void pic_init(void) {}
ffffffffc02009ba:	8082                	ret

ffffffffc02009bc <idt_init>:
void idt_init(void)
{
    extern void __alltraps(void);
    /* Set sscratch register to 0, indicating to exception vector that we are
     * presently executing in the kernel */
    write_csr(sscratch, 0);
ffffffffc02009bc:	14005073          	csrwi	sscratch,0
    /* Set the exception vector address */
    write_csr(stvec, &__alltraps);
ffffffffc02009c0:	00000797          	auipc	a5,0x0
ffffffffc02009c4:	4bc78793          	addi	a5,a5,1212 # ffffffffc0200e7c <__alltraps>
ffffffffc02009c8:	10579073          	csrw	stvec,a5
    /* Allow kernel to access user memory */
    set_csr(sstatus, SSTATUS_SUM);
ffffffffc02009cc:	000407b7          	lui	a5,0x40
ffffffffc02009d0:	1007a7f3          	csrrs	a5,sstatus,a5
}
ffffffffc02009d4:	8082                	ret

ffffffffc02009d6 <print_regs>:
    cprintf("  cause    0x%08x\n", tf->cause);
}

void print_regs(struct pushregs *gpr)
{
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009d6:	610c                	ld	a1,0(a0)
{
ffffffffc02009d8:	1141                	addi	sp,sp,-16
ffffffffc02009da:	e022                	sd	s0,0(sp)
ffffffffc02009dc:	842a                	mv	s0,a0
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009de:	00005517          	auipc	a0,0x5
ffffffffc02009e2:	15250513          	addi	a0,a0,338 # ffffffffc0205b30 <commands+0x1f8>
{
ffffffffc02009e6:	e406                	sd	ra,8(sp)
    cprintf("  zero     0x%08x\n", gpr->zero);
ffffffffc02009e8:	facff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  ra       0x%08x\n", gpr->ra);
ffffffffc02009ec:	640c                	ld	a1,8(s0)
ffffffffc02009ee:	00005517          	auipc	a0,0x5
ffffffffc02009f2:	15a50513          	addi	a0,a0,346 # ffffffffc0205b48 <commands+0x210>
ffffffffc02009f6:	f9eff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  sp       0x%08x\n", gpr->sp);
ffffffffc02009fa:	680c                	ld	a1,16(s0)
ffffffffc02009fc:	00005517          	auipc	a0,0x5
ffffffffc0200a00:	16450513          	addi	a0,a0,356 # ffffffffc0205b60 <commands+0x228>
ffffffffc0200a04:	f90ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  gp       0x%08x\n", gpr->gp);
ffffffffc0200a08:	6c0c                	ld	a1,24(s0)
ffffffffc0200a0a:	00005517          	auipc	a0,0x5
ffffffffc0200a0e:	16e50513          	addi	a0,a0,366 # ffffffffc0205b78 <commands+0x240>
ffffffffc0200a12:	f82ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  tp       0x%08x\n", gpr->tp);
ffffffffc0200a16:	700c                	ld	a1,32(s0)
ffffffffc0200a18:	00005517          	auipc	a0,0x5
ffffffffc0200a1c:	17850513          	addi	a0,a0,376 # ffffffffc0205b90 <commands+0x258>
ffffffffc0200a20:	f74ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t0       0x%08x\n", gpr->t0);
ffffffffc0200a24:	740c                	ld	a1,40(s0)
ffffffffc0200a26:	00005517          	auipc	a0,0x5
ffffffffc0200a2a:	18250513          	addi	a0,a0,386 # ffffffffc0205ba8 <commands+0x270>
ffffffffc0200a2e:	f66ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t1       0x%08x\n", gpr->t1);
ffffffffc0200a32:	780c                	ld	a1,48(s0)
ffffffffc0200a34:	00005517          	auipc	a0,0x5
ffffffffc0200a38:	18c50513          	addi	a0,a0,396 # ffffffffc0205bc0 <commands+0x288>
ffffffffc0200a3c:	f58ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t2       0x%08x\n", gpr->t2);
ffffffffc0200a40:	7c0c                	ld	a1,56(s0)
ffffffffc0200a42:	00005517          	auipc	a0,0x5
ffffffffc0200a46:	19650513          	addi	a0,a0,406 # ffffffffc0205bd8 <commands+0x2a0>
ffffffffc0200a4a:	f4aff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s0       0x%08x\n", gpr->s0);
ffffffffc0200a4e:	602c                	ld	a1,64(s0)
ffffffffc0200a50:	00005517          	auipc	a0,0x5
ffffffffc0200a54:	1a050513          	addi	a0,a0,416 # ffffffffc0205bf0 <commands+0x2b8>
ffffffffc0200a58:	f3cff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s1       0x%08x\n", gpr->s1);
ffffffffc0200a5c:	642c                	ld	a1,72(s0)
ffffffffc0200a5e:	00005517          	auipc	a0,0x5
ffffffffc0200a62:	1aa50513          	addi	a0,a0,426 # ffffffffc0205c08 <commands+0x2d0>
ffffffffc0200a66:	f2eff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a0       0x%08x\n", gpr->a0);
ffffffffc0200a6a:	682c                	ld	a1,80(s0)
ffffffffc0200a6c:	00005517          	auipc	a0,0x5
ffffffffc0200a70:	1b450513          	addi	a0,a0,436 # ffffffffc0205c20 <commands+0x2e8>
ffffffffc0200a74:	f20ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a1       0x%08x\n", gpr->a1);
ffffffffc0200a78:	6c2c                	ld	a1,88(s0)
ffffffffc0200a7a:	00005517          	auipc	a0,0x5
ffffffffc0200a7e:	1be50513          	addi	a0,a0,446 # ffffffffc0205c38 <commands+0x300>
ffffffffc0200a82:	f12ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a2       0x%08x\n", gpr->a2);
ffffffffc0200a86:	702c                	ld	a1,96(s0)
ffffffffc0200a88:	00005517          	auipc	a0,0x5
ffffffffc0200a8c:	1c850513          	addi	a0,a0,456 # ffffffffc0205c50 <commands+0x318>
ffffffffc0200a90:	f04ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a3       0x%08x\n", gpr->a3);
ffffffffc0200a94:	742c                	ld	a1,104(s0)
ffffffffc0200a96:	00005517          	auipc	a0,0x5
ffffffffc0200a9a:	1d250513          	addi	a0,a0,466 # ffffffffc0205c68 <commands+0x330>
ffffffffc0200a9e:	ef6ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a4       0x%08x\n", gpr->a4);
ffffffffc0200aa2:	782c                	ld	a1,112(s0)
ffffffffc0200aa4:	00005517          	auipc	a0,0x5
ffffffffc0200aa8:	1dc50513          	addi	a0,a0,476 # ffffffffc0205c80 <commands+0x348>
ffffffffc0200aac:	ee8ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a5       0x%08x\n", gpr->a5);
ffffffffc0200ab0:	7c2c                	ld	a1,120(s0)
ffffffffc0200ab2:	00005517          	auipc	a0,0x5
ffffffffc0200ab6:	1e650513          	addi	a0,a0,486 # ffffffffc0205c98 <commands+0x360>
ffffffffc0200aba:	edaff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a6       0x%08x\n", gpr->a6);
ffffffffc0200abe:	604c                	ld	a1,128(s0)
ffffffffc0200ac0:	00005517          	auipc	a0,0x5
ffffffffc0200ac4:	1f050513          	addi	a0,a0,496 # ffffffffc0205cb0 <commands+0x378>
ffffffffc0200ac8:	eccff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  a7       0x%08x\n", gpr->a7);
ffffffffc0200acc:	644c                	ld	a1,136(s0)
ffffffffc0200ace:	00005517          	auipc	a0,0x5
ffffffffc0200ad2:	1fa50513          	addi	a0,a0,506 # ffffffffc0205cc8 <commands+0x390>
ffffffffc0200ad6:	ebeff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s2       0x%08x\n", gpr->s2);
ffffffffc0200ada:	684c                	ld	a1,144(s0)
ffffffffc0200adc:	00005517          	auipc	a0,0x5
ffffffffc0200ae0:	20450513          	addi	a0,a0,516 # ffffffffc0205ce0 <commands+0x3a8>
ffffffffc0200ae4:	eb0ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s3       0x%08x\n", gpr->s3);
ffffffffc0200ae8:	6c4c                	ld	a1,152(s0)
ffffffffc0200aea:	00005517          	auipc	a0,0x5
ffffffffc0200aee:	20e50513          	addi	a0,a0,526 # ffffffffc0205cf8 <commands+0x3c0>
ffffffffc0200af2:	ea2ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s4       0x%08x\n", gpr->s4);
ffffffffc0200af6:	704c                	ld	a1,160(s0)
ffffffffc0200af8:	00005517          	auipc	a0,0x5
ffffffffc0200afc:	21850513          	addi	a0,a0,536 # ffffffffc0205d10 <commands+0x3d8>
ffffffffc0200b00:	e94ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s5       0x%08x\n", gpr->s5);
ffffffffc0200b04:	744c                	ld	a1,168(s0)
ffffffffc0200b06:	00005517          	auipc	a0,0x5
ffffffffc0200b0a:	22250513          	addi	a0,a0,546 # ffffffffc0205d28 <commands+0x3f0>
ffffffffc0200b0e:	e86ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s6       0x%08x\n", gpr->s6);
ffffffffc0200b12:	784c                	ld	a1,176(s0)
ffffffffc0200b14:	00005517          	auipc	a0,0x5
ffffffffc0200b18:	22c50513          	addi	a0,a0,556 # ffffffffc0205d40 <commands+0x408>
ffffffffc0200b1c:	e78ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s7       0x%08x\n", gpr->s7);
ffffffffc0200b20:	7c4c                	ld	a1,184(s0)
ffffffffc0200b22:	00005517          	auipc	a0,0x5
ffffffffc0200b26:	23650513          	addi	a0,a0,566 # ffffffffc0205d58 <commands+0x420>
ffffffffc0200b2a:	e6aff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s8       0x%08x\n", gpr->s8);
ffffffffc0200b2e:	606c                	ld	a1,192(s0)
ffffffffc0200b30:	00005517          	auipc	a0,0x5
ffffffffc0200b34:	24050513          	addi	a0,a0,576 # ffffffffc0205d70 <commands+0x438>
ffffffffc0200b38:	e5cff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s9       0x%08x\n", gpr->s9);
ffffffffc0200b3c:	646c                	ld	a1,200(s0)
ffffffffc0200b3e:	00005517          	auipc	a0,0x5
ffffffffc0200b42:	24a50513          	addi	a0,a0,586 # ffffffffc0205d88 <commands+0x450>
ffffffffc0200b46:	e4eff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s10      0x%08x\n", gpr->s10);
ffffffffc0200b4a:	686c                	ld	a1,208(s0)
ffffffffc0200b4c:	00005517          	auipc	a0,0x5
ffffffffc0200b50:	25450513          	addi	a0,a0,596 # ffffffffc0205da0 <commands+0x468>
ffffffffc0200b54:	e40ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  s11      0x%08x\n", gpr->s11);
ffffffffc0200b58:	6c6c                	ld	a1,216(s0)
ffffffffc0200b5a:	00005517          	auipc	a0,0x5
ffffffffc0200b5e:	25e50513          	addi	a0,a0,606 # ffffffffc0205db8 <commands+0x480>
ffffffffc0200b62:	e32ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t3       0x%08x\n", gpr->t3);
ffffffffc0200b66:	706c                	ld	a1,224(s0)
ffffffffc0200b68:	00005517          	auipc	a0,0x5
ffffffffc0200b6c:	26850513          	addi	a0,a0,616 # ffffffffc0205dd0 <commands+0x498>
ffffffffc0200b70:	e24ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t4       0x%08x\n", gpr->t4);
ffffffffc0200b74:	746c                	ld	a1,232(s0)
ffffffffc0200b76:	00005517          	auipc	a0,0x5
ffffffffc0200b7a:	27250513          	addi	a0,a0,626 # ffffffffc0205de8 <commands+0x4b0>
ffffffffc0200b7e:	e16ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t5       0x%08x\n", gpr->t5);
ffffffffc0200b82:	786c                	ld	a1,240(s0)
ffffffffc0200b84:	00005517          	auipc	a0,0x5
ffffffffc0200b88:	27c50513          	addi	a0,a0,636 # ffffffffc0205e00 <commands+0x4c8>
ffffffffc0200b8c:	e08ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b90:	7c6c                	ld	a1,248(s0)
}
ffffffffc0200b92:	6402                	ld	s0,0(sp)
ffffffffc0200b94:	60a2                	ld	ra,8(sp)
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200b96:	00005517          	auipc	a0,0x5
ffffffffc0200b9a:	28250513          	addi	a0,a0,642 # ffffffffc0205e18 <commands+0x4e0>
}
ffffffffc0200b9e:	0141                	addi	sp,sp,16
    cprintf("  t6       0x%08x\n", gpr->t6);
ffffffffc0200ba0:	df4ff06f          	j	ffffffffc0200194 <cprintf>

ffffffffc0200ba4 <print_trapframe>:
{
ffffffffc0200ba4:	1141                	addi	sp,sp,-16
ffffffffc0200ba6:	e022                	sd	s0,0(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200ba8:	85aa                	mv	a1,a0
{
ffffffffc0200baa:	842a                	mv	s0,a0
    cprintf("trapframe at %p\n", tf);
ffffffffc0200bac:	00005517          	auipc	a0,0x5
ffffffffc0200bb0:	28450513          	addi	a0,a0,644 # ffffffffc0205e30 <commands+0x4f8>
{
ffffffffc0200bb4:	e406                	sd	ra,8(sp)
    cprintf("trapframe at %p\n", tf);
ffffffffc0200bb6:	ddeff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    print_regs(&tf->gpr);
ffffffffc0200bba:	8522                	mv	a0,s0
ffffffffc0200bbc:	e1bff0ef          	jal	ra,ffffffffc02009d6 <print_regs>
    cprintf("  status   0x%08x\n", tf->status);
ffffffffc0200bc0:	10043583          	ld	a1,256(s0)
ffffffffc0200bc4:	00005517          	auipc	a0,0x5
ffffffffc0200bc8:	28450513          	addi	a0,a0,644 # ffffffffc0205e48 <commands+0x510>
ffffffffc0200bcc:	dc8ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  epc      0x%08x\n", tf->epc);
ffffffffc0200bd0:	10843583          	ld	a1,264(s0)
ffffffffc0200bd4:	00005517          	auipc	a0,0x5
ffffffffc0200bd8:	28c50513          	addi	a0,a0,652 # ffffffffc0205e60 <commands+0x528>
ffffffffc0200bdc:	db8ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  tval 0x%08x\n", tf->tval);
ffffffffc0200be0:	11043583          	ld	a1,272(s0)
ffffffffc0200be4:	00005517          	auipc	a0,0x5
ffffffffc0200be8:	29450513          	addi	a0,a0,660 # ffffffffc0205e78 <commands+0x540>
ffffffffc0200bec:	da8ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bf0:	11843583          	ld	a1,280(s0)
}
ffffffffc0200bf4:	6402                	ld	s0,0(sp)
ffffffffc0200bf6:	60a2                	ld	ra,8(sp)
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200bf8:	00005517          	auipc	a0,0x5
ffffffffc0200bfc:	29050513          	addi	a0,a0,656 # ffffffffc0205e88 <commands+0x550>
}
ffffffffc0200c00:	0141                	addi	sp,sp,16
    cprintf("  cause    0x%08x\n", tf->cause);
ffffffffc0200c02:	d92ff06f          	j	ffffffffc0200194 <cprintf>

ffffffffc0200c06 <interrupt_handler>:

extern struct mm_struct *check_mm_struct;

void interrupt_handler(struct trapframe *tf)
{
    intptr_t cause = (tf->cause << 1) >> 1;
ffffffffc0200c06:	11853783          	ld	a5,280(a0)
ffffffffc0200c0a:	472d                	li	a4,11
ffffffffc0200c0c:	0786                	slli	a5,a5,0x1
ffffffffc0200c0e:	8385                	srli	a5,a5,0x1
ffffffffc0200c10:	08f76363          	bltu	a4,a5,ffffffffc0200c96 <interrupt_handler+0x90>
ffffffffc0200c14:	00005717          	auipc	a4,0x5
ffffffffc0200c18:	33c70713          	addi	a4,a4,828 # ffffffffc0205f50 <commands+0x618>
ffffffffc0200c1c:	078a                	slli	a5,a5,0x2
ffffffffc0200c1e:	97ba                	add	a5,a5,a4
ffffffffc0200c20:	439c                	lw	a5,0(a5)
ffffffffc0200c22:	97ba                	add	a5,a5,a4
ffffffffc0200c24:	8782                	jr	a5
        break;
    case IRQ_H_SOFT:
        cprintf("Hypervisor software interrupt\n");
        break;
    case IRQ_M_SOFT:
        cprintf("Machine software interrupt\n");
ffffffffc0200c26:	00005517          	auipc	a0,0x5
ffffffffc0200c2a:	2da50513          	addi	a0,a0,730 # ffffffffc0205f00 <commands+0x5c8>
ffffffffc0200c2e:	d66ff06f          	j	ffffffffc0200194 <cprintf>
        cprintf("Hypervisor software interrupt\n");
ffffffffc0200c32:	00005517          	auipc	a0,0x5
ffffffffc0200c36:	2ae50513          	addi	a0,a0,686 # ffffffffc0205ee0 <commands+0x5a8>
ffffffffc0200c3a:	d5aff06f          	j	ffffffffc0200194 <cprintf>
        cprintf("User software interrupt\n");
ffffffffc0200c3e:	00005517          	auipc	a0,0x5
ffffffffc0200c42:	26250513          	addi	a0,a0,610 # ffffffffc0205ea0 <commands+0x568>
ffffffffc0200c46:	d4eff06f          	j	ffffffffc0200194 <cprintf>
        cprintf("Supervisor software interrupt\n");
ffffffffc0200c4a:	00005517          	auipc	a0,0x5
ffffffffc0200c4e:	27650513          	addi	a0,a0,630 # ffffffffc0205ec0 <commands+0x588>
ffffffffc0200c52:	d42ff06f          	j	ffffffffc0200194 <cprintf>
{
ffffffffc0200c56:	1141                	addi	sp,sp,-16
ffffffffc0200c58:	e406                	sd	ra,8(sp)
        /*(1)设置下次时钟中断- clock_set_next_event()
         *(2)计数器（ticks）加一
         *(3)当计数器加到100的时候，我们会输出一个`100ticks`表示我们触发了100次时钟中断，同时打印次数（num）加一
         * (4)判断打印次数，当打印次数为10时，调用<sbi.h>中的关机函数关机
         */
                 clock_set_next_event();
ffffffffc0200c5a:	919ff0ef          	jal	ra,ffffffffc0200572 <clock_set_next_event>
        // 计数器（ticks）加一
        ticks++;
ffffffffc0200c5e:	000b5797          	auipc	a5,0xb5
ffffffffc0200c62:	af278793          	addi	a5,a5,-1294 # ffffffffc02b5750 <ticks>
ffffffffc0200c66:	6398                	ld	a4,0(a5)
ffffffffc0200c68:	0705                	addi	a4,a4,1
ffffffffc0200c6a:	e398                	sd	a4,0(a5)
        // 静态变量用于记录打印次数
        static int print_count = 0;
        // 当计数器达到100时
        if (ticks % TICK_NUM==0) {
ffffffffc0200c6c:	639c                	ld	a5,0(a5)
ffffffffc0200c6e:	06400713          	li	a4,100
ffffffffc0200c72:	02e7f7b3          	remu	a5,a5,a4
ffffffffc0200c76:	c38d                	beqz	a5,ffffffffc0200c98 <interrupt_handler+0x92>
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200c78:	60a2                	ld	ra,8(sp)
        current->need_resched = 1;
ffffffffc0200c7a:	000b5797          	auipc	a5,0xb5
ffffffffc0200c7e:	b367b783          	ld	a5,-1226(a5) # ffffffffc02b57b0 <current>
ffffffffc0200c82:	4705                	li	a4,1
ffffffffc0200c84:	ef98                	sd	a4,24(a5)
}
ffffffffc0200c86:	0141                	addi	sp,sp,16
ffffffffc0200c88:	8082                	ret
        cprintf("Supervisor external interrupt\n");
ffffffffc0200c8a:	00005517          	auipc	a0,0x5
ffffffffc0200c8e:	2a650513          	addi	a0,a0,678 # ffffffffc0205f30 <commands+0x5f8>
ffffffffc0200c92:	d02ff06f          	j	ffffffffc0200194 <cprintf>
        print_trapframe(tf);
ffffffffc0200c96:	b739                	j	ffffffffc0200ba4 <print_trapframe>
    cprintf("%d ticks\n", TICK_NUM);
ffffffffc0200c98:	06400593          	li	a1,100
ffffffffc0200c9c:	00005517          	auipc	a0,0x5
ffffffffc0200ca0:	28450513          	addi	a0,a0,644 # ffffffffc0205f20 <commands+0x5e8>
ffffffffc0200ca4:	cf0ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
            print_count++;
ffffffffc0200ca8:	000b5717          	auipc	a4,0xb5
ffffffffc0200cac:	ac870713          	addi	a4,a4,-1336 # ffffffffc02b5770 <print_count.0>
ffffffffc0200cb0:	431c                	lw	a5,0(a4)
            ticks = 0;
ffffffffc0200cb2:	000b5697          	auipc	a3,0xb5
ffffffffc0200cb6:	a806bf23          	sd	zero,-1378(a3) # ffffffffc02b5750 <ticks>
            if (print_count >= 10) {
ffffffffc0200cba:	46a5                	li	a3,9
            print_count++;
ffffffffc0200cbc:	0017861b          	addiw	a2,a5,1
ffffffffc0200cc0:	c310                	sw	a2,0(a4)
            if (print_count >= 10) {
ffffffffc0200cc2:	fac6dbe3          	bge	a3,a2,ffffffffc0200c78 <interrupt_handler+0x72>
	SBI_CALL_0(SBI_SHUTDOWN);
ffffffffc0200cc6:	4501                	li	a0,0
ffffffffc0200cc8:	4581                	li	a1,0
ffffffffc0200cca:	4601                	li	a2,0
ffffffffc0200ccc:	48a1                	li	a7,8
ffffffffc0200cce:	00000073          	ecall
}
ffffffffc0200cd2:	b75d                	j	ffffffffc0200c78 <interrupt_handler+0x72>

ffffffffc0200cd4 <exception_handler>:
void kernel_execve_ret(struct trapframe *tf, uintptr_t kstacktop);
void exception_handler(struct trapframe *tf)
{
    int ret;
    switch (tf->cause)
ffffffffc0200cd4:	11853783          	ld	a5,280(a0)
{
ffffffffc0200cd8:	1141                	addi	sp,sp,-16
ffffffffc0200cda:	e022                	sd	s0,0(sp)
ffffffffc0200cdc:	e406                	sd	ra,8(sp)
ffffffffc0200cde:	473d                	li	a4,15
ffffffffc0200ce0:	842a                	mv	s0,a0
ffffffffc0200ce2:	0cf76463          	bltu	a4,a5,ffffffffc0200daa <exception_handler+0xd6>
ffffffffc0200ce6:	00005717          	auipc	a4,0x5
ffffffffc0200cea:	42a70713          	addi	a4,a4,1066 # ffffffffc0206110 <commands+0x7d8>
ffffffffc0200cee:	078a                	slli	a5,a5,0x2
ffffffffc0200cf0:	97ba                	add	a5,a5,a4
ffffffffc0200cf2:	439c                	lw	a5,0(a5)
ffffffffc0200cf4:	97ba                	add	a5,a5,a4
ffffffffc0200cf6:	8782                	jr	a5
        // cprintf("Environment call from U-mode\n");
        tf->epc += 4;
        syscall();
        break;
    case CAUSE_SUPERVISOR_ECALL:
        cprintf("Environment call from S-mode\n");
ffffffffc0200cf8:	00005517          	auipc	a0,0x5
ffffffffc0200cfc:	37050513          	addi	a0,a0,880 # ffffffffc0206068 <commands+0x730>
ffffffffc0200d00:	c94ff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        tf->epc += 4;
ffffffffc0200d04:	10843783          	ld	a5,264(s0)
        break;
    default:
        print_trapframe(tf);
        break;
    }
}
ffffffffc0200d08:	60a2                	ld	ra,8(sp)
        tf->epc += 4;
ffffffffc0200d0a:	0791                	addi	a5,a5,4
ffffffffc0200d0c:	10f43423          	sd	a5,264(s0)
}
ffffffffc0200d10:	6402                	ld	s0,0(sp)
ffffffffc0200d12:	0141                	addi	sp,sp,16
        syscall();
ffffffffc0200d14:	46a0406f          	j	ffffffffc020517e <syscall>
        cprintf("Environment call from H-mode\n");
ffffffffc0200d18:	00005517          	auipc	a0,0x5
ffffffffc0200d1c:	37050513          	addi	a0,a0,880 # ffffffffc0206088 <commands+0x750>
}
ffffffffc0200d20:	6402                	ld	s0,0(sp)
ffffffffc0200d22:	60a2                	ld	ra,8(sp)
ffffffffc0200d24:	0141                	addi	sp,sp,16
        cprintf("Instruction access fault\n");
ffffffffc0200d26:	c6eff06f          	j	ffffffffc0200194 <cprintf>
        cprintf("Environment call from M-mode\n");
ffffffffc0200d2a:	00005517          	auipc	a0,0x5
ffffffffc0200d2e:	37e50513          	addi	a0,a0,894 # ffffffffc02060a8 <commands+0x770>
ffffffffc0200d32:	b7fd                	j	ffffffffc0200d20 <exception_handler+0x4c>
        cprintf("Instruction page fault\n");
ffffffffc0200d34:	00005517          	auipc	a0,0x5
ffffffffc0200d38:	39450513          	addi	a0,a0,916 # ffffffffc02060c8 <commands+0x790>
ffffffffc0200d3c:	b7d5                	j	ffffffffc0200d20 <exception_handler+0x4c>
        cprintf("Load page fault\n");
ffffffffc0200d3e:	00005517          	auipc	a0,0x5
ffffffffc0200d42:	3a250513          	addi	a0,a0,930 # ffffffffc02060e0 <commands+0x7a8>
ffffffffc0200d46:	bfe9                	j	ffffffffc0200d20 <exception_handler+0x4c>
        cprintf("Store/AMO page fault\n");
ffffffffc0200d48:	00005517          	auipc	a0,0x5
ffffffffc0200d4c:	3b050513          	addi	a0,a0,944 # ffffffffc02060f8 <commands+0x7c0>
ffffffffc0200d50:	bfc1                	j	ffffffffc0200d20 <exception_handler+0x4c>
        cprintf("Instruction address misaligned\n");
ffffffffc0200d52:	00005517          	auipc	a0,0x5
ffffffffc0200d56:	22e50513          	addi	a0,a0,558 # ffffffffc0205f80 <commands+0x648>
ffffffffc0200d5a:	b7d9                	j	ffffffffc0200d20 <exception_handler+0x4c>
        cprintf("Instruction access fault\n");
ffffffffc0200d5c:	00005517          	auipc	a0,0x5
ffffffffc0200d60:	24450513          	addi	a0,a0,580 # ffffffffc0205fa0 <commands+0x668>
ffffffffc0200d64:	bf75                	j	ffffffffc0200d20 <exception_handler+0x4c>
        cprintf("Illegal instruction\n");
ffffffffc0200d66:	00005517          	auipc	a0,0x5
ffffffffc0200d6a:	25a50513          	addi	a0,a0,602 # ffffffffc0205fc0 <commands+0x688>
ffffffffc0200d6e:	bf4d                	j	ffffffffc0200d20 <exception_handler+0x4c>
        cprintf("Breakpoint\n");
ffffffffc0200d70:	00005517          	auipc	a0,0x5
ffffffffc0200d74:	26850513          	addi	a0,a0,616 # ffffffffc0205fd8 <commands+0x6a0>
ffffffffc0200d78:	c1cff0ef          	jal	ra,ffffffffc0200194 <cprintf>
        if (tf->gpr.a7 == 10)
ffffffffc0200d7c:	6458                	ld	a4,136(s0)
ffffffffc0200d7e:	47a9                	li	a5,10
ffffffffc0200d80:	04f70663          	beq	a4,a5,ffffffffc0200dcc <exception_handler+0xf8>
}
ffffffffc0200d84:	60a2                	ld	ra,8(sp)
ffffffffc0200d86:	6402                	ld	s0,0(sp)
ffffffffc0200d88:	0141                	addi	sp,sp,16
ffffffffc0200d8a:	8082                	ret
        cprintf("Load address misaligned\n");
ffffffffc0200d8c:	00005517          	auipc	a0,0x5
ffffffffc0200d90:	25c50513          	addi	a0,a0,604 # ffffffffc0205fe8 <commands+0x6b0>
ffffffffc0200d94:	b771                	j	ffffffffc0200d20 <exception_handler+0x4c>
        cprintf("Load access fault\n");
ffffffffc0200d96:	00005517          	auipc	a0,0x5
ffffffffc0200d9a:	27250513          	addi	a0,a0,626 # ffffffffc0206008 <commands+0x6d0>
ffffffffc0200d9e:	b749                	j	ffffffffc0200d20 <exception_handler+0x4c>
        cprintf("Store/AMO access fault\n");
ffffffffc0200da0:	00005517          	auipc	a0,0x5
ffffffffc0200da4:	2b050513          	addi	a0,a0,688 # ffffffffc0206050 <commands+0x718>
ffffffffc0200da8:	bfa5                	j	ffffffffc0200d20 <exception_handler+0x4c>
        print_trapframe(tf);
ffffffffc0200daa:	8522                	mv	a0,s0
}
ffffffffc0200dac:	6402                	ld	s0,0(sp)
ffffffffc0200dae:	60a2                	ld	ra,8(sp)
ffffffffc0200db0:	0141                	addi	sp,sp,16
        print_trapframe(tf);
ffffffffc0200db2:	bbcd                	j	ffffffffc0200ba4 <print_trapframe>
        panic("AMO address misaligned\n");
ffffffffc0200db4:	00005617          	auipc	a2,0x5
ffffffffc0200db8:	26c60613          	addi	a2,a2,620 # ffffffffc0206020 <commands+0x6e8>
ffffffffc0200dbc:	0cc00593          	li	a1,204
ffffffffc0200dc0:	00005517          	auipc	a0,0x5
ffffffffc0200dc4:	27850513          	addi	a0,a0,632 # ffffffffc0206038 <commands+0x700>
ffffffffc0200dc8:	ec6ff0ef          	jal	ra,ffffffffc020048e <__panic>
            tf->epc += 4;
ffffffffc0200dcc:	10843783          	ld	a5,264(s0)
ffffffffc0200dd0:	0791                	addi	a5,a5,4
ffffffffc0200dd2:	10f43423          	sd	a5,264(s0)
            syscall();
ffffffffc0200dd6:	3a8040ef          	jal	ra,ffffffffc020517e <syscall>
            kernel_execve_ret(tf, current->kstack + KSTACKSIZE);
ffffffffc0200dda:	000b5797          	auipc	a5,0xb5
ffffffffc0200dde:	9d67b783          	ld	a5,-1578(a5) # ffffffffc02b57b0 <current>
ffffffffc0200de2:	6b9c                	ld	a5,16(a5)
ffffffffc0200de4:	8522                	mv	a0,s0
}
ffffffffc0200de6:	6402                	ld	s0,0(sp)
ffffffffc0200de8:	60a2                	ld	ra,8(sp)
            kernel_execve_ret(tf, current->kstack + KSTACKSIZE);
ffffffffc0200dea:	6589                	lui	a1,0x2
ffffffffc0200dec:	95be                	add	a1,a1,a5
}
ffffffffc0200dee:	0141                	addi	sp,sp,16
            kernel_execve_ret(tf, current->kstack + KSTACKSIZE);
ffffffffc0200df0:	aaa9                	j	ffffffffc0200f4a <kernel_execve_ret>

ffffffffc0200df2 <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void trap(struct trapframe *tf)
{
ffffffffc0200df2:	1101                	addi	sp,sp,-32
ffffffffc0200df4:	e822                	sd	s0,16(sp)
    // dispatch based on what type of trap occurred
    //    cputs("some trap");
    if (current == NULL)
ffffffffc0200df6:	000b5417          	auipc	s0,0xb5
ffffffffc0200dfa:	9ba40413          	addi	s0,s0,-1606 # ffffffffc02b57b0 <current>
ffffffffc0200dfe:	6018                	ld	a4,0(s0)
{
ffffffffc0200e00:	ec06                	sd	ra,24(sp)
ffffffffc0200e02:	e426                	sd	s1,8(sp)
ffffffffc0200e04:	e04a                	sd	s2,0(sp)
    if ((intptr_t)tf->cause < 0)
ffffffffc0200e06:	11853683          	ld	a3,280(a0)
    if (current == NULL)
ffffffffc0200e0a:	cf1d                	beqz	a4,ffffffffc0200e48 <trap+0x56>
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200e0c:	10053483          	ld	s1,256(a0)
    {
        trap_dispatch(tf);
    }
    else
    {
        struct trapframe *otf = current->tf;
ffffffffc0200e10:	0a073903          	ld	s2,160(a4)
        current->tf = tf;
ffffffffc0200e14:	f348                	sd	a0,160(a4)
    return (tf->status & SSTATUS_SPP) != 0;
ffffffffc0200e16:	1004f493          	andi	s1,s1,256
    if ((intptr_t)tf->cause < 0)
ffffffffc0200e1a:	0206c463          	bltz	a3,ffffffffc0200e42 <trap+0x50>
        exception_handler(tf);
ffffffffc0200e1e:	eb7ff0ef          	jal	ra,ffffffffc0200cd4 <exception_handler>

        bool in_kernel = trap_in_kernel(tf);

        trap_dispatch(tf);

        current->tf = otf;
ffffffffc0200e22:	601c                	ld	a5,0(s0)
ffffffffc0200e24:	0b27b023          	sd	s2,160(a5)
        if (!in_kernel)
ffffffffc0200e28:	e499                	bnez	s1,ffffffffc0200e36 <trap+0x44>
        {
            if (current->flags & PF_EXITING)
ffffffffc0200e2a:	0b07a703          	lw	a4,176(a5)
ffffffffc0200e2e:	8b05                	andi	a4,a4,1
ffffffffc0200e30:	e329                	bnez	a4,ffffffffc0200e72 <trap+0x80>
            {
                do_exit(-E_KILLED);
            }
            if (current->need_resched)
ffffffffc0200e32:	6f9c                	ld	a5,24(a5)
ffffffffc0200e34:	eb85                	bnez	a5,ffffffffc0200e64 <trap+0x72>
            {
                schedule();
            }
        }
    }
}
ffffffffc0200e36:	60e2                	ld	ra,24(sp)
ffffffffc0200e38:	6442                	ld	s0,16(sp)
ffffffffc0200e3a:	64a2                	ld	s1,8(sp)
ffffffffc0200e3c:	6902                	ld	s2,0(sp)
ffffffffc0200e3e:	6105                	addi	sp,sp,32
ffffffffc0200e40:	8082                	ret
        interrupt_handler(tf);
ffffffffc0200e42:	dc5ff0ef          	jal	ra,ffffffffc0200c06 <interrupt_handler>
ffffffffc0200e46:	bff1                	j	ffffffffc0200e22 <trap+0x30>
    if ((intptr_t)tf->cause < 0)
ffffffffc0200e48:	0006c863          	bltz	a3,ffffffffc0200e58 <trap+0x66>
}
ffffffffc0200e4c:	6442                	ld	s0,16(sp)
ffffffffc0200e4e:	60e2                	ld	ra,24(sp)
ffffffffc0200e50:	64a2                	ld	s1,8(sp)
ffffffffc0200e52:	6902                	ld	s2,0(sp)
ffffffffc0200e54:	6105                	addi	sp,sp,32
        exception_handler(tf);
ffffffffc0200e56:	bdbd                	j	ffffffffc0200cd4 <exception_handler>
}
ffffffffc0200e58:	6442                	ld	s0,16(sp)
ffffffffc0200e5a:	60e2                	ld	ra,24(sp)
ffffffffc0200e5c:	64a2                	ld	s1,8(sp)
ffffffffc0200e5e:	6902                	ld	s2,0(sp)
ffffffffc0200e60:	6105                	addi	sp,sp,32
        interrupt_handler(tf);
ffffffffc0200e62:	b355                	j	ffffffffc0200c06 <interrupt_handler>
}
ffffffffc0200e64:	6442                	ld	s0,16(sp)
ffffffffc0200e66:	60e2                	ld	ra,24(sp)
ffffffffc0200e68:	64a2                	ld	s1,8(sp)
ffffffffc0200e6a:	6902                	ld	s2,0(sp)
ffffffffc0200e6c:	6105                	addi	sp,sp,32
                schedule();
ffffffffc0200e6e:	2240406f          	j	ffffffffc0205092 <schedule>
                do_exit(-E_KILLED);
ffffffffc0200e72:	555d                	li	a0,-9
ffffffffc0200e74:	564030ef          	jal	ra,ffffffffc02043d8 <do_exit>
            if (current->need_resched)
ffffffffc0200e78:	601c                	ld	a5,0(s0)
ffffffffc0200e7a:	bf65                	j	ffffffffc0200e32 <trap+0x40>

ffffffffc0200e7c <__alltraps>:
    LOAD x2, 2*REGBYTES(sp)
    .endm

    .globl __alltraps
__alltraps:
    SAVE_ALL
ffffffffc0200e7c:	14011173          	csrrw	sp,sscratch,sp
ffffffffc0200e80:	00011463          	bnez	sp,ffffffffc0200e88 <__alltraps+0xc>
ffffffffc0200e84:	14002173          	csrr	sp,sscratch
ffffffffc0200e88:	712d                	addi	sp,sp,-288
ffffffffc0200e8a:	e002                	sd	zero,0(sp)
ffffffffc0200e8c:	e406                	sd	ra,8(sp)
ffffffffc0200e8e:	ec0e                	sd	gp,24(sp)
ffffffffc0200e90:	f012                	sd	tp,32(sp)
ffffffffc0200e92:	f416                	sd	t0,40(sp)
ffffffffc0200e94:	f81a                	sd	t1,48(sp)
ffffffffc0200e96:	fc1e                	sd	t2,56(sp)
ffffffffc0200e98:	e0a2                	sd	s0,64(sp)
ffffffffc0200e9a:	e4a6                	sd	s1,72(sp)
ffffffffc0200e9c:	e8aa                	sd	a0,80(sp)
ffffffffc0200e9e:	ecae                	sd	a1,88(sp)
ffffffffc0200ea0:	f0b2                	sd	a2,96(sp)
ffffffffc0200ea2:	f4b6                	sd	a3,104(sp)
ffffffffc0200ea4:	f8ba                	sd	a4,112(sp)
ffffffffc0200ea6:	fcbe                	sd	a5,120(sp)
ffffffffc0200ea8:	e142                	sd	a6,128(sp)
ffffffffc0200eaa:	e546                	sd	a7,136(sp)
ffffffffc0200eac:	e94a                	sd	s2,144(sp)
ffffffffc0200eae:	ed4e                	sd	s3,152(sp)
ffffffffc0200eb0:	f152                	sd	s4,160(sp)
ffffffffc0200eb2:	f556                	sd	s5,168(sp)
ffffffffc0200eb4:	f95a                	sd	s6,176(sp)
ffffffffc0200eb6:	fd5e                	sd	s7,184(sp)
ffffffffc0200eb8:	e1e2                	sd	s8,192(sp)
ffffffffc0200eba:	e5e6                	sd	s9,200(sp)
ffffffffc0200ebc:	e9ea                	sd	s10,208(sp)
ffffffffc0200ebe:	edee                	sd	s11,216(sp)
ffffffffc0200ec0:	f1f2                	sd	t3,224(sp)
ffffffffc0200ec2:	f5f6                	sd	t4,232(sp)
ffffffffc0200ec4:	f9fa                	sd	t5,240(sp)
ffffffffc0200ec6:	fdfe                	sd	t6,248(sp)
ffffffffc0200ec8:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0200ecc:	100024f3          	csrr	s1,sstatus
ffffffffc0200ed0:	14102973          	csrr	s2,sepc
ffffffffc0200ed4:	143029f3          	csrr	s3,stval
ffffffffc0200ed8:	14202a73          	csrr	s4,scause
ffffffffc0200edc:	e822                	sd	s0,16(sp)
ffffffffc0200ede:	e226                	sd	s1,256(sp)
ffffffffc0200ee0:	e64a                	sd	s2,264(sp)
ffffffffc0200ee2:	ea4e                	sd	s3,272(sp)
ffffffffc0200ee4:	ee52                	sd	s4,280(sp)

    move  a0, sp
ffffffffc0200ee6:	850a                	mv	a0,sp
    jal trap
ffffffffc0200ee8:	f0bff0ef          	jal	ra,ffffffffc0200df2 <trap>

ffffffffc0200eec <__trapret>:
    # sp should be the same as before "jal trap"

    .globl __trapret
__trapret:
    RESTORE_ALL
ffffffffc0200eec:	6492                	ld	s1,256(sp)
ffffffffc0200eee:	6932                	ld	s2,264(sp)
ffffffffc0200ef0:	1004f413          	andi	s0,s1,256
ffffffffc0200ef4:	e401                	bnez	s0,ffffffffc0200efc <__trapret+0x10>
ffffffffc0200ef6:	1200                	addi	s0,sp,288
ffffffffc0200ef8:	14041073          	csrw	sscratch,s0
ffffffffc0200efc:	10049073          	csrw	sstatus,s1
ffffffffc0200f00:	14191073          	csrw	sepc,s2
ffffffffc0200f04:	60a2                	ld	ra,8(sp)
ffffffffc0200f06:	61e2                	ld	gp,24(sp)
ffffffffc0200f08:	7202                	ld	tp,32(sp)
ffffffffc0200f0a:	72a2                	ld	t0,40(sp)
ffffffffc0200f0c:	7342                	ld	t1,48(sp)
ffffffffc0200f0e:	73e2                	ld	t2,56(sp)
ffffffffc0200f10:	6406                	ld	s0,64(sp)
ffffffffc0200f12:	64a6                	ld	s1,72(sp)
ffffffffc0200f14:	6546                	ld	a0,80(sp)
ffffffffc0200f16:	65e6                	ld	a1,88(sp)
ffffffffc0200f18:	7606                	ld	a2,96(sp)
ffffffffc0200f1a:	76a6                	ld	a3,104(sp)
ffffffffc0200f1c:	7746                	ld	a4,112(sp)
ffffffffc0200f1e:	77e6                	ld	a5,120(sp)
ffffffffc0200f20:	680a                	ld	a6,128(sp)
ffffffffc0200f22:	68aa                	ld	a7,136(sp)
ffffffffc0200f24:	694a                	ld	s2,144(sp)
ffffffffc0200f26:	69ea                	ld	s3,152(sp)
ffffffffc0200f28:	7a0a                	ld	s4,160(sp)
ffffffffc0200f2a:	7aaa                	ld	s5,168(sp)
ffffffffc0200f2c:	7b4a                	ld	s6,176(sp)
ffffffffc0200f2e:	7bea                	ld	s7,184(sp)
ffffffffc0200f30:	6c0e                	ld	s8,192(sp)
ffffffffc0200f32:	6cae                	ld	s9,200(sp)
ffffffffc0200f34:	6d4e                	ld	s10,208(sp)
ffffffffc0200f36:	6dee                	ld	s11,216(sp)
ffffffffc0200f38:	7e0e                	ld	t3,224(sp)
ffffffffc0200f3a:	7eae                	ld	t4,232(sp)
ffffffffc0200f3c:	7f4e                	ld	t5,240(sp)
ffffffffc0200f3e:	7fee                	ld	t6,248(sp)
ffffffffc0200f40:	6142                	ld	sp,16(sp)
    # return from supervisor call
    sret
ffffffffc0200f42:	10200073          	sret

ffffffffc0200f46 <forkrets>:
 
    .globl forkrets
forkrets:
    # set stack to this new process's trapframe
    move sp, a0
ffffffffc0200f46:	812a                	mv	sp,a0
    j __trapret
ffffffffc0200f48:	b755                	j	ffffffffc0200eec <__trapret>

ffffffffc0200f4a <kernel_execve_ret>:

    .global kernel_execve_ret
kernel_execve_ret:
    // adjust sp to beneath kstacktop of current process
    addi a1, a1, -36*REGBYTES
ffffffffc0200f4a:	ee058593          	addi	a1,a1,-288 # 1ee0 <_binary_obj___user_faultread_out_size-0x7cd0>

    // copy from previous trapframe to new trapframe
    LOAD s1, 35*REGBYTES(a0)
ffffffffc0200f4e:	11853483          	ld	s1,280(a0)
    STORE s1, 35*REGBYTES(a1)
ffffffffc0200f52:	1095bc23          	sd	s1,280(a1)
    LOAD s1, 34*REGBYTES(a0)
ffffffffc0200f56:	11053483          	ld	s1,272(a0)
    STORE s1, 34*REGBYTES(a1)
ffffffffc0200f5a:	1095b823          	sd	s1,272(a1)
    LOAD s1, 33*REGBYTES(a0)
ffffffffc0200f5e:	10853483          	ld	s1,264(a0)
    STORE s1, 33*REGBYTES(a1)
ffffffffc0200f62:	1095b423          	sd	s1,264(a1)
    LOAD s1, 32*REGBYTES(a0)
ffffffffc0200f66:	10053483          	ld	s1,256(a0)
    STORE s1, 32*REGBYTES(a1)
ffffffffc0200f6a:	1095b023          	sd	s1,256(a1)
    LOAD s1, 31*REGBYTES(a0)
ffffffffc0200f6e:	7d64                	ld	s1,248(a0)
    STORE s1, 31*REGBYTES(a1)
ffffffffc0200f70:	fde4                	sd	s1,248(a1)
    LOAD s1, 30*REGBYTES(a0)
ffffffffc0200f72:	7964                	ld	s1,240(a0)
    STORE s1, 30*REGBYTES(a1)
ffffffffc0200f74:	f9e4                	sd	s1,240(a1)
    LOAD s1, 29*REGBYTES(a0)
ffffffffc0200f76:	7564                	ld	s1,232(a0)
    STORE s1, 29*REGBYTES(a1)
ffffffffc0200f78:	f5e4                	sd	s1,232(a1)
    LOAD s1, 28*REGBYTES(a0)
ffffffffc0200f7a:	7164                	ld	s1,224(a0)
    STORE s1, 28*REGBYTES(a1)
ffffffffc0200f7c:	f1e4                	sd	s1,224(a1)
    LOAD s1, 27*REGBYTES(a0)
ffffffffc0200f7e:	6d64                	ld	s1,216(a0)
    STORE s1, 27*REGBYTES(a1)
ffffffffc0200f80:	ede4                	sd	s1,216(a1)
    LOAD s1, 26*REGBYTES(a0)
ffffffffc0200f82:	6964                	ld	s1,208(a0)
    STORE s1, 26*REGBYTES(a1)
ffffffffc0200f84:	e9e4                	sd	s1,208(a1)
    LOAD s1, 25*REGBYTES(a0)
ffffffffc0200f86:	6564                	ld	s1,200(a0)
    STORE s1, 25*REGBYTES(a1)
ffffffffc0200f88:	e5e4                	sd	s1,200(a1)
    LOAD s1, 24*REGBYTES(a0)
ffffffffc0200f8a:	6164                	ld	s1,192(a0)
    STORE s1, 24*REGBYTES(a1)
ffffffffc0200f8c:	e1e4                	sd	s1,192(a1)
    LOAD s1, 23*REGBYTES(a0)
ffffffffc0200f8e:	7d44                	ld	s1,184(a0)
    STORE s1, 23*REGBYTES(a1)
ffffffffc0200f90:	fdc4                	sd	s1,184(a1)
    LOAD s1, 22*REGBYTES(a0)
ffffffffc0200f92:	7944                	ld	s1,176(a0)
    STORE s1, 22*REGBYTES(a1)
ffffffffc0200f94:	f9c4                	sd	s1,176(a1)
    LOAD s1, 21*REGBYTES(a0)
ffffffffc0200f96:	7544                	ld	s1,168(a0)
    STORE s1, 21*REGBYTES(a1)
ffffffffc0200f98:	f5c4                	sd	s1,168(a1)
    LOAD s1, 20*REGBYTES(a0)
ffffffffc0200f9a:	7144                	ld	s1,160(a0)
    STORE s1, 20*REGBYTES(a1)
ffffffffc0200f9c:	f1c4                	sd	s1,160(a1)
    LOAD s1, 19*REGBYTES(a0)
ffffffffc0200f9e:	6d44                	ld	s1,152(a0)
    STORE s1, 19*REGBYTES(a1)
ffffffffc0200fa0:	edc4                	sd	s1,152(a1)
    LOAD s1, 18*REGBYTES(a0)
ffffffffc0200fa2:	6944                	ld	s1,144(a0)
    STORE s1, 18*REGBYTES(a1)
ffffffffc0200fa4:	e9c4                	sd	s1,144(a1)
    LOAD s1, 17*REGBYTES(a0)
ffffffffc0200fa6:	6544                	ld	s1,136(a0)
    STORE s1, 17*REGBYTES(a1)
ffffffffc0200fa8:	e5c4                	sd	s1,136(a1)
    LOAD s1, 16*REGBYTES(a0)
ffffffffc0200faa:	6144                	ld	s1,128(a0)
    STORE s1, 16*REGBYTES(a1)
ffffffffc0200fac:	e1c4                	sd	s1,128(a1)
    LOAD s1, 15*REGBYTES(a0)
ffffffffc0200fae:	7d24                	ld	s1,120(a0)
    STORE s1, 15*REGBYTES(a1)
ffffffffc0200fb0:	fda4                	sd	s1,120(a1)
    LOAD s1, 14*REGBYTES(a0)
ffffffffc0200fb2:	7924                	ld	s1,112(a0)
    STORE s1, 14*REGBYTES(a1)
ffffffffc0200fb4:	f9a4                	sd	s1,112(a1)
    LOAD s1, 13*REGBYTES(a0)
ffffffffc0200fb6:	7524                	ld	s1,104(a0)
    STORE s1, 13*REGBYTES(a1)
ffffffffc0200fb8:	f5a4                	sd	s1,104(a1)
    LOAD s1, 12*REGBYTES(a0)
ffffffffc0200fba:	7124                	ld	s1,96(a0)
    STORE s1, 12*REGBYTES(a1)
ffffffffc0200fbc:	f1a4                	sd	s1,96(a1)
    LOAD s1, 11*REGBYTES(a0)
ffffffffc0200fbe:	6d24                	ld	s1,88(a0)
    STORE s1, 11*REGBYTES(a1)
ffffffffc0200fc0:	eda4                	sd	s1,88(a1)
    LOAD s1, 10*REGBYTES(a0)
ffffffffc0200fc2:	6924                	ld	s1,80(a0)
    STORE s1, 10*REGBYTES(a1)
ffffffffc0200fc4:	e9a4                	sd	s1,80(a1)
    LOAD s1, 9*REGBYTES(a0)
ffffffffc0200fc6:	6524                	ld	s1,72(a0)
    STORE s1, 9*REGBYTES(a1)
ffffffffc0200fc8:	e5a4                	sd	s1,72(a1)
    LOAD s1, 8*REGBYTES(a0)
ffffffffc0200fca:	6124                	ld	s1,64(a0)
    STORE s1, 8*REGBYTES(a1)
ffffffffc0200fcc:	e1a4                	sd	s1,64(a1)
    LOAD s1, 7*REGBYTES(a0)
ffffffffc0200fce:	7d04                	ld	s1,56(a0)
    STORE s1, 7*REGBYTES(a1)
ffffffffc0200fd0:	fd84                	sd	s1,56(a1)
    LOAD s1, 6*REGBYTES(a0)
ffffffffc0200fd2:	7904                	ld	s1,48(a0)
    STORE s1, 6*REGBYTES(a1)
ffffffffc0200fd4:	f984                	sd	s1,48(a1)
    LOAD s1, 5*REGBYTES(a0)
ffffffffc0200fd6:	7504                	ld	s1,40(a0)
    STORE s1, 5*REGBYTES(a1)
ffffffffc0200fd8:	f584                	sd	s1,40(a1)
    LOAD s1, 4*REGBYTES(a0)
ffffffffc0200fda:	7104                	ld	s1,32(a0)
    STORE s1, 4*REGBYTES(a1)
ffffffffc0200fdc:	f184                	sd	s1,32(a1)
    LOAD s1, 3*REGBYTES(a0)
ffffffffc0200fde:	6d04                	ld	s1,24(a0)
    STORE s1, 3*REGBYTES(a1)
ffffffffc0200fe0:	ed84                	sd	s1,24(a1)
    LOAD s1, 2*REGBYTES(a0)
ffffffffc0200fe2:	6904                	ld	s1,16(a0)
    STORE s1, 2*REGBYTES(a1)
ffffffffc0200fe4:	e984                	sd	s1,16(a1)
    LOAD s1, 1*REGBYTES(a0)
ffffffffc0200fe6:	6504                	ld	s1,8(a0)
    STORE s1, 1*REGBYTES(a1)
ffffffffc0200fe8:	e584                	sd	s1,8(a1)
    LOAD s1, 0*REGBYTES(a0)
ffffffffc0200fea:	6104                	ld	s1,0(a0)
    STORE s1, 0*REGBYTES(a1)
ffffffffc0200fec:	e184                	sd	s1,0(a1)

    // acutually adjust sp
    move sp, a1
ffffffffc0200fee:	812e                	mv	sp,a1
ffffffffc0200ff0:	bdf5                	j	ffffffffc0200eec <__trapret>

ffffffffc0200ff2 <default_init>:
 * list_init - initialize a new entry
 * @elm:        new entry to be initialized
 * */
static inline void
list_init(list_entry_t *elm) {
    elm->prev = elm->next = elm;
ffffffffc0200ff2:	000b0797          	auipc	a5,0xb0
ffffffffc0200ff6:	72e78793          	addi	a5,a5,1838 # ffffffffc02b1720 <free_area>
ffffffffc0200ffa:	e79c                	sd	a5,8(a5)
ffffffffc0200ffc:	e39c                	sd	a5,0(a5)

static void
default_init(void)
{
    list_init(&free_list);
    nr_free = 0;
ffffffffc0200ffe:	0007a823          	sw	zero,16(a5)
}
ffffffffc0201002:	8082                	ret

ffffffffc0201004 <default_nr_free_pages>:

static size_t
default_nr_free_pages(void)
{
    return nr_free;
}
ffffffffc0201004:	000b0517          	auipc	a0,0xb0
ffffffffc0201008:	72c56503          	lwu	a0,1836(a0) # ffffffffc02b1730 <free_area+0x10>
ffffffffc020100c:	8082                	ret

ffffffffc020100e <default_check>:

// LAB2: below code is used to check the first fit allocation algorithm (your EXERCISE 1)
// NOTICE: You SHOULD NOT CHANGE basic_check, default_check functions!
static void
default_check(void)
{
ffffffffc020100e:	715d                	addi	sp,sp,-80
ffffffffc0201010:	e0a2                	sd	s0,64(sp)
 * list_next - get the next entry
 * @listelm:    the list head
 **/
static inline list_entry_t *
list_next(list_entry_t *listelm) {
    return listelm->next;
ffffffffc0201012:	000b0417          	auipc	s0,0xb0
ffffffffc0201016:	70e40413          	addi	s0,s0,1806 # ffffffffc02b1720 <free_area>
ffffffffc020101a:	641c                	ld	a5,8(s0)
ffffffffc020101c:	e486                	sd	ra,72(sp)
ffffffffc020101e:	fc26                	sd	s1,56(sp)
ffffffffc0201020:	f84a                	sd	s2,48(sp)
ffffffffc0201022:	f44e                	sd	s3,40(sp)
ffffffffc0201024:	f052                	sd	s4,32(sp)
ffffffffc0201026:	ec56                	sd	s5,24(sp)
ffffffffc0201028:	e85a                	sd	s6,16(sp)
ffffffffc020102a:	e45e                	sd	s7,8(sp)
ffffffffc020102c:	e062                	sd	s8,0(sp)
    int count = 0, total = 0;
    list_entry_t *le = &free_list;
    while ((le = list_next(le)) != &free_list)
ffffffffc020102e:	2a878d63          	beq	a5,s0,ffffffffc02012e8 <default_check+0x2da>
    int count = 0, total = 0;
ffffffffc0201032:	4481                	li	s1,0
ffffffffc0201034:	4901                	li	s2,0
 * test_bit - Determine whether a bit is set
 * @nr:     the bit to test
 * @addr:   the address to count from
 * */
static inline bool test_bit(int nr, volatile void *addr) {
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc0201036:	ff07b703          	ld	a4,-16(a5)
    {
        struct Page *p = le2page(le, page_link);
        assert(PageProperty(p));
ffffffffc020103a:	8b09                	andi	a4,a4,2
ffffffffc020103c:	2a070a63          	beqz	a4,ffffffffc02012f0 <default_check+0x2e2>
        count++, total += p->property;
ffffffffc0201040:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201044:	679c                	ld	a5,8(a5)
ffffffffc0201046:	2905                	addiw	s2,s2,1
ffffffffc0201048:	9cb9                	addw	s1,s1,a4
    while ((le = list_next(le)) != &free_list)
ffffffffc020104a:	fe8796e3          	bne	a5,s0,ffffffffc0201036 <default_check+0x28>
    }
    assert(total == nr_free_pages());
ffffffffc020104e:	89a6                	mv	s3,s1
ffffffffc0201050:	6df000ef          	jal	ra,ffffffffc0201f2e <nr_free_pages>
ffffffffc0201054:	6f351e63          	bne	a0,s3,ffffffffc0201750 <default_check+0x742>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201058:	4505                	li	a0,1
ffffffffc020105a:	657000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc020105e:	8aaa                	mv	s5,a0
ffffffffc0201060:	42050863          	beqz	a0,ffffffffc0201490 <default_check+0x482>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201064:	4505                	li	a0,1
ffffffffc0201066:	64b000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc020106a:	89aa                	mv	s3,a0
ffffffffc020106c:	70050263          	beqz	a0,ffffffffc0201770 <default_check+0x762>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201070:	4505                	li	a0,1
ffffffffc0201072:	63f000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc0201076:	8a2a                	mv	s4,a0
ffffffffc0201078:	48050c63          	beqz	a0,ffffffffc0201510 <default_check+0x502>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc020107c:	293a8a63          	beq	s5,s3,ffffffffc0201310 <default_check+0x302>
ffffffffc0201080:	28aa8863          	beq	s5,a0,ffffffffc0201310 <default_check+0x302>
ffffffffc0201084:	28a98663          	beq	s3,a0,ffffffffc0201310 <default_check+0x302>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0201088:	000aa783          	lw	a5,0(s5)
ffffffffc020108c:	2a079263          	bnez	a5,ffffffffc0201330 <default_check+0x322>
ffffffffc0201090:	0009a783          	lw	a5,0(s3)
ffffffffc0201094:	28079e63          	bnez	a5,ffffffffc0201330 <default_check+0x322>
ffffffffc0201098:	411c                	lw	a5,0(a0)
ffffffffc020109a:	28079b63          	bnez	a5,ffffffffc0201330 <default_check+0x322>
extern uint_t va_pa_offset;

static inline ppn_t
page2ppn(struct Page *page)
{
    return page - pages + nbase;
ffffffffc020109e:	000b4797          	auipc	a5,0xb4
ffffffffc02010a2:	6fa7b783          	ld	a5,1786(a5) # ffffffffc02b5798 <pages>
ffffffffc02010a6:	40fa8733          	sub	a4,s5,a5
ffffffffc02010aa:	00006617          	auipc	a2,0x6
ffffffffc02010ae:	78663603          	ld	a2,1926(a2) # ffffffffc0207830 <nbase>
ffffffffc02010b2:	8719                	srai	a4,a4,0x6
ffffffffc02010b4:	9732                	add	a4,a4,a2
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc02010b6:	000b4697          	auipc	a3,0xb4
ffffffffc02010ba:	6da6b683          	ld	a3,1754(a3) # ffffffffc02b5790 <npage>
ffffffffc02010be:	06b2                	slli	a3,a3,0xc
}

static inline uintptr_t
page2pa(struct Page *page)
{
    return page2ppn(page) << PGSHIFT;
ffffffffc02010c0:	0732                	slli	a4,a4,0xc
ffffffffc02010c2:	28d77763          	bgeu	a4,a3,ffffffffc0201350 <default_check+0x342>
    return page - pages + nbase;
ffffffffc02010c6:	40f98733          	sub	a4,s3,a5
ffffffffc02010ca:	8719                	srai	a4,a4,0x6
ffffffffc02010cc:	9732                	add	a4,a4,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc02010ce:	0732                	slli	a4,a4,0xc
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc02010d0:	4cd77063          	bgeu	a4,a3,ffffffffc0201590 <default_check+0x582>
    return page - pages + nbase;
ffffffffc02010d4:	40f507b3          	sub	a5,a0,a5
ffffffffc02010d8:	8799                	srai	a5,a5,0x6
ffffffffc02010da:	97b2                	add	a5,a5,a2
    return page2ppn(page) << PGSHIFT;
ffffffffc02010dc:	07b2                	slli	a5,a5,0xc
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02010de:	30d7f963          	bgeu	a5,a3,ffffffffc02013f0 <default_check+0x3e2>
    assert(alloc_page() == NULL);
ffffffffc02010e2:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc02010e4:	00043c03          	ld	s8,0(s0)
ffffffffc02010e8:	00843b83          	ld	s7,8(s0)
    unsigned int nr_free_store = nr_free;
ffffffffc02010ec:	01042b03          	lw	s6,16(s0)
    elm->prev = elm->next = elm;
ffffffffc02010f0:	e400                	sd	s0,8(s0)
ffffffffc02010f2:	e000                	sd	s0,0(s0)
    nr_free = 0;
ffffffffc02010f4:	000b0797          	auipc	a5,0xb0
ffffffffc02010f8:	6207ae23          	sw	zero,1596(a5) # ffffffffc02b1730 <free_area+0x10>
    assert(alloc_page() == NULL);
ffffffffc02010fc:	5b5000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc0201100:	2c051863          	bnez	a0,ffffffffc02013d0 <default_check+0x3c2>
    free_page(p0);
ffffffffc0201104:	4585                	li	a1,1
ffffffffc0201106:	8556                	mv	a0,s5
ffffffffc0201108:	5e7000ef          	jal	ra,ffffffffc0201eee <free_pages>
    free_page(p1);
ffffffffc020110c:	4585                	li	a1,1
ffffffffc020110e:	854e                	mv	a0,s3
ffffffffc0201110:	5df000ef          	jal	ra,ffffffffc0201eee <free_pages>
    free_page(p2);
ffffffffc0201114:	4585                	li	a1,1
ffffffffc0201116:	8552                	mv	a0,s4
ffffffffc0201118:	5d7000ef          	jal	ra,ffffffffc0201eee <free_pages>
    assert(nr_free == 3);
ffffffffc020111c:	4818                	lw	a4,16(s0)
ffffffffc020111e:	478d                	li	a5,3
ffffffffc0201120:	28f71863          	bne	a4,a5,ffffffffc02013b0 <default_check+0x3a2>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201124:	4505                	li	a0,1
ffffffffc0201126:	58b000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc020112a:	89aa                	mv	s3,a0
ffffffffc020112c:	26050263          	beqz	a0,ffffffffc0201390 <default_check+0x382>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201130:	4505                	li	a0,1
ffffffffc0201132:	57f000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc0201136:	8aaa                	mv	s5,a0
ffffffffc0201138:	3a050c63          	beqz	a0,ffffffffc02014f0 <default_check+0x4e2>
    assert((p2 = alloc_page()) != NULL);
ffffffffc020113c:	4505                	li	a0,1
ffffffffc020113e:	573000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc0201142:	8a2a                	mv	s4,a0
ffffffffc0201144:	38050663          	beqz	a0,ffffffffc02014d0 <default_check+0x4c2>
    assert(alloc_page() == NULL);
ffffffffc0201148:	4505                	li	a0,1
ffffffffc020114a:	567000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc020114e:	36051163          	bnez	a0,ffffffffc02014b0 <default_check+0x4a2>
    free_page(p0);
ffffffffc0201152:	4585                	li	a1,1
ffffffffc0201154:	854e                	mv	a0,s3
ffffffffc0201156:	599000ef          	jal	ra,ffffffffc0201eee <free_pages>
    assert(!list_empty(&free_list));
ffffffffc020115a:	641c                	ld	a5,8(s0)
ffffffffc020115c:	20878a63          	beq	a5,s0,ffffffffc0201370 <default_check+0x362>
    assert((p = alloc_page()) == p0);
ffffffffc0201160:	4505                	li	a0,1
ffffffffc0201162:	54f000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc0201166:	30a99563          	bne	s3,a0,ffffffffc0201470 <default_check+0x462>
    assert(alloc_page() == NULL);
ffffffffc020116a:	4505                	li	a0,1
ffffffffc020116c:	545000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc0201170:	2e051063          	bnez	a0,ffffffffc0201450 <default_check+0x442>
    assert(nr_free == 0);
ffffffffc0201174:	481c                	lw	a5,16(s0)
ffffffffc0201176:	2a079d63          	bnez	a5,ffffffffc0201430 <default_check+0x422>
    free_page(p);
ffffffffc020117a:	854e                	mv	a0,s3
ffffffffc020117c:	4585                	li	a1,1
    free_list = free_list_store;
ffffffffc020117e:	01843023          	sd	s8,0(s0)
ffffffffc0201182:	01743423          	sd	s7,8(s0)
    nr_free = nr_free_store;
ffffffffc0201186:	01642823          	sw	s6,16(s0)
    free_page(p);
ffffffffc020118a:	565000ef          	jal	ra,ffffffffc0201eee <free_pages>
    free_page(p1);
ffffffffc020118e:	4585                	li	a1,1
ffffffffc0201190:	8556                	mv	a0,s5
ffffffffc0201192:	55d000ef          	jal	ra,ffffffffc0201eee <free_pages>
    free_page(p2);
ffffffffc0201196:	4585                	li	a1,1
ffffffffc0201198:	8552                	mv	a0,s4
ffffffffc020119a:	555000ef          	jal	ra,ffffffffc0201eee <free_pages>

    basic_check();

    struct Page *p0 = alloc_pages(5), *p1, *p2;
ffffffffc020119e:	4515                	li	a0,5
ffffffffc02011a0:	511000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc02011a4:	89aa                	mv	s3,a0
    assert(p0 != NULL);
ffffffffc02011a6:	26050563          	beqz	a0,ffffffffc0201410 <default_check+0x402>
ffffffffc02011aa:	651c                	ld	a5,8(a0)
ffffffffc02011ac:	8385                	srli	a5,a5,0x1
ffffffffc02011ae:	8b85                	andi	a5,a5,1
    assert(!PageProperty(p0));
ffffffffc02011b0:	54079063          	bnez	a5,ffffffffc02016f0 <default_check+0x6e2>

    list_entry_t free_list_store = free_list;
    list_init(&free_list);
    assert(list_empty(&free_list));
    assert(alloc_page() == NULL);
ffffffffc02011b4:	4505                	li	a0,1
    list_entry_t free_list_store = free_list;
ffffffffc02011b6:	00043b03          	ld	s6,0(s0)
ffffffffc02011ba:	00843a83          	ld	s5,8(s0)
ffffffffc02011be:	e000                	sd	s0,0(s0)
ffffffffc02011c0:	e400                	sd	s0,8(s0)
    assert(alloc_page() == NULL);
ffffffffc02011c2:	4ef000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc02011c6:	50051563          	bnez	a0,ffffffffc02016d0 <default_check+0x6c2>

    unsigned int nr_free_store = nr_free;
    nr_free = 0;

    free_pages(p0 + 2, 3);
ffffffffc02011ca:	08098a13          	addi	s4,s3,128
ffffffffc02011ce:	8552                	mv	a0,s4
ffffffffc02011d0:	458d                	li	a1,3
    unsigned int nr_free_store = nr_free;
ffffffffc02011d2:	01042b83          	lw	s7,16(s0)
    nr_free = 0;
ffffffffc02011d6:	000b0797          	auipc	a5,0xb0
ffffffffc02011da:	5407ad23          	sw	zero,1370(a5) # ffffffffc02b1730 <free_area+0x10>
    free_pages(p0 + 2, 3);
ffffffffc02011de:	511000ef          	jal	ra,ffffffffc0201eee <free_pages>
    assert(alloc_pages(4) == NULL);
ffffffffc02011e2:	4511                	li	a0,4
ffffffffc02011e4:	4cd000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc02011e8:	4c051463          	bnez	a0,ffffffffc02016b0 <default_check+0x6a2>
ffffffffc02011ec:	0889b783          	ld	a5,136(s3)
ffffffffc02011f0:	8385                	srli	a5,a5,0x1
ffffffffc02011f2:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc02011f4:	48078e63          	beqz	a5,ffffffffc0201690 <default_check+0x682>
ffffffffc02011f8:	0909a703          	lw	a4,144(s3)
ffffffffc02011fc:	478d                	li	a5,3
ffffffffc02011fe:	48f71963          	bne	a4,a5,ffffffffc0201690 <default_check+0x682>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0201202:	450d                	li	a0,3
ffffffffc0201204:	4ad000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc0201208:	8c2a                	mv	s8,a0
ffffffffc020120a:	46050363          	beqz	a0,ffffffffc0201670 <default_check+0x662>
    assert(alloc_page() == NULL);
ffffffffc020120e:	4505                	li	a0,1
ffffffffc0201210:	4a1000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc0201214:	42051e63          	bnez	a0,ffffffffc0201650 <default_check+0x642>
    assert(p0 + 2 == p1);
ffffffffc0201218:	418a1c63          	bne	s4,s8,ffffffffc0201630 <default_check+0x622>

    p2 = p0 + 1;
    free_page(p0);
ffffffffc020121c:	4585                	li	a1,1
ffffffffc020121e:	854e                	mv	a0,s3
ffffffffc0201220:	4cf000ef          	jal	ra,ffffffffc0201eee <free_pages>
    free_pages(p1, 3);
ffffffffc0201224:	458d                	li	a1,3
ffffffffc0201226:	8552                	mv	a0,s4
ffffffffc0201228:	4c7000ef          	jal	ra,ffffffffc0201eee <free_pages>
ffffffffc020122c:	0089b783          	ld	a5,8(s3)
    p2 = p0 + 1;
ffffffffc0201230:	04098c13          	addi	s8,s3,64
ffffffffc0201234:	8385                	srli	a5,a5,0x1
ffffffffc0201236:	8b85                	andi	a5,a5,1
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0201238:	3c078c63          	beqz	a5,ffffffffc0201610 <default_check+0x602>
ffffffffc020123c:	0109a703          	lw	a4,16(s3)
ffffffffc0201240:	4785                	li	a5,1
ffffffffc0201242:	3cf71763          	bne	a4,a5,ffffffffc0201610 <default_check+0x602>
ffffffffc0201246:	008a3783          	ld	a5,8(s4)
ffffffffc020124a:	8385                	srli	a5,a5,0x1
ffffffffc020124c:	8b85                	andi	a5,a5,1
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc020124e:	3a078163          	beqz	a5,ffffffffc02015f0 <default_check+0x5e2>
ffffffffc0201252:	010a2703          	lw	a4,16(s4)
ffffffffc0201256:	478d                	li	a5,3
ffffffffc0201258:	38f71c63          	bne	a4,a5,ffffffffc02015f0 <default_check+0x5e2>

    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc020125c:	4505                	li	a0,1
ffffffffc020125e:	453000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc0201262:	36a99763          	bne	s3,a0,ffffffffc02015d0 <default_check+0x5c2>
    free_page(p0);
ffffffffc0201266:	4585                	li	a1,1
ffffffffc0201268:	487000ef          	jal	ra,ffffffffc0201eee <free_pages>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc020126c:	4509                	li	a0,2
ffffffffc020126e:	443000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc0201272:	32aa1f63          	bne	s4,a0,ffffffffc02015b0 <default_check+0x5a2>

    free_pages(p0, 2);
ffffffffc0201276:	4589                	li	a1,2
ffffffffc0201278:	477000ef          	jal	ra,ffffffffc0201eee <free_pages>
    free_page(p2);
ffffffffc020127c:	4585                	li	a1,1
ffffffffc020127e:	8562                	mv	a0,s8
ffffffffc0201280:	46f000ef          	jal	ra,ffffffffc0201eee <free_pages>

    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0201284:	4515                	li	a0,5
ffffffffc0201286:	42b000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc020128a:	89aa                	mv	s3,a0
ffffffffc020128c:	48050263          	beqz	a0,ffffffffc0201710 <default_check+0x702>
    assert(alloc_page() == NULL);
ffffffffc0201290:	4505                	li	a0,1
ffffffffc0201292:	41f000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc0201296:	2c051d63          	bnez	a0,ffffffffc0201570 <default_check+0x562>

    assert(nr_free == 0);
ffffffffc020129a:	481c                	lw	a5,16(s0)
ffffffffc020129c:	2a079a63          	bnez	a5,ffffffffc0201550 <default_check+0x542>
    nr_free = nr_free_store;

    free_list = free_list_store;
    free_pages(p0, 5);
ffffffffc02012a0:	4595                	li	a1,5
ffffffffc02012a2:	854e                	mv	a0,s3
    nr_free = nr_free_store;
ffffffffc02012a4:	01742823          	sw	s7,16(s0)
    free_list = free_list_store;
ffffffffc02012a8:	01643023          	sd	s6,0(s0)
ffffffffc02012ac:	01543423          	sd	s5,8(s0)
    free_pages(p0, 5);
ffffffffc02012b0:	43f000ef          	jal	ra,ffffffffc0201eee <free_pages>
    return listelm->next;
ffffffffc02012b4:	641c                	ld	a5,8(s0)

    le = &free_list;
    while ((le = list_next(le)) != &free_list)
ffffffffc02012b6:	00878963          	beq	a5,s0,ffffffffc02012c8 <default_check+0x2ba>
    {
        struct Page *p = le2page(le, page_link);
        count--, total -= p->property;
ffffffffc02012ba:	ff87a703          	lw	a4,-8(a5)
ffffffffc02012be:	679c                	ld	a5,8(a5)
ffffffffc02012c0:	397d                	addiw	s2,s2,-1
ffffffffc02012c2:	9c99                	subw	s1,s1,a4
    while ((le = list_next(le)) != &free_list)
ffffffffc02012c4:	fe879be3          	bne	a5,s0,ffffffffc02012ba <default_check+0x2ac>
    }
    assert(count == 0);
ffffffffc02012c8:	26091463          	bnez	s2,ffffffffc0201530 <default_check+0x522>
    assert(total == 0);
ffffffffc02012cc:	46049263          	bnez	s1,ffffffffc0201730 <default_check+0x722>
}
ffffffffc02012d0:	60a6                	ld	ra,72(sp)
ffffffffc02012d2:	6406                	ld	s0,64(sp)
ffffffffc02012d4:	74e2                	ld	s1,56(sp)
ffffffffc02012d6:	7942                	ld	s2,48(sp)
ffffffffc02012d8:	79a2                	ld	s3,40(sp)
ffffffffc02012da:	7a02                	ld	s4,32(sp)
ffffffffc02012dc:	6ae2                	ld	s5,24(sp)
ffffffffc02012de:	6b42                	ld	s6,16(sp)
ffffffffc02012e0:	6ba2                	ld	s7,8(sp)
ffffffffc02012e2:	6c02                	ld	s8,0(sp)
ffffffffc02012e4:	6161                	addi	sp,sp,80
ffffffffc02012e6:	8082                	ret
    while ((le = list_next(le)) != &free_list)
ffffffffc02012e8:	4981                	li	s3,0
    int count = 0, total = 0;
ffffffffc02012ea:	4481                	li	s1,0
ffffffffc02012ec:	4901                	li	s2,0
ffffffffc02012ee:	b38d                	j	ffffffffc0201050 <default_check+0x42>
        assert(PageProperty(p));
ffffffffc02012f0:	00005697          	auipc	a3,0x5
ffffffffc02012f4:	e6068693          	addi	a3,a3,-416 # ffffffffc0206150 <commands+0x818>
ffffffffc02012f8:	00005617          	auipc	a2,0x5
ffffffffc02012fc:	e6860613          	addi	a2,a2,-408 # ffffffffc0206160 <commands+0x828>
ffffffffc0201300:	11000593          	li	a1,272
ffffffffc0201304:	00005517          	auipc	a0,0x5
ffffffffc0201308:	e7450513          	addi	a0,a0,-396 # ffffffffc0206178 <commands+0x840>
ffffffffc020130c:	982ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(p0 != p1 && p0 != p2 && p1 != p2);
ffffffffc0201310:	00005697          	auipc	a3,0x5
ffffffffc0201314:	f0068693          	addi	a3,a3,-256 # ffffffffc0206210 <commands+0x8d8>
ffffffffc0201318:	00005617          	auipc	a2,0x5
ffffffffc020131c:	e4860613          	addi	a2,a2,-440 # ffffffffc0206160 <commands+0x828>
ffffffffc0201320:	0db00593          	li	a1,219
ffffffffc0201324:	00005517          	auipc	a0,0x5
ffffffffc0201328:	e5450513          	addi	a0,a0,-428 # ffffffffc0206178 <commands+0x840>
ffffffffc020132c:	962ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p0) == 0 && page_ref(p1) == 0 && page_ref(p2) == 0);
ffffffffc0201330:	00005697          	auipc	a3,0x5
ffffffffc0201334:	f0868693          	addi	a3,a3,-248 # ffffffffc0206238 <commands+0x900>
ffffffffc0201338:	00005617          	auipc	a2,0x5
ffffffffc020133c:	e2860613          	addi	a2,a2,-472 # ffffffffc0206160 <commands+0x828>
ffffffffc0201340:	0dc00593          	li	a1,220
ffffffffc0201344:	00005517          	auipc	a0,0x5
ffffffffc0201348:	e3450513          	addi	a0,a0,-460 # ffffffffc0206178 <commands+0x840>
ffffffffc020134c:	942ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page2pa(p0) < npage * PGSIZE);
ffffffffc0201350:	00005697          	auipc	a3,0x5
ffffffffc0201354:	f2868693          	addi	a3,a3,-216 # ffffffffc0206278 <commands+0x940>
ffffffffc0201358:	00005617          	auipc	a2,0x5
ffffffffc020135c:	e0860613          	addi	a2,a2,-504 # ffffffffc0206160 <commands+0x828>
ffffffffc0201360:	0de00593          	li	a1,222
ffffffffc0201364:	00005517          	auipc	a0,0x5
ffffffffc0201368:	e1450513          	addi	a0,a0,-492 # ffffffffc0206178 <commands+0x840>
ffffffffc020136c:	922ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(!list_empty(&free_list));
ffffffffc0201370:	00005697          	auipc	a3,0x5
ffffffffc0201374:	f9068693          	addi	a3,a3,-112 # ffffffffc0206300 <commands+0x9c8>
ffffffffc0201378:	00005617          	auipc	a2,0x5
ffffffffc020137c:	de860613          	addi	a2,a2,-536 # ffffffffc0206160 <commands+0x828>
ffffffffc0201380:	0f700593          	li	a1,247
ffffffffc0201384:	00005517          	auipc	a0,0x5
ffffffffc0201388:	df450513          	addi	a0,a0,-524 # ffffffffc0206178 <commands+0x840>
ffffffffc020138c:	902ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201390:	00005697          	auipc	a3,0x5
ffffffffc0201394:	e2068693          	addi	a3,a3,-480 # ffffffffc02061b0 <commands+0x878>
ffffffffc0201398:	00005617          	auipc	a2,0x5
ffffffffc020139c:	dc860613          	addi	a2,a2,-568 # ffffffffc0206160 <commands+0x828>
ffffffffc02013a0:	0f000593          	li	a1,240
ffffffffc02013a4:	00005517          	auipc	a0,0x5
ffffffffc02013a8:	dd450513          	addi	a0,a0,-556 # ffffffffc0206178 <commands+0x840>
ffffffffc02013ac:	8e2ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free == 3);
ffffffffc02013b0:	00005697          	auipc	a3,0x5
ffffffffc02013b4:	f4068693          	addi	a3,a3,-192 # ffffffffc02062f0 <commands+0x9b8>
ffffffffc02013b8:	00005617          	auipc	a2,0x5
ffffffffc02013bc:	da860613          	addi	a2,a2,-600 # ffffffffc0206160 <commands+0x828>
ffffffffc02013c0:	0ee00593          	li	a1,238
ffffffffc02013c4:	00005517          	auipc	a0,0x5
ffffffffc02013c8:	db450513          	addi	a0,a0,-588 # ffffffffc0206178 <commands+0x840>
ffffffffc02013cc:	8c2ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc02013d0:	00005697          	auipc	a3,0x5
ffffffffc02013d4:	f0868693          	addi	a3,a3,-248 # ffffffffc02062d8 <commands+0x9a0>
ffffffffc02013d8:	00005617          	auipc	a2,0x5
ffffffffc02013dc:	d8860613          	addi	a2,a2,-632 # ffffffffc0206160 <commands+0x828>
ffffffffc02013e0:	0e900593          	li	a1,233
ffffffffc02013e4:	00005517          	auipc	a0,0x5
ffffffffc02013e8:	d9450513          	addi	a0,a0,-620 # ffffffffc0206178 <commands+0x840>
ffffffffc02013ec:	8a2ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page2pa(p2) < npage * PGSIZE);
ffffffffc02013f0:	00005697          	auipc	a3,0x5
ffffffffc02013f4:	ec868693          	addi	a3,a3,-312 # ffffffffc02062b8 <commands+0x980>
ffffffffc02013f8:	00005617          	auipc	a2,0x5
ffffffffc02013fc:	d6860613          	addi	a2,a2,-664 # ffffffffc0206160 <commands+0x828>
ffffffffc0201400:	0e000593          	li	a1,224
ffffffffc0201404:	00005517          	auipc	a0,0x5
ffffffffc0201408:	d7450513          	addi	a0,a0,-652 # ffffffffc0206178 <commands+0x840>
ffffffffc020140c:	882ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(p0 != NULL);
ffffffffc0201410:	00005697          	auipc	a3,0x5
ffffffffc0201414:	f3868693          	addi	a3,a3,-200 # ffffffffc0206348 <commands+0xa10>
ffffffffc0201418:	00005617          	auipc	a2,0x5
ffffffffc020141c:	d4860613          	addi	a2,a2,-696 # ffffffffc0206160 <commands+0x828>
ffffffffc0201420:	11800593          	li	a1,280
ffffffffc0201424:	00005517          	auipc	a0,0x5
ffffffffc0201428:	d5450513          	addi	a0,a0,-684 # ffffffffc0206178 <commands+0x840>
ffffffffc020142c:	862ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free == 0);
ffffffffc0201430:	00005697          	auipc	a3,0x5
ffffffffc0201434:	f0868693          	addi	a3,a3,-248 # ffffffffc0206338 <commands+0xa00>
ffffffffc0201438:	00005617          	auipc	a2,0x5
ffffffffc020143c:	d2860613          	addi	a2,a2,-728 # ffffffffc0206160 <commands+0x828>
ffffffffc0201440:	0fd00593          	li	a1,253
ffffffffc0201444:	00005517          	auipc	a0,0x5
ffffffffc0201448:	d3450513          	addi	a0,a0,-716 # ffffffffc0206178 <commands+0x840>
ffffffffc020144c:	842ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201450:	00005697          	auipc	a3,0x5
ffffffffc0201454:	e8868693          	addi	a3,a3,-376 # ffffffffc02062d8 <commands+0x9a0>
ffffffffc0201458:	00005617          	auipc	a2,0x5
ffffffffc020145c:	d0860613          	addi	a2,a2,-760 # ffffffffc0206160 <commands+0x828>
ffffffffc0201460:	0fb00593          	li	a1,251
ffffffffc0201464:	00005517          	auipc	a0,0x5
ffffffffc0201468:	d1450513          	addi	a0,a0,-748 # ffffffffc0206178 <commands+0x840>
ffffffffc020146c:	822ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p = alloc_page()) == p0);
ffffffffc0201470:	00005697          	auipc	a3,0x5
ffffffffc0201474:	ea868693          	addi	a3,a3,-344 # ffffffffc0206318 <commands+0x9e0>
ffffffffc0201478:	00005617          	auipc	a2,0x5
ffffffffc020147c:	ce860613          	addi	a2,a2,-792 # ffffffffc0206160 <commands+0x828>
ffffffffc0201480:	0fa00593          	li	a1,250
ffffffffc0201484:	00005517          	auipc	a0,0x5
ffffffffc0201488:	cf450513          	addi	a0,a0,-780 # ffffffffc0206178 <commands+0x840>
ffffffffc020148c:	802ff0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_page()) != NULL);
ffffffffc0201490:	00005697          	auipc	a3,0x5
ffffffffc0201494:	d2068693          	addi	a3,a3,-736 # ffffffffc02061b0 <commands+0x878>
ffffffffc0201498:	00005617          	auipc	a2,0x5
ffffffffc020149c:	cc860613          	addi	a2,a2,-824 # ffffffffc0206160 <commands+0x828>
ffffffffc02014a0:	0d700593          	li	a1,215
ffffffffc02014a4:	00005517          	auipc	a0,0x5
ffffffffc02014a8:	cd450513          	addi	a0,a0,-812 # ffffffffc0206178 <commands+0x840>
ffffffffc02014ac:	fe3fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc02014b0:	00005697          	auipc	a3,0x5
ffffffffc02014b4:	e2868693          	addi	a3,a3,-472 # ffffffffc02062d8 <commands+0x9a0>
ffffffffc02014b8:	00005617          	auipc	a2,0x5
ffffffffc02014bc:	ca860613          	addi	a2,a2,-856 # ffffffffc0206160 <commands+0x828>
ffffffffc02014c0:	0f400593          	li	a1,244
ffffffffc02014c4:	00005517          	auipc	a0,0x5
ffffffffc02014c8:	cb450513          	addi	a0,a0,-844 # ffffffffc0206178 <commands+0x840>
ffffffffc02014cc:	fc3fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc02014d0:	00005697          	auipc	a3,0x5
ffffffffc02014d4:	d2068693          	addi	a3,a3,-736 # ffffffffc02061f0 <commands+0x8b8>
ffffffffc02014d8:	00005617          	auipc	a2,0x5
ffffffffc02014dc:	c8860613          	addi	a2,a2,-888 # ffffffffc0206160 <commands+0x828>
ffffffffc02014e0:	0f200593          	li	a1,242
ffffffffc02014e4:	00005517          	auipc	a0,0x5
ffffffffc02014e8:	c9450513          	addi	a0,a0,-876 # ffffffffc0206178 <commands+0x840>
ffffffffc02014ec:	fa3fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc02014f0:	00005697          	auipc	a3,0x5
ffffffffc02014f4:	ce068693          	addi	a3,a3,-800 # ffffffffc02061d0 <commands+0x898>
ffffffffc02014f8:	00005617          	auipc	a2,0x5
ffffffffc02014fc:	c6860613          	addi	a2,a2,-920 # ffffffffc0206160 <commands+0x828>
ffffffffc0201500:	0f100593          	li	a1,241
ffffffffc0201504:	00005517          	auipc	a0,0x5
ffffffffc0201508:	c7450513          	addi	a0,a0,-908 # ffffffffc0206178 <commands+0x840>
ffffffffc020150c:	f83fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p2 = alloc_page()) != NULL);
ffffffffc0201510:	00005697          	auipc	a3,0x5
ffffffffc0201514:	ce068693          	addi	a3,a3,-800 # ffffffffc02061f0 <commands+0x8b8>
ffffffffc0201518:	00005617          	auipc	a2,0x5
ffffffffc020151c:	c4860613          	addi	a2,a2,-952 # ffffffffc0206160 <commands+0x828>
ffffffffc0201520:	0d900593          	li	a1,217
ffffffffc0201524:	00005517          	auipc	a0,0x5
ffffffffc0201528:	c5450513          	addi	a0,a0,-940 # ffffffffc0206178 <commands+0x840>
ffffffffc020152c:	f63fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(count == 0);
ffffffffc0201530:	00005697          	auipc	a3,0x5
ffffffffc0201534:	f6868693          	addi	a3,a3,-152 # ffffffffc0206498 <commands+0xb60>
ffffffffc0201538:	00005617          	auipc	a2,0x5
ffffffffc020153c:	c2860613          	addi	a2,a2,-984 # ffffffffc0206160 <commands+0x828>
ffffffffc0201540:	14600593          	li	a1,326
ffffffffc0201544:	00005517          	auipc	a0,0x5
ffffffffc0201548:	c3450513          	addi	a0,a0,-972 # ffffffffc0206178 <commands+0x840>
ffffffffc020154c:	f43fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free == 0);
ffffffffc0201550:	00005697          	auipc	a3,0x5
ffffffffc0201554:	de868693          	addi	a3,a3,-536 # ffffffffc0206338 <commands+0xa00>
ffffffffc0201558:	00005617          	auipc	a2,0x5
ffffffffc020155c:	c0860613          	addi	a2,a2,-1016 # ffffffffc0206160 <commands+0x828>
ffffffffc0201560:	13a00593          	li	a1,314
ffffffffc0201564:	00005517          	auipc	a0,0x5
ffffffffc0201568:	c1450513          	addi	a0,a0,-1004 # ffffffffc0206178 <commands+0x840>
ffffffffc020156c:	f23fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201570:	00005697          	auipc	a3,0x5
ffffffffc0201574:	d6868693          	addi	a3,a3,-664 # ffffffffc02062d8 <commands+0x9a0>
ffffffffc0201578:	00005617          	auipc	a2,0x5
ffffffffc020157c:	be860613          	addi	a2,a2,-1048 # ffffffffc0206160 <commands+0x828>
ffffffffc0201580:	13800593          	li	a1,312
ffffffffc0201584:	00005517          	auipc	a0,0x5
ffffffffc0201588:	bf450513          	addi	a0,a0,-1036 # ffffffffc0206178 <commands+0x840>
ffffffffc020158c:	f03fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page2pa(p1) < npage * PGSIZE);
ffffffffc0201590:	00005697          	auipc	a3,0x5
ffffffffc0201594:	d0868693          	addi	a3,a3,-760 # ffffffffc0206298 <commands+0x960>
ffffffffc0201598:	00005617          	auipc	a2,0x5
ffffffffc020159c:	bc860613          	addi	a2,a2,-1080 # ffffffffc0206160 <commands+0x828>
ffffffffc02015a0:	0df00593          	li	a1,223
ffffffffc02015a4:	00005517          	auipc	a0,0x5
ffffffffc02015a8:	bd450513          	addi	a0,a0,-1068 # ffffffffc0206178 <commands+0x840>
ffffffffc02015ac:	ee3fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_pages(2)) == p2 + 1);
ffffffffc02015b0:	00005697          	auipc	a3,0x5
ffffffffc02015b4:	ea868693          	addi	a3,a3,-344 # ffffffffc0206458 <commands+0xb20>
ffffffffc02015b8:	00005617          	auipc	a2,0x5
ffffffffc02015bc:	ba860613          	addi	a2,a2,-1112 # ffffffffc0206160 <commands+0x828>
ffffffffc02015c0:	13200593          	li	a1,306
ffffffffc02015c4:	00005517          	auipc	a0,0x5
ffffffffc02015c8:	bb450513          	addi	a0,a0,-1100 # ffffffffc0206178 <commands+0x840>
ffffffffc02015cc:	ec3fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_page()) == p2 - 1);
ffffffffc02015d0:	00005697          	auipc	a3,0x5
ffffffffc02015d4:	e6868693          	addi	a3,a3,-408 # ffffffffc0206438 <commands+0xb00>
ffffffffc02015d8:	00005617          	auipc	a2,0x5
ffffffffc02015dc:	b8860613          	addi	a2,a2,-1144 # ffffffffc0206160 <commands+0x828>
ffffffffc02015e0:	13000593          	li	a1,304
ffffffffc02015e4:	00005517          	auipc	a0,0x5
ffffffffc02015e8:	b9450513          	addi	a0,a0,-1132 # ffffffffc0206178 <commands+0x840>
ffffffffc02015ec:	ea3fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(PageProperty(p1) && p1->property == 3);
ffffffffc02015f0:	00005697          	auipc	a3,0x5
ffffffffc02015f4:	e2068693          	addi	a3,a3,-480 # ffffffffc0206410 <commands+0xad8>
ffffffffc02015f8:	00005617          	auipc	a2,0x5
ffffffffc02015fc:	b6860613          	addi	a2,a2,-1176 # ffffffffc0206160 <commands+0x828>
ffffffffc0201600:	12e00593          	li	a1,302
ffffffffc0201604:	00005517          	auipc	a0,0x5
ffffffffc0201608:	b7450513          	addi	a0,a0,-1164 # ffffffffc0206178 <commands+0x840>
ffffffffc020160c:	e83fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(PageProperty(p0) && p0->property == 1);
ffffffffc0201610:	00005697          	auipc	a3,0x5
ffffffffc0201614:	dd868693          	addi	a3,a3,-552 # ffffffffc02063e8 <commands+0xab0>
ffffffffc0201618:	00005617          	auipc	a2,0x5
ffffffffc020161c:	b4860613          	addi	a2,a2,-1208 # ffffffffc0206160 <commands+0x828>
ffffffffc0201620:	12d00593          	li	a1,301
ffffffffc0201624:	00005517          	auipc	a0,0x5
ffffffffc0201628:	b5450513          	addi	a0,a0,-1196 # ffffffffc0206178 <commands+0x840>
ffffffffc020162c:	e63fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(p0 + 2 == p1);
ffffffffc0201630:	00005697          	auipc	a3,0x5
ffffffffc0201634:	da868693          	addi	a3,a3,-600 # ffffffffc02063d8 <commands+0xaa0>
ffffffffc0201638:	00005617          	auipc	a2,0x5
ffffffffc020163c:	b2860613          	addi	a2,a2,-1240 # ffffffffc0206160 <commands+0x828>
ffffffffc0201640:	12800593          	li	a1,296
ffffffffc0201644:	00005517          	auipc	a0,0x5
ffffffffc0201648:	b3450513          	addi	a0,a0,-1228 # ffffffffc0206178 <commands+0x840>
ffffffffc020164c:	e43fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc0201650:	00005697          	auipc	a3,0x5
ffffffffc0201654:	c8868693          	addi	a3,a3,-888 # ffffffffc02062d8 <commands+0x9a0>
ffffffffc0201658:	00005617          	auipc	a2,0x5
ffffffffc020165c:	b0860613          	addi	a2,a2,-1272 # ffffffffc0206160 <commands+0x828>
ffffffffc0201660:	12700593          	li	a1,295
ffffffffc0201664:	00005517          	auipc	a0,0x5
ffffffffc0201668:	b1450513          	addi	a0,a0,-1260 # ffffffffc0206178 <commands+0x840>
ffffffffc020166c:	e23fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p1 = alloc_pages(3)) != NULL);
ffffffffc0201670:	00005697          	auipc	a3,0x5
ffffffffc0201674:	d4868693          	addi	a3,a3,-696 # ffffffffc02063b8 <commands+0xa80>
ffffffffc0201678:	00005617          	auipc	a2,0x5
ffffffffc020167c:	ae860613          	addi	a2,a2,-1304 # ffffffffc0206160 <commands+0x828>
ffffffffc0201680:	12600593          	li	a1,294
ffffffffc0201684:	00005517          	auipc	a0,0x5
ffffffffc0201688:	af450513          	addi	a0,a0,-1292 # ffffffffc0206178 <commands+0x840>
ffffffffc020168c:	e03fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(PageProperty(p0 + 2) && p0[2].property == 3);
ffffffffc0201690:	00005697          	auipc	a3,0x5
ffffffffc0201694:	cf868693          	addi	a3,a3,-776 # ffffffffc0206388 <commands+0xa50>
ffffffffc0201698:	00005617          	auipc	a2,0x5
ffffffffc020169c:	ac860613          	addi	a2,a2,-1336 # ffffffffc0206160 <commands+0x828>
ffffffffc02016a0:	12500593          	li	a1,293
ffffffffc02016a4:	00005517          	auipc	a0,0x5
ffffffffc02016a8:	ad450513          	addi	a0,a0,-1324 # ffffffffc0206178 <commands+0x840>
ffffffffc02016ac:	de3fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_pages(4) == NULL);
ffffffffc02016b0:	00005697          	auipc	a3,0x5
ffffffffc02016b4:	cc068693          	addi	a3,a3,-832 # ffffffffc0206370 <commands+0xa38>
ffffffffc02016b8:	00005617          	auipc	a2,0x5
ffffffffc02016bc:	aa860613          	addi	a2,a2,-1368 # ffffffffc0206160 <commands+0x828>
ffffffffc02016c0:	12400593          	li	a1,292
ffffffffc02016c4:	00005517          	auipc	a0,0x5
ffffffffc02016c8:	ab450513          	addi	a0,a0,-1356 # ffffffffc0206178 <commands+0x840>
ffffffffc02016cc:	dc3fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(alloc_page() == NULL);
ffffffffc02016d0:	00005697          	auipc	a3,0x5
ffffffffc02016d4:	c0868693          	addi	a3,a3,-1016 # ffffffffc02062d8 <commands+0x9a0>
ffffffffc02016d8:	00005617          	auipc	a2,0x5
ffffffffc02016dc:	a8860613          	addi	a2,a2,-1400 # ffffffffc0206160 <commands+0x828>
ffffffffc02016e0:	11e00593          	li	a1,286
ffffffffc02016e4:	00005517          	auipc	a0,0x5
ffffffffc02016e8:	a9450513          	addi	a0,a0,-1388 # ffffffffc0206178 <commands+0x840>
ffffffffc02016ec:	da3fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(!PageProperty(p0));
ffffffffc02016f0:	00005697          	auipc	a3,0x5
ffffffffc02016f4:	c6868693          	addi	a3,a3,-920 # ffffffffc0206358 <commands+0xa20>
ffffffffc02016f8:	00005617          	auipc	a2,0x5
ffffffffc02016fc:	a6860613          	addi	a2,a2,-1432 # ffffffffc0206160 <commands+0x828>
ffffffffc0201700:	11900593          	li	a1,281
ffffffffc0201704:	00005517          	auipc	a0,0x5
ffffffffc0201708:	a7450513          	addi	a0,a0,-1420 # ffffffffc0206178 <commands+0x840>
ffffffffc020170c:	d83fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p0 = alloc_pages(5)) != NULL);
ffffffffc0201710:	00005697          	auipc	a3,0x5
ffffffffc0201714:	d6868693          	addi	a3,a3,-664 # ffffffffc0206478 <commands+0xb40>
ffffffffc0201718:	00005617          	auipc	a2,0x5
ffffffffc020171c:	a4860613          	addi	a2,a2,-1464 # ffffffffc0206160 <commands+0x828>
ffffffffc0201720:	13700593          	li	a1,311
ffffffffc0201724:	00005517          	auipc	a0,0x5
ffffffffc0201728:	a5450513          	addi	a0,a0,-1452 # ffffffffc0206178 <commands+0x840>
ffffffffc020172c:	d63fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(total == 0);
ffffffffc0201730:	00005697          	auipc	a3,0x5
ffffffffc0201734:	d7868693          	addi	a3,a3,-648 # ffffffffc02064a8 <commands+0xb70>
ffffffffc0201738:	00005617          	auipc	a2,0x5
ffffffffc020173c:	a2860613          	addi	a2,a2,-1496 # ffffffffc0206160 <commands+0x828>
ffffffffc0201740:	14700593          	li	a1,327
ffffffffc0201744:	00005517          	auipc	a0,0x5
ffffffffc0201748:	a3450513          	addi	a0,a0,-1484 # ffffffffc0206178 <commands+0x840>
ffffffffc020174c:	d43fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(total == nr_free_pages());
ffffffffc0201750:	00005697          	auipc	a3,0x5
ffffffffc0201754:	a4068693          	addi	a3,a3,-1472 # ffffffffc0206190 <commands+0x858>
ffffffffc0201758:	00005617          	auipc	a2,0x5
ffffffffc020175c:	a0860613          	addi	a2,a2,-1528 # ffffffffc0206160 <commands+0x828>
ffffffffc0201760:	11300593          	li	a1,275
ffffffffc0201764:	00005517          	auipc	a0,0x5
ffffffffc0201768:	a1450513          	addi	a0,a0,-1516 # ffffffffc0206178 <commands+0x840>
ffffffffc020176c:	d23fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((p1 = alloc_page()) != NULL);
ffffffffc0201770:	00005697          	auipc	a3,0x5
ffffffffc0201774:	a6068693          	addi	a3,a3,-1440 # ffffffffc02061d0 <commands+0x898>
ffffffffc0201778:	00005617          	auipc	a2,0x5
ffffffffc020177c:	9e860613          	addi	a2,a2,-1560 # ffffffffc0206160 <commands+0x828>
ffffffffc0201780:	0d800593          	li	a1,216
ffffffffc0201784:	00005517          	auipc	a0,0x5
ffffffffc0201788:	9f450513          	addi	a0,a0,-1548 # ffffffffc0206178 <commands+0x840>
ffffffffc020178c:	d03fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201790 <default_free_pages>:
{
ffffffffc0201790:	1141                	addi	sp,sp,-16
ffffffffc0201792:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc0201794:	14058463          	beqz	a1,ffffffffc02018dc <default_free_pages+0x14c>
    for (; p != base + n; p++)
ffffffffc0201798:	00659693          	slli	a3,a1,0x6
ffffffffc020179c:	96aa                	add	a3,a3,a0
ffffffffc020179e:	87aa                	mv	a5,a0
ffffffffc02017a0:	02d50263          	beq	a0,a3,ffffffffc02017c4 <default_free_pages+0x34>
ffffffffc02017a4:	6798                	ld	a4,8(a5)
ffffffffc02017a6:	8b05                	andi	a4,a4,1
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02017a8:	10071a63          	bnez	a4,ffffffffc02018bc <default_free_pages+0x12c>
ffffffffc02017ac:	6798                	ld	a4,8(a5)
ffffffffc02017ae:	8b09                	andi	a4,a4,2
ffffffffc02017b0:	10071663          	bnez	a4,ffffffffc02018bc <default_free_pages+0x12c>
        p->flags = 0;
ffffffffc02017b4:	0007b423          	sd	zero,8(a5)
}

static inline void
set_page_ref(struct Page *page, int val)
{
    page->ref = val;
ffffffffc02017b8:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc02017bc:	04078793          	addi	a5,a5,64
ffffffffc02017c0:	fed792e3          	bne	a5,a3,ffffffffc02017a4 <default_free_pages+0x14>
    base->property = n;
ffffffffc02017c4:	2581                	sext.w	a1,a1
ffffffffc02017c6:	c90c                	sw	a1,16(a0)
    SetPageProperty(base);
ffffffffc02017c8:	00850893          	addi	a7,a0,8
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02017cc:	4789                	li	a5,2
ffffffffc02017ce:	40f8b02f          	amoor.d	zero,a5,(a7)
    nr_free += n;
ffffffffc02017d2:	000b0697          	auipc	a3,0xb0
ffffffffc02017d6:	f4e68693          	addi	a3,a3,-178 # ffffffffc02b1720 <free_area>
ffffffffc02017da:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02017dc:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02017de:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02017e2:	9db9                	addw	a1,a1,a4
ffffffffc02017e4:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list))
ffffffffc02017e6:	0ad78463          	beq	a5,a3,ffffffffc020188e <default_free_pages+0xfe>
            struct Page *page = le2page(le, page_link);
ffffffffc02017ea:	fe878713          	addi	a4,a5,-24
ffffffffc02017ee:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list))
ffffffffc02017f2:	4581                	li	a1,0
            if (base < page)
ffffffffc02017f4:	00e56a63          	bltu	a0,a4,ffffffffc0201808 <default_free_pages+0x78>
    return listelm->next;
ffffffffc02017f8:	6798                	ld	a4,8(a5)
            else if (list_next(le) == &free_list)
ffffffffc02017fa:	04d70c63          	beq	a4,a3,ffffffffc0201852 <default_free_pages+0xc2>
    for (; p != base + n; p++)
ffffffffc02017fe:	87ba                	mv	a5,a4
            struct Page *page = le2page(le, page_link);
ffffffffc0201800:	fe878713          	addi	a4,a5,-24
            if (base < page)
ffffffffc0201804:	fee57ae3          	bgeu	a0,a4,ffffffffc02017f8 <default_free_pages+0x68>
ffffffffc0201808:	c199                	beqz	a1,ffffffffc020180e <default_free_pages+0x7e>
ffffffffc020180a:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc020180e:	6398                	ld	a4,0(a5)
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_add(list_entry_t *elm, list_entry_t *prev, list_entry_t *next) {
    prev->next = next->prev = elm;
ffffffffc0201810:	e390                	sd	a2,0(a5)
ffffffffc0201812:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0201814:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201816:	ed18                	sd	a4,24(a0)
    if (le != &free_list)
ffffffffc0201818:	00d70d63          	beq	a4,a3,ffffffffc0201832 <default_free_pages+0xa2>
        if (p + p->property == base)
ffffffffc020181c:	ff872583          	lw	a1,-8(a4)
        p = le2page(le, page_link);
ffffffffc0201820:	fe870613          	addi	a2,a4,-24
        if (p + p->property == base)
ffffffffc0201824:	02059813          	slli	a6,a1,0x20
ffffffffc0201828:	01a85793          	srli	a5,a6,0x1a
ffffffffc020182c:	97b2                	add	a5,a5,a2
ffffffffc020182e:	02f50c63          	beq	a0,a5,ffffffffc0201866 <default_free_pages+0xd6>
    return listelm->next;
ffffffffc0201832:	711c                	ld	a5,32(a0)
    if (le != &free_list)
ffffffffc0201834:	00d78c63          	beq	a5,a3,ffffffffc020184c <default_free_pages+0xbc>
        if (base + base->property == p)
ffffffffc0201838:	4910                	lw	a2,16(a0)
        p = le2page(le, page_link);
ffffffffc020183a:	fe878693          	addi	a3,a5,-24
        if (base + base->property == p)
ffffffffc020183e:	02061593          	slli	a1,a2,0x20
ffffffffc0201842:	01a5d713          	srli	a4,a1,0x1a
ffffffffc0201846:	972a                	add	a4,a4,a0
ffffffffc0201848:	04e68a63          	beq	a3,a4,ffffffffc020189c <default_free_pages+0x10c>
}
ffffffffc020184c:	60a2                	ld	ra,8(sp)
ffffffffc020184e:	0141                	addi	sp,sp,16
ffffffffc0201850:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0201852:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201854:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0201856:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0201858:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list)
ffffffffc020185a:	02d70763          	beq	a4,a3,ffffffffc0201888 <default_free_pages+0xf8>
    prev->next = next->prev = elm;
ffffffffc020185e:	8832                	mv	a6,a2
ffffffffc0201860:	4585                	li	a1,1
    for (; p != base + n; p++)
ffffffffc0201862:	87ba                	mv	a5,a4
ffffffffc0201864:	bf71                	j	ffffffffc0201800 <default_free_pages+0x70>
            p->property += base->property;
ffffffffc0201866:	491c                	lw	a5,16(a0)
ffffffffc0201868:	9dbd                	addw	a1,a1,a5
ffffffffc020186a:	feb72c23          	sw	a1,-8(a4)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc020186e:	57f5                	li	a5,-3
ffffffffc0201870:	60f8b02f          	amoand.d	zero,a5,(a7)
    __list_del(listelm->prev, listelm->next);
ffffffffc0201874:	01853803          	ld	a6,24(a0)
ffffffffc0201878:	710c                	ld	a1,32(a0)
            base = p;
ffffffffc020187a:	8532                	mv	a0,a2
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 * */
static inline void
__list_del(list_entry_t *prev, list_entry_t *next) {
    prev->next = next;
ffffffffc020187c:	00b83423          	sd	a1,8(a6)
    return listelm->next;
ffffffffc0201880:	671c                	ld	a5,8(a4)
    next->prev = prev;
ffffffffc0201882:	0105b023          	sd	a6,0(a1)
ffffffffc0201886:	b77d                	j	ffffffffc0201834 <default_free_pages+0xa4>
ffffffffc0201888:	e290                	sd	a2,0(a3)
        while ((le = list_next(le)) != &free_list)
ffffffffc020188a:	873e                	mv	a4,a5
ffffffffc020188c:	bf41                	j	ffffffffc020181c <default_free_pages+0x8c>
}
ffffffffc020188e:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0201890:	e390                	sd	a2,0(a5)
ffffffffc0201892:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201894:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201896:	ed1c                	sd	a5,24(a0)
ffffffffc0201898:	0141                	addi	sp,sp,16
ffffffffc020189a:	8082                	ret
            base->property += p->property;
ffffffffc020189c:	ff87a703          	lw	a4,-8(a5)
ffffffffc02018a0:	ff078693          	addi	a3,a5,-16
ffffffffc02018a4:	9e39                	addw	a2,a2,a4
ffffffffc02018a6:	c910                	sw	a2,16(a0)
ffffffffc02018a8:	5775                	li	a4,-3
ffffffffc02018aa:	60e6b02f          	amoand.d	zero,a4,(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc02018ae:	6398                	ld	a4,0(a5)
ffffffffc02018b0:	679c                	ld	a5,8(a5)
}
ffffffffc02018b2:	60a2                	ld	ra,8(sp)
    prev->next = next;
ffffffffc02018b4:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc02018b6:	e398                	sd	a4,0(a5)
ffffffffc02018b8:	0141                	addi	sp,sp,16
ffffffffc02018ba:	8082                	ret
        assert(!PageReserved(p) && !PageProperty(p));
ffffffffc02018bc:	00005697          	auipc	a3,0x5
ffffffffc02018c0:	c0468693          	addi	a3,a3,-1020 # ffffffffc02064c0 <commands+0xb88>
ffffffffc02018c4:	00005617          	auipc	a2,0x5
ffffffffc02018c8:	89c60613          	addi	a2,a2,-1892 # ffffffffc0206160 <commands+0x828>
ffffffffc02018cc:	09400593          	li	a1,148
ffffffffc02018d0:	00005517          	auipc	a0,0x5
ffffffffc02018d4:	8a850513          	addi	a0,a0,-1880 # ffffffffc0206178 <commands+0x840>
ffffffffc02018d8:	bb7fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(n > 0);
ffffffffc02018dc:	00005697          	auipc	a3,0x5
ffffffffc02018e0:	bdc68693          	addi	a3,a3,-1060 # ffffffffc02064b8 <commands+0xb80>
ffffffffc02018e4:	00005617          	auipc	a2,0x5
ffffffffc02018e8:	87c60613          	addi	a2,a2,-1924 # ffffffffc0206160 <commands+0x828>
ffffffffc02018ec:	09000593          	li	a1,144
ffffffffc02018f0:	00005517          	auipc	a0,0x5
ffffffffc02018f4:	88850513          	addi	a0,a0,-1912 # ffffffffc0206178 <commands+0x840>
ffffffffc02018f8:	b97fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02018fc <default_alloc_pages>:
    assert(n > 0);
ffffffffc02018fc:	c941                	beqz	a0,ffffffffc020198c <default_alloc_pages+0x90>
    if (n > nr_free)
ffffffffc02018fe:	000b0597          	auipc	a1,0xb0
ffffffffc0201902:	e2258593          	addi	a1,a1,-478 # ffffffffc02b1720 <free_area>
ffffffffc0201906:	0105a803          	lw	a6,16(a1)
ffffffffc020190a:	872a                	mv	a4,a0
ffffffffc020190c:	02081793          	slli	a5,a6,0x20
ffffffffc0201910:	9381                	srli	a5,a5,0x20
ffffffffc0201912:	00a7ee63          	bltu	a5,a0,ffffffffc020192e <default_alloc_pages+0x32>
    list_entry_t *le = &free_list;
ffffffffc0201916:	87ae                	mv	a5,a1
ffffffffc0201918:	a801                	j	ffffffffc0201928 <default_alloc_pages+0x2c>
        if (p->property >= n)
ffffffffc020191a:	ff87a683          	lw	a3,-8(a5)
ffffffffc020191e:	02069613          	slli	a2,a3,0x20
ffffffffc0201922:	9201                	srli	a2,a2,0x20
ffffffffc0201924:	00e67763          	bgeu	a2,a4,ffffffffc0201932 <default_alloc_pages+0x36>
    return listelm->next;
ffffffffc0201928:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != &free_list)
ffffffffc020192a:	feb798e3          	bne	a5,a1,ffffffffc020191a <default_alloc_pages+0x1e>
        return NULL;
ffffffffc020192e:	4501                	li	a0,0
}
ffffffffc0201930:	8082                	ret
    return listelm->prev;
ffffffffc0201932:	0007b883          	ld	a7,0(a5)
    __list_del(listelm->prev, listelm->next);
ffffffffc0201936:	0087b303          	ld	t1,8(a5)
        struct Page *p = le2page(le, page_link);
ffffffffc020193a:	fe878513          	addi	a0,a5,-24
            p->property = page->property - n;
ffffffffc020193e:	00070e1b          	sext.w	t3,a4
    prev->next = next;
ffffffffc0201942:	0068b423          	sd	t1,8(a7)
    next->prev = prev;
ffffffffc0201946:	01133023          	sd	a7,0(t1)
        if (page->property > n)
ffffffffc020194a:	02c77863          	bgeu	a4,a2,ffffffffc020197a <default_alloc_pages+0x7e>
            struct Page *p = page + n;
ffffffffc020194e:	071a                	slli	a4,a4,0x6
ffffffffc0201950:	972a                	add	a4,a4,a0
            p->property = page->property - n;
ffffffffc0201952:	41c686bb          	subw	a3,a3,t3
ffffffffc0201956:	cb14                	sw	a3,16(a4)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0201958:	00870613          	addi	a2,a4,8
ffffffffc020195c:	4689                	li	a3,2
ffffffffc020195e:	40d6302f          	amoor.d	zero,a3,(a2)
    __list_add(elm, listelm, listelm->next);
ffffffffc0201962:	0088b683          	ld	a3,8(a7)
            list_add(prev, &(p->page_link));
ffffffffc0201966:	01870613          	addi	a2,a4,24
        nr_free -= n;
ffffffffc020196a:	0105a803          	lw	a6,16(a1)
    prev->next = next->prev = elm;
ffffffffc020196e:	e290                	sd	a2,0(a3)
ffffffffc0201970:	00c8b423          	sd	a2,8(a7)
    elm->next = next;
ffffffffc0201974:	f314                	sd	a3,32(a4)
    elm->prev = prev;
ffffffffc0201976:	01173c23          	sd	a7,24(a4)
ffffffffc020197a:	41c8083b          	subw	a6,a6,t3
ffffffffc020197e:	0105a823          	sw	a6,16(a1)
    __op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0201982:	5775                	li	a4,-3
ffffffffc0201984:	17c1                	addi	a5,a5,-16
ffffffffc0201986:	60e7b02f          	amoand.d	zero,a4,(a5)
}
ffffffffc020198a:	8082                	ret
{
ffffffffc020198c:	1141                	addi	sp,sp,-16
    assert(n > 0);
ffffffffc020198e:	00005697          	auipc	a3,0x5
ffffffffc0201992:	b2a68693          	addi	a3,a3,-1238 # ffffffffc02064b8 <commands+0xb80>
ffffffffc0201996:	00004617          	auipc	a2,0x4
ffffffffc020199a:	7ca60613          	addi	a2,a2,1994 # ffffffffc0206160 <commands+0x828>
ffffffffc020199e:	06c00593          	li	a1,108
ffffffffc02019a2:	00004517          	auipc	a0,0x4
ffffffffc02019a6:	7d650513          	addi	a0,a0,2006 # ffffffffc0206178 <commands+0x840>
{
ffffffffc02019aa:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02019ac:	ae3fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02019b0 <default_init_memmap>:
{
ffffffffc02019b0:	1141                	addi	sp,sp,-16
ffffffffc02019b2:	e406                	sd	ra,8(sp)
    assert(n > 0);
ffffffffc02019b4:	c5f1                	beqz	a1,ffffffffc0201a80 <default_init_memmap+0xd0>
    for (; p != base + n; p++)
ffffffffc02019b6:	00659693          	slli	a3,a1,0x6
ffffffffc02019ba:	96aa                	add	a3,a3,a0
ffffffffc02019bc:	87aa                	mv	a5,a0
ffffffffc02019be:	00d50f63          	beq	a0,a3,ffffffffc02019dc <default_init_memmap+0x2c>
    return (((*(volatile unsigned long *)addr) >> nr) & 1);
ffffffffc02019c2:	6798                	ld	a4,8(a5)
ffffffffc02019c4:	8b05                	andi	a4,a4,1
        assert(PageReserved(p));
ffffffffc02019c6:	cf49                	beqz	a4,ffffffffc0201a60 <default_init_memmap+0xb0>
        p->flags = p->property = 0;
ffffffffc02019c8:	0007a823          	sw	zero,16(a5)
ffffffffc02019cc:	0007b423          	sd	zero,8(a5)
ffffffffc02019d0:	0007a023          	sw	zero,0(a5)
    for (; p != base + n; p++)
ffffffffc02019d4:	04078793          	addi	a5,a5,64
ffffffffc02019d8:	fed795e3          	bne	a5,a3,ffffffffc02019c2 <default_init_memmap+0x12>
    base->property = n;
ffffffffc02019dc:	2581                	sext.w	a1,a1
ffffffffc02019de:	c90c                	sw	a1,16(a0)
    __op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc02019e0:	4789                	li	a5,2
ffffffffc02019e2:	00850713          	addi	a4,a0,8
ffffffffc02019e6:	40f7302f          	amoor.d	zero,a5,(a4)
    nr_free += n;
ffffffffc02019ea:	000b0697          	auipc	a3,0xb0
ffffffffc02019ee:	d3668693          	addi	a3,a3,-714 # ffffffffc02b1720 <free_area>
ffffffffc02019f2:	4a98                	lw	a4,16(a3)
    return list->next == list;
ffffffffc02019f4:	669c                	ld	a5,8(a3)
        list_add(&free_list, &(base->page_link));
ffffffffc02019f6:	01850613          	addi	a2,a0,24
    nr_free += n;
ffffffffc02019fa:	9db9                	addw	a1,a1,a4
ffffffffc02019fc:	ca8c                	sw	a1,16(a3)
    if (list_empty(&free_list))
ffffffffc02019fe:	04d78a63          	beq	a5,a3,ffffffffc0201a52 <default_init_memmap+0xa2>
            struct Page *page = le2page(le, page_link);
ffffffffc0201a02:	fe878713          	addi	a4,a5,-24
ffffffffc0201a06:	0006b803          	ld	a6,0(a3)
    if (list_empty(&free_list))
ffffffffc0201a0a:	4581                	li	a1,0
            if (base < page)
ffffffffc0201a0c:	00e56a63          	bltu	a0,a4,ffffffffc0201a20 <default_init_memmap+0x70>
    return listelm->next;
ffffffffc0201a10:	6798                	ld	a4,8(a5)
            else if (list_next(le) == &free_list)
ffffffffc0201a12:	02d70263          	beq	a4,a3,ffffffffc0201a36 <default_init_memmap+0x86>
    for (; p != base + n; p++)
ffffffffc0201a16:	87ba                	mv	a5,a4
            struct Page *page = le2page(le, page_link);
ffffffffc0201a18:	fe878713          	addi	a4,a5,-24
            if (base < page)
ffffffffc0201a1c:	fee57ae3          	bgeu	a0,a4,ffffffffc0201a10 <default_init_memmap+0x60>
ffffffffc0201a20:	c199                	beqz	a1,ffffffffc0201a26 <default_init_memmap+0x76>
ffffffffc0201a22:	0106b023          	sd	a6,0(a3)
    __list_add(elm, listelm->prev, listelm);
ffffffffc0201a26:	6398                	ld	a4,0(a5)
}
ffffffffc0201a28:	60a2                	ld	ra,8(sp)
    prev->next = next->prev = elm;
ffffffffc0201a2a:	e390                	sd	a2,0(a5)
ffffffffc0201a2c:	e710                	sd	a2,8(a4)
    elm->next = next;
ffffffffc0201a2e:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201a30:	ed18                	sd	a4,24(a0)
ffffffffc0201a32:	0141                	addi	sp,sp,16
ffffffffc0201a34:	8082                	ret
    prev->next = next->prev = elm;
ffffffffc0201a36:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201a38:	f114                	sd	a3,32(a0)
    return listelm->next;
ffffffffc0201a3a:	6798                	ld	a4,8(a5)
    elm->prev = prev;
ffffffffc0201a3c:	ed1c                	sd	a5,24(a0)
        while ((le = list_next(le)) != &free_list)
ffffffffc0201a3e:	00d70663          	beq	a4,a3,ffffffffc0201a4a <default_init_memmap+0x9a>
    prev->next = next->prev = elm;
ffffffffc0201a42:	8832                	mv	a6,a2
ffffffffc0201a44:	4585                	li	a1,1
    for (; p != base + n; p++)
ffffffffc0201a46:	87ba                	mv	a5,a4
ffffffffc0201a48:	bfc1                	j	ffffffffc0201a18 <default_init_memmap+0x68>
}
ffffffffc0201a4a:	60a2                	ld	ra,8(sp)
ffffffffc0201a4c:	e290                	sd	a2,0(a3)
ffffffffc0201a4e:	0141                	addi	sp,sp,16
ffffffffc0201a50:	8082                	ret
ffffffffc0201a52:	60a2                	ld	ra,8(sp)
ffffffffc0201a54:	e390                	sd	a2,0(a5)
ffffffffc0201a56:	e790                	sd	a2,8(a5)
    elm->next = next;
ffffffffc0201a58:	f11c                	sd	a5,32(a0)
    elm->prev = prev;
ffffffffc0201a5a:	ed1c                	sd	a5,24(a0)
ffffffffc0201a5c:	0141                	addi	sp,sp,16
ffffffffc0201a5e:	8082                	ret
        assert(PageReserved(p));
ffffffffc0201a60:	00005697          	auipc	a3,0x5
ffffffffc0201a64:	a8868693          	addi	a3,a3,-1400 # ffffffffc02064e8 <commands+0xbb0>
ffffffffc0201a68:	00004617          	auipc	a2,0x4
ffffffffc0201a6c:	6f860613          	addi	a2,a2,1784 # ffffffffc0206160 <commands+0x828>
ffffffffc0201a70:	04b00593          	li	a1,75
ffffffffc0201a74:	00004517          	auipc	a0,0x4
ffffffffc0201a78:	70450513          	addi	a0,a0,1796 # ffffffffc0206178 <commands+0x840>
ffffffffc0201a7c:	a13fe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(n > 0);
ffffffffc0201a80:	00005697          	auipc	a3,0x5
ffffffffc0201a84:	a3868693          	addi	a3,a3,-1480 # ffffffffc02064b8 <commands+0xb80>
ffffffffc0201a88:	00004617          	auipc	a2,0x4
ffffffffc0201a8c:	6d860613          	addi	a2,a2,1752 # ffffffffc0206160 <commands+0x828>
ffffffffc0201a90:	04700593          	li	a1,71
ffffffffc0201a94:	00004517          	auipc	a0,0x4
ffffffffc0201a98:	6e450513          	addi	a0,a0,1764 # ffffffffc0206178 <commands+0x840>
ffffffffc0201a9c:	9f3fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201aa0 <slob_free>:
static void slob_free(void *block, int size)
{
	slob_t *cur, *b = (slob_t *)block;
	unsigned long flags;

	if (!block)
ffffffffc0201aa0:	c94d                	beqz	a0,ffffffffc0201b52 <slob_free+0xb2>
{
ffffffffc0201aa2:	1141                	addi	sp,sp,-16
ffffffffc0201aa4:	e022                	sd	s0,0(sp)
ffffffffc0201aa6:	e406                	sd	ra,8(sp)
ffffffffc0201aa8:	842a                	mv	s0,a0
		return;

	if (size)
ffffffffc0201aaa:	e9c1                	bnez	a1,ffffffffc0201b3a <slob_free+0x9a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201aac:	100027f3          	csrr	a5,sstatus
ffffffffc0201ab0:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0201ab2:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201ab4:	ebd9                	bnez	a5,ffffffffc0201b4a <slob_free+0xaa>
		b->units = SLOB_UNITS(size);

	/* Find reinsertion point */
	spin_lock_irqsave(&slob_lock, flags);
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0201ab6:	000b0617          	auipc	a2,0xb0
ffffffffc0201aba:	85a60613          	addi	a2,a2,-1958 # ffffffffc02b1310 <slobfree>
ffffffffc0201abe:	621c                	ld	a5,0(a2)
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201ac0:	873e                	mv	a4,a5
	for (cur = slobfree; !(b > cur && b < cur->next); cur = cur->next)
ffffffffc0201ac2:	679c                	ld	a5,8(a5)
ffffffffc0201ac4:	02877a63          	bgeu	a4,s0,ffffffffc0201af8 <slob_free+0x58>
ffffffffc0201ac8:	00f46463          	bltu	s0,a5,ffffffffc0201ad0 <slob_free+0x30>
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201acc:	fef76ae3          	bltu	a4,a5,ffffffffc0201ac0 <slob_free+0x20>
			break;

	if (b + b->units == cur->next)
ffffffffc0201ad0:	400c                	lw	a1,0(s0)
ffffffffc0201ad2:	00459693          	slli	a3,a1,0x4
ffffffffc0201ad6:	96a2                	add	a3,a3,s0
ffffffffc0201ad8:	02d78a63          	beq	a5,a3,ffffffffc0201b0c <slob_free+0x6c>
		b->next = cur->next->next;
	}
	else
		b->next = cur->next;

	if (cur + cur->units == b)
ffffffffc0201adc:	4314                	lw	a3,0(a4)
		b->next = cur->next;
ffffffffc0201ade:	e41c                	sd	a5,8(s0)
	if (cur + cur->units == b)
ffffffffc0201ae0:	00469793          	slli	a5,a3,0x4
ffffffffc0201ae4:	97ba                	add	a5,a5,a4
ffffffffc0201ae6:	02f40e63          	beq	s0,a5,ffffffffc0201b22 <slob_free+0x82>
	{
		cur->units += b->units;
		cur->next = b->next;
	}
	else
		cur->next = b;
ffffffffc0201aea:	e700                	sd	s0,8(a4)

	slobfree = cur;
ffffffffc0201aec:	e218                	sd	a4,0(a2)
    if (flag)
ffffffffc0201aee:	e129                	bnez	a0,ffffffffc0201b30 <slob_free+0x90>

	spin_unlock_irqrestore(&slob_lock, flags);
}
ffffffffc0201af0:	60a2                	ld	ra,8(sp)
ffffffffc0201af2:	6402                	ld	s0,0(sp)
ffffffffc0201af4:	0141                	addi	sp,sp,16
ffffffffc0201af6:	8082                	ret
		if (cur >= cur->next && (b > cur || b < cur->next))
ffffffffc0201af8:	fcf764e3          	bltu	a4,a5,ffffffffc0201ac0 <slob_free+0x20>
ffffffffc0201afc:	fcf472e3          	bgeu	s0,a5,ffffffffc0201ac0 <slob_free+0x20>
	if (b + b->units == cur->next)
ffffffffc0201b00:	400c                	lw	a1,0(s0)
ffffffffc0201b02:	00459693          	slli	a3,a1,0x4
ffffffffc0201b06:	96a2                	add	a3,a3,s0
ffffffffc0201b08:	fcd79ae3          	bne	a5,a3,ffffffffc0201adc <slob_free+0x3c>
		b->units += cur->next->units;
ffffffffc0201b0c:	4394                	lw	a3,0(a5)
		b->next = cur->next->next;
ffffffffc0201b0e:	679c                	ld	a5,8(a5)
		b->units += cur->next->units;
ffffffffc0201b10:	9db5                	addw	a1,a1,a3
ffffffffc0201b12:	c00c                	sw	a1,0(s0)
	if (cur + cur->units == b)
ffffffffc0201b14:	4314                	lw	a3,0(a4)
		b->next = cur->next->next;
ffffffffc0201b16:	e41c                	sd	a5,8(s0)
	if (cur + cur->units == b)
ffffffffc0201b18:	00469793          	slli	a5,a3,0x4
ffffffffc0201b1c:	97ba                	add	a5,a5,a4
ffffffffc0201b1e:	fcf416e3          	bne	s0,a5,ffffffffc0201aea <slob_free+0x4a>
		cur->units += b->units;
ffffffffc0201b22:	401c                	lw	a5,0(s0)
		cur->next = b->next;
ffffffffc0201b24:	640c                	ld	a1,8(s0)
	slobfree = cur;
ffffffffc0201b26:	e218                	sd	a4,0(a2)
		cur->units += b->units;
ffffffffc0201b28:	9ebd                	addw	a3,a3,a5
ffffffffc0201b2a:	c314                	sw	a3,0(a4)
		cur->next = b->next;
ffffffffc0201b2c:	e70c                	sd	a1,8(a4)
ffffffffc0201b2e:	d169                	beqz	a0,ffffffffc0201af0 <slob_free+0x50>
}
ffffffffc0201b30:	6402                	ld	s0,0(sp)
ffffffffc0201b32:	60a2                	ld	ra,8(sp)
ffffffffc0201b34:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc0201b36:	e79fe06f          	j	ffffffffc02009ae <intr_enable>
		b->units = SLOB_UNITS(size);
ffffffffc0201b3a:	25bd                	addiw	a1,a1,15
ffffffffc0201b3c:	8191                	srli	a1,a1,0x4
ffffffffc0201b3e:	c10c                	sw	a1,0(a0)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201b40:	100027f3          	csrr	a5,sstatus
ffffffffc0201b44:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0201b46:	4501                	li	a0,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201b48:	d7bd                	beqz	a5,ffffffffc0201ab6 <slob_free+0x16>
        intr_disable();
ffffffffc0201b4a:	e6bfe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc0201b4e:	4505                	li	a0,1
ffffffffc0201b50:	b79d                	j	ffffffffc0201ab6 <slob_free+0x16>
ffffffffc0201b52:	8082                	ret

ffffffffc0201b54 <__slob_get_free_pages.constprop.0>:
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201b54:	4785                	li	a5,1
static void *__slob_get_free_pages(gfp_t gfp, int order)
ffffffffc0201b56:	1141                	addi	sp,sp,-16
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201b58:	00a7953b          	sllw	a0,a5,a0
static void *__slob_get_free_pages(gfp_t gfp, int order)
ffffffffc0201b5c:	e406                	sd	ra,8(sp)
	struct Page *page = alloc_pages(1 << order);
ffffffffc0201b5e:	352000ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
	if (!page)
ffffffffc0201b62:	c91d                	beqz	a0,ffffffffc0201b98 <__slob_get_free_pages.constprop.0+0x44>
    return page - pages + nbase;
ffffffffc0201b64:	000b4697          	auipc	a3,0xb4
ffffffffc0201b68:	c346b683          	ld	a3,-972(a3) # ffffffffc02b5798 <pages>
ffffffffc0201b6c:	8d15                	sub	a0,a0,a3
ffffffffc0201b6e:	8519                	srai	a0,a0,0x6
ffffffffc0201b70:	00006697          	auipc	a3,0x6
ffffffffc0201b74:	cc06b683          	ld	a3,-832(a3) # ffffffffc0207830 <nbase>
ffffffffc0201b78:	9536                	add	a0,a0,a3
    return KADDR(page2pa(page));
ffffffffc0201b7a:	00c51793          	slli	a5,a0,0xc
ffffffffc0201b7e:	83b1                	srli	a5,a5,0xc
ffffffffc0201b80:	000b4717          	auipc	a4,0xb4
ffffffffc0201b84:	c1073703          	ld	a4,-1008(a4) # ffffffffc02b5790 <npage>
    return page2ppn(page) << PGSHIFT;
ffffffffc0201b88:	0532                	slli	a0,a0,0xc
    return KADDR(page2pa(page));
ffffffffc0201b8a:	00e7fa63          	bgeu	a5,a4,ffffffffc0201b9e <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201b8e:	000b4697          	auipc	a3,0xb4
ffffffffc0201b92:	c1a6b683          	ld	a3,-998(a3) # ffffffffc02b57a8 <va_pa_offset>
ffffffffc0201b96:	9536                	add	a0,a0,a3
}
ffffffffc0201b98:	60a2                	ld	ra,8(sp)
ffffffffc0201b9a:	0141                	addi	sp,sp,16
ffffffffc0201b9c:	8082                	ret
ffffffffc0201b9e:	86aa                	mv	a3,a0
ffffffffc0201ba0:	00005617          	auipc	a2,0x5
ffffffffc0201ba4:	9a860613          	addi	a2,a2,-1624 # ffffffffc0206548 <default_pmm_manager+0x38>
ffffffffc0201ba8:	07100593          	li	a1,113
ffffffffc0201bac:	00005517          	auipc	a0,0x5
ffffffffc0201bb0:	9c450513          	addi	a0,a0,-1596 # ffffffffc0206570 <default_pmm_manager+0x60>
ffffffffc0201bb4:	8dbfe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201bb8 <slob_alloc.constprop.0>:
static void *slob_alloc(size_t size, gfp_t gfp, int align)
ffffffffc0201bb8:	1101                	addi	sp,sp,-32
ffffffffc0201bba:	ec06                	sd	ra,24(sp)
ffffffffc0201bbc:	e822                	sd	s0,16(sp)
ffffffffc0201bbe:	e426                	sd	s1,8(sp)
ffffffffc0201bc0:	e04a                	sd	s2,0(sp)
	assert((size + SLOB_UNIT) < PAGE_SIZE);
ffffffffc0201bc2:	01050713          	addi	a4,a0,16
ffffffffc0201bc6:	6785                	lui	a5,0x1
ffffffffc0201bc8:	0cf77363          	bgeu	a4,a5,ffffffffc0201c8e <slob_alloc.constprop.0+0xd6>
	int delta = 0, units = SLOB_UNITS(size);
ffffffffc0201bcc:	00f50493          	addi	s1,a0,15
ffffffffc0201bd0:	8091                	srli	s1,s1,0x4
ffffffffc0201bd2:	2481                	sext.w	s1,s1
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201bd4:	10002673          	csrr	a2,sstatus
ffffffffc0201bd8:	8a09                	andi	a2,a2,2
ffffffffc0201bda:	e25d                	bnez	a2,ffffffffc0201c80 <slob_alloc.constprop.0+0xc8>
	prev = slobfree;
ffffffffc0201bdc:	000af917          	auipc	s2,0xaf
ffffffffc0201be0:	73490913          	addi	s2,s2,1844 # ffffffffc02b1310 <slobfree>
ffffffffc0201be4:	00093683          	ld	a3,0(s2)
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201be8:	669c                	ld	a5,8(a3)
		if (cur->units >= units + delta)
ffffffffc0201bea:	4398                	lw	a4,0(a5)
ffffffffc0201bec:	08975e63          	bge	a4,s1,ffffffffc0201c88 <slob_alloc.constprop.0+0xd0>
		if (cur == slobfree)
ffffffffc0201bf0:	00f68b63          	beq	a3,a5,ffffffffc0201c06 <slob_alloc.constprop.0+0x4e>
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201bf4:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta)
ffffffffc0201bf6:	4018                	lw	a4,0(s0)
ffffffffc0201bf8:	02975a63          	bge	a4,s1,ffffffffc0201c2c <slob_alloc.constprop.0+0x74>
		if (cur == slobfree)
ffffffffc0201bfc:	00093683          	ld	a3,0(s2)
ffffffffc0201c00:	87a2                	mv	a5,s0
ffffffffc0201c02:	fef699e3          	bne	a3,a5,ffffffffc0201bf4 <slob_alloc.constprop.0+0x3c>
    if (flag)
ffffffffc0201c06:	ee31                	bnez	a2,ffffffffc0201c62 <slob_alloc.constprop.0+0xaa>
			cur = (slob_t *)__slob_get_free_page(gfp);
ffffffffc0201c08:	4501                	li	a0,0
ffffffffc0201c0a:	f4bff0ef          	jal	ra,ffffffffc0201b54 <__slob_get_free_pages.constprop.0>
ffffffffc0201c0e:	842a                	mv	s0,a0
			if (!cur)
ffffffffc0201c10:	cd05                	beqz	a0,ffffffffc0201c48 <slob_alloc.constprop.0+0x90>
			slob_free(cur, PAGE_SIZE);
ffffffffc0201c12:	6585                	lui	a1,0x1
ffffffffc0201c14:	e8dff0ef          	jal	ra,ffffffffc0201aa0 <slob_free>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201c18:	10002673          	csrr	a2,sstatus
ffffffffc0201c1c:	8a09                	andi	a2,a2,2
ffffffffc0201c1e:	ee05                	bnez	a2,ffffffffc0201c56 <slob_alloc.constprop.0+0x9e>
			cur = slobfree;
ffffffffc0201c20:	00093783          	ld	a5,0(s2)
	for (cur = prev->next;; prev = cur, cur = cur->next)
ffffffffc0201c24:	6780                	ld	s0,8(a5)
		if (cur->units >= units + delta)
ffffffffc0201c26:	4018                	lw	a4,0(s0)
ffffffffc0201c28:	fc974ae3          	blt	a4,s1,ffffffffc0201bfc <slob_alloc.constprop.0+0x44>
			if (cur->units == units)	/* exact fit? */
ffffffffc0201c2c:	04e48763          	beq	s1,a4,ffffffffc0201c7a <slob_alloc.constprop.0+0xc2>
				prev->next = cur + units;
ffffffffc0201c30:	00449693          	slli	a3,s1,0x4
ffffffffc0201c34:	96a2                	add	a3,a3,s0
ffffffffc0201c36:	e794                	sd	a3,8(a5)
				prev->next->next = cur->next;
ffffffffc0201c38:	640c                	ld	a1,8(s0)
				prev->next->units = cur->units - units;
ffffffffc0201c3a:	9f05                	subw	a4,a4,s1
ffffffffc0201c3c:	c298                	sw	a4,0(a3)
				prev->next->next = cur->next;
ffffffffc0201c3e:	e68c                	sd	a1,8(a3)
				cur->units = units;
ffffffffc0201c40:	c004                	sw	s1,0(s0)
			slobfree = prev;
ffffffffc0201c42:	00f93023          	sd	a5,0(s2)
    if (flag)
ffffffffc0201c46:	e20d                	bnez	a2,ffffffffc0201c68 <slob_alloc.constprop.0+0xb0>
}
ffffffffc0201c48:	60e2                	ld	ra,24(sp)
ffffffffc0201c4a:	8522                	mv	a0,s0
ffffffffc0201c4c:	6442                	ld	s0,16(sp)
ffffffffc0201c4e:	64a2                	ld	s1,8(sp)
ffffffffc0201c50:	6902                	ld	s2,0(sp)
ffffffffc0201c52:	6105                	addi	sp,sp,32
ffffffffc0201c54:	8082                	ret
        intr_disable();
ffffffffc0201c56:	d5ffe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
			cur = slobfree;
ffffffffc0201c5a:	00093783          	ld	a5,0(s2)
        return 1;
ffffffffc0201c5e:	4605                	li	a2,1
ffffffffc0201c60:	b7d1                	j	ffffffffc0201c24 <slob_alloc.constprop.0+0x6c>
        intr_enable();
ffffffffc0201c62:	d4dfe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0201c66:	b74d                	j	ffffffffc0201c08 <slob_alloc.constprop.0+0x50>
ffffffffc0201c68:	d47fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
}
ffffffffc0201c6c:	60e2                	ld	ra,24(sp)
ffffffffc0201c6e:	8522                	mv	a0,s0
ffffffffc0201c70:	6442                	ld	s0,16(sp)
ffffffffc0201c72:	64a2                	ld	s1,8(sp)
ffffffffc0201c74:	6902                	ld	s2,0(sp)
ffffffffc0201c76:	6105                	addi	sp,sp,32
ffffffffc0201c78:	8082                	ret
				prev->next = cur->next; /* unlink */
ffffffffc0201c7a:	6418                	ld	a4,8(s0)
ffffffffc0201c7c:	e798                	sd	a4,8(a5)
ffffffffc0201c7e:	b7d1                	j	ffffffffc0201c42 <slob_alloc.constprop.0+0x8a>
        intr_disable();
ffffffffc0201c80:	d35fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc0201c84:	4605                	li	a2,1
ffffffffc0201c86:	bf99                	j	ffffffffc0201bdc <slob_alloc.constprop.0+0x24>
		if (cur->units >= units + delta)
ffffffffc0201c88:	843e                	mv	s0,a5
ffffffffc0201c8a:	87b6                	mv	a5,a3
ffffffffc0201c8c:	b745                	j	ffffffffc0201c2c <slob_alloc.constprop.0+0x74>
	assert((size + SLOB_UNIT) < PAGE_SIZE);
ffffffffc0201c8e:	00005697          	auipc	a3,0x5
ffffffffc0201c92:	8f268693          	addi	a3,a3,-1806 # ffffffffc0206580 <default_pmm_manager+0x70>
ffffffffc0201c96:	00004617          	auipc	a2,0x4
ffffffffc0201c9a:	4ca60613          	addi	a2,a2,1226 # ffffffffc0206160 <commands+0x828>
ffffffffc0201c9e:	06300593          	li	a1,99
ffffffffc0201ca2:	00005517          	auipc	a0,0x5
ffffffffc0201ca6:	8fe50513          	addi	a0,a0,-1794 # ffffffffc02065a0 <default_pmm_manager+0x90>
ffffffffc0201caa:	fe4fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201cae <kmalloc_init>:
	cprintf("use SLOB allocator\n");
}

inline void
kmalloc_init(void)
{
ffffffffc0201cae:	1141                	addi	sp,sp,-16
	cprintf("use SLOB allocator\n");
ffffffffc0201cb0:	00005517          	auipc	a0,0x5
ffffffffc0201cb4:	90850513          	addi	a0,a0,-1784 # ffffffffc02065b8 <default_pmm_manager+0xa8>
{
ffffffffc0201cb8:	e406                	sd	ra,8(sp)
	cprintf("use SLOB allocator\n");
ffffffffc0201cba:	cdafe0ef          	jal	ra,ffffffffc0200194 <cprintf>
	slob_init();
	cprintf("kmalloc_init() succeeded!\n");
}
ffffffffc0201cbe:	60a2                	ld	ra,8(sp)
	cprintf("kmalloc_init() succeeded!\n");
ffffffffc0201cc0:	00005517          	auipc	a0,0x5
ffffffffc0201cc4:	91050513          	addi	a0,a0,-1776 # ffffffffc02065d0 <default_pmm_manager+0xc0>
}
ffffffffc0201cc8:	0141                	addi	sp,sp,16
	cprintf("kmalloc_init() succeeded!\n");
ffffffffc0201cca:	ccafe06f          	j	ffffffffc0200194 <cprintf>

ffffffffc0201cce <kallocated>:

size_t
kallocated(void)
{
	return slob_allocated();
}
ffffffffc0201cce:	4501                	li	a0,0
ffffffffc0201cd0:	8082                	ret

ffffffffc0201cd2 <kmalloc>:
	return 0;
}

void *
kmalloc(size_t size)
{
ffffffffc0201cd2:	1101                	addi	sp,sp,-32
ffffffffc0201cd4:	e04a                	sd	s2,0(sp)
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201cd6:	6905                	lui	s2,0x1
{
ffffffffc0201cd8:	e822                	sd	s0,16(sp)
ffffffffc0201cda:	ec06                	sd	ra,24(sp)
ffffffffc0201cdc:	e426                	sd	s1,8(sp)
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201cde:	fef90793          	addi	a5,s2,-17 # fef <_binary_obj___user_faultread_out_size-0x8bc1>
{
ffffffffc0201ce2:	842a                	mv	s0,a0
	if (size < PAGE_SIZE - SLOB_UNIT)
ffffffffc0201ce4:	04a7f963          	bgeu	a5,a0,ffffffffc0201d36 <kmalloc+0x64>
	bb = slob_alloc(sizeof(bigblock_t), gfp, 0);
ffffffffc0201ce8:	4561                	li	a0,24
ffffffffc0201cea:	ecfff0ef          	jal	ra,ffffffffc0201bb8 <slob_alloc.constprop.0>
ffffffffc0201cee:	84aa                	mv	s1,a0
	if (!bb)
ffffffffc0201cf0:	c929                	beqz	a0,ffffffffc0201d42 <kmalloc+0x70>
	bb->order = find_order(size);
ffffffffc0201cf2:	0004079b          	sext.w	a5,s0
	int order = 0;
ffffffffc0201cf6:	4501                	li	a0,0
	for (; size > 4096; size >>= 1)
ffffffffc0201cf8:	00f95763          	bge	s2,a5,ffffffffc0201d06 <kmalloc+0x34>
ffffffffc0201cfc:	6705                	lui	a4,0x1
ffffffffc0201cfe:	8785                	srai	a5,a5,0x1
		order++;
ffffffffc0201d00:	2505                	addiw	a0,a0,1
	for (; size > 4096; size >>= 1)
ffffffffc0201d02:	fef74ee3          	blt	a4,a5,ffffffffc0201cfe <kmalloc+0x2c>
	bb->order = find_order(size);
ffffffffc0201d06:	c088                	sw	a0,0(s1)
	bb->pages = (void *)__slob_get_free_pages(gfp, bb->order);
ffffffffc0201d08:	e4dff0ef          	jal	ra,ffffffffc0201b54 <__slob_get_free_pages.constprop.0>
ffffffffc0201d0c:	e488                	sd	a0,8(s1)
ffffffffc0201d0e:	842a                	mv	s0,a0
	if (bb->pages)
ffffffffc0201d10:	c525                	beqz	a0,ffffffffc0201d78 <kmalloc+0xa6>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201d12:	100027f3          	csrr	a5,sstatus
ffffffffc0201d16:	8b89                	andi	a5,a5,2
ffffffffc0201d18:	ef8d                	bnez	a5,ffffffffc0201d52 <kmalloc+0x80>
		bb->next = bigblocks;
ffffffffc0201d1a:	000b4797          	auipc	a5,0xb4
ffffffffc0201d1e:	a5e78793          	addi	a5,a5,-1442 # ffffffffc02b5778 <bigblocks>
ffffffffc0201d22:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc0201d24:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc0201d26:	e898                	sd	a4,16(s1)
	return __kmalloc(size, 0);
}
ffffffffc0201d28:	60e2                	ld	ra,24(sp)
ffffffffc0201d2a:	8522                	mv	a0,s0
ffffffffc0201d2c:	6442                	ld	s0,16(sp)
ffffffffc0201d2e:	64a2                	ld	s1,8(sp)
ffffffffc0201d30:	6902                	ld	s2,0(sp)
ffffffffc0201d32:	6105                	addi	sp,sp,32
ffffffffc0201d34:	8082                	ret
		m = slob_alloc(size + SLOB_UNIT, gfp, 0);
ffffffffc0201d36:	0541                	addi	a0,a0,16
ffffffffc0201d38:	e81ff0ef          	jal	ra,ffffffffc0201bb8 <slob_alloc.constprop.0>
		return m ? (void *)(m + 1) : 0;
ffffffffc0201d3c:	01050413          	addi	s0,a0,16
ffffffffc0201d40:	f565                	bnez	a0,ffffffffc0201d28 <kmalloc+0x56>
ffffffffc0201d42:	4401                	li	s0,0
}
ffffffffc0201d44:	60e2                	ld	ra,24(sp)
ffffffffc0201d46:	8522                	mv	a0,s0
ffffffffc0201d48:	6442                	ld	s0,16(sp)
ffffffffc0201d4a:	64a2                	ld	s1,8(sp)
ffffffffc0201d4c:	6902                	ld	s2,0(sp)
ffffffffc0201d4e:	6105                	addi	sp,sp,32
ffffffffc0201d50:	8082                	ret
        intr_disable();
ffffffffc0201d52:	c63fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
		bb->next = bigblocks;
ffffffffc0201d56:	000b4797          	auipc	a5,0xb4
ffffffffc0201d5a:	a2278793          	addi	a5,a5,-1502 # ffffffffc02b5778 <bigblocks>
ffffffffc0201d5e:	6398                	ld	a4,0(a5)
		bigblocks = bb;
ffffffffc0201d60:	e384                	sd	s1,0(a5)
		bb->next = bigblocks;
ffffffffc0201d62:	e898                	sd	a4,16(s1)
        intr_enable();
ffffffffc0201d64:	c4bfe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
		return bb->pages;
ffffffffc0201d68:	6480                	ld	s0,8(s1)
}
ffffffffc0201d6a:	60e2                	ld	ra,24(sp)
ffffffffc0201d6c:	64a2                	ld	s1,8(sp)
ffffffffc0201d6e:	8522                	mv	a0,s0
ffffffffc0201d70:	6442                	ld	s0,16(sp)
ffffffffc0201d72:	6902                	ld	s2,0(sp)
ffffffffc0201d74:	6105                	addi	sp,sp,32
ffffffffc0201d76:	8082                	ret
	slob_free(bb, sizeof(bigblock_t));
ffffffffc0201d78:	45e1                	li	a1,24
ffffffffc0201d7a:	8526                	mv	a0,s1
ffffffffc0201d7c:	d25ff0ef          	jal	ra,ffffffffc0201aa0 <slob_free>
	return __kmalloc(size, 0);
ffffffffc0201d80:	b765                	j	ffffffffc0201d28 <kmalloc+0x56>

ffffffffc0201d82 <kfree>:
void kfree(void *block)
{
	bigblock_t *bb, **last = &bigblocks;
	unsigned long flags;

	if (!block)
ffffffffc0201d82:	c169                	beqz	a0,ffffffffc0201e44 <kfree+0xc2>
{
ffffffffc0201d84:	1101                	addi	sp,sp,-32
ffffffffc0201d86:	e822                	sd	s0,16(sp)
ffffffffc0201d88:	ec06                	sd	ra,24(sp)
ffffffffc0201d8a:	e426                	sd	s1,8(sp)
		return;

	if (!((unsigned long)block & (PAGE_SIZE - 1)))
ffffffffc0201d8c:	03451793          	slli	a5,a0,0x34
ffffffffc0201d90:	842a                	mv	s0,a0
ffffffffc0201d92:	e3d9                	bnez	a5,ffffffffc0201e18 <kfree+0x96>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201d94:	100027f3          	csrr	a5,sstatus
ffffffffc0201d98:	8b89                	andi	a5,a5,2
ffffffffc0201d9a:	e7d9                	bnez	a5,ffffffffc0201e28 <kfree+0xa6>
	{
		/* might be on the big block list */
		spin_lock_irqsave(&block_lock, flags);
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201d9c:	000b4797          	auipc	a5,0xb4
ffffffffc0201da0:	9dc7b783          	ld	a5,-1572(a5) # ffffffffc02b5778 <bigblocks>
    return 0;
ffffffffc0201da4:	4601                	li	a2,0
ffffffffc0201da6:	cbad                	beqz	a5,ffffffffc0201e18 <kfree+0x96>
	bigblock_t *bb, **last = &bigblocks;
ffffffffc0201da8:	000b4697          	auipc	a3,0xb4
ffffffffc0201dac:	9d068693          	addi	a3,a3,-1584 # ffffffffc02b5778 <bigblocks>
ffffffffc0201db0:	a021                	j	ffffffffc0201db8 <kfree+0x36>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201db2:	01048693          	addi	a3,s1,16
ffffffffc0201db6:	c3a5                	beqz	a5,ffffffffc0201e16 <kfree+0x94>
		{
			if (bb->pages == block)
ffffffffc0201db8:	6798                	ld	a4,8(a5)
ffffffffc0201dba:	84be                	mv	s1,a5
			{
				*last = bb->next;
ffffffffc0201dbc:	6b9c                	ld	a5,16(a5)
			if (bb->pages == block)
ffffffffc0201dbe:	fe871ae3          	bne	a4,s0,ffffffffc0201db2 <kfree+0x30>
				*last = bb->next;
ffffffffc0201dc2:	e29c                	sd	a5,0(a3)
    if (flag)
ffffffffc0201dc4:	ee2d                	bnez	a2,ffffffffc0201e3e <kfree+0xbc>
    return pa2page(PADDR(kva));
ffffffffc0201dc6:	c02007b7          	lui	a5,0xc0200
				spin_unlock_irqrestore(&block_lock, flags);
				__slob_free_pages((unsigned long)block, bb->order);
ffffffffc0201dca:	4098                	lw	a4,0(s1)
ffffffffc0201dcc:	08f46963          	bltu	s0,a5,ffffffffc0201e5e <kfree+0xdc>
ffffffffc0201dd0:	000b4697          	auipc	a3,0xb4
ffffffffc0201dd4:	9d86b683          	ld	a3,-1576(a3) # ffffffffc02b57a8 <va_pa_offset>
ffffffffc0201dd8:	8c15                	sub	s0,s0,a3
    if (PPN(pa) >= npage)
ffffffffc0201dda:	8031                	srli	s0,s0,0xc
ffffffffc0201ddc:	000b4797          	auipc	a5,0xb4
ffffffffc0201de0:	9b47b783          	ld	a5,-1612(a5) # ffffffffc02b5790 <npage>
ffffffffc0201de4:	06f47163          	bgeu	s0,a5,ffffffffc0201e46 <kfree+0xc4>
    return &pages[PPN(pa) - nbase];
ffffffffc0201de8:	00006517          	auipc	a0,0x6
ffffffffc0201dec:	a4853503          	ld	a0,-1464(a0) # ffffffffc0207830 <nbase>
ffffffffc0201df0:	8c09                	sub	s0,s0,a0
ffffffffc0201df2:	041a                	slli	s0,s0,0x6
	free_pages(kva2page(kva), 1 << order);
ffffffffc0201df4:	000b4517          	auipc	a0,0xb4
ffffffffc0201df8:	9a453503          	ld	a0,-1628(a0) # ffffffffc02b5798 <pages>
ffffffffc0201dfc:	4585                	li	a1,1
ffffffffc0201dfe:	9522                	add	a0,a0,s0
ffffffffc0201e00:	00e595bb          	sllw	a1,a1,a4
ffffffffc0201e04:	0ea000ef          	jal	ra,ffffffffc0201eee <free_pages>
		spin_unlock_irqrestore(&block_lock, flags);
	}

	slob_free((slob_t *)block - 1, 0);
	return;
}
ffffffffc0201e08:	6442                	ld	s0,16(sp)
ffffffffc0201e0a:	60e2                	ld	ra,24(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201e0c:	8526                	mv	a0,s1
}
ffffffffc0201e0e:	64a2                	ld	s1,8(sp)
				slob_free(bb, sizeof(bigblock_t));
ffffffffc0201e10:	45e1                	li	a1,24
}
ffffffffc0201e12:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201e14:	b171                	j	ffffffffc0201aa0 <slob_free>
ffffffffc0201e16:	e20d                	bnez	a2,ffffffffc0201e38 <kfree+0xb6>
ffffffffc0201e18:	ff040513          	addi	a0,s0,-16
}
ffffffffc0201e1c:	6442                	ld	s0,16(sp)
ffffffffc0201e1e:	60e2                	ld	ra,24(sp)
ffffffffc0201e20:	64a2                	ld	s1,8(sp)
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201e22:	4581                	li	a1,0
}
ffffffffc0201e24:	6105                	addi	sp,sp,32
	slob_free((slob_t *)block - 1, 0);
ffffffffc0201e26:	b9ad                	j	ffffffffc0201aa0 <slob_free>
        intr_disable();
ffffffffc0201e28:	b8dfe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
		for (bb = bigblocks; bb; last = &bb->next, bb = bb->next)
ffffffffc0201e2c:	000b4797          	auipc	a5,0xb4
ffffffffc0201e30:	94c7b783          	ld	a5,-1716(a5) # ffffffffc02b5778 <bigblocks>
        return 1;
ffffffffc0201e34:	4605                	li	a2,1
ffffffffc0201e36:	fbad                	bnez	a5,ffffffffc0201da8 <kfree+0x26>
        intr_enable();
ffffffffc0201e38:	b77fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0201e3c:	bff1                	j	ffffffffc0201e18 <kfree+0x96>
ffffffffc0201e3e:	b71fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0201e42:	b751                	j	ffffffffc0201dc6 <kfree+0x44>
ffffffffc0201e44:	8082                	ret
        panic("pa2page called with invalid pa");
ffffffffc0201e46:	00004617          	auipc	a2,0x4
ffffffffc0201e4a:	7d260613          	addi	a2,a2,2002 # ffffffffc0206618 <default_pmm_manager+0x108>
ffffffffc0201e4e:	06900593          	li	a1,105
ffffffffc0201e52:	00004517          	auipc	a0,0x4
ffffffffc0201e56:	71e50513          	addi	a0,a0,1822 # ffffffffc0206570 <default_pmm_manager+0x60>
ffffffffc0201e5a:	e34fe0ef          	jal	ra,ffffffffc020048e <__panic>
    return pa2page(PADDR(kva));
ffffffffc0201e5e:	86a2                	mv	a3,s0
ffffffffc0201e60:	00004617          	auipc	a2,0x4
ffffffffc0201e64:	79060613          	addi	a2,a2,1936 # ffffffffc02065f0 <default_pmm_manager+0xe0>
ffffffffc0201e68:	07700593          	li	a1,119
ffffffffc0201e6c:	00004517          	auipc	a0,0x4
ffffffffc0201e70:	70450513          	addi	a0,a0,1796 # ffffffffc0206570 <default_pmm_manager+0x60>
ffffffffc0201e74:	e1afe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201e78 <pa2page.part.0>:
pa2page(uintptr_t pa)
ffffffffc0201e78:	1141                	addi	sp,sp,-16
        panic("pa2page called with invalid pa");
ffffffffc0201e7a:	00004617          	auipc	a2,0x4
ffffffffc0201e7e:	79e60613          	addi	a2,a2,1950 # ffffffffc0206618 <default_pmm_manager+0x108>
ffffffffc0201e82:	06900593          	li	a1,105
ffffffffc0201e86:	00004517          	auipc	a0,0x4
ffffffffc0201e8a:	6ea50513          	addi	a0,a0,1770 # ffffffffc0206570 <default_pmm_manager+0x60>
pa2page(uintptr_t pa)
ffffffffc0201e8e:	e406                	sd	ra,8(sp)
        panic("pa2page called with invalid pa");
ffffffffc0201e90:	dfefe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201e94 <pte2page.part.0>:
pte2page(pte_t pte)
ffffffffc0201e94:	1141                	addi	sp,sp,-16
        panic("pte2page called with invalid pte");
ffffffffc0201e96:	00004617          	auipc	a2,0x4
ffffffffc0201e9a:	7a260613          	addi	a2,a2,1954 # ffffffffc0206638 <default_pmm_manager+0x128>
ffffffffc0201e9e:	07f00593          	li	a1,127
ffffffffc0201ea2:	00004517          	auipc	a0,0x4
ffffffffc0201ea6:	6ce50513          	addi	a0,a0,1742 # ffffffffc0206570 <default_pmm_manager+0x60>
pte2page(pte_t pte)
ffffffffc0201eaa:	e406                	sd	ra,8(sp)
        panic("pte2page called with invalid pte");
ffffffffc0201eac:	de2fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0201eb0 <alloc_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201eb0:	100027f3          	csrr	a5,sstatus
ffffffffc0201eb4:	8b89                	andi	a5,a5,2
ffffffffc0201eb6:	e799                	bnez	a5,ffffffffc0201ec4 <alloc_pages+0x14>
{
    struct Page *page = NULL;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        page = pmm_manager->alloc_pages(n);
ffffffffc0201eb8:	000b4797          	auipc	a5,0xb4
ffffffffc0201ebc:	8e87b783          	ld	a5,-1816(a5) # ffffffffc02b57a0 <pmm_manager>
ffffffffc0201ec0:	6f9c                	ld	a5,24(a5)
ffffffffc0201ec2:	8782                	jr	a5
{
ffffffffc0201ec4:	1141                	addi	sp,sp,-16
ffffffffc0201ec6:	e406                	sd	ra,8(sp)
ffffffffc0201ec8:	e022                	sd	s0,0(sp)
ffffffffc0201eca:	842a                	mv	s0,a0
        intr_disable();
ffffffffc0201ecc:	ae9fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201ed0:	000b4797          	auipc	a5,0xb4
ffffffffc0201ed4:	8d07b783          	ld	a5,-1840(a5) # ffffffffc02b57a0 <pmm_manager>
ffffffffc0201ed8:	6f9c                	ld	a5,24(a5)
ffffffffc0201eda:	8522                	mv	a0,s0
ffffffffc0201edc:	9782                	jalr	a5
ffffffffc0201ede:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201ee0:	acffe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
    }
    local_intr_restore(intr_flag);
    return page;
}
ffffffffc0201ee4:	60a2                	ld	ra,8(sp)
ffffffffc0201ee6:	8522                	mv	a0,s0
ffffffffc0201ee8:	6402                	ld	s0,0(sp)
ffffffffc0201eea:	0141                	addi	sp,sp,16
ffffffffc0201eec:	8082                	ret

ffffffffc0201eee <free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201eee:	100027f3          	csrr	a5,sstatus
ffffffffc0201ef2:	8b89                	andi	a5,a5,2
ffffffffc0201ef4:	e799                	bnez	a5,ffffffffc0201f02 <free_pages+0x14>
void free_pages(struct Page *base, size_t n)
{
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        pmm_manager->free_pages(base, n);
ffffffffc0201ef6:	000b4797          	auipc	a5,0xb4
ffffffffc0201efa:	8aa7b783          	ld	a5,-1878(a5) # ffffffffc02b57a0 <pmm_manager>
ffffffffc0201efe:	739c                	ld	a5,32(a5)
ffffffffc0201f00:	8782                	jr	a5
{
ffffffffc0201f02:	1101                	addi	sp,sp,-32
ffffffffc0201f04:	ec06                	sd	ra,24(sp)
ffffffffc0201f06:	e822                	sd	s0,16(sp)
ffffffffc0201f08:	e426                	sd	s1,8(sp)
ffffffffc0201f0a:	842a                	mv	s0,a0
ffffffffc0201f0c:	84ae                	mv	s1,a1
        intr_disable();
ffffffffc0201f0e:	aa7fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0201f12:	000b4797          	auipc	a5,0xb4
ffffffffc0201f16:	88e7b783          	ld	a5,-1906(a5) # ffffffffc02b57a0 <pmm_manager>
ffffffffc0201f1a:	739c                	ld	a5,32(a5)
ffffffffc0201f1c:	85a6                	mv	a1,s1
ffffffffc0201f1e:	8522                	mv	a0,s0
ffffffffc0201f20:	9782                	jalr	a5
    }
    local_intr_restore(intr_flag);
}
ffffffffc0201f22:	6442                	ld	s0,16(sp)
ffffffffc0201f24:	60e2                	ld	ra,24(sp)
ffffffffc0201f26:	64a2                	ld	s1,8(sp)
ffffffffc0201f28:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc0201f2a:	a85fe06f          	j	ffffffffc02009ae <intr_enable>

ffffffffc0201f2e <nr_free_pages>:
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201f2e:	100027f3          	csrr	a5,sstatus
ffffffffc0201f32:	8b89                	andi	a5,a5,2
ffffffffc0201f34:	e799                	bnez	a5,ffffffffc0201f42 <nr_free_pages+0x14>
{
    size_t ret;
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        ret = pmm_manager->nr_free_pages();
ffffffffc0201f36:	000b4797          	auipc	a5,0xb4
ffffffffc0201f3a:	86a7b783          	ld	a5,-1942(a5) # ffffffffc02b57a0 <pmm_manager>
ffffffffc0201f3e:	779c                	ld	a5,40(a5)
ffffffffc0201f40:	8782                	jr	a5
{
ffffffffc0201f42:	1141                	addi	sp,sp,-16
ffffffffc0201f44:	e406                	sd	ra,8(sp)
ffffffffc0201f46:	e022                	sd	s0,0(sp)
        intr_disable();
ffffffffc0201f48:	a6dfe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0201f4c:	000b4797          	auipc	a5,0xb4
ffffffffc0201f50:	8547b783          	ld	a5,-1964(a5) # ffffffffc02b57a0 <pmm_manager>
ffffffffc0201f54:	779c                	ld	a5,40(a5)
ffffffffc0201f56:	9782                	jalr	a5
ffffffffc0201f58:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0201f5a:	a55fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
    }
    local_intr_restore(intr_flag);
    return ret;
}
ffffffffc0201f5e:	60a2                	ld	ra,8(sp)
ffffffffc0201f60:	8522                	mv	a0,s0
ffffffffc0201f62:	6402                	ld	s0,0(sp)
ffffffffc0201f64:	0141                	addi	sp,sp,16
ffffffffc0201f66:	8082                	ret

ffffffffc0201f68 <get_pte>:
//  la:     the linear address need to map
//  create: a logical value to decide if alloc a page for PT
// return vaule: the kernel virtual address of this pte
pte_t *get_pte(pde_t *pgdir, uintptr_t la, bool create)
{
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201f68:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0201f6c:	1ff7f793          	andi	a5,a5,511
{
ffffffffc0201f70:	7139                	addi	sp,sp,-64
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201f72:	078e                	slli	a5,a5,0x3
{
ffffffffc0201f74:	f426                	sd	s1,40(sp)
    pde_t *pdep1 = &pgdir[PDX1(la)];
ffffffffc0201f76:	00f504b3          	add	s1,a0,a5
    if (!(*pdep1 & PTE_V))
ffffffffc0201f7a:	6094                	ld	a3,0(s1)
{
ffffffffc0201f7c:	f04a                	sd	s2,32(sp)
ffffffffc0201f7e:	ec4e                	sd	s3,24(sp)
ffffffffc0201f80:	e852                	sd	s4,16(sp)
ffffffffc0201f82:	fc06                	sd	ra,56(sp)
ffffffffc0201f84:	f822                	sd	s0,48(sp)
ffffffffc0201f86:	e456                	sd	s5,8(sp)
ffffffffc0201f88:	e05a                	sd	s6,0(sp)
    if (!(*pdep1 & PTE_V))
ffffffffc0201f8a:	0016f793          	andi	a5,a3,1
{
ffffffffc0201f8e:	892e                	mv	s2,a1
ffffffffc0201f90:	8a32                	mv	s4,a2
ffffffffc0201f92:	000b3997          	auipc	s3,0xb3
ffffffffc0201f96:	7fe98993          	addi	s3,s3,2046 # ffffffffc02b5790 <npage>
    if (!(*pdep1 & PTE_V))
ffffffffc0201f9a:	efbd                	bnez	a5,ffffffffc0202018 <get_pte+0xb0>
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201f9c:	14060c63          	beqz	a2,ffffffffc02020f4 <get_pte+0x18c>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0201fa0:	100027f3          	csrr	a5,sstatus
ffffffffc0201fa4:	8b89                	andi	a5,a5,2
ffffffffc0201fa6:	14079963          	bnez	a5,ffffffffc02020f8 <get_pte+0x190>
        page = pmm_manager->alloc_pages(n);
ffffffffc0201faa:	000b3797          	auipc	a5,0xb3
ffffffffc0201fae:	7f67b783          	ld	a5,2038(a5) # ffffffffc02b57a0 <pmm_manager>
ffffffffc0201fb2:	6f9c                	ld	a5,24(a5)
ffffffffc0201fb4:	4505                	li	a0,1
ffffffffc0201fb6:	9782                	jalr	a5
ffffffffc0201fb8:	842a                	mv	s0,a0
        if (!create || (page = alloc_page()) == NULL)
ffffffffc0201fba:	12040d63          	beqz	s0,ffffffffc02020f4 <get_pte+0x18c>
    return page - pages + nbase;
ffffffffc0201fbe:	000b3b17          	auipc	s6,0xb3
ffffffffc0201fc2:	7dab0b13          	addi	s6,s6,2010 # ffffffffc02b5798 <pages>
ffffffffc0201fc6:	000b3503          	ld	a0,0(s6)
ffffffffc0201fca:	00080ab7          	lui	s5,0x80
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0201fce:	000b3997          	auipc	s3,0xb3
ffffffffc0201fd2:	7c298993          	addi	s3,s3,1986 # ffffffffc02b5790 <npage>
ffffffffc0201fd6:	40a40533          	sub	a0,s0,a0
ffffffffc0201fda:	8519                	srai	a0,a0,0x6
ffffffffc0201fdc:	9556                	add	a0,a0,s5
ffffffffc0201fde:	0009b703          	ld	a4,0(s3)
ffffffffc0201fe2:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc0201fe6:	4685                	li	a3,1
ffffffffc0201fe8:	c014                	sw	a3,0(s0)
ffffffffc0201fea:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0201fec:	0532                	slli	a0,a0,0xc
ffffffffc0201fee:	16e7f763          	bgeu	a5,a4,ffffffffc020215c <get_pte+0x1f4>
ffffffffc0201ff2:	000b3797          	auipc	a5,0xb3
ffffffffc0201ff6:	7b67b783          	ld	a5,1974(a5) # ffffffffc02b57a8 <va_pa_offset>
ffffffffc0201ffa:	6605                	lui	a2,0x1
ffffffffc0201ffc:	4581                	li	a1,0
ffffffffc0201ffe:	953e                	add	a0,a0,a5
ffffffffc0202000:	6a4030ef          	jal	ra,ffffffffc02056a4 <memset>
    return page - pages + nbase;
ffffffffc0202004:	000b3683          	ld	a3,0(s6)
ffffffffc0202008:	40d406b3          	sub	a3,s0,a3
ffffffffc020200c:	8699                	srai	a3,a3,0x6
ffffffffc020200e:	96d6                	add	a3,a3,s5
}

// construct PTE from a page and permission bits
static inline pte_t pte_create(uintptr_t ppn, int type)
{
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc0202010:	06aa                	slli	a3,a3,0xa
ffffffffc0202012:	0116e693          	ori	a3,a3,17
        *pdep1 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc0202016:	e094                	sd	a3,0(s1)
    }

    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0202018:	77fd                	lui	a5,0xfffff
ffffffffc020201a:	068a                	slli	a3,a3,0x2
ffffffffc020201c:	0009b703          	ld	a4,0(s3)
ffffffffc0202020:	8efd                	and	a3,a3,a5
ffffffffc0202022:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202026:	10e7ff63          	bgeu	a5,a4,ffffffffc0202144 <get_pte+0x1dc>
ffffffffc020202a:	000b3a97          	auipc	s5,0xb3
ffffffffc020202e:	77ea8a93          	addi	s5,s5,1918 # ffffffffc02b57a8 <va_pa_offset>
ffffffffc0202032:	000ab403          	ld	s0,0(s5)
ffffffffc0202036:	01595793          	srli	a5,s2,0x15
ffffffffc020203a:	1ff7f793          	andi	a5,a5,511
ffffffffc020203e:	96a2                	add	a3,a3,s0
ffffffffc0202040:	00379413          	slli	s0,a5,0x3
ffffffffc0202044:	9436                	add	s0,s0,a3
    if (!(*pdep0 & PTE_V))
ffffffffc0202046:	6014                	ld	a3,0(s0)
ffffffffc0202048:	0016f793          	andi	a5,a3,1
ffffffffc020204c:	ebad                	bnez	a5,ffffffffc02020be <get_pte+0x156>
    {
        struct Page *page;
        if (!create || (page = alloc_page()) == NULL)
ffffffffc020204e:	0a0a0363          	beqz	s4,ffffffffc02020f4 <get_pte+0x18c>
ffffffffc0202052:	100027f3          	csrr	a5,sstatus
ffffffffc0202056:	8b89                	andi	a5,a5,2
ffffffffc0202058:	efcd                	bnez	a5,ffffffffc0202112 <get_pte+0x1aa>
        page = pmm_manager->alloc_pages(n);
ffffffffc020205a:	000b3797          	auipc	a5,0xb3
ffffffffc020205e:	7467b783          	ld	a5,1862(a5) # ffffffffc02b57a0 <pmm_manager>
ffffffffc0202062:	6f9c                	ld	a5,24(a5)
ffffffffc0202064:	4505                	li	a0,1
ffffffffc0202066:	9782                	jalr	a5
ffffffffc0202068:	84aa                	mv	s1,a0
        if (!create || (page = alloc_page()) == NULL)
ffffffffc020206a:	c4c9                	beqz	s1,ffffffffc02020f4 <get_pte+0x18c>
    return page - pages + nbase;
ffffffffc020206c:	000b3b17          	auipc	s6,0xb3
ffffffffc0202070:	72cb0b13          	addi	s6,s6,1836 # ffffffffc02b5798 <pages>
ffffffffc0202074:	000b3503          	ld	a0,0(s6)
ffffffffc0202078:	00080a37          	lui	s4,0x80
        {
            return NULL;
        }
        set_page_ref(page, 1);
        uintptr_t pa = page2pa(page);
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc020207c:	0009b703          	ld	a4,0(s3)
ffffffffc0202080:	40a48533          	sub	a0,s1,a0
ffffffffc0202084:	8519                	srai	a0,a0,0x6
ffffffffc0202086:	9552                	add	a0,a0,s4
ffffffffc0202088:	00c51793          	slli	a5,a0,0xc
    page->ref = val;
ffffffffc020208c:	4685                	li	a3,1
ffffffffc020208e:	c094                	sw	a3,0(s1)
ffffffffc0202090:	83b1                	srli	a5,a5,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0202092:	0532                	slli	a0,a0,0xc
ffffffffc0202094:	0ee7f163          	bgeu	a5,a4,ffffffffc0202176 <get_pte+0x20e>
ffffffffc0202098:	000ab783          	ld	a5,0(s5)
ffffffffc020209c:	6605                	lui	a2,0x1
ffffffffc020209e:	4581                	li	a1,0
ffffffffc02020a0:	953e                	add	a0,a0,a5
ffffffffc02020a2:	602030ef          	jal	ra,ffffffffc02056a4 <memset>
    return page - pages + nbase;
ffffffffc02020a6:	000b3683          	ld	a3,0(s6)
ffffffffc02020aa:	40d486b3          	sub	a3,s1,a3
ffffffffc02020ae:	8699                	srai	a3,a3,0x6
ffffffffc02020b0:	96d2                	add	a3,a3,s4
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc02020b2:	06aa                	slli	a3,a3,0xa
ffffffffc02020b4:	0116e693          	ori	a3,a3,17
        *pdep0 = pte_create(page2ppn(page), PTE_U | PTE_V);
ffffffffc02020b8:	e014                	sd	a3,0(s0)
    }
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc02020ba:	0009b703          	ld	a4,0(s3)
ffffffffc02020be:	068a                	slli	a3,a3,0x2
ffffffffc02020c0:	757d                	lui	a0,0xfffff
ffffffffc02020c2:	8ee9                	and	a3,a3,a0
ffffffffc02020c4:	00c6d793          	srli	a5,a3,0xc
ffffffffc02020c8:	06e7f263          	bgeu	a5,a4,ffffffffc020212c <get_pte+0x1c4>
ffffffffc02020cc:	000ab503          	ld	a0,0(s5)
ffffffffc02020d0:	00c95913          	srli	s2,s2,0xc
ffffffffc02020d4:	1ff97913          	andi	s2,s2,511
ffffffffc02020d8:	96aa                	add	a3,a3,a0
ffffffffc02020da:	00391513          	slli	a0,s2,0x3
ffffffffc02020de:	9536                	add	a0,a0,a3
}
ffffffffc02020e0:	70e2                	ld	ra,56(sp)
ffffffffc02020e2:	7442                	ld	s0,48(sp)
ffffffffc02020e4:	74a2                	ld	s1,40(sp)
ffffffffc02020e6:	7902                	ld	s2,32(sp)
ffffffffc02020e8:	69e2                	ld	s3,24(sp)
ffffffffc02020ea:	6a42                	ld	s4,16(sp)
ffffffffc02020ec:	6aa2                	ld	s5,8(sp)
ffffffffc02020ee:	6b02                	ld	s6,0(sp)
ffffffffc02020f0:	6121                	addi	sp,sp,64
ffffffffc02020f2:	8082                	ret
            return NULL;
ffffffffc02020f4:	4501                	li	a0,0
ffffffffc02020f6:	b7ed                	j	ffffffffc02020e0 <get_pte+0x178>
        intr_disable();
ffffffffc02020f8:	8bdfe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc02020fc:	000b3797          	auipc	a5,0xb3
ffffffffc0202100:	6a47b783          	ld	a5,1700(a5) # ffffffffc02b57a0 <pmm_manager>
ffffffffc0202104:	6f9c                	ld	a5,24(a5)
ffffffffc0202106:	4505                	li	a0,1
ffffffffc0202108:	9782                	jalr	a5
ffffffffc020210a:	842a                	mv	s0,a0
        intr_enable();
ffffffffc020210c:	8a3fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202110:	b56d                	j	ffffffffc0201fba <get_pte+0x52>
        intr_disable();
ffffffffc0202112:	8a3fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202116:	000b3797          	auipc	a5,0xb3
ffffffffc020211a:	68a7b783          	ld	a5,1674(a5) # ffffffffc02b57a0 <pmm_manager>
ffffffffc020211e:	6f9c                	ld	a5,24(a5)
ffffffffc0202120:	4505                	li	a0,1
ffffffffc0202122:	9782                	jalr	a5
ffffffffc0202124:	84aa                	mv	s1,a0
        intr_enable();
ffffffffc0202126:	889fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020212a:	b781                	j	ffffffffc020206a <get_pte+0x102>
    return &((pte_t *)KADDR(PDE_ADDR(*pdep0)))[PTX(la)];
ffffffffc020212c:	00004617          	auipc	a2,0x4
ffffffffc0202130:	41c60613          	addi	a2,a2,1052 # ffffffffc0206548 <default_pmm_manager+0x38>
ffffffffc0202134:	0fa00593          	li	a1,250
ffffffffc0202138:	00004517          	auipc	a0,0x4
ffffffffc020213c:	52850513          	addi	a0,a0,1320 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0202140:	b4efe0ef          	jal	ra,ffffffffc020048e <__panic>
    pde_t *pdep0 = &((pde_t *)KADDR(PDE_ADDR(*pdep1)))[PDX0(la)];
ffffffffc0202144:	00004617          	auipc	a2,0x4
ffffffffc0202148:	40460613          	addi	a2,a2,1028 # ffffffffc0206548 <default_pmm_manager+0x38>
ffffffffc020214c:	0ed00593          	li	a1,237
ffffffffc0202150:	00004517          	auipc	a0,0x4
ffffffffc0202154:	51050513          	addi	a0,a0,1296 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0202158:	b36fe0ef          	jal	ra,ffffffffc020048e <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc020215c:	86aa                	mv	a3,a0
ffffffffc020215e:	00004617          	auipc	a2,0x4
ffffffffc0202162:	3ea60613          	addi	a2,a2,1002 # ffffffffc0206548 <default_pmm_manager+0x38>
ffffffffc0202166:	0e900593          	li	a1,233
ffffffffc020216a:	00004517          	auipc	a0,0x4
ffffffffc020216e:	4f650513          	addi	a0,a0,1270 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0202172:	b1cfe0ef          	jal	ra,ffffffffc020048e <__panic>
        memset(KADDR(pa), 0, PGSIZE);
ffffffffc0202176:	86aa                	mv	a3,a0
ffffffffc0202178:	00004617          	auipc	a2,0x4
ffffffffc020217c:	3d060613          	addi	a2,a2,976 # ffffffffc0206548 <default_pmm_manager+0x38>
ffffffffc0202180:	0f700593          	li	a1,247
ffffffffc0202184:	00004517          	auipc	a0,0x4
ffffffffc0202188:	4dc50513          	addi	a0,a0,1244 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc020218c:	b02fe0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0202190 <get_page>:

// get_page - get related Page struct for linear address la using PDT pgdir
struct Page *get_page(pde_t *pgdir, uintptr_t la, pte_t **ptep_store)
{
ffffffffc0202190:	1141                	addi	sp,sp,-16
ffffffffc0202192:	e022                	sd	s0,0(sp)
ffffffffc0202194:	8432                	mv	s0,a2
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc0202196:	4601                	li	a2,0
{
ffffffffc0202198:	e406                	sd	ra,8(sp)
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc020219a:	dcfff0ef          	jal	ra,ffffffffc0201f68 <get_pte>
    if (ptep_store != NULL)
ffffffffc020219e:	c011                	beqz	s0,ffffffffc02021a2 <get_page+0x12>
    {
        *ptep_store = ptep;
ffffffffc02021a0:	e008                	sd	a0,0(s0)
    }
    if (ptep != NULL && *ptep & PTE_V)
ffffffffc02021a2:	c511                	beqz	a0,ffffffffc02021ae <get_page+0x1e>
ffffffffc02021a4:	611c                	ld	a5,0(a0)
    {
        return pte2page(*ptep);
    }
    return NULL;
ffffffffc02021a6:	4501                	li	a0,0
    if (ptep != NULL && *ptep & PTE_V)
ffffffffc02021a8:	0017f713          	andi	a4,a5,1
ffffffffc02021ac:	e709                	bnez	a4,ffffffffc02021b6 <get_page+0x26>
}
ffffffffc02021ae:	60a2                	ld	ra,8(sp)
ffffffffc02021b0:	6402                	ld	s0,0(sp)
ffffffffc02021b2:	0141                	addi	sp,sp,16
ffffffffc02021b4:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02021b6:	078a                	slli	a5,a5,0x2
ffffffffc02021b8:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02021ba:	000b3717          	auipc	a4,0xb3
ffffffffc02021be:	5d673703          	ld	a4,1494(a4) # ffffffffc02b5790 <npage>
ffffffffc02021c2:	00e7ff63          	bgeu	a5,a4,ffffffffc02021e0 <get_page+0x50>
ffffffffc02021c6:	60a2                	ld	ra,8(sp)
ffffffffc02021c8:	6402                	ld	s0,0(sp)
    return &pages[PPN(pa) - nbase];
ffffffffc02021ca:	fff80537          	lui	a0,0xfff80
ffffffffc02021ce:	97aa                	add	a5,a5,a0
ffffffffc02021d0:	079a                	slli	a5,a5,0x6
ffffffffc02021d2:	000b3517          	auipc	a0,0xb3
ffffffffc02021d6:	5c653503          	ld	a0,1478(a0) # ffffffffc02b5798 <pages>
ffffffffc02021da:	953e                	add	a0,a0,a5
ffffffffc02021dc:	0141                	addi	sp,sp,16
ffffffffc02021de:	8082                	ret
ffffffffc02021e0:	c99ff0ef          	jal	ra,ffffffffc0201e78 <pa2page.part.0>

ffffffffc02021e4 <unmap_range>:
        tlb_invalidate(pgdir, la);
    }
}

void unmap_range(pde_t *pgdir, uintptr_t start, uintptr_t end)
{
ffffffffc02021e4:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02021e6:	00c5e7b3          	or	a5,a1,a2
{
ffffffffc02021ea:	f486                	sd	ra,104(sp)
ffffffffc02021ec:	f0a2                	sd	s0,96(sp)
ffffffffc02021ee:	eca6                	sd	s1,88(sp)
ffffffffc02021f0:	e8ca                	sd	s2,80(sp)
ffffffffc02021f2:	e4ce                	sd	s3,72(sp)
ffffffffc02021f4:	e0d2                	sd	s4,64(sp)
ffffffffc02021f6:	fc56                	sd	s5,56(sp)
ffffffffc02021f8:	f85a                	sd	s6,48(sp)
ffffffffc02021fa:	f45e                	sd	s7,40(sp)
ffffffffc02021fc:	f062                	sd	s8,32(sp)
ffffffffc02021fe:	ec66                	sd	s9,24(sp)
ffffffffc0202200:	e86a                	sd	s10,16(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202202:	17d2                	slli	a5,a5,0x34
ffffffffc0202204:	e3ed                	bnez	a5,ffffffffc02022e6 <unmap_range+0x102>
    assert(USER_ACCESS(start, end));
ffffffffc0202206:	002007b7          	lui	a5,0x200
ffffffffc020220a:	842e                	mv	s0,a1
ffffffffc020220c:	0ef5ed63          	bltu	a1,a5,ffffffffc0202306 <unmap_range+0x122>
ffffffffc0202210:	8932                	mv	s2,a2
ffffffffc0202212:	0ec5fa63          	bgeu	a1,a2,ffffffffc0202306 <unmap_range+0x122>
ffffffffc0202216:	4785                	li	a5,1
ffffffffc0202218:	07fe                	slli	a5,a5,0x1f
ffffffffc020221a:	0ec7e663          	bltu	a5,a2,ffffffffc0202306 <unmap_range+0x122>
ffffffffc020221e:	89aa                	mv	s3,a0
        }
        if (*ptep != 0)
        {
            page_remove_pte(pgdir, start, ptep);
        }
        start += PGSIZE;
ffffffffc0202220:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage)
ffffffffc0202222:	000b3c97          	auipc	s9,0xb3
ffffffffc0202226:	56ec8c93          	addi	s9,s9,1390 # ffffffffc02b5790 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc020222a:	000b3c17          	auipc	s8,0xb3
ffffffffc020222e:	56ec0c13          	addi	s8,s8,1390 # ffffffffc02b5798 <pages>
ffffffffc0202232:	fff80bb7          	lui	s7,0xfff80
        pmm_manager->free_pages(base, n);
ffffffffc0202236:	000b3d17          	auipc	s10,0xb3
ffffffffc020223a:	56ad0d13          	addi	s10,s10,1386 # ffffffffc02b57a0 <pmm_manager>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc020223e:	00200b37          	lui	s6,0x200
ffffffffc0202242:	ffe00ab7          	lui	s5,0xffe00
        pte_t *ptep = get_pte(pgdir, start, 0);
ffffffffc0202246:	4601                	li	a2,0
ffffffffc0202248:	85a2                	mv	a1,s0
ffffffffc020224a:	854e                	mv	a0,s3
ffffffffc020224c:	d1dff0ef          	jal	ra,ffffffffc0201f68 <get_pte>
ffffffffc0202250:	84aa                	mv	s1,a0
        if (ptep == NULL)
ffffffffc0202252:	cd29                	beqz	a0,ffffffffc02022ac <unmap_range+0xc8>
        if (*ptep != 0)
ffffffffc0202254:	611c                	ld	a5,0(a0)
ffffffffc0202256:	e395                	bnez	a5,ffffffffc020227a <unmap_range+0x96>
        start += PGSIZE;
ffffffffc0202258:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc020225a:	ff2466e3          	bltu	s0,s2,ffffffffc0202246 <unmap_range+0x62>
}
ffffffffc020225e:	70a6                	ld	ra,104(sp)
ffffffffc0202260:	7406                	ld	s0,96(sp)
ffffffffc0202262:	64e6                	ld	s1,88(sp)
ffffffffc0202264:	6946                	ld	s2,80(sp)
ffffffffc0202266:	69a6                	ld	s3,72(sp)
ffffffffc0202268:	6a06                	ld	s4,64(sp)
ffffffffc020226a:	7ae2                	ld	s5,56(sp)
ffffffffc020226c:	7b42                	ld	s6,48(sp)
ffffffffc020226e:	7ba2                	ld	s7,40(sp)
ffffffffc0202270:	7c02                	ld	s8,32(sp)
ffffffffc0202272:	6ce2                	ld	s9,24(sp)
ffffffffc0202274:	6d42                	ld	s10,16(sp)
ffffffffc0202276:	6165                	addi	sp,sp,112
ffffffffc0202278:	8082                	ret
    if (*ptep & PTE_V)
ffffffffc020227a:	0017f713          	andi	a4,a5,1
ffffffffc020227e:	df69                	beqz	a4,ffffffffc0202258 <unmap_range+0x74>
    if (PPN(pa) >= npage)
ffffffffc0202280:	000cb703          	ld	a4,0(s9)
    return pa2page(PTE_ADDR(pte));
ffffffffc0202284:	078a                	slli	a5,a5,0x2
ffffffffc0202286:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202288:	08e7ff63          	bgeu	a5,a4,ffffffffc0202326 <unmap_range+0x142>
    return &pages[PPN(pa) - nbase];
ffffffffc020228c:	000c3503          	ld	a0,0(s8)
ffffffffc0202290:	97de                	add	a5,a5,s7
ffffffffc0202292:	079a                	slli	a5,a5,0x6
ffffffffc0202294:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc0202296:	411c                	lw	a5,0(a0)
ffffffffc0202298:	fff7871b          	addiw	a4,a5,-1
ffffffffc020229c:	c118                	sw	a4,0(a0)
        if (page_ref(page) == 0)
ffffffffc020229e:	cf11                	beqz	a4,ffffffffc02022ba <unmap_range+0xd6>
        *ptep = 0;
ffffffffc02022a0:	0004b023          	sd	zero,0(s1)

// invalidate a TLB entry, but only if the page tables being
// edited are the ones currently in use by the processor.
void tlb_invalidate(pde_t *pgdir, uintptr_t la)
{
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02022a4:	12040073          	sfence.vma	s0
        start += PGSIZE;
ffffffffc02022a8:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc02022aa:	bf45                	j	ffffffffc020225a <unmap_range+0x76>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc02022ac:	945a                	add	s0,s0,s6
ffffffffc02022ae:	01547433          	and	s0,s0,s5
    } while (start != 0 && start < end);
ffffffffc02022b2:	d455                	beqz	s0,ffffffffc020225e <unmap_range+0x7a>
ffffffffc02022b4:	f92469e3          	bltu	s0,s2,ffffffffc0202246 <unmap_range+0x62>
ffffffffc02022b8:	b75d                	j	ffffffffc020225e <unmap_range+0x7a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02022ba:	100027f3          	csrr	a5,sstatus
ffffffffc02022be:	8b89                	andi	a5,a5,2
ffffffffc02022c0:	e799                	bnez	a5,ffffffffc02022ce <unmap_range+0xea>
        pmm_manager->free_pages(base, n);
ffffffffc02022c2:	000d3783          	ld	a5,0(s10)
ffffffffc02022c6:	4585                	li	a1,1
ffffffffc02022c8:	739c                	ld	a5,32(a5)
ffffffffc02022ca:	9782                	jalr	a5
    if (flag)
ffffffffc02022cc:	bfd1                	j	ffffffffc02022a0 <unmap_range+0xbc>
ffffffffc02022ce:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc02022d0:	ee4fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc02022d4:	000d3783          	ld	a5,0(s10)
ffffffffc02022d8:	6522                	ld	a0,8(sp)
ffffffffc02022da:	4585                	li	a1,1
ffffffffc02022dc:	739c                	ld	a5,32(a5)
ffffffffc02022de:	9782                	jalr	a5
        intr_enable();
ffffffffc02022e0:	ecefe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc02022e4:	bf75                	j	ffffffffc02022a0 <unmap_range+0xbc>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02022e6:	00004697          	auipc	a3,0x4
ffffffffc02022ea:	38a68693          	addi	a3,a3,906 # ffffffffc0206670 <default_pmm_manager+0x160>
ffffffffc02022ee:	00004617          	auipc	a2,0x4
ffffffffc02022f2:	e7260613          	addi	a2,a2,-398 # ffffffffc0206160 <commands+0x828>
ffffffffc02022f6:	12000593          	li	a1,288
ffffffffc02022fa:	00004517          	auipc	a0,0x4
ffffffffc02022fe:	36650513          	addi	a0,a0,870 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0202302:	98cfe0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc0202306:	00004697          	auipc	a3,0x4
ffffffffc020230a:	39a68693          	addi	a3,a3,922 # ffffffffc02066a0 <default_pmm_manager+0x190>
ffffffffc020230e:	00004617          	auipc	a2,0x4
ffffffffc0202312:	e5260613          	addi	a2,a2,-430 # ffffffffc0206160 <commands+0x828>
ffffffffc0202316:	12100593          	li	a1,289
ffffffffc020231a:	00004517          	auipc	a0,0x4
ffffffffc020231e:	34650513          	addi	a0,a0,838 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0202322:	96cfe0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc0202326:	b53ff0ef          	jal	ra,ffffffffc0201e78 <pa2page.part.0>

ffffffffc020232a <exit_range>:
{
ffffffffc020232a:	7119                	addi	sp,sp,-128
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020232c:	00c5e7b3          	or	a5,a1,a2
{
ffffffffc0202330:	fc86                	sd	ra,120(sp)
ffffffffc0202332:	f8a2                	sd	s0,112(sp)
ffffffffc0202334:	f4a6                	sd	s1,104(sp)
ffffffffc0202336:	f0ca                	sd	s2,96(sp)
ffffffffc0202338:	ecce                	sd	s3,88(sp)
ffffffffc020233a:	e8d2                	sd	s4,80(sp)
ffffffffc020233c:	e4d6                	sd	s5,72(sp)
ffffffffc020233e:	e0da                	sd	s6,64(sp)
ffffffffc0202340:	fc5e                	sd	s7,56(sp)
ffffffffc0202342:	f862                	sd	s8,48(sp)
ffffffffc0202344:	f466                	sd	s9,40(sp)
ffffffffc0202346:	f06a                	sd	s10,32(sp)
ffffffffc0202348:	ec6e                	sd	s11,24(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc020234a:	17d2                	slli	a5,a5,0x34
ffffffffc020234c:	20079a63          	bnez	a5,ffffffffc0202560 <exit_range+0x236>
    assert(USER_ACCESS(start, end));
ffffffffc0202350:	002007b7          	lui	a5,0x200
ffffffffc0202354:	24f5e463          	bltu	a1,a5,ffffffffc020259c <exit_range+0x272>
ffffffffc0202358:	8ab2                	mv	s5,a2
ffffffffc020235a:	24c5f163          	bgeu	a1,a2,ffffffffc020259c <exit_range+0x272>
ffffffffc020235e:	4785                	li	a5,1
ffffffffc0202360:	07fe                	slli	a5,a5,0x1f
ffffffffc0202362:	22c7ed63          	bltu	a5,a2,ffffffffc020259c <exit_range+0x272>
    d1start = ROUNDDOWN(start, PDSIZE);
ffffffffc0202366:	c00009b7          	lui	s3,0xc0000
ffffffffc020236a:	0135f9b3          	and	s3,a1,s3
    d0start = ROUNDDOWN(start, PTSIZE);
ffffffffc020236e:	ffe00937          	lui	s2,0xffe00
ffffffffc0202372:	400007b7          	lui	a5,0x40000
    return KADDR(page2pa(page));
ffffffffc0202376:	5cfd                	li	s9,-1
ffffffffc0202378:	8c2a                	mv	s8,a0
ffffffffc020237a:	0125f933          	and	s2,a1,s2
ffffffffc020237e:	99be                	add	s3,s3,a5
    if (PPN(pa) >= npage)
ffffffffc0202380:	000b3d17          	auipc	s10,0xb3
ffffffffc0202384:	410d0d13          	addi	s10,s10,1040 # ffffffffc02b5790 <npage>
    return KADDR(page2pa(page));
ffffffffc0202388:	00ccdc93          	srli	s9,s9,0xc
    return &pages[PPN(pa) - nbase];
ffffffffc020238c:	000b3717          	auipc	a4,0xb3
ffffffffc0202390:	40c70713          	addi	a4,a4,1036 # ffffffffc02b5798 <pages>
        pmm_manager->free_pages(base, n);
ffffffffc0202394:	000b3d97          	auipc	s11,0xb3
ffffffffc0202398:	40cd8d93          	addi	s11,s11,1036 # ffffffffc02b57a0 <pmm_manager>
        pde1 = pgdir[PDX1(d1start)];
ffffffffc020239c:	c0000437          	lui	s0,0xc0000
ffffffffc02023a0:	944e                	add	s0,s0,s3
ffffffffc02023a2:	8079                	srli	s0,s0,0x1e
ffffffffc02023a4:	1ff47413          	andi	s0,s0,511
ffffffffc02023a8:	040e                	slli	s0,s0,0x3
ffffffffc02023aa:	9462                	add	s0,s0,s8
ffffffffc02023ac:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_obj___user_exit_out_size+0xffffffffbfff4ed8>
        if (pde1 & PTE_V)
ffffffffc02023b0:	001a7793          	andi	a5,s4,1
ffffffffc02023b4:	eb99                	bnez	a5,ffffffffc02023ca <exit_range+0xa0>
    } while (d1start != 0 && d1start < end);
ffffffffc02023b6:	12098463          	beqz	s3,ffffffffc02024de <exit_range+0x1b4>
ffffffffc02023ba:	400007b7          	lui	a5,0x40000
ffffffffc02023be:	97ce                	add	a5,a5,s3
ffffffffc02023c0:	894e                	mv	s2,s3
ffffffffc02023c2:	1159fe63          	bgeu	s3,s5,ffffffffc02024de <exit_range+0x1b4>
ffffffffc02023c6:	89be                	mv	s3,a5
ffffffffc02023c8:	bfd1                	j	ffffffffc020239c <exit_range+0x72>
    if (PPN(pa) >= npage)
ffffffffc02023ca:	000d3783          	ld	a5,0(s10)
    return pa2page(PDE_ADDR(pde));
ffffffffc02023ce:	0a0a                	slli	s4,s4,0x2
ffffffffc02023d0:	00ca5a13          	srli	s4,s4,0xc
    if (PPN(pa) >= npage)
ffffffffc02023d4:	1cfa7263          	bgeu	s4,a5,ffffffffc0202598 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc02023d8:	fff80637          	lui	a2,0xfff80
ffffffffc02023dc:	9652                	add	a2,a2,s4
    return page - pages + nbase;
ffffffffc02023de:	000806b7          	lui	a3,0x80
ffffffffc02023e2:	96b2                	add	a3,a3,a2
    return KADDR(page2pa(page));
ffffffffc02023e4:	0196f5b3          	and	a1,a3,s9
    return &pages[PPN(pa) - nbase];
ffffffffc02023e8:	061a                	slli	a2,a2,0x6
    return page2ppn(page) << PGSHIFT;
ffffffffc02023ea:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02023ec:	18f5fa63          	bgeu	a1,a5,ffffffffc0202580 <exit_range+0x256>
ffffffffc02023f0:	000b3817          	auipc	a6,0xb3
ffffffffc02023f4:	3b880813          	addi	a6,a6,952 # ffffffffc02b57a8 <va_pa_offset>
ffffffffc02023f8:	00083b03          	ld	s6,0(a6)
            free_pd0 = 1;
ffffffffc02023fc:	4b85                	li	s7,1
    return &pages[PPN(pa) - nbase];
ffffffffc02023fe:	fff80e37          	lui	t3,0xfff80
    return KADDR(page2pa(page));
ffffffffc0202402:	9b36                	add	s6,s6,a3
    return page - pages + nbase;
ffffffffc0202404:	00080337          	lui	t1,0x80
ffffffffc0202408:	6885                	lui	a7,0x1
ffffffffc020240a:	a819                	j	ffffffffc0202420 <exit_range+0xf6>
                    free_pd0 = 0;
ffffffffc020240c:	4b81                	li	s7,0
                d0start += PTSIZE;
ffffffffc020240e:	002007b7          	lui	a5,0x200
ffffffffc0202412:	993e                	add	s2,s2,a5
            } while (d0start != 0 && d0start < d1start + PDSIZE && d0start < end);
ffffffffc0202414:	08090c63          	beqz	s2,ffffffffc02024ac <exit_range+0x182>
ffffffffc0202418:	09397a63          	bgeu	s2,s3,ffffffffc02024ac <exit_range+0x182>
ffffffffc020241c:	0f597063          	bgeu	s2,s5,ffffffffc02024fc <exit_range+0x1d2>
                pde0 = pd0[PDX0(d0start)];
ffffffffc0202420:	01595493          	srli	s1,s2,0x15
ffffffffc0202424:	1ff4f493          	andi	s1,s1,511
ffffffffc0202428:	048e                	slli	s1,s1,0x3
ffffffffc020242a:	94da                	add	s1,s1,s6
ffffffffc020242c:	609c                	ld	a5,0(s1)
                if (pde0 & PTE_V)
ffffffffc020242e:	0017f693          	andi	a3,a5,1
ffffffffc0202432:	dee9                	beqz	a3,ffffffffc020240c <exit_range+0xe2>
    if (PPN(pa) >= npage)
ffffffffc0202434:	000d3583          	ld	a1,0(s10)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202438:	078a                	slli	a5,a5,0x2
ffffffffc020243a:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc020243c:	14b7fe63          	bgeu	a5,a1,ffffffffc0202598 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc0202440:	97f2                	add	a5,a5,t3
    return page - pages + nbase;
ffffffffc0202442:	006786b3          	add	a3,a5,t1
    return KADDR(page2pa(page));
ffffffffc0202446:	0196feb3          	and	t4,a3,s9
    return &pages[PPN(pa) - nbase];
ffffffffc020244a:	00679513          	slli	a0,a5,0x6
    return page2ppn(page) << PGSHIFT;
ffffffffc020244e:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202450:	12bef863          	bgeu	t4,a1,ffffffffc0202580 <exit_range+0x256>
ffffffffc0202454:	00083783          	ld	a5,0(a6)
ffffffffc0202458:	96be                	add	a3,a3,a5
                    for (int i = 0; i < NPTEENTRY; i++)
ffffffffc020245a:	011685b3          	add	a1,a3,a7
                        if (pt[i] & PTE_V)
ffffffffc020245e:	629c                	ld	a5,0(a3)
ffffffffc0202460:	8b85                	andi	a5,a5,1
ffffffffc0202462:	f7d5                	bnez	a5,ffffffffc020240e <exit_range+0xe4>
                    for (int i = 0; i < NPTEENTRY; i++)
ffffffffc0202464:	06a1                	addi	a3,a3,8
ffffffffc0202466:	fed59ce3          	bne	a1,a3,ffffffffc020245e <exit_range+0x134>
    return &pages[PPN(pa) - nbase];
ffffffffc020246a:	631c                	ld	a5,0(a4)
ffffffffc020246c:	953e                	add	a0,a0,a5
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020246e:	100027f3          	csrr	a5,sstatus
ffffffffc0202472:	8b89                	andi	a5,a5,2
ffffffffc0202474:	e7d9                	bnez	a5,ffffffffc0202502 <exit_range+0x1d8>
        pmm_manager->free_pages(base, n);
ffffffffc0202476:	000db783          	ld	a5,0(s11)
ffffffffc020247a:	4585                	li	a1,1
ffffffffc020247c:	e032                	sd	a2,0(sp)
ffffffffc020247e:	739c                	ld	a5,32(a5)
ffffffffc0202480:	9782                	jalr	a5
    if (flag)
ffffffffc0202482:	6602                	ld	a2,0(sp)
ffffffffc0202484:	000b3817          	auipc	a6,0xb3
ffffffffc0202488:	32480813          	addi	a6,a6,804 # ffffffffc02b57a8 <va_pa_offset>
ffffffffc020248c:	fff80e37          	lui	t3,0xfff80
ffffffffc0202490:	00080337          	lui	t1,0x80
ffffffffc0202494:	6885                	lui	a7,0x1
ffffffffc0202496:	000b3717          	auipc	a4,0xb3
ffffffffc020249a:	30270713          	addi	a4,a4,770 # ffffffffc02b5798 <pages>
                        pd0[PDX0(d0start)] = 0;
ffffffffc020249e:	0004b023          	sd	zero,0(s1)
                d0start += PTSIZE;
ffffffffc02024a2:	002007b7          	lui	a5,0x200
ffffffffc02024a6:	993e                	add	s2,s2,a5
            } while (d0start != 0 && d0start < d1start + PDSIZE && d0start < end);
ffffffffc02024a8:	f60918e3          	bnez	s2,ffffffffc0202418 <exit_range+0xee>
            if (free_pd0)
ffffffffc02024ac:	f00b85e3          	beqz	s7,ffffffffc02023b6 <exit_range+0x8c>
    if (PPN(pa) >= npage)
ffffffffc02024b0:	000d3783          	ld	a5,0(s10)
ffffffffc02024b4:	0efa7263          	bgeu	s4,a5,ffffffffc0202598 <exit_range+0x26e>
    return &pages[PPN(pa) - nbase];
ffffffffc02024b8:	6308                	ld	a0,0(a4)
ffffffffc02024ba:	9532                	add	a0,a0,a2
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc02024bc:	100027f3          	csrr	a5,sstatus
ffffffffc02024c0:	8b89                	andi	a5,a5,2
ffffffffc02024c2:	efad                	bnez	a5,ffffffffc020253c <exit_range+0x212>
        pmm_manager->free_pages(base, n);
ffffffffc02024c4:	000db783          	ld	a5,0(s11)
ffffffffc02024c8:	4585                	li	a1,1
ffffffffc02024ca:	739c                	ld	a5,32(a5)
ffffffffc02024cc:	9782                	jalr	a5
ffffffffc02024ce:	000b3717          	auipc	a4,0xb3
ffffffffc02024d2:	2ca70713          	addi	a4,a4,714 # ffffffffc02b5798 <pages>
                pgdir[PDX1(d1start)] = 0;
ffffffffc02024d6:	00043023          	sd	zero,0(s0)
    } while (d1start != 0 && d1start < end);
ffffffffc02024da:	ee0990e3          	bnez	s3,ffffffffc02023ba <exit_range+0x90>
}
ffffffffc02024de:	70e6                	ld	ra,120(sp)
ffffffffc02024e0:	7446                	ld	s0,112(sp)
ffffffffc02024e2:	74a6                	ld	s1,104(sp)
ffffffffc02024e4:	7906                	ld	s2,96(sp)
ffffffffc02024e6:	69e6                	ld	s3,88(sp)
ffffffffc02024e8:	6a46                	ld	s4,80(sp)
ffffffffc02024ea:	6aa6                	ld	s5,72(sp)
ffffffffc02024ec:	6b06                	ld	s6,64(sp)
ffffffffc02024ee:	7be2                	ld	s7,56(sp)
ffffffffc02024f0:	7c42                	ld	s8,48(sp)
ffffffffc02024f2:	7ca2                	ld	s9,40(sp)
ffffffffc02024f4:	7d02                	ld	s10,32(sp)
ffffffffc02024f6:	6de2                	ld	s11,24(sp)
ffffffffc02024f8:	6109                	addi	sp,sp,128
ffffffffc02024fa:	8082                	ret
            if (free_pd0)
ffffffffc02024fc:	ea0b8fe3          	beqz	s7,ffffffffc02023ba <exit_range+0x90>
ffffffffc0202500:	bf45                	j	ffffffffc02024b0 <exit_range+0x186>
ffffffffc0202502:	e032                	sd	a2,0(sp)
        intr_disable();
ffffffffc0202504:	e42a                	sd	a0,8(sp)
ffffffffc0202506:	caefe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc020250a:	000db783          	ld	a5,0(s11)
ffffffffc020250e:	6522                	ld	a0,8(sp)
ffffffffc0202510:	4585                	li	a1,1
ffffffffc0202512:	739c                	ld	a5,32(a5)
ffffffffc0202514:	9782                	jalr	a5
        intr_enable();
ffffffffc0202516:	c98fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020251a:	6602                	ld	a2,0(sp)
ffffffffc020251c:	000b3717          	auipc	a4,0xb3
ffffffffc0202520:	27c70713          	addi	a4,a4,636 # ffffffffc02b5798 <pages>
ffffffffc0202524:	6885                	lui	a7,0x1
ffffffffc0202526:	00080337          	lui	t1,0x80
ffffffffc020252a:	fff80e37          	lui	t3,0xfff80
ffffffffc020252e:	000b3817          	auipc	a6,0xb3
ffffffffc0202532:	27a80813          	addi	a6,a6,634 # ffffffffc02b57a8 <va_pa_offset>
                        pd0[PDX0(d0start)] = 0;
ffffffffc0202536:	0004b023          	sd	zero,0(s1)
ffffffffc020253a:	b7a5                	j	ffffffffc02024a2 <exit_range+0x178>
ffffffffc020253c:	e02a                	sd	a0,0(sp)
        intr_disable();
ffffffffc020253e:	c76fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202542:	000db783          	ld	a5,0(s11)
ffffffffc0202546:	6502                	ld	a0,0(sp)
ffffffffc0202548:	4585                	li	a1,1
ffffffffc020254a:	739c                	ld	a5,32(a5)
ffffffffc020254c:	9782                	jalr	a5
        intr_enable();
ffffffffc020254e:	c60fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202552:	000b3717          	auipc	a4,0xb3
ffffffffc0202556:	24670713          	addi	a4,a4,582 # ffffffffc02b5798 <pages>
                pgdir[PDX1(d1start)] = 0;
ffffffffc020255a:	00043023          	sd	zero,0(s0)
ffffffffc020255e:	bfb5                	j	ffffffffc02024da <exit_range+0x1b0>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0202560:	00004697          	auipc	a3,0x4
ffffffffc0202564:	11068693          	addi	a3,a3,272 # ffffffffc0206670 <default_pmm_manager+0x160>
ffffffffc0202568:	00004617          	auipc	a2,0x4
ffffffffc020256c:	bf860613          	addi	a2,a2,-1032 # ffffffffc0206160 <commands+0x828>
ffffffffc0202570:	13500593          	li	a1,309
ffffffffc0202574:	00004517          	auipc	a0,0x4
ffffffffc0202578:	0ec50513          	addi	a0,a0,236 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc020257c:	f13fd0ef          	jal	ra,ffffffffc020048e <__panic>
    return KADDR(page2pa(page));
ffffffffc0202580:	00004617          	auipc	a2,0x4
ffffffffc0202584:	fc860613          	addi	a2,a2,-56 # ffffffffc0206548 <default_pmm_manager+0x38>
ffffffffc0202588:	07100593          	li	a1,113
ffffffffc020258c:	00004517          	auipc	a0,0x4
ffffffffc0202590:	fe450513          	addi	a0,a0,-28 # ffffffffc0206570 <default_pmm_manager+0x60>
ffffffffc0202594:	efbfd0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc0202598:	8e1ff0ef          	jal	ra,ffffffffc0201e78 <pa2page.part.0>
    assert(USER_ACCESS(start, end));
ffffffffc020259c:	00004697          	auipc	a3,0x4
ffffffffc02025a0:	10468693          	addi	a3,a3,260 # ffffffffc02066a0 <default_pmm_manager+0x190>
ffffffffc02025a4:	00004617          	auipc	a2,0x4
ffffffffc02025a8:	bbc60613          	addi	a2,a2,-1092 # ffffffffc0206160 <commands+0x828>
ffffffffc02025ac:	13600593          	li	a1,310
ffffffffc02025b0:	00004517          	auipc	a0,0x4
ffffffffc02025b4:	0b050513          	addi	a0,a0,176 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc02025b8:	ed7fd0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02025bc <page_remove>:
{
ffffffffc02025bc:	7179                	addi	sp,sp,-48
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc02025be:	4601                	li	a2,0
{
ffffffffc02025c0:	ec26                	sd	s1,24(sp)
ffffffffc02025c2:	f406                	sd	ra,40(sp)
ffffffffc02025c4:	f022                	sd	s0,32(sp)
ffffffffc02025c6:	84ae                	mv	s1,a1
    pte_t *ptep = get_pte(pgdir, la, 0);
ffffffffc02025c8:	9a1ff0ef          	jal	ra,ffffffffc0201f68 <get_pte>
    if (ptep != NULL)
ffffffffc02025cc:	c511                	beqz	a0,ffffffffc02025d8 <page_remove+0x1c>
    if (*ptep & PTE_V)
ffffffffc02025ce:	611c                	ld	a5,0(a0)
ffffffffc02025d0:	842a                	mv	s0,a0
ffffffffc02025d2:	0017f713          	andi	a4,a5,1
ffffffffc02025d6:	e711                	bnez	a4,ffffffffc02025e2 <page_remove+0x26>
}
ffffffffc02025d8:	70a2                	ld	ra,40(sp)
ffffffffc02025da:	7402                	ld	s0,32(sp)
ffffffffc02025dc:	64e2                	ld	s1,24(sp)
ffffffffc02025de:	6145                	addi	sp,sp,48
ffffffffc02025e0:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02025e2:	078a                	slli	a5,a5,0x2
ffffffffc02025e4:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02025e6:	000b3717          	auipc	a4,0xb3
ffffffffc02025ea:	1aa73703          	ld	a4,426(a4) # ffffffffc02b5790 <npage>
ffffffffc02025ee:	06e7f363          	bgeu	a5,a4,ffffffffc0202654 <page_remove+0x98>
    return &pages[PPN(pa) - nbase];
ffffffffc02025f2:	fff80537          	lui	a0,0xfff80
ffffffffc02025f6:	97aa                	add	a5,a5,a0
ffffffffc02025f8:	079a                	slli	a5,a5,0x6
ffffffffc02025fa:	000b3517          	auipc	a0,0xb3
ffffffffc02025fe:	19e53503          	ld	a0,414(a0) # ffffffffc02b5798 <pages>
ffffffffc0202602:	953e                	add	a0,a0,a5
    page->ref -= 1;
ffffffffc0202604:	411c                	lw	a5,0(a0)
ffffffffc0202606:	fff7871b          	addiw	a4,a5,-1
ffffffffc020260a:	c118                	sw	a4,0(a0)
        if (page_ref(page) == 0)
ffffffffc020260c:	cb11                	beqz	a4,ffffffffc0202620 <page_remove+0x64>
        *ptep = 0;
ffffffffc020260e:	00043023          	sd	zero,0(s0)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202612:	12048073          	sfence.vma	s1
}
ffffffffc0202616:	70a2                	ld	ra,40(sp)
ffffffffc0202618:	7402                	ld	s0,32(sp)
ffffffffc020261a:	64e2                	ld	s1,24(sp)
ffffffffc020261c:	6145                	addi	sp,sp,48
ffffffffc020261e:	8082                	ret
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202620:	100027f3          	csrr	a5,sstatus
ffffffffc0202624:	8b89                	andi	a5,a5,2
ffffffffc0202626:	eb89                	bnez	a5,ffffffffc0202638 <page_remove+0x7c>
        pmm_manager->free_pages(base, n);
ffffffffc0202628:	000b3797          	auipc	a5,0xb3
ffffffffc020262c:	1787b783          	ld	a5,376(a5) # ffffffffc02b57a0 <pmm_manager>
ffffffffc0202630:	739c                	ld	a5,32(a5)
ffffffffc0202632:	4585                	li	a1,1
ffffffffc0202634:	9782                	jalr	a5
    if (flag)
ffffffffc0202636:	bfe1                	j	ffffffffc020260e <page_remove+0x52>
        intr_disable();
ffffffffc0202638:	e42a                	sd	a0,8(sp)
ffffffffc020263a:	b7afe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc020263e:	000b3797          	auipc	a5,0xb3
ffffffffc0202642:	1627b783          	ld	a5,354(a5) # ffffffffc02b57a0 <pmm_manager>
ffffffffc0202646:	739c                	ld	a5,32(a5)
ffffffffc0202648:	6522                	ld	a0,8(sp)
ffffffffc020264a:	4585                	li	a1,1
ffffffffc020264c:	9782                	jalr	a5
        intr_enable();
ffffffffc020264e:	b60fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202652:	bf75                	j	ffffffffc020260e <page_remove+0x52>
ffffffffc0202654:	825ff0ef          	jal	ra,ffffffffc0201e78 <pa2page.part.0>

ffffffffc0202658 <page_insert>:
{
ffffffffc0202658:	7139                	addi	sp,sp,-64
ffffffffc020265a:	e852                	sd	s4,16(sp)
ffffffffc020265c:	8a32                	mv	s4,a2
ffffffffc020265e:	f822                	sd	s0,48(sp)
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202660:	4605                	li	a2,1
{
ffffffffc0202662:	842e                	mv	s0,a1
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202664:	85d2                	mv	a1,s4
{
ffffffffc0202666:	f426                	sd	s1,40(sp)
ffffffffc0202668:	fc06                	sd	ra,56(sp)
ffffffffc020266a:	f04a                	sd	s2,32(sp)
ffffffffc020266c:	ec4e                	sd	s3,24(sp)
ffffffffc020266e:	e456                	sd	s5,8(sp)
ffffffffc0202670:	84b6                	mv	s1,a3
    pte_t *ptep = get_pte(pgdir, la, 1);
ffffffffc0202672:	8f7ff0ef          	jal	ra,ffffffffc0201f68 <get_pte>
    if (ptep == NULL)
ffffffffc0202676:	c961                	beqz	a0,ffffffffc0202746 <page_insert+0xee>
    page->ref += 1;
ffffffffc0202678:	4014                	lw	a3,0(s0)
    if (*ptep & PTE_V)
ffffffffc020267a:	611c                	ld	a5,0(a0)
ffffffffc020267c:	89aa                	mv	s3,a0
ffffffffc020267e:	0016871b          	addiw	a4,a3,1
ffffffffc0202682:	c018                	sw	a4,0(s0)
ffffffffc0202684:	0017f713          	andi	a4,a5,1
ffffffffc0202688:	ef05                	bnez	a4,ffffffffc02026c0 <page_insert+0x68>
    return page - pages + nbase;
ffffffffc020268a:	000b3717          	auipc	a4,0xb3
ffffffffc020268e:	10e73703          	ld	a4,270(a4) # ffffffffc02b5798 <pages>
ffffffffc0202692:	8c19                	sub	s0,s0,a4
ffffffffc0202694:	000807b7          	lui	a5,0x80
ffffffffc0202698:	8419                	srai	s0,s0,0x6
ffffffffc020269a:	943e                	add	s0,s0,a5
    return (ppn << PTE_PPN_SHIFT) | PTE_V | type;
ffffffffc020269c:	042a                	slli	s0,s0,0xa
ffffffffc020269e:	8cc1                	or	s1,s1,s0
ffffffffc02026a0:	0014e493          	ori	s1,s1,1
    *ptep = pte_create(page2ppn(page), PTE_V | perm);
ffffffffc02026a4:	0099b023          	sd	s1,0(s3) # ffffffffc0000000 <_binary_obj___user_exit_out_size+0xffffffffbfff4ed8>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02026a8:	120a0073          	sfence.vma	s4
    return 0;
ffffffffc02026ac:	4501                	li	a0,0
}
ffffffffc02026ae:	70e2                	ld	ra,56(sp)
ffffffffc02026b0:	7442                	ld	s0,48(sp)
ffffffffc02026b2:	74a2                	ld	s1,40(sp)
ffffffffc02026b4:	7902                	ld	s2,32(sp)
ffffffffc02026b6:	69e2                	ld	s3,24(sp)
ffffffffc02026b8:	6a42                	ld	s4,16(sp)
ffffffffc02026ba:	6aa2                	ld	s5,8(sp)
ffffffffc02026bc:	6121                	addi	sp,sp,64
ffffffffc02026be:	8082                	ret
    return pa2page(PTE_ADDR(pte));
ffffffffc02026c0:	078a                	slli	a5,a5,0x2
ffffffffc02026c2:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc02026c4:	000b3717          	auipc	a4,0xb3
ffffffffc02026c8:	0cc73703          	ld	a4,204(a4) # ffffffffc02b5790 <npage>
ffffffffc02026cc:	06e7ff63          	bgeu	a5,a4,ffffffffc020274a <page_insert+0xf2>
    return &pages[PPN(pa) - nbase];
ffffffffc02026d0:	000b3a97          	auipc	s5,0xb3
ffffffffc02026d4:	0c8a8a93          	addi	s5,s5,200 # ffffffffc02b5798 <pages>
ffffffffc02026d8:	000ab703          	ld	a4,0(s5)
ffffffffc02026dc:	fff80937          	lui	s2,0xfff80
ffffffffc02026e0:	993e                	add	s2,s2,a5
ffffffffc02026e2:	091a                	slli	s2,s2,0x6
ffffffffc02026e4:	993a                	add	s2,s2,a4
        if (p == page)
ffffffffc02026e6:	01240c63          	beq	s0,s2,ffffffffc02026fe <page_insert+0xa6>
    page->ref -= 1;
ffffffffc02026ea:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fcca834>
ffffffffc02026ee:	fff7869b          	addiw	a3,a5,-1
ffffffffc02026f2:	00d92023          	sw	a3,0(s2)
        if (page_ref(page) == 0)
ffffffffc02026f6:	c691                	beqz	a3,ffffffffc0202702 <page_insert+0xaa>
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc02026f8:	120a0073          	sfence.vma	s4
}
ffffffffc02026fc:	bf59                	j	ffffffffc0202692 <page_insert+0x3a>
ffffffffc02026fe:	c014                	sw	a3,0(s0)
    return page->ref;
ffffffffc0202700:	bf49                	j	ffffffffc0202692 <page_insert+0x3a>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0202702:	100027f3          	csrr	a5,sstatus
ffffffffc0202706:	8b89                	andi	a5,a5,2
ffffffffc0202708:	ef91                	bnez	a5,ffffffffc0202724 <page_insert+0xcc>
        pmm_manager->free_pages(base, n);
ffffffffc020270a:	000b3797          	auipc	a5,0xb3
ffffffffc020270e:	0967b783          	ld	a5,150(a5) # ffffffffc02b57a0 <pmm_manager>
ffffffffc0202712:	739c                	ld	a5,32(a5)
ffffffffc0202714:	4585                	li	a1,1
ffffffffc0202716:	854a                	mv	a0,s2
ffffffffc0202718:	9782                	jalr	a5
    return page - pages + nbase;
ffffffffc020271a:	000ab703          	ld	a4,0(s5)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc020271e:	120a0073          	sfence.vma	s4
ffffffffc0202722:	bf85                	j	ffffffffc0202692 <page_insert+0x3a>
        intr_disable();
ffffffffc0202724:	a90fe0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202728:	000b3797          	auipc	a5,0xb3
ffffffffc020272c:	0787b783          	ld	a5,120(a5) # ffffffffc02b57a0 <pmm_manager>
ffffffffc0202730:	739c                	ld	a5,32(a5)
ffffffffc0202732:	4585                	li	a1,1
ffffffffc0202734:	854a                	mv	a0,s2
ffffffffc0202736:	9782                	jalr	a5
        intr_enable();
ffffffffc0202738:	a76fe0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020273c:	000ab703          	ld	a4,0(s5)
    asm volatile("sfence.vma %0" : : "r"(la));
ffffffffc0202740:	120a0073          	sfence.vma	s4
ffffffffc0202744:	b7b9                	j	ffffffffc0202692 <page_insert+0x3a>
        return -E_NO_MEM;
ffffffffc0202746:	5571                	li	a0,-4
ffffffffc0202748:	b79d                	j	ffffffffc02026ae <page_insert+0x56>
ffffffffc020274a:	f2eff0ef          	jal	ra,ffffffffc0201e78 <pa2page.part.0>

ffffffffc020274e <pmm_init>:
    pmm_manager = &default_pmm_manager;
ffffffffc020274e:	00004797          	auipc	a5,0x4
ffffffffc0202752:	dc278793          	addi	a5,a5,-574 # ffffffffc0206510 <default_pmm_manager>
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202756:	638c                	ld	a1,0(a5)
{
ffffffffc0202758:	7159                	addi	sp,sp,-112
ffffffffc020275a:	f85a                	sd	s6,48(sp)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc020275c:	00004517          	auipc	a0,0x4
ffffffffc0202760:	f5c50513          	addi	a0,a0,-164 # ffffffffc02066b8 <default_pmm_manager+0x1a8>
    pmm_manager = &default_pmm_manager;
ffffffffc0202764:	000b3b17          	auipc	s6,0xb3
ffffffffc0202768:	03cb0b13          	addi	s6,s6,60 # ffffffffc02b57a0 <pmm_manager>
{
ffffffffc020276c:	f486                	sd	ra,104(sp)
ffffffffc020276e:	e8ca                	sd	s2,80(sp)
ffffffffc0202770:	e4ce                	sd	s3,72(sp)
ffffffffc0202772:	f0a2                	sd	s0,96(sp)
ffffffffc0202774:	eca6                	sd	s1,88(sp)
ffffffffc0202776:	e0d2                	sd	s4,64(sp)
ffffffffc0202778:	fc56                	sd	s5,56(sp)
ffffffffc020277a:	f45e                	sd	s7,40(sp)
ffffffffc020277c:	f062                	sd	s8,32(sp)
ffffffffc020277e:	ec66                	sd	s9,24(sp)
    pmm_manager = &default_pmm_manager;
ffffffffc0202780:	00fb3023          	sd	a5,0(s6)
    cprintf("memory management: %s\n", pmm_manager->name);
ffffffffc0202784:	a11fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    pmm_manager->init();
ffffffffc0202788:	000b3783          	ld	a5,0(s6)
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc020278c:	000b3997          	auipc	s3,0xb3
ffffffffc0202790:	01c98993          	addi	s3,s3,28 # ffffffffc02b57a8 <va_pa_offset>
    pmm_manager->init();
ffffffffc0202794:	679c                	ld	a5,8(a5)
ffffffffc0202796:	9782                	jalr	a5
    va_pa_offset = PHYSICAL_MEMORY_OFFSET;
ffffffffc0202798:	57f5                	li	a5,-3
ffffffffc020279a:	07fa                	slli	a5,a5,0x1e
ffffffffc020279c:	00f9b023          	sd	a5,0(s3)
    uint64_t mem_begin = get_memory_base();
ffffffffc02027a0:	9fafe0ef          	jal	ra,ffffffffc020099a <get_memory_base>
ffffffffc02027a4:	892a                	mv	s2,a0
    uint64_t mem_size = get_memory_size();
ffffffffc02027a6:	9fefe0ef          	jal	ra,ffffffffc02009a4 <get_memory_size>
    if (mem_size == 0)
ffffffffc02027aa:	200505e3          	beqz	a0,ffffffffc02031b4 <pmm_init+0xa66>
    uint64_t mem_end = mem_begin + mem_size;
ffffffffc02027ae:	84aa                	mv	s1,a0
    cprintf("physcial memory map:\n");
ffffffffc02027b0:	00004517          	auipc	a0,0x4
ffffffffc02027b4:	f4050513          	addi	a0,a0,-192 # ffffffffc02066f0 <default_pmm_manager+0x1e0>
ffffffffc02027b8:	9ddfd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    uint64_t mem_end = mem_begin + mem_size;
ffffffffc02027bc:	00990433          	add	s0,s2,s1
    cprintf("  memory: 0x%08lx, [0x%08lx, 0x%08lx].\n", mem_size, mem_begin,
ffffffffc02027c0:	fff40693          	addi	a3,s0,-1
ffffffffc02027c4:	864a                	mv	a2,s2
ffffffffc02027c6:	85a6                	mv	a1,s1
ffffffffc02027c8:	00004517          	auipc	a0,0x4
ffffffffc02027cc:	f4050513          	addi	a0,a0,-192 # ffffffffc0206708 <default_pmm_manager+0x1f8>
ffffffffc02027d0:	9c5fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    npage = maxpa / PGSIZE;
ffffffffc02027d4:	c8000737          	lui	a4,0xc8000
ffffffffc02027d8:	87a2                	mv	a5,s0
ffffffffc02027da:	54876163          	bltu	a4,s0,ffffffffc0202d1c <pmm_init+0x5ce>
ffffffffc02027de:	757d                	lui	a0,0xfffff
ffffffffc02027e0:	000b4617          	auipc	a2,0xb4
ffffffffc02027e4:	feb60613          	addi	a2,a2,-21 # ffffffffc02b67cb <end+0xfff>
ffffffffc02027e8:	8e69                	and	a2,a2,a0
ffffffffc02027ea:	000b3497          	auipc	s1,0xb3
ffffffffc02027ee:	fa648493          	addi	s1,s1,-90 # ffffffffc02b5790 <npage>
ffffffffc02027f2:	00c7d513          	srli	a0,a5,0xc
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc02027f6:	000b3b97          	auipc	s7,0xb3
ffffffffc02027fa:	fa2b8b93          	addi	s7,s7,-94 # ffffffffc02b5798 <pages>
    npage = maxpa / PGSIZE;
ffffffffc02027fe:	e088                	sd	a0,0(s1)
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0202800:	00cbb023          	sd	a2,0(s7)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc0202804:	000807b7          	lui	a5,0x80
    pages = (struct Page *)ROUNDUP((void *)end, PGSIZE);
ffffffffc0202808:	86b2                	mv	a3,a2
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc020280a:	02f50863          	beq	a0,a5,ffffffffc020283a <pmm_init+0xec>
ffffffffc020280e:	4781                	li	a5,0
ffffffffc0202810:	4585                	li	a1,1
ffffffffc0202812:	fff806b7          	lui	a3,0xfff80
        SetPageReserved(pages + i);
ffffffffc0202816:	00679513          	slli	a0,a5,0x6
ffffffffc020281a:	9532                	add	a0,a0,a2
ffffffffc020281c:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd4983c>
ffffffffc0202820:	40b7302f          	amoor.d	zero,a1,(a4)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc0202824:	6088                	ld	a0,0(s1)
ffffffffc0202826:	0785                	addi	a5,a5,1
        SetPageReserved(pages + i);
ffffffffc0202828:	000bb603          	ld	a2,0(s7)
    for (size_t i = 0; i < npage - nbase; i++)
ffffffffc020282c:	00d50733          	add	a4,a0,a3
ffffffffc0202830:	fee7e3e3          	bltu	a5,a4,ffffffffc0202816 <pmm_init+0xc8>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0202834:	071a                	slli	a4,a4,0x6
ffffffffc0202836:	00e606b3          	add	a3,a2,a4
ffffffffc020283a:	c02007b7          	lui	a5,0xc0200
ffffffffc020283e:	2ef6ece3          	bltu	a3,a5,ffffffffc0203336 <pmm_init+0xbe8>
ffffffffc0202842:	0009b583          	ld	a1,0(s3)
    mem_end = ROUNDDOWN(mem_end, PGSIZE);
ffffffffc0202846:	77fd                	lui	a5,0xfffff
ffffffffc0202848:	8c7d                	and	s0,s0,a5
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc020284a:	8e8d                	sub	a3,a3,a1
    if (freemem < mem_end)
ffffffffc020284c:	5086eb63          	bltu	a3,s0,ffffffffc0202d62 <pmm_init+0x614>
    cprintf("vapaofset is %llu\n", va_pa_offset);
ffffffffc0202850:	00004517          	auipc	a0,0x4
ffffffffc0202854:	ee050513          	addi	a0,a0,-288 # ffffffffc0206730 <default_pmm_manager+0x220>
ffffffffc0202858:	93dfd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    return page;
}

static void check_alloc_page(void)
{
    pmm_manager->check();
ffffffffc020285c:	000b3783          	ld	a5,0(s6)
    boot_pgdir_va = (pte_t *)boot_page_table_sv39;
ffffffffc0202860:	000b3917          	auipc	s2,0xb3
ffffffffc0202864:	f2890913          	addi	s2,s2,-216 # ffffffffc02b5788 <boot_pgdir_va>
    pmm_manager->check();
ffffffffc0202868:	7b9c                	ld	a5,48(a5)
ffffffffc020286a:	9782                	jalr	a5
    cprintf("check_alloc_page() succeeded!\n");
ffffffffc020286c:	00004517          	auipc	a0,0x4
ffffffffc0202870:	edc50513          	addi	a0,a0,-292 # ffffffffc0206748 <default_pmm_manager+0x238>
ffffffffc0202874:	921fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
    boot_pgdir_va = (pte_t *)boot_page_table_sv39;
ffffffffc0202878:	00007697          	auipc	a3,0x7
ffffffffc020287c:	78868693          	addi	a3,a3,1928 # ffffffffc020a000 <boot_page_table_sv39>
ffffffffc0202880:	00d93023          	sd	a3,0(s2)
    boot_pgdir_pa = PADDR(boot_pgdir_va);
ffffffffc0202884:	c02007b7          	lui	a5,0xc0200
ffffffffc0202888:	28f6ebe3          	bltu	a3,a5,ffffffffc020331e <pmm_init+0xbd0>
ffffffffc020288c:	0009b783          	ld	a5,0(s3)
ffffffffc0202890:	8e9d                	sub	a3,a3,a5
ffffffffc0202892:	000b3797          	auipc	a5,0xb3
ffffffffc0202896:	eed7b723          	sd	a3,-274(a5) # ffffffffc02b5780 <boot_pgdir_pa>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020289a:	100027f3          	csrr	a5,sstatus
ffffffffc020289e:	8b89                	andi	a5,a5,2
ffffffffc02028a0:	4a079763          	bnez	a5,ffffffffc0202d4e <pmm_init+0x600>
        ret = pmm_manager->nr_free_pages();
ffffffffc02028a4:	000b3783          	ld	a5,0(s6)
ffffffffc02028a8:	779c                	ld	a5,40(a5)
ffffffffc02028aa:	9782                	jalr	a5
ffffffffc02028ac:	842a                	mv	s0,a0
    // so npage is always larger than KMEMSIZE / PGSIZE
    size_t nr_free_store;

    nr_free_store = nr_free_pages();

    assert(npage <= KERNTOP / PGSIZE);
ffffffffc02028ae:	6098                	ld	a4,0(s1)
ffffffffc02028b0:	c80007b7          	lui	a5,0xc8000
ffffffffc02028b4:	83b1                	srli	a5,a5,0xc
ffffffffc02028b6:	66e7e363          	bltu	a5,a4,ffffffffc0202f1c <pmm_init+0x7ce>
    assert(boot_pgdir_va != NULL && (uint32_t)PGOFF(boot_pgdir_va) == 0);
ffffffffc02028ba:	00093503          	ld	a0,0(s2)
ffffffffc02028be:	62050f63          	beqz	a0,ffffffffc0202efc <pmm_init+0x7ae>
ffffffffc02028c2:	03451793          	slli	a5,a0,0x34
ffffffffc02028c6:	62079b63          	bnez	a5,ffffffffc0202efc <pmm_init+0x7ae>
    assert(get_page(boot_pgdir_va, 0x0, NULL) == NULL);
ffffffffc02028ca:	4601                	li	a2,0
ffffffffc02028cc:	4581                	li	a1,0
ffffffffc02028ce:	8c3ff0ef          	jal	ra,ffffffffc0202190 <get_page>
ffffffffc02028d2:	60051563          	bnez	a0,ffffffffc0202edc <pmm_init+0x78e>
ffffffffc02028d6:	100027f3          	csrr	a5,sstatus
ffffffffc02028da:	8b89                	andi	a5,a5,2
ffffffffc02028dc:	44079e63          	bnez	a5,ffffffffc0202d38 <pmm_init+0x5ea>
        page = pmm_manager->alloc_pages(n);
ffffffffc02028e0:	000b3783          	ld	a5,0(s6)
ffffffffc02028e4:	4505                	li	a0,1
ffffffffc02028e6:	6f9c                	ld	a5,24(a5)
ffffffffc02028e8:	9782                	jalr	a5
ffffffffc02028ea:	8a2a                	mv	s4,a0

    struct Page *p1, *p2;
    p1 = alloc_page();
    assert(page_insert(boot_pgdir_va, p1, 0x0, 0) == 0);
ffffffffc02028ec:	00093503          	ld	a0,0(s2)
ffffffffc02028f0:	4681                	li	a3,0
ffffffffc02028f2:	4601                	li	a2,0
ffffffffc02028f4:	85d2                	mv	a1,s4
ffffffffc02028f6:	d63ff0ef          	jal	ra,ffffffffc0202658 <page_insert>
ffffffffc02028fa:	26051ae3          	bnez	a0,ffffffffc020336e <pmm_init+0xc20>

    pte_t *ptep;
    assert((ptep = get_pte(boot_pgdir_va, 0x0, 0)) != NULL);
ffffffffc02028fe:	00093503          	ld	a0,0(s2)
ffffffffc0202902:	4601                	li	a2,0
ffffffffc0202904:	4581                	li	a1,0
ffffffffc0202906:	e62ff0ef          	jal	ra,ffffffffc0201f68 <get_pte>
ffffffffc020290a:	240502e3          	beqz	a0,ffffffffc020334e <pmm_init+0xc00>
    assert(pte2page(*ptep) == p1);
ffffffffc020290e:	611c                	ld	a5,0(a0)
    if (!(pte & PTE_V))
ffffffffc0202910:	0017f713          	andi	a4,a5,1
ffffffffc0202914:	5a070263          	beqz	a4,ffffffffc0202eb8 <pmm_init+0x76a>
    if (PPN(pa) >= npage)
ffffffffc0202918:	6098                	ld	a4,0(s1)
    return pa2page(PTE_ADDR(pte));
ffffffffc020291a:	078a                	slli	a5,a5,0x2
ffffffffc020291c:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc020291e:	58e7fb63          	bgeu	a5,a4,ffffffffc0202eb4 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202922:	000bb683          	ld	a3,0(s7)
ffffffffc0202926:	fff80637          	lui	a2,0xfff80
ffffffffc020292a:	97b2                	add	a5,a5,a2
ffffffffc020292c:	079a                	slli	a5,a5,0x6
ffffffffc020292e:	97b6                	add	a5,a5,a3
ffffffffc0202930:	14fa17e3          	bne	s4,a5,ffffffffc020327e <pmm_init+0xb30>
    assert(page_ref(p1) == 1);
ffffffffc0202934:	000a2683          	lw	a3,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8bb0>
ffffffffc0202938:	4785                	li	a5,1
ffffffffc020293a:	12f692e3          	bne	a3,a5,ffffffffc020325e <pmm_init+0xb10>

    ptep = (pte_t *)KADDR(PDE_ADDR(boot_pgdir_va[0]));
ffffffffc020293e:	00093503          	ld	a0,0(s2)
ffffffffc0202942:	77fd                	lui	a5,0xfffff
ffffffffc0202944:	6114                	ld	a3,0(a0)
ffffffffc0202946:	068a                	slli	a3,a3,0x2
ffffffffc0202948:	8efd                	and	a3,a3,a5
ffffffffc020294a:	00c6d613          	srli	a2,a3,0xc
ffffffffc020294e:	0ee67ce3          	bgeu	a2,a4,ffffffffc0203246 <pmm_init+0xaf8>
ffffffffc0202952:	0009bc03          	ld	s8,0(s3)
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc0202956:	96e2                	add	a3,a3,s8
ffffffffc0202958:	0006ba83          	ld	s5,0(a3)
ffffffffc020295c:	0a8a                	slli	s5,s5,0x2
ffffffffc020295e:	00fafab3          	and	s5,s5,a5
ffffffffc0202962:	00cad793          	srli	a5,s5,0xc
ffffffffc0202966:	0ce7f3e3          	bgeu	a5,a4,ffffffffc020322c <pmm_init+0xade>
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc020296a:	4601                	li	a2,0
ffffffffc020296c:	6585                	lui	a1,0x1
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc020296e:	9ae2                	add	s5,s5,s8
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202970:	df8ff0ef          	jal	ra,ffffffffc0201f68 <get_pte>
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc0202974:	0aa1                	addi	s5,s5,8
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202976:	55551363          	bne	a0,s5,ffffffffc0202ebc <pmm_init+0x76e>
ffffffffc020297a:	100027f3          	csrr	a5,sstatus
ffffffffc020297e:	8b89                	andi	a5,a5,2
ffffffffc0202980:	3a079163          	bnez	a5,ffffffffc0202d22 <pmm_init+0x5d4>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202984:	000b3783          	ld	a5,0(s6)
ffffffffc0202988:	4505                	li	a0,1
ffffffffc020298a:	6f9c                	ld	a5,24(a5)
ffffffffc020298c:	9782                	jalr	a5
ffffffffc020298e:	8c2a                	mv	s8,a0

    p2 = alloc_page();
    assert(page_insert(boot_pgdir_va, p2, PGSIZE, PTE_U | PTE_W) == 0);
ffffffffc0202990:	00093503          	ld	a0,0(s2)
ffffffffc0202994:	46d1                	li	a3,20
ffffffffc0202996:	6605                	lui	a2,0x1
ffffffffc0202998:	85e2                	mv	a1,s8
ffffffffc020299a:	cbfff0ef          	jal	ra,ffffffffc0202658 <page_insert>
ffffffffc020299e:	060517e3          	bnez	a0,ffffffffc020320c <pmm_init+0xabe>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02029a2:	00093503          	ld	a0,0(s2)
ffffffffc02029a6:	4601                	li	a2,0
ffffffffc02029a8:	6585                	lui	a1,0x1
ffffffffc02029aa:	dbeff0ef          	jal	ra,ffffffffc0201f68 <get_pte>
ffffffffc02029ae:	02050fe3          	beqz	a0,ffffffffc02031ec <pmm_init+0xa9e>
    assert(*ptep & PTE_U);
ffffffffc02029b2:	611c                	ld	a5,0(a0)
ffffffffc02029b4:	0107f713          	andi	a4,a5,16
ffffffffc02029b8:	7c070e63          	beqz	a4,ffffffffc0203194 <pmm_init+0xa46>
    assert(*ptep & PTE_W);
ffffffffc02029bc:	8b91                	andi	a5,a5,4
ffffffffc02029be:	7a078b63          	beqz	a5,ffffffffc0203174 <pmm_init+0xa26>
    assert(boot_pgdir_va[0] & PTE_U);
ffffffffc02029c2:	00093503          	ld	a0,0(s2)
ffffffffc02029c6:	611c                	ld	a5,0(a0)
ffffffffc02029c8:	8bc1                	andi	a5,a5,16
ffffffffc02029ca:	78078563          	beqz	a5,ffffffffc0203154 <pmm_init+0xa06>
    assert(page_ref(p2) == 1);
ffffffffc02029ce:	000c2703          	lw	a4,0(s8)
ffffffffc02029d2:	4785                	li	a5,1
ffffffffc02029d4:	76f71063          	bne	a4,a5,ffffffffc0203134 <pmm_init+0x9e6>

    assert(page_insert(boot_pgdir_va, p1, PGSIZE, 0) == 0);
ffffffffc02029d8:	4681                	li	a3,0
ffffffffc02029da:	6605                	lui	a2,0x1
ffffffffc02029dc:	85d2                	mv	a1,s4
ffffffffc02029de:	c7bff0ef          	jal	ra,ffffffffc0202658 <page_insert>
ffffffffc02029e2:	72051963          	bnez	a0,ffffffffc0203114 <pmm_init+0x9c6>
    assert(page_ref(p1) == 2);
ffffffffc02029e6:	000a2703          	lw	a4,0(s4)
ffffffffc02029ea:	4789                	li	a5,2
ffffffffc02029ec:	70f71463          	bne	a4,a5,ffffffffc02030f4 <pmm_init+0x9a6>
    assert(page_ref(p2) == 0);
ffffffffc02029f0:	000c2783          	lw	a5,0(s8)
ffffffffc02029f4:	6e079063          	bnez	a5,ffffffffc02030d4 <pmm_init+0x986>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02029f8:	00093503          	ld	a0,0(s2)
ffffffffc02029fc:	4601                	li	a2,0
ffffffffc02029fe:	6585                	lui	a1,0x1
ffffffffc0202a00:	d68ff0ef          	jal	ra,ffffffffc0201f68 <get_pte>
ffffffffc0202a04:	6a050863          	beqz	a0,ffffffffc02030b4 <pmm_init+0x966>
    assert(pte2page(*ptep) == p1);
ffffffffc0202a08:	6118                	ld	a4,0(a0)
    if (!(pte & PTE_V))
ffffffffc0202a0a:	00177793          	andi	a5,a4,1
ffffffffc0202a0e:	4a078563          	beqz	a5,ffffffffc0202eb8 <pmm_init+0x76a>
    if (PPN(pa) >= npage)
ffffffffc0202a12:	6094                	ld	a3,0(s1)
    return pa2page(PTE_ADDR(pte));
ffffffffc0202a14:	00271793          	slli	a5,a4,0x2
ffffffffc0202a18:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202a1a:	48d7fd63          	bgeu	a5,a3,ffffffffc0202eb4 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202a1e:	000bb683          	ld	a3,0(s7)
ffffffffc0202a22:	fff80ab7          	lui	s5,0xfff80
ffffffffc0202a26:	97d6                	add	a5,a5,s5
ffffffffc0202a28:	079a                	slli	a5,a5,0x6
ffffffffc0202a2a:	97b6                	add	a5,a5,a3
ffffffffc0202a2c:	66fa1463          	bne	s4,a5,ffffffffc0203094 <pmm_init+0x946>
    assert((*ptep & PTE_U) == 0);
ffffffffc0202a30:	8b41                	andi	a4,a4,16
ffffffffc0202a32:	64071163          	bnez	a4,ffffffffc0203074 <pmm_init+0x926>

    page_remove(boot_pgdir_va, 0x0);
ffffffffc0202a36:	00093503          	ld	a0,0(s2)
ffffffffc0202a3a:	4581                	li	a1,0
ffffffffc0202a3c:	b81ff0ef          	jal	ra,ffffffffc02025bc <page_remove>
    assert(page_ref(p1) == 1);
ffffffffc0202a40:	000a2c83          	lw	s9,0(s4)
ffffffffc0202a44:	4785                	li	a5,1
ffffffffc0202a46:	60fc9763          	bne	s9,a5,ffffffffc0203054 <pmm_init+0x906>
    assert(page_ref(p2) == 0);
ffffffffc0202a4a:	000c2783          	lw	a5,0(s8)
ffffffffc0202a4e:	5e079363          	bnez	a5,ffffffffc0203034 <pmm_init+0x8e6>

    page_remove(boot_pgdir_va, PGSIZE);
ffffffffc0202a52:	00093503          	ld	a0,0(s2)
ffffffffc0202a56:	6585                	lui	a1,0x1
ffffffffc0202a58:	b65ff0ef          	jal	ra,ffffffffc02025bc <page_remove>
    assert(page_ref(p1) == 0);
ffffffffc0202a5c:	000a2783          	lw	a5,0(s4)
ffffffffc0202a60:	52079a63          	bnez	a5,ffffffffc0202f94 <pmm_init+0x846>
    assert(page_ref(p2) == 0);
ffffffffc0202a64:	000c2783          	lw	a5,0(s8)
ffffffffc0202a68:	50079663          	bnez	a5,ffffffffc0202f74 <pmm_init+0x826>

    assert(page_ref(pde2page(boot_pgdir_va[0])) == 1);
ffffffffc0202a6c:	00093a03          	ld	s4,0(s2)
    if (PPN(pa) >= npage)
ffffffffc0202a70:	608c                	ld	a1,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202a72:	000a3683          	ld	a3,0(s4)
ffffffffc0202a76:	068a                	slli	a3,a3,0x2
ffffffffc0202a78:	82b1                	srli	a3,a3,0xc
    if (PPN(pa) >= npage)
ffffffffc0202a7a:	42b6fd63          	bgeu	a3,a1,ffffffffc0202eb4 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202a7e:	000bb503          	ld	a0,0(s7)
ffffffffc0202a82:	96d6                	add	a3,a3,s5
ffffffffc0202a84:	069a                	slli	a3,a3,0x6
    return page->ref;
ffffffffc0202a86:	00d507b3          	add	a5,a0,a3
ffffffffc0202a8a:	439c                	lw	a5,0(a5)
ffffffffc0202a8c:	4d979463          	bne	a5,s9,ffffffffc0202f54 <pmm_init+0x806>
    return page - pages + nbase;
ffffffffc0202a90:	8699                	srai	a3,a3,0x6
ffffffffc0202a92:	00080637          	lui	a2,0x80
ffffffffc0202a96:	96b2                	add	a3,a3,a2
    return KADDR(page2pa(page));
ffffffffc0202a98:	00c69713          	slli	a4,a3,0xc
ffffffffc0202a9c:	8331                	srli	a4,a4,0xc
    return page2ppn(page) << PGSHIFT;
ffffffffc0202a9e:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202aa0:	48b77e63          	bgeu	a4,a1,ffffffffc0202f3c <pmm_init+0x7ee>

    pde_t *pd1 = boot_pgdir_va, *pd0 = page2kva(pde2page(boot_pgdir_va[0]));
    free_page(pde2page(pd0[0]));
ffffffffc0202aa4:	0009b703          	ld	a4,0(s3)
ffffffffc0202aa8:	96ba                	add	a3,a3,a4
    return pa2page(PDE_ADDR(pde));
ffffffffc0202aaa:	629c                	ld	a5,0(a3)
ffffffffc0202aac:	078a                	slli	a5,a5,0x2
ffffffffc0202aae:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202ab0:	40b7f263          	bgeu	a5,a1,ffffffffc0202eb4 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202ab4:	8f91                	sub	a5,a5,a2
ffffffffc0202ab6:	079a                	slli	a5,a5,0x6
ffffffffc0202ab8:	953e                	add	a0,a0,a5
ffffffffc0202aba:	100027f3          	csrr	a5,sstatus
ffffffffc0202abe:	8b89                	andi	a5,a5,2
ffffffffc0202ac0:	30079963          	bnez	a5,ffffffffc0202dd2 <pmm_init+0x684>
        pmm_manager->free_pages(base, n);
ffffffffc0202ac4:	000b3783          	ld	a5,0(s6)
ffffffffc0202ac8:	4585                	li	a1,1
ffffffffc0202aca:	739c                	ld	a5,32(a5)
ffffffffc0202acc:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202ace:	000a3783          	ld	a5,0(s4)
    if (PPN(pa) >= npage)
ffffffffc0202ad2:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202ad4:	078a                	slli	a5,a5,0x2
ffffffffc0202ad6:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202ad8:	3ce7fe63          	bgeu	a5,a4,ffffffffc0202eb4 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202adc:	000bb503          	ld	a0,0(s7)
ffffffffc0202ae0:	fff80737          	lui	a4,0xfff80
ffffffffc0202ae4:	97ba                	add	a5,a5,a4
ffffffffc0202ae6:	079a                	slli	a5,a5,0x6
ffffffffc0202ae8:	953e                	add	a0,a0,a5
ffffffffc0202aea:	100027f3          	csrr	a5,sstatus
ffffffffc0202aee:	8b89                	andi	a5,a5,2
ffffffffc0202af0:	2c079563          	bnez	a5,ffffffffc0202dba <pmm_init+0x66c>
ffffffffc0202af4:	000b3783          	ld	a5,0(s6)
ffffffffc0202af8:	4585                	li	a1,1
ffffffffc0202afa:	739c                	ld	a5,32(a5)
ffffffffc0202afc:	9782                	jalr	a5
    free_page(pde2page(pd1[0]));
    boot_pgdir_va[0] = 0;
ffffffffc0202afe:	00093783          	ld	a5,0(s2)
ffffffffc0202b02:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd49834>
    asm volatile("sfence.vma");
ffffffffc0202b06:	12000073          	sfence.vma
ffffffffc0202b0a:	100027f3          	csrr	a5,sstatus
ffffffffc0202b0e:	8b89                	andi	a5,a5,2
ffffffffc0202b10:	28079b63          	bnez	a5,ffffffffc0202da6 <pmm_init+0x658>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202b14:	000b3783          	ld	a5,0(s6)
ffffffffc0202b18:	779c                	ld	a5,40(a5)
ffffffffc0202b1a:	9782                	jalr	a5
ffffffffc0202b1c:	8a2a                	mv	s4,a0
    flush_tlb();

    assert(nr_free_store == nr_free_pages());
ffffffffc0202b1e:	4b441b63          	bne	s0,s4,ffffffffc0202fd4 <pmm_init+0x886>

    cprintf("check_pgdir() succeeded!\n");
ffffffffc0202b22:	00004517          	auipc	a0,0x4
ffffffffc0202b26:	f4e50513          	addi	a0,a0,-178 # ffffffffc0206a70 <default_pmm_manager+0x560>
ffffffffc0202b2a:	e6afd0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc0202b2e:	100027f3          	csrr	a5,sstatus
ffffffffc0202b32:	8b89                	andi	a5,a5,2
ffffffffc0202b34:	24079f63          	bnez	a5,ffffffffc0202d92 <pmm_init+0x644>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202b38:	000b3783          	ld	a5,0(s6)
ffffffffc0202b3c:	779c                	ld	a5,40(a5)
ffffffffc0202b3e:	9782                	jalr	a5
ffffffffc0202b40:	8c2a                	mv	s8,a0
    pte_t *ptep;
    int i;

    nr_free_store = nr_free_pages();

    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202b42:	6098                	ld	a4,0(s1)
ffffffffc0202b44:	c0200437          	lui	s0,0xc0200
    {
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202b48:	7afd                	lui	s5,0xfffff
    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202b4a:	00c71793          	slli	a5,a4,0xc
ffffffffc0202b4e:	6a05                	lui	s4,0x1
ffffffffc0202b50:	02f47c63          	bgeu	s0,a5,ffffffffc0202b88 <pmm_init+0x43a>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202b54:	00c45793          	srli	a5,s0,0xc
ffffffffc0202b58:	00093503          	ld	a0,0(s2)
ffffffffc0202b5c:	2ee7ff63          	bgeu	a5,a4,ffffffffc0202e5a <pmm_init+0x70c>
ffffffffc0202b60:	0009b583          	ld	a1,0(s3)
ffffffffc0202b64:	4601                	li	a2,0
ffffffffc0202b66:	95a2                	add	a1,a1,s0
ffffffffc0202b68:	c00ff0ef          	jal	ra,ffffffffc0201f68 <get_pte>
ffffffffc0202b6c:	32050463          	beqz	a0,ffffffffc0202e94 <pmm_init+0x746>
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202b70:	611c                	ld	a5,0(a0)
ffffffffc0202b72:	078a                	slli	a5,a5,0x2
ffffffffc0202b74:	0157f7b3          	and	a5,a5,s5
ffffffffc0202b78:	2e879e63          	bne	a5,s0,ffffffffc0202e74 <pmm_init+0x726>
    for (i = ROUNDDOWN(KERNBASE, PGSIZE); i < npage * PGSIZE; i += PGSIZE)
ffffffffc0202b7c:	6098                	ld	a4,0(s1)
ffffffffc0202b7e:	9452                	add	s0,s0,s4
ffffffffc0202b80:	00c71793          	slli	a5,a4,0xc
ffffffffc0202b84:	fcf468e3          	bltu	s0,a5,ffffffffc0202b54 <pmm_init+0x406>
    }

    assert(boot_pgdir_va[0] == 0);
ffffffffc0202b88:	00093783          	ld	a5,0(s2)
ffffffffc0202b8c:	639c                	ld	a5,0(a5)
ffffffffc0202b8e:	42079363          	bnez	a5,ffffffffc0202fb4 <pmm_init+0x866>
ffffffffc0202b92:	100027f3          	csrr	a5,sstatus
ffffffffc0202b96:	8b89                	andi	a5,a5,2
ffffffffc0202b98:	24079963          	bnez	a5,ffffffffc0202dea <pmm_init+0x69c>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202b9c:	000b3783          	ld	a5,0(s6)
ffffffffc0202ba0:	4505                	li	a0,1
ffffffffc0202ba2:	6f9c                	ld	a5,24(a5)
ffffffffc0202ba4:	9782                	jalr	a5
ffffffffc0202ba6:	8a2a                	mv	s4,a0

    struct Page *p;
    p = alloc_page();
    assert(page_insert(boot_pgdir_va, p, 0x100, PTE_W | PTE_R) == 0);
ffffffffc0202ba8:	00093503          	ld	a0,0(s2)
ffffffffc0202bac:	4699                	li	a3,6
ffffffffc0202bae:	10000613          	li	a2,256
ffffffffc0202bb2:	85d2                	mv	a1,s4
ffffffffc0202bb4:	aa5ff0ef          	jal	ra,ffffffffc0202658 <page_insert>
ffffffffc0202bb8:	44051e63          	bnez	a0,ffffffffc0203014 <pmm_init+0x8c6>
    assert(page_ref(p) == 1);
ffffffffc0202bbc:	000a2703          	lw	a4,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8bb0>
ffffffffc0202bc0:	4785                	li	a5,1
ffffffffc0202bc2:	42f71963          	bne	a4,a5,ffffffffc0202ff4 <pmm_init+0x8a6>
    assert(page_insert(boot_pgdir_va, p, 0x100 + PGSIZE, PTE_W | PTE_R) == 0);
ffffffffc0202bc6:	00093503          	ld	a0,0(s2)
ffffffffc0202bca:	6405                	lui	s0,0x1
ffffffffc0202bcc:	4699                	li	a3,6
ffffffffc0202bce:	10040613          	addi	a2,s0,256 # 1100 <_binary_obj___user_faultread_out_size-0x8ab0>
ffffffffc0202bd2:	85d2                	mv	a1,s4
ffffffffc0202bd4:	a85ff0ef          	jal	ra,ffffffffc0202658 <page_insert>
ffffffffc0202bd8:	72051363          	bnez	a0,ffffffffc02032fe <pmm_init+0xbb0>
    assert(page_ref(p) == 2);
ffffffffc0202bdc:	000a2703          	lw	a4,0(s4)
ffffffffc0202be0:	4789                	li	a5,2
ffffffffc0202be2:	6ef71e63          	bne	a4,a5,ffffffffc02032de <pmm_init+0xb90>

    const char *str = "ucore: Hello world!!";
    strcpy((void *)0x100, str);
ffffffffc0202be6:	00004597          	auipc	a1,0x4
ffffffffc0202bea:	fd258593          	addi	a1,a1,-46 # ffffffffc0206bb8 <default_pmm_manager+0x6a8>
ffffffffc0202bee:	10000513          	li	a0,256
ffffffffc0202bf2:	247020ef          	jal	ra,ffffffffc0205638 <strcpy>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
ffffffffc0202bf6:	10040593          	addi	a1,s0,256
ffffffffc0202bfa:	10000513          	li	a0,256
ffffffffc0202bfe:	24d020ef          	jal	ra,ffffffffc020564a <strcmp>
ffffffffc0202c02:	6a051e63          	bnez	a0,ffffffffc02032be <pmm_init+0xb70>
    return page - pages + nbase;
ffffffffc0202c06:	000bb683          	ld	a3,0(s7)
ffffffffc0202c0a:	00080737          	lui	a4,0x80
    return KADDR(page2pa(page));
ffffffffc0202c0e:	547d                	li	s0,-1
    return page - pages + nbase;
ffffffffc0202c10:	40da06b3          	sub	a3,s4,a3
ffffffffc0202c14:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0202c16:	609c                	ld	a5,0(s1)
    return page - pages + nbase;
ffffffffc0202c18:	96ba                	add	a3,a3,a4
    return KADDR(page2pa(page));
ffffffffc0202c1a:	8031                	srli	s0,s0,0xc
ffffffffc0202c1c:	0086f733          	and	a4,a3,s0
    return page2ppn(page) << PGSHIFT;
ffffffffc0202c20:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202c22:	30f77d63          	bgeu	a4,a5,ffffffffc0202f3c <pmm_init+0x7ee>

    *(char *)(page2kva(p) + 0x100) = '\0';
ffffffffc0202c26:	0009b783          	ld	a5,0(s3)
    assert(strlen((const char *)0x100) == 0);
ffffffffc0202c2a:	10000513          	li	a0,256
    *(char *)(page2kva(p) + 0x100) = '\0';
ffffffffc0202c2e:	96be                	add	a3,a3,a5
ffffffffc0202c30:	10068023          	sb	zero,256(a3)
    assert(strlen((const char *)0x100) == 0);
ffffffffc0202c34:	1cf020ef          	jal	ra,ffffffffc0205602 <strlen>
ffffffffc0202c38:	66051363          	bnez	a0,ffffffffc020329e <pmm_init+0xb50>

    pde_t *pd1 = boot_pgdir_va, *pd0 = page2kva(pde2page(boot_pgdir_va[0]));
ffffffffc0202c3c:	00093a83          	ld	s5,0(s2)
    if (PPN(pa) >= npage)
ffffffffc0202c40:	609c                	ld	a5,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c42:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd49834>
ffffffffc0202c46:	068a                	slli	a3,a3,0x2
ffffffffc0202c48:	82b1                	srli	a3,a3,0xc
    if (PPN(pa) >= npage)
ffffffffc0202c4a:	26f6f563          	bgeu	a3,a5,ffffffffc0202eb4 <pmm_init+0x766>
    return KADDR(page2pa(page));
ffffffffc0202c4e:	8c75                	and	s0,s0,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc0202c50:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0202c52:	2ef47563          	bgeu	s0,a5,ffffffffc0202f3c <pmm_init+0x7ee>
ffffffffc0202c56:	0009b403          	ld	s0,0(s3)
ffffffffc0202c5a:	9436                	add	s0,s0,a3
ffffffffc0202c5c:	100027f3          	csrr	a5,sstatus
ffffffffc0202c60:	8b89                	andi	a5,a5,2
ffffffffc0202c62:	1e079163          	bnez	a5,ffffffffc0202e44 <pmm_init+0x6f6>
        pmm_manager->free_pages(base, n);
ffffffffc0202c66:	000b3783          	ld	a5,0(s6)
ffffffffc0202c6a:	4585                	li	a1,1
ffffffffc0202c6c:	8552                	mv	a0,s4
ffffffffc0202c6e:	739c                	ld	a5,32(a5)
ffffffffc0202c70:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c72:	601c                	ld	a5,0(s0)
    if (PPN(pa) >= npage)
ffffffffc0202c74:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202c76:	078a                	slli	a5,a5,0x2
ffffffffc0202c78:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202c7a:	22e7fd63          	bgeu	a5,a4,ffffffffc0202eb4 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202c7e:	000bb503          	ld	a0,0(s7)
ffffffffc0202c82:	fff80737          	lui	a4,0xfff80
ffffffffc0202c86:	97ba                	add	a5,a5,a4
ffffffffc0202c88:	079a                	slli	a5,a5,0x6
ffffffffc0202c8a:	953e                	add	a0,a0,a5
ffffffffc0202c8c:	100027f3          	csrr	a5,sstatus
ffffffffc0202c90:	8b89                	andi	a5,a5,2
ffffffffc0202c92:	18079d63          	bnez	a5,ffffffffc0202e2c <pmm_init+0x6de>
ffffffffc0202c96:	000b3783          	ld	a5,0(s6)
ffffffffc0202c9a:	4585                	li	a1,1
ffffffffc0202c9c:	739c                	ld	a5,32(a5)
ffffffffc0202c9e:	9782                	jalr	a5
    return pa2page(PDE_ADDR(pde));
ffffffffc0202ca0:	000ab783          	ld	a5,0(s5)
    if (PPN(pa) >= npage)
ffffffffc0202ca4:	6098                	ld	a4,0(s1)
    return pa2page(PDE_ADDR(pde));
ffffffffc0202ca6:	078a                	slli	a5,a5,0x2
ffffffffc0202ca8:	83b1                	srli	a5,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0202caa:	20e7f563          	bgeu	a5,a4,ffffffffc0202eb4 <pmm_init+0x766>
    return &pages[PPN(pa) - nbase];
ffffffffc0202cae:	000bb503          	ld	a0,0(s7)
ffffffffc0202cb2:	fff80737          	lui	a4,0xfff80
ffffffffc0202cb6:	97ba                	add	a5,a5,a4
ffffffffc0202cb8:	079a                	slli	a5,a5,0x6
ffffffffc0202cba:	953e                	add	a0,a0,a5
ffffffffc0202cbc:	100027f3          	csrr	a5,sstatus
ffffffffc0202cc0:	8b89                	andi	a5,a5,2
ffffffffc0202cc2:	14079963          	bnez	a5,ffffffffc0202e14 <pmm_init+0x6c6>
ffffffffc0202cc6:	000b3783          	ld	a5,0(s6)
ffffffffc0202cca:	4585                	li	a1,1
ffffffffc0202ccc:	739c                	ld	a5,32(a5)
ffffffffc0202cce:	9782                	jalr	a5
    free_page(p);
    free_page(pde2page(pd0[0]));
    free_page(pde2page(pd1[0]));
    boot_pgdir_va[0] = 0;
ffffffffc0202cd0:	00093783          	ld	a5,0(s2)
ffffffffc0202cd4:	0007b023          	sd	zero,0(a5)
    asm volatile("sfence.vma");
ffffffffc0202cd8:	12000073          	sfence.vma
ffffffffc0202cdc:	100027f3          	csrr	a5,sstatus
ffffffffc0202ce0:	8b89                	andi	a5,a5,2
ffffffffc0202ce2:	10079f63          	bnez	a5,ffffffffc0202e00 <pmm_init+0x6b2>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202ce6:	000b3783          	ld	a5,0(s6)
ffffffffc0202cea:	779c                	ld	a5,40(a5)
ffffffffc0202cec:	9782                	jalr	a5
ffffffffc0202cee:	842a                	mv	s0,a0
    flush_tlb();

    assert(nr_free_store == nr_free_pages());
ffffffffc0202cf0:	4c8c1e63          	bne	s8,s0,ffffffffc02031cc <pmm_init+0xa7e>

    cprintf("check_boot_pgdir() succeeded!\n");
ffffffffc0202cf4:	00004517          	auipc	a0,0x4
ffffffffc0202cf8:	f3c50513          	addi	a0,a0,-196 # ffffffffc0206c30 <default_pmm_manager+0x720>
ffffffffc0202cfc:	c98fd0ef          	jal	ra,ffffffffc0200194 <cprintf>
}
ffffffffc0202d00:	7406                	ld	s0,96(sp)
ffffffffc0202d02:	70a6                	ld	ra,104(sp)
ffffffffc0202d04:	64e6                	ld	s1,88(sp)
ffffffffc0202d06:	6946                	ld	s2,80(sp)
ffffffffc0202d08:	69a6                	ld	s3,72(sp)
ffffffffc0202d0a:	6a06                	ld	s4,64(sp)
ffffffffc0202d0c:	7ae2                	ld	s5,56(sp)
ffffffffc0202d0e:	7b42                	ld	s6,48(sp)
ffffffffc0202d10:	7ba2                	ld	s7,40(sp)
ffffffffc0202d12:	7c02                	ld	s8,32(sp)
ffffffffc0202d14:	6ce2                	ld	s9,24(sp)
ffffffffc0202d16:	6165                	addi	sp,sp,112
    kmalloc_init();
ffffffffc0202d18:	f97fe06f          	j	ffffffffc0201cae <kmalloc_init>
    npage = maxpa / PGSIZE;
ffffffffc0202d1c:	c80007b7          	lui	a5,0xc8000
ffffffffc0202d20:	bc7d                	j	ffffffffc02027de <pmm_init+0x90>
        intr_disable();
ffffffffc0202d22:	c93fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202d26:	000b3783          	ld	a5,0(s6)
ffffffffc0202d2a:	4505                	li	a0,1
ffffffffc0202d2c:	6f9c                	ld	a5,24(a5)
ffffffffc0202d2e:	9782                	jalr	a5
ffffffffc0202d30:	8c2a                	mv	s8,a0
        intr_enable();
ffffffffc0202d32:	c7dfd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202d36:	b9a9                	j	ffffffffc0202990 <pmm_init+0x242>
        intr_disable();
ffffffffc0202d38:	c7dfd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202d3c:	000b3783          	ld	a5,0(s6)
ffffffffc0202d40:	4505                	li	a0,1
ffffffffc0202d42:	6f9c                	ld	a5,24(a5)
ffffffffc0202d44:	9782                	jalr	a5
ffffffffc0202d46:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202d48:	c67fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202d4c:	b645                	j	ffffffffc02028ec <pmm_init+0x19e>
        intr_disable();
ffffffffc0202d4e:	c67fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202d52:	000b3783          	ld	a5,0(s6)
ffffffffc0202d56:	779c                	ld	a5,40(a5)
ffffffffc0202d58:	9782                	jalr	a5
ffffffffc0202d5a:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202d5c:	c53fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202d60:	b6b9                	j	ffffffffc02028ae <pmm_init+0x160>
    mem_begin = ROUNDUP(freemem, PGSIZE);
ffffffffc0202d62:	6705                	lui	a4,0x1
ffffffffc0202d64:	177d                	addi	a4,a4,-1
ffffffffc0202d66:	96ba                	add	a3,a3,a4
ffffffffc0202d68:	8ff5                	and	a5,a5,a3
    if (PPN(pa) >= npage)
ffffffffc0202d6a:	00c7d713          	srli	a4,a5,0xc
ffffffffc0202d6e:	14a77363          	bgeu	a4,a0,ffffffffc0202eb4 <pmm_init+0x766>
    pmm_manager->init_memmap(base, n);
ffffffffc0202d72:	000b3683          	ld	a3,0(s6)
    return &pages[PPN(pa) - nbase];
ffffffffc0202d76:	fff80537          	lui	a0,0xfff80
ffffffffc0202d7a:	972a                	add	a4,a4,a0
ffffffffc0202d7c:	6a94                	ld	a3,16(a3)
        init_memmap(pa2page(mem_begin), (mem_end - mem_begin) / PGSIZE);
ffffffffc0202d7e:	8c1d                	sub	s0,s0,a5
ffffffffc0202d80:	00671513          	slli	a0,a4,0x6
    pmm_manager->init_memmap(base, n);
ffffffffc0202d84:	00c45593          	srli	a1,s0,0xc
ffffffffc0202d88:	9532                	add	a0,a0,a2
ffffffffc0202d8a:	9682                	jalr	a3
    cprintf("vapaofset is %llu\n", va_pa_offset);
ffffffffc0202d8c:	0009b583          	ld	a1,0(s3)
}
ffffffffc0202d90:	b4c1                	j	ffffffffc0202850 <pmm_init+0x102>
        intr_disable();
ffffffffc0202d92:	c23fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202d96:	000b3783          	ld	a5,0(s6)
ffffffffc0202d9a:	779c                	ld	a5,40(a5)
ffffffffc0202d9c:	9782                	jalr	a5
ffffffffc0202d9e:	8c2a                	mv	s8,a0
        intr_enable();
ffffffffc0202da0:	c0ffd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202da4:	bb79                	j	ffffffffc0202b42 <pmm_init+0x3f4>
        intr_disable();
ffffffffc0202da6:	c0ffd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202daa:	000b3783          	ld	a5,0(s6)
ffffffffc0202dae:	779c                	ld	a5,40(a5)
ffffffffc0202db0:	9782                	jalr	a5
ffffffffc0202db2:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202db4:	bfbfd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202db8:	b39d                	j	ffffffffc0202b1e <pmm_init+0x3d0>
ffffffffc0202dba:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202dbc:	bf9fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202dc0:	000b3783          	ld	a5,0(s6)
ffffffffc0202dc4:	6522                	ld	a0,8(sp)
ffffffffc0202dc6:	4585                	li	a1,1
ffffffffc0202dc8:	739c                	ld	a5,32(a5)
ffffffffc0202dca:	9782                	jalr	a5
        intr_enable();
ffffffffc0202dcc:	be3fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202dd0:	b33d                	j	ffffffffc0202afe <pmm_init+0x3b0>
ffffffffc0202dd2:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202dd4:	be1fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202dd8:	000b3783          	ld	a5,0(s6)
ffffffffc0202ddc:	6522                	ld	a0,8(sp)
ffffffffc0202dde:	4585                	li	a1,1
ffffffffc0202de0:	739c                	ld	a5,32(a5)
ffffffffc0202de2:	9782                	jalr	a5
        intr_enable();
ffffffffc0202de4:	bcbfd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202de8:	b1dd                	j	ffffffffc0202ace <pmm_init+0x380>
        intr_disable();
ffffffffc0202dea:	bcbfd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc0202dee:	000b3783          	ld	a5,0(s6)
ffffffffc0202df2:	4505                	li	a0,1
ffffffffc0202df4:	6f9c                	ld	a5,24(a5)
ffffffffc0202df6:	9782                	jalr	a5
ffffffffc0202df8:	8a2a                	mv	s4,a0
        intr_enable();
ffffffffc0202dfa:	bb5fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202dfe:	b36d                	j	ffffffffc0202ba8 <pmm_init+0x45a>
        intr_disable();
ffffffffc0202e00:	bb5fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        ret = pmm_manager->nr_free_pages();
ffffffffc0202e04:	000b3783          	ld	a5,0(s6)
ffffffffc0202e08:	779c                	ld	a5,40(a5)
ffffffffc0202e0a:	9782                	jalr	a5
ffffffffc0202e0c:	842a                	mv	s0,a0
        intr_enable();
ffffffffc0202e0e:	ba1fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202e12:	bdf9                	j	ffffffffc0202cf0 <pmm_init+0x5a2>
ffffffffc0202e14:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202e16:	b9ffd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        pmm_manager->free_pages(base, n);
ffffffffc0202e1a:	000b3783          	ld	a5,0(s6)
ffffffffc0202e1e:	6522                	ld	a0,8(sp)
ffffffffc0202e20:	4585                	li	a1,1
ffffffffc0202e22:	739c                	ld	a5,32(a5)
ffffffffc0202e24:	9782                	jalr	a5
        intr_enable();
ffffffffc0202e26:	b89fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202e2a:	b55d                	j	ffffffffc0202cd0 <pmm_init+0x582>
ffffffffc0202e2c:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0202e2e:	b87fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202e32:	000b3783          	ld	a5,0(s6)
ffffffffc0202e36:	6522                	ld	a0,8(sp)
ffffffffc0202e38:	4585                	li	a1,1
ffffffffc0202e3a:	739c                	ld	a5,32(a5)
ffffffffc0202e3c:	9782                	jalr	a5
        intr_enable();
ffffffffc0202e3e:	b71fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202e42:	bdb9                	j	ffffffffc0202ca0 <pmm_init+0x552>
        intr_disable();
ffffffffc0202e44:	b71fd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc0202e48:	000b3783          	ld	a5,0(s6)
ffffffffc0202e4c:	4585                	li	a1,1
ffffffffc0202e4e:	8552                	mv	a0,s4
ffffffffc0202e50:	739c                	ld	a5,32(a5)
ffffffffc0202e52:	9782                	jalr	a5
        intr_enable();
ffffffffc0202e54:	b5bfd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0202e58:	bd29                	j	ffffffffc0202c72 <pmm_init+0x524>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202e5a:	86a2                	mv	a3,s0
ffffffffc0202e5c:	00003617          	auipc	a2,0x3
ffffffffc0202e60:	6ec60613          	addi	a2,a2,1772 # ffffffffc0206548 <default_pmm_manager+0x38>
ffffffffc0202e64:	25200593          	li	a1,594
ffffffffc0202e68:	00003517          	auipc	a0,0x3
ffffffffc0202e6c:	7f850513          	addi	a0,a0,2040 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0202e70:	e1efd0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(PTE_ADDR(*ptep) == i);
ffffffffc0202e74:	00004697          	auipc	a3,0x4
ffffffffc0202e78:	c5c68693          	addi	a3,a3,-932 # ffffffffc0206ad0 <default_pmm_manager+0x5c0>
ffffffffc0202e7c:	00003617          	auipc	a2,0x3
ffffffffc0202e80:	2e460613          	addi	a2,a2,740 # ffffffffc0206160 <commands+0x828>
ffffffffc0202e84:	25300593          	li	a1,595
ffffffffc0202e88:	00003517          	auipc	a0,0x3
ffffffffc0202e8c:	7d850513          	addi	a0,a0,2008 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0202e90:	dfefd0ef          	jal	ra,ffffffffc020048e <__panic>
        assert((ptep = get_pte(boot_pgdir_va, (uintptr_t)KADDR(i), 0)) != NULL);
ffffffffc0202e94:	00004697          	auipc	a3,0x4
ffffffffc0202e98:	bfc68693          	addi	a3,a3,-1028 # ffffffffc0206a90 <default_pmm_manager+0x580>
ffffffffc0202e9c:	00003617          	auipc	a2,0x3
ffffffffc0202ea0:	2c460613          	addi	a2,a2,708 # ffffffffc0206160 <commands+0x828>
ffffffffc0202ea4:	25200593          	li	a1,594
ffffffffc0202ea8:	00003517          	auipc	a0,0x3
ffffffffc0202eac:	7b850513          	addi	a0,a0,1976 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0202eb0:	ddefd0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc0202eb4:	fc5fe0ef          	jal	ra,ffffffffc0201e78 <pa2page.part.0>
ffffffffc0202eb8:	fddfe0ef          	jal	ra,ffffffffc0201e94 <pte2page.part.0>
    assert(get_pte(boot_pgdir_va, PGSIZE, 0) == ptep);
ffffffffc0202ebc:	00004697          	auipc	a3,0x4
ffffffffc0202ec0:	9cc68693          	addi	a3,a3,-1588 # ffffffffc0206888 <default_pmm_manager+0x378>
ffffffffc0202ec4:	00003617          	auipc	a2,0x3
ffffffffc0202ec8:	29c60613          	addi	a2,a2,668 # ffffffffc0206160 <commands+0x828>
ffffffffc0202ecc:	22200593          	li	a1,546
ffffffffc0202ed0:	00003517          	auipc	a0,0x3
ffffffffc0202ed4:	79050513          	addi	a0,a0,1936 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0202ed8:	db6fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(get_page(boot_pgdir_va, 0x0, NULL) == NULL);
ffffffffc0202edc:	00004697          	auipc	a3,0x4
ffffffffc0202ee0:	8ec68693          	addi	a3,a3,-1812 # ffffffffc02067c8 <default_pmm_manager+0x2b8>
ffffffffc0202ee4:	00003617          	auipc	a2,0x3
ffffffffc0202ee8:	27c60613          	addi	a2,a2,636 # ffffffffc0206160 <commands+0x828>
ffffffffc0202eec:	21500593          	li	a1,533
ffffffffc0202ef0:	00003517          	auipc	a0,0x3
ffffffffc0202ef4:	77050513          	addi	a0,a0,1904 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0202ef8:	d96fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(boot_pgdir_va != NULL && (uint32_t)PGOFF(boot_pgdir_va) == 0);
ffffffffc0202efc:	00004697          	auipc	a3,0x4
ffffffffc0202f00:	88c68693          	addi	a3,a3,-1908 # ffffffffc0206788 <default_pmm_manager+0x278>
ffffffffc0202f04:	00003617          	auipc	a2,0x3
ffffffffc0202f08:	25c60613          	addi	a2,a2,604 # ffffffffc0206160 <commands+0x828>
ffffffffc0202f0c:	21400593          	li	a1,532
ffffffffc0202f10:	00003517          	auipc	a0,0x3
ffffffffc0202f14:	75050513          	addi	a0,a0,1872 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0202f18:	d76fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(npage <= KERNTOP / PGSIZE);
ffffffffc0202f1c:	00004697          	auipc	a3,0x4
ffffffffc0202f20:	84c68693          	addi	a3,a3,-1972 # ffffffffc0206768 <default_pmm_manager+0x258>
ffffffffc0202f24:	00003617          	auipc	a2,0x3
ffffffffc0202f28:	23c60613          	addi	a2,a2,572 # ffffffffc0206160 <commands+0x828>
ffffffffc0202f2c:	21300593          	li	a1,531
ffffffffc0202f30:	00003517          	auipc	a0,0x3
ffffffffc0202f34:	73050513          	addi	a0,a0,1840 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0202f38:	d56fd0ef          	jal	ra,ffffffffc020048e <__panic>
    return KADDR(page2pa(page));
ffffffffc0202f3c:	00003617          	auipc	a2,0x3
ffffffffc0202f40:	60c60613          	addi	a2,a2,1548 # ffffffffc0206548 <default_pmm_manager+0x38>
ffffffffc0202f44:	07100593          	li	a1,113
ffffffffc0202f48:	00003517          	auipc	a0,0x3
ffffffffc0202f4c:	62850513          	addi	a0,a0,1576 # ffffffffc0206570 <default_pmm_manager+0x60>
ffffffffc0202f50:	d3efd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(pde2page(boot_pgdir_va[0])) == 1);
ffffffffc0202f54:	00004697          	auipc	a3,0x4
ffffffffc0202f58:	ac468693          	addi	a3,a3,-1340 # ffffffffc0206a18 <default_pmm_manager+0x508>
ffffffffc0202f5c:	00003617          	auipc	a2,0x3
ffffffffc0202f60:	20460613          	addi	a2,a2,516 # ffffffffc0206160 <commands+0x828>
ffffffffc0202f64:	23b00593          	li	a1,571
ffffffffc0202f68:	00003517          	auipc	a0,0x3
ffffffffc0202f6c:	6f850513          	addi	a0,a0,1784 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0202f70:	d1efd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p2) == 0);
ffffffffc0202f74:	00004697          	auipc	a3,0x4
ffffffffc0202f78:	a5c68693          	addi	a3,a3,-1444 # ffffffffc02069d0 <default_pmm_manager+0x4c0>
ffffffffc0202f7c:	00003617          	auipc	a2,0x3
ffffffffc0202f80:	1e460613          	addi	a2,a2,484 # ffffffffc0206160 <commands+0x828>
ffffffffc0202f84:	23900593          	li	a1,569
ffffffffc0202f88:	00003517          	auipc	a0,0x3
ffffffffc0202f8c:	6d850513          	addi	a0,a0,1752 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0202f90:	cfefd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p1) == 0);
ffffffffc0202f94:	00004697          	auipc	a3,0x4
ffffffffc0202f98:	a6c68693          	addi	a3,a3,-1428 # ffffffffc0206a00 <default_pmm_manager+0x4f0>
ffffffffc0202f9c:	00003617          	auipc	a2,0x3
ffffffffc0202fa0:	1c460613          	addi	a2,a2,452 # ffffffffc0206160 <commands+0x828>
ffffffffc0202fa4:	23800593          	li	a1,568
ffffffffc0202fa8:	00003517          	auipc	a0,0x3
ffffffffc0202fac:	6b850513          	addi	a0,a0,1720 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0202fb0:	cdefd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(boot_pgdir_va[0] == 0);
ffffffffc0202fb4:	00004697          	auipc	a3,0x4
ffffffffc0202fb8:	b3468693          	addi	a3,a3,-1228 # ffffffffc0206ae8 <default_pmm_manager+0x5d8>
ffffffffc0202fbc:	00003617          	auipc	a2,0x3
ffffffffc0202fc0:	1a460613          	addi	a2,a2,420 # ffffffffc0206160 <commands+0x828>
ffffffffc0202fc4:	25600593          	li	a1,598
ffffffffc0202fc8:	00003517          	auipc	a0,0x3
ffffffffc0202fcc:	69850513          	addi	a0,a0,1688 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0202fd0:	cbefd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free_store == nr_free_pages());
ffffffffc0202fd4:	00004697          	auipc	a3,0x4
ffffffffc0202fd8:	a7468693          	addi	a3,a3,-1420 # ffffffffc0206a48 <default_pmm_manager+0x538>
ffffffffc0202fdc:	00003617          	auipc	a2,0x3
ffffffffc0202fe0:	18460613          	addi	a2,a2,388 # ffffffffc0206160 <commands+0x828>
ffffffffc0202fe4:	24300593          	li	a1,579
ffffffffc0202fe8:	00003517          	auipc	a0,0x3
ffffffffc0202fec:	67850513          	addi	a0,a0,1656 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0202ff0:	c9efd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p) == 1);
ffffffffc0202ff4:	00004697          	auipc	a3,0x4
ffffffffc0202ff8:	b4c68693          	addi	a3,a3,-1204 # ffffffffc0206b40 <default_pmm_manager+0x630>
ffffffffc0202ffc:	00003617          	auipc	a2,0x3
ffffffffc0203000:	16460613          	addi	a2,a2,356 # ffffffffc0206160 <commands+0x828>
ffffffffc0203004:	25b00593          	li	a1,603
ffffffffc0203008:	00003517          	auipc	a0,0x3
ffffffffc020300c:	65850513          	addi	a0,a0,1624 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0203010:	c7efd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p, 0x100, PTE_W | PTE_R) == 0);
ffffffffc0203014:	00004697          	auipc	a3,0x4
ffffffffc0203018:	aec68693          	addi	a3,a3,-1300 # ffffffffc0206b00 <default_pmm_manager+0x5f0>
ffffffffc020301c:	00003617          	auipc	a2,0x3
ffffffffc0203020:	14460613          	addi	a2,a2,324 # ffffffffc0206160 <commands+0x828>
ffffffffc0203024:	25a00593          	li	a1,602
ffffffffc0203028:	00003517          	auipc	a0,0x3
ffffffffc020302c:	63850513          	addi	a0,a0,1592 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0203030:	c5efd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p2) == 0);
ffffffffc0203034:	00004697          	auipc	a3,0x4
ffffffffc0203038:	99c68693          	addi	a3,a3,-1636 # ffffffffc02069d0 <default_pmm_manager+0x4c0>
ffffffffc020303c:	00003617          	auipc	a2,0x3
ffffffffc0203040:	12460613          	addi	a2,a2,292 # ffffffffc0206160 <commands+0x828>
ffffffffc0203044:	23500593          	li	a1,565
ffffffffc0203048:	00003517          	auipc	a0,0x3
ffffffffc020304c:	61850513          	addi	a0,a0,1560 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0203050:	c3efd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p1) == 1);
ffffffffc0203054:	00004697          	auipc	a3,0x4
ffffffffc0203058:	81c68693          	addi	a3,a3,-2020 # ffffffffc0206870 <default_pmm_manager+0x360>
ffffffffc020305c:	00003617          	auipc	a2,0x3
ffffffffc0203060:	10460613          	addi	a2,a2,260 # ffffffffc0206160 <commands+0x828>
ffffffffc0203064:	23400593          	li	a1,564
ffffffffc0203068:	00003517          	auipc	a0,0x3
ffffffffc020306c:	5f850513          	addi	a0,a0,1528 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0203070:	c1efd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((*ptep & PTE_U) == 0);
ffffffffc0203074:	00004697          	auipc	a3,0x4
ffffffffc0203078:	97468693          	addi	a3,a3,-1676 # ffffffffc02069e8 <default_pmm_manager+0x4d8>
ffffffffc020307c:	00003617          	auipc	a2,0x3
ffffffffc0203080:	0e460613          	addi	a2,a2,228 # ffffffffc0206160 <commands+0x828>
ffffffffc0203084:	23100593          	li	a1,561
ffffffffc0203088:	00003517          	auipc	a0,0x3
ffffffffc020308c:	5d850513          	addi	a0,a0,1496 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0203090:	bfefd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pte2page(*ptep) == p1);
ffffffffc0203094:	00003697          	auipc	a3,0x3
ffffffffc0203098:	7c468693          	addi	a3,a3,1988 # ffffffffc0206858 <default_pmm_manager+0x348>
ffffffffc020309c:	00003617          	auipc	a2,0x3
ffffffffc02030a0:	0c460613          	addi	a2,a2,196 # ffffffffc0206160 <commands+0x828>
ffffffffc02030a4:	23000593          	li	a1,560
ffffffffc02030a8:	00003517          	auipc	a0,0x3
ffffffffc02030ac:	5b850513          	addi	a0,a0,1464 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc02030b0:	bdefd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02030b4:	00004697          	auipc	a3,0x4
ffffffffc02030b8:	84468693          	addi	a3,a3,-1980 # ffffffffc02068f8 <default_pmm_manager+0x3e8>
ffffffffc02030bc:	00003617          	auipc	a2,0x3
ffffffffc02030c0:	0a460613          	addi	a2,a2,164 # ffffffffc0206160 <commands+0x828>
ffffffffc02030c4:	22f00593          	li	a1,559
ffffffffc02030c8:	00003517          	auipc	a0,0x3
ffffffffc02030cc:	59850513          	addi	a0,a0,1432 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc02030d0:	bbefd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p2) == 0);
ffffffffc02030d4:	00004697          	auipc	a3,0x4
ffffffffc02030d8:	8fc68693          	addi	a3,a3,-1796 # ffffffffc02069d0 <default_pmm_manager+0x4c0>
ffffffffc02030dc:	00003617          	auipc	a2,0x3
ffffffffc02030e0:	08460613          	addi	a2,a2,132 # ffffffffc0206160 <commands+0x828>
ffffffffc02030e4:	22e00593          	li	a1,558
ffffffffc02030e8:	00003517          	auipc	a0,0x3
ffffffffc02030ec:	57850513          	addi	a0,a0,1400 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc02030f0:	b9efd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p1) == 2);
ffffffffc02030f4:	00004697          	auipc	a3,0x4
ffffffffc02030f8:	8c468693          	addi	a3,a3,-1852 # ffffffffc02069b8 <default_pmm_manager+0x4a8>
ffffffffc02030fc:	00003617          	auipc	a2,0x3
ffffffffc0203100:	06460613          	addi	a2,a2,100 # ffffffffc0206160 <commands+0x828>
ffffffffc0203104:	22d00593          	li	a1,557
ffffffffc0203108:	00003517          	auipc	a0,0x3
ffffffffc020310c:	55850513          	addi	a0,a0,1368 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0203110:	b7efd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p1, PGSIZE, 0) == 0);
ffffffffc0203114:	00004697          	auipc	a3,0x4
ffffffffc0203118:	87468693          	addi	a3,a3,-1932 # ffffffffc0206988 <default_pmm_manager+0x478>
ffffffffc020311c:	00003617          	auipc	a2,0x3
ffffffffc0203120:	04460613          	addi	a2,a2,68 # ffffffffc0206160 <commands+0x828>
ffffffffc0203124:	22c00593          	li	a1,556
ffffffffc0203128:	00003517          	auipc	a0,0x3
ffffffffc020312c:	53850513          	addi	a0,a0,1336 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0203130:	b5efd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p2) == 1);
ffffffffc0203134:	00004697          	auipc	a3,0x4
ffffffffc0203138:	83c68693          	addi	a3,a3,-1988 # ffffffffc0206970 <default_pmm_manager+0x460>
ffffffffc020313c:	00003617          	auipc	a2,0x3
ffffffffc0203140:	02460613          	addi	a2,a2,36 # ffffffffc0206160 <commands+0x828>
ffffffffc0203144:	22a00593          	li	a1,554
ffffffffc0203148:	00003517          	auipc	a0,0x3
ffffffffc020314c:	51850513          	addi	a0,a0,1304 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0203150:	b3efd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(boot_pgdir_va[0] & PTE_U);
ffffffffc0203154:	00003697          	auipc	a3,0x3
ffffffffc0203158:	7fc68693          	addi	a3,a3,2044 # ffffffffc0206950 <default_pmm_manager+0x440>
ffffffffc020315c:	00003617          	auipc	a2,0x3
ffffffffc0203160:	00460613          	addi	a2,a2,4 # ffffffffc0206160 <commands+0x828>
ffffffffc0203164:	22900593          	li	a1,553
ffffffffc0203168:	00003517          	auipc	a0,0x3
ffffffffc020316c:	4f850513          	addi	a0,a0,1272 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0203170:	b1efd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(*ptep & PTE_W);
ffffffffc0203174:	00003697          	auipc	a3,0x3
ffffffffc0203178:	7cc68693          	addi	a3,a3,1996 # ffffffffc0206940 <default_pmm_manager+0x430>
ffffffffc020317c:	00003617          	auipc	a2,0x3
ffffffffc0203180:	fe460613          	addi	a2,a2,-28 # ffffffffc0206160 <commands+0x828>
ffffffffc0203184:	22800593          	li	a1,552
ffffffffc0203188:	00003517          	auipc	a0,0x3
ffffffffc020318c:	4d850513          	addi	a0,a0,1240 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0203190:	afefd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(*ptep & PTE_U);
ffffffffc0203194:	00003697          	auipc	a3,0x3
ffffffffc0203198:	79c68693          	addi	a3,a3,1948 # ffffffffc0206930 <default_pmm_manager+0x420>
ffffffffc020319c:	00003617          	auipc	a2,0x3
ffffffffc02031a0:	fc460613          	addi	a2,a2,-60 # ffffffffc0206160 <commands+0x828>
ffffffffc02031a4:	22700593          	li	a1,551
ffffffffc02031a8:	00003517          	auipc	a0,0x3
ffffffffc02031ac:	4b850513          	addi	a0,a0,1208 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc02031b0:	adefd0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("DTB memory info not available");
ffffffffc02031b4:	00003617          	auipc	a2,0x3
ffffffffc02031b8:	51c60613          	addi	a2,a2,1308 # ffffffffc02066d0 <default_pmm_manager+0x1c0>
ffffffffc02031bc:	06500593          	li	a1,101
ffffffffc02031c0:	00003517          	auipc	a0,0x3
ffffffffc02031c4:	4a050513          	addi	a0,a0,1184 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc02031c8:	ac6fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_free_store == nr_free_pages());
ffffffffc02031cc:	00004697          	auipc	a3,0x4
ffffffffc02031d0:	87c68693          	addi	a3,a3,-1924 # ffffffffc0206a48 <default_pmm_manager+0x538>
ffffffffc02031d4:	00003617          	auipc	a2,0x3
ffffffffc02031d8:	f8c60613          	addi	a2,a2,-116 # ffffffffc0206160 <commands+0x828>
ffffffffc02031dc:	26d00593          	li	a1,621
ffffffffc02031e0:	00003517          	auipc	a0,0x3
ffffffffc02031e4:	48050513          	addi	a0,a0,1152 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc02031e8:	aa6fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((ptep = get_pte(boot_pgdir_va, PGSIZE, 0)) != NULL);
ffffffffc02031ec:	00003697          	auipc	a3,0x3
ffffffffc02031f0:	70c68693          	addi	a3,a3,1804 # ffffffffc02068f8 <default_pmm_manager+0x3e8>
ffffffffc02031f4:	00003617          	auipc	a2,0x3
ffffffffc02031f8:	f6c60613          	addi	a2,a2,-148 # ffffffffc0206160 <commands+0x828>
ffffffffc02031fc:	22600593          	li	a1,550
ffffffffc0203200:	00003517          	auipc	a0,0x3
ffffffffc0203204:	46050513          	addi	a0,a0,1120 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0203208:	a86fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p2, PGSIZE, PTE_U | PTE_W) == 0);
ffffffffc020320c:	00003697          	auipc	a3,0x3
ffffffffc0203210:	6ac68693          	addi	a3,a3,1708 # ffffffffc02068b8 <default_pmm_manager+0x3a8>
ffffffffc0203214:	00003617          	auipc	a2,0x3
ffffffffc0203218:	f4c60613          	addi	a2,a2,-180 # ffffffffc0206160 <commands+0x828>
ffffffffc020321c:	22500593          	li	a1,549
ffffffffc0203220:	00003517          	auipc	a0,0x3
ffffffffc0203224:	44050513          	addi	a0,a0,1088 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0203228:	a66fd0ef          	jal	ra,ffffffffc020048e <__panic>
    ptep = (pte_t *)KADDR(PDE_ADDR(ptep[0])) + 1;
ffffffffc020322c:	86d6                	mv	a3,s5
ffffffffc020322e:	00003617          	auipc	a2,0x3
ffffffffc0203232:	31a60613          	addi	a2,a2,794 # ffffffffc0206548 <default_pmm_manager+0x38>
ffffffffc0203236:	22100593          	li	a1,545
ffffffffc020323a:	00003517          	auipc	a0,0x3
ffffffffc020323e:	42650513          	addi	a0,a0,1062 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0203242:	a4cfd0ef          	jal	ra,ffffffffc020048e <__panic>
    ptep = (pte_t *)KADDR(PDE_ADDR(boot_pgdir_va[0]));
ffffffffc0203246:	00003617          	auipc	a2,0x3
ffffffffc020324a:	30260613          	addi	a2,a2,770 # ffffffffc0206548 <default_pmm_manager+0x38>
ffffffffc020324e:	22000593          	li	a1,544
ffffffffc0203252:	00003517          	auipc	a0,0x3
ffffffffc0203256:	40e50513          	addi	a0,a0,1038 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc020325a:	a34fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p1) == 1);
ffffffffc020325e:	00003697          	auipc	a3,0x3
ffffffffc0203262:	61268693          	addi	a3,a3,1554 # ffffffffc0206870 <default_pmm_manager+0x360>
ffffffffc0203266:	00003617          	auipc	a2,0x3
ffffffffc020326a:	efa60613          	addi	a2,a2,-262 # ffffffffc0206160 <commands+0x828>
ffffffffc020326e:	21e00593          	li	a1,542
ffffffffc0203272:	00003517          	auipc	a0,0x3
ffffffffc0203276:	3ee50513          	addi	a0,a0,1006 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc020327a:	a14fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pte2page(*ptep) == p1);
ffffffffc020327e:	00003697          	auipc	a3,0x3
ffffffffc0203282:	5da68693          	addi	a3,a3,1498 # ffffffffc0206858 <default_pmm_manager+0x348>
ffffffffc0203286:	00003617          	auipc	a2,0x3
ffffffffc020328a:	eda60613          	addi	a2,a2,-294 # ffffffffc0206160 <commands+0x828>
ffffffffc020328e:	21d00593          	li	a1,541
ffffffffc0203292:	00003517          	auipc	a0,0x3
ffffffffc0203296:	3ce50513          	addi	a0,a0,974 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc020329a:	9f4fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(strlen((const char *)0x100) == 0);
ffffffffc020329e:	00004697          	auipc	a3,0x4
ffffffffc02032a2:	96a68693          	addi	a3,a3,-1686 # ffffffffc0206c08 <default_pmm_manager+0x6f8>
ffffffffc02032a6:	00003617          	auipc	a2,0x3
ffffffffc02032aa:	eba60613          	addi	a2,a2,-326 # ffffffffc0206160 <commands+0x828>
ffffffffc02032ae:	26400593          	li	a1,612
ffffffffc02032b2:	00003517          	auipc	a0,0x3
ffffffffc02032b6:	3ae50513          	addi	a0,a0,942 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc02032ba:	9d4fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(strcmp((void *)0x100, (void *)(0x100 + PGSIZE)) == 0);
ffffffffc02032be:	00004697          	auipc	a3,0x4
ffffffffc02032c2:	91268693          	addi	a3,a3,-1774 # ffffffffc0206bd0 <default_pmm_manager+0x6c0>
ffffffffc02032c6:	00003617          	auipc	a2,0x3
ffffffffc02032ca:	e9a60613          	addi	a2,a2,-358 # ffffffffc0206160 <commands+0x828>
ffffffffc02032ce:	26100593          	li	a1,609
ffffffffc02032d2:	00003517          	auipc	a0,0x3
ffffffffc02032d6:	38e50513          	addi	a0,a0,910 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc02032da:	9b4fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_ref(p) == 2);
ffffffffc02032de:	00004697          	auipc	a3,0x4
ffffffffc02032e2:	8c268693          	addi	a3,a3,-1854 # ffffffffc0206ba0 <default_pmm_manager+0x690>
ffffffffc02032e6:	00003617          	auipc	a2,0x3
ffffffffc02032ea:	e7a60613          	addi	a2,a2,-390 # ffffffffc0206160 <commands+0x828>
ffffffffc02032ee:	25d00593          	li	a1,605
ffffffffc02032f2:	00003517          	auipc	a0,0x3
ffffffffc02032f6:	36e50513          	addi	a0,a0,878 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc02032fa:	994fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p, 0x100 + PGSIZE, PTE_W | PTE_R) == 0);
ffffffffc02032fe:	00004697          	auipc	a3,0x4
ffffffffc0203302:	85a68693          	addi	a3,a3,-1958 # ffffffffc0206b58 <default_pmm_manager+0x648>
ffffffffc0203306:	00003617          	auipc	a2,0x3
ffffffffc020330a:	e5a60613          	addi	a2,a2,-422 # ffffffffc0206160 <commands+0x828>
ffffffffc020330e:	25c00593          	li	a1,604
ffffffffc0203312:	00003517          	auipc	a0,0x3
ffffffffc0203316:	34e50513          	addi	a0,a0,846 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc020331a:	974fd0ef          	jal	ra,ffffffffc020048e <__panic>
    boot_pgdir_pa = PADDR(boot_pgdir_va);
ffffffffc020331e:	00003617          	auipc	a2,0x3
ffffffffc0203322:	2d260613          	addi	a2,a2,722 # ffffffffc02065f0 <default_pmm_manager+0xe0>
ffffffffc0203326:	0c900593          	li	a1,201
ffffffffc020332a:	00003517          	auipc	a0,0x3
ffffffffc020332e:	33650513          	addi	a0,a0,822 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc0203332:	95cfd0ef          	jal	ra,ffffffffc020048e <__panic>
    uintptr_t freemem = PADDR((uintptr_t)pages + sizeof(struct Page) * (npage - nbase));
ffffffffc0203336:	00003617          	auipc	a2,0x3
ffffffffc020333a:	2ba60613          	addi	a2,a2,698 # ffffffffc02065f0 <default_pmm_manager+0xe0>
ffffffffc020333e:	08100593          	li	a1,129
ffffffffc0203342:	00003517          	auipc	a0,0x3
ffffffffc0203346:	31e50513          	addi	a0,a0,798 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc020334a:	944fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert((ptep = get_pte(boot_pgdir_va, 0x0, 0)) != NULL);
ffffffffc020334e:	00003697          	auipc	a3,0x3
ffffffffc0203352:	4da68693          	addi	a3,a3,1242 # ffffffffc0206828 <default_pmm_manager+0x318>
ffffffffc0203356:	00003617          	auipc	a2,0x3
ffffffffc020335a:	e0a60613          	addi	a2,a2,-502 # ffffffffc0206160 <commands+0x828>
ffffffffc020335e:	21c00593          	li	a1,540
ffffffffc0203362:	00003517          	auipc	a0,0x3
ffffffffc0203366:	2fe50513          	addi	a0,a0,766 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc020336a:	924fd0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(page_insert(boot_pgdir_va, p1, 0x0, 0) == 0);
ffffffffc020336e:	00003697          	auipc	a3,0x3
ffffffffc0203372:	48a68693          	addi	a3,a3,1162 # ffffffffc02067f8 <default_pmm_manager+0x2e8>
ffffffffc0203376:	00003617          	auipc	a2,0x3
ffffffffc020337a:	dea60613          	addi	a2,a2,-534 # ffffffffc0206160 <commands+0x828>
ffffffffc020337e:	21900593          	li	a1,537
ffffffffc0203382:	00003517          	auipc	a0,0x3
ffffffffc0203386:	2de50513          	addi	a0,a0,734 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc020338a:	904fd0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc020338e <copy_range>:
{
ffffffffc020338e:	7159                	addi	sp,sp,-112
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc0203390:	00d667b3          	or	a5,a2,a3
{
ffffffffc0203394:	f486                	sd	ra,104(sp)
ffffffffc0203396:	f0a2                	sd	s0,96(sp)
ffffffffc0203398:	eca6                	sd	s1,88(sp)
ffffffffc020339a:	e8ca                	sd	s2,80(sp)
ffffffffc020339c:	e4ce                	sd	s3,72(sp)
ffffffffc020339e:	e0d2                	sd	s4,64(sp)
ffffffffc02033a0:	fc56                	sd	s5,56(sp)
ffffffffc02033a2:	f85a                	sd	s6,48(sp)
ffffffffc02033a4:	f45e                	sd	s7,40(sp)
ffffffffc02033a6:	f062                	sd	s8,32(sp)
ffffffffc02033a8:	ec66                	sd	s9,24(sp)
ffffffffc02033aa:	e86a                	sd	s10,16(sp)
ffffffffc02033ac:	e46e                	sd	s11,8(sp)
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02033ae:	17d2                	slli	a5,a5,0x34
ffffffffc02033b0:	20079f63          	bnez	a5,ffffffffc02035ce <copy_range+0x240>
    assert(USER_ACCESS(start, end));
ffffffffc02033b4:	002007b7          	lui	a5,0x200
ffffffffc02033b8:	8432                	mv	s0,a2
ffffffffc02033ba:	1af66263          	bltu	a2,a5,ffffffffc020355e <copy_range+0x1d0>
ffffffffc02033be:	8936                	mv	s2,a3
ffffffffc02033c0:	18d67f63          	bgeu	a2,a3,ffffffffc020355e <copy_range+0x1d0>
ffffffffc02033c4:	4785                	li	a5,1
ffffffffc02033c6:	07fe                	slli	a5,a5,0x1f
ffffffffc02033c8:	18d7eb63          	bltu	a5,a3,ffffffffc020355e <copy_range+0x1d0>
ffffffffc02033cc:	5b7d                	li	s6,-1
ffffffffc02033ce:	8aaa                	mv	s5,a0
ffffffffc02033d0:	89ae                	mv	s3,a1
        start += PGSIZE;
ffffffffc02033d2:	6a05                	lui	s4,0x1
    if (PPN(pa) >= npage)
ffffffffc02033d4:	000b2c17          	auipc	s8,0xb2
ffffffffc02033d8:	3bcc0c13          	addi	s8,s8,956 # ffffffffc02b5790 <npage>
    return &pages[PPN(pa) - nbase];
ffffffffc02033dc:	000b2b97          	auipc	s7,0xb2
ffffffffc02033e0:	3bcb8b93          	addi	s7,s7,956 # ffffffffc02b5798 <pages>
    return KADDR(page2pa(page));
ffffffffc02033e4:	00cb5b13          	srli	s6,s6,0xc
        page = pmm_manager->alloc_pages(n);
ffffffffc02033e8:	000b2c97          	auipc	s9,0xb2
ffffffffc02033ec:	3b8c8c93          	addi	s9,s9,952 # ffffffffc02b57a0 <pmm_manager>
        pte_t *ptep = get_pte(from, start, 0), *nptep;
ffffffffc02033f0:	4601                	li	a2,0
ffffffffc02033f2:	85a2                	mv	a1,s0
ffffffffc02033f4:	854e                	mv	a0,s3
ffffffffc02033f6:	b73fe0ef          	jal	ra,ffffffffc0201f68 <get_pte>
ffffffffc02033fa:	84aa                	mv	s1,a0
        if (ptep == NULL)
ffffffffc02033fc:	0e050c63          	beqz	a0,ffffffffc02034f4 <copy_range+0x166>
        if (*ptep & PTE_V)
ffffffffc0203400:	611c                	ld	a5,0(a0)
ffffffffc0203402:	8b85                	andi	a5,a5,1
ffffffffc0203404:	e785                	bnez	a5,ffffffffc020342c <copy_range+0x9e>
        start += PGSIZE;
ffffffffc0203406:	9452                	add	s0,s0,s4
    } while (start != 0 && start < end);
ffffffffc0203408:	ff2464e3          	bltu	s0,s2,ffffffffc02033f0 <copy_range+0x62>
    return 0;
ffffffffc020340c:	4501                	li	a0,0
}
ffffffffc020340e:	70a6                	ld	ra,104(sp)
ffffffffc0203410:	7406                	ld	s0,96(sp)
ffffffffc0203412:	64e6                	ld	s1,88(sp)
ffffffffc0203414:	6946                	ld	s2,80(sp)
ffffffffc0203416:	69a6                	ld	s3,72(sp)
ffffffffc0203418:	6a06                	ld	s4,64(sp)
ffffffffc020341a:	7ae2                	ld	s5,56(sp)
ffffffffc020341c:	7b42                	ld	s6,48(sp)
ffffffffc020341e:	7ba2                	ld	s7,40(sp)
ffffffffc0203420:	7c02                	ld	s8,32(sp)
ffffffffc0203422:	6ce2                	ld	s9,24(sp)
ffffffffc0203424:	6d42                	ld	s10,16(sp)
ffffffffc0203426:	6da2                	ld	s11,8(sp)
ffffffffc0203428:	6165                	addi	sp,sp,112
ffffffffc020342a:	8082                	ret
            if ((nptep = get_pte(to, start, 1)) == NULL)
ffffffffc020342c:	4605                	li	a2,1
ffffffffc020342e:	85a2                	mv	a1,s0
ffffffffc0203430:	8556                	mv	a0,s5
ffffffffc0203432:	b37fe0ef          	jal	ra,ffffffffc0201f68 <get_pte>
ffffffffc0203436:	c56d                	beqz	a0,ffffffffc0203520 <copy_range+0x192>
            uint32_t perm = (*ptep & PTE_USER);
ffffffffc0203438:	609c                	ld	a5,0(s1)
    if (!(pte & PTE_V))
ffffffffc020343a:	0017f713          	andi	a4,a5,1
ffffffffc020343e:	01f7f493          	andi	s1,a5,31
ffffffffc0203442:	16070a63          	beqz	a4,ffffffffc02035b6 <copy_range+0x228>
    if (PPN(pa) >= npage)
ffffffffc0203446:	000c3683          	ld	a3,0(s8)
    return pa2page(PTE_ADDR(pte));
ffffffffc020344a:	078a                	slli	a5,a5,0x2
ffffffffc020344c:	00c7d713          	srli	a4,a5,0xc
    if (PPN(pa) >= npage)
ffffffffc0203450:	14d77763          	bgeu	a4,a3,ffffffffc020359e <copy_range+0x210>
    return &pages[PPN(pa) - nbase];
ffffffffc0203454:	000bb783          	ld	a5,0(s7)
ffffffffc0203458:	fff806b7          	lui	a3,0xfff80
ffffffffc020345c:	9736                	add	a4,a4,a3
ffffffffc020345e:	071a                	slli	a4,a4,0x6
ffffffffc0203460:	00e78db3          	add	s11,a5,a4
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203464:	10002773          	csrr	a4,sstatus
ffffffffc0203468:	8b09                	andi	a4,a4,2
ffffffffc020346a:	e345                	bnez	a4,ffffffffc020350a <copy_range+0x17c>
        page = pmm_manager->alloc_pages(n);
ffffffffc020346c:	000cb703          	ld	a4,0(s9)
ffffffffc0203470:	4505                	li	a0,1
ffffffffc0203472:	6f18                	ld	a4,24(a4)
ffffffffc0203474:	9702                	jalr	a4
ffffffffc0203476:	8d2a                	mv	s10,a0
            assert(page != NULL);
ffffffffc0203478:	0c0d8363          	beqz	s11,ffffffffc020353e <copy_range+0x1b0>
            assert(npage != NULL);
ffffffffc020347c:	100d0163          	beqz	s10,ffffffffc020357e <copy_range+0x1f0>
    return page - pages + nbase;
ffffffffc0203480:	000bb703          	ld	a4,0(s7)
ffffffffc0203484:	000805b7          	lui	a1,0x80
    return KADDR(page2pa(page));
ffffffffc0203488:	000c3603          	ld	a2,0(s8)
    return page - pages + nbase;
ffffffffc020348c:	40ed86b3          	sub	a3,s11,a4
ffffffffc0203490:	8699                	srai	a3,a3,0x6
ffffffffc0203492:	96ae                	add	a3,a3,a1
    return KADDR(page2pa(page));
ffffffffc0203494:	0166f7b3          	and	a5,a3,s6
    return page2ppn(page) << PGSHIFT;
ffffffffc0203498:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc020349a:	08c7f663          	bgeu	a5,a2,ffffffffc0203526 <copy_range+0x198>
    return page - pages + nbase;
ffffffffc020349e:	40ed07b3          	sub	a5,s10,a4
    return KADDR(page2pa(page));
ffffffffc02034a2:	000b2717          	auipc	a4,0xb2
ffffffffc02034a6:	30670713          	addi	a4,a4,774 # ffffffffc02b57a8 <va_pa_offset>
ffffffffc02034aa:	6308                	ld	a0,0(a4)
    return page - pages + nbase;
ffffffffc02034ac:	8799                	srai	a5,a5,0x6
ffffffffc02034ae:	97ae                	add	a5,a5,a1
    return KADDR(page2pa(page));
ffffffffc02034b0:	0167f733          	and	a4,a5,s6
ffffffffc02034b4:	00a685b3          	add	a1,a3,a0
    return page2ppn(page) << PGSHIFT;
ffffffffc02034b8:	07b2                	slli	a5,a5,0xc
    return KADDR(page2pa(page));
ffffffffc02034ba:	06c77563          	bgeu	a4,a2,ffffffffc0203524 <copy_range+0x196>
            memcpy(kva_dst, kva_src, PGSIZE);
ffffffffc02034be:	6605                	lui	a2,0x1
ffffffffc02034c0:	953e                	add	a0,a0,a5
ffffffffc02034c2:	1f4020ef          	jal	ra,ffffffffc02056b6 <memcpy>
            ret = page_insert(to, npage, start, perm);
ffffffffc02034c6:	86a6                	mv	a3,s1
ffffffffc02034c8:	8622                	mv	a2,s0
ffffffffc02034ca:	85ea                	mv	a1,s10
ffffffffc02034cc:	8556                	mv	a0,s5
ffffffffc02034ce:	98aff0ef          	jal	ra,ffffffffc0202658 <page_insert>
            assert(ret == 0);
ffffffffc02034d2:	d915                	beqz	a0,ffffffffc0203406 <copy_range+0x78>
ffffffffc02034d4:	00003697          	auipc	a3,0x3
ffffffffc02034d8:	79c68693          	addi	a3,a3,1948 # ffffffffc0206c70 <default_pmm_manager+0x760>
ffffffffc02034dc:	00003617          	auipc	a2,0x3
ffffffffc02034e0:	c8460613          	addi	a2,a2,-892 # ffffffffc0206160 <commands+0x828>
ffffffffc02034e4:	1b100593          	li	a1,433
ffffffffc02034e8:	00003517          	auipc	a0,0x3
ffffffffc02034ec:	17850513          	addi	a0,a0,376 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc02034f0:	f9ffc0ef          	jal	ra,ffffffffc020048e <__panic>
            start = ROUNDDOWN(start + PTSIZE, PTSIZE);
ffffffffc02034f4:	00200637          	lui	a2,0x200
ffffffffc02034f8:	9432                	add	s0,s0,a2
ffffffffc02034fa:	ffe00637          	lui	a2,0xffe00
ffffffffc02034fe:	8c71                	and	s0,s0,a2
    } while (start != 0 && start < end);
ffffffffc0203500:	f00406e3          	beqz	s0,ffffffffc020340c <copy_range+0x7e>
ffffffffc0203504:	ef2466e3          	bltu	s0,s2,ffffffffc02033f0 <copy_range+0x62>
ffffffffc0203508:	b711                	j	ffffffffc020340c <copy_range+0x7e>
        intr_disable();
ffffffffc020350a:	caafd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc020350e:	000cb703          	ld	a4,0(s9)
ffffffffc0203512:	4505                	li	a0,1
ffffffffc0203514:	6f18                	ld	a4,24(a4)
ffffffffc0203516:	9702                	jalr	a4
ffffffffc0203518:	8d2a                	mv	s10,a0
        intr_enable();
ffffffffc020351a:	c94fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020351e:	bfa9                	j	ffffffffc0203478 <copy_range+0xea>
                return -E_NO_MEM;
ffffffffc0203520:	5571                	li	a0,-4
ffffffffc0203522:	b5f5                	j	ffffffffc020340e <copy_range+0x80>
ffffffffc0203524:	86be                	mv	a3,a5
ffffffffc0203526:	00003617          	auipc	a2,0x3
ffffffffc020352a:	02260613          	addi	a2,a2,34 # ffffffffc0206548 <default_pmm_manager+0x38>
ffffffffc020352e:	07100593          	li	a1,113
ffffffffc0203532:	00003517          	auipc	a0,0x3
ffffffffc0203536:	03e50513          	addi	a0,a0,62 # ffffffffc0206570 <default_pmm_manager+0x60>
ffffffffc020353a:	f55fc0ef          	jal	ra,ffffffffc020048e <__panic>
            assert(page != NULL);
ffffffffc020353e:	00003697          	auipc	a3,0x3
ffffffffc0203542:	71268693          	addi	a3,a3,1810 # ffffffffc0206c50 <default_pmm_manager+0x740>
ffffffffc0203546:	00003617          	auipc	a2,0x3
ffffffffc020354a:	c1a60613          	addi	a2,a2,-998 # ffffffffc0206160 <commands+0x828>
ffffffffc020354e:	19400593          	li	a1,404
ffffffffc0203552:	00003517          	auipc	a0,0x3
ffffffffc0203556:	10e50513          	addi	a0,a0,270 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc020355a:	f35fc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(USER_ACCESS(start, end));
ffffffffc020355e:	00003697          	auipc	a3,0x3
ffffffffc0203562:	14268693          	addi	a3,a3,322 # ffffffffc02066a0 <default_pmm_manager+0x190>
ffffffffc0203566:	00003617          	auipc	a2,0x3
ffffffffc020356a:	bfa60613          	addi	a2,a2,-1030 # ffffffffc0206160 <commands+0x828>
ffffffffc020356e:	17c00593          	li	a1,380
ffffffffc0203572:	00003517          	auipc	a0,0x3
ffffffffc0203576:	0ee50513          	addi	a0,a0,238 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc020357a:	f15fc0ef          	jal	ra,ffffffffc020048e <__panic>
            assert(npage != NULL);
ffffffffc020357e:	00003697          	auipc	a3,0x3
ffffffffc0203582:	6e268693          	addi	a3,a3,1762 # ffffffffc0206c60 <default_pmm_manager+0x750>
ffffffffc0203586:	00003617          	auipc	a2,0x3
ffffffffc020358a:	bda60613          	addi	a2,a2,-1062 # ffffffffc0206160 <commands+0x828>
ffffffffc020358e:	19500593          	li	a1,405
ffffffffc0203592:	00003517          	auipc	a0,0x3
ffffffffc0203596:	0ce50513          	addi	a0,a0,206 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc020359a:	ef5fc0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc020359e:	00003617          	auipc	a2,0x3
ffffffffc02035a2:	07a60613          	addi	a2,a2,122 # ffffffffc0206618 <default_pmm_manager+0x108>
ffffffffc02035a6:	06900593          	li	a1,105
ffffffffc02035aa:	00003517          	auipc	a0,0x3
ffffffffc02035ae:	fc650513          	addi	a0,a0,-58 # ffffffffc0206570 <default_pmm_manager+0x60>
ffffffffc02035b2:	eddfc0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pte2page called with invalid pte");
ffffffffc02035b6:	00003617          	auipc	a2,0x3
ffffffffc02035ba:	08260613          	addi	a2,a2,130 # ffffffffc0206638 <default_pmm_manager+0x128>
ffffffffc02035be:	07f00593          	li	a1,127
ffffffffc02035c2:	00003517          	auipc	a0,0x3
ffffffffc02035c6:	fae50513          	addi	a0,a0,-82 # ffffffffc0206570 <default_pmm_manager+0x60>
ffffffffc02035ca:	ec5fc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(start % PGSIZE == 0 && end % PGSIZE == 0);
ffffffffc02035ce:	00003697          	auipc	a3,0x3
ffffffffc02035d2:	0a268693          	addi	a3,a3,162 # ffffffffc0206670 <default_pmm_manager+0x160>
ffffffffc02035d6:	00003617          	auipc	a2,0x3
ffffffffc02035da:	b8a60613          	addi	a2,a2,-1142 # ffffffffc0206160 <commands+0x828>
ffffffffc02035de:	17b00593          	li	a1,379
ffffffffc02035e2:	00003517          	auipc	a0,0x3
ffffffffc02035e6:	07e50513          	addi	a0,a0,126 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc02035ea:	ea5fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02035ee <pgdir_alloc_page>:
{
ffffffffc02035ee:	7179                	addi	sp,sp,-48
ffffffffc02035f0:	ec26                	sd	s1,24(sp)
ffffffffc02035f2:	e84a                	sd	s2,16(sp)
ffffffffc02035f4:	e052                	sd	s4,0(sp)
ffffffffc02035f6:	f406                	sd	ra,40(sp)
ffffffffc02035f8:	f022                	sd	s0,32(sp)
ffffffffc02035fa:	e44e                	sd	s3,8(sp)
ffffffffc02035fc:	8a2a                	mv	s4,a0
ffffffffc02035fe:	84ae                	mv	s1,a1
ffffffffc0203600:	8932                	mv	s2,a2
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203602:	100027f3          	csrr	a5,sstatus
ffffffffc0203606:	8b89                	andi	a5,a5,2
        page = pmm_manager->alloc_pages(n);
ffffffffc0203608:	000b2997          	auipc	s3,0xb2
ffffffffc020360c:	19898993          	addi	s3,s3,408 # ffffffffc02b57a0 <pmm_manager>
ffffffffc0203610:	ef8d                	bnez	a5,ffffffffc020364a <pgdir_alloc_page+0x5c>
ffffffffc0203612:	0009b783          	ld	a5,0(s3)
ffffffffc0203616:	4505                	li	a0,1
ffffffffc0203618:	6f9c                	ld	a5,24(a5)
ffffffffc020361a:	9782                	jalr	a5
ffffffffc020361c:	842a                	mv	s0,a0
    if (page != NULL)
ffffffffc020361e:	cc09                	beqz	s0,ffffffffc0203638 <pgdir_alloc_page+0x4a>
        if (page_insert(pgdir, page, la, perm) != 0)
ffffffffc0203620:	86ca                	mv	a3,s2
ffffffffc0203622:	8626                	mv	a2,s1
ffffffffc0203624:	85a2                	mv	a1,s0
ffffffffc0203626:	8552                	mv	a0,s4
ffffffffc0203628:	830ff0ef          	jal	ra,ffffffffc0202658 <page_insert>
ffffffffc020362c:	e915                	bnez	a0,ffffffffc0203660 <pgdir_alloc_page+0x72>
        assert(page_ref(page) == 1);
ffffffffc020362e:	4018                	lw	a4,0(s0)
        page->pra_vaddr = la;
ffffffffc0203630:	fc04                	sd	s1,56(s0)
        assert(page_ref(page) == 1);
ffffffffc0203632:	4785                	li	a5,1
ffffffffc0203634:	04f71e63          	bne	a4,a5,ffffffffc0203690 <pgdir_alloc_page+0xa2>
}
ffffffffc0203638:	70a2                	ld	ra,40(sp)
ffffffffc020363a:	8522                	mv	a0,s0
ffffffffc020363c:	7402                	ld	s0,32(sp)
ffffffffc020363e:	64e2                	ld	s1,24(sp)
ffffffffc0203640:	6942                	ld	s2,16(sp)
ffffffffc0203642:	69a2                	ld	s3,8(sp)
ffffffffc0203644:	6a02                	ld	s4,0(sp)
ffffffffc0203646:	6145                	addi	sp,sp,48
ffffffffc0203648:	8082                	ret
        intr_disable();
ffffffffc020364a:	b6afd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        page = pmm_manager->alloc_pages(n);
ffffffffc020364e:	0009b783          	ld	a5,0(s3)
ffffffffc0203652:	4505                	li	a0,1
ffffffffc0203654:	6f9c                	ld	a5,24(a5)
ffffffffc0203656:	9782                	jalr	a5
ffffffffc0203658:	842a                	mv	s0,a0
        intr_enable();
ffffffffc020365a:	b54fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020365e:	b7c1                	j	ffffffffc020361e <pgdir_alloc_page+0x30>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203660:	100027f3          	csrr	a5,sstatus
ffffffffc0203664:	8b89                	andi	a5,a5,2
ffffffffc0203666:	eb89                	bnez	a5,ffffffffc0203678 <pgdir_alloc_page+0x8a>
        pmm_manager->free_pages(base, n);
ffffffffc0203668:	0009b783          	ld	a5,0(s3)
ffffffffc020366c:	8522                	mv	a0,s0
ffffffffc020366e:	4585                	li	a1,1
ffffffffc0203670:	739c                	ld	a5,32(a5)
            return NULL;
ffffffffc0203672:	4401                	li	s0,0
        pmm_manager->free_pages(base, n);
ffffffffc0203674:	9782                	jalr	a5
    if (flag)
ffffffffc0203676:	b7c9                	j	ffffffffc0203638 <pgdir_alloc_page+0x4a>
        intr_disable();
ffffffffc0203678:	b3cfd0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
ffffffffc020367c:	0009b783          	ld	a5,0(s3)
ffffffffc0203680:	8522                	mv	a0,s0
ffffffffc0203682:	4585                	li	a1,1
ffffffffc0203684:	739c                	ld	a5,32(a5)
            return NULL;
ffffffffc0203686:	4401                	li	s0,0
        pmm_manager->free_pages(base, n);
ffffffffc0203688:	9782                	jalr	a5
        intr_enable();
ffffffffc020368a:	b24fd0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc020368e:	b76d                	j	ffffffffc0203638 <pgdir_alloc_page+0x4a>
        assert(page_ref(page) == 1);
ffffffffc0203690:	00003697          	auipc	a3,0x3
ffffffffc0203694:	5f068693          	addi	a3,a3,1520 # ffffffffc0206c80 <default_pmm_manager+0x770>
ffffffffc0203698:	00003617          	auipc	a2,0x3
ffffffffc020369c:	ac860613          	addi	a2,a2,-1336 # ffffffffc0206160 <commands+0x828>
ffffffffc02036a0:	1fa00593          	li	a1,506
ffffffffc02036a4:	00003517          	auipc	a0,0x3
ffffffffc02036a8:	fbc50513          	addi	a0,a0,-68 # ffffffffc0206660 <default_pmm_manager+0x150>
ffffffffc02036ac:	de3fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02036b0 <check_vma_overlap.part.0>:
    return vma;
}

// check_vma_overlap - check if vma1 overlaps vma2 ?
static inline void
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
ffffffffc02036b0:	1141                	addi	sp,sp,-16
{
    assert(prev->vm_start < prev->vm_end);
    assert(prev->vm_end <= next->vm_start);
    assert(next->vm_start < next->vm_end);
ffffffffc02036b2:	00003697          	auipc	a3,0x3
ffffffffc02036b6:	5e668693          	addi	a3,a3,1510 # ffffffffc0206c98 <default_pmm_manager+0x788>
ffffffffc02036ba:	00003617          	auipc	a2,0x3
ffffffffc02036be:	aa660613          	addi	a2,a2,-1370 # ffffffffc0206160 <commands+0x828>
ffffffffc02036c2:	07400593          	li	a1,116
ffffffffc02036c6:	00003517          	auipc	a0,0x3
ffffffffc02036ca:	5f250513          	addi	a0,a0,1522 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
check_vma_overlap(struct vma_struct *prev, struct vma_struct *next)
ffffffffc02036ce:	e406                	sd	ra,8(sp)
    assert(next->vm_start < next->vm_end);
ffffffffc02036d0:	dbffc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02036d4 <mm_create>:
{
ffffffffc02036d4:	1141                	addi	sp,sp,-16
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc02036d6:	04000513          	li	a0,64
{
ffffffffc02036da:	e406                	sd	ra,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc02036dc:	df6fe0ef          	jal	ra,ffffffffc0201cd2 <kmalloc>
    if (mm != NULL)
ffffffffc02036e0:	cd19                	beqz	a0,ffffffffc02036fe <mm_create+0x2a>
    elm->prev = elm->next = elm;
ffffffffc02036e2:	e508                	sd	a0,8(a0)
ffffffffc02036e4:	e108                	sd	a0,0(a0)
        mm->mmap_cache = NULL;
ffffffffc02036e6:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc02036ea:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc02036ee:	02052023          	sw	zero,32(a0)
        mm->sm_priv = NULL;
ffffffffc02036f2:	02053423          	sd	zero,40(a0)
}

static inline void
set_mm_count(struct mm_struct *mm, int val)
{
    mm->mm_count = val;
ffffffffc02036f6:	02052823          	sw	zero,48(a0)
typedef volatile bool lock_t;

static inline void
lock_init(lock_t *lock)
{
    *lock = 0;
ffffffffc02036fa:	02053c23          	sd	zero,56(a0)
}
ffffffffc02036fe:	60a2                	ld	ra,8(sp)
ffffffffc0203700:	0141                	addi	sp,sp,16
ffffffffc0203702:	8082                	ret

ffffffffc0203704 <find_vma>:
{
ffffffffc0203704:	86aa                	mv	a3,a0
    if (mm != NULL)
ffffffffc0203706:	c505                	beqz	a0,ffffffffc020372e <find_vma+0x2a>
        vma = mm->mmap_cache;
ffffffffc0203708:	6908                	ld	a0,16(a0)
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr))
ffffffffc020370a:	c501                	beqz	a0,ffffffffc0203712 <find_vma+0xe>
ffffffffc020370c:	651c                	ld	a5,8(a0)
ffffffffc020370e:	02f5f263          	bgeu	a1,a5,ffffffffc0203732 <find_vma+0x2e>
    return listelm->next;
ffffffffc0203712:	669c                	ld	a5,8(a3)
            while ((le = list_next(le)) != list)
ffffffffc0203714:	00f68d63          	beq	a3,a5,ffffffffc020372e <find_vma+0x2a>
                if (vma->vm_start <= addr && addr < vma->vm_end)
ffffffffc0203718:	fe87b703          	ld	a4,-24(a5) # 1fffe8 <_binary_obj___user_exit_out_size+0x1f4ec0>
ffffffffc020371c:	00e5e663          	bltu	a1,a4,ffffffffc0203728 <find_vma+0x24>
ffffffffc0203720:	ff07b703          	ld	a4,-16(a5)
ffffffffc0203724:	00e5ec63          	bltu	a1,a4,ffffffffc020373c <find_vma+0x38>
ffffffffc0203728:	679c                	ld	a5,8(a5)
            while ((le = list_next(le)) != list)
ffffffffc020372a:	fef697e3          	bne	a3,a5,ffffffffc0203718 <find_vma+0x14>
    struct vma_struct *vma = NULL;
ffffffffc020372e:	4501                	li	a0,0
}
ffffffffc0203730:	8082                	ret
        if (!(vma != NULL && vma->vm_start <= addr && vma->vm_end > addr))
ffffffffc0203732:	691c                	ld	a5,16(a0)
ffffffffc0203734:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0203712 <find_vma+0xe>
            mm->mmap_cache = vma;
ffffffffc0203738:	ea88                	sd	a0,16(a3)
ffffffffc020373a:	8082                	ret
                vma = le2vma(le, list_link);
ffffffffc020373c:	fe078513          	addi	a0,a5,-32
            mm->mmap_cache = vma;
ffffffffc0203740:	ea88                	sd	a0,16(a3)
ffffffffc0203742:	8082                	ret

ffffffffc0203744 <insert_vma_struct>:
}

// insert_vma_struct -insert vma in mm's list link
void insert_vma_struct(struct mm_struct *mm, struct vma_struct *vma)
{
    assert(vma->vm_start < vma->vm_end);
ffffffffc0203744:	6590                	ld	a2,8(a1)
ffffffffc0203746:	0105b803          	ld	a6,16(a1) # 80010 <_binary_obj___user_exit_out_size+0x74ee8>
{
ffffffffc020374a:	1141                	addi	sp,sp,-16
ffffffffc020374c:	e406                	sd	ra,8(sp)
ffffffffc020374e:	87aa                	mv	a5,a0
    assert(vma->vm_start < vma->vm_end);
ffffffffc0203750:	01066763          	bltu	a2,a6,ffffffffc020375e <insert_vma_struct+0x1a>
ffffffffc0203754:	a085                	j	ffffffffc02037b4 <insert_vma_struct+0x70>

    list_entry_t *le = list;
    while ((le = list_next(le)) != list)
    {
        struct vma_struct *mmap_prev = le2vma(le, list_link);
        if (mmap_prev->vm_start > vma->vm_start)
ffffffffc0203756:	fe87b703          	ld	a4,-24(a5)
ffffffffc020375a:	04e66863          	bltu	a2,a4,ffffffffc02037aa <insert_vma_struct+0x66>
ffffffffc020375e:	86be                	mv	a3,a5
ffffffffc0203760:	679c                	ld	a5,8(a5)
    while ((le = list_next(le)) != list)
ffffffffc0203762:	fef51ae3          	bne	a0,a5,ffffffffc0203756 <insert_vma_struct+0x12>
    }

    le_next = list_next(le_prev);

    /* check overlap */
    if (le_prev != list)
ffffffffc0203766:	02a68463          	beq	a3,a0,ffffffffc020378e <insert_vma_struct+0x4a>
    {
        check_vma_overlap(le2vma(le_prev, list_link), vma);
ffffffffc020376a:	ff06b703          	ld	a4,-16(a3)
    assert(prev->vm_start < prev->vm_end);
ffffffffc020376e:	fe86b883          	ld	a7,-24(a3)
ffffffffc0203772:	08e8f163          	bgeu	a7,a4,ffffffffc02037f4 <insert_vma_struct+0xb0>
    assert(prev->vm_end <= next->vm_start);
ffffffffc0203776:	04e66f63          	bltu	a2,a4,ffffffffc02037d4 <insert_vma_struct+0x90>
    }
    if (le_next != list)
ffffffffc020377a:	00f50a63          	beq	a0,a5,ffffffffc020378e <insert_vma_struct+0x4a>
        if (mmap_prev->vm_start > vma->vm_start)
ffffffffc020377e:	fe87b703          	ld	a4,-24(a5)
    assert(prev->vm_end <= next->vm_start);
ffffffffc0203782:	05076963          	bltu	a4,a6,ffffffffc02037d4 <insert_vma_struct+0x90>
    assert(next->vm_start < next->vm_end);
ffffffffc0203786:	ff07b603          	ld	a2,-16(a5)
ffffffffc020378a:	02c77363          	bgeu	a4,a2,ffffffffc02037b0 <insert_vma_struct+0x6c>
    }

    vma->vm_mm = mm;
    list_add_after(le_prev, &(vma->list_link));

    mm->map_count++;
ffffffffc020378e:	5118                	lw	a4,32(a0)
    vma->vm_mm = mm;
ffffffffc0203790:	e188                	sd	a0,0(a1)
    list_add_after(le_prev, &(vma->list_link));
ffffffffc0203792:	02058613          	addi	a2,a1,32
    prev->next = next->prev = elm;
ffffffffc0203796:	e390                	sd	a2,0(a5)
ffffffffc0203798:	e690                	sd	a2,8(a3)
}
ffffffffc020379a:	60a2                	ld	ra,8(sp)
    elm->next = next;
ffffffffc020379c:	f59c                	sd	a5,40(a1)
    elm->prev = prev;
ffffffffc020379e:	f194                	sd	a3,32(a1)
    mm->map_count++;
ffffffffc02037a0:	0017079b          	addiw	a5,a4,1
ffffffffc02037a4:	d11c                	sw	a5,32(a0)
}
ffffffffc02037a6:	0141                	addi	sp,sp,16
ffffffffc02037a8:	8082                	ret
    if (le_prev != list)
ffffffffc02037aa:	fca690e3          	bne	a3,a0,ffffffffc020376a <insert_vma_struct+0x26>
ffffffffc02037ae:	bfd1                	j	ffffffffc0203782 <insert_vma_struct+0x3e>
ffffffffc02037b0:	f01ff0ef          	jal	ra,ffffffffc02036b0 <check_vma_overlap.part.0>
    assert(vma->vm_start < vma->vm_end);
ffffffffc02037b4:	00003697          	auipc	a3,0x3
ffffffffc02037b8:	51468693          	addi	a3,a3,1300 # ffffffffc0206cc8 <default_pmm_manager+0x7b8>
ffffffffc02037bc:	00003617          	auipc	a2,0x3
ffffffffc02037c0:	9a460613          	addi	a2,a2,-1628 # ffffffffc0206160 <commands+0x828>
ffffffffc02037c4:	07a00593          	li	a1,122
ffffffffc02037c8:	00003517          	auipc	a0,0x3
ffffffffc02037cc:	4f050513          	addi	a0,a0,1264 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc02037d0:	cbffc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(prev->vm_end <= next->vm_start);
ffffffffc02037d4:	00003697          	auipc	a3,0x3
ffffffffc02037d8:	53468693          	addi	a3,a3,1332 # ffffffffc0206d08 <default_pmm_manager+0x7f8>
ffffffffc02037dc:	00003617          	auipc	a2,0x3
ffffffffc02037e0:	98460613          	addi	a2,a2,-1660 # ffffffffc0206160 <commands+0x828>
ffffffffc02037e4:	07300593          	li	a1,115
ffffffffc02037e8:	00003517          	auipc	a0,0x3
ffffffffc02037ec:	4d050513          	addi	a0,a0,1232 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc02037f0:	c9ffc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(prev->vm_start < prev->vm_end);
ffffffffc02037f4:	00003697          	auipc	a3,0x3
ffffffffc02037f8:	4f468693          	addi	a3,a3,1268 # ffffffffc0206ce8 <default_pmm_manager+0x7d8>
ffffffffc02037fc:	00003617          	auipc	a2,0x3
ffffffffc0203800:	96460613          	addi	a2,a2,-1692 # ffffffffc0206160 <commands+0x828>
ffffffffc0203804:	07200593          	li	a1,114
ffffffffc0203808:	00003517          	auipc	a0,0x3
ffffffffc020380c:	4b050513          	addi	a0,a0,1200 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc0203810:	c7ffc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203814 <mm_destroy>:

// mm_destroy - free mm and mm internal fields
void mm_destroy(struct mm_struct *mm)
{
    assert(mm_count(mm) == 0);
ffffffffc0203814:	591c                	lw	a5,48(a0)
{
ffffffffc0203816:	1141                	addi	sp,sp,-16
ffffffffc0203818:	e406                	sd	ra,8(sp)
ffffffffc020381a:	e022                	sd	s0,0(sp)
    assert(mm_count(mm) == 0);
ffffffffc020381c:	e78d                	bnez	a5,ffffffffc0203846 <mm_destroy+0x32>
ffffffffc020381e:	842a                	mv	s0,a0
    return listelm->next;
ffffffffc0203820:	6508                	ld	a0,8(a0)

    list_entry_t *list = &(mm->mmap_list), *le;
    while ((le = list_next(list)) != list)
ffffffffc0203822:	00a40c63          	beq	s0,a0,ffffffffc020383a <mm_destroy+0x26>
    __list_del(listelm->prev, listelm->next);
ffffffffc0203826:	6118                	ld	a4,0(a0)
ffffffffc0203828:	651c                	ld	a5,8(a0)
    {
        list_del(le);
        kfree(le2vma(le, list_link)); // kfree vma
ffffffffc020382a:	1501                	addi	a0,a0,-32
    prev->next = next;
ffffffffc020382c:	e71c                	sd	a5,8(a4)
    next->prev = prev;
ffffffffc020382e:	e398                	sd	a4,0(a5)
ffffffffc0203830:	d52fe0ef          	jal	ra,ffffffffc0201d82 <kfree>
    return listelm->next;
ffffffffc0203834:	6408                	ld	a0,8(s0)
    while ((le = list_next(list)) != list)
ffffffffc0203836:	fea418e3          	bne	s0,a0,ffffffffc0203826 <mm_destroy+0x12>
    }
    kfree(mm); // kfree mm
ffffffffc020383a:	8522                	mv	a0,s0
    mm = NULL;
}
ffffffffc020383c:	6402                	ld	s0,0(sp)
ffffffffc020383e:	60a2                	ld	ra,8(sp)
ffffffffc0203840:	0141                	addi	sp,sp,16
    kfree(mm); // kfree mm
ffffffffc0203842:	d40fe06f          	j	ffffffffc0201d82 <kfree>
    assert(mm_count(mm) == 0);
ffffffffc0203846:	00003697          	auipc	a3,0x3
ffffffffc020384a:	4e268693          	addi	a3,a3,1250 # ffffffffc0206d28 <default_pmm_manager+0x818>
ffffffffc020384e:	00003617          	auipc	a2,0x3
ffffffffc0203852:	91260613          	addi	a2,a2,-1774 # ffffffffc0206160 <commands+0x828>
ffffffffc0203856:	09e00593          	li	a1,158
ffffffffc020385a:	00003517          	auipc	a0,0x3
ffffffffc020385e:	45e50513          	addi	a0,a0,1118 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc0203862:	c2dfc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203866 <mm_map>:

int mm_map(struct mm_struct *mm, uintptr_t addr, size_t len, uint32_t vm_flags,
           struct vma_struct **vma_store)
{
ffffffffc0203866:	7139                	addi	sp,sp,-64
ffffffffc0203868:	f822                	sd	s0,48(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc020386a:	6405                	lui	s0,0x1
ffffffffc020386c:	147d                	addi	s0,s0,-1
ffffffffc020386e:	77fd                	lui	a5,0xfffff
ffffffffc0203870:	9622                	add	a2,a2,s0
ffffffffc0203872:	962e                	add	a2,a2,a1
{
ffffffffc0203874:	f426                	sd	s1,40(sp)
ffffffffc0203876:	fc06                	sd	ra,56(sp)
    uintptr_t start = ROUNDDOWN(addr, PGSIZE), end = ROUNDUP(addr + len, PGSIZE);
ffffffffc0203878:	00f5f4b3          	and	s1,a1,a5
{
ffffffffc020387c:	f04a                	sd	s2,32(sp)
ffffffffc020387e:	ec4e                	sd	s3,24(sp)
ffffffffc0203880:	e852                	sd	s4,16(sp)
ffffffffc0203882:	e456                	sd	s5,8(sp)
    if (!USER_ACCESS(start, end))
ffffffffc0203884:	002005b7          	lui	a1,0x200
ffffffffc0203888:	00f67433          	and	s0,a2,a5
ffffffffc020388c:	06b4e363          	bltu	s1,a1,ffffffffc02038f2 <mm_map+0x8c>
ffffffffc0203890:	0684f163          	bgeu	s1,s0,ffffffffc02038f2 <mm_map+0x8c>
ffffffffc0203894:	4785                	li	a5,1
ffffffffc0203896:	07fe                	slli	a5,a5,0x1f
ffffffffc0203898:	0487ed63          	bltu	a5,s0,ffffffffc02038f2 <mm_map+0x8c>
ffffffffc020389c:	89aa                	mv	s3,a0
    {
        return -E_INVAL;
    }

    assert(mm != NULL);
ffffffffc020389e:	cd21                	beqz	a0,ffffffffc02038f6 <mm_map+0x90>

    int ret = -E_INVAL;

    struct vma_struct *vma;
    if ((vma = find_vma(mm, start)) != NULL && end > vma->vm_start)
ffffffffc02038a0:	85a6                	mv	a1,s1
ffffffffc02038a2:	8ab6                	mv	s5,a3
ffffffffc02038a4:	8a3a                	mv	s4,a4
ffffffffc02038a6:	e5fff0ef          	jal	ra,ffffffffc0203704 <find_vma>
ffffffffc02038aa:	c501                	beqz	a0,ffffffffc02038b2 <mm_map+0x4c>
ffffffffc02038ac:	651c                	ld	a5,8(a0)
ffffffffc02038ae:	0487e263          	bltu	a5,s0,ffffffffc02038f2 <mm_map+0x8c>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc02038b2:	03000513          	li	a0,48
ffffffffc02038b6:	c1cfe0ef          	jal	ra,ffffffffc0201cd2 <kmalloc>
ffffffffc02038ba:	892a                	mv	s2,a0
    {
        goto out;
    }
    ret = -E_NO_MEM;
ffffffffc02038bc:	5571                	li	a0,-4
    if (vma != NULL)
ffffffffc02038be:	02090163          	beqz	s2,ffffffffc02038e0 <mm_map+0x7a>

    if ((vma = vma_create(start, end, vm_flags)) == NULL)
    {
        goto out;
    }
    insert_vma_struct(mm, vma);
ffffffffc02038c2:	854e                	mv	a0,s3
        vma->vm_start = vm_start;
ffffffffc02038c4:	00993423          	sd	s1,8(s2)
        vma->vm_end = vm_end;
ffffffffc02038c8:	00893823          	sd	s0,16(s2)
        vma->vm_flags = vm_flags;
ffffffffc02038cc:	01592c23          	sw	s5,24(s2)
    insert_vma_struct(mm, vma);
ffffffffc02038d0:	85ca                	mv	a1,s2
ffffffffc02038d2:	e73ff0ef          	jal	ra,ffffffffc0203744 <insert_vma_struct>
    if (vma_store != NULL)
    {
        *vma_store = vma;
    }
    ret = 0;
ffffffffc02038d6:	4501                	li	a0,0
    if (vma_store != NULL)
ffffffffc02038d8:	000a0463          	beqz	s4,ffffffffc02038e0 <mm_map+0x7a>
        *vma_store = vma;
ffffffffc02038dc:	012a3023          	sd	s2,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8bb0>

out:
    return ret;
}
ffffffffc02038e0:	70e2                	ld	ra,56(sp)
ffffffffc02038e2:	7442                	ld	s0,48(sp)
ffffffffc02038e4:	74a2                	ld	s1,40(sp)
ffffffffc02038e6:	7902                	ld	s2,32(sp)
ffffffffc02038e8:	69e2                	ld	s3,24(sp)
ffffffffc02038ea:	6a42                	ld	s4,16(sp)
ffffffffc02038ec:	6aa2                	ld	s5,8(sp)
ffffffffc02038ee:	6121                	addi	sp,sp,64
ffffffffc02038f0:	8082                	ret
        return -E_INVAL;
ffffffffc02038f2:	5575                	li	a0,-3
ffffffffc02038f4:	b7f5                	j	ffffffffc02038e0 <mm_map+0x7a>
    assert(mm != NULL);
ffffffffc02038f6:	00003697          	auipc	a3,0x3
ffffffffc02038fa:	44a68693          	addi	a3,a3,1098 # ffffffffc0206d40 <default_pmm_manager+0x830>
ffffffffc02038fe:	00003617          	auipc	a2,0x3
ffffffffc0203902:	86260613          	addi	a2,a2,-1950 # ffffffffc0206160 <commands+0x828>
ffffffffc0203906:	0b300593          	li	a1,179
ffffffffc020390a:	00003517          	auipc	a0,0x3
ffffffffc020390e:	3ae50513          	addi	a0,a0,942 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc0203912:	b7dfc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203916 <dup_mmap>:

int dup_mmap(struct mm_struct *to, struct mm_struct *from)
{
ffffffffc0203916:	7139                	addi	sp,sp,-64
ffffffffc0203918:	fc06                	sd	ra,56(sp)
ffffffffc020391a:	f822                	sd	s0,48(sp)
ffffffffc020391c:	f426                	sd	s1,40(sp)
ffffffffc020391e:	f04a                	sd	s2,32(sp)
ffffffffc0203920:	ec4e                	sd	s3,24(sp)
ffffffffc0203922:	e852                	sd	s4,16(sp)
ffffffffc0203924:	e456                	sd	s5,8(sp)
    assert(to != NULL && from != NULL);
ffffffffc0203926:	c52d                	beqz	a0,ffffffffc0203990 <dup_mmap+0x7a>
ffffffffc0203928:	892a                	mv	s2,a0
ffffffffc020392a:	84ae                	mv	s1,a1
    list_entry_t *list = &(from->mmap_list), *le = list;
ffffffffc020392c:	842e                	mv	s0,a1
    assert(to != NULL && from != NULL);
ffffffffc020392e:	e595                	bnez	a1,ffffffffc020395a <dup_mmap+0x44>
ffffffffc0203930:	a085                	j	ffffffffc0203990 <dup_mmap+0x7a>
        if (nvma == NULL)
        {
            return -E_NO_MEM;
        }

        insert_vma_struct(to, nvma);
ffffffffc0203932:	854a                	mv	a0,s2
        vma->vm_start = vm_start;
ffffffffc0203934:	0155b423          	sd	s5,8(a1) # 200008 <_binary_obj___user_exit_out_size+0x1f4ee0>
        vma->vm_end = vm_end;
ffffffffc0203938:	0145b823          	sd	s4,16(a1)
        vma->vm_flags = vm_flags;
ffffffffc020393c:	0135ac23          	sw	s3,24(a1)
        insert_vma_struct(to, nvma);
ffffffffc0203940:	e05ff0ef          	jal	ra,ffffffffc0203744 <insert_vma_struct>

        bool share = 0;
        if (copy_range(to->pgdir, from->pgdir, vma->vm_start, vma->vm_end, share) != 0)
ffffffffc0203944:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_obj___user_faultread_out_size-0x8bc0>
ffffffffc0203948:	fe843603          	ld	a2,-24(s0)
ffffffffc020394c:	6c8c                	ld	a1,24(s1)
ffffffffc020394e:	01893503          	ld	a0,24(s2)
ffffffffc0203952:	4701                	li	a4,0
ffffffffc0203954:	a3bff0ef          	jal	ra,ffffffffc020338e <copy_range>
ffffffffc0203958:	e105                	bnez	a0,ffffffffc0203978 <dup_mmap+0x62>
    return listelm->prev;
ffffffffc020395a:	6000                	ld	s0,0(s0)
    while ((le = list_prev(le)) != list)
ffffffffc020395c:	02848863          	beq	s1,s0,ffffffffc020398c <dup_mmap+0x76>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203960:	03000513          	li	a0,48
        nvma = vma_create(vma->vm_start, vma->vm_end, vma->vm_flags);
ffffffffc0203964:	fe843a83          	ld	s5,-24(s0)
ffffffffc0203968:	ff043a03          	ld	s4,-16(s0)
ffffffffc020396c:	ff842983          	lw	s3,-8(s0)
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203970:	b62fe0ef          	jal	ra,ffffffffc0201cd2 <kmalloc>
ffffffffc0203974:	85aa                	mv	a1,a0
    if (vma != NULL)
ffffffffc0203976:	fd55                	bnez	a0,ffffffffc0203932 <dup_mmap+0x1c>
            return -E_NO_MEM;
ffffffffc0203978:	5571                	li	a0,-4
        {
            return -E_NO_MEM;
        }
    }
    return 0;
}
ffffffffc020397a:	70e2                	ld	ra,56(sp)
ffffffffc020397c:	7442                	ld	s0,48(sp)
ffffffffc020397e:	74a2                	ld	s1,40(sp)
ffffffffc0203980:	7902                	ld	s2,32(sp)
ffffffffc0203982:	69e2                	ld	s3,24(sp)
ffffffffc0203984:	6a42                	ld	s4,16(sp)
ffffffffc0203986:	6aa2                	ld	s5,8(sp)
ffffffffc0203988:	6121                	addi	sp,sp,64
ffffffffc020398a:	8082                	ret
    return 0;
ffffffffc020398c:	4501                	li	a0,0
ffffffffc020398e:	b7f5                	j	ffffffffc020397a <dup_mmap+0x64>
    assert(to != NULL && from != NULL);
ffffffffc0203990:	00003697          	auipc	a3,0x3
ffffffffc0203994:	3c068693          	addi	a3,a3,960 # ffffffffc0206d50 <default_pmm_manager+0x840>
ffffffffc0203998:	00002617          	auipc	a2,0x2
ffffffffc020399c:	7c860613          	addi	a2,a2,1992 # ffffffffc0206160 <commands+0x828>
ffffffffc02039a0:	0cf00593          	li	a1,207
ffffffffc02039a4:	00003517          	auipc	a0,0x3
ffffffffc02039a8:	31450513          	addi	a0,a0,788 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc02039ac:	ae3fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02039b0 <exit_mmap>:

void exit_mmap(struct mm_struct *mm)
{
ffffffffc02039b0:	1101                	addi	sp,sp,-32
ffffffffc02039b2:	ec06                	sd	ra,24(sp)
ffffffffc02039b4:	e822                	sd	s0,16(sp)
ffffffffc02039b6:	e426                	sd	s1,8(sp)
ffffffffc02039b8:	e04a                	sd	s2,0(sp)
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc02039ba:	c531                	beqz	a0,ffffffffc0203a06 <exit_mmap+0x56>
ffffffffc02039bc:	591c                	lw	a5,48(a0)
ffffffffc02039be:	84aa                	mv	s1,a0
ffffffffc02039c0:	e3b9                	bnez	a5,ffffffffc0203a06 <exit_mmap+0x56>
    return listelm->next;
ffffffffc02039c2:	6500                	ld	s0,8(a0)
    pde_t *pgdir = mm->pgdir;
ffffffffc02039c4:	01853903          	ld	s2,24(a0)
    list_entry_t *list = &(mm->mmap_list), *le = list;
    while ((le = list_next(le)) != list)
ffffffffc02039c8:	02850663          	beq	a0,s0,ffffffffc02039f4 <exit_mmap+0x44>
    {
        struct vma_struct *vma = le2vma(le, list_link);
        unmap_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc02039cc:	ff043603          	ld	a2,-16(s0)
ffffffffc02039d0:	fe843583          	ld	a1,-24(s0)
ffffffffc02039d4:	854a                	mv	a0,s2
ffffffffc02039d6:	80ffe0ef          	jal	ra,ffffffffc02021e4 <unmap_range>
ffffffffc02039da:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list)
ffffffffc02039dc:	fe8498e3          	bne	s1,s0,ffffffffc02039cc <exit_mmap+0x1c>
ffffffffc02039e0:	6400                	ld	s0,8(s0)
    }
    while ((le = list_next(le)) != list)
ffffffffc02039e2:	00848c63          	beq	s1,s0,ffffffffc02039fa <exit_mmap+0x4a>
    {
        struct vma_struct *vma = le2vma(le, list_link);
        exit_range(pgdir, vma->vm_start, vma->vm_end);
ffffffffc02039e6:	ff043603          	ld	a2,-16(s0)
ffffffffc02039ea:	fe843583          	ld	a1,-24(s0)
ffffffffc02039ee:	854a                	mv	a0,s2
ffffffffc02039f0:	93bfe0ef          	jal	ra,ffffffffc020232a <exit_range>
ffffffffc02039f4:	6400                	ld	s0,8(s0)
    while ((le = list_next(le)) != list)
ffffffffc02039f6:	fe8498e3          	bne	s1,s0,ffffffffc02039e6 <exit_mmap+0x36>
    }
}
ffffffffc02039fa:	60e2                	ld	ra,24(sp)
ffffffffc02039fc:	6442                	ld	s0,16(sp)
ffffffffc02039fe:	64a2                	ld	s1,8(sp)
ffffffffc0203a00:	6902                	ld	s2,0(sp)
ffffffffc0203a02:	6105                	addi	sp,sp,32
ffffffffc0203a04:	8082                	ret
    assert(mm != NULL && mm_count(mm) == 0);
ffffffffc0203a06:	00003697          	auipc	a3,0x3
ffffffffc0203a0a:	36a68693          	addi	a3,a3,874 # ffffffffc0206d70 <default_pmm_manager+0x860>
ffffffffc0203a0e:	00002617          	auipc	a2,0x2
ffffffffc0203a12:	75260613          	addi	a2,a2,1874 # ffffffffc0206160 <commands+0x828>
ffffffffc0203a16:	0e800593          	li	a1,232
ffffffffc0203a1a:	00003517          	auipc	a0,0x3
ffffffffc0203a1e:	29e50513          	addi	a0,a0,670 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc0203a22:	a6dfc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203a26 <vmm_init>:
}

// vmm_init - initialize virtual memory management
//          - now just call check_vmm to check correctness of vmm
void vmm_init(void)
{
ffffffffc0203a26:	7139                	addi	sp,sp,-64
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0203a28:	04000513          	li	a0,64
{
ffffffffc0203a2c:	fc06                	sd	ra,56(sp)
ffffffffc0203a2e:	f822                	sd	s0,48(sp)
ffffffffc0203a30:	f426                	sd	s1,40(sp)
ffffffffc0203a32:	f04a                	sd	s2,32(sp)
ffffffffc0203a34:	ec4e                	sd	s3,24(sp)
ffffffffc0203a36:	e852                	sd	s4,16(sp)
ffffffffc0203a38:	e456                	sd	s5,8(sp)
    struct mm_struct *mm = kmalloc(sizeof(struct mm_struct));
ffffffffc0203a3a:	a98fe0ef          	jal	ra,ffffffffc0201cd2 <kmalloc>
    if (mm != NULL)
ffffffffc0203a3e:	2e050663          	beqz	a0,ffffffffc0203d2a <vmm_init+0x304>
ffffffffc0203a42:	84aa                	mv	s1,a0
    elm->prev = elm->next = elm;
ffffffffc0203a44:	e508                	sd	a0,8(a0)
ffffffffc0203a46:	e108                	sd	a0,0(a0)
        mm->mmap_cache = NULL;
ffffffffc0203a48:	00053823          	sd	zero,16(a0)
        mm->pgdir = NULL;
ffffffffc0203a4c:	00053c23          	sd	zero,24(a0)
        mm->map_count = 0;
ffffffffc0203a50:	02052023          	sw	zero,32(a0)
        mm->sm_priv = NULL;
ffffffffc0203a54:	02053423          	sd	zero,40(a0)
ffffffffc0203a58:	02052823          	sw	zero,48(a0)
ffffffffc0203a5c:	02053c23          	sd	zero,56(a0)
ffffffffc0203a60:	03200413          	li	s0,50
ffffffffc0203a64:	a811                	j	ffffffffc0203a78 <vmm_init+0x52>
        vma->vm_start = vm_start;
ffffffffc0203a66:	e500                	sd	s0,8(a0)
        vma->vm_end = vm_end;
ffffffffc0203a68:	e91c                	sd	a5,16(a0)
        vma->vm_flags = vm_flags;
ffffffffc0203a6a:	00052c23          	sw	zero,24(a0)
    assert(mm != NULL);

    int step1 = 10, step2 = step1 * 10;

    int i;
    for (i = step1; i >= 1; i--)
ffffffffc0203a6e:	146d                	addi	s0,s0,-5
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
ffffffffc0203a70:	8526                	mv	a0,s1
ffffffffc0203a72:	cd3ff0ef          	jal	ra,ffffffffc0203744 <insert_vma_struct>
    for (i = step1; i >= 1; i--)
ffffffffc0203a76:	c80d                	beqz	s0,ffffffffc0203aa8 <vmm_init+0x82>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203a78:	03000513          	li	a0,48
ffffffffc0203a7c:	a56fe0ef          	jal	ra,ffffffffc0201cd2 <kmalloc>
ffffffffc0203a80:	85aa                	mv	a1,a0
ffffffffc0203a82:	00240793          	addi	a5,s0,2
    if (vma != NULL)
ffffffffc0203a86:	f165                	bnez	a0,ffffffffc0203a66 <vmm_init+0x40>
        assert(vma != NULL);
ffffffffc0203a88:	00003697          	auipc	a3,0x3
ffffffffc0203a8c:	48068693          	addi	a3,a3,1152 # ffffffffc0206f08 <default_pmm_manager+0x9f8>
ffffffffc0203a90:	00002617          	auipc	a2,0x2
ffffffffc0203a94:	6d060613          	addi	a2,a2,1744 # ffffffffc0206160 <commands+0x828>
ffffffffc0203a98:	18d00593          	li	a1,397
ffffffffc0203a9c:	00003517          	auipc	a0,0x3
ffffffffc0203aa0:	21c50513          	addi	a0,a0,540 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc0203aa4:	9ebfc0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc0203aa8:	03700413          	li	s0,55
    }

    for (i = step1 + 1; i <= step2; i++)
ffffffffc0203aac:	1f900913          	li	s2,505
ffffffffc0203ab0:	a819                	j	ffffffffc0203ac6 <vmm_init+0xa0>
        vma->vm_start = vm_start;
ffffffffc0203ab2:	e500                	sd	s0,8(a0)
        vma->vm_end = vm_end;
ffffffffc0203ab4:	e91c                	sd	a5,16(a0)
        vma->vm_flags = vm_flags;
ffffffffc0203ab6:	00052c23          	sw	zero,24(a0)
    for (i = step1 + 1; i <= step2; i++)
ffffffffc0203aba:	0415                	addi	s0,s0,5
    {
        struct vma_struct *vma = vma_create(i * 5, i * 5 + 2, 0);
        assert(vma != NULL);
        insert_vma_struct(mm, vma);
ffffffffc0203abc:	8526                	mv	a0,s1
ffffffffc0203abe:	c87ff0ef          	jal	ra,ffffffffc0203744 <insert_vma_struct>
    for (i = step1 + 1; i <= step2; i++)
ffffffffc0203ac2:	03240a63          	beq	s0,s2,ffffffffc0203af6 <vmm_init+0xd0>
    struct vma_struct *vma = kmalloc(sizeof(struct vma_struct));
ffffffffc0203ac6:	03000513          	li	a0,48
ffffffffc0203aca:	a08fe0ef          	jal	ra,ffffffffc0201cd2 <kmalloc>
ffffffffc0203ace:	85aa                	mv	a1,a0
ffffffffc0203ad0:	00240793          	addi	a5,s0,2
    if (vma != NULL)
ffffffffc0203ad4:	fd79                	bnez	a0,ffffffffc0203ab2 <vmm_init+0x8c>
        assert(vma != NULL);
ffffffffc0203ad6:	00003697          	auipc	a3,0x3
ffffffffc0203ada:	43268693          	addi	a3,a3,1074 # ffffffffc0206f08 <default_pmm_manager+0x9f8>
ffffffffc0203ade:	00002617          	auipc	a2,0x2
ffffffffc0203ae2:	68260613          	addi	a2,a2,1666 # ffffffffc0206160 <commands+0x828>
ffffffffc0203ae6:	19400593          	li	a1,404
ffffffffc0203aea:	00003517          	auipc	a0,0x3
ffffffffc0203aee:	1ce50513          	addi	a0,a0,462 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc0203af2:	99dfc0ef          	jal	ra,ffffffffc020048e <__panic>
    return listelm->next;
ffffffffc0203af6:	649c                	ld	a5,8(s1)
ffffffffc0203af8:	471d                	li	a4,7
    }

    list_entry_t *le = list_next(&(mm->mmap_list));

    for (i = 1; i <= step2; i++)
ffffffffc0203afa:	1fb00593          	li	a1,507
    {
        assert(le != &(mm->mmap_list));
ffffffffc0203afe:	16f48663          	beq	s1,a5,ffffffffc0203c6a <vmm_init+0x244>
        struct vma_struct *mmap = le2vma(le, list_link);
        assert(mmap->vm_start == i * 5 && mmap->vm_end == i * 5 + 2);
ffffffffc0203b02:	fe87b603          	ld	a2,-24(a5) # ffffffffffffefe8 <end+0x3fd4981c>
ffffffffc0203b06:	ffe70693          	addi	a3,a4,-2
ffffffffc0203b0a:	10d61063          	bne	a2,a3,ffffffffc0203c0a <vmm_init+0x1e4>
ffffffffc0203b0e:	ff07b683          	ld	a3,-16(a5)
ffffffffc0203b12:	0ed71c63          	bne	a4,a3,ffffffffc0203c0a <vmm_init+0x1e4>
    for (i = 1; i <= step2; i++)
ffffffffc0203b16:	0715                	addi	a4,a4,5
ffffffffc0203b18:	679c                	ld	a5,8(a5)
ffffffffc0203b1a:	feb712e3          	bne	a4,a1,ffffffffc0203afe <vmm_init+0xd8>
ffffffffc0203b1e:	4a1d                	li	s4,7
ffffffffc0203b20:	4415                	li	s0,5
        le = list_next(le);
    }

    for (i = 5; i <= 5 * step2; i += 5)
ffffffffc0203b22:	1f900a93          	li	s5,505
    {
        struct vma_struct *vma1 = find_vma(mm, i);
ffffffffc0203b26:	85a2                	mv	a1,s0
ffffffffc0203b28:	8526                	mv	a0,s1
ffffffffc0203b2a:	bdbff0ef          	jal	ra,ffffffffc0203704 <find_vma>
ffffffffc0203b2e:	892a                	mv	s2,a0
        assert(vma1 != NULL);
ffffffffc0203b30:	16050d63          	beqz	a0,ffffffffc0203caa <vmm_init+0x284>
        struct vma_struct *vma2 = find_vma(mm, i + 1);
ffffffffc0203b34:	00140593          	addi	a1,s0,1
ffffffffc0203b38:	8526                	mv	a0,s1
ffffffffc0203b3a:	bcbff0ef          	jal	ra,ffffffffc0203704 <find_vma>
ffffffffc0203b3e:	89aa                	mv	s3,a0
        assert(vma2 != NULL);
ffffffffc0203b40:	14050563          	beqz	a0,ffffffffc0203c8a <vmm_init+0x264>
        struct vma_struct *vma3 = find_vma(mm, i + 2);
ffffffffc0203b44:	85d2                	mv	a1,s4
ffffffffc0203b46:	8526                	mv	a0,s1
ffffffffc0203b48:	bbdff0ef          	jal	ra,ffffffffc0203704 <find_vma>
        assert(vma3 == NULL);
ffffffffc0203b4c:	16051f63          	bnez	a0,ffffffffc0203cca <vmm_init+0x2a4>
        struct vma_struct *vma4 = find_vma(mm, i + 3);
ffffffffc0203b50:	00340593          	addi	a1,s0,3
ffffffffc0203b54:	8526                	mv	a0,s1
ffffffffc0203b56:	bafff0ef          	jal	ra,ffffffffc0203704 <find_vma>
        assert(vma4 == NULL);
ffffffffc0203b5a:	1a051863          	bnez	a0,ffffffffc0203d0a <vmm_init+0x2e4>
        struct vma_struct *vma5 = find_vma(mm, i + 4);
ffffffffc0203b5e:	00440593          	addi	a1,s0,4
ffffffffc0203b62:	8526                	mv	a0,s1
ffffffffc0203b64:	ba1ff0ef          	jal	ra,ffffffffc0203704 <find_vma>
        assert(vma5 == NULL);
ffffffffc0203b68:	18051163          	bnez	a0,ffffffffc0203cea <vmm_init+0x2c4>

        assert(vma1->vm_start == i && vma1->vm_end == i + 2);
ffffffffc0203b6c:	00893783          	ld	a5,8(s2)
ffffffffc0203b70:	0a879d63          	bne	a5,s0,ffffffffc0203c2a <vmm_init+0x204>
ffffffffc0203b74:	01093783          	ld	a5,16(s2)
ffffffffc0203b78:	0b479963          	bne	a5,s4,ffffffffc0203c2a <vmm_init+0x204>
        assert(vma2->vm_start == i && vma2->vm_end == i + 2);
ffffffffc0203b7c:	0089b783          	ld	a5,8(s3)
ffffffffc0203b80:	0c879563          	bne	a5,s0,ffffffffc0203c4a <vmm_init+0x224>
ffffffffc0203b84:	0109b783          	ld	a5,16(s3)
ffffffffc0203b88:	0d479163          	bne	a5,s4,ffffffffc0203c4a <vmm_init+0x224>
    for (i = 5; i <= 5 * step2; i += 5)
ffffffffc0203b8c:	0415                	addi	s0,s0,5
ffffffffc0203b8e:	0a15                	addi	s4,s4,5
ffffffffc0203b90:	f9541be3          	bne	s0,s5,ffffffffc0203b26 <vmm_init+0x100>
ffffffffc0203b94:	4411                	li	s0,4
    }

    for (i = 4; i >= 0; i--)
ffffffffc0203b96:	597d                	li	s2,-1
    {
        struct vma_struct *vma_below_5 = find_vma(mm, i);
ffffffffc0203b98:	85a2                	mv	a1,s0
ffffffffc0203b9a:	8526                	mv	a0,s1
ffffffffc0203b9c:	b69ff0ef          	jal	ra,ffffffffc0203704 <find_vma>
ffffffffc0203ba0:	0004059b          	sext.w	a1,s0
        if (vma_below_5 != NULL)
ffffffffc0203ba4:	c90d                	beqz	a0,ffffffffc0203bd6 <vmm_init+0x1b0>
        {
            cprintf("vma_below_5: i %x, start %x, end %x\n", i, vma_below_5->vm_start, vma_below_5->vm_end);
ffffffffc0203ba6:	6914                	ld	a3,16(a0)
ffffffffc0203ba8:	6510                	ld	a2,8(a0)
ffffffffc0203baa:	00003517          	auipc	a0,0x3
ffffffffc0203bae:	2e650513          	addi	a0,a0,742 # ffffffffc0206e90 <default_pmm_manager+0x980>
ffffffffc0203bb2:	de2fc0ef          	jal	ra,ffffffffc0200194 <cprintf>
        }
        assert(vma_below_5 == NULL);
ffffffffc0203bb6:	00003697          	auipc	a3,0x3
ffffffffc0203bba:	30268693          	addi	a3,a3,770 # ffffffffc0206eb8 <default_pmm_manager+0x9a8>
ffffffffc0203bbe:	00002617          	auipc	a2,0x2
ffffffffc0203bc2:	5a260613          	addi	a2,a2,1442 # ffffffffc0206160 <commands+0x828>
ffffffffc0203bc6:	1ba00593          	li	a1,442
ffffffffc0203bca:	00003517          	auipc	a0,0x3
ffffffffc0203bce:	0ee50513          	addi	a0,a0,238 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc0203bd2:	8bdfc0ef          	jal	ra,ffffffffc020048e <__panic>
    for (i = 4; i >= 0; i--)
ffffffffc0203bd6:	147d                	addi	s0,s0,-1
ffffffffc0203bd8:	fd2410e3          	bne	s0,s2,ffffffffc0203b98 <vmm_init+0x172>
    }

    mm_destroy(mm);
ffffffffc0203bdc:	8526                	mv	a0,s1
ffffffffc0203bde:	c37ff0ef          	jal	ra,ffffffffc0203814 <mm_destroy>

    cprintf("check_vma_struct() succeeded!\n");
ffffffffc0203be2:	00003517          	auipc	a0,0x3
ffffffffc0203be6:	2ee50513          	addi	a0,a0,750 # ffffffffc0206ed0 <default_pmm_manager+0x9c0>
ffffffffc0203bea:	daafc0ef          	jal	ra,ffffffffc0200194 <cprintf>
}
ffffffffc0203bee:	7442                	ld	s0,48(sp)
ffffffffc0203bf0:	70e2                	ld	ra,56(sp)
ffffffffc0203bf2:	74a2                	ld	s1,40(sp)
ffffffffc0203bf4:	7902                	ld	s2,32(sp)
ffffffffc0203bf6:	69e2                	ld	s3,24(sp)
ffffffffc0203bf8:	6a42                	ld	s4,16(sp)
ffffffffc0203bfa:	6aa2                	ld	s5,8(sp)
    cprintf("check_vmm() succeeded.\n");
ffffffffc0203bfc:	00003517          	auipc	a0,0x3
ffffffffc0203c00:	2f450513          	addi	a0,a0,756 # ffffffffc0206ef0 <default_pmm_manager+0x9e0>
}
ffffffffc0203c04:	6121                	addi	sp,sp,64
    cprintf("check_vmm() succeeded.\n");
ffffffffc0203c06:	d8efc06f          	j	ffffffffc0200194 <cprintf>
        assert(mmap->vm_start == i * 5 && mmap->vm_end == i * 5 + 2);
ffffffffc0203c0a:	00003697          	auipc	a3,0x3
ffffffffc0203c0e:	19e68693          	addi	a3,a3,414 # ffffffffc0206da8 <default_pmm_manager+0x898>
ffffffffc0203c12:	00002617          	auipc	a2,0x2
ffffffffc0203c16:	54e60613          	addi	a2,a2,1358 # ffffffffc0206160 <commands+0x828>
ffffffffc0203c1a:	19e00593          	li	a1,414
ffffffffc0203c1e:	00003517          	auipc	a0,0x3
ffffffffc0203c22:	09a50513          	addi	a0,a0,154 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc0203c26:	869fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma1->vm_start == i && vma1->vm_end == i + 2);
ffffffffc0203c2a:	00003697          	auipc	a3,0x3
ffffffffc0203c2e:	20668693          	addi	a3,a3,518 # ffffffffc0206e30 <default_pmm_manager+0x920>
ffffffffc0203c32:	00002617          	auipc	a2,0x2
ffffffffc0203c36:	52e60613          	addi	a2,a2,1326 # ffffffffc0206160 <commands+0x828>
ffffffffc0203c3a:	1af00593          	li	a1,431
ffffffffc0203c3e:	00003517          	auipc	a0,0x3
ffffffffc0203c42:	07a50513          	addi	a0,a0,122 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc0203c46:	849fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma2->vm_start == i && vma2->vm_end == i + 2);
ffffffffc0203c4a:	00003697          	auipc	a3,0x3
ffffffffc0203c4e:	21668693          	addi	a3,a3,534 # ffffffffc0206e60 <default_pmm_manager+0x950>
ffffffffc0203c52:	00002617          	auipc	a2,0x2
ffffffffc0203c56:	50e60613          	addi	a2,a2,1294 # ffffffffc0206160 <commands+0x828>
ffffffffc0203c5a:	1b000593          	li	a1,432
ffffffffc0203c5e:	00003517          	auipc	a0,0x3
ffffffffc0203c62:	05a50513          	addi	a0,a0,90 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc0203c66:	829fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(le != &(mm->mmap_list));
ffffffffc0203c6a:	00003697          	auipc	a3,0x3
ffffffffc0203c6e:	12668693          	addi	a3,a3,294 # ffffffffc0206d90 <default_pmm_manager+0x880>
ffffffffc0203c72:	00002617          	auipc	a2,0x2
ffffffffc0203c76:	4ee60613          	addi	a2,a2,1262 # ffffffffc0206160 <commands+0x828>
ffffffffc0203c7a:	19c00593          	li	a1,412
ffffffffc0203c7e:	00003517          	auipc	a0,0x3
ffffffffc0203c82:	03a50513          	addi	a0,a0,58 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc0203c86:	809fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma2 != NULL);
ffffffffc0203c8a:	00003697          	auipc	a3,0x3
ffffffffc0203c8e:	16668693          	addi	a3,a3,358 # ffffffffc0206df0 <default_pmm_manager+0x8e0>
ffffffffc0203c92:	00002617          	auipc	a2,0x2
ffffffffc0203c96:	4ce60613          	addi	a2,a2,1230 # ffffffffc0206160 <commands+0x828>
ffffffffc0203c9a:	1a700593          	li	a1,423
ffffffffc0203c9e:	00003517          	auipc	a0,0x3
ffffffffc0203ca2:	01a50513          	addi	a0,a0,26 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc0203ca6:	fe8fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma1 != NULL);
ffffffffc0203caa:	00003697          	auipc	a3,0x3
ffffffffc0203cae:	13668693          	addi	a3,a3,310 # ffffffffc0206de0 <default_pmm_manager+0x8d0>
ffffffffc0203cb2:	00002617          	auipc	a2,0x2
ffffffffc0203cb6:	4ae60613          	addi	a2,a2,1198 # ffffffffc0206160 <commands+0x828>
ffffffffc0203cba:	1a500593          	li	a1,421
ffffffffc0203cbe:	00003517          	auipc	a0,0x3
ffffffffc0203cc2:	ffa50513          	addi	a0,a0,-6 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc0203cc6:	fc8fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma3 == NULL);
ffffffffc0203cca:	00003697          	auipc	a3,0x3
ffffffffc0203cce:	13668693          	addi	a3,a3,310 # ffffffffc0206e00 <default_pmm_manager+0x8f0>
ffffffffc0203cd2:	00002617          	auipc	a2,0x2
ffffffffc0203cd6:	48e60613          	addi	a2,a2,1166 # ffffffffc0206160 <commands+0x828>
ffffffffc0203cda:	1a900593          	li	a1,425
ffffffffc0203cde:	00003517          	auipc	a0,0x3
ffffffffc0203ce2:	fda50513          	addi	a0,a0,-38 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc0203ce6:	fa8fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma5 == NULL);
ffffffffc0203cea:	00003697          	auipc	a3,0x3
ffffffffc0203cee:	13668693          	addi	a3,a3,310 # ffffffffc0206e20 <default_pmm_manager+0x910>
ffffffffc0203cf2:	00002617          	auipc	a2,0x2
ffffffffc0203cf6:	46e60613          	addi	a2,a2,1134 # ffffffffc0206160 <commands+0x828>
ffffffffc0203cfa:	1ad00593          	li	a1,429
ffffffffc0203cfe:	00003517          	auipc	a0,0x3
ffffffffc0203d02:	fba50513          	addi	a0,a0,-70 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc0203d06:	f88fc0ef          	jal	ra,ffffffffc020048e <__panic>
        assert(vma4 == NULL);
ffffffffc0203d0a:	00003697          	auipc	a3,0x3
ffffffffc0203d0e:	10668693          	addi	a3,a3,262 # ffffffffc0206e10 <default_pmm_manager+0x900>
ffffffffc0203d12:	00002617          	auipc	a2,0x2
ffffffffc0203d16:	44e60613          	addi	a2,a2,1102 # ffffffffc0206160 <commands+0x828>
ffffffffc0203d1a:	1ab00593          	li	a1,427
ffffffffc0203d1e:	00003517          	auipc	a0,0x3
ffffffffc0203d22:	f9a50513          	addi	a0,a0,-102 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc0203d26:	f68fc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(mm != NULL);
ffffffffc0203d2a:	00003697          	auipc	a3,0x3
ffffffffc0203d2e:	01668693          	addi	a3,a3,22 # ffffffffc0206d40 <default_pmm_manager+0x830>
ffffffffc0203d32:	00002617          	auipc	a2,0x2
ffffffffc0203d36:	42e60613          	addi	a2,a2,1070 # ffffffffc0206160 <commands+0x828>
ffffffffc0203d3a:	18500593          	li	a1,389
ffffffffc0203d3e:	00003517          	auipc	a0,0x3
ffffffffc0203d42:	f7a50513          	addi	a0,a0,-134 # ffffffffc0206cb8 <default_pmm_manager+0x7a8>
ffffffffc0203d46:	f48fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203d4a <user_mem_check>:
}
bool user_mem_check(struct mm_struct *mm, uintptr_t addr, size_t len, bool write)
{
ffffffffc0203d4a:	7179                	addi	sp,sp,-48
ffffffffc0203d4c:	f022                	sd	s0,32(sp)
ffffffffc0203d4e:	f406                	sd	ra,40(sp)
ffffffffc0203d50:	ec26                	sd	s1,24(sp)
ffffffffc0203d52:	e84a                	sd	s2,16(sp)
ffffffffc0203d54:	e44e                	sd	s3,8(sp)
ffffffffc0203d56:	e052                	sd	s4,0(sp)
ffffffffc0203d58:	842e                	mv	s0,a1
    if (mm != NULL)
ffffffffc0203d5a:	c135                	beqz	a0,ffffffffc0203dbe <user_mem_check+0x74>
    {
        if (!USER_ACCESS(addr, addr + len))
ffffffffc0203d5c:	002007b7          	lui	a5,0x200
ffffffffc0203d60:	04f5e663          	bltu	a1,a5,ffffffffc0203dac <user_mem_check+0x62>
ffffffffc0203d64:	00c584b3          	add	s1,a1,a2
ffffffffc0203d68:	0495f263          	bgeu	a1,s1,ffffffffc0203dac <user_mem_check+0x62>
ffffffffc0203d6c:	4785                	li	a5,1
ffffffffc0203d6e:	07fe                	slli	a5,a5,0x1f
ffffffffc0203d70:	0297ee63          	bltu	a5,s1,ffffffffc0203dac <user_mem_check+0x62>
ffffffffc0203d74:	892a                	mv	s2,a0
ffffffffc0203d76:	89b6                	mv	s3,a3
            {
                return 0;
            }
            if (write && (vma->vm_flags & VM_STACK))
            {
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203d78:	6a05                	lui	s4,0x1
ffffffffc0203d7a:	a821                	j	ffffffffc0203d92 <user_mem_check+0x48>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203d7c:	0027f693          	andi	a3,a5,2
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203d80:	9752                	add	a4,a4,s4
            if (write && (vma->vm_flags & VM_STACK))
ffffffffc0203d82:	8ba1                	andi	a5,a5,8
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203d84:	c685                	beqz	a3,ffffffffc0203dac <user_mem_check+0x62>
            if (write && (vma->vm_flags & VM_STACK))
ffffffffc0203d86:	c399                	beqz	a5,ffffffffc0203d8c <user_mem_check+0x42>
                if (start < vma->vm_start + PGSIZE)
ffffffffc0203d88:	02e46263          	bltu	s0,a4,ffffffffc0203dac <user_mem_check+0x62>
                { // check stack start & size
                    return 0;
                }
            }
            start = vma->vm_end;
ffffffffc0203d8c:	6900                	ld	s0,16(a0)
        while (start < end)
ffffffffc0203d8e:	04947663          	bgeu	s0,s1,ffffffffc0203dda <user_mem_check+0x90>
            if ((vma = find_vma(mm, start)) == NULL || start < vma->vm_start)
ffffffffc0203d92:	85a2                	mv	a1,s0
ffffffffc0203d94:	854a                	mv	a0,s2
ffffffffc0203d96:	96fff0ef          	jal	ra,ffffffffc0203704 <find_vma>
ffffffffc0203d9a:	c909                	beqz	a0,ffffffffc0203dac <user_mem_check+0x62>
ffffffffc0203d9c:	6518                	ld	a4,8(a0)
ffffffffc0203d9e:	00e46763          	bltu	s0,a4,ffffffffc0203dac <user_mem_check+0x62>
            if (!(vma->vm_flags & ((write) ? VM_WRITE : VM_READ)))
ffffffffc0203da2:	4d1c                	lw	a5,24(a0)
ffffffffc0203da4:	fc099ce3          	bnez	s3,ffffffffc0203d7c <user_mem_check+0x32>
ffffffffc0203da8:	8b85                	andi	a5,a5,1
ffffffffc0203daa:	f3ed                	bnez	a5,ffffffffc0203d8c <user_mem_check+0x42>
            return 0;
ffffffffc0203dac:	4501                	li	a0,0
        }
        return 1;
    }
    return KERN_ACCESS(addr, addr + len);
ffffffffc0203dae:	70a2                	ld	ra,40(sp)
ffffffffc0203db0:	7402                	ld	s0,32(sp)
ffffffffc0203db2:	64e2                	ld	s1,24(sp)
ffffffffc0203db4:	6942                	ld	s2,16(sp)
ffffffffc0203db6:	69a2                	ld	s3,8(sp)
ffffffffc0203db8:	6a02                	ld	s4,0(sp)
ffffffffc0203dba:	6145                	addi	sp,sp,48
ffffffffc0203dbc:	8082                	ret
    return KERN_ACCESS(addr, addr + len);
ffffffffc0203dbe:	c02007b7          	lui	a5,0xc0200
ffffffffc0203dc2:	4501                	li	a0,0
ffffffffc0203dc4:	fef5e5e3          	bltu	a1,a5,ffffffffc0203dae <user_mem_check+0x64>
ffffffffc0203dc8:	962e                	add	a2,a2,a1
ffffffffc0203dca:	fec5f2e3          	bgeu	a1,a2,ffffffffc0203dae <user_mem_check+0x64>
ffffffffc0203dce:	c8000537          	lui	a0,0xc8000
ffffffffc0203dd2:	0505                	addi	a0,a0,1
ffffffffc0203dd4:	00a63533          	sltu	a0,a2,a0
ffffffffc0203dd8:	bfd9                	j	ffffffffc0203dae <user_mem_check+0x64>
        return 1;
ffffffffc0203dda:	4505                	li	a0,1
ffffffffc0203ddc:	bfc9                	j	ffffffffc0203dae <user_mem_check+0x64>

ffffffffc0203dde <kernel_thread_entry>:
.text
.globl kernel_thread_entry
kernel_thread_entry:        # void kernel_thread(void)
	move a0, s1
ffffffffc0203dde:	8526                	mv	a0,s1
	jalr s0
ffffffffc0203de0:	9402                	jalr	s0

	jal do_exit
ffffffffc0203de2:	5f6000ef          	jal	ra,ffffffffc02043d8 <do_exit>

ffffffffc0203de6 <alloc_proc>:
void switch_to(struct context *from, struct context *to);

// alloc_proc - alloc a proc_struct and init all fields of proc_struct
static struct proc_struct *
alloc_proc(void)
{
ffffffffc0203de6:	1141                	addi	sp,sp,-16
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203de8:	10800513          	li	a0,264
{
ffffffffc0203dec:	e022                	sd	s0,0(sp)
ffffffffc0203dee:	e406                	sd	ra,8(sp)
    struct proc_struct *proc = kmalloc(sizeof(struct proc_struct));
ffffffffc0203df0:	ee3fd0ef          	jal	ra,ffffffffc0201cd2 <kmalloc>
ffffffffc0203df4:	842a                	mv	s0,a0
    if (proc != NULL)
ffffffffc0203df6:	cd21                	beqz	a0,ffffffffc0203e4e <alloc_proc+0x68>
    {
        // ... (existing initialization)
        proc->state = PROC_UNINIT;
ffffffffc0203df8:	57fd                	li	a5,-1
ffffffffc0203dfa:	1782                	slli	a5,a5,0x20
ffffffffc0203dfc:	e11c                	sd	a5,0(a0)
        proc->runs = 0;
        proc->kstack = 0;
        proc->need_resched = 0;
        proc->parent = NULL;
        proc->mm = NULL;
        memset(&proc->context, 0, sizeof(struct context));
ffffffffc0203dfe:	07000613          	li	a2,112
ffffffffc0203e02:	4581                	li	a1,0
        proc->runs = 0;
ffffffffc0203e04:	00052423          	sw	zero,8(a0) # ffffffffc8000008 <end+0x7d4a83c>
        proc->kstack = 0;
ffffffffc0203e08:	00053823          	sd	zero,16(a0)
        proc->need_resched = 0;
ffffffffc0203e0c:	00053c23          	sd	zero,24(a0)
        proc->parent = NULL;
ffffffffc0203e10:	02053023          	sd	zero,32(a0)
        proc->mm = NULL;
ffffffffc0203e14:	02053423          	sd	zero,40(a0)
        memset(&proc->context, 0, sizeof(struct context));
ffffffffc0203e18:	03050513          	addi	a0,a0,48
ffffffffc0203e1c:	089010ef          	jal	ra,ffffffffc02056a4 <memset>
        proc->tf = NULL;
        proc->pgdir = boot_pgdir_pa;
ffffffffc0203e20:	000b2797          	auipc	a5,0xb2
ffffffffc0203e24:	9607b783          	ld	a5,-1696(a5) # ffffffffc02b5780 <boot_pgdir_pa>
        proc->tf = NULL;
ffffffffc0203e28:	0a043023          	sd	zero,160(s0)
        proc->pgdir = boot_pgdir_pa;
ffffffffc0203e2c:	f45c                	sd	a5,168(s0)
        proc->flags = 0;
ffffffffc0203e2e:	0a042823          	sw	zero,176(s0)
        memset(proc->name, 0, PROC_NAME_LEN + 1);
ffffffffc0203e32:	4641                	li	a2,16
ffffffffc0203e34:	4581                	li	a1,0
ffffffffc0203e36:	0b440513          	addi	a0,s0,180
ffffffffc0203e3a:	06b010ef          	jal	ra,ffffffffc02056a4 <memset>

        // LAB5 YOUR CODE: Initialize new fields
        proc->wait_state = 0;
ffffffffc0203e3e:	0e042623          	sw	zero,236(s0)
        proc->cptr = NULL;
ffffffffc0203e42:	0e043823          	sd	zero,240(s0)
        proc->optr = NULL;
ffffffffc0203e46:	10043023          	sd	zero,256(s0)
        proc->yptr = NULL;
ffffffffc0203e4a:	0e043c23          	sd	zero,248(s0)
    }
    return proc;
}
ffffffffc0203e4e:	60a2                	ld	ra,8(sp)
ffffffffc0203e50:	8522                	mv	a0,s0
ffffffffc0203e52:	6402                	ld	s0,0(sp)
ffffffffc0203e54:	0141                	addi	sp,sp,16
ffffffffc0203e56:	8082                	ret

ffffffffc0203e58 <forkret>:
// NOTE: the addr of forkret is setted in copy_thread function
//       after switch_to, the current proc will execute here.
static void
forkret(void)
{
    forkrets(current->tf);
ffffffffc0203e58:	000b2797          	auipc	a5,0xb2
ffffffffc0203e5c:	9587b783          	ld	a5,-1704(a5) # ffffffffc02b57b0 <current>
ffffffffc0203e60:	73c8                	ld	a0,160(a5)
ffffffffc0203e62:	8e4fd06f          	j	ffffffffc0200f46 <forkrets>

ffffffffc0203e66 <user_main>:

// user_main - kernel thread used to exec a user program
static int
user_main(void *arg)
{
    KERNEL_EXECVE(cowtest);
ffffffffc0203e66:	000b2797          	auipc	a5,0xb2
ffffffffc0203e6a:	94a7b783          	ld	a5,-1718(a5) # ffffffffc02b57b0 <current>
ffffffffc0203e6e:	43cc                	lw	a1,4(a5)
{
ffffffffc0203e70:	7139                	addi	sp,sp,-64
    KERNEL_EXECVE(cowtest);
ffffffffc0203e72:	00003617          	auipc	a2,0x3
ffffffffc0203e76:	0a660613          	addi	a2,a2,166 # ffffffffc0206f18 <default_pmm_manager+0xa08>
ffffffffc0203e7a:	00003517          	auipc	a0,0x3
ffffffffc0203e7e:	0a650513          	addi	a0,a0,166 # ffffffffc0206f20 <default_pmm_manager+0xa10>
{
ffffffffc0203e82:	fc06                	sd	ra,56(sp)
    KERNEL_EXECVE(cowtest);
ffffffffc0203e84:	b10fc0ef          	jal	ra,ffffffffc0200194 <cprintf>
ffffffffc0203e88:	3fe07797          	auipc	a5,0x3fe07
ffffffffc0203e8c:	1c078793          	addi	a5,a5,448 # b048 <_binary_obj___user_cowtest_out_size>
ffffffffc0203e90:	e43e                	sd	a5,8(sp)
ffffffffc0203e92:	00003517          	auipc	a0,0x3
ffffffffc0203e96:	08650513          	addi	a0,a0,134 # ffffffffc0206f18 <default_pmm_manager+0xa08>
ffffffffc0203e9a:	0001c797          	auipc	a5,0x1c
ffffffffc0203e9e:	0ee78793          	addi	a5,a5,238 # ffffffffc021ff88 <_binary_obj___user_cowtest_out_start>
ffffffffc0203ea2:	f03e                	sd	a5,32(sp)
ffffffffc0203ea4:	f42a                	sd	a0,40(sp)
    int64_t ret = 0, len = strlen(name);
ffffffffc0203ea6:	e802                	sd	zero,16(sp)
ffffffffc0203ea8:	75a010ef          	jal	ra,ffffffffc0205602 <strlen>
ffffffffc0203eac:	ec2a                	sd	a0,24(sp)
    asm volatile(
ffffffffc0203eae:	4511                	li	a0,4
ffffffffc0203eb0:	55a2                	lw	a1,40(sp)
ffffffffc0203eb2:	4662                	lw	a2,24(sp)
ffffffffc0203eb4:	5682                	lw	a3,32(sp)
ffffffffc0203eb6:	4722                	lw	a4,8(sp)
ffffffffc0203eb8:	48a9                	li	a7,10
ffffffffc0203eba:	9002                	ebreak
ffffffffc0203ebc:	c82a                	sw	a0,16(sp)
    cprintf("ret = %d\n", ret);
ffffffffc0203ebe:	65c2                	ld	a1,16(sp)
ffffffffc0203ec0:	00003517          	auipc	a0,0x3
ffffffffc0203ec4:	08850513          	addi	a0,a0,136 # ffffffffc0206f48 <default_pmm_manager+0xa38>
ffffffffc0203ec8:	accfc0ef          	jal	ra,ffffffffc0200194 <cprintf>
    panic("user_main execve failed.\n");
ffffffffc0203ecc:	00003617          	auipc	a2,0x3
ffffffffc0203ed0:	08c60613          	addi	a2,a2,140 # ffffffffc0206f58 <default_pmm_manager+0xa48>
ffffffffc0203ed4:	37a00593          	li	a1,890
ffffffffc0203ed8:	00003517          	auipc	a0,0x3
ffffffffc0203edc:	0a050513          	addi	a0,a0,160 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc0203ee0:	daefc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203ee4 <put_pgdir>:
    return pa2page(PADDR(kva));
ffffffffc0203ee4:	6d14                	ld	a3,24(a0)
{
ffffffffc0203ee6:	1141                	addi	sp,sp,-16
ffffffffc0203ee8:	e406                	sd	ra,8(sp)
ffffffffc0203eea:	c02007b7          	lui	a5,0xc0200
ffffffffc0203eee:	02f6ee63          	bltu	a3,a5,ffffffffc0203f2a <put_pgdir+0x46>
ffffffffc0203ef2:	000b2517          	auipc	a0,0xb2
ffffffffc0203ef6:	8b653503          	ld	a0,-1866(a0) # ffffffffc02b57a8 <va_pa_offset>
ffffffffc0203efa:	8e89                	sub	a3,a3,a0
    if (PPN(pa) >= npage)
ffffffffc0203efc:	82b1                	srli	a3,a3,0xc
ffffffffc0203efe:	000b2797          	auipc	a5,0xb2
ffffffffc0203f02:	8927b783          	ld	a5,-1902(a5) # ffffffffc02b5790 <npage>
ffffffffc0203f06:	02f6fe63          	bgeu	a3,a5,ffffffffc0203f42 <put_pgdir+0x5e>
    return &pages[PPN(pa) - nbase];
ffffffffc0203f0a:	00004517          	auipc	a0,0x4
ffffffffc0203f0e:	92653503          	ld	a0,-1754(a0) # ffffffffc0207830 <nbase>
} 
ffffffffc0203f12:	60a2                	ld	ra,8(sp)
ffffffffc0203f14:	8e89                	sub	a3,a3,a0
ffffffffc0203f16:	069a                	slli	a3,a3,0x6
    free_page(kva2page(mm->pgdir));
ffffffffc0203f18:	000b2517          	auipc	a0,0xb2
ffffffffc0203f1c:	88053503          	ld	a0,-1920(a0) # ffffffffc02b5798 <pages>
ffffffffc0203f20:	4585                	li	a1,1
ffffffffc0203f22:	9536                	add	a0,a0,a3
} 
ffffffffc0203f24:	0141                	addi	sp,sp,16
    free_page(kva2page(mm->pgdir));
ffffffffc0203f26:	fc9fd06f          	j	ffffffffc0201eee <free_pages>
    return pa2page(PADDR(kva));
ffffffffc0203f2a:	00002617          	auipc	a2,0x2
ffffffffc0203f2e:	6c660613          	addi	a2,a2,1734 # ffffffffc02065f0 <default_pmm_manager+0xe0>
ffffffffc0203f32:	07700593          	li	a1,119
ffffffffc0203f36:	00002517          	auipc	a0,0x2
ffffffffc0203f3a:	63a50513          	addi	a0,a0,1594 # ffffffffc0206570 <default_pmm_manager+0x60>
ffffffffc0203f3e:	d50fc0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0203f42:	00002617          	auipc	a2,0x2
ffffffffc0203f46:	6d660613          	addi	a2,a2,1750 # ffffffffc0206618 <default_pmm_manager+0x108>
ffffffffc0203f4a:	06900593          	li	a1,105
ffffffffc0203f4e:	00002517          	auipc	a0,0x2
ffffffffc0203f52:	62250513          	addi	a0,a0,1570 # ffffffffc0206570 <default_pmm_manager+0x60>
ffffffffc0203f56:	d38fc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0203f5a <proc_run>:
{
ffffffffc0203f5a:	7179                	addi	sp,sp,-48
    if (proc != current)
ffffffffc0203f5c:	000b2797          	auipc	a5,0xb2
ffffffffc0203f60:	85478793          	addi	a5,a5,-1964 # ffffffffc02b57b0 <current>
{
ffffffffc0203f64:	f026                	sd	s1,32(sp)
    if (proc != current)
ffffffffc0203f66:	6384                	ld	s1,0(a5)
{
ffffffffc0203f68:	f406                	sd	ra,40(sp)
ffffffffc0203f6a:	ec4a                	sd	s2,24(sp)
    if (proc != current)
ffffffffc0203f6c:	02a48963          	beq	s1,a0,ffffffffc0203f9e <proc_run+0x44>
        current = proc;                     // 更新当前进程为proc
ffffffffc0203f70:	e388                	sd	a0,0(a5)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203f72:	100027f3          	csrr	a5,sstatus
ffffffffc0203f76:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0203f78:	4901                	li	s2,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0203f7a:	ef8d                	bnez	a5,ffffffffc0203fb4 <proc_run+0x5a>
#define barrier() __asm__ __volatile__("fence" ::: "memory")

static inline void
lsatp(unsigned long pgdir)
{
  write_csr(satp, 0x8000000000000000 | (pgdir >> RISCV_PGSHIFT));
ffffffffc0203f7c:	755c                	ld	a5,168(a0)
ffffffffc0203f7e:	577d                	li	a4,-1
ffffffffc0203f80:	177e                	slli	a4,a4,0x3f
ffffffffc0203f82:	83b1                	srli	a5,a5,0xc
ffffffffc0203f84:	8fd9                	or	a5,a5,a4
ffffffffc0203f86:	18079073          	csrw	satp,a5
    asm volatile("sfence.vma");
ffffffffc0203f8a:	12000073          	sfence.vma
        switch_to(&(prev->context), &(proc->context));
ffffffffc0203f8e:	03050593          	addi	a1,a0,48
ffffffffc0203f92:	03048513          	addi	a0,s1,48
ffffffffc0203f96:	012010ef          	jal	ra,ffffffffc0204fa8 <switch_to>
    if (flag)
ffffffffc0203f9a:	00091763          	bnez	s2,ffffffffc0203fa8 <proc_run+0x4e>
}
ffffffffc0203f9e:	70a2                	ld	ra,40(sp)
ffffffffc0203fa0:	7482                	ld	s1,32(sp)
ffffffffc0203fa2:	6962                	ld	s2,24(sp)
ffffffffc0203fa4:	6145                	addi	sp,sp,48
ffffffffc0203fa6:	8082                	ret
ffffffffc0203fa8:	70a2                	ld	ra,40(sp)
ffffffffc0203faa:	7482                	ld	s1,32(sp)
ffffffffc0203fac:	6962                	ld	s2,24(sp)
ffffffffc0203fae:	6145                	addi	sp,sp,48
        intr_enable();
ffffffffc0203fb0:	9fffc06f          	j	ffffffffc02009ae <intr_enable>
ffffffffc0203fb4:	e42a                	sd	a0,8(sp)
        intr_disable();
ffffffffc0203fb6:	9fffc0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc0203fba:	6522                	ld	a0,8(sp)
ffffffffc0203fbc:	4905                	li	s2,1
ffffffffc0203fbe:	bf7d                	j	ffffffffc0203f7c <proc_run+0x22>

ffffffffc0203fc0 <do_fork>:
{
ffffffffc0203fc0:	7119                	addi	sp,sp,-128
ffffffffc0203fc2:	f0ca                	sd	s2,96(sp)
    if (nr_process >= MAX_PROCESS) {
ffffffffc0203fc4:	000b2917          	auipc	s2,0xb2
ffffffffc0203fc8:	80490913          	addi	s2,s2,-2044 # ffffffffc02b57c8 <nr_process>
ffffffffc0203fcc:	00092703          	lw	a4,0(s2)
{
ffffffffc0203fd0:	fc86                	sd	ra,120(sp)
ffffffffc0203fd2:	f8a2                	sd	s0,112(sp)
ffffffffc0203fd4:	f4a6                	sd	s1,104(sp)
ffffffffc0203fd6:	ecce                	sd	s3,88(sp)
ffffffffc0203fd8:	e8d2                	sd	s4,80(sp)
ffffffffc0203fda:	e4d6                	sd	s5,72(sp)
ffffffffc0203fdc:	e0da                	sd	s6,64(sp)
ffffffffc0203fde:	fc5e                	sd	s7,56(sp)
ffffffffc0203fe0:	f862                	sd	s8,48(sp)
ffffffffc0203fe2:	f466                	sd	s9,40(sp)
ffffffffc0203fe4:	f06a                	sd	s10,32(sp)
ffffffffc0203fe6:	ec6e                	sd	s11,24(sp)
    if (nr_process >= MAX_PROCESS) {
ffffffffc0203fe8:	6785                	lui	a5,0x1
ffffffffc0203fea:	2ef75d63          	bge	a4,a5,ffffffffc02042e4 <do_fork+0x324>
ffffffffc0203fee:	8a2a                	mv	s4,a0
ffffffffc0203ff0:	89ae                	mv	s3,a1
ffffffffc0203ff2:	8432                	mv	s0,a2
    if ((proc = alloc_proc()) == NULL) {
ffffffffc0203ff4:	df3ff0ef          	jal	ra,ffffffffc0203de6 <alloc_proc>
ffffffffc0203ff8:	84aa                	mv	s1,a0
ffffffffc0203ffa:	2c050963          	beqz	a0,ffffffffc02042cc <do_fork+0x30c>
    proc->parent = current;
ffffffffc0203ffe:	000b1c17          	auipc	s8,0xb1
ffffffffc0204002:	7b2c0c13          	addi	s8,s8,1970 # ffffffffc02b57b0 <current>
ffffffffc0204006:	000c3783          	ld	a5,0(s8)
    assert(current->wait_state == 0); // Check wait state
ffffffffc020400a:	0ec7a703          	lw	a4,236(a5) # 10ec <_binary_obj___user_faultread_out_size-0x8ac4>
    proc->parent = current;
ffffffffc020400e:	f11c                	sd	a5,32(a0)
    assert(current->wait_state == 0); // Check wait state
ffffffffc0204010:	2e071c63          	bnez	a4,ffffffffc0204308 <do_fork+0x348>
    struct Page *page = alloc_pages(KSTACKPAGE);
ffffffffc0204014:	4509                	li	a0,2
ffffffffc0204016:	e9bfd0ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
    if (page != NULL)
ffffffffc020401a:	2a050663          	beqz	a0,ffffffffc02042c6 <do_fork+0x306>
    return page - pages + nbase;
ffffffffc020401e:	000b1a97          	auipc	s5,0xb1
ffffffffc0204022:	77aa8a93          	addi	s5,s5,1914 # ffffffffc02b5798 <pages>
ffffffffc0204026:	000ab683          	ld	a3,0(s5)
ffffffffc020402a:	00004b17          	auipc	s6,0x4
ffffffffc020402e:	806b0b13          	addi	s6,s6,-2042 # ffffffffc0207830 <nbase>
ffffffffc0204032:	000b3783          	ld	a5,0(s6)
ffffffffc0204036:	40d506b3          	sub	a3,a0,a3
    return KADDR(page2pa(page));
ffffffffc020403a:	000b1b97          	auipc	s7,0xb1
ffffffffc020403e:	756b8b93          	addi	s7,s7,1878 # ffffffffc02b5790 <npage>
    return page - pages + nbase;
ffffffffc0204042:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc0204044:	5dfd                	li	s11,-1
ffffffffc0204046:	000bb703          	ld	a4,0(s7)
    return page - pages + nbase;
ffffffffc020404a:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc020404c:	00cddd93          	srli	s11,s11,0xc
ffffffffc0204050:	01b6f633          	and	a2,a3,s11
    return page2ppn(page) << PGSHIFT;
ffffffffc0204054:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204056:	30e67163          	bgeu	a2,a4,ffffffffc0204358 <do_fork+0x398>
    struct mm_struct *mm, *oldmm = current->mm;
ffffffffc020405a:	000c3603          	ld	a2,0(s8)
ffffffffc020405e:	000b1c17          	auipc	s8,0xb1
ffffffffc0204062:	74ac0c13          	addi	s8,s8,1866 # ffffffffc02b57a8 <va_pa_offset>
ffffffffc0204066:	000c3703          	ld	a4,0(s8)
ffffffffc020406a:	02863d03          	ld	s10,40(a2)
ffffffffc020406e:	e43e                	sd	a5,8(sp)
ffffffffc0204070:	96ba                	add	a3,a3,a4
        proc->kstack = (uintptr_t)page2kva(page);
ffffffffc0204072:	e894                	sd	a3,16(s1)
    if (oldmm == NULL)
ffffffffc0204074:	020d0863          	beqz	s10,ffffffffc02040a4 <do_fork+0xe4>
    if (clone_flags & CLONE_VM)
ffffffffc0204078:	100a7a13          	andi	s4,s4,256
ffffffffc020407c:	180a0763          	beqz	s4,ffffffffc020420a <do_fork+0x24a>
}

static inline int
mm_count_inc(struct mm_struct *mm)
{
    mm->mm_count += 1;
ffffffffc0204080:	030d2703          	lw	a4,48(s10)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0204084:	018d3783          	ld	a5,24(s10)
ffffffffc0204088:	c02006b7          	lui	a3,0xc0200
ffffffffc020408c:	2705                	addiw	a4,a4,1
ffffffffc020408e:	02ed2823          	sw	a4,48(s10)
    proc->mm = mm;
ffffffffc0204092:	03a4b423          	sd	s10,40(s1)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc0204096:	24d7ec63          	bltu	a5,a3,ffffffffc02042ee <do_fork+0x32e>
ffffffffc020409a:	000c3703          	ld	a4,0(s8)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc020409e:	6894                	ld	a3,16(s1)
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc02040a0:	8f99                	sub	a5,a5,a4
ffffffffc02040a2:	f4dc                	sd	a5,168(s1)
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc02040a4:	6789                	lui	a5,0x2
ffffffffc02040a6:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_obj___user_faultread_out_size-0x7cd0>
ffffffffc02040aa:	96be                	add	a3,a3,a5
    *(proc->tf) = *tf;
ffffffffc02040ac:	8622                	mv	a2,s0
    proc->tf = (struct trapframe *)(proc->kstack + KSTACKSIZE) - 1;
ffffffffc02040ae:	f0d4                	sd	a3,160(s1)
    *(proc->tf) = *tf;
ffffffffc02040b0:	87b6                	mv	a5,a3
ffffffffc02040b2:	12040893          	addi	a7,s0,288
ffffffffc02040b6:	00063803          	ld	a6,0(a2)
ffffffffc02040ba:	6608                	ld	a0,8(a2)
ffffffffc02040bc:	6a0c                	ld	a1,16(a2)
ffffffffc02040be:	6e18                	ld	a4,24(a2)
ffffffffc02040c0:	0107b023          	sd	a6,0(a5)
ffffffffc02040c4:	e788                	sd	a0,8(a5)
ffffffffc02040c6:	eb8c                	sd	a1,16(a5)
ffffffffc02040c8:	ef98                	sd	a4,24(a5)
ffffffffc02040ca:	02060613          	addi	a2,a2,32
ffffffffc02040ce:	02078793          	addi	a5,a5,32
ffffffffc02040d2:	ff1612e3          	bne	a2,a7,ffffffffc02040b6 <do_fork+0xf6>
    proc->tf->gpr.a0 = 0;
ffffffffc02040d6:	0406b823          	sd	zero,80(a3) # ffffffffc0200050 <kern_init+0x6>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc02040da:	12098663          	beqz	s3,ffffffffc0204206 <do_fork+0x246>
    if (++last_pid >= MAX_PID)
ffffffffc02040de:	000ad817          	auipc	a6,0xad
ffffffffc02040e2:	23a80813          	addi	a6,a6,570 # ffffffffc02b1318 <last_pid.1>
ffffffffc02040e6:	00082783          	lw	a5,0(a6)
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc02040ea:	0136b823          	sd	s3,16(a3)
    proc->context.ra = (uintptr_t)forkret;
ffffffffc02040ee:	00000717          	auipc	a4,0x0
ffffffffc02040f2:	d6a70713          	addi	a4,a4,-662 # ffffffffc0203e58 <forkret>
    if (++last_pid >= MAX_PID)
ffffffffc02040f6:	0017851b          	addiw	a0,a5,1
    proc->context.ra = (uintptr_t)forkret;
ffffffffc02040fa:	f898                	sd	a4,48(s1)
    proc->context.sp = (uintptr_t)(proc->tf);
ffffffffc02040fc:	fc94                	sd	a3,56(s1)
    if (++last_pid >= MAX_PID)
ffffffffc02040fe:	00a82023          	sw	a0,0(a6)
ffffffffc0204102:	6789                	lui	a5,0x2
ffffffffc0204104:	08f55a63          	bge	a0,a5,ffffffffc0204198 <do_fork+0x1d8>
    if (last_pid >= next_safe)
ffffffffc0204108:	000ad317          	auipc	t1,0xad
ffffffffc020410c:	21430313          	addi	t1,t1,532 # ffffffffc02b131c <next_safe.0>
ffffffffc0204110:	00032783          	lw	a5,0(t1)
ffffffffc0204114:	000b1417          	auipc	s0,0xb1
ffffffffc0204118:	62440413          	addi	s0,s0,1572 # ffffffffc02b5738 <proc_list>
ffffffffc020411c:	08f55663          	bge	a0,a5,ffffffffc02041a8 <do_fork+0x1e8>
    proc->state = PROC_RUNNABLE;
ffffffffc0204120:	4789                	li	a5,2
    proc->pid = get_pid();
ffffffffc0204122:	c0c8                	sw	a0,4(s1)
    proc->state = PROC_RUNNABLE;
ffffffffc0204124:	c09c                	sw	a5,0(s1)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc0204126:	45a9                	li	a1,10
ffffffffc0204128:	2501                	sext.w	a0,a0
ffffffffc020412a:	0d4010ef          	jal	ra,ffffffffc02051fe <hash32>
ffffffffc020412e:	02051793          	slli	a5,a0,0x20
ffffffffc0204132:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0204136:	000ad797          	auipc	a5,0xad
ffffffffc020413a:	60278793          	addi	a5,a5,1538 # ffffffffc02b1738 <hash_list>
ffffffffc020413e:	953e                	add	a0,a0,a5
    __list_add(elm, listelm, listelm->next);
ffffffffc0204140:	650c                	ld	a1,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc0204142:	7094                	ld	a3,32(s1)
    list_add(hash_list + pid_hashfn(proc->pid), &(proc->hash_link));
ffffffffc0204144:	0d848793          	addi	a5,s1,216
    prev->next = next->prev = elm;
ffffffffc0204148:	e19c                	sd	a5,0(a1)
    __list_add(elm, listelm, listelm->next);
ffffffffc020414a:	6410                	ld	a2,8(s0)
    prev->next = next->prev = elm;
ffffffffc020414c:	e51c                	sd	a5,8(a0)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc020414e:	7af8                	ld	a4,240(a3)
    list_add(&proc_list, &(proc->list_link));
ffffffffc0204150:	0c848793          	addi	a5,s1,200
    elm->next = next;
ffffffffc0204154:	f0ec                	sd	a1,224(s1)
    elm->prev = prev;
ffffffffc0204156:	ece8                	sd	a0,216(s1)
    prev->next = next->prev = elm;
ffffffffc0204158:	e21c                	sd	a5,0(a2)
ffffffffc020415a:	e41c                	sd	a5,8(s0)
    elm->next = next;
ffffffffc020415c:	e8f0                	sd	a2,208(s1)
    elm->prev = prev;
ffffffffc020415e:	e4e0                	sd	s0,200(s1)
    proc->yptr = NULL;
ffffffffc0204160:	0e04bc23          	sd	zero,248(s1)
    if ((proc->optr = proc->parent->cptr) != NULL)
ffffffffc0204164:	10e4b023          	sd	a4,256(s1)
ffffffffc0204168:	c311                	beqz	a4,ffffffffc020416c <do_fork+0x1ac>
        proc->optr->yptr = proc;
ffffffffc020416a:	ff64                	sd	s1,248(a4)
    nr_process++;
ffffffffc020416c:	00092783          	lw	a5,0(s2)
    ret = proc->pid;
ffffffffc0204170:	40c8                	lw	a0,4(s1)
    proc->parent->cptr = proc;
ffffffffc0204172:	fae4                	sd	s1,240(a3)
    nr_process++;
ffffffffc0204174:	2785                	addiw	a5,a5,1
ffffffffc0204176:	00f92023          	sw	a5,0(s2)
}
ffffffffc020417a:	70e6                	ld	ra,120(sp)
ffffffffc020417c:	7446                	ld	s0,112(sp)
ffffffffc020417e:	74a6                	ld	s1,104(sp)
ffffffffc0204180:	7906                	ld	s2,96(sp)
ffffffffc0204182:	69e6                	ld	s3,88(sp)
ffffffffc0204184:	6a46                	ld	s4,80(sp)
ffffffffc0204186:	6aa6                	ld	s5,72(sp)
ffffffffc0204188:	6b06                	ld	s6,64(sp)
ffffffffc020418a:	7be2                	ld	s7,56(sp)
ffffffffc020418c:	7c42                	ld	s8,48(sp)
ffffffffc020418e:	7ca2                	ld	s9,40(sp)
ffffffffc0204190:	7d02                	ld	s10,32(sp)
ffffffffc0204192:	6de2                	ld	s11,24(sp)
ffffffffc0204194:	6109                	addi	sp,sp,128
ffffffffc0204196:	8082                	ret
        last_pid = 1;
ffffffffc0204198:	4785                	li	a5,1
ffffffffc020419a:	00f82023          	sw	a5,0(a6)
        goto inside;
ffffffffc020419e:	4505                	li	a0,1
ffffffffc02041a0:	000ad317          	auipc	t1,0xad
ffffffffc02041a4:	17c30313          	addi	t1,t1,380 # ffffffffc02b131c <next_safe.0>
    return listelm->next;
ffffffffc02041a8:	000b1417          	auipc	s0,0xb1
ffffffffc02041ac:	59040413          	addi	s0,s0,1424 # ffffffffc02b5738 <proc_list>
ffffffffc02041b0:	00843e03          	ld	t3,8(s0)
        next_safe = MAX_PID;
ffffffffc02041b4:	6789                	lui	a5,0x2
ffffffffc02041b6:	00f32023          	sw	a5,0(t1)
ffffffffc02041ba:	86aa                	mv	a3,a0
ffffffffc02041bc:	4581                	li	a1,0
        while ((le = list_next(le)) != list)
ffffffffc02041be:	6e89                	lui	t4,0x2
ffffffffc02041c0:	108e0d63          	beq	t3,s0,ffffffffc02042da <do_fork+0x31a>
ffffffffc02041c4:	88ae                	mv	a7,a1
ffffffffc02041c6:	87f2                	mv	a5,t3
ffffffffc02041c8:	6609                	lui	a2,0x2
ffffffffc02041ca:	a811                	j	ffffffffc02041de <do_fork+0x21e>
            else if (proc->pid > last_pid && next_safe > proc->pid)
ffffffffc02041cc:	00e6d663          	bge	a3,a4,ffffffffc02041d8 <do_fork+0x218>
ffffffffc02041d0:	00c75463          	bge	a4,a2,ffffffffc02041d8 <do_fork+0x218>
ffffffffc02041d4:	863a                	mv	a2,a4
ffffffffc02041d6:	4885                	li	a7,1
ffffffffc02041d8:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc02041da:	00878d63          	beq	a5,s0,ffffffffc02041f4 <do_fork+0x234>
            if (proc->pid == last_pid)
ffffffffc02041de:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_obj___user_faultread_out_size-0x7c74>
ffffffffc02041e2:	fed715e3          	bne	a4,a3,ffffffffc02041cc <do_fork+0x20c>
                if (++last_pid >= next_safe)
ffffffffc02041e6:	2685                	addiw	a3,a3,1
ffffffffc02041e8:	0ec6d463          	bge	a3,a2,ffffffffc02042d0 <do_fork+0x310>
ffffffffc02041ec:	679c                	ld	a5,8(a5)
ffffffffc02041ee:	4585                	li	a1,1
        while ((le = list_next(le)) != list)
ffffffffc02041f0:	fe8797e3          	bne	a5,s0,ffffffffc02041de <do_fork+0x21e>
ffffffffc02041f4:	c581                	beqz	a1,ffffffffc02041fc <do_fork+0x23c>
ffffffffc02041f6:	00d82023          	sw	a3,0(a6)
ffffffffc02041fa:	8536                	mv	a0,a3
ffffffffc02041fc:	f20882e3          	beqz	a7,ffffffffc0204120 <do_fork+0x160>
ffffffffc0204200:	00c32023          	sw	a2,0(t1)
ffffffffc0204204:	bf31                	j	ffffffffc0204120 <do_fork+0x160>
    proc->tf->gpr.sp = (esp == 0) ? (uintptr_t)proc->tf : esp;
ffffffffc0204206:	89b6                	mv	s3,a3
ffffffffc0204208:	bdd9                	j	ffffffffc02040de <do_fork+0x11e>
    if ((mm = mm_create()) == NULL)
ffffffffc020420a:	ccaff0ef          	jal	ra,ffffffffc02036d4 <mm_create>
ffffffffc020420e:	8caa                	mv	s9,a0
ffffffffc0204210:	c159                	beqz	a0,ffffffffc0204296 <do_fork+0x2d6>
    if ((page = alloc_page()) == NULL)
ffffffffc0204212:	4505                	li	a0,1
ffffffffc0204214:	c9dfd0ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc0204218:	cd25                	beqz	a0,ffffffffc0204290 <do_fork+0x2d0>
    return page - pages + nbase;
ffffffffc020421a:	000ab683          	ld	a3,0(s5)
ffffffffc020421e:	67a2                	ld	a5,8(sp)
    return KADDR(page2pa(page));
ffffffffc0204220:	000bb703          	ld	a4,0(s7)
    return page - pages + nbase;
ffffffffc0204224:	40d506b3          	sub	a3,a0,a3
ffffffffc0204228:	8699                	srai	a3,a3,0x6
ffffffffc020422a:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc020422c:	01b6fdb3          	and	s11,a3,s11
    return page2ppn(page) << PGSHIFT;
ffffffffc0204230:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204232:	12edf363          	bgeu	s11,a4,ffffffffc0204358 <do_fork+0x398>
ffffffffc0204236:	000c3a03          	ld	s4,0(s8)
    memcpy(pgdir, boot_pgdir_va, PGSIZE);
ffffffffc020423a:	6605                	lui	a2,0x1
ffffffffc020423c:	000b1597          	auipc	a1,0xb1
ffffffffc0204240:	54c5b583          	ld	a1,1356(a1) # ffffffffc02b5788 <boot_pgdir_va>
ffffffffc0204244:	9a36                	add	s4,s4,a3
ffffffffc0204246:	8552                	mv	a0,s4
ffffffffc0204248:	46e010ef          	jal	ra,ffffffffc02056b6 <memcpy>
static inline void
lock_mm(struct mm_struct *mm)
{
    if (mm != NULL)
    {
        lock(&(mm->mm_lock));
ffffffffc020424c:	038d0d93          	addi	s11,s10,56
    mm->pgdir = pgdir;
ffffffffc0204250:	014cbc23          	sd	s4,24(s9)
 * test_and_set_bit - Atomically set a bit and return its old value
 * @nr:     the bit to set
 * @addr:   the address to count from
 * */
static inline bool test_and_set_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(or, __NOP, nr, ((volatile unsigned long *)addr));
ffffffffc0204254:	4785                	li	a5,1
ffffffffc0204256:	40fdb7af          	amoor.d	a5,a5,(s11)
}

static inline void
lock(lock_t *lock)
{
    while (!try_lock(lock))
ffffffffc020425a:	8b85                	andi	a5,a5,1
ffffffffc020425c:	4a05                	li	s4,1
ffffffffc020425e:	c799                	beqz	a5,ffffffffc020426c <do_fork+0x2ac>
    {
        schedule();
ffffffffc0204260:	633000ef          	jal	ra,ffffffffc0205092 <schedule>
ffffffffc0204264:	414db7af          	amoor.d	a5,s4,(s11)
    while (!try_lock(lock))
ffffffffc0204268:	8b85                	andi	a5,a5,1
ffffffffc020426a:	fbfd                	bnez	a5,ffffffffc0204260 <do_fork+0x2a0>
        ret = dup_mmap(mm, oldmm);
ffffffffc020426c:	85ea                	mv	a1,s10
ffffffffc020426e:	8566                	mv	a0,s9
ffffffffc0204270:	ea6ff0ef          	jal	ra,ffffffffc0203916 <dup_mmap>
 * test_and_clear_bit - Atomically clear a bit and return its old value
 * @nr:     the bit to clear
 * @addr:   the address to count from
 * */
static inline bool test_and_clear_bit(int nr, volatile void *addr) {
    return __test_and_op_bit(and, __NOT, nr, ((volatile unsigned long *)addr));
ffffffffc0204274:	57f9                	li	a5,-2
ffffffffc0204276:	60fdb7af          	amoand.d	a5,a5,(s11)
ffffffffc020427a:	8b85                	andi	a5,a5,1
}

static inline void
unlock(lock_t *lock)
{
    if (!test_and_clear_bit(0, lock))
ffffffffc020427c:	c3f1                	beqz	a5,ffffffffc0204340 <do_fork+0x380>
good_mm:
ffffffffc020427e:	8d66                	mv	s10,s9
    if (ret != 0)
ffffffffc0204280:	e00500e3          	beqz	a0,ffffffffc0204080 <do_fork+0xc0>
    exit_mmap(mm);
ffffffffc0204284:	8566                	mv	a0,s9
ffffffffc0204286:	f2aff0ef          	jal	ra,ffffffffc02039b0 <exit_mmap>
    put_pgdir(mm);
ffffffffc020428a:	8566                	mv	a0,s9
ffffffffc020428c:	c59ff0ef          	jal	ra,ffffffffc0203ee4 <put_pgdir>
    mm_destroy(mm);
ffffffffc0204290:	8566                	mv	a0,s9
ffffffffc0204292:	d82ff0ef          	jal	ra,ffffffffc0203814 <mm_destroy>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc0204296:	6894                	ld	a3,16(s1)
    return pa2page(PADDR(kva));
ffffffffc0204298:	c02007b7          	lui	a5,0xc0200
ffffffffc020429c:	0cf6ea63          	bltu	a3,a5,ffffffffc0204370 <do_fork+0x3b0>
ffffffffc02042a0:	000c3783          	ld	a5,0(s8)
    if (PPN(pa) >= npage)
ffffffffc02042a4:	000bb703          	ld	a4,0(s7)
    return pa2page(PADDR(kva));
ffffffffc02042a8:	40f687b3          	sub	a5,a3,a5
    if (PPN(pa) >= npage)
ffffffffc02042ac:	83b1                	srli	a5,a5,0xc
ffffffffc02042ae:	06e7fd63          	bgeu	a5,a4,ffffffffc0204328 <do_fork+0x368>
    return &pages[PPN(pa) - nbase];
ffffffffc02042b2:	000b3703          	ld	a4,0(s6)
ffffffffc02042b6:	000ab503          	ld	a0,0(s5)
ffffffffc02042ba:	4589                	li	a1,2
ffffffffc02042bc:	8f99                	sub	a5,a5,a4
ffffffffc02042be:	079a                	slli	a5,a5,0x6
ffffffffc02042c0:	953e                	add	a0,a0,a5
ffffffffc02042c2:	c2dfd0ef          	jal	ra,ffffffffc0201eee <free_pages>
    kfree(proc);
ffffffffc02042c6:	8526                	mv	a0,s1
ffffffffc02042c8:	abbfd0ef          	jal	ra,ffffffffc0201d82 <kfree>
    ret = -E_NO_MEM;
ffffffffc02042cc:	5571                	li	a0,-4
    return ret;
ffffffffc02042ce:	b575                	j	ffffffffc020417a <do_fork+0x1ba>
                    if (last_pid >= MAX_PID)
ffffffffc02042d0:	01d6c363          	blt	a3,t4,ffffffffc02042d6 <do_fork+0x316>
                        last_pid = 1;
ffffffffc02042d4:	4685                	li	a3,1
                    goto repeat;
ffffffffc02042d6:	4585                	li	a1,1
ffffffffc02042d8:	b5e5                	j	ffffffffc02041c0 <do_fork+0x200>
ffffffffc02042da:	c599                	beqz	a1,ffffffffc02042e8 <do_fork+0x328>
ffffffffc02042dc:	00d82023          	sw	a3,0(a6)
    return last_pid;
ffffffffc02042e0:	8536                	mv	a0,a3
ffffffffc02042e2:	bd3d                	j	ffffffffc0204120 <do_fork+0x160>
    int ret = -E_NO_FREE_PROC;
ffffffffc02042e4:	556d                	li	a0,-5
ffffffffc02042e6:	bd51                	j	ffffffffc020417a <do_fork+0x1ba>
    return last_pid;
ffffffffc02042e8:	00082503          	lw	a0,0(a6)
ffffffffc02042ec:	bd15                	j	ffffffffc0204120 <do_fork+0x160>
    proc->pgdir = PADDR(mm->pgdir);
ffffffffc02042ee:	86be                	mv	a3,a5
ffffffffc02042f0:	00002617          	auipc	a2,0x2
ffffffffc02042f4:	30060613          	addi	a2,a2,768 # ffffffffc02065f0 <default_pmm_manager+0xe0>
ffffffffc02042f8:	17100593          	li	a1,369
ffffffffc02042fc:	00003517          	auipc	a0,0x3
ffffffffc0204300:	c7c50513          	addi	a0,a0,-900 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc0204304:	98afc0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(current->wait_state == 0); // Check wait state
ffffffffc0204308:	00003697          	auipc	a3,0x3
ffffffffc020430c:	c8868693          	addi	a3,a3,-888 # ffffffffc0206f90 <default_pmm_manager+0xa80>
ffffffffc0204310:	00002617          	auipc	a2,0x2
ffffffffc0204314:	e5060613          	addi	a2,a2,-432 # ffffffffc0206160 <commands+0x828>
ffffffffc0204318:	1a100593          	li	a1,417
ffffffffc020431c:	00003517          	auipc	a0,0x3
ffffffffc0204320:	c5c50513          	addi	a0,a0,-932 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc0204324:	96afc0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc0204328:	00002617          	auipc	a2,0x2
ffffffffc020432c:	2f060613          	addi	a2,a2,752 # ffffffffc0206618 <default_pmm_manager+0x108>
ffffffffc0204330:	06900593          	li	a1,105
ffffffffc0204334:	00002517          	auipc	a0,0x2
ffffffffc0204338:	23c50513          	addi	a0,a0,572 # ffffffffc0206570 <default_pmm_manager+0x60>
ffffffffc020433c:	952fc0ef          	jal	ra,ffffffffc020048e <__panic>
    {
        panic("Unlock failed.\n");
ffffffffc0204340:	00003617          	auipc	a2,0x3
ffffffffc0204344:	c7060613          	addi	a2,a2,-912 # ffffffffc0206fb0 <default_pmm_manager+0xaa0>
ffffffffc0204348:	03f00593          	li	a1,63
ffffffffc020434c:	00003517          	auipc	a0,0x3
ffffffffc0204350:	c7450513          	addi	a0,a0,-908 # ffffffffc0206fc0 <default_pmm_manager+0xab0>
ffffffffc0204354:	93afc0ef          	jal	ra,ffffffffc020048e <__panic>
    return KADDR(page2pa(page));
ffffffffc0204358:	00002617          	auipc	a2,0x2
ffffffffc020435c:	1f060613          	addi	a2,a2,496 # ffffffffc0206548 <default_pmm_manager+0x38>
ffffffffc0204360:	07100593          	li	a1,113
ffffffffc0204364:	00002517          	auipc	a0,0x2
ffffffffc0204368:	20c50513          	addi	a0,a0,524 # ffffffffc0206570 <default_pmm_manager+0x60>
ffffffffc020436c:	922fc0ef          	jal	ra,ffffffffc020048e <__panic>
    return pa2page(PADDR(kva));
ffffffffc0204370:	00002617          	auipc	a2,0x2
ffffffffc0204374:	28060613          	addi	a2,a2,640 # ffffffffc02065f0 <default_pmm_manager+0xe0>
ffffffffc0204378:	07700593          	li	a1,119
ffffffffc020437c:	00002517          	auipc	a0,0x2
ffffffffc0204380:	1f450513          	addi	a0,a0,500 # ffffffffc0206570 <default_pmm_manager+0x60>
ffffffffc0204384:	90afc0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0204388 <kernel_thread>:
{
ffffffffc0204388:	7129                	addi	sp,sp,-320
ffffffffc020438a:	fa22                	sd	s0,304(sp)
ffffffffc020438c:	f626                	sd	s1,296(sp)
ffffffffc020438e:	f24a                	sd	s2,288(sp)
ffffffffc0204390:	84ae                	mv	s1,a1
ffffffffc0204392:	892a                	mv	s2,a0
ffffffffc0204394:	8432                	mv	s0,a2
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc0204396:	4581                	li	a1,0
ffffffffc0204398:	12000613          	li	a2,288
ffffffffc020439c:	850a                	mv	a0,sp
{
ffffffffc020439e:	fe06                	sd	ra,312(sp)
    memset(&tf, 0, sizeof(struct trapframe));
ffffffffc02043a0:	304010ef          	jal	ra,ffffffffc02056a4 <memset>
    tf.gpr.s0 = (uintptr_t)fn;
ffffffffc02043a4:	e0ca                	sd	s2,64(sp)
    tf.gpr.s1 = (uintptr_t)arg;
ffffffffc02043a6:	e4a6                	sd	s1,72(sp)
    tf.status = (read_csr(sstatus) | SSTATUS_SPP | SSTATUS_SPIE) & ~SSTATUS_SIE;
ffffffffc02043a8:	100027f3          	csrr	a5,sstatus
ffffffffc02043ac:	edd7f793          	andi	a5,a5,-291
ffffffffc02043b0:	1207e793          	ori	a5,a5,288
ffffffffc02043b4:	e23e                	sd	a5,256(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc02043b6:	860a                	mv	a2,sp
ffffffffc02043b8:	10046513          	ori	a0,s0,256
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc02043bc:	00000797          	auipc	a5,0x0
ffffffffc02043c0:	a2278793          	addi	a5,a5,-1502 # ffffffffc0203dde <kernel_thread_entry>
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc02043c4:	4581                	li	a1,0
    tf.epc = (uintptr_t)kernel_thread_entry;
ffffffffc02043c6:	e63e                	sd	a5,264(sp)
    return do_fork(clone_flags | CLONE_VM, 0, &tf);
ffffffffc02043c8:	bf9ff0ef          	jal	ra,ffffffffc0203fc0 <do_fork>
}
ffffffffc02043cc:	70f2                	ld	ra,312(sp)
ffffffffc02043ce:	7452                	ld	s0,304(sp)
ffffffffc02043d0:	74b2                	ld	s1,296(sp)
ffffffffc02043d2:	7912                	ld	s2,288(sp)
ffffffffc02043d4:	6131                	addi	sp,sp,320
ffffffffc02043d6:	8082                	ret

ffffffffc02043d8 <do_exit>:
{
ffffffffc02043d8:	7179                	addi	sp,sp,-48
ffffffffc02043da:	f022                	sd	s0,32(sp)
    if (current == idleproc)
ffffffffc02043dc:	000b1417          	auipc	s0,0xb1
ffffffffc02043e0:	3d440413          	addi	s0,s0,980 # ffffffffc02b57b0 <current>
ffffffffc02043e4:	601c                	ld	a5,0(s0)
{
ffffffffc02043e6:	f406                	sd	ra,40(sp)
ffffffffc02043e8:	ec26                	sd	s1,24(sp)
ffffffffc02043ea:	e84a                	sd	s2,16(sp)
ffffffffc02043ec:	e44e                	sd	s3,8(sp)
ffffffffc02043ee:	e052                	sd	s4,0(sp)
    if (current == idleproc)
ffffffffc02043f0:	000b1717          	auipc	a4,0xb1
ffffffffc02043f4:	3c873703          	ld	a4,968(a4) # ffffffffc02b57b8 <idleproc>
ffffffffc02043f8:	0ce78c63          	beq	a5,a4,ffffffffc02044d0 <do_exit+0xf8>
    if (current == initproc)
ffffffffc02043fc:	000b1497          	auipc	s1,0xb1
ffffffffc0204400:	3c448493          	addi	s1,s1,964 # ffffffffc02b57c0 <initproc>
ffffffffc0204404:	6098                	ld	a4,0(s1)
ffffffffc0204406:	0ee78b63          	beq	a5,a4,ffffffffc02044fc <do_exit+0x124>
    struct mm_struct *mm = current->mm;
ffffffffc020440a:	0287b983          	ld	s3,40(a5)
ffffffffc020440e:	892a                	mv	s2,a0
    if (mm != NULL)
ffffffffc0204410:	02098663          	beqz	s3,ffffffffc020443c <do_exit+0x64>
ffffffffc0204414:	000b1797          	auipc	a5,0xb1
ffffffffc0204418:	36c7b783          	ld	a5,876(a5) # ffffffffc02b5780 <boot_pgdir_pa>
ffffffffc020441c:	577d                	li	a4,-1
ffffffffc020441e:	177e                	slli	a4,a4,0x3f
ffffffffc0204420:	83b1                	srli	a5,a5,0xc
ffffffffc0204422:	8fd9                	or	a5,a5,a4
ffffffffc0204424:	18079073          	csrw	satp,a5
    mm->mm_count -= 1;
ffffffffc0204428:	0309a783          	lw	a5,48(s3)
ffffffffc020442c:	fff7871b          	addiw	a4,a5,-1
ffffffffc0204430:	02e9a823          	sw	a4,48(s3)
        if (mm_count_dec(mm) == 0)
ffffffffc0204434:	cb55                	beqz	a4,ffffffffc02044e8 <do_exit+0x110>
        current->mm = NULL;
ffffffffc0204436:	601c                	ld	a5,0(s0)
ffffffffc0204438:	0207b423          	sd	zero,40(a5)
    current->state = PROC_ZOMBIE;
ffffffffc020443c:	601c                	ld	a5,0(s0)
ffffffffc020443e:	470d                	li	a4,3
ffffffffc0204440:	c398                	sw	a4,0(a5)
    current->exit_code = error_code;
ffffffffc0204442:	0f27a423          	sw	s2,232(a5)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204446:	100027f3          	csrr	a5,sstatus
ffffffffc020444a:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020444c:	4a01                	li	s4,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020444e:	e3f9                	bnez	a5,ffffffffc0204514 <do_exit+0x13c>
        proc = current->parent;
ffffffffc0204450:	6018                	ld	a4,0(s0)
        if (proc->wait_state == WT_CHILD)
ffffffffc0204452:	800007b7          	lui	a5,0x80000
ffffffffc0204456:	0785                	addi	a5,a5,1
        proc = current->parent;
ffffffffc0204458:	7308                	ld	a0,32(a4)
        if (proc->wait_state == WT_CHILD)
ffffffffc020445a:	0ec52703          	lw	a4,236(a0)
ffffffffc020445e:	0af70f63          	beq	a4,a5,ffffffffc020451c <do_exit+0x144>
        while (current->cptr != NULL)
ffffffffc0204462:	6018                	ld	a4,0(s0)
ffffffffc0204464:	7b7c                	ld	a5,240(a4)
ffffffffc0204466:	c3a1                	beqz	a5,ffffffffc02044a6 <do_exit+0xce>
                if (initproc->wait_state == WT_CHILD)
ffffffffc0204468:	800009b7          	lui	s3,0x80000
            if (proc->state == PROC_ZOMBIE)
ffffffffc020446c:	490d                	li	s2,3
                if (initproc->wait_state == WT_CHILD)
ffffffffc020446e:	0985                	addi	s3,s3,1
ffffffffc0204470:	a021                	j	ffffffffc0204478 <do_exit+0xa0>
        while (current->cptr != NULL)
ffffffffc0204472:	6018                	ld	a4,0(s0)
ffffffffc0204474:	7b7c                	ld	a5,240(a4)
ffffffffc0204476:	cb85                	beqz	a5,ffffffffc02044a6 <do_exit+0xce>
            current->cptr = proc->optr;
ffffffffc0204478:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_obj___user_exit_out_size+0xffffffff7fff4fd8>
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc020447c:	6088                	ld	a0,0(s1)
            current->cptr = proc->optr;
ffffffffc020447e:	fb74                	sd	a3,240(a4)
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc0204480:	7978                	ld	a4,240(a0)
            proc->yptr = NULL;
ffffffffc0204482:	0e07bc23          	sd	zero,248(a5)
            if ((proc->optr = initproc->cptr) != NULL)
ffffffffc0204486:	10e7b023          	sd	a4,256(a5)
ffffffffc020448a:	c311                	beqz	a4,ffffffffc020448e <do_exit+0xb6>
                initproc->cptr->yptr = proc;
ffffffffc020448c:	ff7c                	sd	a5,248(a4)
            if (proc->state == PROC_ZOMBIE)
ffffffffc020448e:	4398                	lw	a4,0(a5)
            proc->parent = initproc;
ffffffffc0204490:	f388                	sd	a0,32(a5)
            initproc->cptr = proc;
ffffffffc0204492:	f97c                	sd	a5,240(a0)
            if (proc->state == PROC_ZOMBIE)
ffffffffc0204494:	fd271fe3          	bne	a4,s2,ffffffffc0204472 <do_exit+0x9a>
                if (initproc->wait_state == WT_CHILD)
ffffffffc0204498:	0ec52783          	lw	a5,236(a0)
ffffffffc020449c:	fd379be3          	bne	a5,s3,ffffffffc0204472 <do_exit+0x9a>
                    wakeup_proc(initproc);
ffffffffc02044a0:	373000ef          	jal	ra,ffffffffc0205012 <wakeup_proc>
ffffffffc02044a4:	b7f9                	j	ffffffffc0204472 <do_exit+0x9a>
    if (flag)
ffffffffc02044a6:	020a1263          	bnez	s4,ffffffffc02044ca <do_exit+0xf2>
    schedule();
ffffffffc02044aa:	3e9000ef          	jal	ra,ffffffffc0205092 <schedule>
    panic("do_exit will not return!! %d.\n", current->pid);
ffffffffc02044ae:	601c                	ld	a5,0(s0)
ffffffffc02044b0:	00003617          	auipc	a2,0x3
ffffffffc02044b4:	b4860613          	addi	a2,a2,-1208 # ffffffffc0206ff8 <default_pmm_manager+0xae8>
ffffffffc02044b8:	20100593          	li	a1,513
ffffffffc02044bc:	43d4                	lw	a3,4(a5)
ffffffffc02044be:	00003517          	auipc	a0,0x3
ffffffffc02044c2:	aba50513          	addi	a0,a0,-1350 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc02044c6:	fc9fb0ef          	jal	ra,ffffffffc020048e <__panic>
        intr_enable();
ffffffffc02044ca:	ce4fc0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc02044ce:	bff1                	j	ffffffffc02044aa <do_exit+0xd2>
        panic("idleproc exit.\n");
ffffffffc02044d0:	00003617          	auipc	a2,0x3
ffffffffc02044d4:	b0860613          	addi	a2,a2,-1272 # ffffffffc0206fd8 <default_pmm_manager+0xac8>
ffffffffc02044d8:	1cd00593          	li	a1,461
ffffffffc02044dc:	00003517          	auipc	a0,0x3
ffffffffc02044e0:	a9c50513          	addi	a0,a0,-1380 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc02044e4:	fabfb0ef          	jal	ra,ffffffffc020048e <__panic>
            exit_mmap(mm);
ffffffffc02044e8:	854e                	mv	a0,s3
ffffffffc02044ea:	cc6ff0ef          	jal	ra,ffffffffc02039b0 <exit_mmap>
            put_pgdir(mm);
ffffffffc02044ee:	854e                	mv	a0,s3
ffffffffc02044f0:	9f5ff0ef          	jal	ra,ffffffffc0203ee4 <put_pgdir>
            mm_destroy(mm);
ffffffffc02044f4:	854e                	mv	a0,s3
ffffffffc02044f6:	b1eff0ef          	jal	ra,ffffffffc0203814 <mm_destroy>
ffffffffc02044fa:	bf35                	j	ffffffffc0204436 <do_exit+0x5e>
        panic("initproc exit.\n");
ffffffffc02044fc:	00003617          	auipc	a2,0x3
ffffffffc0204500:	aec60613          	addi	a2,a2,-1300 # ffffffffc0206fe8 <default_pmm_manager+0xad8>
ffffffffc0204504:	1d100593          	li	a1,465
ffffffffc0204508:	00003517          	auipc	a0,0x3
ffffffffc020450c:	a7050513          	addi	a0,a0,-1424 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc0204510:	f7ffb0ef          	jal	ra,ffffffffc020048e <__panic>
        intr_disable();
ffffffffc0204514:	ca0fc0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc0204518:	4a05                	li	s4,1
ffffffffc020451a:	bf1d                	j	ffffffffc0204450 <do_exit+0x78>
            wakeup_proc(proc);
ffffffffc020451c:	2f7000ef          	jal	ra,ffffffffc0205012 <wakeup_proc>
ffffffffc0204520:	b789                	j	ffffffffc0204462 <do_exit+0x8a>

ffffffffc0204522 <do_wait.part.0>:
int do_wait(int pid, int *code_store)
ffffffffc0204522:	715d                	addi	sp,sp,-80
ffffffffc0204524:	f84a                	sd	s2,48(sp)
ffffffffc0204526:	f44e                	sd	s3,40(sp)
        current->wait_state = WT_CHILD;
ffffffffc0204528:	80000937          	lui	s2,0x80000
    if (0 < pid && pid < MAX_PID)
ffffffffc020452c:	6989                	lui	s3,0x2
int do_wait(int pid, int *code_store)
ffffffffc020452e:	fc26                	sd	s1,56(sp)
ffffffffc0204530:	f052                	sd	s4,32(sp)
ffffffffc0204532:	ec56                	sd	s5,24(sp)
ffffffffc0204534:	e85a                	sd	s6,16(sp)
ffffffffc0204536:	e45e                	sd	s7,8(sp)
ffffffffc0204538:	e486                	sd	ra,72(sp)
ffffffffc020453a:	e0a2                	sd	s0,64(sp)
ffffffffc020453c:	84aa                	mv	s1,a0
ffffffffc020453e:	8a2e                	mv	s4,a1
        proc = current->cptr;
ffffffffc0204540:	000b1b97          	auipc	s7,0xb1
ffffffffc0204544:	270b8b93          	addi	s7,s7,624 # ffffffffc02b57b0 <current>
    if (0 < pid && pid < MAX_PID)
ffffffffc0204548:	00050b1b          	sext.w	s6,a0
ffffffffc020454c:	fff50a9b          	addiw	s5,a0,-1
ffffffffc0204550:	19f9                	addi	s3,s3,-2
        current->wait_state = WT_CHILD;
ffffffffc0204552:	0905                	addi	s2,s2,1
    if (pid != 0)
ffffffffc0204554:	ccbd                	beqz	s1,ffffffffc02045d2 <do_wait.part.0+0xb0>
    if (0 < pid && pid < MAX_PID)
ffffffffc0204556:	0359e863          	bltu	s3,s5,ffffffffc0204586 <do_wait.part.0+0x64>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc020455a:	45a9                	li	a1,10
ffffffffc020455c:	855a                	mv	a0,s6
ffffffffc020455e:	4a1000ef          	jal	ra,ffffffffc02051fe <hash32>
ffffffffc0204562:	02051793          	slli	a5,a0,0x20
ffffffffc0204566:	01c7d513          	srli	a0,a5,0x1c
ffffffffc020456a:	000ad797          	auipc	a5,0xad
ffffffffc020456e:	1ce78793          	addi	a5,a5,462 # ffffffffc02b1738 <hash_list>
ffffffffc0204572:	953e                	add	a0,a0,a5
ffffffffc0204574:	842a                	mv	s0,a0
        while ((le = list_next(le)) != list)
ffffffffc0204576:	a029                	j	ffffffffc0204580 <do_wait.part.0+0x5e>
            if (proc->pid == pid)
ffffffffc0204578:	f2c42783          	lw	a5,-212(s0)
ffffffffc020457c:	02978163          	beq	a5,s1,ffffffffc020459e <do_wait.part.0+0x7c>
ffffffffc0204580:	6400                	ld	s0,8(s0)
        while ((le = list_next(le)) != list)
ffffffffc0204582:	fe851be3          	bne	a0,s0,ffffffffc0204578 <do_wait.part.0+0x56>
    return -E_BAD_PROC;
ffffffffc0204586:	5579                	li	a0,-2
}
ffffffffc0204588:	60a6                	ld	ra,72(sp)
ffffffffc020458a:	6406                	ld	s0,64(sp)
ffffffffc020458c:	74e2                	ld	s1,56(sp)
ffffffffc020458e:	7942                	ld	s2,48(sp)
ffffffffc0204590:	79a2                	ld	s3,40(sp)
ffffffffc0204592:	7a02                	ld	s4,32(sp)
ffffffffc0204594:	6ae2                	ld	s5,24(sp)
ffffffffc0204596:	6b42                	ld	s6,16(sp)
ffffffffc0204598:	6ba2                	ld	s7,8(sp)
ffffffffc020459a:	6161                	addi	sp,sp,80
ffffffffc020459c:	8082                	ret
        if (proc != NULL && proc->parent == current)
ffffffffc020459e:	000bb683          	ld	a3,0(s7)
ffffffffc02045a2:	f4843783          	ld	a5,-184(s0)
ffffffffc02045a6:	fed790e3          	bne	a5,a3,ffffffffc0204586 <do_wait.part.0+0x64>
            if (proc->state == PROC_ZOMBIE)
ffffffffc02045aa:	f2842703          	lw	a4,-216(s0)
ffffffffc02045ae:	478d                	li	a5,3
ffffffffc02045b0:	0ef70b63          	beq	a4,a5,ffffffffc02046a6 <do_wait.part.0+0x184>
        current->state = PROC_SLEEPING;
ffffffffc02045b4:	4785                	li	a5,1
ffffffffc02045b6:	c29c                	sw	a5,0(a3)
        current->wait_state = WT_CHILD;
ffffffffc02045b8:	0f26a623          	sw	s2,236(a3)
        schedule();
ffffffffc02045bc:	2d7000ef          	jal	ra,ffffffffc0205092 <schedule>
        if (current->flags & PF_EXITING)
ffffffffc02045c0:	000bb783          	ld	a5,0(s7)
ffffffffc02045c4:	0b07a783          	lw	a5,176(a5)
ffffffffc02045c8:	8b85                	andi	a5,a5,1
ffffffffc02045ca:	d7c9                	beqz	a5,ffffffffc0204554 <do_wait.part.0+0x32>
            do_exit(-E_KILLED);
ffffffffc02045cc:	555d                	li	a0,-9
ffffffffc02045ce:	e0bff0ef          	jal	ra,ffffffffc02043d8 <do_exit>
        proc = current->cptr;
ffffffffc02045d2:	000bb683          	ld	a3,0(s7)
ffffffffc02045d6:	7ae0                	ld	s0,240(a3)
        for (; proc != NULL; proc = proc->optr)
ffffffffc02045d8:	d45d                	beqz	s0,ffffffffc0204586 <do_wait.part.0+0x64>
            if (proc->state == PROC_ZOMBIE)
ffffffffc02045da:	470d                	li	a4,3
ffffffffc02045dc:	a021                	j	ffffffffc02045e4 <do_wait.part.0+0xc2>
        for (; proc != NULL; proc = proc->optr)
ffffffffc02045de:	10043403          	ld	s0,256(s0)
ffffffffc02045e2:	d869                	beqz	s0,ffffffffc02045b4 <do_wait.part.0+0x92>
            if (proc->state == PROC_ZOMBIE)
ffffffffc02045e4:	401c                	lw	a5,0(s0)
ffffffffc02045e6:	fee79ce3          	bne	a5,a4,ffffffffc02045de <do_wait.part.0+0xbc>
    if (proc == idleproc || proc == initproc)
ffffffffc02045ea:	000b1797          	auipc	a5,0xb1
ffffffffc02045ee:	1ce7b783          	ld	a5,462(a5) # ffffffffc02b57b8 <idleproc>
ffffffffc02045f2:	0c878963          	beq	a5,s0,ffffffffc02046c4 <do_wait.part.0+0x1a2>
ffffffffc02045f6:	000b1797          	auipc	a5,0xb1
ffffffffc02045fa:	1ca7b783          	ld	a5,458(a5) # ffffffffc02b57c0 <initproc>
ffffffffc02045fe:	0cf40363          	beq	s0,a5,ffffffffc02046c4 <do_wait.part.0+0x1a2>
    if (code_store != NULL)
ffffffffc0204602:	000a0663          	beqz	s4,ffffffffc020460e <do_wait.part.0+0xec>
        *code_store = proc->exit_code;
ffffffffc0204606:	0e842783          	lw	a5,232(s0)
ffffffffc020460a:	00fa2023          	sw	a5,0(s4) # 1000 <_binary_obj___user_faultread_out_size-0x8bb0>
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020460e:	100027f3          	csrr	a5,sstatus
ffffffffc0204612:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc0204614:	4581                	li	a1,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0204616:	e7c1                	bnez	a5,ffffffffc020469e <do_wait.part.0+0x17c>
    __list_del(listelm->prev, listelm->next);
ffffffffc0204618:	6c70                	ld	a2,216(s0)
ffffffffc020461a:	7074                	ld	a3,224(s0)
    if (proc->optr != NULL)
ffffffffc020461c:	10043703          	ld	a4,256(s0)
        proc->optr->yptr = proc->yptr;
ffffffffc0204620:	7c7c                	ld	a5,248(s0)
    prev->next = next;
ffffffffc0204622:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc0204624:	e290                	sd	a2,0(a3)
    __list_del(listelm->prev, listelm->next);
ffffffffc0204626:	6470                	ld	a2,200(s0)
ffffffffc0204628:	6874                	ld	a3,208(s0)
    prev->next = next;
ffffffffc020462a:	e614                	sd	a3,8(a2)
    next->prev = prev;
ffffffffc020462c:	e290                	sd	a2,0(a3)
    if (proc->optr != NULL)
ffffffffc020462e:	c319                	beqz	a4,ffffffffc0204634 <do_wait.part.0+0x112>
        proc->optr->yptr = proc->yptr;
ffffffffc0204630:	ff7c                	sd	a5,248(a4)
    if (proc->yptr != NULL)
ffffffffc0204632:	7c7c                	ld	a5,248(s0)
ffffffffc0204634:	c3b5                	beqz	a5,ffffffffc0204698 <do_wait.part.0+0x176>
        proc->yptr->optr = proc->optr;
ffffffffc0204636:	10e7b023          	sd	a4,256(a5)
    nr_process--;
ffffffffc020463a:	000b1717          	auipc	a4,0xb1
ffffffffc020463e:	18e70713          	addi	a4,a4,398 # ffffffffc02b57c8 <nr_process>
ffffffffc0204642:	431c                	lw	a5,0(a4)
ffffffffc0204644:	37fd                	addiw	a5,a5,-1
ffffffffc0204646:	c31c                	sw	a5,0(a4)
    if (flag)
ffffffffc0204648:	e5a9                	bnez	a1,ffffffffc0204692 <do_wait.part.0+0x170>
    free_pages(kva2page((void *)(proc->kstack)), KSTACKPAGE);
ffffffffc020464a:	6814                	ld	a3,16(s0)
ffffffffc020464c:	c02007b7          	lui	a5,0xc0200
ffffffffc0204650:	04f6ee63          	bltu	a3,a5,ffffffffc02046ac <do_wait.part.0+0x18a>
ffffffffc0204654:	000b1797          	auipc	a5,0xb1
ffffffffc0204658:	1547b783          	ld	a5,340(a5) # ffffffffc02b57a8 <va_pa_offset>
ffffffffc020465c:	8e9d                	sub	a3,a3,a5
    if (PPN(pa) >= npage)
ffffffffc020465e:	82b1                	srli	a3,a3,0xc
ffffffffc0204660:	000b1797          	auipc	a5,0xb1
ffffffffc0204664:	1307b783          	ld	a5,304(a5) # ffffffffc02b5790 <npage>
ffffffffc0204668:	06f6fa63          	bgeu	a3,a5,ffffffffc02046dc <do_wait.part.0+0x1ba>
    return &pages[PPN(pa) - nbase];
ffffffffc020466c:	00003517          	auipc	a0,0x3
ffffffffc0204670:	1c453503          	ld	a0,452(a0) # ffffffffc0207830 <nbase>
ffffffffc0204674:	8e89                	sub	a3,a3,a0
ffffffffc0204676:	069a                	slli	a3,a3,0x6
ffffffffc0204678:	000b1517          	auipc	a0,0xb1
ffffffffc020467c:	12053503          	ld	a0,288(a0) # ffffffffc02b5798 <pages>
ffffffffc0204680:	9536                	add	a0,a0,a3
ffffffffc0204682:	4589                	li	a1,2
ffffffffc0204684:	86bfd0ef          	jal	ra,ffffffffc0201eee <free_pages>
    kfree(proc);
ffffffffc0204688:	8522                	mv	a0,s0
ffffffffc020468a:	ef8fd0ef          	jal	ra,ffffffffc0201d82 <kfree>
    return 0;
ffffffffc020468e:	4501                	li	a0,0
ffffffffc0204690:	bde5                	j	ffffffffc0204588 <do_wait.part.0+0x66>
        intr_enable();
ffffffffc0204692:	b1cfc0ef          	jal	ra,ffffffffc02009ae <intr_enable>
ffffffffc0204696:	bf55                	j	ffffffffc020464a <do_wait.part.0+0x128>
        proc->parent->cptr = proc->optr;
ffffffffc0204698:	701c                	ld	a5,32(s0)
ffffffffc020469a:	fbf8                	sd	a4,240(a5)
ffffffffc020469c:	bf79                	j	ffffffffc020463a <do_wait.part.0+0x118>
        intr_disable();
ffffffffc020469e:	b16fc0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc02046a2:	4585                	li	a1,1
ffffffffc02046a4:	bf95                	j	ffffffffc0204618 <do_wait.part.0+0xf6>
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc02046a6:	f2840413          	addi	s0,s0,-216
ffffffffc02046aa:	b781                	j	ffffffffc02045ea <do_wait.part.0+0xc8>
    return pa2page(PADDR(kva));
ffffffffc02046ac:	00002617          	auipc	a2,0x2
ffffffffc02046b0:	f4460613          	addi	a2,a2,-188 # ffffffffc02065f0 <default_pmm_manager+0xe0>
ffffffffc02046b4:	07700593          	li	a1,119
ffffffffc02046b8:	00002517          	auipc	a0,0x2
ffffffffc02046bc:	eb850513          	addi	a0,a0,-328 # ffffffffc0206570 <default_pmm_manager+0x60>
ffffffffc02046c0:	dcffb0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("wait idleproc or initproc.\n");
ffffffffc02046c4:	00003617          	auipc	a2,0x3
ffffffffc02046c8:	95460613          	addi	a2,a2,-1708 # ffffffffc0207018 <default_pmm_manager+0xb08>
ffffffffc02046cc:	32600593          	li	a1,806
ffffffffc02046d0:	00003517          	auipc	a0,0x3
ffffffffc02046d4:	8a850513          	addi	a0,a0,-1880 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc02046d8:	db7fb0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("pa2page called with invalid pa");
ffffffffc02046dc:	00002617          	auipc	a2,0x2
ffffffffc02046e0:	f3c60613          	addi	a2,a2,-196 # ffffffffc0206618 <default_pmm_manager+0x108>
ffffffffc02046e4:	06900593          	li	a1,105
ffffffffc02046e8:	00002517          	auipc	a0,0x2
ffffffffc02046ec:	e8850513          	addi	a0,a0,-376 # ffffffffc0206570 <default_pmm_manager+0x60>
ffffffffc02046f0:	d9ffb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02046f4 <init_main>:
}

// init_main - the second kernel thread used to create user_main kernel threads
static int
init_main(void *arg)
{
ffffffffc02046f4:	1141                	addi	sp,sp,-16
ffffffffc02046f6:	e406                	sd	ra,8(sp)
    size_t nr_free_pages_store = nr_free_pages();
ffffffffc02046f8:	837fd0ef          	jal	ra,ffffffffc0201f2e <nr_free_pages>
    size_t kernel_allocated_store = kallocated();
ffffffffc02046fc:	dd2fd0ef          	jal	ra,ffffffffc0201cce <kallocated>

    int pid = kernel_thread(user_main, NULL, 0);
ffffffffc0204700:	4601                	li	a2,0
ffffffffc0204702:	4581                	li	a1,0
ffffffffc0204704:	fffff517          	auipc	a0,0xfffff
ffffffffc0204708:	76250513          	addi	a0,a0,1890 # ffffffffc0203e66 <user_main>
ffffffffc020470c:	c7dff0ef          	jal	ra,ffffffffc0204388 <kernel_thread>
    if (pid <= 0)
ffffffffc0204710:	00a04563          	bgtz	a0,ffffffffc020471a <init_main+0x26>
ffffffffc0204714:	a071                	j	ffffffffc02047a0 <init_main+0xac>
        panic("create user_main failed.\n");
    }

    while (do_wait(0, NULL) == 0)
    {
        schedule();
ffffffffc0204716:	17d000ef          	jal	ra,ffffffffc0205092 <schedule>
    if (code_store != NULL)
ffffffffc020471a:	4581                	li	a1,0
ffffffffc020471c:	4501                	li	a0,0
ffffffffc020471e:	e05ff0ef          	jal	ra,ffffffffc0204522 <do_wait.part.0>
    while (do_wait(0, NULL) == 0)
ffffffffc0204722:	d975                	beqz	a0,ffffffffc0204716 <init_main+0x22>
    }

    cprintf("all user-mode processes have quit.\n");
ffffffffc0204724:	00003517          	auipc	a0,0x3
ffffffffc0204728:	93450513          	addi	a0,a0,-1740 # ffffffffc0207058 <default_pmm_manager+0xb48>
ffffffffc020472c:	a69fb0ef          	jal	ra,ffffffffc0200194 <cprintf>
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0204730:	000b1797          	auipc	a5,0xb1
ffffffffc0204734:	0907b783          	ld	a5,144(a5) # ffffffffc02b57c0 <initproc>
ffffffffc0204738:	7bf8                	ld	a4,240(a5)
ffffffffc020473a:	e339                	bnez	a4,ffffffffc0204780 <init_main+0x8c>
ffffffffc020473c:	7ff8                	ld	a4,248(a5)
ffffffffc020473e:	e329                	bnez	a4,ffffffffc0204780 <init_main+0x8c>
ffffffffc0204740:	1007b703          	ld	a4,256(a5)
ffffffffc0204744:	ef15                	bnez	a4,ffffffffc0204780 <init_main+0x8c>
    assert(nr_process == 2);
ffffffffc0204746:	000b1697          	auipc	a3,0xb1
ffffffffc020474a:	0826a683          	lw	a3,130(a3) # ffffffffc02b57c8 <nr_process>
ffffffffc020474e:	4709                	li	a4,2
ffffffffc0204750:	0ae69463          	bne	a3,a4,ffffffffc02047f8 <init_main+0x104>
    return listelm->next;
ffffffffc0204754:	000b1697          	auipc	a3,0xb1
ffffffffc0204758:	fe468693          	addi	a3,a3,-28 # ffffffffc02b5738 <proc_list>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc020475c:	6698                	ld	a4,8(a3)
ffffffffc020475e:	0c878793          	addi	a5,a5,200
ffffffffc0204762:	06f71b63          	bne	a4,a5,ffffffffc02047d8 <init_main+0xe4>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc0204766:	629c                	ld	a5,0(a3)
ffffffffc0204768:	04f71863          	bne	a4,a5,ffffffffc02047b8 <init_main+0xc4>

    cprintf("init check memory pass.\n");
ffffffffc020476c:	00003517          	auipc	a0,0x3
ffffffffc0204770:	9d450513          	addi	a0,a0,-1580 # ffffffffc0207140 <default_pmm_manager+0xc30>
ffffffffc0204774:	a21fb0ef          	jal	ra,ffffffffc0200194 <cprintf>
    return 0;
}
ffffffffc0204778:	60a2                	ld	ra,8(sp)
ffffffffc020477a:	4501                	li	a0,0
ffffffffc020477c:	0141                	addi	sp,sp,16
ffffffffc020477e:	8082                	ret
    assert(initproc->cptr == NULL && initproc->yptr == NULL && initproc->optr == NULL);
ffffffffc0204780:	00003697          	auipc	a3,0x3
ffffffffc0204784:	90068693          	addi	a3,a3,-1792 # ffffffffc0207080 <default_pmm_manager+0xb70>
ffffffffc0204788:	00002617          	auipc	a2,0x2
ffffffffc020478c:	9d860613          	addi	a2,a2,-1576 # ffffffffc0206160 <commands+0x828>
ffffffffc0204790:	39000593          	li	a1,912
ffffffffc0204794:	00002517          	auipc	a0,0x2
ffffffffc0204798:	7e450513          	addi	a0,a0,2020 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc020479c:	cf3fb0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("create user_main failed.\n");
ffffffffc02047a0:	00003617          	auipc	a2,0x3
ffffffffc02047a4:	89860613          	addi	a2,a2,-1896 # ffffffffc0207038 <default_pmm_manager+0xb28>
ffffffffc02047a8:	38700593          	li	a1,903
ffffffffc02047ac:	00002517          	auipc	a0,0x2
ffffffffc02047b0:	7cc50513          	addi	a0,a0,1996 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc02047b4:	cdbfb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(list_prev(&proc_list) == &(initproc->list_link));
ffffffffc02047b8:	00003697          	auipc	a3,0x3
ffffffffc02047bc:	95868693          	addi	a3,a3,-1704 # ffffffffc0207110 <default_pmm_manager+0xc00>
ffffffffc02047c0:	00002617          	auipc	a2,0x2
ffffffffc02047c4:	9a060613          	addi	a2,a2,-1632 # ffffffffc0206160 <commands+0x828>
ffffffffc02047c8:	39300593          	li	a1,915
ffffffffc02047cc:	00002517          	auipc	a0,0x2
ffffffffc02047d0:	7ac50513          	addi	a0,a0,1964 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc02047d4:	cbbfb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(list_next(&proc_list) == &(initproc->list_link));
ffffffffc02047d8:	00003697          	auipc	a3,0x3
ffffffffc02047dc:	90868693          	addi	a3,a3,-1784 # ffffffffc02070e0 <default_pmm_manager+0xbd0>
ffffffffc02047e0:	00002617          	auipc	a2,0x2
ffffffffc02047e4:	98060613          	addi	a2,a2,-1664 # ffffffffc0206160 <commands+0x828>
ffffffffc02047e8:	39200593          	li	a1,914
ffffffffc02047ec:	00002517          	auipc	a0,0x2
ffffffffc02047f0:	78c50513          	addi	a0,a0,1932 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc02047f4:	c9bfb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(nr_process == 2);
ffffffffc02047f8:	00003697          	auipc	a3,0x3
ffffffffc02047fc:	8d868693          	addi	a3,a3,-1832 # ffffffffc02070d0 <default_pmm_manager+0xbc0>
ffffffffc0204800:	00002617          	auipc	a2,0x2
ffffffffc0204804:	96060613          	addi	a2,a2,-1696 # ffffffffc0206160 <commands+0x828>
ffffffffc0204808:	39100593          	li	a1,913
ffffffffc020480c:	00002517          	auipc	a0,0x2
ffffffffc0204810:	76c50513          	addi	a0,a0,1900 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc0204814:	c7bfb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0204818 <do_execve>:
{
ffffffffc0204818:	7171                	addi	sp,sp,-176
ffffffffc020481a:	e4ee                	sd	s11,72(sp)
    struct mm_struct *mm = current->mm;
ffffffffc020481c:	000b1d97          	auipc	s11,0xb1
ffffffffc0204820:	f94d8d93          	addi	s11,s11,-108 # ffffffffc02b57b0 <current>
ffffffffc0204824:	000db783          	ld	a5,0(s11)
{
ffffffffc0204828:	e54e                	sd	s3,136(sp)
ffffffffc020482a:	ed26                	sd	s1,152(sp)
    struct mm_struct *mm = current->mm;
ffffffffc020482c:	0287b983          	ld	s3,40(a5)
{
ffffffffc0204830:	e94a                	sd	s2,144(sp)
ffffffffc0204832:	f4de                	sd	s7,104(sp)
ffffffffc0204834:	892a                	mv	s2,a0
ffffffffc0204836:	8bb2                	mv	s7,a2
ffffffffc0204838:	84ae                	mv	s1,a1
    if (!user_mem_check(mm, (uintptr_t)name, len, 0))
ffffffffc020483a:	862e                	mv	a2,a1
ffffffffc020483c:	4681                	li	a3,0
ffffffffc020483e:	85aa                	mv	a1,a0
ffffffffc0204840:	854e                	mv	a0,s3
{
ffffffffc0204842:	f506                	sd	ra,168(sp)
ffffffffc0204844:	f122                	sd	s0,160(sp)
ffffffffc0204846:	e152                	sd	s4,128(sp)
ffffffffc0204848:	fcd6                	sd	s5,120(sp)
ffffffffc020484a:	f8da                	sd	s6,112(sp)
ffffffffc020484c:	f0e2                	sd	s8,96(sp)
ffffffffc020484e:	ece6                	sd	s9,88(sp)
ffffffffc0204850:	e8ea                	sd	s10,80(sp)
ffffffffc0204852:	f05e                	sd	s7,32(sp)
    if (!user_mem_check(mm, (uintptr_t)name, len, 0))
ffffffffc0204854:	cf6ff0ef          	jal	ra,ffffffffc0203d4a <user_mem_check>
ffffffffc0204858:	40050a63          	beqz	a0,ffffffffc0204c6c <do_execve+0x454>
    memset(local_name, 0, sizeof(local_name));
ffffffffc020485c:	4641                	li	a2,16
ffffffffc020485e:	4581                	li	a1,0
ffffffffc0204860:	1808                	addi	a0,sp,48
ffffffffc0204862:	643000ef          	jal	ra,ffffffffc02056a4 <memset>
    memcpy(local_name, name, len);
ffffffffc0204866:	47bd                	li	a5,15
ffffffffc0204868:	8626                	mv	a2,s1
ffffffffc020486a:	1e97e263          	bltu	a5,s1,ffffffffc0204a4e <do_execve+0x236>
ffffffffc020486e:	85ca                	mv	a1,s2
ffffffffc0204870:	1808                	addi	a0,sp,48
ffffffffc0204872:	645000ef          	jal	ra,ffffffffc02056b6 <memcpy>
    if (mm != NULL)
ffffffffc0204876:	1e098363          	beqz	s3,ffffffffc0204a5c <do_execve+0x244>
        cputs("mm != NULL");
ffffffffc020487a:	00002517          	auipc	a0,0x2
ffffffffc020487e:	4c650513          	addi	a0,a0,1222 # ffffffffc0206d40 <default_pmm_manager+0x830>
ffffffffc0204882:	94bfb0ef          	jal	ra,ffffffffc02001cc <cputs>
ffffffffc0204886:	000b1797          	auipc	a5,0xb1
ffffffffc020488a:	efa7b783          	ld	a5,-262(a5) # ffffffffc02b5780 <boot_pgdir_pa>
ffffffffc020488e:	577d                	li	a4,-1
ffffffffc0204890:	177e                	slli	a4,a4,0x3f
ffffffffc0204892:	83b1                	srli	a5,a5,0xc
ffffffffc0204894:	8fd9                	or	a5,a5,a4
ffffffffc0204896:	18079073          	csrw	satp,a5
ffffffffc020489a:	0309a783          	lw	a5,48(s3) # 2030 <_binary_obj___user_faultread_out_size-0x7b80>
ffffffffc020489e:	fff7871b          	addiw	a4,a5,-1
ffffffffc02048a2:	02e9a823          	sw	a4,48(s3)
        if (mm_count_dec(mm) == 0)
ffffffffc02048a6:	2c070463          	beqz	a4,ffffffffc0204b6e <do_execve+0x356>
        current->mm = NULL;
ffffffffc02048aa:	000db783          	ld	a5,0(s11)
ffffffffc02048ae:	0207b423          	sd	zero,40(a5)
    if ((mm = mm_create()) == NULL)
ffffffffc02048b2:	e23fe0ef          	jal	ra,ffffffffc02036d4 <mm_create>
ffffffffc02048b6:	84aa                	mv	s1,a0
ffffffffc02048b8:	1c050d63          	beqz	a0,ffffffffc0204a92 <do_execve+0x27a>
    if ((page = alloc_page()) == NULL)
ffffffffc02048bc:	4505                	li	a0,1
ffffffffc02048be:	df2fd0ef          	jal	ra,ffffffffc0201eb0 <alloc_pages>
ffffffffc02048c2:	3a050963          	beqz	a0,ffffffffc0204c74 <do_execve+0x45c>
    return page - pages + nbase;
ffffffffc02048c6:	000b1c97          	auipc	s9,0xb1
ffffffffc02048ca:	ed2c8c93          	addi	s9,s9,-302 # ffffffffc02b5798 <pages>
ffffffffc02048ce:	000cb683          	ld	a3,0(s9)
    return KADDR(page2pa(page));
ffffffffc02048d2:	000b1c17          	auipc	s8,0xb1
ffffffffc02048d6:	ebec0c13          	addi	s8,s8,-322 # ffffffffc02b5790 <npage>
    return page - pages + nbase;
ffffffffc02048da:	00003717          	auipc	a4,0x3
ffffffffc02048de:	f5673703          	ld	a4,-170(a4) # ffffffffc0207830 <nbase>
ffffffffc02048e2:	40d506b3          	sub	a3,a0,a3
ffffffffc02048e6:	8699                	srai	a3,a3,0x6
    return KADDR(page2pa(page));
ffffffffc02048e8:	5afd                	li	s5,-1
ffffffffc02048ea:	000c3783          	ld	a5,0(s8)
    return page - pages + nbase;
ffffffffc02048ee:	96ba                	add	a3,a3,a4
ffffffffc02048f0:	e83a                	sd	a4,16(sp)
    return KADDR(page2pa(page));
ffffffffc02048f2:	00cad713          	srli	a4,s5,0xc
ffffffffc02048f6:	ec3a                	sd	a4,24(sp)
ffffffffc02048f8:	8f75                	and	a4,a4,a3
    return page2ppn(page) << PGSHIFT;
ffffffffc02048fa:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc02048fc:	38f77063          	bgeu	a4,a5,ffffffffc0204c7c <do_execve+0x464>
ffffffffc0204900:	000b1b17          	auipc	s6,0xb1
ffffffffc0204904:	ea8b0b13          	addi	s6,s6,-344 # ffffffffc02b57a8 <va_pa_offset>
ffffffffc0204908:	000b3903          	ld	s2,0(s6)
    memcpy(pgdir, boot_pgdir_va, PGSIZE);
ffffffffc020490c:	6605                	lui	a2,0x1
ffffffffc020490e:	000b1597          	auipc	a1,0xb1
ffffffffc0204912:	e7a5b583          	ld	a1,-390(a1) # ffffffffc02b5788 <boot_pgdir_va>
ffffffffc0204916:	9936                	add	s2,s2,a3
ffffffffc0204918:	854a                	mv	a0,s2
ffffffffc020491a:	59d000ef          	jal	ra,ffffffffc02056b6 <memcpy>
    if (elf->e_magic != ELF_MAGIC)
ffffffffc020491e:	7782                	ld	a5,32(sp)
ffffffffc0204920:	4398                	lw	a4,0(a5)
ffffffffc0204922:	464c47b7          	lui	a5,0x464c4
    mm->pgdir = pgdir;
ffffffffc0204926:	0124bc23          	sd	s2,24(s1)
    if (elf->e_magic != ELF_MAGIC)
ffffffffc020492a:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_obj___user_exit_out_size+0x464b9457>
ffffffffc020492e:	14f71863          	bne	a4,a5,ffffffffc0204a7e <do_execve+0x266>
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0204932:	7682                	ld	a3,32(sp)
ffffffffc0204934:	0386d703          	lhu	a4,56(a3)
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0204938:	0206b983          	ld	s3,32(a3)
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc020493c:	00371793          	slli	a5,a4,0x3
ffffffffc0204940:	8f99                	sub	a5,a5,a4
    struct proghdr *ph = (struct proghdr *)(binary + elf->e_phoff);
ffffffffc0204942:	99b6                	add	s3,s3,a3
    struct proghdr *ph_end = ph + elf->e_phnum;
ffffffffc0204944:	078e                	slli	a5,a5,0x3
ffffffffc0204946:	97ce                	add	a5,a5,s3
ffffffffc0204948:	f43e                	sd	a5,40(sp)
    for (; ph < ph_end; ph++)
ffffffffc020494a:	00f9fc63          	bgeu	s3,a5,ffffffffc0204962 <do_execve+0x14a>
        if (ph->p_type != ELF_PT_LOAD)
ffffffffc020494e:	0009a783          	lw	a5,0(s3)
ffffffffc0204952:	4705                	li	a4,1
ffffffffc0204954:	14e78163          	beq	a5,a4,ffffffffc0204a96 <do_execve+0x27e>
    for (; ph < ph_end; ph++)
ffffffffc0204958:	77a2                	ld	a5,40(sp)
ffffffffc020495a:	03898993          	addi	s3,s3,56
ffffffffc020495e:	fef9e8e3          	bltu	s3,a5,ffffffffc020494e <do_execve+0x136>
    if ((ret = mm_map(mm, USTACKTOP - USTACKSIZE, USTACKSIZE, vm_flags, NULL)) != 0)
ffffffffc0204962:	4701                	li	a4,0
ffffffffc0204964:	46ad                	li	a3,11
ffffffffc0204966:	00100637          	lui	a2,0x100
ffffffffc020496a:	7ff005b7          	lui	a1,0x7ff00
ffffffffc020496e:	8526                	mv	a0,s1
ffffffffc0204970:	ef7fe0ef          	jal	ra,ffffffffc0203866 <mm_map>
ffffffffc0204974:	892a                	mv	s2,a0
ffffffffc0204976:	1e051263          	bnez	a0,ffffffffc0204b5a <do_execve+0x342>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - PGSIZE, PTE_USER) != NULL);
ffffffffc020497a:	6c88                	ld	a0,24(s1)
ffffffffc020497c:	467d                	li	a2,31
ffffffffc020497e:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc0204982:	c6dfe0ef          	jal	ra,ffffffffc02035ee <pgdir_alloc_page>
ffffffffc0204986:	38050363          	beqz	a0,ffffffffc0204d0c <do_execve+0x4f4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 2 * PGSIZE, PTE_USER) != NULL);
ffffffffc020498a:	6c88                	ld	a0,24(s1)
ffffffffc020498c:	467d                	li	a2,31
ffffffffc020498e:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc0204992:	c5dfe0ef          	jal	ra,ffffffffc02035ee <pgdir_alloc_page>
ffffffffc0204996:	34050b63          	beqz	a0,ffffffffc0204cec <do_execve+0x4d4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 3 * PGSIZE, PTE_USER) != NULL);
ffffffffc020499a:	6c88                	ld	a0,24(s1)
ffffffffc020499c:	467d                	li	a2,31
ffffffffc020499e:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc02049a2:	c4dfe0ef          	jal	ra,ffffffffc02035ee <pgdir_alloc_page>
ffffffffc02049a6:	32050363          	beqz	a0,ffffffffc0204ccc <do_execve+0x4b4>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 4 * PGSIZE, PTE_USER) != NULL);
ffffffffc02049aa:	6c88                	ld	a0,24(s1)
ffffffffc02049ac:	467d                	li	a2,31
ffffffffc02049ae:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc02049b2:	c3dfe0ef          	jal	ra,ffffffffc02035ee <pgdir_alloc_page>
ffffffffc02049b6:	2e050b63          	beqz	a0,ffffffffc0204cac <do_execve+0x494>
    mm->mm_count += 1;
ffffffffc02049ba:	589c                	lw	a5,48(s1)
    current->mm = mm;
ffffffffc02049bc:	000db603          	ld	a2,0(s11)
    current->pgdir = PADDR(mm->pgdir);
ffffffffc02049c0:	6c94                	ld	a3,24(s1)
ffffffffc02049c2:	2785                	addiw	a5,a5,1
ffffffffc02049c4:	d89c                	sw	a5,48(s1)
    current->mm = mm;
ffffffffc02049c6:	f604                	sd	s1,40(a2)
    current->pgdir = PADDR(mm->pgdir);
ffffffffc02049c8:	c02007b7          	lui	a5,0xc0200
ffffffffc02049cc:	2cf6e463          	bltu	a3,a5,ffffffffc0204c94 <do_execve+0x47c>
ffffffffc02049d0:	000b3783          	ld	a5,0(s6)
ffffffffc02049d4:	577d                	li	a4,-1
ffffffffc02049d6:	177e                	slli	a4,a4,0x3f
ffffffffc02049d8:	8e9d                	sub	a3,a3,a5
ffffffffc02049da:	00c6d793          	srli	a5,a3,0xc
ffffffffc02049de:	f654                	sd	a3,168(a2)
ffffffffc02049e0:	8fd9                	or	a5,a5,a4
ffffffffc02049e2:	18079073          	csrw	satp,a5
    struct trapframe *tf = current->tf;
ffffffffc02049e6:	7244                	ld	s1,160(a2)
    memset(tf, 0, sizeof(struct trapframe));
ffffffffc02049e8:	4581                	li	a1,0
ffffffffc02049ea:	12000613          	li	a2,288
ffffffffc02049ee:	8526                	mv	a0,s1
ffffffffc02049f0:	4b5000ef          	jal	ra,ffffffffc02056a4 <memset>
    tf->epc = elf->e_entry;
ffffffffc02049f4:	7782                	ld	a5,32(sp)
ffffffffc02049f6:	6f98                	ld	a4,24(a5)
    tf->gpr.sp = USTACKTOP;
ffffffffc02049f8:	4785                	li	a5,1
ffffffffc02049fa:	07fe                	slli	a5,a5,0x1f
ffffffffc02049fc:	e89c                	sd	a5,16(s1)
    tf->epc = elf->e_entry;
ffffffffc02049fe:	10e4b423          	sd	a4,264(s1)
    tf->status = (read_csr(sstatus) & ~SSTATUS_SPP) | SSTATUS_SPIE;
ffffffffc0204a02:	100027f3          	csrr	a5,sstatus
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204a06:	000db403          	ld	s0,0(s11)
    tf->status = (read_csr(sstatus) & ~SSTATUS_SPP) | SSTATUS_SPIE;
ffffffffc0204a0a:	edf7f793          	andi	a5,a5,-289
ffffffffc0204a0e:	0207e793          	ori	a5,a5,32
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204a12:	0b440413          	addi	s0,s0,180
ffffffffc0204a16:	4641                	li	a2,16
ffffffffc0204a18:	4581                	li	a1,0
    tf->status = (read_csr(sstatus) & ~SSTATUS_SPP) | SSTATUS_SPIE;
ffffffffc0204a1a:	10f4b023          	sd	a5,256(s1)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204a1e:	8522                	mv	a0,s0
ffffffffc0204a20:	485000ef          	jal	ra,ffffffffc02056a4 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204a24:	463d                	li	a2,15
ffffffffc0204a26:	180c                	addi	a1,sp,48
ffffffffc0204a28:	8522                	mv	a0,s0
ffffffffc0204a2a:	48d000ef          	jal	ra,ffffffffc02056b6 <memcpy>
}
ffffffffc0204a2e:	70aa                	ld	ra,168(sp)
ffffffffc0204a30:	740a                	ld	s0,160(sp)
ffffffffc0204a32:	64ea                	ld	s1,152(sp)
ffffffffc0204a34:	69aa                	ld	s3,136(sp)
ffffffffc0204a36:	6a0a                	ld	s4,128(sp)
ffffffffc0204a38:	7ae6                	ld	s5,120(sp)
ffffffffc0204a3a:	7b46                	ld	s6,112(sp)
ffffffffc0204a3c:	7ba6                	ld	s7,104(sp)
ffffffffc0204a3e:	7c06                	ld	s8,96(sp)
ffffffffc0204a40:	6ce6                	ld	s9,88(sp)
ffffffffc0204a42:	6d46                	ld	s10,80(sp)
ffffffffc0204a44:	6da6                	ld	s11,72(sp)
ffffffffc0204a46:	854a                	mv	a0,s2
ffffffffc0204a48:	694a                	ld	s2,144(sp)
ffffffffc0204a4a:	614d                	addi	sp,sp,176
ffffffffc0204a4c:	8082                	ret
    memcpy(local_name, name, len);
ffffffffc0204a4e:	463d                	li	a2,15
ffffffffc0204a50:	85ca                	mv	a1,s2
ffffffffc0204a52:	1808                	addi	a0,sp,48
ffffffffc0204a54:	463000ef          	jal	ra,ffffffffc02056b6 <memcpy>
    if (mm != NULL)
ffffffffc0204a58:	e20991e3          	bnez	s3,ffffffffc020487a <do_execve+0x62>
    if (current->mm != NULL)
ffffffffc0204a5c:	000db783          	ld	a5,0(s11)
ffffffffc0204a60:	779c                	ld	a5,40(a5)
ffffffffc0204a62:	e40788e3          	beqz	a5,ffffffffc02048b2 <do_execve+0x9a>
        panic("load_icode: current->mm must be empty.\n");
ffffffffc0204a66:	00002617          	auipc	a2,0x2
ffffffffc0204a6a:	6fa60613          	addi	a2,a2,1786 # ffffffffc0207160 <default_pmm_manager+0xc50>
ffffffffc0204a6e:	20d00593          	li	a1,525
ffffffffc0204a72:	00002517          	auipc	a0,0x2
ffffffffc0204a76:	50650513          	addi	a0,a0,1286 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc0204a7a:	a15fb0ef          	jal	ra,ffffffffc020048e <__panic>
    put_pgdir(mm);
ffffffffc0204a7e:	8526                	mv	a0,s1
ffffffffc0204a80:	c64ff0ef          	jal	ra,ffffffffc0203ee4 <put_pgdir>
    mm_destroy(mm);
ffffffffc0204a84:	8526                	mv	a0,s1
ffffffffc0204a86:	d8ffe0ef          	jal	ra,ffffffffc0203814 <mm_destroy>
        ret = -E_INVAL_ELF;
ffffffffc0204a8a:	5961                	li	s2,-8
    do_exit(ret);
ffffffffc0204a8c:	854a                	mv	a0,s2
ffffffffc0204a8e:	94bff0ef          	jal	ra,ffffffffc02043d8 <do_exit>
    int ret = -E_NO_MEM;
ffffffffc0204a92:	5971                	li	s2,-4
ffffffffc0204a94:	bfe5                	j	ffffffffc0204a8c <do_execve+0x274>
        if (ph->p_filesz > ph->p_memsz)
ffffffffc0204a96:	0289b603          	ld	a2,40(s3)
ffffffffc0204a9a:	0209b783          	ld	a5,32(s3)
ffffffffc0204a9e:	1cf66d63          	bltu	a2,a5,ffffffffc0204c78 <do_execve+0x460>
        if (ph->p_flags & ELF_PF_X)
ffffffffc0204aa2:	0049a783          	lw	a5,4(s3)
ffffffffc0204aa6:	0017f693          	andi	a3,a5,1
ffffffffc0204aaa:	c291                	beqz	a3,ffffffffc0204aae <do_execve+0x296>
            vm_flags |= VM_EXEC;
ffffffffc0204aac:	4691                	li	a3,4
        if (ph->p_flags & ELF_PF_W)
ffffffffc0204aae:	0027f713          	andi	a4,a5,2
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204ab2:	8b91                	andi	a5,a5,4
        if (ph->p_flags & ELF_PF_W)
ffffffffc0204ab4:	e779                	bnez	a4,ffffffffc0204b82 <do_execve+0x36a>
        vm_flags = 0, perm = PTE_U | PTE_V;
ffffffffc0204ab6:	4d45                	li	s10,17
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204ab8:	c781                	beqz	a5,ffffffffc0204ac0 <do_execve+0x2a8>
            vm_flags |= VM_READ;
ffffffffc0204aba:	0016e693          	ori	a3,a3,1
            perm |= PTE_R;
ffffffffc0204abe:	4d4d                	li	s10,19
        if (vm_flags & VM_WRITE)
ffffffffc0204ac0:	0026f793          	andi	a5,a3,2
ffffffffc0204ac4:	e3f1                	bnez	a5,ffffffffc0204b88 <do_execve+0x370>
        if (vm_flags & VM_EXEC)
ffffffffc0204ac6:	0046f793          	andi	a5,a3,4
ffffffffc0204aca:	c399                	beqz	a5,ffffffffc0204ad0 <do_execve+0x2b8>
            perm |= PTE_X;
ffffffffc0204acc:	008d6d13          	ori	s10,s10,8
        if ((ret = mm_map(mm, ph->p_va, ph->p_memsz, vm_flags, NULL)) != 0)
ffffffffc0204ad0:	0109b583          	ld	a1,16(s3)
ffffffffc0204ad4:	4701                	li	a4,0
ffffffffc0204ad6:	8526                	mv	a0,s1
ffffffffc0204ad8:	d8ffe0ef          	jal	ra,ffffffffc0203866 <mm_map>
ffffffffc0204adc:	892a                	mv	s2,a0
ffffffffc0204ade:	ed35                	bnez	a0,ffffffffc0204b5a <do_execve+0x342>
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204ae0:	0109bb83          	ld	s7,16(s3)
ffffffffc0204ae4:	77fd                	lui	a5,0xfffff
        end = ph->p_va + ph->p_filesz;
ffffffffc0204ae6:	0209ba03          	ld	s4,32(s3)
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204aea:	0089b903          	ld	s2,8(s3)
        uintptr_t start = ph->p_va, end, la = ROUNDDOWN(start, PGSIZE);
ffffffffc0204aee:	00fbfab3          	and	s5,s7,a5
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204af2:	7782                	ld	a5,32(sp)
        end = ph->p_va + ph->p_filesz;
ffffffffc0204af4:	9a5e                	add	s4,s4,s7
        unsigned char *from = binary + ph->p_offset;
ffffffffc0204af6:	993e                	add	s2,s2,a5
        while (start < end)
ffffffffc0204af8:	054be963          	bltu	s7,s4,ffffffffc0204b4a <do_execve+0x332>
ffffffffc0204afc:	aa95                	j	ffffffffc0204c70 <do_execve+0x458>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204afe:	6785                	lui	a5,0x1
ffffffffc0204b00:	415b8533          	sub	a0,s7,s5
ffffffffc0204b04:	9abe                	add	s5,s5,a5
ffffffffc0204b06:	417a8633          	sub	a2,s5,s7
            if (end < la)
ffffffffc0204b0a:	015a7463          	bgeu	s4,s5,ffffffffc0204b12 <do_execve+0x2fa>
                size -= la - end;
ffffffffc0204b0e:	417a0633          	sub	a2,s4,s7
    return page - pages + nbase;
ffffffffc0204b12:	000cb683          	ld	a3,0(s9)
ffffffffc0204b16:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204b18:	000c3583          	ld	a1,0(s8)
    return page - pages + nbase;
ffffffffc0204b1c:	40d406b3          	sub	a3,s0,a3
ffffffffc0204b20:	8699                	srai	a3,a3,0x6
ffffffffc0204b22:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204b24:	67e2                	ld	a5,24(sp)
ffffffffc0204b26:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204b2a:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204b2c:	14b87863          	bgeu	a6,a1,ffffffffc0204c7c <do_execve+0x464>
ffffffffc0204b30:	000b3803          	ld	a6,0(s6)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204b34:	85ca                	mv	a1,s2
            start += size, from += size;
ffffffffc0204b36:	9bb2                	add	s7,s7,a2
ffffffffc0204b38:	96c2                	add	a3,a3,a6
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204b3a:	9536                	add	a0,a0,a3
            start += size, from += size;
ffffffffc0204b3c:	e432                	sd	a2,8(sp)
            memcpy(page2kva(page) + off, from, size);
ffffffffc0204b3e:	379000ef          	jal	ra,ffffffffc02056b6 <memcpy>
            start += size, from += size;
ffffffffc0204b42:	6622                	ld	a2,8(sp)
ffffffffc0204b44:	9932                	add	s2,s2,a2
        while (start < end)
ffffffffc0204b46:	054bf363          	bgeu	s7,s4,ffffffffc0204b8c <do_execve+0x374>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
ffffffffc0204b4a:	6c88                	ld	a0,24(s1)
ffffffffc0204b4c:	866a                	mv	a2,s10
ffffffffc0204b4e:	85d6                	mv	a1,s5
ffffffffc0204b50:	a9ffe0ef          	jal	ra,ffffffffc02035ee <pgdir_alloc_page>
ffffffffc0204b54:	842a                	mv	s0,a0
ffffffffc0204b56:	f545                	bnez	a0,ffffffffc0204afe <do_execve+0x2e6>
        ret = -E_NO_MEM;
ffffffffc0204b58:	5971                	li	s2,-4
    exit_mmap(mm);
ffffffffc0204b5a:	8526                	mv	a0,s1
ffffffffc0204b5c:	e55fe0ef          	jal	ra,ffffffffc02039b0 <exit_mmap>
    put_pgdir(mm);
ffffffffc0204b60:	8526                	mv	a0,s1
ffffffffc0204b62:	b82ff0ef          	jal	ra,ffffffffc0203ee4 <put_pgdir>
    mm_destroy(mm);
ffffffffc0204b66:	8526                	mv	a0,s1
ffffffffc0204b68:	cadfe0ef          	jal	ra,ffffffffc0203814 <mm_destroy>
    return ret;
ffffffffc0204b6c:	b705                	j	ffffffffc0204a8c <do_execve+0x274>
            exit_mmap(mm);
ffffffffc0204b6e:	854e                	mv	a0,s3
ffffffffc0204b70:	e41fe0ef          	jal	ra,ffffffffc02039b0 <exit_mmap>
            put_pgdir(mm);
ffffffffc0204b74:	854e                	mv	a0,s3
ffffffffc0204b76:	b6eff0ef          	jal	ra,ffffffffc0203ee4 <put_pgdir>
            mm_destroy(mm);
ffffffffc0204b7a:	854e                	mv	a0,s3
ffffffffc0204b7c:	c99fe0ef          	jal	ra,ffffffffc0203814 <mm_destroy>
ffffffffc0204b80:	b32d                	j	ffffffffc02048aa <do_execve+0x92>
            vm_flags |= VM_WRITE;
ffffffffc0204b82:	0026e693          	ori	a3,a3,2
        if (ph->p_flags & ELF_PF_R)
ffffffffc0204b86:	fb95                	bnez	a5,ffffffffc0204aba <do_execve+0x2a2>
            perm |= (PTE_W | PTE_R);
ffffffffc0204b88:	4d5d                	li	s10,23
ffffffffc0204b8a:	bf35                	j	ffffffffc0204ac6 <do_execve+0x2ae>
        end = ph->p_va + ph->p_memsz;
ffffffffc0204b8c:	0109b683          	ld	a3,16(s3)
ffffffffc0204b90:	0289b903          	ld	s2,40(s3)
ffffffffc0204b94:	9936                	add	s2,s2,a3
        if (start < la)
ffffffffc0204b96:	075bfd63          	bgeu	s7,s5,ffffffffc0204c10 <do_execve+0x3f8>
            if (start == end)
ffffffffc0204b9a:	db790fe3          	beq	s2,s7,ffffffffc0204958 <do_execve+0x140>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204b9e:	6785                	lui	a5,0x1
ffffffffc0204ba0:	00fb8533          	add	a0,s7,a5
ffffffffc0204ba4:	41550533          	sub	a0,a0,s5
                size -= la - end;
ffffffffc0204ba8:	41790a33          	sub	s4,s2,s7
            if (end < la)
ffffffffc0204bac:	0b597d63          	bgeu	s2,s5,ffffffffc0204c66 <do_execve+0x44e>
    return page - pages + nbase;
ffffffffc0204bb0:	000cb683          	ld	a3,0(s9)
ffffffffc0204bb4:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204bb6:	000c3603          	ld	a2,0(s8)
    return page - pages + nbase;
ffffffffc0204bba:	40d406b3          	sub	a3,s0,a3
ffffffffc0204bbe:	8699                	srai	a3,a3,0x6
ffffffffc0204bc0:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204bc2:	67e2                	ld	a5,24(sp)
ffffffffc0204bc4:	00f6f5b3          	and	a1,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204bc8:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204bca:	0ac5f963          	bgeu	a1,a2,ffffffffc0204c7c <do_execve+0x464>
ffffffffc0204bce:	000b3803          	ld	a6,0(s6)
            memset(page2kva(page) + off, 0, size);
ffffffffc0204bd2:	8652                	mv	a2,s4
ffffffffc0204bd4:	4581                	li	a1,0
ffffffffc0204bd6:	96c2                	add	a3,a3,a6
ffffffffc0204bd8:	9536                	add	a0,a0,a3
ffffffffc0204bda:	2cb000ef          	jal	ra,ffffffffc02056a4 <memset>
            start += size;
ffffffffc0204bde:	017a0733          	add	a4,s4,s7
            assert((end < la && start == end) || (end >= la && start == la));
ffffffffc0204be2:	03597463          	bgeu	s2,s5,ffffffffc0204c0a <do_execve+0x3f2>
ffffffffc0204be6:	d6e909e3          	beq	s2,a4,ffffffffc0204958 <do_execve+0x140>
ffffffffc0204bea:	00002697          	auipc	a3,0x2
ffffffffc0204bee:	59e68693          	addi	a3,a3,1438 # ffffffffc0207188 <default_pmm_manager+0xc78>
ffffffffc0204bf2:	00001617          	auipc	a2,0x1
ffffffffc0204bf6:	56e60613          	addi	a2,a2,1390 # ffffffffc0206160 <commands+0x828>
ffffffffc0204bfa:	27600593          	li	a1,630
ffffffffc0204bfe:	00002517          	auipc	a0,0x2
ffffffffc0204c02:	37a50513          	addi	a0,a0,890 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc0204c06:	889fb0ef          	jal	ra,ffffffffc020048e <__panic>
ffffffffc0204c0a:	ff5710e3          	bne	a4,s5,ffffffffc0204bea <do_execve+0x3d2>
ffffffffc0204c0e:	8bd6                	mv	s7,s5
        while (start < end)
ffffffffc0204c10:	d52bf4e3          	bgeu	s7,s2,ffffffffc0204958 <do_execve+0x140>
            if ((page = pgdir_alloc_page(mm->pgdir, la, perm)) == NULL)
ffffffffc0204c14:	6c88                	ld	a0,24(s1)
ffffffffc0204c16:	866a                	mv	a2,s10
ffffffffc0204c18:	85d6                	mv	a1,s5
ffffffffc0204c1a:	9d5fe0ef          	jal	ra,ffffffffc02035ee <pgdir_alloc_page>
ffffffffc0204c1e:	842a                	mv	s0,a0
ffffffffc0204c20:	dd05                	beqz	a0,ffffffffc0204b58 <do_execve+0x340>
            off = start - la, size = PGSIZE - off, la += PGSIZE;
ffffffffc0204c22:	6785                	lui	a5,0x1
ffffffffc0204c24:	415b8533          	sub	a0,s7,s5
ffffffffc0204c28:	9abe                	add	s5,s5,a5
ffffffffc0204c2a:	417a8633          	sub	a2,s5,s7
            if (end < la)
ffffffffc0204c2e:	01597463          	bgeu	s2,s5,ffffffffc0204c36 <do_execve+0x41e>
                size -= la - end;
ffffffffc0204c32:	41790633          	sub	a2,s2,s7
    return page - pages + nbase;
ffffffffc0204c36:	000cb683          	ld	a3,0(s9)
ffffffffc0204c3a:	67c2                	ld	a5,16(sp)
    return KADDR(page2pa(page));
ffffffffc0204c3c:	000c3583          	ld	a1,0(s8)
    return page - pages + nbase;
ffffffffc0204c40:	40d406b3          	sub	a3,s0,a3
ffffffffc0204c44:	8699                	srai	a3,a3,0x6
ffffffffc0204c46:	96be                	add	a3,a3,a5
    return KADDR(page2pa(page));
ffffffffc0204c48:	67e2                	ld	a5,24(sp)
ffffffffc0204c4a:	00f6f833          	and	a6,a3,a5
    return page2ppn(page) << PGSHIFT;
ffffffffc0204c4e:	06b2                	slli	a3,a3,0xc
    return KADDR(page2pa(page));
ffffffffc0204c50:	02b87663          	bgeu	a6,a1,ffffffffc0204c7c <do_execve+0x464>
ffffffffc0204c54:	000b3803          	ld	a6,0(s6)
            memset(page2kva(page) + off, 0, size);
ffffffffc0204c58:	4581                	li	a1,0
            start += size;
ffffffffc0204c5a:	9bb2                	add	s7,s7,a2
ffffffffc0204c5c:	96c2                	add	a3,a3,a6
            memset(page2kva(page) + off, 0, size);
ffffffffc0204c5e:	9536                	add	a0,a0,a3
ffffffffc0204c60:	245000ef          	jal	ra,ffffffffc02056a4 <memset>
ffffffffc0204c64:	b775                	j	ffffffffc0204c10 <do_execve+0x3f8>
            off = start + PGSIZE - la, size = PGSIZE - off;
ffffffffc0204c66:	417a8a33          	sub	s4,s5,s7
ffffffffc0204c6a:	b799                	j	ffffffffc0204bb0 <do_execve+0x398>
        return -E_INVAL;
ffffffffc0204c6c:	5975                	li	s2,-3
ffffffffc0204c6e:	b3c1                	j	ffffffffc0204a2e <do_execve+0x216>
        while (start < end)
ffffffffc0204c70:	86de                	mv	a3,s7
ffffffffc0204c72:	bf39                	j	ffffffffc0204b90 <do_execve+0x378>
    int ret = -E_NO_MEM;
ffffffffc0204c74:	5971                	li	s2,-4
ffffffffc0204c76:	bdc5                	j	ffffffffc0204b66 <do_execve+0x34e>
            ret = -E_INVAL_ELF;
ffffffffc0204c78:	5961                	li	s2,-8
ffffffffc0204c7a:	b5c5                	j	ffffffffc0204b5a <do_execve+0x342>
ffffffffc0204c7c:	00002617          	auipc	a2,0x2
ffffffffc0204c80:	8cc60613          	addi	a2,a2,-1844 # ffffffffc0206548 <default_pmm_manager+0x38>
ffffffffc0204c84:	07100593          	li	a1,113
ffffffffc0204c88:	00002517          	auipc	a0,0x2
ffffffffc0204c8c:	8e850513          	addi	a0,a0,-1816 # ffffffffc0206570 <default_pmm_manager+0x60>
ffffffffc0204c90:	ffefb0ef          	jal	ra,ffffffffc020048e <__panic>
    current->pgdir = PADDR(mm->pgdir);
ffffffffc0204c94:	00002617          	auipc	a2,0x2
ffffffffc0204c98:	95c60613          	addi	a2,a2,-1700 # ffffffffc02065f0 <default_pmm_manager+0xe0>
ffffffffc0204c9c:	29500593          	li	a1,661
ffffffffc0204ca0:	00002517          	auipc	a0,0x2
ffffffffc0204ca4:	2d850513          	addi	a0,a0,728 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc0204ca8:	fe6fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 4 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204cac:	00002697          	auipc	a3,0x2
ffffffffc0204cb0:	5f468693          	addi	a3,a3,1524 # ffffffffc02072a0 <default_pmm_manager+0xd90>
ffffffffc0204cb4:	00001617          	auipc	a2,0x1
ffffffffc0204cb8:	4ac60613          	addi	a2,a2,1196 # ffffffffc0206160 <commands+0x828>
ffffffffc0204cbc:	29000593          	li	a1,656
ffffffffc0204cc0:	00002517          	auipc	a0,0x2
ffffffffc0204cc4:	2b850513          	addi	a0,a0,696 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc0204cc8:	fc6fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 3 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204ccc:	00002697          	auipc	a3,0x2
ffffffffc0204cd0:	58c68693          	addi	a3,a3,1420 # ffffffffc0207258 <default_pmm_manager+0xd48>
ffffffffc0204cd4:	00001617          	auipc	a2,0x1
ffffffffc0204cd8:	48c60613          	addi	a2,a2,1164 # ffffffffc0206160 <commands+0x828>
ffffffffc0204cdc:	28f00593          	li	a1,655
ffffffffc0204ce0:	00002517          	auipc	a0,0x2
ffffffffc0204ce4:	29850513          	addi	a0,a0,664 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc0204ce8:	fa6fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - 2 * PGSIZE, PTE_USER) != NULL);
ffffffffc0204cec:	00002697          	auipc	a3,0x2
ffffffffc0204cf0:	52468693          	addi	a3,a3,1316 # ffffffffc0207210 <default_pmm_manager+0xd00>
ffffffffc0204cf4:	00001617          	auipc	a2,0x1
ffffffffc0204cf8:	46c60613          	addi	a2,a2,1132 # ffffffffc0206160 <commands+0x828>
ffffffffc0204cfc:	28e00593          	li	a1,654
ffffffffc0204d00:	00002517          	auipc	a0,0x2
ffffffffc0204d04:	27850513          	addi	a0,a0,632 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc0204d08:	f86fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(pgdir_alloc_page(mm->pgdir, USTACKTOP - PGSIZE, PTE_USER) != NULL);
ffffffffc0204d0c:	00002697          	auipc	a3,0x2
ffffffffc0204d10:	4bc68693          	addi	a3,a3,1212 # ffffffffc02071c8 <default_pmm_manager+0xcb8>
ffffffffc0204d14:	00001617          	auipc	a2,0x1
ffffffffc0204d18:	44c60613          	addi	a2,a2,1100 # ffffffffc0206160 <commands+0x828>
ffffffffc0204d1c:	28d00593          	li	a1,653
ffffffffc0204d20:	00002517          	auipc	a0,0x2
ffffffffc0204d24:	25850513          	addi	a0,a0,600 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc0204d28:	f66fb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0204d2c <do_yield>:
    current->need_resched = 1;
ffffffffc0204d2c:	000b1797          	auipc	a5,0xb1
ffffffffc0204d30:	a847b783          	ld	a5,-1404(a5) # ffffffffc02b57b0 <current>
ffffffffc0204d34:	4705                	li	a4,1
ffffffffc0204d36:	ef98                	sd	a4,24(a5)
}
ffffffffc0204d38:	4501                	li	a0,0
ffffffffc0204d3a:	8082                	ret

ffffffffc0204d3c <do_wait>:
{
ffffffffc0204d3c:	1101                	addi	sp,sp,-32
ffffffffc0204d3e:	e822                	sd	s0,16(sp)
ffffffffc0204d40:	e426                	sd	s1,8(sp)
ffffffffc0204d42:	ec06                	sd	ra,24(sp)
ffffffffc0204d44:	842e                	mv	s0,a1
ffffffffc0204d46:	84aa                	mv	s1,a0
    if (code_store != NULL)
ffffffffc0204d48:	c999                	beqz	a1,ffffffffc0204d5e <do_wait+0x22>
    struct mm_struct *mm = current->mm;
ffffffffc0204d4a:	000b1797          	auipc	a5,0xb1
ffffffffc0204d4e:	a667b783          	ld	a5,-1434(a5) # ffffffffc02b57b0 <current>
        if (!user_mem_check(mm, (uintptr_t)code_store, sizeof(int), 1))
ffffffffc0204d52:	7788                	ld	a0,40(a5)
ffffffffc0204d54:	4685                	li	a3,1
ffffffffc0204d56:	4611                	li	a2,4
ffffffffc0204d58:	ff3fe0ef          	jal	ra,ffffffffc0203d4a <user_mem_check>
ffffffffc0204d5c:	c909                	beqz	a0,ffffffffc0204d6e <do_wait+0x32>
ffffffffc0204d5e:	85a2                	mv	a1,s0
}
ffffffffc0204d60:	6442                	ld	s0,16(sp)
ffffffffc0204d62:	60e2                	ld	ra,24(sp)
ffffffffc0204d64:	8526                	mv	a0,s1
ffffffffc0204d66:	64a2                	ld	s1,8(sp)
ffffffffc0204d68:	6105                	addi	sp,sp,32
ffffffffc0204d6a:	fb8ff06f          	j	ffffffffc0204522 <do_wait.part.0>
ffffffffc0204d6e:	60e2                	ld	ra,24(sp)
ffffffffc0204d70:	6442                	ld	s0,16(sp)
ffffffffc0204d72:	64a2                	ld	s1,8(sp)
ffffffffc0204d74:	5575                	li	a0,-3
ffffffffc0204d76:	6105                	addi	sp,sp,32
ffffffffc0204d78:	8082                	ret

ffffffffc0204d7a <do_kill>:
{
ffffffffc0204d7a:	1141                	addi	sp,sp,-16
    if (0 < pid && pid < MAX_PID)
ffffffffc0204d7c:	6789                	lui	a5,0x2
{
ffffffffc0204d7e:	e406                	sd	ra,8(sp)
ffffffffc0204d80:	e022                	sd	s0,0(sp)
    if (0 < pid && pid < MAX_PID)
ffffffffc0204d82:	fff5071b          	addiw	a4,a0,-1
ffffffffc0204d86:	17f9                	addi	a5,a5,-2
ffffffffc0204d88:	02e7e963          	bltu	a5,a4,ffffffffc0204dba <do_kill+0x40>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204d8c:	842a                	mv	s0,a0
ffffffffc0204d8e:	45a9                	li	a1,10
ffffffffc0204d90:	2501                	sext.w	a0,a0
ffffffffc0204d92:	46c000ef          	jal	ra,ffffffffc02051fe <hash32>
ffffffffc0204d96:	02051793          	slli	a5,a0,0x20
ffffffffc0204d9a:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0204d9e:	000ad797          	auipc	a5,0xad
ffffffffc0204da2:	99a78793          	addi	a5,a5,-1638 # ffffffffc02b1738 <hash_list>
ffffffffc0204da6:	953e                	add	a0,a0,a5
ffffffffc0204da8:	87aa                	mv	a5,a0
        while ((le = list_next(le)) != list)
ffffffffc0204daa:	a029                	j	ffffffffc0204db4 <do_kill+0x3a>
            if (proc->pid == pid)
ffffffffc0204dac:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0204db0:	00870b63          	beq	a4,s0,ffffffffc0204dc6 <do_kill+0x4c>
ffffffffc0204db4:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204db6:	fef51be3          	bne	a0,a5,ffffffffc0204dac <do_kill+0x32>
    return -E_INVAL;
ffffffffc0204dba:	5475                	li	s0,-3
}
ffffffffc0204dbc:	60a2                	ld	ra,8(sp)
ffffffffc0204dbe:	8522                	mv	a0,s0
ffffffffc0204dc0:	6402                	ld	s0,0(sp)
ffffffffc0204dc2:	0141                	addi	sp,sp,16
ffffffffc0204dc4:	8082                	ret
        if (!(proc->flags & PF_EXITING))
ffffffffc0204dc6:	fd87a703          	lw	a4,-40(a5)
ffffffffc0204dca:	00177693          	andi	a3,a4,1
ffffffffc0204dce:	e295                	bnez	a3,ffffffffc0204df2 <do_kill+0x78>
            if (proc->wait_state & WT_INTERRUPTED)
ffffffffc0204dd0:	4bd4                	lw	a3,20(a5)
            proc->flags |= PF_EXITING;
ffffffffc0204dd2:	00176713          	ori	a4,a4,1
ffffffffc0204dd6:	fce7ac23          	sw	a4,-40(a5)
            return 0;
ffffffffc0204dda:	4401                	li	s0,0
            if (proc->wait_state & WT_INTERRUPTED)
ffffffffc0204ddc:	fe06d0e3          	bgez	a3,ffffffffc0204dbc <do_kill+0x42>
                wakeup_proc(proc);
ffffffffc0204de0:	f2878513          	addi	a0,a5,-216
ffffffffc0204de4:	22e000ef          	jal	ra,ffffffffc0205012 <wakeup_proc>
}
ffffffffc0204de8:	60a2                	ld	ra,8(sp)
ffffffffc0204dea:	8522                	mv	a0,s0
ffffffffc0204dec:	6402                	ld	s0,0(sp)
ffffffffc0204dee:	0141                	addi	sp,sp,16
ffffffffc0204df0:	8082                	ret
        return -E_KILLED;
ffffffffc0204df2:	545d                	li	s0,-9
ffffffffc0204df4:	b7e1                	j	ffffffffc0204dbc <do_kill+0x42>

ffffffffc0204df6 <proc_init>:

// proc_init - set up the first kernel thread idleproc "idle" by itself and
//           - create the second kernel thread init_main
void proc_init(void)
{
ffffffffc0204df6:	1101                	addi	sp,sp,-32
ffffffffc0204df8:	e426                	sd	s1,8(sp)
    elm->prev = elm->next = elm;
ffffffffc0204dfa:	000b1797          	auipc	a5,0xb1
ffffffffc0204dfe:	93e78793          	addi	a5,a5,-1730 # ffffffffc02b5738 <proc_list>
ffffffffc0204e02:	ec06                	sd	ra,24(sp)
ffffffffc0204e04:	e822                	sd	s0,16(sp)
ffffffffc0204e06:	e04a                	sd	s2,0(sp)
ffffffffc0204e08:	000ad497          	auipc	s1,0xad
ffffffffc0204e0c:	93048493          	addi	s1,s1,-1744 # ffffffffc02b1738 <hash_list>
ffffffffc0204e10:	e79c                	sd	a5,8(a5)
ffffffffc0204e12:	e39c                	sd	a5,0(a5)
    int i;

    list_init(&proc_list);
    for (i = 0; i < HASH_LIST_SIZE; i++)
ffffffffc0204e14:	000b1717          	auipc	a4,0xb1
ffffffffc0204e18:	92470713          	addi	a4,a4,-1756 # ffffffffc02b5738 <proc_list>
ffffffffc0204e1c:	87a6                	mv	a5,s1
ffffffffc0204e1e:	e79c                	sd	a5,8(a5)
ffffffffc0204e20:	e39c                	sd	a5,0(a5)
ffffffffc0204e22:	07c1                	addi	a5,a5,16
ffffffffc0204e24:	fef71de3          	bne	a4,a5,ffffffffc0204e1e <proc_init+0x28>
    {
        list_init(hash_list + i);
    }

    if ((idleproc = alloc_proc()) == NULL)
ffffffffc0204e28:	fbffe0ef          	jal	ra,ffffffffc0203de6 <alloc_proc>
ffffffffc0204e2c:	000b1917          	auipc	s2,0xb1
ffffffffc0204e30:	98c90913          	addi	s2,s2,-1652 # ffffffffc02b57b8 <idleproc>
ffffffffc0204e34:	00a93023          	sd	a0,0(s2)
ffffffffc0204e38:	0e050f63          	beqz	a0,ffffffffc0204f36 <proc_init+0x140>
    {
        panic("cannot alloc idleproc.\n");
    }

    idleproc->pid = 0;
    idleproc->state = PROC_RUNNABLE;
ffffffffc0204e3c:	4789                	li	a5,2
ffffffffc0204e3e:	e11c                	sd	a5,0(a0)
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204e40:	00003797          	auipc	a5,0x3
ffffffffc0204e44:	1c078793          	addi	a5,a5,448 # ffffffffc0208000 <bootstack>
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204e48:	0b450413          	addi	s0,a0,180
    idleproc->kstack = (uintptr_t)bootstack;
ffffffffc0204e4c:	e91c                	sd	a5,16(a0)
    idleproc->need_resched = 1;
ffffffffc0204e4e:	4785                	li	a5,1
ffffffffc0204e50:	ed1c                	sd	a5,24(a0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204e52:	4641                	li	a2,16
ffffffffc0204e54:	4581                	li	a1,0
ffffffffc0204e56:	8522                	mv	a0,s0
ffffffffc0204e58:	04d000ef          	jal	ra,ffffffffc02056a4 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204e5c:	463d                	li	a2,15
ffffffffc0204e5e:	00002597          	auipc	a1,0x2
ffffffffc0204e62:	4a258593          	addi	a1,a1,1186 # ffffffffc0207300 <default_pmm_manager+0xdf0>
ffffffffc0204e66:	8522                	mv	a0,s0
ffffffffc0204e68:	04f000ef          	jal	ra,ffffffffc02056b6 <memcpy>
    set_proc_name(idleproc, "idle");
    nr_process++;
ffffffffc0204e6c:	000b1717          	auipc	a4,0xb1
ffffffffc0204e70:	95c70713          	addi	a4,a4,-1700 # ffffffffc02b57c8 <nr_process>
ffffffffc0204e74:	431c                	lw	a5,0(a4)

    current = idleproc;
ffffffffc0204e76:	00093683          	ld	a3,0(s2)

    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204e7a:	4601                	li	a2,0
    nr_process++;
ffffffffc0204e7c:	2785                	addiw	a5,a5,1
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204e7e:	4581                	li	a1,0
ffffffffc0204e80:	00000517          	auipc	a0,0x0
ffffffffc0204e84:	87450513          	addi	a0,a0,-1932 # ffffffffc02046f4 <init_main>
    nr_process++;
ffffffffc0204e88:	c31c                	sw	a5,0(a4)
    current = idleproc;
ffffffffc0204e8a:	000b1797          	auipc	a5,0xb1
ffffffffc0204e8e:	92d7b323          	sd	a3,-1754(a5) # ffffffffc02b57b0 <current>
    int pid = kernel_thread(init_main, NULL, 0);
ffffffffc0204e92:	cf6ff0ef          	jal	ra,ffffffffc0204388 <kernel_thread>
ffffffffc0204e96:	842a                	mv	s0,a0
    if (pid <= 0)
ffffffffc0204e98:	08a05363          	blez	a0,ffffffffc0204f1e <proc_init+0x128>
    if (0 < pid && pid < MAX_PID)
ffffffffc0204e9c:	6789                	lui	a5,0x2
ffffffffc0204e9e:	fff5071b          	addiw	a4,a0,-1
ffffffffc0204ea2:	17f9                	addi	a5,a5,-2
ffffffffc0204ea4:	2501                	sext.w	a0,a0
ffffffffc0204ea6:	02e7e363          	bltu	a5,a4,ffffffffc0204ecc <proc_init+0xd6>
        list_entry_t *list = hash_list + pid_hashfn(pid), *le = list;
ffffffffc0204eaa:	45a9                	li	a1,10
ffffffffc0204eac:	352000ef          	jal	ra,ffffffffc02051fe <hash32>
ffffffffc0204eb0:	02051793          	slli	a5,a0,0x20
ffffffffc0204eb4:	01c7d693          	srli	a3,a5,0x1c
ffffffffc0204eb8:	96a6                	add	a3,a3,s1
ffffffffc0204eba:	87b6                	mv	a5,a3
        while ((le = list_next(le)) != list)
ffffffffc0204ebc:	a029                	j	ffffffffc0204ec6 <proc_init+0xd0>
            if (proc->pid == pid)
ffffffffc0204ebe:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_obj___user_faultread_out_size-0x7c84>
ffffffffc0204ec2:	04870b63          	beq	a4,s0,ffffffffc0204f18 <proc_init+0x122>
    return listelm->next;
ffffffffc0204ec6:	679c                	ld	a5,8(a5)
        while ((le = list_next(le)) != list)
ffffffffc0204ec8:	fef69be3          	bne	a3,a5,ffffffffc0204ebe <proc_init+0xc8>
    return NULL;
ffffffffc0204ecc:	4781                	li	a5,0
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204ece:	0b478493          	addi	s1,a5,180
ffffffffc0204ed2:	4641                	li	a2,16
ffffffffc0204ed4:	4581                	li	a1,0
    {
        panic("create init_main failed.\n");
    }

    initproc = find_proc(pid);
ffffffffc0204ed6:	000b1417          	auipc	s0,0xb1
ffffffffc0204eda:	8ea40413          	addi	s0,s0,-1814 # ffffffffc02b57c0 <initproc>
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204ede:	8526                	mv	a0,s1
    initproc = find_proc(pid);
ffffffffc0204ee0:	e01c                	sd	a5,0(s0)
    memset(proc->name, 0, sizeof(proc->name));
ffffffffc0204ee2:	7c2000ef          	jal	ra,ffffffffc02056a4 <memset>
    return memcpy(proc->name, name, PROC_NAME_LEN);
ffffffffc0204ee6:	463d                	li	a2,15
ffffffffc0204ee8:	00002597          	auipc	a1,0x2
ffffffffc0204eec:	44058593          	addi	a1,a1,1088 # ffffffffc0207328 <default_pmm_manager+0xe18>
ffffffffc0204ef0:	8526                	mv	a0,s1
ffffffffc0204ef2:	7c4000ef          	jal	ra,ffffffffc02056b6 <memcpy>
    set_proc_name(initproc, "init");

    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc0204ef6:	00093783          	ld	a5,0(s2)
ffffffffc0204efa:	cbb5                	beqz	a5,ffffffffc0204f6e <proc_init+0x178>
ffffffffc0204efc:	43dc                	lw	a5,4(a5)
ffffffffc0204efe:	eba5                	bnez	a5,ffffffffc0204f6e <proc_init+0x178>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204f00:	601c                	ld	a5,0(s0)
ffffffffc0204f02:	c7b1                	beqz	a5,ffffffffc0204f4e <proc_init+0x158>
ffffffffc0204f04:	43d8                	lw	a4,4(a5)
ffffffffc0204f06:	4785                	li	a5,1
ffffffffc0204f08:	04f71363          	bne	a4,a5,ffffffffc0204f4e <proc_init+0x158>
}
ffffffffc0204f0c:	60e2                	ld	ra,24(sp)
ffffffffc0204f0e:	6442                	ld	s0,16(sp)
ffffffffc0204f10:	64a2                	ld	s1,8(sp)
ffffffffc0204f12:	6902                	ld	s2,0(sp)
ffffffffc0204f14:	6105                	addi	sp,sp,32
ffffffffc0204f16:	8082                	ret
            struct proc_struct *proc = le2proc(le, hash_link);
ffffffffc0204f18:	f2878793          	addi	a5,a5,-216
ffffffffc0204f1c:	bf4d                	j	ffffffffc0204ece <proc_init+0xd8>
        panic("create init_main failed.\n");
ffffffffc0204f1e:	00002617          	auipc	a2,0x2
ffffffffc0204f22:	3ea60613          	addi	a2,a2,1002 # ffffffffc0207308 <default_pmm_manager+0xdf8>
ffffffffc0204f26:	3b600593          	li	a1,950
ffffffffc0204f2a:	00002517          	auipc	a0,0x2
ffffffffc0204f2e:	04e50513          	addi	a0,a0,78 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc0204f32:	d5cfb0ef          	jal	ra,ffffffffc020048e <__panic>
        panic("cannot alloc idleproc.\n");
ffffffffc0204f36:	00002617          	auipc	a2,0x2
ffffffffc0204f3a:	3b260613          	addi	a2,a2,946 # ffffffffc02072e8 <default_pmm_manager+0xdd8>
ffffffffc0204f3e:	3a700593          	li	a1,935
ffffffffc0204f42:	00002517          	auipc	a0,0x2
ffffffffc0204f46:	03650513          	addi	a0,a0,54 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc0204f4a:	d44fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(initproc != NULL && initproc->pid == 1);
ffffffffc0204f4e:	00002697          	auipc	a3,0x2
ffffffffc0204f52:	40a68693          	addi	a3,a3,1034 # ffffffffc0207358 <default_pmm_manager+0xe48>
ffffffffc0204f56:	00001617          	auipc	a2,0x1
ffffffffc0204f5a:	20a60613          	addi	a2,a2,522 # ffffffffc0206160 <commands+0x828>
ffffffffc0204f5e:	3bd00593          	li	a1,957
ffffffffc0204f62:	00002517          	auipc	a0,0x2
ffffffffc0204f66:	01650513          	addi	a0,a0,22 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc0204f6a:	d24fb0ef          	jal	ra,ffffffffc020048e <__panic>
    assert(idleproc != NULL && idleproc->pid == 0);
ffffffffc0204f6e:	00002697          	auipc	a3,0x2
ffffffffc0204f72:	3c268693          	addi	a3,a3,962 # ffffffffc0207330 <default_pmm_manager+0xe20>
ffffffffc0204f76:	00001617          	auipc	a2,0x1
ffffffffc0204f7a:	1ea60613          	addi	a2,a2,490 # ffffffffc0206160 <commands+0x828>
ffffffffc0204f7e:	3bc00593          	li	a1,956
ffffffffc0204f82:	00002517          	auipc	a0,0x2
ffffffffc0204f86:	ff650513          	addi	a0,a0,-10 # ffffffffc0206f78 <default_pmm_manager+0xa68>
ffffffffc0204f8a:	d04fb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0204f8e <cpu_idle>:

// cpu_idle - at the end of kern_init, the first kernel thread idleproc will do below works
void cpu_idle(void)
{
ffffffffc0204f8e:	1141                	addi	sp,sp,-16
ffffffffc0204f90:	e022                	sd	s0,0(sp)
ffffffffc0204f92:	e406                	sd	ra,8(sp)
ffffffffc0204f94:	000b1417          	auipc	s0,0xb1
ffffffffc0204f98:	81c40413          	addi	s0,s0,-2020 # ffffffffc02b57b0 <current>
    while (1)
    {
        if (current->need_resched)
ffffffffc0204f9c:	6018                	ld	a4,0(s0)
ffffffffc0204f9e:	6f1c                	ld	a5,24(a4)
ffffffffc0204fa0:	dffd                	beqz	a5,ffffffffc0204f9e <cpu_idle+0x10>
        {
            schedule();
ffffffffc0204fa2:	0f0000ef          	jal	ra,ffffffffc0205092 <schedule>
ffffffffc0204fa6:	bfdd                	j	ffffffffc0204f9c <cpu_idle+0xe>

ffffffffc0204fa8 <switch_to>:
.text
# void switch_to(struct proc_struct* from, struct proc_struct* to)
.globl switch_to
switch_to:
    # save from's registers
    STORE ra, 0*REGBYTES(a0)
ffffffffc0204fa8:	00153023          	sd	ra,0(a0)
    STORE sp, 1*REGBYTES(a0)
ffffffffc0204fac:	00253423          	sd	sp,8(a0)
    STORE s0, 2*REGBYTES(a0)
ffffffffc0204fb0:	e900                	sd	s0,16(a0)
    STORE s1, 3*REGBYTES(a0)
ffffffffc0204fb2:	ed04                	sd	s1,24(a0)
    STORE s2, 4*REGBYTES(a0)
ffffffffc0204fb4:	03253023          	sd	s2,32(a0)
    STORE s3, 5*REGBYTES(a0)
ffffffffc0204fb8:	03353423          	sd	s3,40(a0)
    STORE s4, 6*REGBYTES(a0)
ffffffffc0204fbc:	03453823          	sd	s4,48(a0)
    STORE s5, 7*REGBYTES(a0)
ffffffffc0204fc0:	03553c23          	sd	s5,56(a0)
    STORE s6, 8*REGBYTES(a0)
ffffffffc0204fc4:	05653023          	sd	s6,64(a0)
    STORE s7, 9*REGBYTES(a0)
ffffffffc0204fc8:	05753423          	sd	s7,72(a0)
    STORE s8, 10*REGBYTES(a0)
ffffffffc0204fcc:	05853823          	sd	s8,80(a0)
    STORE s9, 11*REGBYTES(a0)
ffffffffc0204fd0:	05953c23          	sd	s9,88(a0)
    STORE s10, 12*REGBYTES(a0)
ffffffffc0204fd4:	07a53023          	sd	s10,96(a0)
    STORE s11, 13*REGBYTES(a0)
ffffffffc0204fd8:	07b53423          	sd	s11,104(a0)

    # restore to's registers
    LOAD ra, 0*REGBYTES(a1)
ffffffffc0204fdc:	0005b083          	ld	ra,0(a1)
    LOAD sp, 1*REGBYTES(a1)
ffffffffc0204fe0:	0085b103          	ld	sp,8(a1)
    LOAD s0, 2*REGBYTES(a1)
ffffffffc0204fe4:	6980                	ld	s0,16(a1)
    LOAD s1, 3*REGBYTES(a1)
ffffffffc0204fe6:	6d84                	ld	s1,24(a1)
    LOAD s2, 4*REGBYTES(a1)
ffffffffc0204fe8:	0205b903          	ld	s2,32(a1)
    LOAD s3, 5*REGBYTES(a1)
ffffffffc0204fec:	0285b983          	ld	s3,40(a1)
    LOAD s4, 6*REGBYTES(a1)
ffffffffc0204ff0:	0305ba03          	ld	s4,48(a1)
    LOAD s5, 7*REGBYTES(a1)
ffffffffc0204ff4:	0385ba83          	ld	s5,56(a1)
    LOAD s6, 8*REGBYTES(a1)
ffffffffc0204ff8:	0405bb03          	ld	s6,64(a1)
    LOAD s7, 9*REGBYTES(a1)
ffffffffc0204ffc:	0485bb83          	ld	s7,72(a1)
    LOAD s8, 10*REGBYTES(a1)
ffffffffc0205000:	0505bc03          	ld	s8,80(a1)
    LOAD s9, 11*REGBYTES(a1)
ffffffffc0205004:	0585bc83          	ld	s9,88(a1)
    LOAD s10, 12*REGBYTES(a1)
ffffffffc0205008:	0605bd03          	ld	s10,96(a1)
    LOAD s11, 13*REGBYTES(a1)
ffffffffc020500c:	0685bd83          	ld	s11,104(a1)

    ret
ffffffffc0205010:	8082                	ret

ffffffffc0205012 <wakeup_proc>:
#include <sched.h>
#include <assert.h>

void wakeup_proc(struct proc_struct *proc)
{
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0205012:	4118                	lw	a4,0(a0)
{
ffffffffc0205014:	1101                	addi	sp,sp,-32
ffffffffc0205016:	ec06                	sd	ra,24(sp)
ffffffffc0205018:	e822                	sd	s0,16(sp)
ffffffffc020501a:	e426                	sd	s1,8(sp)
    assert(proc->state != PROC_ZOMBIE);
ffffffffc020501c:	478d                	li	a5,3
ffffffffc020501e:	04f70b63          	beq	a4,a5,ffffffffc0205074 <wakeup_proc+0x62>
ffffffffc0205022:	842a                	mv	s0,a0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0205024:	100027f3          	csrr	a5,sstatus
ffffffffc0205028:	8b89                	andi	a5,a5,2
    return 0;
ffffffffc020502a:	4481                	li	s1,0
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc020502c:	ef9d                	bnez	a5,ffffffffc020506a <wakeup_proc+0x58>
    bool intr_flag;
    local_intr_save(intr_flag);
    {
        if (proc->state != PROC_RUNNABLE)
ffffffffc020502e:	4789                	li	a5,2
ffffffffc0205030:	02f70163          	beq	a4,a5,ffffffffc0205052 <wakeup_proc+0x40>
        {
            proc->state = PROC_RUNNABLE;
ffffffffc0205034:	c01c                	sw	a5,0(s0)
            proc->wait_state = 0;
ffffffffc0205036:	0e042623          	sw	zero,236(s0)
    if (flag)
ffffffffc020503a:	e491                	bnez	s1,ffffffffc0205046 <wakeup_proc+0x34>
        {
            warn("wakeup runnable process.\n");
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc020503c:	60e2                	ld	ra,24(sp)
ffffffffc020503e:	6442                	ld	s0,16(sp)
ffffffffc0205040:	64a2                	ld	s1,8(sp)
ffffffffc0205042:	6105                	addi	sp,sp,32
ffffffffc0205044:	8082                	ret
ffffffffc0205046:	6442                	ld	s0,16(sp)
ffffffffc0205048:	60e2                	ld	ra,24(sp)
ffffffffc020504a:	64a2                	ld	s1,8(sp)
ffffffffc020504c:	6105                	addi	sp,sp,32
        intr_enable();
ffffffffc020504e:	961fb06f          	j	ffffffffc02009ae <intr_enable>
            warn("wakeup runnable process.\n");
ffffffffc0205052:	00002617          	auipc	a2,0x2
ffffffffc0205056:	36660613          	addi	a2,a2,870 # ffffffffc02073b8 <default_pmm_manager+0xea8>
ffffffffc020505a:	45d1                	li	a1,20
ffffffffc020505c:	00002517          	auipc	a0,0x2
ffffffffc0205060:	34450513          	addi	a0,a0,836 # ffffffffc02073a0 <default_pmm_manager+0xe90>
ffffffffc0205064:	c92fb0ef          	jal	ra,ffffffffc02004f6 <__warn>
ffffffffc0205068:	bfc9                	j	ffffffffc020503a <wakeup_proc+0x28>
        intr_disable();
ffffffffc020506a:	94bfb0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        if (proc->state != PROC_RUNNABLE)
ffffffffc020506e:	4018                	lw	a4,0(s0)
        return 1;
ffffffffc0205070:	4485                	li	s1,1
ffffffffc0205072:	bf75                	j	ffffffffc020502e <wakeup_proc+0x1c>
    assert(proc->state != PROC_ZOMBIE);
ffffffffc0205074:	00002697          	auipc	a3,0x2
ffffffffc0205078:	30c68693          	addi	a3,a3,780 # ffffffffc0207380 <default_pmm_manager+0xe70>
ffffffffc020507c:	00001617          	auipc	a2,0x1
ffffffffc0205080:	0e460613          	addi	a2,a2,228 # ffffffffc0206160 <commands+0x828>
ffffffffc0205084:	45a5                	li	a1,9
ffffffffc0205086:	00002517          	auipc	a0,0x2
ffffffffc020508a:	31a50513          	addi	a0,a0,794 # ffffffffc02073a0 <default_pmm_manager+0xe90>
ffffffffc020508e:	c00fb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc0205092 <schedule>:

void schedule(void)
{
ffffffffc0205092:	1141                	addi	sp,sp,-16
ffffffffc0205094:	e406                	sd	ra,8(sp)
ffffffffc0205096:	e022                	sd	s0,0(sp)
    if (read_csr(sstatus) & SSTATUS_SIE)
ffffffffc0205098:	100027f3          	csrr	a5,sstatus
ffffffffc020509c:	8b89                	andi	a5,a5,2
ffffffffc020509e:	4401                	li	s0,0
ffffffffc02050a0:	efbd                	bnez	a5,ffffffffc020511e <schedule+0x8c>
    bool intr_flag;
    list_entry_t *le, *last;
    struct proc_struct *next = NULL;
    local_intr_save(intr_flag);
    {
        current->need_resched = 0;
ffffffffc02050a2:	000b0897          	auipc	a7,0xb0
ffffffffc02050a6:	70e8b883          	ld	a7,1806(a7) # ffffffffc02b57b0 <current>
ffffffffc02050aa:	0008bc23          	sd	zero,24(a7)
        last = (current == idleproc) ? &proc_list : &(current->list_link);
ffffffffc02050ae:	000b0517          	auipc	a0,0xb0
ffffffffc02050b2:	70a53503          	ld	a0,1802(a0) # ffffffffc02b57b8 <idleproc>
ffffffffc02050b6:	04a88e63          	beq	a7,a0,ffffffffc0205112 <schedule+0x80>
ffffffffc02050ba:	0c888693          	addi	a3,a7,200
ffffffffc02050be:	000b0617          	auipc	a2,0xb0
ffffffffc02050c2:	67a60613          	addi	a2,a2,1658 # ffffffffc02b5738 <proc_list>
        le = last;
ffffffffc02050c6:	87b6                	mv	a5,a3
    struct proc_struct *next = NULL;
ffffffffc02050c8:	4581                	li	a1,0
        do
        {
            if ((le = list_next(le)) != &proc_list)
            {
                next = le2proc(le, list_link);
                if (next->state == PROC_RUNNABLE)
ffffffffc02050ca:	4809                	li	a6,2
ffffffffc02050cc:	679c                	ld	a5,8(a5)
            if ((le = list_next(le)) != &proc_list)
ffffffffc02050ce:	00c78863          	beq	a5,a2,ffffffffc02050de <schedule+0x4c>
                if (next->state == PROC_RUNNABLE)
ffffffffc02050d2:	f387a703          	lw	a4,-200(a5)
                next = le2proc(le, list_link);
ffffffffc02050d6:	f3878593          	addi	a1,a5,-200
                if (next->state == PROC_RUNNABLE)
ffffffffc02050da:	03070163          	beq	a4,a6,ffffffffc02050fc <schedule+0x6a>
                {
                    break;
                }
            }
        } while (le != last);
ffffffffc02050de:	fef697e3          	bne	a3,a5,ffffffffc02050cc <schedule+0x3a>
        if (next == NULL || next->state != PROC_RUNNABLE)
ffffffffc02050e2:	ed89                	bnez	a1,ffffffffc02050fc <schedule+0x6a>
        {
            next = idleproc;
        }
        next->runs++;
ffffffffc02050e4:	451c                	lw	a5,8(a0)
ffffffffc02050e6:	2785                	addiw	a5,a5,1
ffffffffc02050e8:	c51c                	sw	a5,8(a0)
        if (next != current)
ffffffffc02050ea:	00a88463          	beq	a7,a0,ffffffffc02050f2 <schedule+0x60>
        {
            proc_run(next);
ffffffffc02050ee:	e6dfe0ef          	jal	ra,ffffffffc0203f5a <proc_run>
    if (flag)
ffffffffc02050f2:	e819                	bnez	s0,ffffffffc0205108 <schedule+0x76>
        }
    }
    local_intr_restore(intr_flag);
}
ffffffffc02050f4:	60a2                	ld	ra,8(sp)
ffffffffc02050f6:	6402                	ld	s0,0(sp)
ffffffffc02050f8:	0141                	addi	sp,sp,16
ffffffffc02050fa:	8082                	ret
        if (next == NULL || next->state != PROC_RUNNABLE)
ffffffffc02050fc:	4198                	lw	a4,0(a1)
ffffffffc02050fe:	4789                	li	a5,2
ffffffffc0205100:	fef712e3          	bne	a4,a5,ffffffffc02050e4 <schedule+0x52>
ffffffffc0205104:	852e                	mv	a0,a1
ffffffffc0205106:	bff9                	j	ffffffffc02050e4 <schedule+0x52>
}
ffffffffc0205108:	6402                	ld	s0,0(sp)
ffffffffc020510a:	60a2                	ld	ra,8(sp)
ffffffffc020510c:	0141                	addi	sp,sp,16
        intr_enable();
ffffffffc020510e:	8a1fb06f          	j	ffffffffc02009ae <intr_enable>
        last = (current == idleproc) ? &proc_list : &(current->list_link);
ffffffffc0205112:	000b0617          	auipc	a2,0xb0
ffffffffc0205116:	62660613          	addi	a2,a2,1574 # ffffffffc02b5738 <proc_list>
ffffffffc020511a:	86b2                	mv	a3,a2
ffffffffc020511c:	b76d                	j	ffffffffc02050c6 <schedule+0x34>
        intr_disable();
ffffffffc020511e:	897fb0ef          	jal	ra,ffffffffc02009b4 <intr_disable>
        return 1;
ffffffffc0205122:	4405                	li	s0,1
ffffffffc0205124:	bfbd                	j	ffffffffc02050a2 <schedule+0x10>

ffffffffc0205126 <sys_getpid>:
    return do_kill(pid);
}

static int
sys_getpid(uint64_t arg[]) {
    return current->pid;
ffffffffc0205126:	000b0797          	auipc	a5,0xb0
ffffffffc020512a:	68a7b783          	ld	a5,1674(a5) # ffffffffc02b57b0 <current>
}
ffffffffc020512e:	43c8                	lw	a0,4(a5)
ffffffffc0205130:	8082                	ret

ffffffffc0205132 <sys_pgdir>:

static int
sys_pgdir(uint64_t arg[]) {
    //print_pgdir();
    return 0;
}
ffffffffc0205132:	4501                	li	a0,0
ffffffffc0205134:	8082                	ret

ffffffffc0205136 <sys_putc>:
    cputchar(c);
ffffffffc0205136:	4108                	lw	a0,0(a0)
sys_putc(uint64_t arg[]) {
ffffffffc0205138:	1141                	addi	sp,sp,-16
ffffffffc020513a:	e406                	sd	ra,8(sp)
    cputchar(c);
ffffffffc020513c:	88efb0ef          	jal	ra,ffffffffc02001ca <cputchar>
}
ffffffffc0205140:	60a2                	ld	ra,8(sp)
ffffffffc0205142:	4501                	li	a0,0
ffffffffc0205144:	0141                	addi	sp,sp,16
ffffffffc0205146:	8082                	ret

ffffffffc0205148 <sys_kill>:
    return do_kill(pid);
ffffffffc0205148:	4108                	lw	a0,0(a0)
ffffffffc020514a:	c31ff06f          	j	ffffffffc0204d7a <do_kill>

ffffffffc020514e <sys_yield>:
    return do_yield();
ffffffffc020514e:	bdfff06f          	j	ffffffffc0204d2c <do_yield>

ffffffffc0205152 <sys_exec>:
    return do_execve(name, len, binary, size);
ffffffffc0205152:	6d14                	ld	a3,24(a0)
ffffffffc0205154:	6910                	ld	a2,16(a0)
ffffffffc0205156:	650c                	ld	a1,8(a0)
ffffffffc0205158:	6108                	ld	a0,0(a0)
ffffffffc020515a:	ebeff06f          	j	ffffffffc0204818 <do_execve>

ffffffffc020515e <sys_wait>:
    return do_wait(pid, store);
ffffffffc020515e:	650c                	ld	a1,8(a0)
ffffffffc0205160:	4108                	lw	a0,0(a0)
ffffffffc0205162:	bdbff06f          	j	ffffffffc0204d3c <do_wait>

ffffffffc0205166 <sys_fork>:
    struct trapframe *tf = current->tf;
ffffffffc0205166:	000b0797          	auipc	a5,0xb0
ffffffffc020516a:	64a7b783          	ld	a5,1610(a5) # ffffffffc02b57b0 <current>
ffffffffc020516e:	73d0                	ld	a2,160(a5)
    return do_fork(0, stack, tf);
ffffffffc0205170:	4501                	li	a0,0
ffffffffc0205172:	6a0c                	ld	a1,16(a2)
ffffffffc0205174:	e4dfe06f          	j	ffffffffc0203fc0 <do_fork>

ffffffffc0205178 <sys_exit>:
    return do_exit(error_code);
ffffffffc0205178:	4108                	lw	a0,0(a0)
ffffffffc020517a:	a5eff06f          	j	ffffffffc02043d8 <do_exit>

ffffffffc020517e <syscall>:
};

#define NUM_SYSCALLS        ((sizeof(syscalls)) / (sizeof(syscalls[0])))

void
syscall(void) {
ffffffffc020517e:	715d                	addi	sp,sp,-80
ffffffffc0205180:	fc26                	sd	s1,56(sp)
    struct trapframe *tf = current->tf;
ffffffffc0205182:	000b0497          	auipc	s1,0xb0
ffffffffc0205186:	62e48493          	addi	s1,s1,1582 # ffffffffc02b57b0 <current>
ffffffffc020518a:	6098                	ld	a4,0(s1)
syscall(void) {
ffffffffc020518c:	e0a2                	sd	s0,64(sp)
ffffffffc020518e:	f84a                	sd	s2,48(sp)
    struct trapframe *tf = current->tf;
ffffffffc0205190:	7340                	ld	s0,160(a4)
syscall(void) {
ffffffffc0205192:	e486                	sd	ra,72(sp)
    uint64_t arg[5];
    int num = tf->gpr.a0;
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc0205194:	47fd                	li	a5,31
    int num = tf->gpr.a0;
ffffffffc0205196:	05042903          	lw	s2,80(s0)
    if (num >= 0 && num < NUM_SYSCALLS) {
ffffffffc020519a:	0327ee63          	bltu	a5,s2,ffffffffc02051d6 <syscall+0x58>
        if (syscalls[num] != NULL) {
ffffffffc020519e:	00391713          	slli	a4,s2,0x3
ffffffffc02051a2:	00002797          	auipc	a5,0x2
ffffffffc02051a6:	27e78793          	addi	a5,a5,638 # ffffffffc0207420 <syscalls>
ffffffffc02051aa:	97ba                	add	a5,a5,a4
ffffffffc02051ac:	639c                	ld	a5,0(a5)
ffffffffc02051ae:	c785                	beqz	a5,ffffffffc02051d6 <syscall+0x58>
            arg[0] = tf->gpr.a1;
ffffffffc02051b0:	6c28                	ld	a0,88(s0)
            arg[1] = tf->gpr.a2;
ffffffffc02051b2:	702c                	ld	a1,96(s0)
            arg[2] = tf->gpr.a3;
ffffffffc02051b4:	7430                	ld	a2,104(s0)
            arg[3] = tf->gpr.a4;
ffffffffc02051b6:	7834                	ld	a3,112(s0)
            arg[4] = tf->gpr.a5;
ffffffffc02051b8:	7c38                	ld	a4,120(s0)
            arg[0] = tf->gpr.a1;
ffffffffc02051ba:	e42a                	sd	a0,8(sp)
            arg[1] = tf->gpr.a2;
ffffffffc02051bc:	e82e                	sd	a1,16(sp)
            arg[2] = tf->gpr.a3;
ffffffffc02051be:	ec32                	sd	a2,24(sp)
            arg[3] = tf->gpr.a4;
ffffffffc02051c0:	f036                	sd	a3,32(sp)
            arg[4] = tf->gpr.a5;
ffffffffc02051c2:	f43a                	sd	a4,40(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02051c4:	0028                	addi	a0,sp,8
ffffffffc02051c6:	9782                	jalr	a5
        }
    }
    print_trapframe(tf);
    panic("undefined syscall %d, pid = %d, name = %s.\n",
            num, current->pid, current->name);
}
ffffffffc02051c8:	60a6                	ld	ra,72(sp)
            tf->gpr.a0 = syscalls[num](arg);
ffffffffc02051ca:	e828                	sd	a0,80(s0)
}
ffffffffc02051cc:	6406                	ld	s0,64(sp)
ffffffffc02051ce:	74e2                	ld	s1,56(sp)
ffffffffc02051d0:	7942                	ld	s2,48(sp)
ffffffffc02051d2:	6161                	addi	sp,sp,80
ffffffffc02051d4:	8082                	ret
    print_trapframe(tf);
ffffffffc02051d6:	8522                	mv	a0,s0
ffffffffc02051d8:	9cdfb0ef          	jal	ra,ffffffffc0200ba4 <print_trapframe>
    panic("undefined syscall %d, pid = %d, name = %s.\n",
ffffffffc02051dc:	609c                	ld	a5,0(s1)
ffffffffc02051de:	86ca                	mv	a3,s2
ffffffffc02051e0:	00002617          	auipc	a2,0x2
ffffffffc02051e4:	1f860613          	addi	a2,a2,504 # ffffffffc02073d8 <default_pmm_manager+0xec8>
ffffffffc02051e8:	43d8                	lw	a4,4(a5)
ffffffffc02051ea:	06200593          	li	a1,98
ffffffffc02051ee:	0b478793          	addi	a5,a5,180
ffffffffc02051f2:	00002517          	auipc	a0,0x2
ffffffffc02051f6:	21650513          	addi	a0,a0,534 # ffffffffc0207408 <default_pmm_manager+0xef8>
ffffffffc02051fa:	a94fb0ef          	jal	ra,ffffffffc020048e <__panic>

ffffffffc02051fe <hash32>:
 *
 * High bits are more random, so we use them.
 * */
uint32_t
hash32(uint32_t val, unsigned int bits) {
    uint32_t hash = val * GOLDEN_RATIO_PRIME_32;
ffffffffc02051fe:	9e3707b7          	lui	a5,0x9e370
ffffffffc0205202:	2785                	addiw	a5,a5,1
ffffffffc0205204:	02a7853b          	mulw	a0,a5,a0
    return (hash >> (32 - bits));
ffffffffc0205208:	02000793          	li	a5,32
ffffffffc020520c:	9f8d                	subw	a5,a5,a1
}
ffffffffc020520e:	00f5553b          	srlw	a0,a0,a5
ffffffffc0205212:	8082                	ret

ffffffffc0205214 <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
ffffffffc0205214:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0205218:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
ffffffffc020521a:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc020521e:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
ffffffffc0205220:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
ffffffffc0205224:	f022                	sd	s0,32(sp)
ffffffffc0205226:	ec26                	sd	s1,24(sp)
ffffffffc0205228:	e84a                	sd	s2,16(sp)
ffffffffc020522a:	f406                	sd	ra,40(sp)
ffffffffc020522c:	e44e                	sd	s3,8(sp)
ffffffffc020522e:	84aa                	mv	s1,a0
ffffffffc0205230:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
ffffffffc0205232:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
ffffffffc0205236:	2a01                	sext.w	s4,s4
    if (num >= base) {
ffffffffc0205238:	03067e63          	bgeu	a2,a6,ffffffffc0205274 <printnum+0x60>
ffffffffc020523c:	89be                	mv	s3,a5
        while (-- width > 0)
ffffffffc020523e:	00805763          	blez	s0,ffffffffc020524c <printnum+0x38>
ffffffffc0205242:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
ffffffffc0205244:	85ca                	mv	a1,s2
ffffffffc0205246:	854e                	mv	a0,s3
ffffffffc0205248:	9482                	jalr	s1
        while (-- width > 0)
ffffffffc020524a:	fc65                	bnez	s0,ffffffffc0205242 <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
ffffffffc020524c:	1a02                	slli	s4,s4,0x20
ffffffffc020524e:	00002797          	auipc	a5,0x2
ffffffffc0205252:	2d278793          	addi	a5,a5,722 # ffffffffc0207520 <syscalls+0x100>
ffffffffc0205256:	020a5a13          	srli	s4,s4,0x20
ffffffffc020525a:	9a3e                	add	s4,s4,a5
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
ffffffffc020525c:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc020525e:	000a4503          	lbu	a0,0(s4)
}
ffffffffc0205262:	70a2                	ld	ra,40(sp)
ffffffffc0205264:	69a2                	ld	s3,8(sp)
ffffffffc0205266:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0205268:	85ca                	mv	a1,s2
ffffffffc020526a:	87a6                	mv	a5,s1
}
ffffffffc020526c:	6942                	ld	s2,16(sp)
ffffffffc020526e:	64e2                	ld	s1,24(sp)
ffffffffc0205270:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
ffffffffc0205272:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
ffffffffc0205274:	03065633          	divu	a2,a2,a6
ffffffffc0205278:	8722                	mv	a4,s0
ffffffffc020527a:	f9bff0ef          	jal	ra,ffffffffc0205214 <printnum>
ffffffffc020527e:	b7f9                	j	ffffffffc020524c <printnum+0x38>

ffffffffc0205280 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
ffffffffc0205280:	7119                	addi	sp,sp,-128
ffffffffc0205282:	f4a6                	sd	s1,104(sp)
ffffffffc0205284:	f0ca                	sd	s2,96(sp)
ffffffffc0205286:	ecce                	sd	s3,88(sp)
ffffffffc0205288:	e8d2                	sd	s4,80(sp)
ffffffffc020528a:	e4d6                	sd	s5,72(sp)
ffffffffc020528c:	e0da                	sd	s6,64(sp)
ffffffffc020528e:	fc5e                	sd	s7,56(sp)
ffffffffc0205290:	f06a                	sd	s10,32(sp)
ffffffffc0205292:	fc86                	sd	ra,120(sp)
ffffffffc0205294:	f8a2                	sd	s0,112(sp)
ffffffffc0205296:	f862                	sd	s8,48(sp)
ffffffffc0205298:	f466                	sd	s9,40(sp)
ffffffffc020529a:	ec6e                	sd	s11,24(sp)
ffffffffc020529c:	892a                	mv	s2,a0
ffffffffc020529e:	84ae                	mv	s1,a1
ffffffffc02052a0:	8d32                	mv	s10,a2
ffffffffc02052a2:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02052a4:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
ffffffffc02052a8:	5b7d                	li	s6,-1
ffffffffc02052aa:	00002a97          	auipc	s5,0x2
ffffffffc02052ae:	2a2a8a93          	addi	s5,s5,674 # ffffffffc020754c <syscalls+0x12c>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc02052b2:	00002b97          	auipc	s7,0x2
ffffffffc02052b6:	4b6b8b93          	addi	s7,s7,1206 # ffffffffc0207768 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02052ba:	000d4503          	lbu	a0,0(s10)
ffffffffc02052be:	001d0413          	addi	s0,s10,1
ffffffffc02052c2:	01350a63          	beq	a0,s3,ffffffffc02052d6 <vprintfmt+0x56>
            if (ch == '\0') {
ffffffffc02052c6:	c121                	beqz	a0,ffffffffc0205306 <vprintfmt+0x86>
            putch(ch, putdat);
ffffffffc02052c8:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02052ca:	0405                	addi	s0,s0,1
            putch(ch, putdat);
ffffffffc02052cc:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
ffffffffc02052ce:	fff44503          	lbu	a0,-1(s0)
ffffffffc02052d2:	ff351ae3          	bne	a0,s3,ffffffffc02052c6 <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02052d6:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
ffffffffc02052da:	02000793          	li	a5,32
        lflag = altflag = 0;
ffffffffc02052de:	4c81                	li	s9,0
ffffffffc02052e0:	4881                	li	a7,0
        width = precision = -1;
ffffffffc02052e2:	5c7d                	li	s8,-1
ffffffffc02052e4:	5dfd                	li	s11,-1
ffffffffc02052e6:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
ffffffffc02052ea:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02052ec:	fdd6059b          	addiw	a1,a2,-35
ffffffffc02052f0:	0ff5f593          	zext.b	a1,a1
ffffffffc02052f4:	00140d13          	addi	s10,s0,1
ffffffffc02052f8:	04b56263          	bltu	a0,a1,ffffffffc020533c <vprintfmt+0xbc>
ffffffffc02052fc:	058a                	slli	a1,a1,0x2
ffffffffc02052fe:	95d6                	add	a1,a1,s5
ffffffffc0205300:	4194                	lw	a3,0(a1)
ffffffffc0205302:	96d6                	add	a3,a3,s5
ffffffffc0205304:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
ffffffffc0205306:	70e6                	ld	ra,120(sp)
ffffffffc0205308:	7446                	ld	s0,112(sp)
ffffffffc020530a:	74a6                	ld	s1,104(sp)
ffffffffc020530c:	7906                	ld	s2,96(sp)
ffffffffc020530e:	69e6                	ld	s3,88(sp)
ffffffffc0205310:	6a46                	ld	s4,80(sp)
ffffffffc0205312:	6aa6                	ld	s5,72(sp)
ffffffffc0205314:	6b06                	ld	s6,64(sp)
ffffffffc0205316:	7be2                	ld	s7,56(sp)
ffffffffc0205318:	7c42                	ld	s8,48(sp)
ffffffffc020531a:	7ca2                	ld	s9,40(sp)
ffffffffc020531c:	7d02                	ld	s10,32(sp)
ffffffffc020531e:	6de2                	ld	s11,24(sp)
ffffffffc0205320:	6109                	addi	sp,sp,128
ffffffffc0205322:	8082                	ret
            padc = '0';
ffffffffc0205324:	87b2                	mv	a5,a2
            goto reswitch;
ffffffffc0205326:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020532a:	846a                	mv	s0,s10
ffffffffc020532c:	00140d13          	addi	s10,s0,1
ffffffffc0205330:	fdd6059b          	addiw	a1,a2,-35
ffffffffc0205334:	0ff5f593          	zext.b	a1,a1
ffffffffc0205338:	fcb572e3          	bgeu	a0,a1,ffffffffc02052fc <vprintfmt+0x7c>
            putch('%', putdat);
ffffffffc020533c:	85a6                	mv	a1,s1
ffffffffc020533e:	02500513          	li	a0,37
ffffffffc0205342:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
ffffffffc0205344:	fff44783          	lbu	a5,-1(s0)
ffffffffc0205348:	8d22                	mv	s10,s0
ffffffffc020534a:	f73788e3          	beq	a5,s3,ffffffffc02052ba <vprintfmt+0x3a>
ffffffffc020534e:	ffed4783          	lbu	a5,-2(s10)
ffffffffc0205352:	1d7d                	addi	s10,s10,-1
ffffffffc0205354:	ff379de3          	bne	a5,s3,ffffffffc020534e <vprintfmt+0xce>
ffffffffc0205358:	b78d                	j	ffffffffc02052ba <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
ffffffffc020535a:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
ffffffffc020535e:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205362:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
ffffffffc0205364:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
ffffffffc0205368:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc020536c:	02d86463          	bltu	a6,a3,ffffffffc0205394 <vprintfmt+0x114>
                ch = *fmt;
ffffffffc0205370:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
ffffffffc0205374:	002c169b          	slliw	a3,s8,0x2
ffffffffc0205378:	0186873b          	addw	a4,a3,s8
ffffffffc020537c:	0017171b          	slliw	a4,a4,0x1
ffffffffc0205380:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
ffffffffc0205382:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
ffffffffc0205386:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
ffffffffc0205388:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
ffffffffc020538c:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
ffffffffc0205390:	fed870e3          	bgeu	a6,a3,ffffffffc0205370 <vprintfmt+0xf0>
            if (width < 0)
ffffffffc0205394:	f40ddce3          	bgez	s11,ffffffffc02052ec <vprintfmt+0x6c>
                width = precision, precision = -1;
ffffffffc0205398:	8de2                	mv	s11,s8
ffffffffc020539a:	5c7d                	li	s8,-1
ffffffffc020539c:	bf81                	j	ffffffffc02052ec <vprintfmt+0x6c>
            if (width < 0)
ffffffffc020539e:	fffdc693          	not	a3,s11
ffffffffc02053a2:	96fd                	srai	a3,a3,0x3f
ffffffffc02053a4:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02053a8:	00144603          	lbu	a2,1(s0)
ffffffffc02053ac:	2d81                	sext.w	s11,s11
ffffffffc02053ae:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc02053b0:	bf35                	j	ffffffffc02052ec <vprintfmt+0x6c>
            precision = va_arg(ap, int);
ffffffffc02053b2:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02053b6:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
ffffffffc02053ba:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc02053bc:	846a                	mv	s0,s10
            goto process_precision;
ffffffffc02053be:	bfd9                	j	ffffffffc0205394 <vprintfmt+0x114>
    if (lflag >= 2) {
ffffffffc02053c0:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02053c2:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc02053c6:	01174463          	blt	a4,a7,ffffffffc02053ce <vprintfmt+0x14e>
    else if (lflag) {
ffffffffc02053ca:	1a088e63          	beqz	a7,ffffffffc0205586 <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
ffffffffc02053ce:	000a3603          	ld	a2,0(s4)
ffffffffc02053d2:	46c1                	li	a3,16
ffffffffc02053d4:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
ffffffffc02053d6:	2781                	sext.w	a5,a5
ffffffffc02053d8:	876e                	mv	a4,s11
ffffffffc02053da:	85a6                	mv	a1,s1
ffffffffc02053dc:	854a                	mv	a0,s2
ffffffffc02053de:	e37ff0ef          	jal	ra,ffffffffc0205214 <printnum>
            break;
ffffffffc02053e2:	bde1                	j	ffffffffc02052ba <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
ffffffffc02053e4:	000a2503          	lw	a0,0(s4)
ffffffffc02053e8:	85a6                	mv	a1,s1
ffffffffc02053ea:	0a21                	addi	s4,s4,8
ffffffffc02053ec:	9902                	jalr	s2
            break;
ffffffffc02053ee:	b5f1                	j	ffffffffc02052ba <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc02053f0:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02053f2:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc02053f6:	01174463          	blt	a4,a7,ffffffffc02053fe <vprintfmt+0x17e>
    else if (lflag) {
ffffffffc02053fa:	18088163          	beqz	a7,ffffffffc020557c <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
ffffffffc02053fe:	000a3603          	ld	a2,0(s4)
ffffffffc0205402:	46a9                	li	a3,10
ffffffffc0205404:	8a2e                	mv	s4,a1
ffffffffc0205406:	bfc1                	j	ffffffffc02053d6 <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205408:	00144603          	lbu	a2,1(s0)
            altflag = 1;
ffffffffc020540c:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020540e:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0205410:	bdf1                	j	ffffffffc02052ec <vprintfmt+0x6c>
            putch(ch, putdat);
ffffffffc0205412:	85a6                	mv	a1,s1
ffffffffc0205414:	02500513          	li	a0,37
ffffffffc0205418:	9902                	jalr	s2
            break;
ffffffffc020541a:	b545                	j	ffffffffc02052ba <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc020541c:	00144603          	lbu	a2,1(s0)
            lflag ++;
ffffffffc0205420:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
ffffffffc0205422:	846a                	mv	s0,s10
            goto reswitch;
ffffffffc0205424:	b5e1                	j	ffffffffc02052ec <vprintfmt+0x6c>
    if (lflag >= 2) {
ffffffffc0205426:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc0205428:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
ffffffffc020542c:	01174463          	blt	a4,a7,ffffffffc0205434 <vprintfmt+0x1b4>
    else if (lflag) {
ffffffffc0205430:	14088163          	beqz	a7,ffffffffc0205572 <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
ffffffffc0205434:	000a3603          	ld	a2,0(s4)
ffffffffc0205438:	46a1                	li	a3,8
ffffffffc020543a:	8a2e                	mv	s4,a1
ffffffffc020543c:	bf69                	j	ffffffffc02053d6 <vprintfmt+0x156>
            putch('0', putdat);
ffffffffc020543e:	03000513          	li	a0,48
ffffffffc0205442:	85a6                	mv	a1,s1
ffffffffc0205444:	e03e                	sd	a5,0(sp)
ffffffffc0205446:	9902                	jalr	s2
            putch('x', putdat);
ffffffffc0205448:	85a6                	mv	a1,s1
ffffffffc020544a:	07800513          	li	a0,120
ffffffffc020544e:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0205450:	0a21                	addi	s4,s4,8
            goto number;
ffffffffc0205452:	6782                	ld	a5,0(sp)
ffffffffc0205454:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
ffffffffc0205456:	ff8a3603          	ld	a2,-8(s4)
            goto number;
ffffffffc020545a:	bfb5                	j	ffffffffc02053d6 <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc020545c:	000a3403          	ld	s0,0(s4)
ffffffffc0205460:	008a0713          	addi	a4,s4,8
ffffffffc0205464:	e03a                	sd	a4,0(sp)
ffffffffc0205466:	14040263          	beqz	s0,ffffffffc02055aa <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
ffffffffc020546a:	0fb05763          	blez	s11,ffffffffc0205558 <vprintfmt+0x2d8>
ffffffffc020546e:	02d00693          	li	a3,45
ffffffffc0205472:	0cd79163          	bne	a5,a3,ffffffffc0205534 <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205476:	00044783          	lbu	a5,0(s0)
ffffffffc020547a:	0007851b          	sext.w	a0,a5
ffffffffc020547e:	cf85                	beqz	a5,ffffffffc02054b6 <vprintfmt+0x236>
ffffffffc0205480:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205484:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205488:	000c4563          	bltz	s8,ffffffffc0205492 <vprintfmt+0x212>
ffffffffc020548c:	3c7d                	addiw	s8,s8,-1
ffffffffc020548e:	036c0263          	beq	s8,s6,ffffffffc02054b2 <vprintfmt+0x232>
                    putch('?', putdat);
ffffffffc0205492:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205494:	0e0c8e63          	beqz	s9,ffffffffc0205590 <vprintfmt+0x310>
ffffffffc0205498:	3781                	addiw	a5,a5,-32
ffffffffc020549a:	0ef47b63          	bgeu	s0,a5,ffffffffc0205590 <vprintfmt+0x310>
                    putch('?', putdat);
ffffffffc020549e:	03f00513          	li	a0,63
ffffffffc02054a2:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc02054a4:	000a4783          	lbu	a5,0(s4)
ffffffffc02054a8:	3dfd                	addiw	s11,s11,-1
ffffffffc02054aa:	0a05                	addi	s4,s4,1
ffffffffc02054ac:	0007851b          	sext.w	a0,a5
ffffffffc02054b0:	ffe1                	bnez	a5,ffffffffc0205488 <vprintfmt+0x208>
            for (; width > 0; width --) {
ffffffffc02054b2:	01b05963          	blez	s11,ffffffffc02054c4 <vprintfmt+0x244>
ffffffffc02054b6:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
ffffffffc02054b8:	85a6                	mv	a1,s1
ffffffffc02054ba:	02000513          	li	a0,32
ffffffffc02054be:	9902                	jalr	s2
            for (; width > 0; width --) {
ffffffffc02054c0:	fe0d9be3          	bnez	s11,ffffffffc02054b6 <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
ffffffffc02054c4:	6a02                	ld	s4,0(sp)
ffffffffc02054c6:	bbd5                	j	ffffffffc02052ba <vprintfmt+0x3a>
    if (lflag >= 2) {
ffffffffc02054c8:	4705                	li	a4,1
            precision = va_arg(ap, int);
ffffffffc02054ca:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
ffffffffc02054ce:	01174463          	blt	a4,a7,ffffffffc02054d6 <vprintfmt+0x256>
    else if (lflag) {
ffffffffc02054d2:	08088d63          	beqz	a7,ffffffffc020556c <vprintfmt+0x2ec>
        return va_arg(*ap, long);
ffffffffc02054d6:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
ffffffffc02054da:	0a044d63          	bltz	s0,ffffffffc0205594 <vprintfmt+0x314>
            num = getint(&ap, lflag);
ffffffffc02054de:	8622                	mv	a2,s0
ffffffffc02054e0:	8a66                	mv	s4,s9
ffffffffc02054e2:	46a9                	li	a3,10
ffffffffc02054e4:	bdcd                	j	ffffffffc02053d6 <vprintfmt+0x156>
            err = va_arg(ap, int);
ffffffffc02054e6:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc02054ea:	4761                	li	a4,24
            err = va_arg(ap, int);
ffffffffc02054ec:	0a21                	addi	s4,s4,8
            if (err < 0) {
ffffffffc02054ee:	41f7d69b          	sraiw	a3,a5,0x1f
ffffffffc02054f2:	8fb5                	xor	a5,a5,a3
ffffffffc02054f4:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
ffffffffc02054f8:	02d74163          	blt	a4,a3,ffffffffc020551a <vprintfmt+0x29a>
ffffffffc02054fc:	00369793          	slli	a5,a3,0x3
ffffffffc0205500:	97de                	add	a5,a5,s7
ffffffffc0205502:	639c                	ld	a5,0(a5)
ffffffffc0205504:	cb99                	beqz	a5,ffffffffc020551a <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
ffffffffc0205506:	86be                	mv	a3,a5
ffffffffc0205508:	00000617          	auipc	a2,0x0
ffffffffc020550c:	1f060613          	addi	a2,a2,496 # ffffffffc02056f8 <etext+0x2a>
ffffffffc0205510:	85a6                	mv	a1,s1
ffffffffc0205512:	854a                	mv	a0,s2
ffffffffc0205514:	0ce000ef          	jal	ra,ffffffffc02055e2 <printfmt>
ffffffffc0205518:	b34d                	j	ffffffffc02052ba <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
ffffffffc020551a:	00002617          	auipc	a2,0x2
ffffffffc020551e:	02660613          	addi	a2,a2,38 # ffffffffc0207540 <syscalls+0x120>
ffffffffc0205522:	85a6                	mv	a1,s1
ffffffffc0205524:	854a                	mv	a0,s2
ffffffffc0205526:	0bc000ef          	jal	ra,ffffffffc02055e2 <printfmt>
ffffffffc020552a:	bb41                	j	ffffffffc02052ba <vprintfmt+0x3a>
                p = "(null)";
ffffffffc020552c:	00002417          	auipc	s0,0x2
ffffffffc0205530:	00c40413          	addi	s0,s0,12 # ffffffffc0207538 <syscalls+0x118>
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0205534:	85e2                	mv	a1,s8
ffffffffc0205536:	8522                	mv	a0,s0
ffffffffc0205538:	e43e                	sd	a5,8(sp)
ffffffffc020553a:	0e2000ef          	jal	ra,ffffffffc020561c <strnlen>
ffffffffc020553e:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0205542:	01b05b63          	blez	s11,ffffffffc0205558 <vprintfmt+0x2d8>
                    putch(padc, putdat);
ffffffffc0205546:	67a2                	ld	a5,8(sp)
ffffffffc0205548:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc020554c:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
ffffffffc020554e:	85a6                	mv	a1,s1
ffffffffc0205550:	8552                	mv	a0,s4
ffffffffc0205552:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
ffffffffc0205554:	fe0d9ce3          	bnez	s11,ffffffffc020554c <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc0205558:	00044783          	lbu	a5,0(s0)
ffffffffc020555c:	00140a13          	addi	s4,s0,1
ffffffffc0205560:	0007851b          	sext.w	a0,a5
ffffffffc0205564:	d3a5                	beqz	a5,ffffffffc02054c4 <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc0205566:	05e00413          	li	s0,94
ffffffffc020556a:	bf39                	j	ffffffffc0205488 <vprintfmt+0x208>
        return va_arg(*ap, int);
ffffffffc020556c:	000a2403          	lw	s0,0(s4)
ffffffffc0205570:	b7ad                	j	ffffffffc02054da <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
ffffffffc0205572:	000a6603          	lwu	a2,0(s4)
ffffffffc0205576:	46a1                	li	a3,8
ffffffffc0205578:	8a2e                	mv	s4,a1
ffffffffc020557a:	bdb1                	j	ffffffffc02053d6 <vprintfmt+0x156>
ffffffffc020557c:	000a6603          	lwu	a2,0(s4)
ffffffffc0205580:	46a9                	li	a3,10
ffffffffc0205582:	8a2e                	mv	s4,a1
ffffffffc0205584:	bd89                	j	ffffffffc02053d6 <vprintfmt+0x156>
ffffffffc0205586:	000a6603          	lwu	a2,0(s4)
ffffffffc020558a:	46c1                	li	a3,16
ffffffffc020558c:	8a2e                	mv	s4,a1
ffffffffc020558e:	b5a1                	j	ffffffffc02053d6 <vprintfmt+0x156>
                    putch(ch, putdat);
ffffffffc0205590:	9902                	jalr	s2
ffffffffc0205592:	bf09                	j	ffffffffc02054a4 <vprintfmt+0x224>
                putch('-', putdat);
ffffffffc0205594:	85a6                	mv	a1,s1
ffffffffc0205596:	02d00513          	li	a0,45
ffffffffc020559a:	e03e                	sd	a5,0(sp)
ffffffffc020559c:	9902                	jalr	s2
                num = -(long long)num;
ffffffffc020559e:	6782                	ld	a5,0(sp)
ffffffffc02055a0:	8a66                	mv	s4,s9
ffffffffc02055a2:	40800633          	neg	a2,s0
ffffffffc02055a6:	46a9                	li	a3,10
ffffffffc02055a8:	b53d                	j	ffffffffc02053d6 <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
ffffffffc02055aa:	03b05163          	blez	s11,ffffffffc02055cc <vprintfmt+0x34c>
ffffffffc02055ae:	02d00693          	li	a3,45
ffffffffc02055b2:	f6d79de3          	bne	a5,a3,ffffffffc020552c <vprintfmt+0x2ac>
                p = "(null)";
ffffffffc02055b6:	00002417          	auipc	s0,0x2
ffffffffc02055ba:	f8240413          	addi	s0,s0,-126 # ffffffffc0207538 <syscalls+0x118>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
ffffffffc02055be:	02800793          	li	a5,40
ffffffffc02055c2:	02800513          	li	a0,40
ffffffffc02055c6:	00140a13          	addi	s4,s0,1
ffffffffc02055ca:	bd6d                	j	ffffffffc0205484 <vprintfmt+0x204>
ffffffffc02055cc:	00002a17          	auipc	s4,0x2
ffffffffc02055d0:	f6da0a13          	addi	s4,s4,-147 # ffffffffc0207539 <syscalls+0x119>
ffffffffc02055d4:	02800513          	li	a0,40
ffffffffc02055d8:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
ffffffffc02055dc:	05e00413          	li	s0,94
ffffffffc02055e0:	b565                	j	ffffffffc0205488 <vprintfmt+0x208>

ffffffffc02055e2 <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02055e2:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
ffffffffc02055e4:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02055e8:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc02055ea:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
ffffffffc02055ec:	ec06                	sd	ra,24(sp)
ffffffffc02055ee:	f83a                	sd	a4,48(sp)
ffffffffc02055f0:	fc3e                	sd	a5,56(sp)
ffffffffc02055f2:	e0c2                	sd	a6,64(sp)
ffffffffc02055f4:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
ffffffffc02055f6:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
ffffffffc02055f8:	c89ff0ef          	jal	ra,ffffffffc0205280 <vprintfmt>
}
ffffffffc02055fc:	60e2                	ld	ra,24(sp)
ffffffffc02055fe:	6161                	addi	sp,sp,80
ffffffffc0205600:	8082                	ret

ffffffffc0205602 <strlen>:
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
    size_t cnt = 0;
    while (*s ++ != '\0') {
ffffffffc0205602:	00054783          	lbu	a5,0(a0)
strlen(const char *s) {
ffffffffc0205606:	872a                	mv	a4,a0
    size_t cnt = 0;
ffffffffc0205608:	4501                	li	a0,0
    while (*s ++ != '\0') {
ffffffffc020560a:	cb81                	beqz	a5,ffffffffc020561a <strlen+0x18>
        cnt ++;
ffffffffc020560c:	0505                	addi	a0,a0,1
    while (*s ++ != '\0') {
ffffffffc020560e:	00a707b3          	add	a5,a4,a0
ffffffffc0205612:	0007c783          	lbu	a5,0(a5)
ffffffffc0205616:	fbfd                	bnez	a5,ffffffffc020560c <strlen+0xa>
ffffffffc0205618:	8082                	ret
    }
    return cnt;
}
ffffffffc020561a:	8082                	ret

ffffffffc020561c <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
ffffffffc020561c:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
ffffffffc020561e:	e589                	bnez	a1,ffffffffc0205628 <strnlen+0xc>
ffffffffc0205620:	a811                	j	ffffffffc0205634 <strnlen+0x18>
        cnt ++;
ffffffffc0205622:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
ffffffffc0205624:	00f58863          	beq	a1,a5,ffffffffc0205634 <strnlen+0x18>
ffffffffc0205628:	00f50733          	add	a4,a0,a5
ffffffffc020562c:	00074703          	lbu	a4,0(a4)
ffffffffc0205630:	fb6d                	bnez	a4,ffffffffc0205622 <strnlen+0x6>
ffffffffc0205632:	85be                	mv	a1,a5
    }
    return cnt;
}
ffffffffc0205634:	852e                	mv	a0,a1
ffffffffc0205636:	8082                	ret

ffffffffc0205638 <strcpy>:
char *
strcpy(char *dst, const char *src) {
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
#else
    char *p = dst;
ffffffffc0205638:	87aa                	mv	a5,a0
    while ((*p ++ = *src ++) != '\0')
ffffffffc020563a:	0005c703          	lbu	a4,0(a1)
ffffffffc020563e:	0785                	addi	a5,a5,1
ffffffffc0205640:	0585                	addi	a1,a1,1
ffffffffc0205642:	fee78fa3          	sb	a4,-1(a5)
ffffffffc0205646:	fb75                	bnez	a4,ffffffffc020563a <strcpy+0x2>
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
ffffffffc0205648:	8082                	ret

ffffffffc020564a <strcmp>:
int
strcmp(const char *s1, const char *s2) {
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
#else
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc020564a:	00054783          	lbu	a5,0(a0)
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc020564e:	0005c703          	lbu	a4,0(a1)
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0205652:	cb89                	beqz	a5,ffffffffc0205664 <strcmp+0x1a>
        s1 ++, s2 ++;
ffffffffc0205654:	0505                	addi	a0,a0,1
ffffffffc0205656:	0585                	addi	a1,a1,1
    while (*s1 != '\0' && *s1 == *s2) {
ffffffffc0205658:	fee789e3          	beq	a5,a4,ffffffffc020564a <strcmp>
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc020565c:	0007851b          	sext.w	a0,a5
#endif /* __HAVE_ARCH_STRCMP */
}
ffffffffc0205660:	9d19                	subw	a0,a0,a4
ffffffffc0205662:	8082                	ret
ffffffffc0205664:	4501                	li	a0,0
ffffffffc0205666:	bfed                	j	ffffffffc0205660 <strcmp+0x16>

ffffffffc0205668 <strncmp>:
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0205668:	c20d                	beqz	a2,ffffffffc020568a <strncmp+0x22>
ffffffffc020566a:	962e                	add	a2,a2,a1
ffffffffc020566c:	a031                	j	ffffffffc0205678 <strncmp+0x10>
        n --, s1 ++, s2 ++;
ffffffffc020566e:	0505                	addi	a0,a0,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc0205670:	00e79a63          	bne	a5,a4,ffffffffc0205684 <strncmp+0x1c>
ffffffffc0205674:	00b60b63          	beq	a2,a1,ffffffffc020568a <strncmp+0x22>
ffffffffc0205678:	00054783          	lbu	a5,0(a0)
        n --, s1 ++, s2 ++;
ffffffffc020567c:	0585                	addi	a1,a1,1
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
ffffffffc020567e:	fff5c703          	lbu	a4,-1(a1)
ffffffffc0205682:	f7f5                	bnez	a5,ffffffffc020566e <strncmp+0x6>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc0205684:	40e7853b          	subw	a0,a5,a4
}
ffffffffc0205688:	8082                	ret
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
ffffffffc020568a:	4501                	li	a0,0
ffffffffc020568c:	8082                	ret

ffffffffc020568e <strchr>:
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
    while (*s != '\0') {
ffffffffc020568e:	00054783          	lbu	a5,0(a0)
ffffffffc0205692:	c799                	beqz	a5,ffffffffc02056a0 <strchr+0x12>
        if (*s == c) {
ffffffffc0205694:	00f58763          	beq	a1,a5,ffffffffc02056a2 <strchr+0x14>
    while (*s != '\0') {
ffffffffc0205698:	00154783          	lbu	a5,1(a0)
            return (char *)s;
        }
        s ++;
ffffffffc020569c:	0505                	addi	a0,a0,1
    while (*s != '\0') {
ffffffffc020569e:	fbfd                	bnez	a5,ffffffffc0205694 <strchr+0x6>
    }
    return NULL;
ffffffffc02056a0:	4501                	li	a0,0
}
ffffffffc02056a2:	8082                	ret

ffffffffc02056a4 <memset>:
memset(void *s, char c, size_t n) {
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
#else
    char *p = s;
    while (n -- > 0) {
ffffffffc02056a4:	ca01                	beqz	a2,ffffffffc02056b4 <memset+0x10>
ffffffffc02056a6:	962a                	add	a2,a2,a0
    char *p = s;
ffffffffc02056a8:	87aa                	mv	a5,a0
        *p ++ = c;
ffffffffc02056aa:	0785                	addi	a5,a5,1
ffffffffc02056ac:	feb78fa3          	sb	a1,-1(a5)
    while (n -- > 0) {
ffffffffc02056b0:	fec79de3          	bne	a5,a2,ffffffffc02056aa <memset+0x6>
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
ffffffffc02056b4:	8082                	ret

ffffffffc02056b6 <memcpy>:
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
#else
    const char *s = src;
    char *d = dst;
    while (n -- > 0) {
ffffffffc02056b6:	ca19                	beqz	a2,ffffffffc02056cc <memcpy+0x16>
ffffffffc02056b8:	962e                	add	a2,a2,a1
    char *d = dst;
ffffffffc02056ba:	87aa                	mv	a5,a0
        *d ++ = *s ++;
ffffffffc02056bc:	0005c703          	lbu	a4,0(a1)
ffffffffc02056c0:	0585                	addi	a1,a1,1
ffffffffc02056c2:	0785                	addi	a5,a5,1
ffffffffc02056c4:	fee78fa3          	sb	a4,-1(a5)
    while (n -- > 0) {
ffffffffc02056c8:	fec59ae3          	bne	a1,a2,ffffffffc02056bc <memcpy+0x6>
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
ffffffffc02056cc:	8082                	ret
