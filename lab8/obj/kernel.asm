
bin/kernel:     file format elf64-littleriscv


Disassembly of section .text:

ffffffffc0200000 <kern_entry>:
ffffffffc0200000:	00014297          	auipc	t0,0x14
ffffffffc0200004:	00028293          	mv	t0,t0
ffffffffc0200008:	00a2b023          	sd	a0,0(t0) # ffffffffc0214000 <boot_hartid>
ffffffffc020000c:	00014297          	auipc	t0,0x14
ffffffffc0200010:	ffc28293          	addi	t0,t0,-4 # ffffffffc0214008 <boot_dtb>
ffffffffc0200014:	00b2b023          	sd	a1,0(t0)
ffffffffc0200018:	c02132b7          	lui	t0,0xc0213
ffffffffc020001c:	ffd0031b          	addiw	t1,zero,-3
ffffffffc0200020:	037a                	slli	t1,t1,0x1e
ffffffffc0200022:	406282b3          	sub	t0,t0,t1
ffffffffc0200026:	00c2d293          	srli	t0,t0,0xc
ffffffffc020002a:	fff0031b          	addiw	t1,zero,-1
ffffffffc020002e:	137e                	slli	t1,t1,0x3f
ffffffffc0200030:	0062e2b3          	or	t0,t0,t1
ffffffffc0200034:	18029073          	csrw	satp,t0
ffffffffc0200038:	12000073          	sfence.vma
ffffffffc020003c:	c0213137          	lui	sp,0xc0213
ffffffffc0200040:	c02002b7          	lui	t0,0xc0200
ffffffffc0200044:	04a28293          	addi	t0,t0,74 # ffffffffc020004a <kern_init>
ffffffffc0200048:	8282                	jr	t0

ffffffffc020004a <kern_init>:
ffffffffc020004a:	00091517          	auipc	a0,0x91
ffffffffc020004e:	01650513          	addi	a0,a0,22 # ffffffffc0291060 <buf>
ffffffffc0200052:	00097617          	auipc	a2,0x97
ffffffffc0200056:	8be60613          	addi	a2,a2,-1858 # ffffffffc0296910 <end>
ffffffffc020005a:	1141                	addi	sp,sp,-16
ffffffffc020005c:	8e09                	sub	a2,a2,a0
ffffffffc020005e:	4581                	li	a1,0
ffffffffc0200060:	e406                	sd	ra,8(sp)
ffffffffc0200062:	5040b0ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc0200066:	52c000ef          	jal	ra,ffffffffc0200592 <cons_init>
ffffffffc020006a:	0000b597          	auipc	a1,0xb
ffffffffc020006e:	56658593          	addi	a1,a1,1382 # ffffffffc020b5d0 <etext>
ffffffffc0200072:	0000b517          	auipc	a0,0xb
ffffffffc0200076:	57e50513          	addi	a0,a0,1406 # ffffffffc020b5f0 <etext+0x20>
ffffffffc020007a:	12c000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020007e:	1ae000ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc0200082:	62a000ef          	jal	ra,ffffffffc02006ac <dtb_init>
ffffffffc0200086:	24b020ef          	jal	ra,ffffffffc0202ad0 <pmm_init>
ffffffffc020008a:	3ef000ef          	jal	ra,ffffffffc0200c78 <pic_init>
ffffffffc020008e:	515000ef          	jal	ra,ffffffffc0200da2 <idt_init>
ffffffffc0200092:	6d7030ef          	jal	ra,ffffffffc0203f68 <vmm_init>
ffffffffc0200096:	248070ef          	jal	ra,ffffffffc02072de <sched_init>
ffffffffc020009a:	64f060ef          	jal	ra,ffffffffc0206ee8 <proc_init>
ffffffffc020009e:	1bf000ef          	jal	ra,ffffffffc0200a5c <ide_init>
ffffffffc02000a2:	108050ef          	jal	ra,ffffffffc02051aa <fs_init>
ffffffffc02000a6:	4a4000ef          	jal	ra,ffffffffc020054a <clock_init>
ffffffffc02000aa:	3c3000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02000ae:	006070ef          	jal	ra,ffffffffc02070b4 <cpu_idle>

ffffffffc02000b2 <readline>:
ffffffffc02000b2:	715d                	addi	sp,sp,-80
ffffffffc02000b4:	e486                	sd	ra,72(sp)
ffffffffc02000b6:	e0a6                	sd	s1,64(sp)
ffffffffc02000b8:	fc4a                	sd	s2,56(sp)
ffffffffc02000ba:	f84e                	sd	s3,48(sp)
ffffffffc02000bc:	f452                	sd	s4,40(sp)
ffffffffc02000be:	f056                	sd	s5,32(sp)
ffffffffc02000c0:	ec5a                	sd	s6,24(sp)
ffffffffc02000c2:	e85e                	sd	s7,16(sp)
ffffffffc02000c4:	c901                	beqz	a0,ffffffffc02000d4 <readline+0x22>
ffffffffc02000c6:	85aa                	mv	a1,a0
ffffffffc02000c8:	0000b517          	auipc	a0,0xb
ffffffffc02000cc:	53050513          	addi	a0,a0,1328 # ffffffffc020b5f8 <etext+0x28>
ffffffffc02000d0:	0d6000ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02000d4:	4481                	li	s1,0
ffffffffc02000d6:	497d                	li	s2,31
ffffffffc02000d8:	49a1                	li	s3,8
ffffffffc02000da:	4aa9                	li	s5,10
ffffffffc02000dc:	4b35                	li	s6,13
ffffffffc02000de:	00091b97          	auipc	s7,0x91
ffffffffc02000e2:	f82b8b93          	addi	s7,s7,-126 # ffffffffc0291060 <buf>
ffffffffc02000e6:	3fe00a13          	li	s4,1022
ffffffffc02000ea:	0fa000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc02000ee:	00054a63          	bltz	a0,ffffffffc0200102 <readline+0x50>
ffffffffc02000f2:	00a95a63          	bge	s2,a0,ffffffffc0200106 <readline+0x54>
ffffffffc02000f6:	029a5263          	bge	s4,s1,ffffffffc020011a <readline+0x68>
ffffffffc02000fa:	0ea000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc02000fe:	fe055ae3          	bgez	a0,ffffffffc02000f2 <readline+0x40>
ffffffffc0200102:	4501                	li	a0,0
ffffffffc0200104:	a091                	j	ffffffffc0200148 <readline+0x96>
ffffffffc0200106:	03351463          	bne	a0,s3,ffffffffc020012e <readline+0x7c>
ffffffffc020010a:	e8a9                	bnez	s1,ffffffffc020015c <readline+0xaa>
ffffffffc020010c:	0d8000ef          	jal	ra,ffffffffc02001e4 <getchar>
ffffffffc0200110:	fe0549e3          	bltz	a0,ffffffffc0200102 <readline+0x50>
ffffffffc0200114:	fea959e3          	bge	s2,a0,ffffffffc0200106 <readline+0x54>
ffffffffc0200118:	4481                	li	s1,0
ffffffffc020011a:	e42a                	sd	a0,8(sp)
ffffffffc020011c:	0c6000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0200120:	6522                	ld	a0,8(sp)
ffffffffc0200122:	009b87b3          	add	a5,s7,s1
ffffffffc0200126:	2485                	addiw	s1,s1,1
ffffffffc0200128:	00a78023          	sb	a0,0(a5)
ffffffffc020012c:	bf7d                	j	ffffffffc02000ea <readline+0x38>
ffffffffc020012e:	01550463          	beq	a0,s5,ffffffffc0200136 <readline+0x84>
ffffffffc0200132:	fb651ce3          	bne	a0,s6,ffffffffc02000ea <readline+0x38>
ffffffffc0200136:	0ac000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc020013a:	00091517          	auipc	a0,0x91
ffffffffc020013e:	f2650513          	addi	a0,a0,-218 # ffffffffc0291060 <buf>
ffffffffc0200142:	94aa                	add	s1,s1,a0
ffffffffc0200144:	00048023          	sb	zero,0(s1)
ffffffffc0200148:	60a6                	ld	ra,72(sp)
ffffffffc020014a:	6486                	ld	s1,64(sp)
ffffffffc020014c:	7962                	ld	s2,56(sp)
ffffffffc020014e:	79c2                	ld	s3,48(sp)
ffffffffc0200150:	7a22                	ld	s4,40(sp)
ffffffffc0200152:	7a82                	ld	s5,32(sp)
ffffffffc0200154:	6b62                	ld	s6,24(sp)
ffffffffc0200156:	6bc2                	ld	s7,16(sp)
ffffffffc0200158:	6161                	addi	sp,sp,80
ffffffffc020015a:	8082                	ret
ffffffffc020015c:	4521                	li	a0,8
ffffffffc020015e:	084000ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0200162:	34fd                	addiw	s1,s1,-1
ffffffffc0200164:	b759                	j	ffffffffc02000ea <readline+0x38>

ffffffffc0200166 <cputch>:
ffffffffc0200166:	1141                	addi	sp,sp,-16
ffffffffc0200168:	e022                	sd	s0,0(sp)
ffffffffc020016a:	e406                	sd	ra,8(sp)
ffffffffc020016c:	842e                	mv	s0,a1
ffffffffc020016e:	432000ef          	jal	ra,ffffffffc02005a0 <cons_putc>
ffffffffc0200172:	401c                	lw	a5,0(s0)
ffffffffc0200174:	60a2                	ld	ra,8(sp)
ffffffffc0200176:	2785                	addiw	a5,a5,1
ffffffffc0200178:	c01c                	sw	a5,0(s0)
ffffffffc020017a:	6402                	ld	s0,0(sp)
ffffffffc020017c:	0141                	addi	sp,sp,16
ffffffffc020017e:	8082                	ret

ffffffffc0200180 <vcprintf>:
ffffffffc0200180:	1101                	addi	sp,sp,-32
ffffffffc0200182:	872e                	mv	a4,a1
ffffffffc0200184:	75dd                	lui	a1,0xffff7
ffffffffc0200186:	86aa                	mv	a3,a0
ffffffffc0200188:	0070                	addi	a2,sp,12
ffffffffc020018a:	00000517          	auipc	a0,0x0
ffffffffc020018e:	fdc50513          	addi	a0,a0,-36 # ffffffffc0200166 <cputch>
ffffffffc0200192:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0200196:	ec06                	sd	ra,24(sp)
ffffffffc0200198:	c602                	sw	zero,12(sp)
ffffffffc020019a:	73f0a0ef          	jal	ra,ffffffffc020b0d8 <vprintfmt>
ffffffffc020019e:	60e2                	ld	ra,24(sp)
ffffffffc02001a0:	4532                	lw	a0,12(sp)
ffffffffc02001a2:	6105                	addi	sp,sp,32
ffffffffc02001a4:	8082                	ret

ffffffffc02001a6 <cprintf>:
ffffffffc02001a6:	711d                	addi	sp,sp,-96
ffffffffc02001a8:	02810313          	addi	t1,sp,40 # ffffffffc0213028 <boot_page_table_sv39+0x28>
ffffffffc02001ac:	8e2a                	mv	t3,a0
ffffffffc02001ae:	f42e                	sd	a1,40(sp)
ffffffffc02001b0:	75dd                	lui	a1,0xffff7
ffffffffc02001b2:	f832                	sd	a2,48(sp)
ffffffffc02001b4:	fc36                	sd	a3,56(sp)
ffffffffc02001b6:	e0ba                	sd	a4,64(sp)
ffffffffc02001b8:	00000517          	auipc	a0,0x0
ffffffffc02001bc:	fae50513          	addi	a0,a0,-82 # ffffffffc0200166 <cputch>
ffffffffc02001c0:	0050                	addi	a2,sp,4
ffffffffc02001c2:	871a                	mv	a4,t1
ffffffffc02001c4:	86f2                	mv	a3,t3
ffffffffc02001c6:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc02001ca:	ec06                	sd	ra,24(sp)
ffffffffc02001cc:	e4be                	sd	a5,72(sp)
ffffffffc02001ce:	e8c2                	sd	a6,80(sp)
ffffffffc02001d0:	ecc6                	sd	a7,88(sp)
ffffffffc02001d2:	e41a                	sd	t1,8(sp)
ffffffffc02001d4:	c202                	sw	zero,4(sp)
ffffffffc02001d6:	7030a0ef          	jal	ra,ffffffffc020b0d8 <vprintfmt>
ffffffffc02001da:	60e2                	ld	ra,24(sp)
ffffffffc02001dc:	4512                	lw	a0,4(sp)
ffffffffc02001de:	6125                	addi	sp,sp,96
ffffffffc02001e0:	8082                	ret

ffffffffc02001e2 <cputchar>:
ffffffffc02001e2:	ae7d                	j	ffffffffc02005a0 <cons_putc>

ffffffffc02001e4 <getchar>:
ffffffffc02001e4:	1141                	addi	sp,sp,-16
ffffffffc02001e6:	e406                	sd	ra,8(sp)
ffffffffc02001e8:	40c000ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc02001ec:	dd75                	beqz	a0,ffffffffc02001e8 <getchar+0x4>
ffffffffc02001ee:	60a2                	ld	ra,8(sp)
ffffffffc02001f0:	0141                	addi	sp,sp,16
ffffffffc02001f2:	8082                	ret

ffffffffc02001f4 <strdup>:
ffffffffc02001f4:	1101                	addi	sp,sp,-32
ffffffffc02001f6:	ec06                	sd	ra,24(sp)
ffffffffc02001f8:	e822                	sd	s0,16(sp)
ffffffffc02001fa:	e426                	sd	s1,8(sp)
ffffffffc02001fc:	e04a                	sd	s2,0(sp)
ffffffffc02001fe:	892a                	mv	s2,a0
ffffffffc0200200:	2c40b0ef          	jal	ra,ffffffffc020b4c4 <strlen>
ffffffffc0200204:	842a                	mv	s0,a0
ffffffffc0200206:	0505                	addi	a0,a0,1
ffffffffc0200208:	587010ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020020c:	84aa                	mv	s1,a0
ffffffffc020020e:	c901                	beqz	a0,ffffffffc020021e <strdup+0x2a>
ffffffffc0200210:	8622                	mv	a2,s0
ffffffffc0200212:	85ca                	mv	a1,s2
ffffffffc0200214:	9426                	add	s0,s0,s1
ffffffffc0200216:	3a20b0ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc020021a:	00040023          	sb	zero,0(s0)
ffffffffc020021e:	60e2                	ld	ra,24(sp)
ffffffffc0200220:	6442                	ld	s0,16(sp)
ffffffffc0200222:	6902                	ld	s2,0(sp)
ffffffffc0200224:	8526                	mv	a0,s1
ffffffffc0200226:	64a2                	ld	s1,8(sp)
ffffffffc0200228:	6105                	addi	sp,sp,32
ffffffffc020022a:	8082                	ret

ffffffffc020022c <print_kerninfo>:
ffffffffc020022c:	1141                	addi	sp,sp,-16
ffffffffc020022e:	0000b517          	auipc	a0,0xb
ffffffffc0200232:	3d250513          	addi	a0,a0,978 # ffffffffc020b600 <etext+0x30>
ffffffffc0200236:	e406                	sd	ra,8(sp)
ffffffffc0200238:	f6fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020023c:	00000597          	auipc	a1,0x0
ffffffffc0200240:	e0e58593          	addi	a1,a1,-498 # ffffffffc020004a <kern_init>
ffffffffc0200244:	0000b517          	auipc	a0,0xb
ffffffffc0200248:	3dc50513          	addi	a0,a0,988 # ffffffffc020b620 <etext+0x50>
ffffffffc020024c:	f5bff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200250:	0000b597          	auipc	a1,0xb
ffffffffc0200254:	38058593          	addi	a1,a1,896 # ffffffffc020b5d0 <etext>
ffffffffc0200258:	0000b517          	auipc	a0,0xb
ffffffffc020025c:	3e850513          	addi	a0,a0,1000 # ffffffffc020b640 <etext+0x70>
ffffffffc0200260:	f47ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200264:	00091597          	auipc	a1,0x91
ffffffffc0200268:	dfc58593          	addi	a1,a1,-516 # ffffffffc0291060 <buf>
ffffffffc020026c:	0000b517          	auipc	a0,0xb
ffffffffc0200270:	3f450513          	addi	a0,a0,1012 # ffffffffc020b660 <etext+0x90>
ffffffffc0200274:	f33ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200278:	00096597          	auipc	a1,0x96
ffffffffc020027c:	69858593          	addi	a1,a1,1688 # ffffffffc0296910 <end>
ffffffffc0200280:	0000b517          	auipc	a0,0xb
ffffffffc0200284:	40050513          	addi	a0,a0,1024 # ffffffffc020b680 <etext+0xb0>
ffffffffc0200288:	f1fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020028c:	00097597          	auipc	a1,0x97
ffffffffc0200290:	a8358593          	addi	a1,a1,-1405 # ffffffffc0296d0f <end+0x3ff>
ffffffffc0200294:	00000797          	auipc	a5,0x0
ffffffffc0200298:	db678793          	addi	a5,a5,-586 # ffffffffc020004a <kern_init>
ffffffffc020029c:	40f587b3          	sub	a5,a1,a5
ffffffffc02002a0:	43f7d593          	srai	a1,a5,0x3f
ffffffffc02002a4:	60a2                	ld	ra,8(sp)
ffffffffc02002a6:	3ff5f593          	andi	a1,a1,1023
ffffffffc02002aa:	95be                	add	a1,a1,a5
ffffffffc02002ac:	85a9                	srai	a1,a1,0xa
ffffffffc02002ae:	0000b517          	auipc	a0,0xb
ffffffffc02002b2:	3f250513          	addi	a0,a0,1010 # ffffffffc020b6a0 <etext+0xd0>
ffffffffc02002b6:	0141                	addi	sp,sp,16
ffffffffc02002b8:	b5fd                	j	ffffffffc02001a6 <cprintf>

ffffffffc02002ba <print_stackframe>:
ffffffffc02002ba:	1141                	addi	sp,sp,-16
ffffffffc02002bc:	0000b617          	auipc	a2,0xb
ffffffffc02002c0:	41460613          	addi	a2,a2,1044 # ffffffffc020b6d0 <etext+0x100>
ffffffffc02002c4:	04e00593          	li	a1,78
ffffffffc02002c8:	0000b517          	auipc	a0,0xb
ffffffffc02002cc:	42050513          	addi	a0,a0,1056 # ffffffffc020b6e8 <etext+0x118>
ffffffffc02002d0:	e406                	sd	ra,8(sp)
ffffffffc02002d2:	1cc000ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02002d6 <mon_help>:
ffffffffc02002d6:	1141                	addi	sp,sp,-16
ffffffffc02002d8:	0000b617          	auipc	a2,0xb
ffffffffc02002dc:	42860613          	addi	a2,a2,1064 # ffffffffc020b700 <etext+0x130>
ffffffffc02002e0:	0000b597          	auipc	a1,0xb
ffffffffc02002e4:	44058593          	addi	a1,a1,1088 # ffffffffc020b720 <etext+0x150>
ffffffffc02002e8:	0000b517          	auipc	a0,0xb
ffffffffc02002ec:	44050513          	addi	a0,a0,1088 # ffffffffc020b728 <etext+0x158>
ffffffffc02002f0:	e406                	sd	ra,8(sp)
ffffffffc02002f2:	eb5ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02002f6:	0000b617          	auipc	a2,0xb
ffffffffc02002fa:	44260613          	addi	a2,a2,1090 # ffffffffc020b738 <etext+0x168>
ffffffffc02002fe:	0000b597          	auipc	a1,0xb
ffffffffc0200302:	46258593          	addi	a1,a1,1122 # ffffffffc020b760 <etext+0x190>
ffffffffc0200306:	0000b517          	auipc	a0,0xb
ffffffffc020030a:	42250513          	addi	a0,a0,1058 # ffffffffc020b728 <etext+0x158>
ffffffffc020030e:	e99ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200312:	0000b617          	auipc	a2,0xb
ffffffffc0200316:	45e60613          	addi	a2,a2,1118 # ffffffffc020b770 <etext+0x1a0>
ffffffffc020031a:	0000b597          	auipc	a1,0xb
ffffffffc020031e:	47658593          	addi	a1,a1,1142 # ffffffffc020b790 <etext+0x1c0>
ffffffffc0200322:	0000b517          	auipc	a0,0xb
ffffffffc0200326:	40650513          	addi	a0,a0,1030 # ffffffffc020b728 <etext+0x158>
ffffffffc020032a:	e7dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020032e:	60a2                	ld	ra,8(sp)
ffffffffc0200330:	4501                	li	a0,0
ffffffffc0200332:	0141                	addi	sp,sp,16
ffffffffc0200334:	8082                	ret

ffffffffc0200336 <mon_kerninfo>:
ffffffffc0200336:	1141                	addi	sp,sp,-16
ffffffffc0200338:	e406                	sd	ra,8(sp)
ffffffffc020033a:	ef3ff0ef          	jal	ra,ffffffffc020022c <print_kerninfo>
ffffffffc020033e:	60a2                	ld	ra,8(sp)
ffffffffc0200340:	4501                	li	a0,0
ffffffffc0200342:	0141                	addi	sp,sp,16
ffffffffc0200344:	8082                	ret

ffffffffc0200346 <mon_backtrace>:
ffffffffc0200346:	1141                	addi	sp,sp,-16
ffffffffc0200348:	e406                	sd	ra,8(sp)
ffffffffc020034a:	f71ff0ef          	jal	ra,ffffffffc02002ba <print_stackframe>
ffffffffc020034e:	60a2                	ld	ra,8(sp)
ffffffffc0200350:	4501                	li	a0,0
ffffffffc0200352:	0141                	addi	sp,sp,16
ffffffffc0200354:	8082                	ret

ffffffffc0200356 <kmonitor>:
ffffffffc0200356:	7115                	addi	sp,sp,-224
ffffffffc0200358:	ed5e                	sd	s7,152(sp)
ffffffffc020035a:	8baa                	mv	s7,a0
ffffffffc020035c:	0000b517          	auipc	a0,0xb
ffffffffc0200360:	44450513          	addi	a0,a0,1092 # ffffffffc020b7a0 <etext+0x1d0>
ffffffffc0200364:	ed86                	sd	ra,216(sp)
ffffffffc0200366:	e9a2                	sd	s0,208(sp)
ffffffffc0200368:	e5a6                	sd	s1,200(sp)
ffffffffc020036a:	e1ca                	sd	s2,192(sp)
ffffffffc020036c:	fd4e                	sd	s3,184(sp)
ffffffffc020036e:	f952                	sd	s4,176(sp)
ffffffffc0200370:	f556                	sd	s5,168(sp)
ffffffffc0200372:	f15a                	sd	s6,160(sp)
ffffffffc0200374:	e962                	sd	s8,144(sp)
ffffffffc0200376:	e566                	sd	s9,136(sp)
ffffffffc0200378:	e16a                	sd	s10,128(sp)
ffffffffc020037a:	e2dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020037e:	0000b517          	auipc	a0,0xb
ffffffffc0200382:	44a50513          	addi	a0,a0,1098 # ffffffffc020b7c8 <etext+0x1f8>
ffffffffc0200386:	e21ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020038a:	000b8563          	beqz	s7,ffffffffc0200394 <kmonitor+0x3e>
ffffffffc020038e:	855e                	mv	a0,s7
ffffffffc0200390:	3fb000ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc0200394:	0000bc17          	auipc	s8,0xb
ffffffffc0200398:	4a4c0c13          	addi	s8,s8,1188 # ffffffffc020b838 <commands>
ffffffffc020039c:	0000b917          	auipc	s2,0xb
ffffffffc02003a0:	45490913          	addi	s2,s2,1108 # ffffffffc020b7f0 <etext+0x220>
ffffffffc02003a4:	0000b497          	auipc	s1,0xb
ffffffffc02003a8:	45448493          	addi	s1,s1,1108 # ffffffffc020b7f8 <etext+0x228>
ffffffffc02003ac:	49bd                	li	s3,15
ffffffffc02003ae:	0000bb17          	auipc	s6,0xb
ffffffffc02003b2:	452b0b13          	addi	s6,s6,1106 # ffffffffc020b800 <etext+0x230>
ffffffffc02003b6:	0000ba17          	auipc	s4,0xb
ffffffffc02003ba:	36aa0a13          	addi	s4,s4,874 # ffffffffc020b720 <etext+0x150>
ffffffffc02003be:	4a8d                	li	s5,3
ffffffffc02003c0:	854a                	mv	a0,s2
ffffffffc02003c2:	cf1ff0ef          	jal	ra,ffffffffc02000b2 <readline>
ffffffffc02003c6:	842a                	mv	s0,a0
ffffffffc02003c8:	dd65                	beqz	a0,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc02003ca:	00054583          	lbu	a1,0(a0)
ffffffffc02003ce:	4c81                	li	s9,0
ffffffffc02003d0:	e1bd                	bnez	a1,ffffffffc0200436 <kmonitor+0xe0>
ffffffffc02003d2:	fe0c87e3          	beqz	s9,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc02003d6:	6582                	ld	a1,0(sp)
ffffffffc02003d8:	0000bd17          	auipc	s10,0xb
ffffffffc02003dc:	460d0d13          	addi	s10,s10,1120 # ffffffffc020b838 <commands>
ffffffffc02003e0:	8552                	mv	a0,s4
ffffffffc02003e2:	4401                	li	s0,0
ffffffffc02003e4:	0d61                	addi	s10,s10,24
ffffffffc02003e6:	1260b0ef          	jal	ra,ffffffffc020b50c <strcmp>
ffffffffc02003ea:	c919                	beqz	a0,ffffffffc0200400 <kmonitor+0xaa>
ffffffffc02003ec:	2405                	addiw	s0,s0,1
ffffffffc02003ee:	0b540063          	beq	s0,s5,ffffffffc020048e <kmonitor+0x138>
ffffffffc02003f2:	000d3503          	ld	a0,0(s10)
ffffffffc02003f6:	6582                	ld	a1,0(sp)
ffffffffc02003f8:	0d61                	addi	s10,s10,24
ffffffffc02003fa:	1120b0ef          	jal	ra,ffffffffc020b50c <strcmp>
ffffffffc02003fe:	f57d                	bnez	a0,ffffffffc02003ec <kmonitor+0x96>
ffffffffc0200400:	00141793          	slli	a5,s0,0x1
ffffffffc0200404:	97a2                	add	a5,a5,s0
ffffffffc0200406:	078e                	slli	a5,a5,0x3
ffffffffc0200408:	97e2                	add	a5,a5,s8
ffffffffc020040a:	6b9c                	ld	a5,16(a5)
ffffffffc020040c:	865e                	mv	a2,s7
ffffffffc020040e:	002c                	addi	a1,sp,8
ffffffffc0200410:	fffc851b          	addiw	a0,s9,-1
ffffffffc0200414:	9782                	jalr	a5
ffffffffc0200416:	fa0555e3          	bgez	a0,ffffffffc02003c0 <kmonitor+0x6a>
ffffffffc020041a:	60ee                	ld	ra,216(sp)
ffffffffc020041c:	644e                	ld	s0,208(sp)
ffffffffc020041e:	64ae                	ld	s1,200(sp)
ffffffffc0200420:	690e                	ld	s2,192(sp)
ffffffffc0200422:	79ea                	ld	s3,184(sp)
ffffffffc0200424:	7a4a                	ld	s4,176(sp)
ffffffffc0200426:	7aaa                	ld	s5,168(sp)
ffffffffc0200428:	7b0a                	ld	s6,160(sp)
ffffffffc020042a:	6bea                	ld	s7,152(sp)
ffffffffc020042c:	6c4a                	ld	s8,144(sp)
ffffffffc020042e:	6caa                	ld	s9,136(sp)
ffffffffc0200430:	6d0a                	ld	s10,128(sp)
ffffffffc0200432:	612d                	addi	sp,sp,224
ffffffffc0200434:	8082                	ret
ffffffffc0200436:	8526                	mv	a0,s1
ffffffffc0200438:	1180b0ef          	jal	ra,ffffffffc020b550 <strchr>
ffffffffc020043c:	c901                	beqz	a0,ffffffffc020044c <kmonitor+0xf6>
ffffffffc020043e:	00144583          	lbu	a1,1(s0)
ffffffffc0200442:	00040023          	sb	zero,0(s0)
ffffffffc0200446:	0405                	addi	s0,s0,1
ffffffffc0200448:	d5c9                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc020044a:	b7f5                	j	ffffffffc0200436 <kmonitor+0xe0>
ffffffffc020044c:	00044783          	lbu	a5,0(s0)
ffffffffc0200450:	d3c9                	beqz	a5,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200452:	033c8963          	beq	s9,s3,ffffffffc0200484 <kmonitor+0x12e>
ffffffffc0200456:	003c9793          	slli	a5,s9,0x3
ffffffffc020045a:	0118                	addi	a4,sp,128
ffffffffc020045c:	97ba                	add	a5,a5,a4
ffffffffc020045e:	f887b023          	sd	s0,-128(a5)
ffffffffc0200462:	00044583          	lbu	a1,0(s0)
ffffffffc0200466:	2c85                	addiw	s9,s9,1
ffffffffc0200468:	e591                	bnez	a1,ffffffffc0200474 <kmonitor+0x11e>
ffffffffc020046a:	b7b5                	j	ffffffffc02003d6 <kmonitor+0x80>
ffffffffc020046c:	00144583          	lbu	a1,1(s0)
ffffffffc0200470:	0405                	addi	s0,s0,1
ffffffffc0200472:	d1a5                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200474:	8526                	mv	a0,s1
ffffffffc0200476:	0da0b0ef          	jal	ra,ffffffffc020b550 <strchr>
ffffffffc020047a:	d96d                	beqz	a0,ffffffffc020046c <kmonitor+0x116>
ffffffffc020047c:	00044583          	lbu	a1,0(s0)
ffffffffc0200480:	d9a9                	beqz	a1,ffffffffc02003d2 <kmonitor+0x7c>
ffffffffc0200482:	bf55                	j	ffffffffc0200436 <kmonitor+0xe0>
ffffffffc0200484:	45c1                	li	a1,16
ffffffffc0200486:	855a                	mv	a0,s6
ffffffffc0200488:	d1fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020048c:	b7e9                	j	ffffffffc0200456 <kmonitor+0x100>
ffffffffc020048e:	6582                	ld	a1,0(sp)
ffffffffc0200490:	0000b517          	auipc	a0,0xb
ffffffffc0200494:	39050513          	addi	a0,a0,912 # ffffffffc020b820 <etext+0x250>
ffffffffc0200498:	d0fff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020049c:	b715                	j	ffffffffc02003c0 <kmonitor+0x6a>

ffffffffc020049e <__panic>:
ffffffffc020049e:	00096317          	auipc	t1,0x96
ffffffffc02004a2:	3ca30313          	addi	t1,t1,970 # ffffffffc0296868 <is_panic>
ffffffffc02004a6:	00033e03          	ld	t3,0(t1)
ffffffffc02004aa:	715d                	addi	sp,sp,-80
ffffffffc02004ac:	ec06                	sd	ra,24(sp)
ffffffffc02004ae:	e822                	sd	s0,16(sp)
ffffffffc02004b0:	f436                	sd	a3,40(sp)
ffffffffc02004b2:	f83a                	sd	a4,48(sp)
ffffffffc02004b4:	fc3e                	sd	a5,56(sp)
ffffffffc02004b6:	e0c2                	sd	a6,64(sp)
ffffffffc02004b8:	e4c6                	sd	a7,72(sp)
ffffffffc02004ba:	020e1a63          	bnez	t3,ffffffffc02004ee <__panic+0x50>
ffffffffc02004be:	4785                	li	a5,1
ffffffffc02004c0:	00f33023          	sd	a5,0(t1)
ffffffffc02004c4:	8432                	mv	s0,a2
ffffffffc02004c6:	103c                	addi	a5,sp,40
ffffffffc02004c8:	862e                	mv	a2,a1
ffffffffc02004ca:	85aa                	mv	a1,a0
ffffffffc02004cc:	0000b517          	auipc	a0,0xb
ffffffffc02004d0:	3b450513          	addi	a0,a0,948 # ffffffffc020b880 <commands+0x48>
ffffffffc02004d4:	e43e                	sd	a5,8(sp)
ffffffffc02004d6:	cd1ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004da:	65a2                	ld	a1,8(sp)
ffffffffc02004dc:	8522                	mv	a0,s0
ffffffffc02004de:	ca3ff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc02004e2:	0000c517          	auipc	a0,0xc
ffffffffc02004e6:	65e50513          	addi	a0,a0,1630 # ffffffffc020cb40 <default_pmm_manager+0x610>
ffffffffc02004ea:	cbdff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02004ee:	4501                	li	a0,0
ffffffffc02004f0:	4581                	li	a1,0
ffffffffc02004f2:	4601                	li	a2,0
ffffffffc02004f4:	48a1                	li	a7,8
ffffffffc02004f6:	00000073          	ecall
ffffffffc02004fa:	778000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02004fe:	4501                	li	a0,0
ffffffffc0200500:	e57ff0ef          	jal	ra,ffffffffc0200356 <kmonitor>
ffffffffc0200504:	bfed                	j	ffffffffc02004fe <__panic+0x60>

ffffffffc0200506 <__warn>:
ffffffffc0200506:	715d                	addi	sp,sp,-80
ffffffffc0200508:	832e                	mv	t1,a1
ffffffffc020050a:	e822                	sd	s0,16(sp)
ffffffffc020050c:	85aa                	mv	a1,a0
ffffffffc020050e:	8432                	mv	s0,a2
ffffffffc0200510:	fc3e                	sd	a5,56(sp)
ffffffffc0200512:	861a                	mv	a2,t1
ffffffffc0200514:	103c                	addi	a5,sp,40
ffffffffc0200516:	0000b517          	auipc	a0,0xb
ffffffffc020051a:	38a50513          	addi	a0,a0,906 # ffffffffc020b8a0 <commands+0x68>
ffffffffc020051e:	ec06                	sd	ra,24(sp)
ffffffffc0200520:	f436                	sd	a3,40(sp)
ffffffffc0200522:	f83a                	sd	a4,48(sp)
ffffffffc0200524:	e0c2                	sd	a6,64(sp)
ffffffffc0200526:	e4c6                	sd	a7,72(sp)
ffffffffc0200528:	e43e                	sd	a5,8(sp)
ffffffffc020052a:	c7dff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020052e:	65a2                	ld	a1,8(sp)
ffffffffc0200530:	8522                	mv	a0,s0
ffffffffc0200532:	c4fff0ef          	jal	ra,ffffffffc0200180 <vcprintf>
ffffffffc0200536:	0000c517          	auipc	a0,0xc
ffffffffc020053a:	60a50513          	addi	a0,a0,1546 # ffffffffc020cb40 <default_pmm_manager+0x610>
ffffffffc020053e:	c69ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200542:	60e2                	ld	ra,24(sp)
ffffffffc0200544:	6442                	ld	s0,16(sp)
ffffffffc0200546:	6161                	addi	sp,sp,80
ffffffffc0200548:	8082                	ret

ffffffffc020054a <clock_init>:
ffffffffc020054a:	02000793          	li	a5,32
ffffffffc020054e:	1047a7f3          	csrrs	a5,sie,a5
ffffffffc0200552:	c0102573          	rdtime	a0
ffffffffc0200556:	67e1                	lui	a5,0x18
ffffffffc0200558:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc020055c:	953e                	add	a0,a0,a5
ffffffffc020055e:	4581                	li	a1,0
ffffffffc0200560:	4601                	li	a2,0
ffffffffc0200562:	4881                	li	a7,0
ffffffffc0200564:	00000073          	ecall
ffffffffc0200568:	0000b517          	auipc	a0,0xb
ffffffffc020056c:	35850513          	addi	a0,a0,856 # ffffffffc020b8c0 <commands+0x88>
ffffffffc0200570:	00096797          	auipc	a5,0x96
ffffffffc0200574:	3007b023          	sd	zero,768(a5) # ffffffffc0296870 <ticks>
ffffffffc0200578:	b13d                	j	ffffffffc02001a6 <cprintf>

ffffffffc020057a <clock_set_next_event>:
ffffffffc020057a:	c0102573          	rdtime	a0
ffffffffc020057e:	67e1                	lui	a5,0x18
ffffffffc0200580:	6a078793          	addi	a5,a5,1696 # 186a0 <_binary_bin_swap_img_size+0x109a0>
ffffffffc0200584:	953e                	add	a0,a0,a5
ffffffffc0200586:	4581                	li	a1,0
ffffffffc0200588:	4601                	li	a2,0
ffffffffc020058a:	4881                	li	a7,0
ffffffffc020058c:	00000073          	ecall
ffffffffc0200590:	8082                	ret

ffffffffc0200592 <cons_init>:
ffffffffc0200592:	4501                	li	a0,0
ffffffffc0200594:	4581                	li	a1,0
ffffffffc0200596:	4601                	li	a2,0
ffffffffc0200598:	4889                	li	a7,2
ffffffffc020059a:	00000073          	ecall
ffffffffc020059e:	8082                	ret

ffffffffc02005a0 <cons_putc>:
ffffffffc02005a0:	1101                	addi	sp,sp,-32
ffffffffc02005a2:	ec06                	sd	ra,24(sp)
ffffffffc02005a4:	100027f3          	csrr	a5,sstatus
ffffffffc02005a8:	8b89                	andi	a5,a5,2
ffffffffc02005aa:	4701                	li	a4,0
ffffffffc02005ac:	ef95                	bnez	a5,ffffffffc02005e8 <cons_putc+0x48>
ffffffffc02005ae:	47a1                	li	a5,8
ffffffffc02005b0:	00f50b63          	beq	a0,a5,ffffffffc02005c6 <cons_putc+0x26>
ffffffffc02005b4:	4581                	li	a1,0
ffffffffc02005b6:	4601                	li	a2,0
ffffffffc02005b8:	4885                	li	a7,1
ffffffffc02005ba:	00000073          	ecall
ffffffffc02005be:	e315                	bnez	a4,ffffffffc02005e2 <cons_putc+0x42>
ffffffffc02005c0:	60e2                	ld	ra,24(sp)
ffffffffc02005c2:	6105                	addi	sp,sp,32
ffffffffc02005c4:	8082                	ret
ffffffffc02005c6:	4521                	li	a0,8
ffffffffc02005c8:	4581                	li	a1,0
ffffffffc02005ca:	4601                	li	a2,0
ffffffffc02005cc:	4885                	li	a7,1
ffffffffc02005ce:	00000073          	ecall
ffffffffc02005d2:	02000513          	li	a0,32
ffffffffc02005d6:	00000073          	ecall
ffffffffc02005da:	4521                	li	a0,8
ffffffffc02005dc:	00000073          	ecall
ffffffffc02005e0:	d365                	beqz	a4,ffffffffc02005c0 <cons_putc+0x20>
ffffffffc02005e2:	60e2                	ld	ra,24(sp)
ffffffffc02005e4:	6105                	addi	sp,sp,32
ffffffffc02005e6:	a559                	j	ffffffffc0200c6c <intr_enable>
ffffffffc02005e8:	e42a                	sd	a0,8(sp)
ffffffffc02005ea:	688000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02005ee:	6522                	ld	a0,8(sp)
ffffffffc02005f0:	4705                	li	a4,1
ffffffffc02005f2:	bf75                	j	ffffffffc02005ae <cons_putc+0xe>

ffffffffc02005f4 <cons_getc>:
ffffffffc02005f4:	1101                	addi	sp,sp,-32
ffffffffc02005f6:	ec06                	sd	ra,24(sp)
ffffffffc02005f8:	100027f3          	csrr	a5,sstatus
ffffffffc02005fc:	8b89                	andi	a5,a5,2
ffffffffc02005fe:	4801                	li	a6,0
ffffffffc0200600:	e3d5                	bnez	a5,ffffffffc02006a4 <cons_getc+0xb0>
ffffffffc0200602:	00091697          	auipc	a3,0x91
ffffffffc0200606:	e5e68693          	addi	a3,a3,-418 # ffffffffc0291460 <cons>
ffffffffc020060a:	07f00713          	li	a4,127
ffffffffc020060e:	20000313          	li	t1,512
ffffffffc0200612:	a021                	j	ffffffffc020061a <cons_getc+0x26>
ffffffffc0200614:	0ff57513          	zext.b	a0,a0
ffffffffc0200618:	ef91                	bnez	a5,ffffffffc0200634 <cons_getc+0x40>
ffffffffc020061a:	4501                	li	a0,0
ffffffffc020061c:	4581                	li	a1,0
ffffffffc020061e:	4601                	li	a2,0
ffffffffc0200620:	4889                	li	a7,2
ffffffffc0200622:	00000073          	ecall
ffffffffc0200626:	0005079b          	sext.w	a5,a0
ffffffffc020062a:	0207c763          	bltz	a5,ffffffffc0200658 <cons_getc+0x64>
ffffffffc020062e:	fee793e3          	bne	a5,a4,ffffffffc0200614 <cons_getc+0x20>
ffffffffc0200632:	4521                	li	a0,8
ffffffffc0200634:	2046a783          	lw	a5,516(a3)
ffffffffc0200638:	02079613          	slli	a2,a5,0x20
ffffffffc020063c:	9201                	srli	a2,a2,0x20
ffffffffc020063e:	2785                	addiw	a5,a5,1
ffffffffc0200640:	9636                	add	a2,a2,a3
ffffffffc0200642:	20f6a223          	sw	a5,516(a3)
ffffffffc0200646:	00a60023          	sb	a0,0(a2)
ffffffffc020064a:	fc6798e3          	bne	a5,t1,ffffffffc020061a <cons_getc+0x26>
ffffffffc020064e:	00091797          	auipc	a5,0x91
ffffffffc0200652:	0007ab23          	sw	zero,22(a5) # ffffffffc0291664 <cons+0x204>
ffffffffc0200656:	b7d1                	j	ffffffffc020061a <cons_getc+0x26>
ffffffffc0200658:	2006a783          	lw	a5,512(a3)
ffffffffc020065c:	2046a703          	lw	a4,516(a3)
ffffffffc0200660:	4501                	li	a0,0
ffffffffc0200662:	00f70f63          	beq	a4,a5,ffffffffc0200680 <cons_getc+0x8c>
ffffffffc0200666:	0017861b          	addiw	a2,a5,1
ffffffffc020066a:	1782                	slli	a5,a5,0x20
ffffffffc020066c:	9381                	srli	a5,a5,0x20
ffffffffc020066e:	97b6                	add	a5,a5,a3
ffffffffc0200670:	20c6a023          	sw	a2,512(a3)
ffffffffc0200674:	20000713          	li	a4,512
ffffffffc0200678:	0007c503          	lbu	a0,0(a5)
ffffffffc020067c:	00e60763          	beq	a2,a4,ffffffffc020068a <cons_getc+0x96>
ffffffffc0200680:	00081b63          	bnez	a6,ffffffffc0200696 <cons_getc+0xa2>
ffffffffc0200684:	60e2                	ld	ra,24(sp)
ffffffffc0200686:	6105                	addi	sp,sp,32
ffffffffc0200688:	8082                	ret
ffffffffc020068a:	00091797          	auipc	a5,0x91
ffffffffc020068e:	fc07ab23          	sw	zero,-42(a5) # ffffffffc0291660 <cons+0x200>
ffffffffc0200692:	fe0809e3          	beqz	a6,ffffffffc0200684 <cons_getc+0x90>
ffffffffc0200696:	e42a                	sd	a0,8(sp)
ffffffffc0200698:	5d4000ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020069c:	60e2                	ld	ra,24(sp)
ffffffffc020069e:	6522                	ld	a0,8(sp)
ffffffffc02006a0:	6105                	addi	sp,sp,32
ffffffffc02006a2:	8082                	ret
ffffffffc02006a4:	5ce000ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02006a8:	4805                	li	a6,1
ffffffffc02006aa:	bfa1                	j	ffffffffc0200602 <cons_getc+0xe>

ffffffffc02006ac <dtb_init>:
ffffffffc02006ac:	7119                	addi	sp,sp,-128
ffffffffc02006ae:	0000b517          	auipc	a0,0xb
ffffffffc02006b2:	23250513          	addi	a0,a0,562 # ffffffffc020b8e0 <commands+0xa8>
ffffffffc02006b6:	fc86                	sd	ra,120(sp)
ffffffffc02006b8:	f8a2                	sd	s0,112(sp)
ffffffffc02006ba:	e8d2                	sd	s4,80(sp)
ffffffffc02006bc:	f4a6                	sd	s1,104(sp)
ffffffffc02006be:	f0ca                	sd	s2,96(sp)
ffffffffc02006c0:	ecce                	sd	s3,88(sp)
ffffffffc02006c2:	e4d6                	sd	s5,72(sp)
ffffffffc02006c4:	e0da                	sd	s6,64(sp)
ffffffffc02006c6:	fc5e                	sd	s7,56(sp)
ffffffffc02006c8:	f862                	sd	s8,48(sp)
ffffffffc02006ca:	f466                	sd	s9,40(sp)
ffffffffc02006cc:	f06a                	sd	s10,32(sp)
ffffffffc02006ce:	ec6e                	sd	s11,24(sp)
ffffffffc02006d0:	ad7ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006d4:	00014597          	auipc	a1,0x14
ffffffffc02006d8:	92c5b583          	ld	a1,-1748(a1) # ffffffffc0214000 <boot_hartid>
ffffffffc02006dc:	0000b517          	auipc	a0,0xb
ffffffffc02006e0:	21450513          	addi	a0,a0,532 # ffffffffc020b8f0 <commands+0xb8>
ffffffffc02006e4:	ac3ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006e8:	00014417          	auipc	s0,0x14
ffffffffc02006ec:	92040413          	addi	s0,s0,-1760 # ffffffffc0214008 <boot_dtb>
ffffffffc02006f0:	600c                	ld	a1,0(s0)
ffffffffc02006f2:	0000b517          	auipc	a0,0xb
ffffffffc02006f6:	20e50513          	addi	a0,a0,526 # ffffffffc020b900 <commands+0xc8>
ffffffffc02006fa:	aadff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02006fe:	00043a03          	ld	s4,0(s0)
ffffffffc0200702:	0000b517          	auipc	a0,0xb
ffffffffc0200706:	21650513          	addi	a0,a0,534 # ffffffffc020b918 <commands+0xe0>
ffffffffc020070a:	120a0463          	beqz	s4,ffffffffc0200832 <dtb_init+0x186>
ffffffffc020070e:	57f5                	li	a5,-3
ffffffffc0200710:	07fa                	slli	a5,a5,0x1e
ffffffffc0200712:	00fa0733          	add	a4,s4,a5
ffffffffc0200716:	431c                	lw	a5,0(a4)
ffffffffc0200718:	00ff0637          	lui	a2,0xff0
ffffffffc020071c:	6b41                	lui	s6,0x10
ffffffffc020071e:	0087d59b          	srliw	a1,a5,0x8
ffffffffc0200722:	0187969b          	slliw	a3,a5,0x18
ffffffffc0200726:	0187d51b          	srliw	a0,a5,0x18
ffffffffc020072a:	0105959b          	slliw	a1,a1,0x10
ffffffffc020072e:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200732:	8df1                	and	a1,a1,a2
ffffffffc0200734:	8ec9                	or	a3,a3,a0
ffffffffc0200736:	0087979b          	slliw	a5,a5,0x8
ffffffffc020073a:	1b7d                	addi	s6,s6,-1
ffffffffc020073c:	0167f7b3          	and	a5,a5,s6
ffffffffc0200740:	8dd5                	or	a1,a1,a3
ffffffffc0200742:	8ddd                	or	a1,a1,a5
ffffffffc0200744:	d00e07b7          	lui	a5,0xd00e0
ffffffffc0200748:	2581                	sext.w	a1,a1
ffffffffc020074a:	eed78793          	addi	a5,a5,-275 # ffffffffd00dfeed <end+0xfe495dd>
ffffffffc020074e:	10f59163          	bne	a1,a5,ffffffffc0200850 <dtb_init+0x1a4>
ffffffffc0200752:	471c                	lw	a5,8(a4)
ffffffffc0200754:	4754                	lw	a3,12(a4)
ffffffffc0200756:	4c81                	li	s9,0
ffffffffc0200758:	0087d59b          	srliw	a1,a5,0x8
ffffffffc020075c:	0086d51b          	srliw	a0,a3,0x8
ffffffffc0200760:	0186941b          	slliw	s0,a3,0x18
ffffffffc0200764:	0186d89b          	srliw	a7,a3,0x18
ffffffffc0200768:	01879a1b          	slliw	s4,a5,0x18
ffffffffc020076c:	0187d81b          	srliw	a6,a5,0x18
ffffffffc0200770:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200774:	0106d69b          	srliw	a3,a3,0x10
ffffffffc0200778:	0105959b          	slliw	a1,a1,0x10
ffffffffc020077c:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200780:	8d71                	and	a0,a0,a2
ffffffffc0200782:	01146433          	or	s0,s0,a7
ffffffffc0200786:	0086969b          	slliw	a3,a3,0x8
ffffffffc020078a:	010a6a33          	or	s4,s4,a6
ffffffffc020078e:	8e6d                	and	a2,a2,a1
ffffffffc0200790:	0087979b          	slliw	a5,a5,0x8
ffffffffc0200794:	8c49                	or	s0,s0,a0
ffffffffc0200796:	0166f6b3          	and	a3,a3,s6
ffffffffc020079a:	00ca6a33          	or	s4,s4,a2
ffffffffc020079e:	0167f7b3          	and	a5,a5,s6
ffffffffc02007a2:	8c55                	or	s0,s0,a3
ffffffffc02007a4:	00fa6a33          	or	s4,s4,a5
ffffffffc02007a8:	1402                	slli	s0,s0,0x20
ffffffffc02007aa:	1a02                	slli	s4,s4,0x20
ffffffffc02007ac:	9001                	srli	s0,s0,0x20
ffffffffc02007ae:	020a5a13          	srli	s4,s4,0x20
ffffffffc02007b2:	943a                	add	s0,s0,a4
ffffffffc02007b4:	9a3a                	add	s4,s4,a4
ffffffffc02007b6:	00ff0c37          	lui	s8,0xff0
ffffffffc02007ba:	4b8d                	li	s7,3
ffffffffc02007bc:	0000b917          	auipc	s2,0xb
ffffffffc02007c0:	1ac90913          	addi	s2,s2,428 # ffffffffc020b968 <commands+0x130>
ffffffffc02007c4:	49bd                	li	s3,15
ffffffffc02007c6:	4d91                	li	s11,4
ffffffffc02007c8:	4d05                	li	s10,1
ffffffffc02007ca:	0000b497          	auipc	s1,0xb
ffffffffc02007ce:	19648493          	addi	s1,s1,406 # ffffffffc020b960 <commands+0x128>
ffffffffc02007d2:	000a2703          	lw	a4,0(s4)
ffffffffc02007d6:	004a0a93          	addi	s5,s4,4
ffffffffc02007da:	0087569b          	srliw	a3,a4,0x8
ffffffffc02007de:	0187179b          	slliw	a5,a4,0x18
ffffffffc02007e2:	0187561b          	srliw	a2,a4,0x18
ffffffffc02007e6:	0106969b          	slliw	a3,a3,0x10
ffffffffc02007ea:	0107571b          	srliw	a4,a4,0x10
ffffffffc02007ee:	8fd1                	or	a5,a5,a2
ffffffffc02007f0:	0186f6b3          	and	a3,a3,s8
ffffffffc02007f4:	0087171b          	slliw	a4,a4,0x8
ffffffffc02007f8:	8fd5                	or	a5,a5,a3
ffffffffc02007fa:	00eb7733          	and	a4,s6,a4
ffffffffc02007fe:	8fd9                	or	a5,a5,a4
ffffffffc0200800:	2781                	sext.w	a5,a5
ffffffffc0200802:	09778c63          	beq	a5,s7,ffffffffc020089a <dtb_init+0x1ee>
ffffffffc0200806:	00fbea63          	bltu	s7,a5,ffffffffc020081a <dtb_init+0x16e>
ffffffffc020080a:	07a78663          	beq	a5,s10,ffffffffc0200876 <dtb_init+0x1ca>
ffffffffc020080e:	4709                	li	a4,2
ffffffffc0200810:	00e79763          	bne	a5,a4,ffffffffc020081e <dtb_init+0x172>
ffffffffc0200814:	4c81                	li	s9,0
ffffffffc0200816:	8a56                	mv	s4,s5
ffffffffc0200818:	bf6d                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc020081a:	ffb78ee3          	beq	a5,s11,ffffffffc0200816 <dtb_init+0x16a>
ffffffffc020081e:	0000b517          	auipc	a0,0xb
ffffffffc0200822:	1c250513          	addi	a0,a0,450 # ffffffffc020b9e0 <commands+0x1a8>
ffffffffc0200826:	981ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020082a:	0000b517          	auipc	a0,0xb
ffffffffc020082e:	1ee50513          	addi	a0,a0,494 # ffffffffc020ba18 <commands+0x1e0>
ffffffffc0200832:	7446                	ld	s0,112(sp)
ffffffffc0200834:	70e6                	ld	ra,120(sp)
ffffffffc0200836:	74a6                	ld	s1,104(sp)
ffffffffc0200838:	7906                	ld	s2,96(sp)
ffffffffc020083a:	69e6                	ld	s3,88(sp)
ffffffffc020083c:	6a46                	ld	s4,80(sp)
ffffffffc020083e:	6aa6                	ld	s5,72(sp)
ffffffffc0200840:	6b06                	ld	s6,64(sp)
ffffffffc0200842:	7be2                	ld	s7,56(sp)
ffffffffc0200844:	7c42                	ld	s8,48(sp)
ffffffffc0200846:	7ca2                	ld	s9,40(sp)
ffffffffc0200848:	7d02                	ld	s10,32(sp)
ffffffffc020084a:	6de2                	ld	s11,24(sp)
ffffffffc020084c:	6109                	addi	sp,sp,128
ffffffffc020084e:	baa1                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200850:	7446                	ld	s0,112(sp)
ffffffffc0200852:	70e6                	ld	ra,120(sp)
ffffffffc0200854:	74a6                	ld	s1,104(sp)
ffffffffc0200856:	7906                	ld	s2,96(sp)
ffffffffc0200858:	69e6                	ld	s3,88(sp)
ffffffffc020085a:	6a46                	ld	s4,80(sp)
ffffffffc020085c:	6aa6                	ld	s5,72(sp)
ffffffffc020085e:	6b06                	ld	s6,64(sp)
ffffffffc0200860:	7be2                	ld	s7,56(sp)
ffffffffc0200862:	7c42                	ld	s8,48(sp)
ffffffffc0200864:	7ca2                	ld	s9,40(sp)
ffffffffc0200866:	7d02                	ld	s10,32(sp)
ffffffffc0200868:	6de2                	ld	s11,24(sp)
ffffffffc020086a:	0000b517          	auipc	a0,0xb
ffffffffc020086e:	0ce50513          	addi	a0,a0,206 # ffffffffc020b938 <commands+0x100>
ffffffffc0200872:	6109                	addi	sp,sp,128
ffffffffc0200874:	ba0d                	j	ffffffffc02001a6 <cprintf>
ffffffffc0200876:	8556                	mv	a0,s5
ffffffffc0200878:	44d0a0ef          	jal	ra,ffffffffc020b4c4 <strlen>
ffffffffc020087c:	8a2a                	mv	s4,a0
ffffffffc020087e:	4619                	li	a2,6
ffffffffc0200880:	85a6                	mv	a1,s1
ffffffffc0200882:	8556                	mv	a0,s5
ffffffffc0200884:	2a01                	sext.w	s4,s4
ffffffffc0200886:	4a50a0ef          	jal	ra,ffffffffc020b52a <strncmp>
ffffffffc020088a:	e111                	bnez	a0,ffffffffc020088e <dtb_init+0x1e2>
ffffffffc020088c:	4c85                	li	s9,1
ffffffffc020088e:	0a91                	addi	s5,s5,4
ffffffffc0200890:	9ad2                	add	s5,s5,s4
ffffffffc0200892:	ffcafa93          	andi	s5,s5,-4
ffffffffc0200896:	8a56                	mv	s4,s5
ffffffffc0200898:	bf2d                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc020089a:	004a2783          	lw	a5,4(s4)
ffffffffc020089e:	00ca0693          	addi	a3,s4,12
ffffffffc02008a2:	0087d71b          	srliw	a4,a5,0x8
ffffffffc02008a6:	01879a9b          	slliw	s5,a5,0x18
ffffffffc02008aa:	0187d61b          	srliw	a2,a5,0x18
ffffffffc02008ae:	0107171b          	slliw	a4,a4,0x10
ffffffffc02008b2:	0107d79b          	srliw	a5,a5,0x10
ffffffffc02008b6:	00caeab3          	or	s5,s5,a2
ffffffffc02008ba:	01877733          	and	a4,a4,s8
ffffffffc02008be:	0087979b          	slliw	a5,a5,0x8
ffffffffc02008c2:	00eaeab3          	or	s5,s5,a4
ffffffffc02008c6:	00fb77b3          	and	a5,s6,a5
ffffffffc02008ca:	00faeab3          	or	s5,s5,a5
ffffffffc02008ce:	2a81                	sext.w	s5,s5
ffffffffc02008d0:	000c9c63          	bnez	s9,ffffffffc02008e8 <dtb_init+0x23c>
ffffffffc02008d4:	1a82                	slli	s5,s5,0x20
ffffffffc02008d6:	00368793          	addi	a5,a3,3
ffffffffc02008da:	020ada93          	srli	s5,s5,0x20
ffffffffc02008de:	9abe                	add	s5,s5,a5
ffffffffc02008e0:	ffcafa93          	andi	s5,s5,-4
ffffffffc02008e4:	8a56                	mv	s4,s5
ffffffffc02008e6:	b5f5                	j	ffffffffc02007d2 <dtb_init+0x126>
ffffffffc02008e8:	008a2783          	lw	a5,8(s4)
ffffffffc02008ec:	85ca                	mv	a1,s2
ffffffffc02008ee:	e436                	sd	a3,8(sp)
ffffffffc02008f0:	0087d51b          	srliw	a0,a5,0x8
ffffffffc02008f4:	0187d61b          	srliw	a2,a5,0x18
ffffffffc02008f8:	0187971b          	slliw	a4,a5,0x18
ffffffffc02008fc:	0105151b          	slliw	a0,a0,0x10
ffffffffc0200900:	0107d79b          	srliw	a5,a5,0x10
ffffffffc0200904:	8f51                	or	a4,a4,a2
ffffffffc0200906:	01857533          	and	a0,a0,s8
ffffffffc020090a:	0087979b          	slliw	a5,a5,0x8
ffffffffc020090e:	8d59                	or	a0,a0,a4
ffffffffc0200910:	00fb77b3          	and	a5,s6,a5
ffffffffc0200914:	8d5d                	or	a0,a0,a5
ffffffffc0200916:	1502                	slli	a0,a0,0x20
ffffffffc0200918:	9101                	srli	a0,a0,0x20
ffffffffc020091a:	9522                	add	a0,a0,s0
ffffffffc020091c:	3f10a0ef          	jal	ra,ffffffffc020b50c <strcmp>
ffffffffc0200920:	66a2                	ld	a3,8(sp)
ffffffffc0200922:	f94d                	bnez	a0,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200924:	fb59f8e3          	bgeu	s3,s5,ffffffffc02008d4 <dtb_init+0x228>
ffffffffc0200928:	00ca3783          	ld	a5,12(s4)
ffffffffc020092c:	014a3703          	ld	a4,20(s4)
ffffffffc0200930:	0000b517          	auipc	a0,0xb
ffffffffc0200934:	04050513          	addi	a0,a0,64 # ffffffffc020b970 <commands+0x138>
ffffffffc0200938:	4207d613          	srai	a2,a5,0x20
ffffffffc020093c:	0087d31b          	srliw	t1,a5,0x8
ffffffffc0200940:	42075593          	srai	a1,a4,0x20
ffffffffc0200944:	0187de1b          	srliw	t3,a5,0x18
ffffffffc0200948:	0186581b          	srliw	a6,a2,0x18
ffffffffc020094c:	0187941b          	slliw	s0,a5,0x18
ffffffffc0200950:	0107d89b          	srliw	a7,a5,0x10
ffffffffc0200954:	0187d693          	srli	a3,a5,0x18
ffffffffc0200958:	01861f1b          	slliw	t5,a2,0x18
ffffffffc020095c:	0087579b          	srliw	a5,a4,0x8
ffffffffc0200960:	0103131b          	slliw	t1,t1,0x10
ffffffffc0200964:	0106561b          	srliw	a2,a2,0x10
ffffffffc0200968:	010f6f33          	or	t5,t5,a6
ffffffffc020096c:	0187529b          	srliw	t0,a4,0x18
ffffffffc0200970:	0185df9b          	srliw	t6,a1,0x18
ffffffffc0200974:	01837333          	and	t1,t1,s8
ffffffffc0200978:	01c46433          	or	s0,s0,t3
ffffffffc020097c:	0186f6b3          	and	a3,a3,s8
ffffffffc0200980:	01859e1b          	slliw	t3,a1,0x18
ffffffffc0200984:	01871e9b          	slliw	t4,a4,0x18
ffffffffc0200988:	0107581b          	srliw	a6,a4,0x10
ffffffffc020098c:	0086161b          	slliw	a2,a2,0x8
ffffffffc0200990:	8361                	srli	a4,a4,0x18
ffffffffc0200992:	0107979b          	slliw	a5,a5,0x10
ffffffffc0200996:	0105d59b          	srliw	a1,a1,0x10
ffffffffc020099a:	01e6e6b3          	or	a3,a3,t5
ffffffffc020099e:	00cb7633          	and	a2,s6,a2
ffffffffc02009a2:	0088181b          	slliw	a6,a6,0x8
ffffffffc02009a6:	0085959b          	slliw	a1,a1,0x8
ffffffffc02009aa:	00646433          	or	s0,s0,t1
ffffffffc02009ae:	0187f7b3          	and	a5,a5,s8
ffffffffc02009b2:	01fe6333          	or	t1,t3,t6
ffffffffc02009b6:	01877c33          	and	s8,a4,s8
ffffffffc02009ba:	0088989b          	slliw	a7,a7,0x8
ffffffffc02009be:	011b78b3          	and	a7,s6,a7
ffffffffc02009c2:	005eeeb3          	or	t4,t4,t0
ffffffffc02009c6:	00c6e733          	or	a4,a3,a2
ffffffffc02009ca:	006c6c33          	or	s8,s8,t1
ffffffffc02009ce:	010b76b3          	and	a3,s6,a6
ffffffffc02009d2:	00bb7b33          	and	s6,s6,a1
ffffffffc02009d6:	01d7e7b3          	or	a5,a5,t4
ffffffffc02009da:	016c6b33          	or	s6,s8,s6
ffffffffc02009de:	01146433          	or	s0,s0,a7
ffffffffc02009e2:	8fd5                	or	a5,a5,a3
ffffffffc02009e4:	1702                	slli	a4,a4,0x20
ffffffffc02009e6:	1b02                	slli	s6,s6,0x20
ffffffffc02009e8:	1782                	slli	a5,a5,0x20
ffffffffc02009ea:	9301                	srli	a4,a4,0x20
ffffffffc02009ec:	1402                	slli	s0,s0,0x20
ffffffffc02009ee:	020b5b13          	srli	s6,s6,0x20
ffffffffc02009f2:	0167eb33          	or	s6,a5,s6
ffffffffc02009f6:	8c59                	or	s0,s0,a4
ffffffffc02009f8:	faeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02009fc:	85a2                	mv	a1,s0
ffffffffc02009fe:	0000b517          	auipc	a0,0xb
ffffffffc0200a02:	f9250513          	addi	a0,a0,-110 # ffffffffc020b990 <commands+0x158>
ffffffffc0200a06:	fa0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a0a:	014b5613          	srli	a2,s6,0x14
ffffffffc0200a0e:	85da                	mv	a1,s6
ffffffffc0200a10:	0000b517          	auipc	a0,0xb
ffffffffc0200a14:	f9850513          	addi	a0,a0,-104 # ffffffffc020b9a8 <commands+0x170>
ffffffffc0200a18:	f8eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a1c:	008b05b3          	add	a1,s6,s0
ffffffffc0200a20:	15fd                	addi	a1,a1,-1
ffffffffc0200a22:	0000b517          	auipc	a0,0xb
ffffffffc0200a26:	fa650513          	addi	a0,a0,-90 # ffffffffc020b9c8 <commands+0x190>
ffffffffc0200a2a:	f7cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200a2e:	0000b517          	auipc	a0,0xb
ffffffffc0200a32:	fea50513          	addi	a0,a0,-22 # ffffffffc020ba18 <commands+0x1e0>
ffffffffc0200a36:	00096797          	auipc	a5,0x96
ffffffffc0200a3a:	e487b123          	sd	s0,-446(a5) # ffffffffc0296878 <memory_base>
ffffffffc0200a3e:	00096797          	auipc	a5,0x96
ffffffffc0200a42:	e567b123          	sd	s6,-446(a5) # ffffffffc0296880 <memory_size>
ffffffffc0200a46:	b3f5                	j	ffffffffc0200832 <dtb_init+0x186>

ffffffffc0200a48 <get_memory_base>:
ffffffffc0200a48:	00096517          	auipc	a0,0x96
ffffffffc0200a4c:	e3053503          	ld	a0,-464(a0) # ffffffffc0296878 <memory_base>
ffffffffc0200a50:	8082                	ret

ffffffffc0200a52 <get_memory_size>:
ffffffffc0200a52:	00096517          	auipc	a0,0x96
ffffffffc0200a56:	e2e53503          	ld	a0,-466(a0) # ffffffffc0296880 <memory_size>
ffffffffc0200a5a:	8082                	ret

ffffffffc0200a5c <ide_init>:
ffffffffc0200a5c:	1141                	addi	sp,sp,-16
ffffffffc0200a5e:	00091597          	auipc	a1,0x91
ffffffffc0200a62:	c5a58593          	addi	a1,a1,-934 # ffffffffc02916b8 <ide_devices+0x50>
ffffffffc0200a66:	4505                	li	a0,1
ffffffffc0200a68:	e022                	sd	s0,0(sp)
ffffffffc0200a6a:	00091797          	auipc	a5,0x91
ffffffffc0200a6e:	be07af23          	sw	zero,-1026(a5) # ffffffffc0291668 <ide_devices>
ffffffffc0200a72:	00091797          	auipc	a5,0x91
ffffffffc0200a76:	c407a323          	sw	zero,-954(a5) # ffffffffc02916b8 <ide_devices+0x50>
ffffffffc0200a7a:	00091797          	auipc	a5,0x91
ffffffffc0200a7e:	c807a723          	sw	zero,-882(a5) # ffffffffc0291708 <ide_devices+0xa0>
ffffffffc0200a82:	00091797          	auipc	a5,0x91
ffffffffc0200a86:	cc07ab23          	sw	zero,-810(a5) # ffffffffc0291758 <ide_devices+0xf0>
ffffffffc0200a8a:	e406                	sd	ra,8(sp)
ffffffffc0200a8c:	00091417          	auipc	s0,0x91
ffffffffc0200a90:	bdc40413          	addi	s0,s0,-1060 # ffffffffc0291668 <ide_devices>
ffffffffc0200a94:	23a000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200a98:	483c                	lw	a5,80(s0)
ffffffffc0200a9a:	cf99                	beqz	a5,ffffffffc0200ab8 <ide_init+0x5c>
ffffffffc0200a9c:	00091597          	auipc	a1,0x91
ffffffffc0200aa0:	c6c58593          	addi	a1,a1,-916 # ffffffffc0291708 <ide_devices+0xa0>
ffffffffc0200aa4:	4509                	li	a0,2
ffffffffc0200aa6:	228000ef          	jal	ra,ffffffffc0200cce <ramdisk_init>
ffffffffc0200aaa:	0a042783          	lw	a5,160(s0)
ffffffffc0200aae:	c785                	beqz	a5,ffffffffc0200ad6 <ide_init+0x7a>
ffffffffc0200ab0:	60a2                	ld	ra,8(sp)
ffffffffc0200ab2:	6402                	ld	s0,0(sp)
ffffffffc0200ab4:	0141                	addi	sp,sp,16
ffffffffc0200ab6:	8082                	ret
ffffffffc0200ab8:	0000b697          	auipc	a3,0xb
ffffffffc0200abc:	f7868693          	addi	a3,a3,-136 # ffffffffc020ba30 <commands+0x1f8>
ffffffffc0200ac0:	0000b617          	auipc	a2,0xb
ffffffffc0200ac4:	f8860613          	addi	a2,a2,-120 # ffffffffc020ba48 <commands+0x210>
ffffffffc0200ac8:	45c5                	li	a1,17
ffffffffc0200aca:	0000b517          	auipc	a0,0xb
ffffffffc0200ace:	f9650513          	addi	a0,a0,-106 # ffffffffc020ba60 <commands+0x228>
ffffffffc0200ad2:	9cdff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200ad6:	0000b697          	auipc	a3,0xb
ffffffffc0200ada:	fa268693          	addi	a3,a3,-94 # ffffffffc020ba78 <commands+0x240>
ffffffffc0200ade:	0000b617          	auipc	a2,0xb
ffffffffc0200ae2:	f6a60613          	addi	a2,a2,-150 # ffffffffc020ba48 <commands+0x210>
ffffffffc0200ae6:	45d1                	li	a1,20
ffffffffc0200ae8:	0000b517          	auipc	a0,0xb
ffffffffc0200aec:	f7850513          	addi	a0,a0,-136 # ffffffffc020ba60 <commands+0x228>
ffffffffc0200af0:	9afff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200af4 <ide_device_valid>:
ffffffffc0200af4:	478d                	li	a5,3
ffffffffc0200af6:	00a7ef63          	bltu	a5,a0,ffffffffc0200b14 <ide_device_valid+0x20>
ffffffffc0200afa:	00251793          	slli	a5,a0,0x2
ffffffffc0200afe:	953e                	add	a0,a0,a5
ffffffffc0200b00:	0512                	slli	a0,a0,0x4
ffffffffc0200b02:	00091797          	auipc	a5,0x91
ffffffffc0200b06:	b6678793          	addi	a5,a5,-1178 # ffffffffc0291668 <ide_devices>
ffffffffc0200b0a:	953e                	add	a0,a0,a5
ffffffffc0200b0c:	4108                	lw	a0,0(a0)
ffffffffc0200b0e:	00a03533          	snez	a0,a0
ffffffffc0200b12:	8082                	ret
ffffffffc0200b14:	4501                	li	a0,0
ffffffffc0200b16:	8082                	ret

ffffffffc0200b18 <ide_device_size>:
ffffffffc0200b18:	478d                	li	a5,3
ffffffffc0200b1a:	02a7e163          	bltu	a5,a0,ffffffffc0200b3c <ide_device_size+0x24>
ffffffffc0200b1e:	00251793          	slli	a5,a0,0x2
ffffffffc0200b22:	953e                	add	a0,a0,a5
ffffffffc0200b24:	0512                	slli	a0,a0,0x4
ffffffffc0200b26:	00091797          	auipc	a5,0x91
ffffffffc0200b2a:	b4278793          	addi	a5,a5,-1214 # ffffffffc0291668 <ide_devices>
ffffffffc0200b2e:	97aa                	add	a5,a5,a0
ffffffffc0200b30:	4398                	lw	a4,0(a5)
ffffffffc0200b32:	4501                	li	a0,0
ffffffffc0200b34:	c709                	beqz	a4,ffffffffc0200b3e <ide_device_size+0x26>
ffffffffc0200b36:	0087e503          	lwu	a0,8(a5)
ffffffffc0200b3a:	8082                	ret
ffffffffc0200b3c:	4501                	li	a0,0
ffffffffc0200b3e:	8082                	ret

ffffffffc0200b40 <ide_read_secs>:
ffffffffc0200b40:	1141                	addi	sp,sp,-16
ffffffffc0200b42:	e406                	sd	ra,8(sp)
ffffffffc0200b44:	08000793          	li	a5,128
ffffffffc0200b48:	04d7e763          	bltu	a5,a3,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b4c:	478d                	li	a5,3
ffffffffc0200b4e:	0005081b          	sext.w	a6,a0
ffffffffc0200b52:	04a7e263          	bltu	a5,a0,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b56:	00281793          	slli	a5,a6,0x2
ffffffffc0200b5a:	97c2                	add	a5,a5,a6
ffffffffc0200b5c:	0792                	slli	a5,a5,0x4
ffffffffc0200b5e:	00091817          	auipc	a6,0x91
ffffffffc0200b62:	b0a80813          	addi	a6,a6,-1270 # ffffffffc0291668 <ide_devices>
ffffffffc0200b66:	97c2                	add	a5,a5,a6
ffffffffc0200b68:	0007a883          	lw	a7,0(a5)
ffffffffc0200b6c:	02088563          	beqz	a7,ffffffffc0200b96 <ide_read_secs+0x56>
ffffffffc0200b70:	100008b7          	lui	a7,0x10000
ffffffffc0200b74:	0515f163          	bgeu	a1,a7,ffffffffc0200bb6 <ide_read_secs+0x76>
ffffffffc0200b78:	1582                	slli	a1,a1,0x20
ffffffffc0200b7a:	9181                	srli	a1,a1,0x20
ffffffffc0200b7c:	00d58733          	add	a4,a1,a3
ffffffffc0200b80:	02e8eb63          	bltu	a7,a4,ffffffffc0200bb6 <ide_read_secs+0x76>
ffffffffc0200b84:	00251713          	slli	a4,a0,0x2
ffffffffc0200b88:	60a2                	ld	ra,8(sp)
ffffffffc0200b8a:	63bc                	ld	a5,64(a5)
ffffffffc0200b8c:	953a                	add	a0,a0,a4
ffffffffc0200b8e:	0512                	slli	a0,a0,0x4
ffffffffc0200b90:	9542                	add	a0,a0,a6
ffffffffc0200b92:	0141                	addi	sp,sp,16
ffffffffc0200b94:	8782                	jr	a5
ffffffffc0200b96:	0000b697          	auipc	a3,0xb
ffffffffc0200b9a:	efa68693          	addi	a3,a3,-262 # ffffffffc020ba90 <commands+0x258>
ffffffffc0200b9e:	0000b617          	auipc	a2,0xb
ffffffffc0200ba2:	eaa60613          	addi	a2,a2,-342 # ffffffffc020ba48 <commands+0x210>
ffffffffc0200ba6:	02200593          	li	a1,34
ffffffffc0200baa:	0000b517          	auipc	a0,0xb
ffffffffc0200bae:	eb650513          	addi	a0,a0,-330 # ffffffffc020ba60 <commands+0x228>
ffffffffc0200bb2:	8edff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200bb6:	0000b697          	auipc	a3,0xb
ffffffffc0200bba:	f0268693          	addi	a3,a3,-254 # ffffffffc020bab8 <commands+0x280>
ffffffffc0200bbe:	0000b617          	auipc	a2,0xb
ffffffffc0200bc2:	e8a60613          	addi	a2,a2,-374 # ffffffffc020ba48 <commands+0x210>
ffffffffc0200bc6:	02300593          	li	a1,35
ffffffffc0200bca:	0000b517          	auipc	a0,0xb
ffffffffc0200bce:	e9650513          	addi	a0,a0,-362 # ffffffffc020ba60 <commands+0x228>
ffffffffc0200bd2:	8cdff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200bd6 <ide_write_secs>:
ffffffffc0200bd6:	1141                	addi	sp,sp,-16
ffffffffc0200bd8:	e406                	sd	ra,8(sp)
ffffffffc0200bda:	08000793          	li	a5,128
ffffffffc0200bde:	04d7e763          	bltu	a5,a3,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200be2:	478d                	li	a5,3
ffffffffc0200be4:	0005081b          	sext.w	a6,a0
ffffffffc0200be8:	04a7e263          	bltu	a5,a0,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200bec:	00281793          	slli	a5,a6,0x2
ffffffffc0200bf0:	97c2                	add	a5,a5,a6
ffffffffc0200bf2:	0792                	slli	a5,a5,0x4
ffffffffc0200bf4:	00091817          	auipc	a6,0x91
ffffffffc0200bf8:	a7480813          	addi	a6,a6,-1420 # ffffffffc0291668 <ide_devices>
ffffffffc0200bfc:	97c2                	add	a5,a5,a6
ffffffffc0200bfe:	0007a883          	lw	a7,0(a5)
ffffffffc0200c02:	02088563          	beqz	a7,ffffffffc0200c2c <ide_write_secs+0x56>
ffffffffc0200c06:	100008b7          	lui	a7,0x10000
ffffffffc0200c0a:	0515f163          	bgeu	a1,a7,ffffffffc0200c4c <ide_write_secs+0x76>
ffffffffc0200c0e:	1582                	slli	a1,a1,0x20
ffffffffc0200c10:	9181                	srli	a1,a1,0x20
ffffffffc0200c12:	00d58733          	add	a4,a1,a3
ffffffffc0200c16:	02e8eb63          	bltu	a7,a4,ffffffffc0200c4c <ide_write_secs+0x76>
ffffffffc0200c1a:	00251713          	slli	a4,a0,0x2
ffffffffc0200c1e:	60a2                	ld	ra,8(sp)
ffffffffc0200c20:	67bc                	ld	a5,72(a5)
ffffffffc0200c22:	953a                	add	a0,a0,a4
ffffffffc0200c24:	0512                	slli	a0,a0,0x4
ffffffffc0200c26:	9542                	add	a0,a0,a6
ffffffffc0200c28:	0141                	addi	sp,sp,16
ffffffffc0200c2a:	8782                	jr	a5
ffffffffc0200c2c:	0000b697          	auipc	a3,0xb
ffffffffc0200c30:	e6468693          	addi	a3,a3,-412 # ffffffffc020ba90 <commands+0x258>
ffffffffc0200c34:	0000b617          	auipc	a2,0xb
ffffffffc0200c38:	e1460613          	addi	a2,a2,-492 # ffffffffc020ba48 <commands+0x210>
ffffffffc0200c3c:	02900593          	li	a1,41
ffffffffc0200c40:	0000b517          	auipc	a0,0xb
ffffffffc0200c44:	e2050513          	addi	a0,a0,-480 # ffffffffc020ba60 <commands+0x228>
ffffffffc0200c48:	857ff0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0200c4c:	0000b697          	auipc	a3,0xb
ffffffffc0200c50:	e6c68693          	addi	a3,a3,-404 # ffffffffc020bab8 <commands+0x280>
ffffffffc0200c54:	0000b617          	auipc	a2,0xb
ffffffffc0200c58:	df460613          	addi	a2,a2,-524 # ffffffffc020ba48 <commands+0x210>
ffffffffc0200c5c:	02a00593          	li	a1,42
ffffffffc0200c60:	0000b517          	auipc	a0,0xb
ffffffffc0200c64:	e0050513          	addi	a0,a0,-512 # ffffffffc020ba60 <commands+0x228>
ffffffffc0200c68:	837ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200c6c <intr_enable>:
ffffffffc0200c6c:	100167f3          	csrrsi	a5,sstatus,2
ffffffffc0200c70:	8082                	ret

ffffffffc0200c72 <intr_disable>:
ffffffffc0200c72:	100177f3          	csrrci	a5,sstatus,2
ffffffffc0200c76:	8082                	ret

ffffffffc0200c78 <pic_init>:
ffffffffc0200c78:	8082                	ret

ffffffffc0200c7a <ramdisk_write>:
ffffffffc0200c7a:	00856703          	lwu	a4,8(a0)
ffffffffc0200c7e:	1141                	addi	sp,sp,-16
ffffffffc0200c80:	e406                	sd	ra,8(sp)
ffffffffc0200c82:	8f0d                	sub	a4,a4,a1
ffffffffc0200c84:	87ae                	mv	a5,a1
ffffffffc0200c86:	85b2                	mv	a1,a2
ffffffffc0200c88:	00e6f363          	bgeu	a3,a4,ffffffffc0200c8e <ramdisk_write+0x14>
ffffffffc0200c8c:	8736                	mv	a4,a3
ffffffffc0200c8e:	6908                	ld	a0,16(a0)
ffffffffc0200c90:	07a6                	slli	a5,a5,0x9
ffffffffc0200c92:	00971613          	slli	a2,a4,0x9
ffffffffc0200c96:	953e                	add	a0,a0,a5
ffffffffc0200c98:	1210a0ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc0200c9c:	60a2                	ld	ra,8(sp)
ffffffffc0200c9e:	4501                	li	a0,0
ffffffffc0200ca0:	0141                	addi	sp,sp,16
ffffffffc0200ca2:	8082                	ret

ffffffffc0200ca4 <ramdisk_read>:
ffffffffc0200ca4:	00856783          	lwu	a5,8(a0)
ffffffffc0200ca8:	1141                	addi	sp,sp,-16
ffffffffc0200caa:	e406                	sd	ra,8(sp)
ffffffffc0200cac:	8f8d                	sub	a5,a5,a1
ffffffffc0200cae:	872a                	mv	a4,a0
ffffffffc0200cb0:	8532                	mv	a0,a2
ffffffffc0200cb2:	00f6f363          	bgeu	a3,a5,ffffffffc0200cb8 <ramdisk_read+0x14>
ffffffffc0200cb6:	87b6                	mv	a5,a3
ffffffffc0200cb8:	6b18                	ld	a4,16(a4)
ffffffffc0200cba:	05a6                	slli	a1,a1,0x9
ffffffffc0200cbc:	00979613          	slli	a2,a5,0x9
ffffffffc0200cc0:	95ba                	add	a1,a1,a4
ffffffffc0200cc2:	0f70a0ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc0200cc6:	60a2                	ld	ra,8(sp)
ffffffffc0200cc8:	4501                	li	a0,0
ffffffffc0200cca:	0141                	addi	sp,sp,16
ffffffffc0200ccc:	8082                	ret

ffffffffc0200cce <ramdisk_init>:
ffffffffc0200cce:	1101                	addi	sp,sp,-32
ffffffffc0200cd0:	e822                	sd	s0,16(sp)
ffffffffc0200cd2:	842e                	mv	s0,a1
ffffffffc0200cd4:	e426                	sd	s1,8(sp)
ffffffffc0200cd6:	05000613          	li	a2,80
ffffffffc0200cda:	84aa                	mv	s1,a0
ffffffffc0200cdc:	4581                	li	a1,0
ffffffffc0200cde:	8522                	mv	a0,s0
ffffffffc0200ce0:	ec06                	sd	ra,24(sp)
ffffffffc0200ce2:	e04a                	sd	s2,0(sp)
ffffffffc0200ce4:	0830a0ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc0200ce8:	4785                	li	a5,1
ffffffffc0200cea:	06f48b63          	beq	s1,a5,ffffffffc0200d60 <ramdisk_init+0x92>
ffffffffc0200cee:	4789                	li	a5,2
ffffffffc0200cf0:	00090617          	auipc	a2,0x90
ffffffffc0200cf4:	32060613          	addi	a2,a2,800 # ffffffffc0291010 <arena>
ffffffffc0200cf8:	0001b917          	auipc	s2,0x1b
ffffffffc0200cfc:	01890913          	addi	s2,s2,24 # ffffffffc021bd10 <_binary_bin_sfs_img_start>
ffffffffc0200d00:	08f49563          	bne	s1,a5,ffffffffc0200d8a <ramdisk_init+0xbc>
ffffffffc0200d04:	06c90863          	beq	s2,a2,ffffffffc0200d74 <ramdisk_init+0xa6>
ffffffffc0200d08:	412604b3          	sub	s1,a2,s2
ffffffffc0200d0c:	86a6                	mv	a3,s1
ffffffffc0200d0e:	85ca                	mv	a1,s2
ffffffffc0200d10:	167d                	addi	a2,a2,-1
ffffffffc0200d12:	0000b517          	auipc	a0,0xb
ffffffffc0200d16:	dfe50513          	addi	a0,a0,-514 # ffffffffc020bb10 <commands+0x2d8>
ffffffffc0200d1a:	c8cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200d1e:	57fd                	li	a5,-1
ffffffffc0200d20:	1782                	slli	a5,a5,0x20
ffffffffc0200d22:	0785                	addi	a5,a5,1
ffffffffc0200d24:	0094d49b          	srliw	s1,s1,0x9
ffffffffc0200d28:	e01c                	sd	a5,0(s0)
ffffffffc0200d2a:	c404                	sw	s1,8(s0)
ffffffffc0200d2c:	01243823          	sd	s2,16(s0)
ffffffffc0200d30:	02040513          	addi	a0,s0,32
ffffffffc0200d34:	0000b597          	auipc	a1,0xb
ffffffffc0200d38:	e3458593          	addi	a1,a1,-460 # ffffffffc020bb68 <commands+0x330>
ffffffffc0200d3c:	7be0a0ef          	jal	ra,ffffffffc020b4fa <strcpy>
ffffffffc0200d40:	00000797          	auipc	a5,0x0
ffffffffc0200d44:	f6478793          	addi	a5,a5,-156 # ffffffffc0200ca4 <ramdisk_read>
ffffffffc0200d48:	e03c                	sd	a5,64(s0)
ffffffffc0200d4a:	00000797          	auipc	a5,0x0
ffffffffc0200d4e:	f3078793          	addi	a5,a5,-208 # ffffffffc0200c7a <ramdisk_write>
ffffffffc0200d52:	60e2                	ld	ra,24(sp)
ffffffffc0200d54:	e43c                	sd	a5,72(s0)
ffffffffc0200d56:	6442                	ld	s0,16(sp)
ffffffffc0200d58:	64a2                	ld	s1,8(sp)
ffffffffc0200d5a:	6902                	ld	s2,0(sp)
ffffffffc0200d5c:	6105                	addi	sp,sp,32
ffffffffc0200d5e:	8082                	ret
ffffffffc0200d60:	0001b617          	auipc	a2,0x1b
ffffffffc0200d64:	fb060613          	addi	a2,a2,-80 # ffffffffc021bd10 <_binary_bin_sfs_img_start>
ffffffffc0200d68:	00013917          	auipc	s2,0x13
ffffffffc0200d6c:	2a890913          	addi	s2,s2,680 # ffffffffc0214010 <_binary_bin_swap_img_start>
ffffffffc0200d70:	f8c91ce3          	bne	s2,a2,ffffffffc0200d08 <ramdisk_init+0x3a>
ffffffffc0200d74:	6442                	ld	s0,16(sp)
ffffffffc0200d76:	60e2                	ld	ra,24(sp)
ffffffffc0200d78:	64a2                	ld	s1,8(sp)
ffffffffc0200d7a:	6902                	ld	s2,0(sp)
ffffffffc0200d7c:	0000b517          	auipc	a0,0xb
ffffffffc0200d80:	d7c50513          	addi	a0,a0,-644 # ffffffffc020baf8 <commands+0x2c0>
ffffffffc0200d84:	6105                	addi	sp,sp,32
ffffffffc0200d86:	c20ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0200d8a:	0000b617          	auipc	a2,0xb
ffffffffc0200d8e:	dae60613          	addi	a2,a2,-594 # ffffffffc020bb38 <commands+0x300>
ffffffffc0200d92:	03200593          	li	a1,50
ffffffffc0200d96:	0000b517          	auipc	a0,0xb
ffffffffc0200d9a:	dba50513          	addi	a0,a0,-582 # ffffffffc020bb50 <commands+0x318>
ffffffffc0200d9e:	f00ff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0200da2 <idt_init>:
ffffffffc0200da2:	14005073          	csrwi	sscratch,0
ffffffffc0200da6:	00000797          	auipc	a5,0x0
ffffffffc0200daa:	43a78793          	addi	a5,a5,1082 # ffffffffc02011e0 <__alltraps>
ffffffffc0200dae:	10579073          	csrw	stvec,a5
ffffffffc0200db2:	000407b7          	lui	a5,0x40
ffffffffc0200db6:	1007a7f3          	csrrs	a5,sstatus,a5
ffffffffc0200dba:	8082                	ret

ffffffffc0200dbc <print_regs>:
ffffffffc0200dbc:	610c                	ld	a1,0(a0)
ffffffffc0200dbe:	1141                	addi	sp,sp,-16
ffffffffc0200dc0:	e022                	sd	s0,0(sp)
ffffffffc0200dc2:	842a                	mv	s0,a0
ffffffffc0200dc4:	0000b517          	auipc	a0,0xb
ffffffffc0200dc8:	db450513          	addi	a0,a0,-588 # ffffffffc020bb78 <commands+0x340>
ffffffffc0200dcc:	e406                	sd	ra,8(sp)
ffffffffc0200dce:	bd8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dd2:	640c                	ld	a1,8(s0)
ffffffffc0200dd4:	0000b517          	auipc	a0,0xb
ffffffffc0200dd8:	dbc50513          	addi	a0,a0,-580 # ffffffffc020bb90 <commands+0x358>
ffffffffc0200ddc:	bcaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200de0:	680c                	ld	a1,16(s0)
ffffffffc0200de2:	0000b517          	auipc	a0,0xb
ffffffffc0200de6:	dc650513          	addi	a0,a0,-570 # ffffffffc020bba8 <commands+0x370>
ffffffffc0200dea:	bbcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dee:	6c0c                	ld	a1,24(s0)
ffffffffc0200df0:	0000b517          	auipc	a0,0xb
ffffffffc0200df4:	dd050513          	addi	a0,a0,-560 # ffffffffc020bbc0 <commands+0x388>
ffffffffc0200df8:	baeff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200dfc:	700c                	ld	a1,32(s0)
ffffffffc0200dfe:	0000b517          	auipc	a0,0xb
ffffffffc0200e02:	dda50513          	addi	a0,a0,-550 # ffffffffc020bbd8 <commands+0x3a0>
ffffffffc0200e06:	ba0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e0a:	740c                	ld	a1,40(s0)
ffffffffc0200e0c:	0000b517          	auipc	a0,0xb
ffffffffc0200e10:	de450513          	addi	a0,a0,-540 # ffffffffc020bbf0 <commands+0x3b8>
ffffffffc0200e14:	b92ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e18:	780c                	ld	a1,48(s0)
ffffffffc0200e1a:	0000b517          	auipc	a0,0xb
ffffffffc0200e1e:	dee50513          	addi	a0,a0,-530 # ffffffffc020bc08 <commands+0x3d0>
ffffffffc0200e22:	b84ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e26:	7c0c                	ld	a1,56(s0)
ffffffffc0200e28:	0000b517          	auipc	a0,0xb
ffffffffc0200e2c:	df850513          	addi	a0,a0,-520 # ffffffffc020bc20 <commands+0x3e8>
ffffffffc0200e30:	b76ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e34:	602c                	ld	a1,64(s0)
ffffffffc0200e36:	0000b517          	auipc	a0,0xb
ffffffffc0200e3a:	e0250513          	addi	a0,a0,-510 # ffffffffc020bc38 <commands+0x400>
ffffffffc0200e3e:	b68ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e42:	642c                	ld	a1,72(s0)
ffffffffc0200e44:	0000b517          	auipc	a0,0xb
ffffffffc0200e48:	e0c50513          	addi	a0,a0,-500 # ffffffffc020bc50 <commands+0x418>
ffffffffc0200e4c:	b5aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e50:	682c                	ld	a1,80(s0)
ffffffffc0200e52:	0000b517          	auipc	a0,0xb
ffffffffc0200e56:	e1650513          	addi	a0,a0,-490 # ffffffffc020bc68 <commands+0x430>
ffffffffc0200e5a:	b4cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e5e:	6c2c                	ld	a1,88(s0)
ffffffffc0200e60:	0000b517          	auipc	a0,0xb
ffffffffc0200e64:	e2050513          	addi	a0,a0,-480 # ffffffffc020bc80 <commands+0x448>
ffffffffc0200e68:	b3eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e6c:	702c                	ld	a1,96(s0)
ffffffffc0200e6e:	0000b517          	auipc	a0,0xb
ffffffffc0200e72:	e2a50513          	addi	a0,a0,-470 # ffffffffc020bc98 <commands+0x460>
ffffffffc0200e76:	b30ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e7a:	742c                	ld	a1,104(s0)
ffffffffc0200e7c:	0000b517          	auipc	a0,0xb
ffffffffc0200e80:	e3450513          	addi	a0,a0,-460 # ffffffffc020bcb0 <commands+0x478>
ffffffffc0200e84:	b22ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e88:	782c                	ld	a1,112(s0)
ffffffffc0200e8a:	0000b517          	auipc	a0,0xb
ffffffffc0200e8e:	e3e50513          	addi	a0,a0,-450 # ffffffffc020bcc8 <commands+0x490>
ffffffffc0200e92:	b14ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200e96:	7c2c                	ld	a1,120(s0)
ffffffffc0200e98:	0000b517          	auipc	a0,0xb
ffffffffc0200e9c:	e4850513          	addi	a0,a0,-440 # ffffffffc020bce0 <commands+0x4a8>
ffffffffc0200ea0:	b06ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ea4:	604c                	ld	a1,128(s0)
ffffffffc0200ea6:	0000b517          	auipc	a0,0xb
ffffffffc0200eaa:	e5250513          	addi	a0,a0,-430 # ffffffffc020bcf8 <commands+0x4c0>
ffffffffc0200eae:	af8ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eb2:	644c                	ld	a1,136(s0)
ffffffffc0200eb4:	0000b517          	auipc	a0,0xb
ffffffffc0200eb8:	e5c50513          	addi	a0,a0,-420 # ffffffffc020bd10 <commands+0x4d8>
ffffffffc0200ebc:	aeaff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ec0:	684c                	ld	a1,144(s0)
ffffffffc0200ec2:	0000b517          	auipc	a0,0xb
ffffffffc0200ec6:	e6650513          	addi	a0,a0,-410 # ffffffffc020bd28 <commands+0x4f0>
ffffffffc0200eca:	adcff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ece:	6c4c                	ld	a1,152(s0)
ffffffffc0200ed0:	0000b517          	auipc	a0,0xb
ffffffffc0200ed4:	e7050513          	addi	a0,a0,-400 # ffffffffc020bd40 <commands+0x508>
ffffffffc0200ed8:	aceff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200edc:	704c                	ld	a1,160(s0)
ffffffffc0200ede:	0000b517          	auipc	a0,0xb
ffffffffc0200ee2:	e7a50513          	addi	a0,a0,-390 # ffffffffc020bd58 <commands+0x520>
ffffffffc0200ee6:	ac0ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200eea:	744c                	ld	a1,168(s0)
ffffffffc0200eec:	0000b517          	auipc	a0,0xb
ffffffffc0200ef0:	e8450513          	addi	a0,a0,-380 # ffffffffc020bd70 <commands+0x538>
ffffffffc0200ef4:	ab2ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200ef8:	784c                	ld	a1,176(s0)
ffffffffc0200efa:	0000b517          	auipc	a0,0xb
ffffffffc0200efe:	e8e50513          	addi	a0,a0,-370 # ffffffffc020bd88 <commands+0x550>
ffffffffc0200f02:	aa4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f06:	7c4c                	ld	a1,184(s0)
ffffffffc0200f08:	0000b517          	auipc	a0,0xb
ffffffffc0200f0c:	e9850513          	addi	a0,a0,-360 # ffffffffc020bda0 <commands+0x568>
ffffffffc0200f10:	a96ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f14:	606c                	ld	a1,192(s0)
ffffffffc0200f16:	0000b517          	auipc	a0,0xb
ffffffffc0200f1a:	ea250513          	addi	a0,a0,-350 # ffffffffc020bdb8 <commands+0x580>
ffffffffc0200f1e:	a88ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f22:	646c                	ld	a1,200(s0)
ffffffffc0200f24:	0000b517          	auipc	a0,0xb
ffffffffc0200f28:	eac50513          	addi	a0,a0,-340 # ffffffffc020bdd0 <commands+0x598>
ffffffffc0200f2c:	a7aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f30:	686c                	ld	a1,208(s0)
ffffffffc0200f32:	0000b517          	auipc	a0,0xb
ffffffffc0200f36:	eb650513          	addi	a0,a0,-330 # ffffffffc020bde8 <commands+0x5b0>
ffffffffc0200f3a:	a6cff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f3e:	6c6c                	ld	a1,216(s0)
ffffffffc0200f40:	0000b517          	auipc	a0,0xb
ffffffffc0200f44:	ec050513          	addi	a0,a0,-320 # ffffffffc020be00 <commands+0x5c8>
ffffffffc0200f48:	a5eff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f4c:	706c                	ld	a1,224(s0)
ffffffffc0200f4e:	0000b517          	auipc	a0,0xb
ffffffffc0200f52:	eca50513          	addi	a0,a0,-310 # ffffffffc020be18 <commands+0x5e0>
ffffffffc0200f56:	a50ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f5a:	746c                	ld	a1,232(s0)
ffffffffc0200f5c:	0000b517          	auipc	a0,0xb
ffffffffc0200f60:	ed450513          	addi	a0,a0,-300 # ffffffffc020be30 <commands+0x5f8>
ffffffffc0200f64:	a42ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f68:	786c                	ld	a1,240(s0)
ffffffffc0200f6a:	0000b517          	auipc	a0,0xb
ffffffffc0200f6e:	ede50513          	addi	a0,a0,-290 # ffffffffc020be48 <commands+0x610>
ffffffffc0200f72:	a34ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200f76:	7c6c                	ld	a1,248(s0)
ffffffffc0200f78:	6402                	ld	s0,0(sp)
ffffffffc0200f7a:	60a2                	ld	ra,8(sp)
ffffffffc0200f7c:	0000b517          	auipc	a0,0xb
ffffffffc0200f80:	ee450513          	addi	a0,a0,-284 # ffffffffc020be60 <commands+0x628>
ffffffffc0200f84:	0141                	addi	sp,sp,16
ffffffffc0200f86:	a20ff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200f8a <print_trapframe>:
ffffffffc0200f8a:	1141                	addi	sp,sp,-16
ffffffffc0200f8c:	e022                	sd	s0,0(sp)
ffffffffc0200f8e:	85aa                	mv	a1,a0
ffffffffc0200f90:	842a                	mv	s0,a0
ffffffffc0200f92:	0000b517          	auipc	a0,0xb
ffffffffc0200f96:	ee650513          	addi	a0,a0,-282 # ffffffffc020be78 <commands+0x640>
ffffffffc0200f9a:	e406                	sd	ra,8(sp)
ffffffffc0200f9c:	a0aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fa0:	8522                	mv	a0,s0
ffffffffc0200fa2:	e1bff0ef          	jal	ra,ffffffffc0200dbc <print_regs>
ffffffffc0200fa6:	10043583          	ld	a1,256(s0)
ffffffffc0200faa:	0000b517          	auipc	a0,0xb
ffffffffc0200fae:	ee650513          	addi	a0,a0,-282 # ffffffffc020be90 <commands+0x658>
ffffffffc0200fb2:	9f4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fb6:	10843583          	ld	a1,264(s0)
ffffffffc0200fba:	0000b517          	auipc	a0,0xb
ffffffffc0200fbe:	eee50513          	addi	a0,a0,-274 # ffffffffc020bea8 <commands+0x670>
ffffffffc0200fc2:	9e4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fc6:	11043583          	ld	a1,272(s0)
ffffffffc0200fca:	0000b517          	auipc	a0,0xb
ffffffffc0200fce:	ef650513          	addi	a0,a0,-266 # ffffffffc020bec0 <commands+0x688>
ffffffffc0200fd2:	9d4ff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0200fd6:	11843583          	ld	a1,280(s0)
ffffffffc0200fda:	6402                	ld	s0,0(sp)
ffffffffc0200fdc:	60a2                	ld	ra,8(sp)
ffffffffc0200fde:	0000b517          	auipc	a0,0xb
ffffffffc0200fe2:	ef250513          	addi	a0,a0,-270 # ffffffffc020bed0 <commands+0x698>
ffffffffc0200fe6:	0141                	addi	sp,sp,16
ffffffffc0200fe8:	9beff06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0200fec <interrupt_handler>:
ffffffffc0200fec:	11853783          	ld	a5,280(a0)
ffffffffc0200ff0:	472d                	li	a4,11
ffffffffc0200ff2:	0786                	slli	a5,a5,0x1
ffffffffc0200ff4:	8385                	srli	a5,a5,0x1
ffffffffc0200ff6:	06f76c63          	bltu	a4,a5,ffffffffc020106e <interrupt_handler+0x82>
ffffffffc0200ffa:	0000b717          	auipc	a4,0xb
ffffffffc0200ffe:	f8e70713          	addi	a4,a4,-114 # ffffffffc020bf88 <commands+0x750>
ffffffffc0201002:	078a                	slli	a5,a5,0x2
ffffffffc0201004:	97ba                	add	a5,a5,a4
ffffffffc0201006:	439c                	lw	a5,0(a5)
ffffffffc0201008:	97ba                	add	a5,a5,a4
ffffffffc020100a:	8782                	jr	a5
ffffffffc020100c:	0000b517          	auipc	a0,0xb
ffffffffc0201010:	f3c50513          	addi	a0,a0,-196 # ffffffffc020bf48 <commands+0x710>
ffffffffc0201014:	992ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201018:	0000b517          	auipc	a0,0xb
ffffffffc020101c:	f1050513          	addi	a0,a0,-240 # ffffffffc020bf28 <commands+0x6f0>
ffffffffc0201020:	986ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201024:	0000b517          	auipc	a0,0xb
ffffffffc0201028:	ec450513          	addi	a0,a0,-316 # ffffffffc020bee8 <commands+0x6b0>
ffffffffc020102c:	97aff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0201030:	0000b517          	auipc	a0,0xb
ffffffffc0201034:	ed850513          	addi	a0,a0,-296 # ffffffffc020bf08 <commands+0x6d0>
ffffffffc0201038:	96eff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc020103c:	1141                	addi	sp,sp,-16
ffffffffc020103e:	e406                	sd	ra,8(sp)
ffffffffc0201040:	d3aff0ef          	jal	ra,ffffffffc020057a <clock_set_next_event>
ffffffffc0201044:	00096717          	auipc	a4,0x96
ffffffffc0201048:	82c70713          	addi	a4,a4,-2004 # ffffffffc0296870 <ticks>
ffffffffc020104c:	631c                	ld	a5,0(a4)
ffffffffc020104e:	0785                	addi	a5,a5,1
ffffffffc0201050:	e31c                	sd	a5,0(a4)
ffffffffc0201052:	59c060ef          	jal	ra,ffffffffc02075ee <run_timer_list>
ffffffffc0201056:	d9eff0ef          	jal	ra,ffffffffc02005f4 <cons_getc>
ffffffffc020105a:	60a2                	ld	ra,8(sp)
ffffffffc020105c:	0141                	addi	sp,sp,16
ffffffffc020105e:	4610706f          	j	ffffffffc0208cbe <dev_stdin_write>
ffffffffc0201062:	0000b517          	auipc	a0,0xb
ffffffffc0201066:	f0650513          	addi	a0,a0,-250 # ffffffffc020bf68 <commands+0x730>
ffffffffc020106a:	93cff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc020106e:	bf31                	j	ffffffffc0200f8a <print_trapframe>

ffffffffc0201070 <exception_handler>:
ffffffffc0201070:	11853783          	ld	a5,280(a0)
ffffffffc0201074:	1141                	addi	sp,sp,-16
ffffffffc0201076:	e022                	sd	s0,0(sp)
ffffffffc0201078:	e406                	sd	ra,8(sp)
ffffffffc020107a:	473d                	li	a4,15
ffffffffc020107c:	842a                	mv	s0,a0
ffffffffc020107e:	0af76b63          	bltu	a4,a5,ffffffffc0201134 <exception_handler+0xc4>
ffffffffc0201082:	0000b717          	auipc	a4,0xb
ffffffffc0201086:	0c670713          	addi	a4,a4,198 # ffffffffc020c148 <commands+0x910>
ffffffffc020108a:	078a                	slli	a5,a5,0x2
ffffffffc020108c:	97ba                	add	a5,a5,a4
ffffffffc020108e:	439c                	lw	a5,0(a5)
ffffffffc0201090:	97ba                	add	a5,a5,a4
ffffffffc0201092:	8782                	jr	a5
ffffffffc0201094:	0000b517          	auipc	a0,0xb
ffffffffc0201098:	00c50513          	addi	a0,a0,12 # ffffffffc020c0a0 <commands+0x868>
ffffffffc020109c:	90aff0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02010a0:	10843783          	ld	a5,264(s0)
ffffffffc02010a4:	60a2                	ld	ra,8(sp)
ffffffffc02010a6:	0791                	addi	a5,a5,4
ffffffffc02010a8:	10f43423          	sd	a5,264(s0)
ffffffffc02010ac:	6402                	ld	s0,0(sp)
ffffffffc02010ae:	0141                	addi	sp,sp,16
ffffffffc02010b0:	7540606f          	j	ffffffffc0207804 <syscall>
ffffffffc02010b4:	0000b517          	auipc	a0,0xb
ffffffffc02010b8:	00c50513          	addi	a0,a0,12 # ffffffffc020c0c0 <commands+0x888>
ffffffffc02010bc:	6402                	ld	s0,0(sp)
ffffffffc02010be:	60a2                	ld	ra,8(sp)
ffffffffc02010c0:	0141                	addi	sp,sp,16
ffffffffc02010c2:	8e4ff06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc02010c6:	0000b517          	auipc	a0,0xb
ffffffffc02010ca:	01a50513          	addi	a0,a0,26 # ffffffffc020c0e0 <commands+0x8a8>
ffffffffc02010ce:	b7fd                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010d0:	0000b517          	auipc	a0,0xb
ffffffffc02010d4:	03050513          	addi	a0,a0,48 # ffffffffc020c100 <commands+0x8c8>
ffffffffc02010d8:	b7d5                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010da:	0000b517          	auipc	a0,0xb
ffffffffc02010de:	03e50513          	addi	a0,a0,62 # ffffffffc020c118 <commands+0x8e0>
ffffffffc02010e2:	bfe9                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010e4:	0000b517          	auipc	a0,0xb
ffffffffc02010e8:	04c50513          	addi	a0,a0,76 # ffffffffc020c130 <commands+0x8f8>
ffffffffc02010ec:	bfc1                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010ee:	0000b517          	auipc	a0,0xb
ffffffffc02010f2:	eca50513          	addi	a0,a0,-310 # ffffffffc020bfb8 <commands+0x780>
ffffffffc02010f6:	b7d9                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc02010f8:	0000b517          	auipc	a0,0xb
ffffffffc02010fc:	ee050513          	addi	a0,a0,-288 # ffffffffc020bfd8 <commands+0x7a0>
ffffffffc0201100:	bf75                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201102:	0000b517          	auipc	a0,0xb
ffffffffc0201106:	ef650513          	addi	a0,a0,-266 # ffffffffc020bff8 <commands+0x7c0>
ffffffffc020110a:	bf4d                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc020110c:	0000b517          	auipc	a0,0xb
ffffffffc0201110:	f0450513          	addi	a0,a0,-252 # ffffffffc020c010 <commands+0x7d8>
ffffffffc0201114:	b765                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201116:	0000b517          	auipc	a0,0xb
ffffffffc020111a:	f0a50513          	addi	a0,a0,-246 # ffffffffc020c020 <commands+0x7e8>
ffffffffc020111e:	bf79                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201120:	0000b517          	auipc	a0,0xb
ffffffffc0201124:	f2050513          	addi	a0,a0,-224 # ffffffffc020c040 <commands+0x808>
ffffffffc0201128:	bf51                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc020112a:	0000b517          	auipc	a0,0xb
ffffffffc020112e:	f5e50513          	addi	a0,a0,-162 # ffffffffc020c088 <commands+0x850>
ffffffffc0201132:	b769                	j	ffffffffc02010bc <exception_handler+0x4c>
ffffffffc0201134:	8522                	mv	a0,s0
ffffffffc0201136:	6402                	ld	s0,0(sp)
ffffffffc0201138:	60a2                	ld	ra,8(sp)
ffffffffc020113a:	0141                	addi	sp,sp,16
ffffffffc020113c:	b5b9                	j	ffffffffc0200f8a <print_trapframe>
ffffffffc020113e:	0000b617          	auipc	a2,0xb
ffffffffc0201142:	f1a60613          	addi	a2,a2,-230 # ffffffffc020c058 <commands+0x820>
ffffffffc0201146:	0b100593          	li	a1,177
ffffffffc020114a:	0000b517          	auipc	a0,0xb
ffffffffc020114e:	f2650513          	addi	a0,a0,-218 # ffffffffc020c070 <commands+0x838>
ffffffffc0201152:	b4cff0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201156 <trap>:
ffffffffc0201156:	1101                	addi	sp,sp,-32
ffffffffc0201158:	e822                	sd	s0,16(sp)
ffffffffc020115a:	00095417          	auipc	s0,0x95
ffffffffc020115e:	76640413          	addi	s0,s0,1894 # ffffffffc02968c0 <current>
ffffffffc0201162:	6018                	ld	a4,0(s0)
ffffffffc0201164:	ec06                	sd	ra,24(sp)
ffffffffc0201166:	e426                	sd	s1,8(sp)
ffffffffc0201168:	e04a                	sd	s2,0(sp)
ffffffffc020116a:	11853683          	ld	a3,280(a0)
ffffffffc020116e:	cf1d                	beqz	a4,ffffffffc02011ac <trap+0x56>
ffffffffc0201170:	10053483          	ld	s1,256(a0)
ffffffffc0201174:	0a073903          	ld	s2,160(a4)
ffffffffc0201178:	f348                	sd	a0,160(a4)
ffffffffc020117a:	1004f493          	andi	s1,s1,256
ffffffffc020117e:	0206c463          	bltz	a3,ffffffffc02011a6 <trap+0x50>
ffffffffc0201182:	eefff0ef          	jal	ra,ffffffffc0201070 <exception_handler>
ffffffffc0201186:	601c                	ld	a5,0(s0)
ffffffffc0201188:	0b27b023          	sd	s2,160(a5) # 400a0 <_binary_bin_swap_img_size+0x383a0>
ffffffffc020118c:	e499                	bnez	s1,ffffffffc020119a <trap+0x44>
ffffffffc020118e:	0b07a703          	lw	a4,176(a5)
ffffffffc0201192:	8b05                	andi	a4,a4,1
ffffffffc0201194:	e329                	bnez	a4,ffffffffc02011d6 <trap+0x80>
ffffffffc0201196:	6f9c                	ld	a5,24(a5)
ffffffffc0201198:	eb85                	bnez	a5,ffffffffc02011c8 <trap+0x72>
ffffffffc020119a:	60e2                	ld	ra,24(sp)
ffffffffc020119c:	6442                	ld	s0,16(sp)
ffffffffc020119e:	64a2                	ld	s1,8(sp)
ffffffffc02011a0:	6902                	ld	s2,0(sp)
ffffffffc02011a2:	6105                	addi	sp,sp,32
ffffffffc02011a4:	8082                	ret
ffffffffc02011a6:	e47ff0ef          	jal	ra,ffffffffc0200fec <interrupt_handler>
ffffffffc02011aa:	bff1                	j	ffffffffc0201186 <trap+0x30>
ffffffffc02011ac:	0006c863          	bltz	a3,ffffffffc02011bc <trap+0x66>
ffffffffc02011b0:	6442                	ld	s0,16(sp)
ffffffffc02011b2:	60e2                	ld	ra,24(sp)
ffffffffc02011b4:	64a2                	ld	s1,8(sp)
ffffffffc02011b6:	6902                	ld	s2,0(sp)
ffffffffc02011b8:	6105                	addi	sp,sp,32
ffffffffc02011ba:	bd5d                	j	ffffffffc0201070 <exception_handler>
ffffffffc02011bc:	6442                	ld	s0,16(sp)
ffffffffc02011be:	60e2                	ld	ra,24(sp)
ffffffffc02011c0:	64a2                	ld	s1,8(sp)
ffffffffc02011c2:	6902                	ld	s2,0(sp)
ffffffffc02011c4:	6105                	addi	sp,sp,32
ffffffffc02011c6:	b51d                	j	ffffffffc0200fec <interrupt_handler>
ffffffffc02011c8:	6442                	ld	s0,16(sp)
ffffffffc02011ca:	60e2                	ld	ra,24(sp)
ffffffffc02011cc:	64a2                	ld	s1,8(sp)
ffffffffc02011ce:	6902                	ld	s2,0(sp)
ffffffffc02011d0:	6105                	addi	sp,sp,32
ffffffffc02011d2:	2100606f          	j	ffffffffc02073e2 <schedule>
ffffffffc02011d6:	555d                	li	a0,-9
ffffffffc02011d8:	625040ef          	jal	ra,ffffffffc0205ffc <do_exit>
ffffffffc02011dc:	601c                	ld	a5,0(s0)
ffffffffc02011de:	bf65                	j	ffffffffc0201196 <trap+0x40>

ffffffffc02011e0 <__alltraps>:
ffffffffc02011e0:	14011173          	csrrw	sp,sscratch,sp
ffffffffc02011e4:	00011463          	bnez	sp,ffffffffc02011ec <__alltraps+0xc>
ffffffffc02011e8:	14002173          	csrr	sp,sscratch
ffffffffc02011ec:	712d                	addi	sp,sp,-288
ffffffffc02011ee:	e002                	sd	zero,0(sp)
ffffffffc02011f0:	e406                	sd	ra,8(sp)
ffffffffc02011f2:	ec0e                	sd	gp,24(sp)
ffffffffc02011f4:	f012                	sd	tp,32(sp)
ffffffffc02011f6:	f416                	sd	t0,40(sp)
ffffffffc02011f8:	f81a                	sd	t1,48(sp)
ffffffffc02011fa:	fc1e                	sd	t2,56(sp)
ffffffffc02011fc:	e0a2                	sd	s0,64(sp)
ffffffffc02011fe:	e4a6                	sd	s1,72(sp)
ffffffffc0201200:	e8aa                	sd	a0,80(sp)
ffffffffc0201202:	ecae                	sd	a1,88(sp)
ffffffffc0201204:	f0b2                	sd	a2,96(sp)
ffffffffc0201206:	f4b6                	sd	a3,104(sp)
ffffffffc0201208:	f8ba                	sd	a4,112(sp)
ffffffffc020120a:	fcbe                	sd	a5,120(sp)
ffffffffc020120c:	e142                	sd	a6,128(sp)
ffffffffc020120e:	e546                	sd	a7,136(sp)
ffffffffc0201210:	e94a                	sd	s2,144(sp)
ffffffffc0201212:	ed4e                	sd	s3,152(sp)
ffffffffc0201214:	f152                	sd	s4,160(sp)
ffffffffc0201216:	f556                	sd	s5,168(sp)
ffffffffc0201218:	f95a                	sd	s6,176(sp)
ffffffffc020121a:	fd5e                	sd	s7,184(sp)
ffffffffc020121c:	e1e2                	sd	s8,192(sp)
ffffffffc020121e:	e5e6                	sd	s9,200(sp)
ffffffffc0201220:	e9ea                	sd	s10,208(sp)
ffffffffc0201222:	edee                	sd	s11,216(sp)
ffffffffc0201224:	f1f2                	sd	t3,224(sp)
ffffffffc0201226:	f5f6                	sd	t4,232(sp)
ffffffffc0201228:	f9fa                	sd	t5,240(sp)
ffffffffc020122a:	fdfe                	sd	t6,248(sp)
ffffffffc020122c:	14001473          	csrrw	s0,sscratch,zero
ffffffffc0201230:	100024f3          	csrr	s1,sstatus
ffffffffc0201234:	14102973          	csrr	s2,sepc
ffffffffc0201238:	143029f3          	csrr	s3,stval
ffffffffc020123c:	14202a73          	csrr	s4,scause
ffffffffc0201240:	e822                	sd	s0,16(sp)
ffffffffc0201242:	e226                	sd	s1,256(sp)
ffffffffc0201244:	e64a                	sd	s2,264(sp)
ffffffffc0201246:	ea4e                	sd	s3,272(sp)
ffffffffc0201248:	ee52                	sd	s4,280(sp)
ffffffffc020124a:	850a                	mv	a0,sp
ffffffffc020124c:	f0bff0ef          	jal	ra,ffffffffc0201156 <trap>

ffffffffc0201250 <__trapret>:
ffffffffc0201250:	6492                	ld	s1,256(sp)
ffffffffc0201252:	6932                	ld	s2,264(sp)
ffffffffc0201254:	1004f413          	andi	s0,s1,256
ffffffffc0201258:	e401                	bnez	s0,ffffffffc0201260 <__trapret+0x10>
ffffffffc020125a:	1200                	addi	s0,sp,288
ffffffffc020125c:	14041073          	csrw	sscratch,s0
ffffffffc0201260:	10049073          	csrw	sstatus,s1
ffffffffc0201264:	14191073          	csrw	sepc,s2
ffffffffc0201268:	60a2                	ld	ra,8(sp)
ffffffffc020126a:	61e2                	ld	gp,24(sp)
ffffffffc020126c:	7202                	ld	tp,32(sp)
ffffffffc020126e:	72a2                	ld	t0,40(sp)
ffffffffc0201270:	7342                	ld	t1,48(sp)
ffffffffc0201272:	73e2                	ld	t2,56(sp)
ffffffffc0201274:	6406                	ld	s0,64(sp)
ffffffffc0201276:	64a6                	ld	s1,72(sp)
ffffffffc0201278:	6546                	ld	a0,80(sp)
ffffffffc020127a:	65e6                	ld	a1,88(sp)
ffffffffc020127c:	7606                	ld	a2,96(sp)
ffffffffc020127e:	76a6                	ld	a3,104(sp)
ffffffffc0201280:	7746                	ld	a4,112(sp)
ffffffffc0201282:	77e6                	ld	a5,120(sp)
ffffffffc0201284:	680a                	ld	a6,128(sp)
ffffffffc0201286:	68aa                	ld	a7,136(sp)
ffffffffc0201288:	694a                	ld	s2,144(sp)
ffffffffc020128a:	69ea                	ld	s3,152(sp)
ffffffffc020128c:	7a0a                	ld	s4,160(sp)
ffffffffc020128e:	7aaa                	ld	s5,168(sp)
ffffffffc0201290:	7b4a                	ld	s6,176(sp)
ffffffffc0201292:	7bea                	ld	s7,184(sp)
ffffffffc0201294:	6c0e                	ld	s8,192(sp)
ffffffffc0201296:	6cae                	ld	s9,200(sp)
ffffffffc0201298:	6d4e                	ld	s10,208(sp)
ffffffffc020129a:	6dee                	ld	s11,216(sp)
ffffffffc020129c:	7e0e                	ld	t3,224(sp)
ffffffffc020129e:	7eae                	ld	t4,232(sp)
ffffffffc02012a0:	7f4e                	ld	t5,240(sp)
ffffffffc02012a2:	7fee                	ld	t6,248(sp)
ffffffffc02012a4:	6142                	ld	sp,16(sp)
ffffffffc02012a6:	10200073          	sret

ffffffffc02012aa <forkrets>:
ffffffffc02012aa:	812a                	mv	sp,a0
ffffffffc02012ac:	b755                	j	ffffffffc0201250 <__trapret>

ffffffffc02012ae <default_init>:
ffffffffc02012ae:	00090797          	auipc	a5,0x90
ffffffffc02012b2:	4fa78793          	addi	a5,a5,1274 # ffffffffc02917a8 <free_area>
ffffffffc02012b6:	e79c                	sd	a5,8(a5)
ffffffffc02012b8:	e39c                	sd	a5,0(a5)
ffffffffc02012ba:	0007a823          	sw	zero,16(a5)
ffffffffc02012be:	8082                	ret

ffffffffc02012c0 <default_nr_free_pages>:
ffffffffc02012c0:	00090517          	auipc	a0,0x90
ffffffffc02012c4:	4f856503          	lwu	a0,1272(a0) # ffffffffc02917b8 <free_area+0x10>
ffffffffc02012c8:	8082                	ret

ffffffffc02012ca <default_check>:
ffffffffc02012ca:	715d                	addi	sp,sp,-80
ffffffffc02012cc:	e0a2                	sd	s0,64(sp)
ffffffffc02012ce:	00090417          	auipc	s0,0x90
ffffffffc02012d2:	4da40413          	addi	s0,s0,1242 # ffffffffc02917a8 <free_area>
ffffffffc02012d6:	641c                	ld	a5,8(s0)
ffffffffc02012d8:	e486                	sd	ra,72(sp)
ffffffffc02012da:	fc26                	sd	s1,56(sp)
ffffffffc02012dc:	f84a                	sd	s2,48(sp)
ffffffffc02012de:	f44e                	sd	s3,40(sp)
ffffffffc02012e0:	f052                	sd	s4,32(sp)
ffffffffc02012e2:	ec56                	sd	s5,24(sp)
ffffffffc02012e4:	e85a                	sd	s6,16(sp)
ffffffffc02012e6:	e45e                	sd	s7,8(sp)
ffffffffc02012e8:	e062                	sd	s8,0(sp)
ffffffffc02012ea:	2a878d63          	beq	a5,s0,ffffffffc02015a4 <default_check+0x2da>
ffffffffc02012ee:	4481                	li	s1,0
ffffffffc02012f0:	4901                	li	s2,0
ffffffffc02012f2:	ff07b703          	ld	a4,-16(a5)
ffffffffc02012f6:	8b09                	andi	a4,a4,2
ffffffffc02012f8:	2a070a63          	beqz	a4,ffffffffc02015ac <default_check+0x2e2>
ffffffffc02012fc:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201300:	679c                	ld	a5,8(a5)
ffffffffc0201302:	2905                	addiw	s2,s2,1
ffffffffc0201304:	9cb9                	addw	s1,s1,a4
ffffffffc0201306:	fe8796e3          	bne	a5,s0,ffffffffc02012f2 <default_check+0x28>
ffffffffc020130a:	89a6                	mv	s3,s1
ffffffffc020130c:	6df000ef          	jal	ra,ffffffffc02021ea <nr_free_pages>
ffffffffc0201310:	6f351e63          	bne	a0,s3,ffffffffc0201a0c <default_check+0x742>
ffffffffc0201314:	4505                	li	a0,1
ffffffffc0201316:	657000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020131a:	8aaa                	mv	s5,a0
ffffffffc020131c:	42050863          	beqz	a0,ffffffffc020174c <default_check+0x482>
ffffffffc0201320:	4505                	li	a0,1
ffffffffc0201322:	64b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201326:	89aa                	mv	s3,a0
ffffffffc0201328:	70050263          	beqz	a0,ffffffffc0201a2c <default_check+0x762>
ffffffffc020132c:	4505                	li	a0,1
ffffffffc020132e:	63f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201332:	8a2a                	mv	s4,a0
ffffffffc0201334:	48050c63          	beqz	a0,ffffffffc02017cc <default_check+0x502>
ffffffffc0201338:	293a8a63          	beq	s5,s3,ffffffffc02015cc <default_check+0x302>
ffffffffc020133c:	28aa8863          	beq	s5,a0,ffffffffc02015cc <default_check+0x302>
ffffffffc0201340:	28a98663          	beq	s3,a0,ffffffffc02015cc <default_check+0x302>
ffffffffc0201344:	000aa783          	lw	a5,0(s5)
ffffffffc0201348:	2a079263          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc020134c:	0009a783          	lw	a5,0(s3)
ffffffffc0201350:	28079e63          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc0201354:	411c                	lw	a5,0(a0)
ffffffffc0201356:	28079b63          	bnez	a5,ffffffffc02015ec <default_check+0x322>
ffffffffc020135a:	00095797          	auipc	a5,0x95
ffffffffc020135e:	54e7b783          	ld	a5,1358(a5) # ffffffffc02968a8 <pages>
ffffffffc0201362:	40fa8733          	sub	a4,s5,a5
ffffffffc0201366:	0000e617          	auipc	a2,0xe
ffffffffc020136a:	4ea63603          	ld	a2,1258(a2) # ffffffffc020f850 <nbase>
ffffffffc020136e:	8719                	srai	a4,a4,0x6
ffffffffc0201370:	9732                	add	a4,a4,a2
ffffffffc0201372:	00095697          	auipc	a3,0x95
ffffffffc0201376:	52e6b683          	ld	a3,1326(a3) # ffffffffc02968a0 <npage>
ffffffffc020137a:	06b2                	slli	a3,a3,0xc
ffffffffc020137c:	0732                	slli	a4,a4,0xc
ffffffffc020137e:	28d77763          	bgeu	a4,a3,ffffffffc020160c <default_check+0x342>
ffffffffc0201382:	40f98733          	sub	a4,s3,a5
ffffffffc0201386:	8719                	srai	a4,a4,0x6
ffffffffc0201388:	9732                	add	a4,a4,a2
ffffffffc020138a:	0732                	slli	a4,a4,0xc
ffffffffc020138c:	4cd77063          	bgeu	a4,a3,ffffffffc020184c <default_check+0x582>
ffffffffc0201390:	40f507b3          	sub	a5,a0,a5
ffffffffc0201394:	8799                	srai	a5,a5,0x6
ffffffffc0201396:	97b2                	add	a5,a5,a2
ffffffffc0201398:	07b2                	slli	a5,a5,0xc
ffffffffc020139a:	30d7f963          	bgeu	a5,a3,ffffffffc02016ac <default_check+0x3e2>
ffffffffc020139e:	4505                	li	a0,1
ffffffffc02013a0:	00043c03          	ld	s8,0(s0)
ffffffffc02013a4:	00843b83          	ld	s7,8(s0)
ffffffffc02013a8:	01042b03          	lw	s6,16(s0)
ffffffffc02013ac:	e400                	sd	s0,8(s0)
ffffffffc02013ae:	e000                	sd	s0,0(s0)
ffffffffc02013b0:	00090797          	auipc	a5,0x90
ffffffffc02013b4:	4007a423          	sw	zero,1032(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc02013b8:	5b5000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013bc:	2c051863          	bnez	a0,ffffffffc020168c <default_check+0x3c2>
ffffffffc02013c0:	4585                	li	a1,1
ffffffffc02013c2:	8556                	mv	a0,s5
ffffffffc02013c4:	5e7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013c8:	4585                	li	a1,1
ffffffffc02013ca:	854e                	mv	a0,s3
ffffffffc02013cc:	5df000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013d0:	4585                	li	a1,1
ffffffffc02013d2:	8552                	mv	a0,s4
ffffffffc02013d4:	5d7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02013d8:	4818                	lw	a4,16(s0)
ffffffffc02013da:	478d                	li	a5,3
ffffffffc02013dc:	28f71863          	bne	a4,a5,ffffffffc020166c <default_check+0x3a2>
ffffffffc02013e0:	4505                	li	a0,1
ffffffffc02013e2:	58b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013e6:	89aa                	mv	s3,a0
ffffffffc02013e8:	26050263          	beqz	a0,ffffffffc020164c <default_check+0x382>
ffffffffc02013ec:	4505                	li	a0,1
ffffffffc02013ee:	57f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013f2:	8aaa                	mv	s5,a0
ffffffffc02013f4:	3a050c63          	beqz	a0,ffffffffc02017ac <default_check+0x4e2>
ffffffffc02013f8:	4505                	li	a0,1
ffffffffc02013fa:	573000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02013fe:	8a2a                	mv	s4,a0
ffffffffc0201400:	38050663          	beqz	a0,ffffffffc020178c <default_check+0x4c2>
ffffffffc0201404:	4505                	li	a0,1
ffffffffc0201406:	567000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020140a:	36051163          	bnez	a0,ffffffffc020176c <default_check+0x4a2>
ffffffffc020140e:	4585                	li	a1,1
ffffffffc0201410:	854e                	mv	a0,s3
ffffffffc0201412:	599000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201416:	641c                	ld	a5,8(s0)
ffffffffc0201418:	20878a63          	beq	a5,s0,ffffffffc020162c <default_check+0x362>
ffffffffc020141c:	4505                	li	a0,1
ffffffffc020141e:	54f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201422:	30a99563          	bne	s3,a0,ffffffffc020172c <default_check+0x462>
ffffffffc0201426:	4505                	li	a0,1
ffffffffc0201428:	545000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020142c:	2e051063          	bnez	a0,ffffffffc020170c <default_check+0x442>
ffffffffc0201430:	481c                	lw	a5,16(s0)
ffffffffc0201432:	2a079d63          	bnez	a5,ffffffffc02016ec <default_check+0x422>
ffffffffc0201436:	854e                	mv	a0,s3
ffffffffc0201438:	4585                	li	a1,1
ffffffffc020143a:	01843023          	sd	s8,0(s0)
ffffffffc020143e:	01743423          	sd	s7,8(s0)
ffffffffc0201442:	01642823          	sw	s6,16(s0)
ffffffffc0201446:	565000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020144a:	4585                	li	a1,1
ffffffffc020144c:	8556                	mv	a0,s5
ffffffffc020144e:	55d000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201452:	4585                	li	a1,1
ffffffffc0201454:	8552                	mv	a0,s4
ffffffffc0201456:	555000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020145a:	4515                	li	a0,5
ffffffffc020145c:	511000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201460:	89aa                	mv	s3,a0
ffffffffc0201462:	26050563          	beqz	a0,ffffffffc02016cc <default_check+0x402>
ffffffffc0201466:	651c                	ld	a5,8(a0)
ffffffffc0201468:	8385                	srli	a5,a5,0x1
ffffffffc020146a:	8b85                	andi	a5,a5,1
ffffffffc020146c:	54079063          	bnez	a5,ffffffffc02019ac <default_check+0x6e2>
ffffffffc0201470:	4505                	li	a0,1
ffffffffc0201472:	00043b03          	ld	s6,0(s0)
ffffffffc0201476:	00843a83          	ld	s5,8(s0)
ffffffffc020147a:	e000                	sd	s0,0(s0)
ffffffffc020147c:	e400                	sd	s0,8(s0)
ffffffffc020147e:	4ef000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201482:	50051563          	bnez	a0,ffffffffc020198c <default_check+0x6c2>
ffffffffc0201486:	08098a13          	addi	s4,s3,128
ffffffffc020148a:	8552                	mv	a0,s4
ffffffffc020148c:	458d                	li	a1,3
ffffffffc020148e:	01042b83          	lw	s7,16(s0)
ffffffffc0201492:	00090797          	auipc	a5,0x90
ffffffffc0201496:	3207a323          	sw	zero,806(a5) # ffffffffc02917b8 <free_area+0x10>
ffffffffc020149a:	511000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc020149e:	4511                	li	a0,4
ffffffffc02014a0:	4cd000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014a4:	4c051463          	bnez	a0,ffffffffc020196c <default_check+0x6a2>
ffffffffc02014a8:	0889b783          	ld	a5,136(s3)
ffffffffc02014ac:	8385                	srli	a5,a5,0x1
ffffffffc02014ae:	8b85                	andi	a5,a5,1
ffffffffc02014b0:	48078e63          	beqz	a5,ffffffffc020194c <default_check+0x682>
ffffffffc02014b4:	0909a703          	lw	a4,144(s3)
ffffffffc02014b8:	478d                	li	a5,3
ffffffffc02014ba:	48f71963          	bne	a4,a5,ffffffffc020194c <default_check+0x682>
ffffffffc02014be:	450d                	li	a0,3
ffffffffc02014c0:	4ad000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014c4:	8c2a                	mv	s8,a0
ffffffffc02014c6:	46050363          	beqz	a0,ffffffffc020192c <default_check+0x662>
ffffffffc02014ca:	4505                	li	a0,1
ffffffffc02014cc:	4a1000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02014d0:	42051e63          	bnez	a0,ffffffffc020190c <default_check+0x642>
ffffffffc02014d4:	418a1c63          	bne	s4,s8,ffffffffc02018ec <default_check+0x622>
ffffffffc02014d8:	4585                	li	a1,1
ffffffffc02014da:	854e                	mv	a0,s3
ffffffffc02014dc:	4cf000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02014e0:	458d                	li	a1,3
ffffffffc02014e2:	8552                	mv	a0,s4
ffffffffc02014e4:	4c7000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02014e8:	0089b783          	ld	a5,8(s3)
ffffffffc02014ec:	04098c13          	addi	s8,s3,64
ffffffffc02014f0:	8385                	srli	a5,a5,0x1
ffffffffc02014f2:	8b85                	andi	a5,a5,1
ffffffffc02014f4:	3c078c63          	beqz	a5,ffffffffc02018cc <default_check+0x602>
ffffffffc02014f8:	0109a703          	lw	a4,16(s3)
ffffffffc02014fc:	4785                	li	a5,1
ffffffffc02014fe:	3cf71763          	bne	a4,a5,ffffffffc02018cc <default_check+0x602>
ffffffffc0201502:	008a3783          	ld	a5,8(s4)
ffffffffc0201506:	8385                	srli	a5,a5,0x1
ffffffffc0201508:	8b85                	andi	a5,a5,1
ffffffffc020150a:	3a078163          	beqz	a5,ffffffffc02018ac <default_check+0x5e2>
ffffffffc020150e:	010a2703          	lw	a4,16(s4)
ffffffffc0201512:	478d                	li	a5,3
ffffffffc0201514:	38f71c63          	bne	a4,a5,ffffffffc02018ac <default_check+0x5e2>
ffffffffc0201518:	4505                	li	a0,1
ffffffffc020151a:	453000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020151e:	36a99763          	bne	s3,a0,ffffffffc020188c <default_check+0x5c2>
ffffffffc0201522:	4585                	li	a1,1
ffffffffc0201524:	487000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201528:	4509                	li	a0,2
ffffffffc020152a:	443000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc020152e:	32aa1f63          	bne	s4,a0,ffffffffc020186c <default_check+0x5a2>
ffffffffc0201532:	4589                	li	a1,2
ffffffffc0201534:	477000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201538:	4585                	li	a1,1
ffffffffc020153a:	8562                	mv	a0,s8
ffffffffc020153c:	46f000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201540:	4515                	li	a0,5
ffffffffc0201542:	42b000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201546:	89aa                	mv	s3,a0
ffffffffc0201548:	48050263          	beqz	a0,ffffffffc02019cc <default_check+0x702>
ffffffffc020154c:	4505                	li	a0,1
ffffffffc020154e:	41f000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201552:	2c051d63          	bnez	a0,ffffffffc020182c <default_check+0x562>
ffffffffc0201556:	481c                	lw	a5,16(s0)
ffffffffc0201558:	2a079a63          	bnez	a5,ffffffffc020180c <default_check+0x542>
ffffffffc020155c:	4595                	li	a1,5
ffffffffc020155e:	854e                	mv	a0,s3
ffffffffc0201560:	01742823          	sw	s7,16(s0)
ffffffffc0201564:	01643023          	sd	s6,0(s0)
ffffffffc0201568:	01543423          	sd	s5,8(s0)
ffffffffc020156c:	43f000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0201570:	641c                	ld	a5,8(s0)
ffffffffc0201572:	00878963          	beq	a5,s0,ffffffffc0201584 <default_check+0x2ba>
ffffffffc0201576:	ff87a703          	lw	a4,-8(a5)
ffffffffc020157a:	679c                	ld	a5,8(a5)
ffffffffc020157c:	397d                	addiw	s2,s2,-1
ffffffffc020157e:	9c99                	subw	s1,s1,a4
ffffffffc0201580:	fe879be3          	bne	a5,s0,ffffffffc0201576 <default_check+0x2ac>
ffffffffc0201584:	26091463          	bnez	s2,ffffffffc02017ec <default_check+0x522>
ffffffffc0201588:	46049263          	bnez	s1,ffffffffc02019ec <default_check+0x722>
ffffffffc020158c:	60a6                	ld	ra,72(sp)
ffffffffc020158e:	6406                	ld	s0,64(sp)
ffffffffc0201590:	74e2                	ld	s1,56(sp)
ffffffffc0201592:	7942                	ld	s2,48(sp)
ffffffffc0201594:	79a2                	ld	s3,40(sp)
ffffffffc0201596:	7a02                	ld	s4,32(sp)
ffffffffc0201598:	6ae2                	ld	s5,24(sp)
ffffffffc020159a:	6b42                	ld	s6,16(sp)
ffffffffc020159c:	6ba2                	ld	s7,8(sp)
ffffffffc020159e:	6c02                	ld	s8,0(sp)
ffffffffc02015a0:	6161                	addi	sp,sp,80
ffffffffc02015a2:	8082                	ret
ffffffffc02015a4:	4981                	li	s3,0
ffffffffc02015a6:	4481                	li	s1,0
ffffffffc02015a8:	4901                	li	s2,0
ffffffffc02015aa:	b38d                	j	ffffffffc020130c <default_check+0x42>
ffffffffc02015ac:	0000b697          	auipc	a3,0xb
ffffffffc02015b0:	bdc68693          	addi	a3,a3,-1060 # ffffffffc020c188 <commands+0x950>
ffffffffc02015b4:	0000a617          	auipc	a2,0xa
ffffffffc02015b8:	49460613          	addi	a2,a2,1172 # ffffffffc020ba48 <commands+0x210>
ffffffffc02015bc:	0ef00593          	li	a1,239
ffffffffc02015c0:	0000b517          	auipc	a0,0xb
ffffffffc02015c4:	bd850513          	addi	a0,a0,-1064 # ffffffffc020c198 <commands+0x960>
ffffffffc02015c8:	ed7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02015cc:	0000b697          	auipc	a3,0xb
ffffffffc02015d0:	c6468693          	addi	a3,a3,-924 # ffffffffc020c230 <commands+0x9f8>
ffffffffc02015d4:	0000a617          	auipc	a2,0xa
ffffffffc02015d8:	47460613          	addi	a2,a2,1140 # ffffffffc020ba48 <commands+0x210>
ffffffffc02015dc:	0bc00593          	li	a1,188
ffffffffc02015e0:	0000b517          	auipc	a0,0xb
ffffffffc02015e4:	bb850513          	addi	a0,a0,-1096 # ffffffffc020c198 <commands+0x960>
ffffffffc02015e8:	eb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02015ec:	0000b697          	auipc	a3,0xb
ffffffffc02015f0:	c6c68693          	addi	a3,a3,-916 # ffffffffc020c258 <commands+0xa20>
ffffffffc02015f4:	0000a617          	auipc	a2,0xa
ffffffffc02015f8:	45460613          	addi	a2,a2,1108 # ffffffffc020ba48 <commands+0x210>
ffffffffc02015fc:	0bd00593          	li	a1,189
ffffffffc0201600:	0000b517          	auipc	a0,0xb
ffffffffc0201604:	b9850513          	addi	a0,a0,-1128 # ffffffffc020c198 <commands+0x960>
ffffffffc0201608:	e97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020160c:	0000b697          	auipc	a3,0xb
ffffffffc0201610:	c8c68693          	addi	a3,a3,-884 # ffffffffc020c298 <commands+0xa60>
ffffffffc0201614:	0000a617          	auipc	a2,0xa
ffffffffc0201618:	43460613          	addi	a2,a2,1076 # ffffffffc020ba48 <commands+0x210>
ffffffffc020161c:	0bf00593          	li	a1,191
ffffffffc0201620:	0000b517          	auipc	a0,0xb
ffffffffc0201624:	b7850513          	addi	a0,a0,-1160 # ffffffffc020c198 <commands+0x960>
ffffffffc0201628:	e77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020162c:	0000b697          	auipc	a3,0xb
ffffffffc0201630:	cf468693          	addi	a3,a3,-780 # ffffffffc020c320 <commands+0xae8>
ffffffffc0201634:	0000a617          	auipc	a2,0xa
ffffffffc0201638:	41460613          	addi	a2,a2,1044 # ffffffffc020ba48 <commands+0x210>
ffffffffc020163c:	0d800593          	li	a1,216
ffffffffc0201640:	0000b517          	auipc	a0,0xb
ffffffffc0201644:	b5850513          	addi	a0,a0,-1192 # ffffffffc020c198 <commands+0x960>
ffffffffc0201648:	e57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020164c:	0000b697          	auipc	a3,0xb
ffffffffc0201650:	b8468693          	addi	a3,a3,-1148 # ffffffffc020c1d0 <commands+0x998>
ffffffffc0201654:	0000a617          	auipc	a2,0xa
ffffffffc0201658:	3f460613          	addi	a2,a2,1012 # ffffffffc020ba48 <commands+0x210>
ffffffffc020165c:	0d100593          	li	a1,209
ffffffffc0201660:	0000b517          	auipc	a0,0xb
ffffffffc0201664:	b3850513          	addi	a0,a0,-1224 # ffffffffc020c198 <commands+0x960>
ffffffffc0201668:	e37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020166c:	0000b697          	auipc	a3,0xb
ffffffffc0201670:	ca468693          	addi	a3,a3,-860 # ffffffffc020c310 <commands+0xad8>
ffffffffc0201674:	0000a617          	auipc	a2,0xa
ffffffffc0201678:	3d460613          	addi	a2,a2,980 # ffffffffc020ba48 <commands+0x210>
ffffffffc020167c:	0cf00593          	li	a1,207
ffffffffc0201680:	0000b517          	auipc	a0,0xb
ffffffffc0201684:	b1850513          	addi	a0,a0,-1256 # ffffffffc020c198 <commands+0x960>
ffffffffc0201688:	e17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020168c:	0000b697          	auipc	a3,0xb
ffffffffc0201690:	c6c68693          	addi	a3,a3,-916 # ffffffffc020c2f8 <commands+0xac0>
ffffffffc0201694:	0000a617          	auipc	a2,0xa
ffffffffc0201698:	3b460613          	addi	a2,a2,948 # ffffffffc020ba48 <commands+0x210>
ffffffffc020169c:	0ca00593          	li	a1,202
ffffffffc02016a0:	0000b517          	auipc	a0,0xb
ffffffffc02016a4:	af850513          	addi	a0,a0,-1288 # ffffffffc020c198 <commands+0x960>
ffffffffc02016a8:	df7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016ac:	0000b697          	auipc	a3,0xb
ffffffffc02016b0:	c2c68693          	addi	a3,a3,-980 # ffffffffc020c2d8 <commands+0xaa0>
ffffffffc02016b4:	0000a617          	auipc	a2,0xa
ffffffffc02016b8:	39460613          	addi	a2,a2,916 # ffffffffc020ba48 <commands+0x210>
ffffffffc02016bc:	0c100593          	li	a1,193
ffffffffc02016c0:	0000b517          	auipc	a0,0xb
ffffffffc02016c4:	ad850513          	addi	a0,a0,-1320 # ffffffffc020c198 <commands+0x960>
ffffffffc02016c8:	dd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016cc:	0000b697          	auipc	a3,0xb
ffffffffc02016d0:	c9c68693          	addi	a3,a3,-868 # ffffffffc020c368 <commands+0xb30>
ffffffffc02016d4:	0000a617          	auipc	a2,0xa
ffffffffc02016d8:	37460613          	addi	a2,a2,884 # ffffffffc020ba48 <commands+0x210>
ffffffffc02016dc:	0f700593          	li	a1,247
ffffffffc02016e0:	0000b517          	auipc	a0,0xb
ffffffffc02016e4:	ab850513          	addi	a0,a0,-1352 # ffffffffc020c198 <commands+0x960>
ffffffffc02016e8:	db7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02016ec:	0000b697          	auipc	a3,0xb
ffffffffc02016f0:	c6c68693          	addi	a3,a3,-916 # ffffffffc020c358 <commands+0xb20>
ffffffffc02016f4:	0000a617          	auipc	a2,0xa
ffffffffc02016f8:	35460613          	addi	a2,a2,852 # ffffffffc020ba48 <commands+0x210>
ffffffffc02016fc:	0de00593          	li	a1,222
ffffffffc0201700:	0000b517          	auipc	a0,0xb
ffffffffc0201704:	a9850513          	addi	a0,a0,-1384 # ffffffffc020c198 <commands+0x960>
ffffffffc0201708:	d97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020170c:	0000b697          	auipc	a3,0xb
ffffffffc0201710:	bec68693          	addi	a3,a3,-1044 # ffffffffc020c2f8 <commands+0xac0>
ffffffffc0201714:	0000a617          	auipc	a2,0xa
ffffffffc0201718:	33460613          	addi	a2,a2,820 # ffffffffc020ba48 <commands+0x210>
ffffffffc020171c:	0dc00593          	li	a1,220
ffffffffc0201720:	0000b517          	auipc	a0,0xb
ffffffffc0201724:	a7850513          	addi	a0,a0,-1416 # ffffffffc020c198 <commands+0x960>
ffffffffc0201728:	d77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020172c:	0000b697          	auipc	a3,0xb
ffffffffc0201730:	c0c68693          	addi	a3,a3,-1012 # ffffffffc020c338 <commands+0xb00>
ffffffffc0201734:	0000a617          	auipc	a2,0xa
ffffffffc0201738:	31460613          	addi	a2,a2,788 # ffffffffc020ba48 <commands+0x210>
ffffffffc020173c:	0db00593          	li	a1,219
ffffffffc0201740:	0000b517          	auipc	a0,0xb
ffffffffc0201744:	a5850513          	addi	a0,a0,-1448 # ffffffffc020c198 <commands+0x960>
ffffffffc0201748:	d57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020174c:	0000b697          	auipc	a3,0xb
ffffffffc0201750:	a8468693          	addi	a3,a3,-1404 # ffffffffc020c1d0 <commands+0x998>
ffffffffc0201754:	0000a617          	auipc	a2,0xa
ffffffffc0201758:	2f460613          	addi	a2,a2,756 # ffffffffc020ba48 <commands+0x210>
ffffffffc020175c:	0b800593          	li	a1,184
ffffffffc0201760:	0000b517          	auipc	a0,0xb
ffffffffc0201764:	a3850513          	addi	a0,a0,-1480 # ffffffffc020c198 <commands+0x960>
ffffffffc0201768:	d37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020176c:	0000b697          	auipc	a3,0xb
ffffffffc0201770:	b8c68693          	addi	a3,a3,-1140 # ffffffffc020c2f8 <commands+0xac0>
ffffffffc0201774:	0000a617          	auipc	a2,0xa
ffffffffc0201778:	2d460613          	addi	a2,a2,724 # ffffffffc020ba48 <commands+0x210>
ffffffffc020177c:	0d500593          	li	a1,213
ffffffffc0201780:	0000b517          	auipc	a0,0xb
ffffffffc0201784:	a1850513          	addi	a0,a0,-1512 # ffffffffc020c198 <commands+0x960>
ffffffffc0201788:	d17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020178c:	0000b697          	auipc	a3,0xb
ffffffffc0201790:	a8468693          	addi	a3,a3,-1404 # ffffffffc020c210 <commands+0x9d8>
ffffffffc0201794:	0000a617          	auipc	a2,0xa
ffffffffc0201798:	2b460613          	addi	a2,a2,692 # ffffffffc020ba48 <commands+0x210>
ffffffffc020179c:	0d300593          	li	a1,211
ffffffffc02017a0:	0000b517          	auipc	a0,0xb
ffffffffc02017a4:	9f850513          	addi	a0,a0,-1544 # ffffffffc020c198 <commands+0x960>
ffffffffc02017a8:	cf7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017ac:	0000b697          	auipc	a3,0xb
ffffffffc02017b0:	a4468693          	addi	a3,a3,-1468 # ffffffffc020c1f0 <commands+0x9b8>
ffffffffc02017b4:	0000a617          	auipc	a2,0xa
ffffffffc02017b8:	29460613          	addi	a2,a2,660 # ffffffffc020ba48 <commands+0x210>
ffffffffc02017bc:	0d200593          	li	a1,210
ffffffffc02017c0:	0000b517          	auipc	a0,0xb
ffffffffc02017c4:	9d850513          	addi	a0,a0,-1576 # ffffffffc020c198 <commands+0x960>
ffffffffc02017c8:	cd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017cc:	0000b697          	auipc	a3,0xb
ffffffffc02017d0:	a4468693          	addi	a3,a3,-1468 # ffffffffc020c210 <commands+0x9d8>
ffffffffc02017d4:	0000a617          	auipc	a2,0xa
ffffffffc02017d8:	27460613          	addi	a2,a2,628 # ffffffffc020ba48 <commands+0x210>
ffffffffc02017dc:	0ba00593          	li	a1,186
ffffffffc02017e0:	0000b517          	auipc	a0,0xb
ffffffffc02017e4:	9b850513          	addi	a0,a0,-1608 # ffffffffc020c198 <commands+0x960>
ffffffffc02017e8:	cb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02017ec:	0000b697          	auipc	a3,0xb
ffffffffc02017f0:	ccc68693          	addi	a3,a3,-820 # ffffffffc020c4b8 <commands+0xc80>
ffffffffc02017f4:	0000a617          	auipc	a2,0xa
ffffffffc02017f8:	25460613          	addi	a2,a2,596 # ffffffffc020ba48 <commands+0x210>
ffffffffc02017fc:	12400593          	li	a1,292
ffffffffc0201800:	0000b517          	auipc	a0,0xb
ffffffffc0201804:	99850513          	addi	a0,a0,-1640 # ffffffffc020c198 <commands+0x960>
ffffffffc0201808:	c97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020180c:	0000b697          	auipc	a3,0xb
ffffffffc0201810:	b4c68693          	addi	a3,a3,-1204 # ffffffffc020c358 <commands+0xb20>
ffffffffc0201814:	0000a617          	auipc	a2,0xa
ffffffffc0201818:	23460613          	addi	a2,a2,564 # ffffffffc020ba48 <commands+0x210>
ffffffffc020181c:	11900593          	li	a1,281
ffffffffc0201820:	0000b517          	auipc	a0,0xb
ffffffffc0201824:	97850513          	addi	a0,a0,-1672 # ffffffffc020c198 <commands+0x960>
ffffffffc0201828:	c77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020182c:	0000b697          	auipc	a3,0xb
ffffffffc0201830:	acc68693          	addi	a3,a3,-1332 # ffffffffc020c2f8 <commands+0xac0>
ffffffffc0201834:	0000a617          	auipc	a2,0xa
ffffffffc0201838:	21460613          	addi	a2,a2,532 # ffffffffc020ba48 <commands+0x210>
ffffffffc020183c:	11700593          	li	a1,279
ffffffffc0201840:	0000b517          	auipc	a0,0xb
ffffffffc0201844:	95850513          	addi	a0,a0,-1704 # ffffffffc020c198 <commands+0x960>
ffffffffc0201848:	c57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020184c:	0000b697          	auipc	a3,0xb
ffffffffc0201850:	a6c68693          	addi	a3,a3,-1428 # ffffffffc020c2b8 <commands+0xa80>
ffffffffc0201854:	0000a617          	auipc	a2,0xa
ffffffffc0201858:	1f460613          	addi	a2,a2,500 # ffffffffc020ba48 <commands+0x210>
ffffffffc020185c:	0c000593          	li	a1,192
ffffffffc0201860:	0000b517          	auipc	a0,0xb
ffffffffc0201864:	93850513          	addi	a0,a0,-1736 # ffffffffc020c198 <commands+0x960>
ffffffffc0201868:	c37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020186c:	0000b697          	auipc	a3,0xb
ffffffffc0201870:	c0c68693          	addi	a3,a3,-1012 # ffffffffc020c478 <commands+0xc40>
ffffffffc0201874:	0000a617          	auipc	a2,0xa
ffffffffc0201878:	1d460613          	addi	a2,a2,468 # ffffffffc020ba48 <commands+0x210>
ffffffffc020187c:	11100593          	li	a1,273
ffffffffc0201880:	0000b517          	auipc	a0,0xb
ffffffffc0201884:	91850513          	addi	a0,a0,-1768 # ffffffffc020c198 <commands+0x960>
ffffffffc0201888:	c17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020188c:	0000b697          	auipc	a3,0xb
ffffffffc0201890:	bcc68693          	addi	a3,a3,-1076 # ffffffffc020c458 <commands+0xc20>
ffffffffc0201894:	0000a617          	auipc	a2,0xa
ffffffffc0201898:	1b460613          	addi	a2,a2,436 # ffffffffc020ba48 <commands+0x210>
ffffffffc020189c:	10f00593          	li	a1,271
ffffffffc02018a0:	0000b517          	auipc	a0,0xb
ffffffffc02018a4:	8f850513          	addi	a0,a0,-1800 # ffffffffc020c198 <commands+0x960>
ffffffffc02018a8:	bf7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018ac:	0000b697          	auipc	a3,0xb
ffffffffc02018b0:	b8468693          	addi	a3,a3,-1148 # ffffffffc020c430 <commands+0xbf8>
ffffffffc02018b4:	0000a617          	auipc	a2,0xa
ffffffffc02018b8:	19460613          	addi	a2,a2,404 # ffffffffc020ba48 <commands+0x210>
ffffffffc02018bc:	10d00593          	li	a1,269
ffffffffc02018c0:	0000b517          	auipc	a0,0xb
ffffffffc02018c4:	8d850513          	addi	a0,a0,-1832 # ffffffffc020c198 <commands+0x960>
ffffffffc02018c8:	bd7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018cc:	0000b697          	auipc	a3,0xb
ffffffffc02018d0:	b3c68693          	addi	a3,a3,-1220 # ffffffffc020c408 <commands+0xbd0>
ffffffffc02018d4:	0000a617          	auipc	a2,0xa
ffffffffc02018d8:	17460613          	addi	a2,a2,372 # ffffffffc020ba48 <commands+0x210>
ffffffffc02018dc:	10c00593          	li	a1,268
ffffffffc02018e0:	0000b517          	auipc	a0,0xb
ffffffffc02018e4:	8b850513          	addi	a0,a0,-1864 # ffffffffc020c198 <commands+0x960>
ffffffffc02018e8:	bb7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02018ec:	0000b697          	auipc	a3,0xb
ffffffffc02018f0:	b0c68693          	addi	a3,a3,-1268 # ffffffffc020c3f8 <commands+0xbc0>
ffffffffc02018f4:	0000a617          	auipc	a2,0xa
ffffffffc02018f8:	15460613          	addi	a2,a2,340 # ffffffffc020ba48 <commands+0x210>
ffffffffc02018fc:	10700593          	li	a1,263
ffffffffc0201900:	0000b517          	auipc	a0,0xb
ffffffffc0201904:	89850513          	addi	a0,a0,-1896 # ffffffffc020c198 <commands+0x960>
ffffffffc0201908:	b97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020190c:	0000b697          	auipc	a3,0xb
ffffffffc0201910:	9ec68693          	addi	a3,a3,-1556 # ffffffffc020c2f8 <commands+0xac0>
ffffffffc0201914:	0000a617          	auipc	a2,0xa
ffffffffc0201918:	13460613          	addi	a2,a2,308 # ffffffffc020ba48 <commands+0x210>
ffffffffc020191c:	10600593          	li	a1,262
ffffffffc0201920:	0000b517          	auipc	a0,0xb
ffffffffc0201924:	87850513          	addi	a0,a0,-1928 # ffffffffc020c198 <commands+0x960>
ffffffffc0201928:	b77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020192c:	0000b697          	auipc	a3,0xb
ffffffffc0201930:	aac68693          	addi	a3,a3,-1364 # ffffffffc020c3d8 <commands+0xba0>
ffffffffc0201934:	0000a617          	auipc	a2,0xa
ffffffffc0201938:	11460613          	addi	a2,a2,276 # ffffffffc020ba48 <commands+0x210>
ffffffffc020193c:	10500593          	li	a1,261
ffffffffc0201940:	0000b517          	auipc	a0,0xb
ffffffffc0201944:	85850513          	addi	a0,a0,-1960 # ffffffffc020c198 <commands+0x960>
ffffffffc0201948:	b57fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020194c:	0000b697          	auipc	a3,0xb
ffffffffc0201950:	a5c68693          	addi	a3,a3,-1444 # ffffffffc020c3a8 <commands+0xb70>
ffffffffc0201954:	0000a617          	auipc	a2,0xa
ffffffffc0201958:	0f460613          	addi	a2,a2,244 # ffffffffc020ba48 <commands+0x210>
ffffffffc020195c:	10400593          	li	a1,260
ffffffffc0201960:	0000b517          	auipc	a0,0xb
ffffffffc0201964:	83850513          	addi	a0,a0,-1992 # ffffffffc020c198 <commands+0x960>
ffffffffc0201968:	b37fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020196c:	0000b697          	auipc	a3,0xb
ffffffffc0201970:	a2468693          	addi	a3,a3,-1500 # ffffffffc020c390 <commands+0xb58>
ffffffffc0201974:	0000a617          	auipc	a2,0xa
ffffffffc0201978:	0d460613          	addi	a2,a2,212 # ffffffffc020ba48 <commands+0x210>
ffffffffc020197c:	10300593          	li	a1,259
ffffffffc0201980:	0000b517          	auipc	a0,0xb
ffffffffc0201984:	81850513          	addi	a0,a0,-2024 # ffffffffc020c198 <commands+0x960>
ffffffffc0201988:	b17fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020198c:	0000b697          	auipc	a3,0xb
ffffffffc0201990:	96c68693          	addi	a3,a3,-1684 # ffffffffc020c2f8 <commands+0xac0>
ffffffffc0201994:	0000a617          	auipc	a2,0xa
ffffffffc0201998:	0b460613          	addi	a2,a2,180 # ffffffffc020ba48 <commands+0x210>
ffffffffc020199c:	0fd00593          	li	a1,253
ffffffffc02019a0:	0000a517          	auipc	a0,0xa
ffffffffc02019a4:	7f850513          	addi	a0,a0,2040 # ffffffffc020c198 <commands+0x960>
ffffffffc02019a8:	af7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019ac:	0000b697          	auipc	a3,0xb
ffffffffc02019b0:	9cc68693          	addi	a3,a3,-1588 # ffffffffc020c378 <commands+0xb40>
ffffffffc02019b4:	0000a617          	auipc	a2,0xa
ffffffffc02019b8:	09460613          	addi	a2,a2,148 # ffffffffc020ba48 <commands+0x210>
ffffffffc02019bc:	0f800593          	li	a1,248
ffffffffc02019c0:	0000a517          	auipc	a0,0xa
ffffffffc02019c4:	7d850513          	addi	a0,a0,2008 # ffffffffc020c198 <commands+0x960>
ffffffffc02019c8:	ad7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019cc:	0000b697          	auipc	a3,0xb
ffffffffc02019d0:	acc68693          	addi	a3,a3,-1332 # ffffffffc020c498 <commands+0xc60>
ffffffffc02019d4:	0000a617          	auipc	a2,0xa
ffffffffc02019d8:	07460613          	addi	a2,a2,116 # ffffffffc020ba48 <commands+0x210>
ffffffffc02019dc:	11600593          	li	a1,278
ffffffffc02019e0:	0000a517          	auipc	a0,0xa
ffffffffc02019e4:	7b850513          	addi	a0,a0,1976 # ffffffffc020c198 <commands+0x960>
ffffffffc02019e8:	ab7fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02019ec:	0000b697          	auipc	a3,0xb
ffffffffc02019f0:	adc68693          	addi	a3,a3,-1316 # ffffffffc020c4c8 <commands+0xc90>
ffffffffc02019f4:	0000a617          	auipc	a2,0xa
ffffffffc02019f8:	05460613          	addi	a2,a2,84 # ffffffffc020ba48 <commands+0x210>
ffffffffc02019fc:	12500593          	li	a1,293
ffffffffc0201a00:	0000a517          	auipc	a0,0xa
ffffffffc0201a04:	79850513          	addi	a0,a0,1944 # ffffffffc020c198 <commands+0x960>
ffffffffc0201a08:	a97fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a0c:	0000a697          	auipc	a3,0xa
ffffffffc0201a10:	7a468693          	addi	a3,a3,1956 # ffffffffc020c1b0 <commands+0x978>
ffffffffc0201a14:	0000a617          	auipc	a2,0xa
ffffffffc0201a18:	03460613          	addi	a2,a2,52 # ffffffffc020ba48 <commands+0x210>
ffffffffc0201a1c:	0f200593          	li	a1,242
ffffffffc0201a20:	0000a517          	auipc	a0,0xa
ffffffffc0201a24:	77850513          	addi	a0,a0,1912 # ffffffffc020c198 <commands+0x960>
ffffffffc0201a28:	a77fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201a2c:	0000a697          	auipc	a3,0xa
ffffffffc0201a30:	7c468693          	addi	a3,a3,1988 # ffffffffc020c1f0 <commands+0x9b8>
ffffffffc0201a34:	0000a617          	auipc	a2,0xa
ffffffffc0201a38:	01460613          	addi	a2,a2,20 # ffffffffc020ba48 <commands+0x210>
ffffffffc0201a3c:	0b900593          	li	a1,185
ffffffffc0201a40:	0000a517          	auipc	a0,0xa
ffffffffc0201a44:	75850513          	addi	a0,a0,1880 # ffffffffc020c198 <commands+0x960>
ffffffffc0201a48:	a57fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201a4c <default_free_pages>:
ffffffffc0201a4c:	1141                	addi	sp,sp,-16
ffffffffc0201a4e:	e406                	sd	ra,8(sp)
ffffffffc0201a50:	14058463          	beqz	a1,ffffffffc0201b98 <default_free_pages+0x14c>
ffffffffc0201a54:	00659693          	slli	a3,a1,0x6
ffffffffc0201a58:	96aa                	add	a3,a3,a0
ffffffffc0201a5a:	87aa                	mv	a5,a0
ffffffffc0201a5c:	02d50263          	beq	a0,a3,ffffffffc0201a80 <default_free_pages+0x34>
ffffffffc0201a60:	6798                	ld	a4,8(a5)
ffffffffc0201a62:	8b05                	andi	a4,a4,1
ffffffffc0201a64:	10071a63          	bnez	a4,ffffffffc0201b78 <default_free_pages+0x12c>
ffffffffc0201a68:	6798                	ld	a4,8(a5)
ffffffffc0201a6a:	8b09                	andi	a4,a4,2
ffffffffc0201a6c:	10071663          	bnez	a4,ffffffffc0201b78 <default_free_pages+0x12c>
ffffffffc0201a70:	0007b423          	sd	zero,8(a5)
ffffffffc0201a74:	0007a023          	sw	zero,0(a5)
ffffffffc0201a78:	04078793          	addi	a5,a5,64
ffffffffc0201a7c:	fed792e3          	bne	a5,a3,ffffffffc0201a60 <default_free_pages+0x14>
ffffffffc0201a80:	2581                	sext.w	a1,a1
ffffffffc0201a82:	c90c                	sw	a1,16(a0)
ffffffffc0201a84:	00850893          	addi	a7,a0,8
ffffffffc0201a88:	4789                	li	a5,2
ffffffffc0201a8a:	40f8b02f          	amoor.d	zero,a5,(a7)
ffffffffc0201a8e:	00090697          	auipc	a3,0x90
ffffffffc0201a92:	d1a68693          	addi	a3,a3,-742 # ffffffffc02917a8 <free_area>
ffffffffc0201a96:	4a98                	lw	a4,16(a3)
ffffffffc0201a98:	669c                	ld	a5,8(a3)
ffffffffc0201a9a:	01850613          	addi	a2,a0,24
ffffffffc0201a9e:	9db9                	addw	a1,a1,a4
ffffffffc0201aa0:	ca8c                	sw	a1,16(a3)
ffffffffc0201aa2:	0ad78463          	beq	a5,a3,ffffffffc0201b4a <default_free_pages+0xfe>
ffffffffc0201aa6:	fe878713          	addi	a4,a5,-24
ffffffffc0201aaa:	0006b803          	ld	a6,0(a3)
ffffffffc0201aae:	4581                	li	a1,0
ffffffffc0201ab0:	00e56a63          	bltu	a0,a4,ffffffffc0201ac4 <default_free_pages+0x78>
ffffffffc0201ab4:	6798                	ld	a4,8(a5)
ffffffffc0201ab6:	04d70c63          	beq	a4,a3,ffffffffc0201b0e <default_free_pages+0xc2>
ffffffffc0201aba:	87ba                	mv	a5,a4
ffffffffc0201abc:	fe878713          	addi	a4,a5,-24
ffffffffc0201ac0:	fee57ae3          	bgeu	a0,a4,ffffffffc0201ab4 <default_free_pages+0x68>
ffffffffc0201ac4:	c199                	beqz	a1,ffffffffc0201aca <default_free_pages+0x7e>
ffffffffc0201ac6:	0106b023          	sd	a6,0(a3)
ffffffffc0201aca:	6398                	ld	a4,0(a5)
ffffffffc0201acc:	e390                	sd	a2,0(a5)
ffffffffc0201ace:	e710                	sd	a2,8(a4)
ffffffffc0201ad0:	f11c                	sd	a5,32(a0)
ffffffffc0201ad2:	ed18                	sd	a4,24(a0)
ffffffffc0201ad4:	00d70d63          	beq	a4,a3,ffffffffc0201aee <default_free_pages+0xa2>
ffffffffc0201ad8:	ff872583          	lw	a1,-8(a4)
ffffffffc0201adc:	fe870613          	addi	a2,a4,-24
ffffffffc0201ae0:	02059813          	slli	a6,a1,0x20
ffffffffc0201ae4:	01a85793          	srli	a5,a6,0x1a
ffffffffc0201ae8:	97b2                	add	a5,a5,a2
ffffffffc0201aea:	02f50c63          	beq	a0,a5,ffffffffc0201b22 <default_free_pages+0xd6>
ffffffffc0201aee:	711c                	ld	a5,32(a0)
ffffffffc0201af0:	00d78c63          	beq	a5,a3,ffffffffc0201b08 <default_free_pages+0xbc>
ffffffffc0201af4:	4910                	lw	a2,16(a0)
ffffffffc0201af6:	fe878693          	addi	a3,a5,-24
ffffffffc0201afa:	02061593          	slli	a1,a2,0x20
ffffffffc0201afe:	01a5d713          	srli	a4,a1,0x1a
ffffffffc0201b02:	972a                	add	a4,a4,a0
ffffffffc0201b04:	04e68a63          	beq	a3,a4,ffffffffc0201b58 <default_free_pages+0x10c>
ffffffffc0201b08:	60a2                	ld	ra,8(sp)
ffffffffc0201b0a:	0141                	addi	sp,sp,16
ffffffffc0201b0c:	8082                	ret
ffffffffc0201b0e:	e790                	sd	a2,8(a5)
ffffffffc0201b10:	f114                	sd	a3,32(a0)
ffffffffc0201b12:	6798                	ld	a4,8(a5)
ffffffffc0201b14:	ed1c                	sd	a5,24(a0)
ffffffffc0201b16:	02d70763          	beq	a4,a3,ffffffffc0201b44 <default_free_pages+0xf8>
ffffffffc0201b1a:	8832                	mv	a6,a2
ffffffffc0201b1c:	4585                	li	a1,1
ffffffffc0201b1e:	87ba                	mv	a5,a4
ffffffffc0201b20:	bf71                	j	ffffffffc0201abc <default_free_pages+0x70>
ffffffffc0201b22:	491c                	lw	a5,16(a0)
ffffffffc0201b24:	9dbd                	addw	a1,a1,a5
ffffffffc0201b26:	feb72c23          	sw	a1,-8(a4)
ffffffffc0201b2a:	57f5                	li	a5,-3
ffffffffc0201b2c:	60f8b02f          	amoand.d	zero,a5,(a7)
ffffffffc0201b30:	01853803          	ld	a6,24(a0)
ffffffffc0201b34:	710c                	ld	a1,32(a0)
ffffffffc0201b36:	8532                	mv	a0,a2
ffffffffc0201b38:	00b83423          	sd	a1,8(a6)
ffffffffc0201b3c:	671c                	ld	a5,8(a4)
ffffffffc0201b3e:	0105b023          	sd	a6,0(a1)
ffffffffc0201b42:	b77d                	j	ffffffffc0201af0 <default_free_pages+0xa4>
ffffffffc0201b44:	e290                	sd	a2,0(a3)
ffffffffc0201b46:	873e                	mv	a4,a5
ffffffffc0201b48:	bf41                	j	ffffffffc0201ad8 <default_free_pages+0x8c>
ffffffffc0201b4a:	60a2                	ld	ra,8(sp)
ffffffffc0201b4c:	e390                	sd	a2,0(a5)
ffffffffc0201b4e:	e790                	sd	a2,8(a5)
ffffffffc0201b50:	f11c                	sd	a5,32(a0)
ffffffffc0201b52:	ed1c                	sd	a5,24(a0)
ffffffffc0201b54:	0141                	addi	sp,sp,16
ffffffffc0201b56:	8082                	ret
ffffffffc0201b58:	ff87a703          	lw	a4,-8(a5)
ffffffffc0201b5c:	ff078693          	addi	a3,a5,-16
ffffffffc0201b60:	9e39                	addw	a2,a2,a4
ffffffffc0201b62:	c910                	sw	a2,16(a0)
ffffffffc0201b64:	5775                	li	a4,-3
ffffffffc0201b66:	60e6b02f          	amoand.d	zero,a4,(a3)
ffffffffc0201b6a:	6398                	ld	a4,0(a5)
ffffffffc0201b6c:	679c                	ld	a5,8(a5)
ffffffffc0201b6e:	60a2                	ld	ra,8(sp)
ffffffffc0201b70:	e71c                	sd	a5,8(a4)
ffffffffc0201b72:	e398                	sd	a4,0(a5)
ffffffffc0201b74:	0141                	addi	sp,sp,16
ffffffffc0201b76:	8082                	ret
ffffffffc0201b78:	0000b697          	auipc	a3,0xb
ffffffffc0201b7c:	96868693          	addi	a3,a3,-1688 # ffffffffc020c4e0 <commands+0xca8>
ffffffffc0201b80:	0000a617          	auipc	a2,0xa
ffffffffc0201b84:	ec860613          	addi	a2,a2,-312 # ffffffffc020ba48 <commands+0x210>
ffffffffc0201b88:	08200593          	li	a1,130
ffffffffc0201b8c:	0000a517          	auipc	a0,0xa
ffffffffc0201b90:	60c50513          	addi	a0,a0,1548 # ffffffffc020c198 <commands+0x960>
ffffffffc0201b94:	90bfe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201b98:	0000b697          	auipc	a3,0xb
ffffffffc0201b9c:	94068693          	addi	a3,a3,-1728 # ffffffffc020c4d8 <commands+0xca0>
ffffffffc0201ba0:	0000a617          	auipc	a2,0xa
ffffffffc0201ba4:	ea860613          	addi	a2,a2,-344 # ffffffffc020ba48 <commands+0x210>
ffffffffc0201ba8:	07f00593          	li	a1,127
ffffffffc0201bac:	0000a517          	auipc	a0,0xa
ffffffffc0201bb0:	5ec50513          	addi	a0,a0,1516 # ffffffffc020c198 <commands+0x960>
ffffffffc0201bb4:	8ebfe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201bb8 <default_alloc_pages>:
ffffffffc0201bb8:	c941                	beqz	a0,ffffffffc0201c48 <default_alloc_pages+0x90>
ffffffffc0201bba:	00090597          	auipc	a1,0x90
ffffffffc0201bbe:	bee58593          	addi	a1,a1,-1042 # ffffffffc02917a8 <free_area>
ffffffffc0201bc2:	0105a803          	lw	a6,16(a1)
ffffffffc0201bc6:	872a                	mv	a4,a0
ffffffffc0201bc8:	02081793          	slli	a5,a6,0x20
ffffffffc0201bcc:	9381                	srli	a5,a5,0x20
ffffffffc0201bce:	00a7ee63          	bltu	a5,a0,ffffffffc0201bea <default_alloc_pages+0x32>
ffffffffc0201bd2:	87ae                	mv	a5,a1
ffffffffc0201bd4:	a801                	j	ffffffffc0201be4 <default_alloc_pages+0x2c>
ffffffffc0201bd6:	ff87a683          	lw	a3,-8(a5)
ffffffffc0201bda:	02069613          	slli	a2,a3,0x20
ffffffffc0201bde:	9201                	srli	a2,a2,0x20
ffffffffc0201be0:	00e67763          	bgeu	a2,a4,ffffffffc0201bee <default_alloc_pages+0x36>
ffffffffc0201be4:	679c                	ld	a5,8(a5)
ffffffffc0201be6:	feb798e3          	bne	a5,a1,ffffffffc0201bd6 <default_alloc_pages+0x1e>
ffffffffc0201bea:	4501                	li	a0,0
ffffffffc0201bec:	8082                	ret
ffffffffc0201bee:	0007b883          	ld	a7,0(a5)
ffffffffc0201bf2:	0087b303          	ld	t1,8(a5)
ffffffffc0201bf6:	fe878513          	addi	a0,a5,-24
ffffffffc0201bfa:	00070e1b          	sext.w	t3,a4
ffffffffc0201bfe:	0068b423          	sd	t1,8(a7) # 10000008 <_binary_bin_sfs_img_size+0xff8ad08>
ffffffffc0201c02:	01133023          	sd	a7,0(t1)
ffffffffc0201c06:	02c77863          	bgeu	a4,a2,ffffffffc0201c36 <default_alloc_pages+0x7e>
ffffffffc0201c0a:	071a                	slli	a4,a4,0x6
ffffffffc0201c0c:	972a                	add	a4,a4,a0
ffffffffc0201c0e:	41c686bb          	subw	a3,a3,t3
ffffffffc0201c12:	cb14                	sw	a3,16(a4)
ffffffffc0201c14:	00870613          	addi	a2,a4,8
ffffffffc0201c18:	4689                	li	a3,2
ffffffffc0201c1a:	40d6302f          	amoor.d	zero,a3,(a2)
ffffffffc0201c1e:	0088b683          	ld	a3,8(a7)
ffffffffc0201c22:	01870613          	addi	a2,a4,24
ffffffffc0201c26:	0105a803          	lw	a6,16(a1)
ffffffffc0201c2a:	e290                	sd	a2,0(a3)
ffffffffc0201c2c:	00c8b423          	sd	a2,8(a7)
ffffffffc0201c30:	f314                	sd	a3,32(a4)
ffffffffc0201c32:	01173c23          	sd	a7,24(a4)
ffffffffc0201c36:	41c8083b          	subw	a6,a6,t3
ffffffffc0201c3a:	0105a823          	sw	a6,16(a1)
ffffffffc0201c3e:	5775                	li	a4,-3
ffffffffc0201c40:	17c1                	addi	a5,a5,-16
ffffffffc0201c42:	60e7b02f          	amoand.d	zero,a4,(a5)
ffffffffc0201c46:	8082                	ret
ffffffffc0201c48:	1141                	addi	sp,sp,-16
ffffffffc0201c4a:	0000b697          	auipc	a3,0xb
ffffffffc0201c4e:	88e68693          	addi	a3,a3,-1906 # ffffffffc020c4d8 <commands+0xca0>
ffffffffc0201c52:	0000a617          	auipc	a2,0xa
ffffffffc0201c56:	df660613          	addi	a2,a2,-522 # ffffffffc020ba48 <commands+0x210>
ffffffffc0201c5a:	06100593          	li	a1,97
ffffffffc0201c5e:	0000a517          	auipc	a0,0xa
ffffffffc0201c62:	53a50513          	addi	a0,a0,1338 # ffffffffc020c198 <commands+0x960>
ffffffffc0201c66:	e406                	sd	ra,8(sp)
ffffffffc0201c68:	837fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201c6c <default_init_memmap>:
ffffffffc0201c6c:	1141                	addi	sp,sp,-16
ffffffffc0201c6e:	e406                	sd	ra,8(sp)
ffffffffc0201c70:	c5f1                	beqz	a1,ffffffffc0201d3c <default_init_memmap+0xd0>
ffffffffc0201c72:	00659693          	slli	a3,a1,0x6
ffffffffc0201c76:	96aa                	add	a3,a3,a0
ffffffffc0201c78:	87aa                	mv	a5,a0
ffffffffc0201c7a:	00d50f63          	beq	a0,a3,ffffffffc0201c98 <default_init_memmap+0x2c>
ffffffffc0201c7e:	6798                	ld	a4,8(a5)
ffffffffc0201c80:	8b05                	andi	a4,a4,1
ffffffffc0201c82:	cf49                	beqz	a4,ffffffffc0201d1c <default_init_memmap+0xb0>
ffffffffc0201c84:	0007a823          	sw	zero,16(a5)
ffffffffc0201c88:	0007b423          	sd	zero,8(a5)
ffffffffc0201c8c:	0007a023          	sw	zero,0(a5)
ffffffffc0201c90:	04078793          	addi	a5,a5,64
ffffffffc0201c94:	fed795e3          	bne	a5,a3,ffffffffc0201c7e <default_init_memmap+0x12>
ffffffffc0201c98:	2581                	sext.w	a1,a1
ffffffffc0201c9a:	c90c                	sw	a1,16(a0)
ffffffffc0201c9c:	4789                	li	a5,2
ffffffffc0201c9e:	00850713          	addi	a4,a0,8
ffffffffc0201ca2:	40f7302f          	amoor.d	zero,a5,(a4)
ffffffffc0201ca6:	00090697          	auipc	a3,0x90
ffffffffc0201caa:	b0268693          	addi	a3,a3,-1278 # ffffffffc02917a8 <free_area>
ffffffffc0201cae:	4a98                	lw	a4,16(a3)
ffffffffc0201cb0:	669c                	ld	a5,8(a3)
ffffffffc0201cb2:	01850613          	addi	a2,a0,24
ffffffffc0201cb6:	9db9                	addw	a1,a1,a4
ffffffffc0201cb8:	ca8c                	sw	a1,16(a3)
ffffffffc0201cba:	04d78a63          	beq	a5,a3,ffffffffc0201d0e <default_init_memmap+0xa2>
ffffffffc0201cbe:	fe878713          	addi	a4,a5,-24
ffffffffc0201cc2:	0006b803          	ld	a6,0(a3)
ffffffffc0201cc6:	4581                	li	a1,0
ffffffffc0201cc8:	00e56a63          	bltu	a0,a4,ffffffffc0201cdc <default_init_memmap+0x70>
ffffffffc0201ccc:	6798                	ld	a4,8(a5)
ffffffffc0201cce:	02d70263          	beq	a4,a3,ffffffffc0201cf2 <default_init_memmap+0x86>
ffffffffc0201cd2:	87ba                	mv	a5,a4
ffffffffc0201cd4:	fe878713          	addi	a4,a5,-24
ffffffffc0201cd8:	fee57ae3          	bgeu	a0,a4,ffffffffc0201ccc <default_init_memmap+0x60>
ffffffffc0201cdc:	c199                	beqz	a1,ffffffffc0201ce2 <default_init_memmap+0x76>
ffffffffc0201cde:	0106b023          	sd	a6,0(a3)
ffffffffc0201ce2:	6398                	ld	a4,0(a5)
ffffffffc0201ce4:	60a2                	ld	ra,8(sp)
ffffffffc0201ce6:	e390                	sd	a2,0(a5)
ffffffffc0201ce8:	e710                	sd	a2,8(a4)
ffffffffc0201cea:	f11c                	sd	a5,32(a0)
ffffffffc0201cec:	ed18                	sd	a4,24(a0)
ffffffffc0201cee:	0141                	addi	sp,sp,16
ffffffffc0201cf0:	8082                	ret
ffffffffc0201cf2:	e790                	sd	a2,8(a5)
ffffffffc0201cf4:	f114                	sd	a3,32(a0)
ffffffffc0201cf6:	6798                	ld	a4,8(a5)
ffffffffc0201cf8:	ed1c                	sd	a5,24(a0)
ffffffffc0201cfa:	00d70663          	beq	a4,a3,ffffffffc0201d06 <default_init_memmap+0x9a>
ffffffffc0201cfe:	8832                	mv	a6,a2
ffffffffc0201d00:	4585                	li	a1,1
ffffffffc0201d02:	87ba                	mv	a5,a4
ffffffffc0201d04:	bfc1                	j	ffffffffc0201cd4 <default_init_memmap+0x68>
ffffffffc0201d06:	60a2                	ld	ra,8(sp)
ffffffffc0201d08:	e290                	sd	a2,0(a3)
ffffffffc0201d0a:	0141                	addi	sp,sp,16
ffffffffc0201d0c:	8082                	ret
ffffffffc0201d0e:	60a2                	ld	ra,8(sp)
ffffffffc0201d10:	e390                	sd	a2,0(a5)
ffffffffc0201d12:	e790                	sd	a2,8(a5)
ffffffffc0201d14:	f11c                	sd	a5,32(a0)
ffffffffc0201d16:	ed1c                	sd	a5,24(a0)
ffffffffc0201d18:	0141                	addi	sp,sp,16
ffffffffc0201d1a:	8082                	ret
ffffffffc0201d1c:	0000a697          	auipc	a3,0xa
ffffffffc0201d20:	7ec68693          	addi	a3,a3,2028 # ffffffffc020c508 <commands+0xcd0>
ffffffffc0201d24:	0000a617          	auipc	a2,0xa
ffffffffc0201d28:	d2460613          	addi	a2,a2,-732 # ffffffffc020ba48 <commands+0x210>
ffffffffc0201d2c:	04800593          	li	a1,72
ffffffffc0201d30:	0000a517          	auipc	a0,0xa
ffffffffc0201d34:	46850513          	addi	a0,a0,1128 # ffffffffc020c198 <commands+0x960>
ffffffffc0201d38:	f66fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0201d3c:	0000a697          	auipc	a3,0xa
ffffffffc0201d40:	79c68693          	addi	a3,a3,1948 # ffffffffc020c4d8 <commands+0xca0>
ffffffffc0201d44:	0000a617          	auipc	a2,0xa
ffffffffc0201d48:	d0460613          	addi	a2,a2,-764 # ffffffffc020ba48 <commands+0x210>
ffffffffc0201d4c:	04500593          	li	a1,69
ffffffffc0201d50:	0000a517          	auipc	a0,0xa
ffffffffc0201d54:	44850513          	addi	a0,a0,1096 # ffffffffc020c198 <commands+0x960>
ffffffffc0201d58:	f46fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201d5c <slob_free>:
ffffffffc0201d5c:	c94d                	beqz	a0,ffffffffc0201e0e <slob_free+0xb2>
ffffffffc0201d5e:	1141                	addi	sp,sp,-16
ffffffffc0201d60:	e022                	sd	s0,0(sp)
ffffffffc0201d62:	e406                	sd	ra,8(sp)
ffffffffc0201d64:	842a                	mv	s0,a0
ffffffffc0201d66:	e9c1                	bnez	a1,ffffffffc0201df6 <slob_free+0x9a>
ffffffffc0201d68:	100027f3          	csrr	a5,sstatus
ffffffffc0201d6c:	8b89                	andi	a5,a5,2
ffffffffc0201d6e:	4501                	li	a0,0
ffffffffc0201d70:	ebd9                	bnez	a5,ffffffffc0201e06 <slob_free+0xaa>
ffffffffc0201d72:	0008f617          	auipc	a2,0x8f
ffffffffc0201d76:	2de60613          	addi	a2,a2,734 # ffffffffc0291050 <slobfree>
ffffffffc0201d7a:	621c                	ld	a5,0(a2)
ffffffffc0201d7c:	873e                	mv	a4,a5
ffffffffc0201d7e:	679c                	ld	a5,8(a5)
ffffffffc0201d80:	02877a63          	bgeu	a4,s0,ffffffffc0201db4 <slob_free+0x58>
ffffffffc0201d84:	00f46463          	bltu	s0,a5,ffffffffc0201d8c <slob_free+0x30>
ffffffffc0201d88:	fef76ae3          	bltu	a4,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201d8c:	400c                	lw	a1,0(s0)
ffffffffc0201d8e:	00459693          	slli	a3,a1,0x4
ffffffffc0201d92:	96a2                	add	a3,a3,s0
ffffffffc0201d94:	02d78a63          	beq	a5,a3,ffffffffc0201dc8 <slob_free+0x6c>
ffffffffc0201d98:	4314                	lw	a3,0(a4)
ffffffffc0201d9a:	e41c                	sd	a5,8(s0)
ffffffffc0201d9c:	00469793          	slli	a5,a3,0x4
ffffffffc0201da0:	97ba                	add	a5,a5,a4
ffffffffc0201da2:	02f40e63          	beq	s0,a5,ffffffffc0201dde <slob_free+0x82>
ffffffffc0201da6:	e700                	sd	s0,8(a4)
ffffffffc0201da8:	e218                	sd	a4,0(a2)
ffffffffc0201daa:	e129                	bnez	a0,ffffffffc0201dec <slob_free+0x90>
ffffffffc0201dac:	60a2                	ld	ra,8(sp)
ffffffffc0201dae:	6402                	ld	s0,0(sp)
ffffffffc0201db0:	0141                	addi	sp,sp,16
ffffffffc0201db2:	8082                	ret
ffffffffc0201db4:	fcf764e3          	bltu	a4,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201db8:	fcf472e3          	bgeu	s0,a5,ffffffffc0201d7c <slob_free+0x20>
ffffffffc0201dbc:	400c                	lw	a1,0(s0)
ffffffffc0201dbe:	00459693          	slli	a3,a1,0x4
ffffffffc0201dc2:	96a2                	add	a3,a3,s0
ffffffffc0201dc4:	fcd79ae3          	bne	a5,a3,ffffffffc0201d98 <slob_free+0x3c>
ffffffffc0201dc8:	4394                	lw	a3,0(a5)
ffffffffc0201dca:	679c                	ld	a5,8(a5)
ffffffffc0201dcc:	9db5                	addw	a1,a1,a3
ffffffffc0201dce:	c00c                	sw	a1,0(s0)
ffffffffc0201dd0:	4314                	lw	a3,0(a4)
ffffffffc0201dd2:	e41c                	sd	a5,8(s0)
ffffffffc0201dd4:	00469793          	slli	a5,a3,0x4
ffffffffc0201dd8:	97ba                	add	a5,a5,a4
ffffffffc0201dda:	fcf416e3          	bne	s0,a5,ffffffffc0201da6 <slob_free+0x4a>
ffffffffc0201dde:	401c                	lw	a5,0(s0)
ffffffffc0201de0:	640c                	ld	a1,8(s0)
ffffffffc0201de2:	e218                	sd	a4,0(a2)
ffffffffc0201de4:	9ebd                	addw	a3,a3,a5
ffffffffc0201de6:	c314                	sw	a3,0(a4)
ffffffffc0201de8:	e70c                	sd	a1,8(a4)
ffffffffc0201dea:	d169                	beqz	a0,ffffffffc0201dac <slob_free+0x50>
ffffffffc0201dec:	6402                	ld	s0,0(sp)
ffffffffc0201dee:	60a2                	ld	ra,8(sp)
ffffffffc0201df0:	0141                	addi	sp,sp,16
ffffffffc0201df2:	e7bfe06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0201df6:	25bd                	addiw	a1,a1,15
ffffffffc0201df8:	8191                	srli	a1,a1,0x4
ffffffffc0201dfa:	c10c                	sw	a1,0(a0)
ffffffffc0201dfc:	100027f3          	csrr	a5,sstatus
ffffffffc0201e00:	8b89                	andi	a5,a5,2
ffffffffc0201e02:	4501                	li	a0,0
ffffffffc0201e04:	d7bd                	beqz	a5,ffffffffc0201d72 <slob_free+0x16>
ffffffffc0201e06:	e6dfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201e0a:	4505                	li	a0,1
ffffffffc0201e0c:	b79d                	j	ffffffffc0201d72 <slob_free+0x16>
ffffffffc0201e0e:	8082                	ret

ffffffffc0201e10 <__slob_get_free_pages.constprop.0>:
ffffffffc0201e10:	4785                	li	a5,1
ffffffffc0201e12:	1141                	addi	sp,sp,-16
ffffffffc0201e14:	00a7953b          	sllw	a0,a5,a0
ffffffffc0201e18:	e406                	sd	ra,8(sp)
ffffffffc0201e1a:	352000ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0201e1e:	c91d                	beqz	a0,ffffffffc0201e54 <__slob_get_free_pages.constprop.0+0x44>
ffffffffc0201e20:	00095697          	auipc	a3,0x95
ffffffffc0201e24:	a886b683          	ld	a3,-1400(a3) # ffffffffc02968a8 <pages>
ffffffffc0201e28:	8d15                	sub	a0,a0,a3
ffffffffc0201e2a:	8519                	srai	a0,a0,0x6
ffffffffc0201e2c:	0000e697          	auipc	a3,0xe
ffffffffc0201e30:	a246b683          	ld	a3,-1500(a3) # ffffffffc020f850 <nbase>
ffffffffc0201e34:	9536                	add	a0,a0,a3
ffffffffc0201e36:	00c51793          	slli	a5,a0,0xc
ffffffffc0201e3a:	83b1                	srli	a5,a5,0xc
ffffffffc0201e3c:	00095717          	auipc	a4,0x95
ffffffffc0201e40:	a6473703          	ld	a4,-1436(a4) # ffffffffc02968a0 <npage>
ffffffffc0201e44:	0532                	slli	a0,a0,0xc
ffffffffc0201e46:	00e7fa63          	bgeu	a5,a4,ffffffffc0201e5a <__slob_get_free_pages.constprop.0+0x4a>
ffffffffc0201e4a:	00095697          	auipc	a3,0x95
ffffffffc0201e4e:	a6e6b683          	ld	a3,-1426(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0201e52:	9536                	add	a0,a0,a3
ffffffffc0201e54:	60a2                	ld	ra,8(sp)
ffffffffc0201e56:	0141                	addi	sp,sp,16
ffffffffc0201e58:	8082                	ret
ffffffffc0201e5a:	86aa                	mv	a3,a0
ffffffffc0201e5c:	0000a617          	auipc	a2,0xa
ffffffffc0201e60:	70c60613          	addi	a2,a2,1804 # ffffffffc020c568 <default_pmm_manager+0x38>
ffffffffc0201e64:	07100593          	li	a1,113
ffffffffc0201e68:	0000a517          	auipc	a0,0xa
ffffffffc0201e6c:	72850513          	addi	a0,a0,1832 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc0201e70:	e2efe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201e74 <slob_alloc.constprop.0>:
ffffffffc0201e74:	1101                	addi	sp,sp,-32
ffffffffc0201e76:	ec06                	sd	ra,24(sp)
ffffffffc0201e78:	e822                	sd	s0,16(sp)
ffffffffc0201e7a:	e426                	sd	s1,8(sp)
ffffffffc0201e7c:	e04a                	sd	s2,0(sp)
ffffffffc0201e7e:	01050713          	addi	a4,a0,16
ffffffffc0201e82:	6785                	lui	a5,0x1
ffffffffc0201e84:	0cf77363          	bgeu	a4,a5,ffffffffc0201f4a <slob_alloc.constprop.0+0xd6>
ffffffffc0201e88:	00f50493          	addi	s1,a0,15
ffffffffc0201e8c:	8091                	srli	s1,s1,0x4
ffffffffc0201e8e:	2481                	sext.w	s1,s1
ffffffffc0201e90:	10002673          	csrr	a2,sstatus
ffffffffc0201e94:	8a09                	andi	a2,a2,2
ffffffffc0201e96:	e25d                	bnez	a2,ffffffffc0201f3c <slob_alloc.constprop.0+0xc8>
ffffffffc0201e98:	0008f917          	auipc	s2,0x8f
ffffffffc0201e9c:	1b890913          	addi	s2,s2,440 # ffffffffc0291050 <slobfree>
ffffffffc0201ea0:	00093683          	ld	a3,0(s2)
ffffffffc0201ea4:	669c                	ld	a5,8(a3)
ffffffffc0201ea6:	4398                	lw	a4,0(a5)
ffffffffc0201ea8:	08975e63          	bge	a4,s1,ffffffffc0201f44 <slob_alloc.constprop.0+0xd0>
ffffffffc0201eac:	00f68b63          	beq	a3,a5,ffffffffc0201ec2 <slob_alloc.constprop.0+0x4e>
ffffffffc0201eb0:	6780                	ld	s0,8(a5)
ffffffffc0201eb2:	4018                	lw	a4,0(s0)
ffffffffc0201eb4:	02975a63          	bge	a4,s1,ffffffffc0201ee8 <slob_alloc.constprop.0+0x74>
ffffffffc0201eb8:	00093683          	ld	a3,0(s2)
ffffffffc0201ebc:	87a2                	mv	a5,s0
ffffffffc0201ebe:	fef699e3          	bne	a3,a5,ffffffffc0201eb0 <slob_alloc.constprop.0+0x3c>
ffffffffc0201ec2:	ee31                	bnez	a2,ffffffffc0201f1e <slob_alloc.constprop.0+0xaa>
ffffffffc0201ec4:	4501                	li	a0,0
ffffffffc0201ec6:	f4bff0ef          	jal	ra,ffffffffc0201e10 <__slob_get_free_pages.constprop.0>
ffffffffc0201eca:	842a                	mv	s0,a0
ffffffffc0201ecc:	cd05                	beqz	a0,ffffffffc0201f04 <slob_alloc.constprop.0+0x90>
ffffffffc0201ece:	6585                	lui	a1,0x1
ffffffffc0201ed0:	e8dff0ef          	jal	ra,ffffffffc0201d5c <slob_free>
ffffffffc0201ed4:	10002673          	csrr	a2,sstatus
ffffffffc0201ed8:	8a09                	andi	a2,a2,2
ffffffffc0201eda:	ee05                	bnez	a2,ffffffffc0201f12 <slob_alloc.constprop.0+0x9e>
ffffffffc0201edc:	00093783          	ld	a5,0(s2)
ffffffffc0201ee0:	6780                	ld	s0,8(a5)
ffffffffc0201ee2:	4018                	lw	a4,0(s0)
ffffffffc0201ee4:	fc974ae3          	blt	a4,s1,ffffffffc0201eb8 <slob_alloc.constprop.0+0x44>
ffffffffc0201ee8:	04e48763          	beq	s1,a4,ffffffffc0201f36 <slob_alloc.constprop.0+0xc2>
ffffffffc0201eec:	00449693          	slli	a3,s1,0x4
ffffffffc0201ef0:	96a2                	add	a3,a3,s0
ffffffffc0201ef2:	e794                	sd	a3,8(a5)
ffffffffc0201ef4:	640c                	ld	a1,8(s0)
ffffffffc0201ef6:	9f05                	subw	a4,a4,s1
ffffffffc0201ef8:	c298                	sw	a4,0(a3)
ffffffffc0201efa:	e68c                	sd	a1,8(a3)
ffffffffc0201efc:	c004                	sw	s1,0(s0)
ffffffffc0201efe:	00f93023          	sd	a5,0(s2)
ffffffffc0201f02:	e20d                	bnez	a2,ffffffffc0201f24 <slob_alloc.constprop.0+0xb0>
ffffffffc0201f04:	60e2                	ld	ra,24(sp)
ffffffffc0201f06:	8522                	mv	a0,s0
ffffffffc0201f08:	6442                	ld	s0,16(sp)
ffffffffc0201f0a:	64a2                	ld	s1,8(sp)
ffffffffc0201f0c:	6902                	ld	s2,0(sp)
ffffffffc0201f0e:	6105                	addi	sp,sp,32
ffffffffc0201f10:	8082                	ret
ffffffffc0201f12:	d61fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f16:	00093783          	ld	a5,0(s2)
ffffffffc0201f1a:	4605                	li	a2,1
ffffffffc0201f1c:	b7d1                	j	ffffffffc0201ee0 <slob_alloc.constprop.0+0x6c>
ffffffffc0201f1e:	d4ffe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f22:	b74d                	j	ffffffffc0201ec4 <slob_alloc.constprop.0+0x50>
ffffffffc0201f24:	d49fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0201f28:	60e2                	ld	ra,24(sp)
ffffffffc0201f2a:	8522                	mv	a0,s0
ffffffffc0201f2c:	6442                	ld	s0,16(sp)
ffffffffc0201f2e:	64a2                	ld	s1,8(sp)
ffffffffc0201f30:	6902                	ld	s2,0(sp)
ffffffffc0201f32:	6105                	addi	sp,sp,32
ffffffffc0201f34:	8082                	ret
ffffffffc0201f36:	6418                	ld	a4,8(s0)
ffffffffc0201f38:	e798                	sd	a4,8(a5)
ffffffffc0201f3a:	b7d1                	j	ffffffffc0201efe <slob_alloc.constprop.0+0x8a>
ffffffffc0201f3c:	d37fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0201f40:	4605                	li	a2,1
ffffffffc0201f42:	bf99                	j	ffffffffc0201e98 <slob_alloc.constprop.0+0x24>
ffffffffc0201f44:	843e                	mv	s0,a5
ffffffffc0201f46:	87b6                	mv	a5,a3
ffffffffc0201f48:	b745                	j	ffffffffc0201ee8 <slob_alloc.constprop.0+0x74>
ffffffffc0201f4a:	0000a697          	auipc	a3,0xa
ffffffffc0201f4e:	65668693          	addi	a3,a3,1622 # ffffffffc020c5a0 <default_pmm_manager+0x70>
ffffffffc0201f52:	0000a617          	auipc	a2,0xa
ffffffffc0201f56:	af660613          	addi	a2,a2,-1290 # ffffffffc020ba48 <commands+0x210>
ffffffffc0201f5a:	06300593          	li	a1,99
ffffffffc0201f5e:	0000a517          	auipc	a0,0xa
ffffffffc0201f62:	66250513          	addi	a0,a0,1634 # ffffffffc020c5c0 <default_pmm_manager+0x90>
ffffffffc0201f66:	d38fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0201f6a <kmalloc_init>:
ffffffffc0201f6a:	1141                	addi	sp,sp,-16
ffffffffc0201f6c:	0000a517          	auipc	a0,0xa
ffffffffc0201f70:	66c50513          	addi	a0,a0,1644 # ffffffffc020c5d8 <default_pmm_manager+0xa8>
ffffffffc0201f74:	e406                	sd	ra,8(sp)
ffffffffc0201f76:	a30fe0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0201f7a:	60a2                	ld	ra,8(sp)
ffffffffc0201f7c:	0000a517          	auipc	a0,0xa
ffffffffc0201f80:	67450513          	addi	a0,a0,1652 # ffffffffc020c5f0 <default_pmm_manager+0xc0>
ffffffffc0201f84:	0141                	addi	sp,sp,16
ffffffffc0201f86:	a20fe06f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0201f8a <kallocated>:
ffffffffc0201f8a:	4501                	li	a0,0
ffffffffc0201f8c:	8082                	ret

ffffffffc0201f8e <kmalloc>:
ffffffffc0201f8e:	1101                	addi	sp,sp,-32
ffffffffc0201f90:	e04a                	sd	s2,0(sp)
ffffffffc0201f92:	6905                	lui	s2,0x1
ffffffffc0201f94:	e822                	sd	s0,16(sp)
ffffffffc0201f96:	ec06                	sd	ra,24(sp)
ffffffffc0201f98:	e426                	sd	s1,8(sp)
ffffffffc0201f9a:	fef90793          	addi	a5,s2,-17 # fef <_binary_bin_swap_img_size-0x6d11>
ffffffffc0201f9e:	842a                	mv	s0,a0
ffffffffc0201fa0:	04a7f963          	bgeu	a5,a0,ffffffffc0201ff2 <kmalloc+0x64>
ffffffffc0201fa4:	4561                	li	a0,24
ffffffffc0201fa6:	ecfff0ef          	jal	ra,ffffffffc0201e74 <slob_alloc.constprop.0>
ffffffffc0201faa:	84aa                	mv	s1,a0
ffffffffc0201fac:	c929                	beqz	a0,ffffffffc0201ffe <kmalloc+0x70>
ffffffffc0201fae:	0004079b          	sext.w	a5,s0
ffffffffc0201fb2:	4501                	li	a0,0
ffffffffc0201fb4:	00f95763          	bge	s2,a5,ffffffffc0201fc2 <kmalloc+0x34>
ffffffffc0201fb8:	6705                	lui	a4,0x1
ffffffffc0201fba:	8785                	srai	a5,a5,0x1
ffffffffc0201fbc:	2505                	addiw	a0,a0,1
ffffffffc0201fbe:	fef74ee3          	blt	a4,a5,ffffffffc0201fba <kmalloc+0x2c>
ffffffffc0201fc2:	c088                	sw	a0,0(s1)
ffffffffc0201fc4:	e4dff0ef          	jal	ra,ffffffffc0201e10 <__slob_get_free_pages.constprop.0>
ffffffffc0201fc8:	e488                	sd	a0,8(s1)
ffffffffc0201fca:	842a                	mv	s0,a0
ffffffffc0201fcc:	c525                	beqz	a0,ffffffffc0202034 <kmalloc+0xa6>
ffffffffc0201fce:	100027f3          	csrr	a5,sstatus
ffffffffc0201fd2:	8b89                	andi	a5,a5,2
ffffffffc0201fd4:	ef8d                	bnez	a5,ffffffffc020200e <kmalloc+0x80>
ffffffffc0201fd6:	00095797          	auipc	a5,0x95
ffffffffc0201fda:	8b278793          	addi	a5,a5,-1870 # ffffffffc0296888 <bigblocks>
ffffffffc0201fde:	6398                	ld	a4,0(a5)
ffffffffc0201fe0:	e384                	sd	s1,0(a5)
ffffffffc0201fe2:	e898                	sd	a4,16(s1)
ffffffffc0201fe4:	60e2                	ld	ra,24(sp)
ffffffffc0201fe6:	8522                	mv	a0,s0
ffffffffc0201fe8:	6442                	ld	s0,16(sp)
ffffffffc0201fea:	64a2                	ld	s1,8(sp)
ffffffffc0201fec:	6902                	ld	s2,0(sp)
ffffffffc0201fee:	6105                	addi	sp,sp,32
ffffffffc0201ff0:	8082                	ret
ffffffffc0201ff2:	0541                	addi	a0,a0,16
ffffffffc0201ff4:	e81ff0ef          	jal	ra,ffffffffc0201e74 <slob_alloc.constprop.0>
ffffffffc0201ff8:	01050413          	addi	s0,a0,16
ffffffffc0201ffc:	f565                	bnez	a0,ffffffffc0201fe4 <kmalloc+0x56>
ffffffffc0201ffe:	4401                	li	s0,0
ffffffffc0202000:	60e2                	ld	ra,24(sp)
ffffffffc0202002:	8522                	mv	a0,s0
ffffffffc0202004:	6442                	ld	s0,16(sp)
ffffffffc0202006:	64a2                	ld	s1,8(sp)
ffffffffc0202008:	6902                	ld	s2,0(sp)
ffffffffc020200a:	6105                	addi	sp,sp,32
ffffffffc020200c:	8082                	ret
ffffffffc020200e:	c65fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202012:	00095797          	auipc	a5,0x95
ffffffffc0202016:	87678793          	addi	a5,a5,-1930 # ffffffffc0296888 <bigblocks>
ffffffffc020201a:	6398                	ld	a4,0(a5)
ffffffffc020201c:	e384                	sd	s1,0(a5)
ffffffffc020201e:	e898                	sd	a4,16(s1)
ffffffffc0202020:	c4dfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202024:	6480                	ld	s0,8(s1)
ffffffffc0202026:	60e2                	ld	ra,24(sp)
ffffffffc0202028:	64a2                	ld	s1,8(sp)
ffffffffc020202a:	8522                	mv	a0,s0
ffffffffc020202c:	6442                	ld	s0,16(sp)
ffffffffc020202e:	6902                	ld	s2,0(sp)
ffffffffc0202030:	6105                	addi	sp,sp,32
ffffffffc0202032:	8082                	ret
ffffffffc0202034:	45e1                	li	a1,24
ffffffffc0202036:	8526                	mv	a0,s1
ffffffffc0202038:	d25ff0ef          	jal	ra,ffffffffc0201d5c <slob_free>
ffffffffc020203c:	b765                	j	ffffffffc0201fe4 <kmalloc+0x56>

ffffffffc020203e <kfree>:
ffffffffc020203e:	c169                	beqz	a0,ffffffffc0202100 <kfree+0xc2>
ffffffffc0202040:	1101                	addi	sp,sp,-32
ffffffffc0202042:	e822                	sd	s0,16(sp)
ffffffffc0202044:	ec06                	sd	ra,24(sp)
ffffffffc0202046:	e426                	sd	s1,8(sp)
ffffffffc0202048:	03451793          	slli	a5,a0,0x34
ffffffffc020204c:	842a                	mv	s0,a0
ffffffffc020204e:	e3d9                	bnez	a5,ffffffffc02020d4 <kfree+0x96>
ffffffffc0202050:	100027f3          	csrr	a5,sstatus
ffffffffc0202054:	8b89                	andi	a5,a5,2
ffffffffc0202056:	e7d9                	bnez	a5,ffffffffc02020e4 <kfree+0xa6>
ffffffffc0202058:	00095797          	auipc	a5,0x95
ffffffffc020205c:	8307b783          	ld	a5,-2000(a5) # ffffffffc0296888 <bigblocks>
ffffffffc0202060:	4601                	li	a2,0
ffffffffc0202062:	cbad                	beqz	a5,ffffffffc02020d4 <kfree+0x96>
ffffffffc0202064:	00095697          	auipc	a3,0x95
ffffffffc0202068:	82468693          	addi	a3,a3,-2012 # ffffffffc0296888 <bigblocks>
ffffffffc020206c:	a021                	j	ffffffffc0202074 <kfree+0x36>
ffffffffc020206e:	01048693          	addi	a3,s1,16
ffffffffc0202072:	c3a5                	beqz	a5,ffffffffc02020d2 <kfree+0x94>
ffffffffc0202074:	6798                	ld	a4,8(a5)
ffffffffc0202076:	84be                	mv	s1,a5
ffffffffc0202078:	6b9c                	ld	a5,16(a5)
ffffffffc020207a:	fe871ae3          	bne	a4,s0,ffffffffc020206e <kfree+0x30>
ffffffffc020207e:	e29c                	sd	a5,0(a3)
ffffffffc0202080:	ee2d                	bnez	a2,ffffffffc02020fa <kfree+0xbc>
ffffffffc0202082:	c02007b7          	lui	a5,0xc0200
ffffffffc0202086:	4098                	lw	a4,0(s1)
ffffffffc0202088:	08f46963          	bltu	s0,a5,ffffffffc020211a <kfree+0xdc>
ffffffffc020208c:	00095697          	auipc	a3,0x95
ffffffffc0202090:	82c6b683          	ld	a3,-2004(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202094:	8c15                	sub	s0,s0,a3
ffffffffc0202096:	8031                	srli	s0,s0,0xc
ffffffffc0202098:	00095797          	auipc	a5,0x95
ffffffffc020209c:	8087b783          	ld	a5,-2040(a5) # ffffffffc02968a0 <npage>
ffffffffc02020a0:	06f47163          	bgeu	s0,a5,ffffffffc0202102 <kfree+0xc4>
ffffffffc02020a4:	0000d517          	auipc	a0,0xd
ffffffffc02020a8:	7ac53503          	ld	a0,1964(a0) # ffffffffc020f850 <nbase>
ffffffffc02020ac:	8c09                	sub	s0,s0,a0
ffffffffc02020ae:	041a                	slli	s0,s0,0x6
ffffffffc02020b0:	00094517          	auipc	a0,0x94
ffffffffc02020b4:	7f853503          	ld	a0,2040(a0) # ffffffffc02968a8 <pages>
ffffffffc02020b8:	4585                	li	a1,1
ffffffffc02020ba:	9522                	add	a0,a0,s0
ffffffffc02020bc:	00e595bb          	sllw	a1,a1,a4
ffffffffc02020c0:	0ea000ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02020c4:	6442                	ld	s0,16(sp)
ffffffffc02020c6:	60e2                	ld	ra,24(sp)
ffffffffc02020c8:	8526                	mv	a0,s1
ffffffffc02020ca:	64a2                	ld	s1,8(sp)
ffffffffc02020cc:	45e1                	li	a1,24
ffffffffc02020ce:	6105                	addi	sp,sp,32
ffffffffc02020d0:	b171                	j	ffffffffc0201d5c <slob_free>
ffffffffc02020d2:	e20d                	bnez	a2,ffffffffc02020f4 <kfree+0xb6>
ffffffffc02020d4:	ff040513          	addi	a0,s0,-16
ffffffffc02020d8:	6442                	ld	s0,16(sp)
ffffffffc02020da:	60e2                	ld	ra,24(sp)
ffffffffc02020dc:	64a2                	ld	s1,8(sp)
ffffffffc02020de:	4581                	li	a1,0
ffffffffc02020e0:	6105                	addi	sp,sp,32
ffffffffc02020e2:	b9ad                	j	ffffffffc0201d5c <slob_free>
ffffffffc02020e4:	b8ffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02020e8:	00094797          	auipc	a5,0x94
ffffffffc02020ec:	7a07b783          	ld	a5,1952(a5) # ffffffffc0296888 <bigblocks>
ffffffffc02020f0:	4605                	li	a2,1
ffffffffc02020f2:	fbad                	bnez	a5,ffffffffc0202064 <kfree+0x26>
ffffffffc02020f4:	b79fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02020f8:	bff1                	j	ffffffffc02020d4 <kfree+0x96>
ffffffffc02020fa:	b73fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02020fe:	b751                	j	ffffffffc0202082 <kfree+0x44>
ffffffffc0202100:	8082                	ret
ffffffffc0202102:	0000a617          	auipc	a2,0xa
ffffffffc0202106:	53660613          	addi	a2,a2,1334 # ffffffffc020c638 <default_pmm_manager+0x108>
ffffffffc020210a:	06900593          	li	a1,105
ffffffffc020210e:	0000a517          	auipc	a0,0xa
ffffffffc0202112:	48250513          	addi	a0,a0,1154 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc0202116:	b88fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020211a:	86a2                	mv	a3,s0
ffffffffc020211c:	0000a617          	auipc	a2,0xa
ffffffffc0202120:	4f460613          	addi	a2,a2,1268 # ffffffffc020c610 <default_pmm_manager+0xe0>
ffffffffc0202124:	07700593          	li	a1,119
ffffffffc0202128:	0000a517          	auipc	a0,0xa
ffffffffc020212c:	46850513          	addi	a0,a0,1128 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc0202130:	b6efe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202134 <pa2page.part.0>:
ffffffffc0202134:	1141                	addi	sp,sp,-16
ffffffffc0202136:	0000a617          	auipc	a2,0xa
ffffffffc020213a:	50260613          	addi	a2,a2,1282 # ffffffffc020c638 <default_pmm_manager+0x108>
ffffffffc020213e:	06900593          	li	a1,105
ffffffffc0202142:	0000a517          	auipc	a0,0xa
ffffffffc0202146:	44e50513          	addi	a0,a0,1102 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc020214a:	e406                	sd	ra,8(sp)
ffffffffc020214c:	b52fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202150 <pte2page.part.0>:
ffffffffc0202150:	1141                	addi	sp,sp,-16
ffffffffc0202152:	0000a617          	auipc	a2,0xa
ffffffffc0202156:	50660613          	addi	a2,a2,1286 # ffffffffc020c658 <default_pmm_manager+0x128>
ffffffffc020215a:	07f00593          	li	a1,127
ffffffffc020215e:	0000a517          	auipc	a0,0xa
ffffffffc0202162:	43250513          	addi	a0,a0,1074 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc0202166:	e406                	sd	ra,8(sp)
ffffffffc0202168:	b36fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020216c <alloc_pages>:
ffffffffc020216c:	100027f3          	csrr	a5,sstatus
ffffffffc0202170:	8b89                	andi	a5,a5,2
ffffffffc0202172:	e799                	bnez	a5,ffffffffc0202180 <alloc_pages+0x14>
ffffffffc0202174:	00094797          	auipc	a5,0x94
ffffffffc0202178:	73c7b783          	ld	a5,1852(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020217c:	6f9c                	ld	a5,24(a5)
ffffffffc020217e:	8782                	jr	a5
ffffffffc0202180:	1141                	addi	sp,sp,-16
ffffffffc0202182:	e406                	sd	ra,8(sp)
ffffffffc0202184:	e022                	sd	s0,0(sp)
ffffffffc0202186:	842a                	mv	s0,a0
ffffffffc0202188:	aebfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020218c:	00094797          	auipc	a5,0x94
ffffffffc0202190:	7247b783          	ld	a5,1828(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202194:	6f9c                	ld	a5,24(a5)
ffffffffc0202196:	8522                	mv	a0,s0
ffffffffc0202198:	9782                	jalr	a5
ffffffffc020219a:	842a                	mv	s0,a0
ffffffffc020219c:	ad1fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02021a0:	60a2                	ld	ra,8(sp)
ffffffffc02021a2:	8522                	mv	a0,s0
ffffffffc02021a4:	6402                	ld	s0,0(sp)
ffffffffc02021a6:	0141                	addi	sp,sp,16
ffffffffc02021a8:	8082                	ret

ffffffffc02021aa <free_pages>:
ffffffffc02021aa:	100027f3          	csrr	a5,sstatus
ffffffffc02021ae:	8b89                	andi	a5,a5,2
ffffffffc02021b0:	e799                	bnez	a5,ffffffffc02021be <free_pages+0x14>
ffffffffc02021b2:	00094797          	auipc	a5,0x94
ffffffffc02021b6:	6fe7b783          	ld	a5,1790(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021ba:	739c                	ld	a5,32(a5)
ffffffffc02021bc:	8782                	jr	a5
ffffffffc02021be:	1101                	addi	sp,sp,-32
ffffffffc02021c0:	ec06                	sd	ra,24(sp)
ffffffffc02021c2:	e822                	sd	s0,16(sp)
ffffffffc02021c4:	e426                	sd	s1,8(sp)
ffffffffc02021c6:	842a                	mv	s0,a0
ffffffffc02021c8:	84ae                	mv	s1,a1
ffffffffc02021ca:	aa9fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02021ce:	00094797          	auipc	a5,0x94
ffffffffc02021d2:	6e27b783          	ld	a5,1762(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021d6:	739c                	ld	a5,32(a5)
ffffffffc02021d8:	85a6                	mv	a1,s1
ffffffffc02021da:	8522                	mv	a0,s0
ffffffffc02021dc:	9782                	jalr	a5
ffffffffc02021de:	6442                	ld	s0,16(sp)
ffffffffc02021e0:	60e2                	ld	ra,24(sp)
ffffffffc02021e2:	64a2                	ld	s1,8(sp)
ffffffffc02021e4:	6105                	addi	sp,sp,32
ffffffffc02021e6:	a87fe06f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc02021ea <nr_free_pages>:
ffffffffc02021ea:	100027f3          	csrr	a5,sstatus
ffffffffc02021ee:	8b89                	andi	a5,a5,2
ffffffffc02021f0:	e799                	bnez	a5,ffffffffc02021fe <nr_free_pages+0x14>
ffffffffc02021f2:	00094797          	auipc	a5,0x94
ffffffffc02021f6:	6be7b783          	ld	a5,1726(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02021fa:	779c                	ld	a5,40(a5)
ffffffffc02021fc:	8782                	jr	a5
ffffffffc02021fe:	1141                	addi	sp,sp,-16
ffffffffc0202200:	e406                	sd	ra,8(sp)
ffffffffc0202202:	e022                	sd	s0,0(sp)
ffffffffc0202204:	a6ffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202208:	00094797          	auipc	a5,0x94
ffffffffc020220c:	6a87b783          	ld	a5,1704(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202210:	779c                	ld	a5,40(a5)
ffffffffc0202212:	9782                	jalr	a5
ffffffffc0202214:	842a                	mv	s0,a0
ffffffffc0202216:	a57fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020221a:	60a2                	ld	ra,8(sp)
ffffffffc020221c:	8522                	mv	a0,s0
ffffffffc020221e:	6402                	ld	s0,0(sp)
ffffffffc0202220:	0141                	addi	sp,sp,16
ffffffffc0202222:	8082                	ret

ffffffffc0202224 <get_pte>:
ffffffffc0202224:	01e5d793          	srli	a5,a1,0x1e
ffffffffc0202228:	1ff7f793          	andi	a5,a5,511
ffffffffc020222c:	7139                	addi	sp,sp,-64
ffffffffc020222e:	078e                	slli	a5,a5,0x3
ffffffffc0202230:	f426                	sd	s1,40(sp)
ffffffffc0202232:	00f504b3          	add	s1,a0,a5
ffffffffc0202236:	6094                	ld	a3,0(s1)
ffffffffc0202238:	f04a                	sd	s2,32(sp)
ffffffffc020223a:	ec4e                	sd	s3,24(sp)
ffffffffc020223c:	e852                	sd	s4,16(sp)
ffffffffc020223e:	fc06                	sd	ra,56(sp)
ffffffffc0202240:	f822                	sd	s0,48(sp)
ffffffffc0202242:	e456                	sd	s5,8(sp)
ffffffffc0202244:	e05a                	sd	s6,0(sp)
ffffffffc0202246:	0016f793          	andi	a5,a3,1
ffffffffc020224a:	892e                	mv	s2,a1
ffffffffc020224c:	8a32                	mv	s4,a2
ffffffffc020224e:	00094997          	auipc	s3,0x94
ffffffffc0202252:	65298993          	addi	s3,s3,1618 # ffffffffc02968a0 <npage>
ffffffffc0202256:	efbd                	bnez	a5,ffffffffc02022d4 <get_pte+0xb0>
ffffffffc0202258:	14060c63          	beqz	a2,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020225c:	100027f3          	csrr	a5,sstatus
ffffffffc0202260:	8b89                	andi	a5,a5,2
ffffffffc0202262:	14079963          	bnez	a5,ffffffffc02023b4 <get_pte+0x190>
ffffffffc0202266:	00094797          	auipc	a5,0x94
ffffffffc020226a:	64a7b783          	ld	a5,1610(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020226e:	6f9c                	ld	a5,24(a5)
ffffffffc0202270:	4505                	li	a0,1
ffffffffc0202272:	9782                	jalr	a5
ffffffffc0202274:	842a                	mv	s0,a0
ffffffffc0202276:	12040d63          	beqz	s0,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020227a:	00094b17          	auipc	s6,0x94
ffffffffc020227e:	62eb0b13          	addi	s6,s6,1582 # ffffffffc02968a8 <pages>
ffffffffc0202282:	000b3503          	ld	a0,0(s6)
ffffffffc0202286:	00080ab7          	lui	s5,0x80
ffffffffc020228a:	00094997          	auipc	s3,0x94
ffffffffc020228e:	61698993          	addi	s3,s3,1558 # ffffffffc02968a0 <npage>
ffffffffc0202292:	40a40533          	sub	a0,s0,a0
ffffffffc0202296:	8519                	srai	a0,a0,0x6
ffffffffc0202298:	9556                	add	a0,a0,s5
ffffffffc020229a:	0009b703          	ld	a4,0(s3)
ffffffffc020229e:	00c51793          	slli	a5,a0,0xc
ffffffffc02022a2:	4685                	li	a3,1
ffffffffc02022a4:	c014                	sw	a3,0(s0)
ffffffffc02022a6:	83b1                	srli	a5,a5,0xc
ffffffffc02022a8:	0532                	slli	a0,a0,0xc
ffffffffc02022aa:	16e7f763          	bgeu	a5,a4,ffffffffc0202418 <get_pte+0x1f4>
ffffffffc02022ae:	00094797          	auipc	a5,0x94
ffffffffc02022b2:	60a7b783          	ld	a5,1546(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc02022b6:	6605                	lui	a2,0x1
ffffffffc02022b8:	4581                	li	a1,0
ffffffffc02022ba:	953e                	add	a0,a0,a5
ffffffffc02022bc:	2aa090ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc02022c0:	000b3683          	ld	a3,0(s6)
ffffffffc02022c4:	40d406b3          	sub	a3,s0,a3
ffffffffc02022c8:	8699                	srai	a3,a3,0x6
ffffffffc02022ca:	96d6                	add	a3,a3,s5
ffffffffc02022cc:	06aa                	slli	a3,a3,0xa
ffffffffc02022ce:	0116e693          	ori	a3,a3,17
ffffffffc02022d2:	e094                	sd	a3,0(s1)
ffffffffc02022d4:	77fd                	lui	a5,0xfffff
ffffffffc02022d6:	068a                	slli	a3,a3,0x2
ffffffffc02022d8:	0009b703          	ld	a4,0(s3)
ffffffffc02022dc:	8efd                	and	a3,a3,a5
ffffffffc02022de:	00c6d793          	srli	a5,a3,0xc
ffffffffc02022e2:	10e7ff63          	bgeu	a5,a4,ffffffffc0202400 <get_pte+0x1dc>
ffffffffc02022e6:	00094a97          	auipc	s5,0x94
ffffffffc02022ea:	5d2a8a93          	addi	s5,s5,1490 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02022ee:	000ab403          	ld	s0,0(s5)
ffffffffc02022f2:	01595793          	srli	a5,s2,0x15
ffffffffc02022f6:	1ff7f793          	andi	a5,a5,511
ffffffffc02022fa:	96a2                	add	a3,a3,s0
ffffffffc02022fc:	00379413          	slli	s0,a5,0x3
ffffffffc0202300:	9436                	add	s0,s0,a3
ffffffffc0202302:	6014                	ld	a3,0(s0)
ffffffffc0202304:	0016f793          	andi	a5,a3,1
ffffffffc0202308:	ebad                	bnez	a5,ffffffffc020237a <get_pte+0x156>
ffffffffc020230a:	0a0a0363          	beqz	s4,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc020230e:	100027f3          	csrr	a5,sstatus
ffffffffc0202312:	8b89                	andi	a5,a5,2
ffffffffc0202314:	efcd                	bnez	a5,ffffffffc02023ce <get_pte+0x1aa>
ffffffffc0202316:	00094797          	auipc	a5,0x94
ffffffffc020231a:	59a7b783          	ld	a5,1434(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc020231e:	6f9c                	ld	a5,24(a5)
ffffffffc0202320:	4505                	li	a0,1
ffffffffc0202322:	9782                	jalr	a5
ffffffffc0202324:	84aa                	mv	s1,a0
ffffffffc0202326:	c4c9                	beqz	s1,ffffffffc02023b0 <get_pte+0x18c>
ffffffffc0202328:	00094b17          	auipc	s6,0x94
ffffffffc020232c:	580b0b13          	addi	s6,s6,1408 # ffffffffc02968a8 <pages>
ffffffffc0202330:	000b3503          	ld	a0,0(s6)
ffffffffc0202334:	00080a37          	lui	s4,0x80
ffffffffc0202338:	0009b703          	ld	a4,0(s3)
ffffffffc020233c:	40a48533          	sub	a0,s1,a0
ffffffffc0202340:	8519                	srai	a0,a0,0x6
ffffffffc0202342:	9552                	add	a0,a0,s4
ffffffffc0202344:	00c51793          	slli	a5,a0,0xc
ffffffffc0202348:	4685                	li	a3,1
ffffffffc020234a:	c094                	sw	a3,0(s1)
ffffffffc020234c:	83b1                	srli	a5,a5,0xc
ffffffffc020234e:	0532                	slli	a0,a0,0xc
ffffffffc0202350:	0ee7f163          	bgeu	a5,a4,ffffffffc0202432 <get_pte+0x20e>
ffffffffc0202354:	000ab783          	ld	a5,0(s5)
ffffffffc0202358:	6605                	lui	a2,0x1
ffffffffc020235a:	4581                	li	a1,0
ffffffffc020235c:	953e                	add	a0,a0,a5
ffffffffc020235e:	208090ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc0202362:	000b3683          	ld	a3,0(s6)
ffffffffc0202366:	40d486b3          	sub	a3,s1,a3
ffffffffc020236a:	8699                	srai	a3,a3,0x6
ffffffffc020236c:	96d2                	add	a3,a3,s4
ffffffffc020236e:	06aa                	slli	a3,a3,0xa
ffffffffc0202370:	0116e693          	ori	a3,a3,17
ffffffffc0202374:	e014                	sd	a3,0(s0)
ffffffffc0202376:	0009b703          	ld	a4,0(s3)
ffffffffc020237a:	068a                	slli	a3,a3,0x2
ffffffffc020237c:	757d                	lui	a0,0xfffff
ffffffffc020237e:	8ee9                	and	a3,a3,a0
ffffffffc0202380:	00c6d793          	srli	a5,a3,0xc
ffffffffc0202384:	06e7f263          	bgeu	a5,a4,ffffffffc02023e8 <get_pte+0x1c4>
ffffffffc0202388:	000ab503          	ld	a0,0(s5)
ffffffffc020238c:	00c95913          	srli	s2,s2,0xc
ffffffffc0202390:	1ff97913          	andi	s2,s2,511
ffffffffc0202394:	96aa                	add	a3,a3,a0
ffffffffc0202396:	00391513          	slli	a0,s2,0x3
ffffffffc020239a:	9536                	add	a0,a0,a3
ffffffffc020239c:	70e2                	ld	ra,56(sp)
ffffffffc020239e:	7442                	ld	s0,48(sp)
ffffffffc02023a0:	74a2                	ld	s1,40(sp)
ffffffffc02023a2:	7902                	ld	s2,32(sp)
ffffffffc02023a4:	69e2                	ld	s3,24(sp)
ffffffffc02023a6:	6a42                	ld	s4,16(sp)
ffffffffc02023a8:	6aa2                	ld	s5,8(sp)
ffffffffc02023aa:	6b02                	ld	s6,0(sp)
ffffffffc02023ac:	6121                	addi	sp,sp,64
ffffffffc02023ae:	8082                	ret
ffffffffc02023b0:	4501                	li	a0,0
ffffffffc02023b2:	b7ed                	j	ffffffffc020239c <get_pte+0x178>
ffffffffc02023b4:	8bffe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02023b8:	00094797          	auipc	a5,0x94
ffffffffc02023bc:	4f87b783          	ld	a5,1272(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02023c0:	6f9c                	ld	a5,24(a5)
ffffffffc02023c2:	4505                	li	a0,1
ffffffffc02023c4:	9782                	jalr	a5
ffffffffc02023c6:	842a                	mv	s0,a0
ffffffffc02023c8:	8a5fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02023cc:	b56d                	j	ffffffffc0202276 <get_pte+0x52>
ffffffffc02023ce:	8a5fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02023d2:	00094797          	auipc	a5,0x94
ffffffffc02023d6:	4de7b783          	ld	a5,1246(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02023da:	6f9c                	ld	a5,24(a5)
ffffffffc02023dc:	4505                	li	a0,1
ffffffffc02023de:	9782                	jalr	a5
ffffffffc02023e0:	84aa                	mv	s1,a0
ffffffffc02023e2:	88bfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02023e6:	b781                	j	ffffffffc0202326 <get_pte+0x102>
ffffffffc02023e8:	0000a617          	auipc	a2,0xa
ffffffffc02023ec:	18060613          	addi	a2,a2,384 # ffffffffc020c568 <default_pmm_manager+0x38>
ffffffffc02023f0:	13200593          	li	a1,306
ffffffffc02023f4:	0000a517          	auipc	a0,0xa
ffffffffc02023f8:	28c50513          	addi	a0,a0,652 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02023fc:	8a2fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202400:	0000a617          	auipc	a2,0xa
ffffffffc0202404:	16860613          	addi	a2,a2,360 # ffffffffc020c568 <default_pmm_manager+0x38>
ffffffffc0202408:	12500593          	li	a1,293
ffffffffc020240c:	0000a517          	auipc	a0,0xa
ffffffffc0202410:	27450513          	addi	a0,a0,628 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0202414:	88afe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202418:	86aa                	mv	a3,a0
ffffffffc020241a:	0000a617          	auipc	a2,0xa
ffffffffc020241e:	14e60613          	addi	a2,a2,334 # ffffffffc020c568 <default_pmm_manager+0x38>
ffffffffc0202422:	12100593          	li	a1,289
ffffffffc0202426:	0000a517          	auipc	a0,0xa
ffffffffc020242a:	25a50513          	addi	a0,a0,602 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc020242e:	870fe0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202432:	86aa                	mv	a3,a0
ffffffffc0202434:	0000a617          	auipc	a2,0xa
ffffffffc0202438:	13460613          	addi	a2,a2,308 # ffffffffc020c568 <default_pmm_manager+0x38>
ffffffffc020243c:	12f00593          	li	a1,303
ffffffffc0202440:	0000a517          	auipc	a0,0xa
ffffffffc0202444:	24050513          	addi	a0,a0,576 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0202448:	856fe0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020244c <boot_map_segment>:
ffffffffc020244c:	6785                	lui	a5,0x1
ffffffffc020244e:	7139                	addi	sp,sp,-64
ffffffffc0202450:	00d5c833          	xor	a6,a1,a3
ffffffffc0202454:	17fd                	addi	a5,a5,-1
ffffffffc0202456:	fc06                	sd	ra,56(sp)
ffffffffc0202458:	f822                	sd	s0,48(sp)
ffffffffc020245a:	f426                	sd	s1,40(sp)
ffffffffc020245c:	f04a                	sd	s2,32(sp)
ffffffffc020245e:	ec4e                	sd	s3,24(sp)
ffffffffc0202460:	e852                	sd	s4,16(sp)
ffffffffc0202462:	e456                	sd	s5,8(sp)
ffffffffc0202464:	00f87833          	and	a6,a6,a5
ffffffffc0202468:	08081563          	bnez	a6,ffffffffc02024f2 <boot_map_segment+0xa6>
ffffffffc020246c:	00f5f4b3          	and	s1,a1,a5
ffffffffc0202470:	963e                	add	a2,a2,a5
ffffffffc0202472:	94b2                	add	s1,s1,a2
ffffffffc0202474:	797d                	lui	s2,0xfffff
ffffffffc0202476:	80b1                	srli	s1,s1,0xc
ffffffffc0202478:	0125f5b3          	and	a1,a1,s2
ffffffffc020247c:	0126f6b3          	and	a3,a3,s2
ffffffffc0202480:	c0a1                	beqz	s1,ffffffffc02024c0 <boot_map_segment+0x74>
ffffffffc0202482:	00176713          	ori	a4,a4,1
ffffffffc0202486:	04b2                	slli	s1,s1,0xc
ffffffffc0202488:	02071993          	slli	s3,a4,0x20
ffffffffc020248c:	8a2a                	mv	s4,a0
ffffffffc020248e:	842e                	mv	s0,a1
ffffffffc0202490:	94ae                	add	s1,s1,a1
ffffffffc0202492:	40b68933          	sub	s2,a3,a1
ffffffffc0202496:	0209d993          	srli	s3,s3,0x20
ffffffffc020249a:	6a85                	lui	s5,0x1
ffffffffc020249c:	4605                	li	a2,1
ffffffffc020249e:	85a2                	mv	a1,s0
ffffffffc02024a0:	8552                	mv	a0,s4
ffffffffc02024a2:	d83ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02024a6:	008907b3          	add	a5,s2,s0
ffffffffc02024aa:	c505                	beqz	a0,ffffffffc02024d2 <boot_map_segment+0x86>
ffffffffc02024ac:	83b1                	srli	a5,a5,0xc
ffffffffc02024ae:	07aa                	slli	a5,a5,0xa
ffffffffc02024b0:	0137e7b3          	or	a5,a5,s3
ffffffffc02024b4:	0017e793          	ori	a5,a5,1
ffffffffc02024b8:	e11c                	sd	a5,0(a0)
ffffffffc02024ba:	9456                	add	s0,s0,s5
ffffffffc02024bc:	fe8490e3          	bne	s1,s0,ffffffffc020249c <boot_map_segment+0x50>
ffffffffc02024c0:	70e2                	ld	ra,56(sp)
ffffffffc02024c2:	7442                	ld	s0,48(sp)
ffffffffc02024c4:	74a2                	ld	s1,40(sp)
ffffffffc02024c6:	7902                	ld	s2,32(sp)
ffffffffc02024c8:	69e2                	ld	s3,24(sp)
ffffffffc02024ca:	6a42                	ld	s4,16(sp)
ffffffffc02024cc:	6aa2                	ld	s5,8(sp)
ffffffffc02024ce:	6121                	addi	sp,sp,64
ffffffffc02024d0:	8082                	ret
ffffffffc02024d2:	0000a697          	auipc	a3,0xa
ffffffffc02024d6:	1d668693          	addi	a3,a3,470 # ffffffffc020c6a8 <default_pmm_manager+0x178>
ffffffffc02024da:	00009617          	auipc	a2,0x9
ffffffffc02024de:	56e60613          	addi	a2,a2,1390 # ffffffffc020ba48 <commands+0x210>
ffffffffc02024e2:	09c00593          	li	a1,156
ffffffffc02024e6:	0000a517          	auipc	a0,0xa
ffffffffc02024ea:	19a50513          	addi	a0,a0,410 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02024ee:	fb1fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02024f2:	0000a697          	auipc	a3,0xa
ffffffffc02024f6:	19e68693          	addi	a3,a3,414 # ffffffffc020c690 <default_pmm_manager+0x160>
ffffffffc02024fa:	00009617          	auipc	a2,0x9
ffffffffc02024fe:	54e60613          	addi	a2,a2,1358 # ffffffffc020ba48 <commands+0x210>
ffffffffc0202502:	09500593          	li	a1,149
ffffffffc0202506:	0000a517          	auipc	a0,0xa
ffffffffc020250a:	17a50513          	addi	a0,a0,378 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc020250e:	f91fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0202512 <get_page>:
ffffffffc0202512:	1141                	addi	sp,sp,-16
ffffffffc0202514:	e022                	sd	s0,0(sp)
ffffffffc0202516:	8432                	mv	s0,a2
ffffffffc0202518:	4601                	li	a2,0
ffffffffc020251a:	e406                	sd	ra,8(sp)
ffffffffc020251c:	d09ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202520:	c011                	beqz	s0,ffffffffc0202524 <get_page+0x12>
ffffffffc0202522:	e008                	sd	a0,0(s0)
ffffffffc0202524:	c511                	beqz	a0,ffffffffc0202530 <get_page+0x1e>
ffffffffc0202526:	611c                	ld	a5,0(a0)
ffffffffc0202528:	4501                	li	a0,0
ffffffffc020252a:	0017f713          	andi	a4,a5,1
ffffffffc020252e:	e709                	bnez	a4,ffffffffc0202538 <get_page+0x26>
ffffffffc0202530:	60a2                	ld	ra,8(sp)
ffffffffc0202532:	6402                	ld	s0,0(sp)
ffffffffc0202534:	0141                	addi	sp,sp,16
ffffffffc0202536:	8082                	ret
ffffffffc0202538:	078a                	slli	a5,a5,0x2
ffffffffc020253a:	83b1                	srli	a5,a5,0xc
ffffffffc020253c:	00094717          	auipc	a4,0x94
ffffffffc0202540:	36473703          	ld	a4,868(a4) # ffffffffc02968a0 <npage>
ffffffffc0202544:	00e7ff63          	bgeu	a5,a4,ffffffffc0202562 <get_page+0x50>
ffffffffc0202548:	60a2                	ld	ra,8(sp)
ffffffffc020254a:	6402                	ld	s0,0(sp)
ffffffffc020254c:	fff80537          	lui	a0,0xfff80
ffffffffc0202550:	97aa                	add	a5,a5,a0
ffffffffc0202552:	079a                	slli	a5,a5,0x6
ffffffffc0202554:	00094517          	auipc	a0,0x94
ffffffffc0202558:	35453503          	ld	a0,852(a0) # ffffffffc02968a8 <pages>
ffffffffc020255c:	953e                	add	a0,a0,a5
ffffffffc020255e:	0141                	addi	sp,sp,16
ffffffffc0202560:	8082                	ret
ffffffffc0202562:	bd3ff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc0202566 <unmap_range>:
ffffffffc0202566:	7159                	addi	sp,sp,-112
ffffffffc0202568:	00c5e7b3          	or	a5,a1,a2
ffffffffc020256c:	f486                	sd	ra,104(sp)
ffffffffc020256e:	f0a2                	sd	s0,96(sp)
ffffffffc0202570:	eca6                	sd	s1,88(sp)
ffffffffc0202572:	e8ca                	sd	s2,80(sp)
ffffffffc0202574:	e4ce                	sd	s3,72(sp)
ffffffffc0202576:	e0d2                	sd	s4,64(sp)
ffffffffc0202578:	fc56                	sd	s5,56(sp)
ffffffffc020257a:	f85a                	sd	s6,48(sp)
ffffffffc020257c:	f45e                	sd	s7,40(sp)
ffffffffc020257e:	f062                	sd	s8,32(sp)
ffffffffc0202580:	ec66                	sd	s9,24(sp)
ffffffffc0202582:	e86a                	sd	s10,16(sp)
ffffffffc0202584:	17d2                	slli	a5,a5,0x34
ffffffffc0202586:	e3ed                	bnez	a5,ffffffffc0202668 <unmap_range+0x102>
ffffffffc0202588:	002007b7          	lui	a5,0x200
ffffffffc020258c:	842e                	mv	s0,a1
ffffffffc020258e:	0ef5ed63          	bltu	a1,a5,ffffffffc0202688 <unmap_range+0x122>
ffffffffc0202592:	8932                	mv	s2,a2
ffffffffc0202594:	0ec5fa63          	bgeu	a1,a2,ffffffffc0202688 <unmap_range+0x122>
ffffffffc0202598:	4785                	li	a5,1
ffffffffc020259a:	07fe                	slli	a5,a5,0x1f
ffffffffc020259c:	0ec7e663          	bltu	a5,a2,ffffffffc0202688 <unmap_range+0x122>
ffffffffc02025a0:	89aa                	mv	s3,a0
ffffffffc02025a2:	6a05                	lui	s4,0x1
ffffffffc02025a4:	00094c97          	auipc	s9,0x94
ffffffffc02025a8:	2fcc8c93          	addi	s9,s9,764 # ffffffffc02968a0 <npage>
ffffffffc02025ac:	00094c17          	auipc	s8,0x94
ffffffffc02025b0:	2fcc0c13          	addi	s8,s8,764 # ffffffffc02968a8 <pages>
ffffffffc02025b4:	fff80bb7          	lui	s7,0xfff80
ffffffffc02025b8:	00094d17          	auipc	s10,0x94
ffffffffc02025bc:	2f8d0d13          	addi	s10,s10,760 # ffffffffc02968b0 <pmm_manager>
ffffffffc02025c0:	00200b37          	lui	s6,0x200
ffffffffc02025c4:	ffe00ab7          	lui	s5,0xffe00
ffffffffc02025c8:	4601                	li	a2,0
ffffffffc02025ca:	85a2                	mv	a1,s0
ffffffffc02025cc:	854e                	mv	a0,s3
ffffffffc02025ce:	c57ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02025d2:	84aa                	mv	s1,a0
ffffffffc02025d4:	cd29                	beqz	a0,ffffffffc020262e <unmap_range+0xc8>
ffffffffc02025d6:	611c                	ld	a5,0(a0)
ffffffffc02025d8:	e395                	bnez	a5,ffffffffc02025fc <unmap_range+0x96>
ffffffffc02025da:	9452                	add	s0,s0,s4
ffffffffc02025dc:	ff2466e3          	bltu	s0,s2,ffffffffc02025c8 <unmap_range+0x62>
ffffffffc02025e0:	70a6                	ld	ra,104(sp)
ffffffffc02025e2:	7406                	ld	s0,96(sp)
ffffffffc02025e4:	64e6                	ld	s1,88(sp)
ffffffffc02025e6:	6946                	ld	s2,80(sp)
ffffffffc02025e8:	69a6                	ld	s3,72(sp)
ffffffffc02025ea:	6a06                	ld	s4,64(sp)
ffffffffc02025ec:	7ae2                	ld	s5,56(sp)
ffffffffc02025ee:	7b42                	ld	s6,48(sp)
ffffffffc02025f0:	7ba2                	ld	s7,40(sp)
ffffffffc02025f2:	7c02                	ld	s8,32(sp)
ffffffffc02025f4:	6ce2                	ld	s9,24(sp)
ffffffffc02025f6:	6d42                	ld	s10,16(sp)
ffffffffc02025f8:	6165                	addi	sp,sp,112
ffffffffc02025fa:	8082                	ret
ffffffffc02025fc:	0017f713          	andi	a4,a5,1
ffffffffc0202600:	df69                	beqz	a4,ffffffffc02025da <unmap_range+0x74>
ffffffffc0202602:	000cb703          	ld	a4,0(s9)
ffffffffc0202606:	078a                	slli	a5,a5,0x2
ffffffffc0202608:	83b1                	srli	a5,a5,0xc
ffffffffc020260a:	08e7ff63          	bgeu	a5,a4,ffffffffc02026a8 <unmap_range+0x142>
ffffffffc020260e:	000c3503          	ld	a0,0(s8)
ffffffffc0202612:	97de                	add	a5,a5,s7
ffffffffc0202614:	079a                	slli	a5,a5,0x6
ffffffffc0202616:	953e                	add	a0,a0,a5
ffffffffc0202618:	411c                	lw	a5,0(a0)
ffffffffc020261a:	fff7871b          	addiw	a4,a5,-1
ffffffffc020261e:	c118                	sw	a4,0(a0)
ffffffffc0202620:	cf11                	beqz	a4,ffffffffc020263c <unmap_range+0xd6>
ffffffffc0202622:	0004b023          	sd	zero,0(s1)
ffffffffc0202626:	12040073          	sfence.vma	s0
ffffffffc020262a:	9452                	add	s0,s0,s4
ffffffffc020262c:	bf45                	j	ffffffffc02025dc <unmap_range+0x76>
ffffffffc020262e:	945a                	add	s0,s0,s6
ffffffffc0202630:	01547433          	and	s0,s0,s5
ffffffffc0202634:	d455                	beqz	s0,ffffffffc02025e0 <unmap_range+0x7a>
ffffffffc0202636:	f92469e3          	bltu	s0,s2,ffffffffc02025c8 <unmap_range+0x62>
ffffffffc020263a:	b75d                	j	ffffffffc02025e0 <unmap_range+0x7a>
ffffffffc020263c:	100027f3          	csrr	a5,sstatus
ffffffffc0202640:	8b89                	andi	a5,a5,2
ffffffffc0202642:	e799                	bnez	a5,ffffffffc0202650 <unmap_range+0xea>
ffffffffc0202644:	000d3783          	ld	a5,0(s10)
ffffffffc0202648:	4585                	li	a1,1
ffffffffc020264a:	739c                	ld	a5,32(a5)
ffffffffc020264c:	9782                	jalr	a5
ffffffffc020264e:	bfd1                	j	ffffffffc0202622 <unmap_range+0xbc>
ffffffffc0202650:	e42a                	sd	a0,8(sp)
ffffffffc0202652:	e20fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202656:	000d3783          	ld	a5,0(s10)
ffffffffc020265a:	6522                	ld	a0,8(sp)
ffffffffc020265c:	4585                	li	a1,1
ffffffffc020265e:	739c                	ld	a5,32(a5)
ffffffffc0202660:	9782                	jalr	a5
ffffffffc0202662:	e0afe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202666:	bf75                	j	ffffffffc0202622 <unmap_range+0xbc>
ffffffffc0202668:	0000a697          	auipc	a3,0xa
ffffffffc020266c:	05068693          	addi	a3,a3,80 # ffffffffc020c6b8 <default_pmm_manager+0x188>
ffffffffc0202670:	00009617          	auipc	a2,0x9
ffffffffc0202674:	3d860613          	addi	a2,a2,984 # ffffffffc020ba48 <commands+0x210>
ffffffffc0202678:	15a00593          	li	a1,346
ffffffffc020267c:	0000a517          	auipc	a0,0xa
ffffffffc0202680:	00450513          	addi	a0,a0,4 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0202684:	e1bfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202688:	0000a697          	auipc	a3,0xa
ffffffffc020268c:	06068693          	addi	a3,a3,96 # ffffffffc020c6e8 <default_pmm_manager+0x1b8>
ffffffffc0202690:	00009617          	auipc	a2,0x9
ffffffffc0202694:	3b860613          	addi	a2,a2,952 # ffffffffc020ba48 <commands+0x210>
ffffffffc0202698:	15b00593          	li	a1,347
ffffffffc020269c:	0000a517          	auipc	a0,0xa
ffffffffc02026a0:	fe450513          	addi	a0,a0,-28 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02026a4:	dfbfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02026a8:	a8dff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc02026ac <exit_range>:
ffffffffc02026ac:	7119                	addi	sp,sp,-128
ffffffffc02026ae:	00c5e7b3          	or	a5,a1,a2
ffffffffc02026b2:	fc86                	sd	ra,120(sp)
ffffffffc02026b4:	f8a2                	sd	s0,112(sp)
ffffffffc02026b6:	f4a6                	sd	s1,104(sp)
ffffffffc02026b8:	f0ca                	sd	s2,96(sp)
ffffffffc02026ba:	ecce                	sd	s3,88(sp)
ffffffffc02026bc:	e8d2                	sd	s4,80(sp)
ffffffffc02026be:	e4d6                	sd	s5,72(sp)
ffffffffc02026c0:	e0da                	sd	s6,64(sp)
ffffffffc02026c2:	fc5e                	sd	s7,56(sp)
ffffffffc02026c4:	f862                	sd	s8,48(sp)
ffffffffc02026c6:	f466                	sd	s9,40(sp)
ffffffffc02026c8:	f06a                	sd	s10,32(sp)
ffffffffc02026ca:	ec6e                	sd	s11,24(sp)
ffffffffc02026cc:	17d2                	slli	a5,a5,0x34
ffffffffc02026ce:	20079a63          	bnez	a5,ffffffffc02028e2 <exit_range+0x236>
ffffffffc02026d2:	002007b7          	lui	a5,0x200
ffffffffc02026d6:	24f5e463          	bltu	a1,a5,ffffffffc020291e <exit_range+0x272>
ffffffffc02026da:	8ab2                	mv	s5,a2
ffffffffc02026dc:	24c5f163          	bgeu	a1,a2,ffffffffc020291e <exit_range+0x272>
ffffffffc02026e0:	4785                	li	a5,1
ffffffffc02026e2:	07fe                	slli	a5,a5,0x1f
ffffffffc02026e4:	22c7ed63          	bltu	a5,a2,ffffffffc020291e <exit_range+0x272>
ffffffffc02026e8:	c00009b7          	lui	s3,0xc0000
ffffffffc02026ec:	0135f9b3          	and	s3,a1,s3
ffffffffc02026f0:	ffe00937          	lui	s2,0xffe00
ffffffffc02026f4:	400007b7          	lui	a5,0x40000
ffffffffc02026f8:	5cfd                	li	s9,-1
ffffffffc02026fa:	8c2a                	mv	s8,a0
ffffffffc02026fc:	0125f933          	and	s2,a1,s2
ffffffffc0202700:	99be                	add	s3,s3,a5
ffffffffc0202702:	00094d17          	auipc	s10,0x94
ffffffffc0202706:	19ed0d13          	addi	s10,s10,414 # ffffffffc02968a0 <npage>
ffffffffc020270a:	00ccdc93          	srli	s9,s9,0xc
ffffffffc020270e:	00094717          	auipc	a4,0x94
ffffffffc0202712:	19a70713          	addi	a4,a4,410 # ffffffffc02968a8 <pages>
ffffffffc0202716:	00094d97          	auipc	s11,0x94
ffffffffc020271a:	19ad8d93          	addi	s11,s11,410 # ffffffffc02968b0 <pmm_manager>
ffffffffc020271e:	c0000437          	lui	s0,0xc0000
ffffffffc0202722:	944e                	add	s0,s0,s3
ffffffffc0202724:	8079                	srli	s0,s0,0x1e
ffffffffc0202726:	1ff47413          	andi	s0,s0,511
ffffffffc020272a:	040e                	slli	s0,s0,0x3
ffffffffc020272c:	9462                	add	s0,s0,s8
ffffffffc020272e:	00043a03          	ld	s4,0(s0) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202732:	001a7793          	andi	a5,s4,1
ffffffffc0202736:	eb99                	bnez	a5,ffffffffc020274c <exit_range+0xa0>
ffffffffc0202738:	12098463          	beqz	s3,ffffffffc0202860 <exit_range+0x1b4>
ffffffffc020273c:	400007b7          	lui	a5,0x40000
ffffffffc0202740:	97ce                	add	a5,a5,s3
ffffffffc0202742:	894e                	mv	s2,s3
ffffffffc0202744:	1159fe63          	bgeu	s3,s5,ffffffffc0202860 <exit_range+0x1b4>
ffffffffc0202748:	89be                	mv	s3,a5
ffffffffc020274a:	bfd1                	j	ffffffffc020271e <exit_range+0x72>
ffffffffc020274c:	000d3783          	ld	a5,0(s10)
ffffffffc0202750:	0a0a                	slli	s4,s4,0x2
ffffffffc0202752:	00ca5a13          	srli	s4,s4,0xc
ffffffffc0202756:	1cfa7263          	bgeu	s4,a5,ffffffffc020291a <exit_range+0x26e>
ffffffffc020275a:	fff80637          	lui	a2,0xfff80
ffffffffc020275e:	9652                	add	a2,a2,s4
ffffffffc0202760:	000806b7          	lui	a3,0x80
ffffffffc0202764:	96b2                	add	a3,a3,a2
ffffffffc0202766:	0196f5b3          	and	a1,a3,s9
ffffffffc020276a:	061a                	slli	a2,a2,0x6
ffffffffc020276c:	06b2                	slli	a3,a3,0xc
ffffffffc020276e:	18f5fa63          	bgeu	a1,a5,ffffffffc0202902 <exit_range+0x256>
ffffffffc0202772:	00094817          	auipc	a6,0x94
ffffffffc0202776:	14680813          	addi	a6,a6,326 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020277a:	00083b03          	ld	s6,0(a6)
ffffffffc020277e:	4b85                	li	s7,1
ffffffffc0202780:	fff80e37          	lui	t3,0xfff80
ffffffffc0202784:	9b36                	add	s6,s6,a3
ffffffffc0202786:	00080337          	lui	t1,0x80
ffffffffc020278a:	6885                	lui	a7,0x1
ffffffffc020278c:	a819                	j	ffffffffc02027a2 <exit_range+0xf6>
ffffffffc020278e:	4b81                	li	s7,0
ffffffffc0202790:	002007b7          	lui	a5,0x200
ffffffffc0202794:	993e                	add	s2,s2,a5
ffffffffc0202796:	08090c63          	beqz	s2,ffffffffc020282e <exit_range+0x182>
ffffffffc020279a:	09397a63          	bgeu	s2,s3,ffffffffc020282e <exit_range+0x182>
ffffffffc020279e:	0f597063          	bgeu	s2,s5,ffffffffc020287e <exit_range+0x1d2>
ffffffffc02027a2:	01595493          	srli	s1,s2,0x15
ffffffffc02027a6:	1ff4f493          	andi	s1,s1,511
ffffffffc02027aa:	048e                	slli	s1,s1,0x3
ffffffffc02027ac:	94da                	add	s1,s1,s6
ffffffffc02027ae:	609c                	ld	a5,0(s1)
ffffffffc02027b0:	0017f693          	andi	a3,a5,1
ffffffffc02027b4:	dee9                	beqz	a3,ffffffffc020278e <exit_range+0xe2>
ffffffffc02027b6:	000d3583          	ld	a1,0(s10)
ffffffffc02027ba:	078a                	slli	a5,a5,0x2
ffffffffc02027bc:	83b1                	srli	a5,a5,0xc
ffffffffc02027be:	14b7fe63          	bgeu	a5,a1,ffffffffc020291a <exit_range+0x26e>
ffffffffc02027c2:	97f2                	add	a5,a5,t3
ffffffffc02027c4:	006786b3          	add	a3,a5,t1
ffffffffc02027c8:	0196feb3          	and	t4,a3,s9
ffffffffc02027cc:	00679513          	slli	a0,a5,0x6
ffffffffc02027d0:	06b2                	slli	a3,a3,0xc
ffffffffc02027d2:	12bef863          	bgeu	t4,a1,ffffffffc0202902 <exit_range+0x256>
ffffffffc02027d6:	00083783          	ld	a5,0(a6)
ffffffffc02027da:	96be                	add	a3,a3,a5
ffffffffc02027dc:	011685b3          	add	a1,a3,a7
ffffffffc02027e0:	629c                	ld	a5,0(a3)
ffffffffc02027e2:	8b85                	andi	a5,a5,1
ffffffffc02027e4:	f7d5                	bnez	a5,ffffffffc0202790 <exit_range+0xe4>
ffffffffc02027e6:	06a1                	addi	a3,a3,8
ffffffffc02027e8:	fed59ce3          	bne	a1,a3,ffffffffc02027e0 <exit_range+0x134>
ffffffffc02027ec:	631c                	ld	a5,0(a4)
ffffffffc02027ee:	953e                	add	a0,a0,a5
ffffffffc02027f0:	100027f3          	csrr	a5,sstatus
ffffffffc02027f4:	8b89                	andi	a5,a5,2
ffffffffc02027f6:	e7d9                	bnez	a5,ffffffffc0202884 <exit_range+0x1d8>
ffffffffc02027f8:	000db783          	ld	a5,0(s11)
ffffffffc02027fc:	4585                	li	a1,1
ffffffffc02027fe:	e032                	sd	a2,0(sp)
ffffffffc0202800:	739c                	ld	a5,32(a5)
ffffffffc0202802:	9782                	jalr	a5
ffffffffc0202804:	6602                	ld	a2,0(sp)
ffffffffc0202806:	00094817          	auipc	a6,0x94
ffffffffc020280a:	0b280813          	addi	a6,a6,178 # ffffffffc02968b8 <va_pa_offset>
ffffffffc020280e:	fff80e37          	lui	t3,0xfff80
ffffffffc0202812:	00080337          	lui	t1,0x80
ffffffffc0202816:	6885                	lui	a7,0x1
ffffffffc0202818:	00094717          	auipc	a4,0x94
ffffffffc020281c:	09070713          	addi	a4,a4,144 # ffffffffc02968a8 <pages>
ffffffffc0202820:	0004b023          	sd	zero,0(s1)
ffffffffc0202824:	002007b7          	lui	a5,0x200
ffffffffc0202828:	993e                	add	s2,s2,a5
ffffffffc020282a:	f60918e3          	bnez	s2,ffffffffc020279a <exit_range+0xee>
ffffffffc020282e:	f00b85e3          	beqz	s7,ffffffffc0202738 <exit_range+0x8c>
ffffffffc0202832:	000d3783          	ld	a5,0(s10)
ffffffffc0202836:	0efa7263          	bgeu	s4,a5,ffffffffc020291a <exit_range+0x26e>
ffffffffc020283a:	6308                	ld	a0,0(a4)
ffffffffc020283c:	9532                	add	a0,a0,a2
ffffffffc020283e:	100027f3          	csrr	a5,sstatus
ffffffffc0202842:	8b89                	andi	a5,a5,2
ffffffffc0202844:	efad                	bnez	a5,ffffffffc02028be <exit_range+0x212>
ffffffffc0202846:	000db783          	ld	a5,0(s11)
ffffffffc020284a:	4585                	li	a1,1
ffffffffc020284c:	739c                	ld	a5,32(a5)
ffffffffc020284e:	9782                	jalr	a5
ffffffffc0202850:	00094717          	auipc	a4,0x94
ffffffffc0202854:	05870713          	addi	a4,a4,88 # ffffffffc02968a8 <pages>
ffffffffc0202858:	00043023          	sd	zero,0(s0)
ffffffffc020285c:	ee0990e3          	bnez	s3,ffffffffc020273c <exit_range+0x90>
ffffffffc0202860:	70e6                	ld	ra,120(sp)
ffffffffc0202862:	7446                	ld	s0,112(sp)
ffffffffc0202864:	74a6                	ld	s1,104(sp)
ffffffffc0202866:	7906                	ld	s2,96(sp)
ffffffffc0202868:	69e6                	ld	s3,88(sp)
ffffffffc020286a:	6a46                	ld	s4,80(sp)
ffffffffc020286c:	6aa6                	ld	s5,72(sp)
ffffffffc020286e:	6b06                	ld	s6,64(sp)
ffffffffc0202870:	7be2                	ld	s7,56(sp)
ffffffffc0202872:	7c42                	ld	s8,48(sp)
ffffffffc0202874:	7ca2                	ld	s9,40(sp)
ffffffffc0202876:	7d02                	ld	s10,32(sp)
ffffffffc0202878:	6de2                	ld	s11,24(sp)
ffffffffc020287a:	6109                	addi	sp,sp,128
ffffffffc020287c:	8082                	ret
ffffffffc020287e:	ea0b8fe3          	beqz	s7,ffffffffc020273c <exit_range+0x90>
ffffffffc0202882:	bf45                	j	ffffffffc0202832 <exit_range+0x186>
ffffffffc0202884:	e032                	sd	a2,0(sp)
ffffffffc0202886:	e42a                	sd	a0,8(sp)
ffffffffc0202888:	beafe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020288c:	000db783          	ld	a5,0(s11)
ffffffffc0202890:	6522                	ld	a0,8(sp)
ffffffffc0202892:	4585                	li	a1,1
ffffffffc0202894:	739c                	ld	a5,32(a5)
ffffffffc0202896:	9782                	jalr	a5
ffffffffc0202898:	bd4fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020289c:	6602                	ld	a2,0(sp)
ffffffffc020289e:	00094717          	auipc	a4,0x94
ffffffffc02028a2:	00a70713          	addi	a4,a4,10 # ffffffffc02968a8 <pages>
ffffffffc02028a6:	6885                	lui	a7,0x1
ffffffffc02028a8:	00080337          	lui	t1,0x80
ffffffffc02028ac:	fff80e37          	lui	t3,0xfff80
ffffffffc02028b0:	00094817          	auipc	a6,0x94
ffffffffc02028b4:	00880813          	addi	a6,a6,8 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02028b8:	0004b023          	sd	zero,0(s1)
ffffffffc02028bc:	b7a5                	j	ffffffffc0202824 <exit_range+0x178>
ffffffffc02028be:	e02a                	sd	a0,0(sp)
ffffffffc02028c0:	bb2fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02028c4:	000db783          	ld	a5,0(s11)
ffffffffc02028c8:	6502                	ld	a0,0(sp)
ffffffffc02028ca:	4585                	li	a1,1
ffffffffc02028cc:	739c                	ld	a5,32(a5)
ffffffffc02028ce:	9782                	jalr	a5
ffffffffc02028d0:	b9cfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02028d4:	00094717          	auipc	a4,0x94
ffffffffc02028d8:	fd470713          	addi	a4,a4,-44 # ffffffffc02968a8 <pages>
ffffffffc02028dc:	00043023          	sd	zero,0(s0)
ffffffffc02028e0:	bfb5                	j	ffffffffc020285c <exit_range+0x1b0>
ffffffffc02028e2:	0000a697          	auipc	a3,0xa
ffffffffc02028e6:	dd668693          	addi	a3,a3,-554 # ffffffffc020c6b8 <default_pmm_manager+0x188>
ffffffffc02028ea:	00009617          	auipc	a2,0x9
ffffffffc02028ee:	15e60613          	addi	a2,a2,350 # ffffffffc020ba48 <commands+0x210>
ffffffffc02028f2:	16f00593          	li	a1,367
ffffffffc02028f6:	0000a517          	auipc	a0,0xa
ffffffffc02028fa:	d8a50513          	addi	a0,a0,-630 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02028fe:	ba1fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0202902:	0000a617          	auipc	a2,0xa
ffffffffc0202906:	c6660613          	addi	a2,a2,-922 # ffffffffc020c568 <default_pmm_manager+0x38>
ffffffffc020290a:	07100593          	li	a1,113
ffffffffc020290e:	0000a517          	auipc	a0,0xa
ffffffffc0202912:	c8250513          	addi	a0,a0,-894 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc0202916:	b89fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020291a:	81bff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>
ffffffffc020291e:	0000a697          	auipc	a3,0xa
ffffffffc0202922:	dca68693          	addi	a3,a3,-566 # ffffffffc020c6e8 <default_pmm_manager+0x1b8>
ffffffffc0202926:	00009617          	auipc	a2,0x9
ffffffffc020292a:	12260613          	addi	a2,a2,290 # ffffffffc020ba48 <commands+0x210>
ffffffffc020292e:	17000593          	li	a1,368
ffffffffc0202932:	0000a517          	auipc	a0,0xa
ffffffffc0202936:	d4e50513          	addi	a0,a0,-690 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc020293a:	b65fd0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020293e <page_remove>:
ffffffffc020293e:	7179                	addi	sp,sp,-48
ffffffffc0202940:	4601                	li	a2,0
ffffffffc0202942:	ec26                	sd	s1,24(sp)
ffffffffc0202944:	f406                	sd	ra,40(sp)
ffffffffc0202946:	f022                	sd	s0,32(sp)
ffffffffc0202948:	84ae                	mv	s1,a1
ffffffffc020294a:	8dbff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc020294e:	c511                	beqz	a0,ffffffffc020295a <page_remove+0x1c>
ffffffffc0202950:	611c                	ld	a5,0(a0)
ffffffffc0202952:	842a                	mv	s0,a0
ffffffffc0202954:	0017f713          	andi	a4,a5,1
ffffffffc0202958:	e711                	bnez	a4,ffffffffc0202964 <page_remove+0x26>
ffffffffc020295a:	70a2                	ld	ra,40(sp)
ffffffffc020295c:	7402                	ld	s0,32(sp)
ffffffffc020295e:	64e2                	ld	s1,24(sp)
ffffffffc0202960:	6145                	addi	sp,sp,48
ffffffffc0202962:	8082                	ret
ffffffffc0202964:	078a                	slli	a5,a5,0x2
ffffffffc0202966:	83b1                	srli	a5,a5,0xc
ffffffffc0202968:	00094717          	auipc	a4,0x94
ffffffffc020296c:	f3873703          	ld	a4,-200(a4) # ffffffffc02968a0 <npage>
ffffffffc0202970:	06e7f363          	bgeu	a5,a4,ffffffffc02029d6 <page_remove+0x98>
ffffffffc0202974:	fff80537          	lui	a0,0xfff80
ffffffffc0202978:	97aa                	add	a5,a5,a0
ffffffffc020297a:	079a                	slli	a5,a5,0x6
ffffffffc020297c:	00094517          	auipc	a0,0x94
ffffffffc0202980:	f2c53503          	ld	a0,-212(a0) # ffffffffc02968a8 <pages>
ffffffffc0202984:	953e                	add	a0,a0,a5
ffffffffc0202986:	411c                	lw	a5,0(a0)
ffffffffc0202988:	fff7871b          	addiw	a4,a5,-1
ffffffffc020298c:	c118                	sw	a4,0(a0)
ffffffffc020298e:	cb11                	beqz	a4,ffffffffc02029a2 <page_remove+0x64>
ffffffffc0202990:	00043023          	sd	zero,0(s0)
ffffffffc0202994:	12048073          	sfence.vma	s1
ffffffffc0202998:	70a2                	ld	ra,40(sp)
ffffffffc020299a:	7402                	ld	s0,32(sp)
ffffffffc020299c:	64e2                	ld	s1,24(sp)
ffffffffc020299e:	6145                	addi	sp,sp,48
ffffffffc02029a0:	8082                	ret
ffffffffc02029a2:	100027f3          	csrr	a5,sstatus
ffffffffc02029a6:	8b89                	andi	a5,a5,2
ffffffffc02029a8:	eb89                	bnez	a5,ffffffffc02029ba <page_remove+0x7c>
ffffffffc02029aa:	00094797          	auipc	a5,0x94
ffffffffc02029ae:	f067b783          	ld	a5,-250(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02029b2:	739c                	ld	a5,32(a5)
ffffffffc02029b4:	4585                	li	a1,1
ffffffffc02029b6:	9782                	jalr	a5
ffffffffc02029b8:	bfe1                	j	ffffffffc0202990 <page_remove+0x52>
ffffffffc02029ba:	e42a                	sd	a0,8(sp)
ffffffffc02029bc:	ab6fe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02029c0:	00094797          	auipc	a5,0x94
ffffffffc02029c4:	ef07b783          	ld	a5,-272(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc02029c8:	739c                	ld	a5,32(a5)
ffffffffc02029ca:	6522                	ld	a0,8(sp)
ffffffffc02029cc:	4585                	li	a1,1
ffffffffc02029ce:	9782                	jalr	a5
ffffffffc02029d0:	a9cfe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02029d4:	bf75                	j	ffffffffc0202990 <page_remove+0x52>
ffffffffc02029d6:	f5eff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc02029da <page_insert>:
ffffffffc02029da:	7139                	addi	sp,sp,-64
ffffffffc02029dc:	e852                	sd	s4,16(sp)
ffffffffc02029de:	8a32                	mv	s4,a2
ffffffffc02029e0:	f822                	sd	s0,48(sp)
ffffffffc02029e2:	4605                	li	a2,1
ffffffffc02029e4:	842e                	mv	s0,a1
ffffffffc02029e6:	85d2                	mv	a1,s4
ffffffffc02029e8:	f426                	sd	s1,40(sp)
ffffffffc02029ea:	fc06                	sd	ra,56(sp)
ffffffffc02029ec:	f04a                	sd	s2,32(sp)
ffffffffc02029ee:	ec4e                	sd	s3,24(sp)
ffffffffc02029f0:	e456                	sd	s5,8(sp)
ffffffffc02029f2:	84b6                	mv	s1,a3
ffffffffc02029f4:	831ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc02029f8:	c961                	beqz	a0,ffffffffc0202ac8 <page_insert+0xee>
ffffffffc02029fa:	4014                	lw	a3,0(s0)
ffffffffc02029fc:	611c                	ld	a5,0(a0)
ffffffffc02029fe:	89aa                	mv	s3,a0
ffffffffc0202a00:	0016871b          	addiw	a4,a3,1
ffffffffc0202a04:	c018                	sw	a4,0(s0)
ffffffffc0202a06:	0017f713          	andi	a4,a5,1
ffffffffc0202a0a:	ef05                	bnez	a4,ffffffffc0202a42 <page_insert+0x68>
ffffffffc0202a0c:	00094717          	auipc	a4,0x94
ffffffffc0202a10:	e9c73703          	ld	a4,-356(a4) # ffffffffc02968a8 <pages>
ffffffffc0202a14:	8c19                	sub	s0,s0,a4
ffffffffc0202a16:	000807b7          	lui	a5,0x80
ffffffffc0202a1a:	8419                	srai	s0,s0,0x6
ffffffffc0202a1c:	943e                	add	s0,s0,a5
ffffffffc0202a1e:	042a                	slli	s0,s0,0xa
ffffffffc0202a20:	8cc1                	or	s1,s1,s0
ffffffffc0202a22:	0014e493          	ori	s1,s1,1
ffffffffc0202a26:	0099b023          	sd	s1,0(s3) # ffffffffc0000000 <_binary_bin_sfs_img_size+0xffffffffbff8ad00>
ffffffffc0202a2a:	120a0073          	sfence.vma	s4
ffffffffc0202a2e:	4501                	li	a0,0
ffffffffc0202a30:	70e2                	ld	ra,56(sp)
ffffffffc0202a32:	7442                	ld	s0,48(sp)
ffffffffc0202a34:	74a2                	ld	s1,40(sp)
ffffffffc0202a36:	7902                	ld	s2,32(sp)
ffffffffc0202a38:	69e2                	ld	s3,24(sp)
ffffffffc0202a3a:	6a42                	ld	s4,16(sp)
ffffffffc0202a3c:	6aa2                	ld	s5,8(sp)
ffffffffc0202a3e:	6121                	addi	sp,sp,64
ffffffffc0202a40:	8082                	ret
ffffffffc0202a42:	078a                	slli	a5,a5,0x2
ffffffffc0202a44:	83b1                	srli	a5,a5,0xc
ffffffffc0202a46:	00094717          	auipc	a4,0x94
ffffffffc0202a4a:	e5a73703          	ld	a4,-422(a4) # ffffffffc02968a0 <npage>
ffffffffc0202a4e:	06e7ff63          	bgeu	a5,a4,ffffffffc0202acc <page_insert+0xf2>
ffffffffc0202a52:	00094a97          	auipc	s5,0x94
ffffffffc0202a56:	e56a8a93          	addi	s5,s5,-426 # ffffffffc02968a8 <pages>
ffffffffc0202a5a:	000ab703          	ld	a4,0(s5)
ffffffffc0202a5e:	fff80937          	lui	s2,0xfff80
ffffffffc0202a62:	993e                	add	s2,s2,a5
ffffffffc0202a64:	091a                	slli	s2,s2,0x6
ffffffffc0202a66:	993a                	add	s2,s2,a4
ffffffffc0202a68:	01240c63          	beq	s0,s2,ffffffffc0202a80 <page_insert+0xa6>
ffffffffc0202a6c:	00092783          	lw	a5,0(s2) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc0202a70:	fff7869b          	addiw	a3,a5,-1
ffffffffc0202a74:	00d92023          	sw	a3,0(s2)
ffffffffc0202a78:	c691                	beqz	a3,ffffffffc0202a84 <page_insert+0xaa>
ffffffffc0202a7a:	120a0073          	sfence.vma	s4
ffffffffc0202a7e:	bf59                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202a80:	c014                	sw	a3,0(s0)
ffffffffc0202a82:	bf49                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202a84:	100027f3          	csrr	a5,sstatus
ffffffffc0202a88:	8b89                	andi	a5,a5,2
ffffffffc0202a8a:	ef91                	bnez	a5,ffffffffc0202aa6 <page_insert+0xcc>
ffffffffc0202a8c:	00094797          	auipc	a5,0x94
ffffffffc0202a90:	e247b783          	ld	a5,-476(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202a94:	739c                	ld	a5,32(a5)
ffffffffc0202a96:	4585                	li	a1,1
ffffffffc0202a98:	854a                	mv	a0,s2
ffffffffc0202a9a:	9782                	jalr	a5
ffffffffc0202a9c:	000ab703          	ld	a4,0(s5)
ffffffffc0202aa0:	120a0073          	sfence.vma	s4
ffffffffc0202aa4:	bf85                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202aa6:	9ccfe0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0202aaa:	00094797          	auipc	a5,0x94
ffffffffc0202aae:	e067b783          	ld	a5,-506(a5) # ffffffffc02968b0 <pmm_manager>
ffffffffc0202ab2:	739c                	ld	a5,32(a5)
ffffffffc0202ab4:	4585                	li	a1,1
ffffffffc0202ab6:	854a                	mv	a0,s2
ffffffffc0202ab8:	9782                	jalr	a5
ffffffffc0202aba:	9b2fe0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0202abe:	000ab703          	ld	a4,0(s5)
ffffffffc0202ac2:	120a0073          	sfence.vma	s4
ffffffffc0202ac6:	b7b9                	j	ffffffffc0202a14 <page_insert+0x3a>
ffffffffc0202ac8:	5571                	li	a0,-4
ffffffffc0202aca:	b79d                	j	ffffffffc0202a30 <page_insert+0x56>
ffffffffc0202acc:	e68ff0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>

ffffffffc0202ad0 <pmm_init>:
ffffffffc0202ad0:	0000a797          	auipc	a5,0xa
ffffffffc0202ad4:	a6078793          	addi	a5,a5,-1440 # ffffffffc020c530 <default_pmm_manager>
ffffffffc0202ad8:	638c                	ld	a1,0(a5)
ffffffffc0202ada:	7159                	addi	sp,sp,-112
ffffffffc0202adc:	f85a                	sd	s6,48(sp)
ffffffffc0202ade:	0000a517          	auipc	a0,0xa
ffffffffc0202ae2:	c2250513          	addi	a0,a0,-990 # ffffffffc020c700 <default_pmm_manager+0x1d0>
ffffffffc0202ae6:	00094b17          	auipc	s6,0x94
ffffffffc0202aea:	dcab0b13          	addi	s6,s6,-566 # ffffffffc02968b0 <pmm_manager>
ffffffffc0202aee:	f486                	sd	ra,104(sp)
ffffffffc0202af0:	e8ca                	sd	s2,80(sp)
ffffffffc0202af2:	e4ce                	sd	s3,72(sp)
ffffffffc0202af4:	f0a2                	sd	s0,96(sp)
ffffffffc0202af6:	eca6                	sd	s1,88(sp)
ffffffffc0202af8:	e0d2                	sd	s4,64(sp)
ffffffffc0202afa:	fc56                	sd	s5,56(sp)
ffffffffc0202afc:	f45e                	sd	s7,40(sp)
ffffffffc0202afe:	f062                	sd	s8,32(sp)
ffffffffc0202b00:	ec66                	sd	s9,24(sp)
ffffffffc0202b02:	00fb3023          	sd	a5,0(s6)
ffffffffc0202b06:	ea0fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b0a:	000b3783          	ld	a5,0(s6)
ffffffffc0202b0e:	00094997          	auipc	s3,0x94
ffffffffc0202b12:	daa98993          	addi	s3,s3,-598 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0202b16:	679c                	ld	a5,8(a5)
ffffffffc0202b18:	9782                	jalr	a5
ffffffffc0202b1a:	57f5                	li	a5,-3
ffffffffc0202b1c:	07fa                	slli	a5,a5,0x1e
ffffffffc0202b1e:	00f9b023          	sd	a5,0(s3)
ffffffffc0202b22:	f27fd0ef          	jal	ra,ffffffffc0200a48 <get_memory_base>
ffffffffc0202b26:	892a                	mv	s2,a0
ffffffffc0202b28:	f2bfd0ef          	jal	ra,ffffffffc0200a52 <get_memory_size>
ffffffffc0202b2c:	280502e3          	beqz	a0,ffffffffc02035b0 <pmm_init+0xae0>
ffffffffc0202b30:	84aa                	mv	s1,a0
ffffffffc0202b32:	0000a517          	auipc	a0,0xa
ffffffffc0202b36:	c0650513          	addi	a0,a0,-1018 # ffffffffc020c738 <default_pmm_manager+0x208>
ffffffffc0202b3a:	e6cfd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b3e:	00990433          	add	s0,s2,s1
ffffffffc0202b42:	fff40693          	addi	a3,s0,-1
ffffffffc0202b46:	864a                	mv	a2,s2
ffffffffc0202b48:	85a6                	mv	a1,s1
ffffffffc0202b4a:	0000a517          	auipc	a0,0xa
ffffffffc0202b4e:	c0650513          	addi	a0,a0,-1018 # ffffffffc020c750 <default_pmm_manager+0x220>
ffffffffc0202b52:	e54fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202b56:	c8000737          	lui	a4,0xc8000
ffffffffc0202b5a:	87a2                	mv	a5,s0
ffffffffc0202b5c:	5e876e63          	bltu	a4,s0,ffffffffc0203158 <pmm_init+0x688>
ffffffffc0202b60:	757d                	lui	a0,0xfffff
ffffffffc0202b62:	00095617          	auipc	a2,0x95
ffffffffc0202b66:	dad60613          	addi	a2,a2,-595 # ffffffffc029790f <end+0xfff>
ffffffffc0202b6a:	8e69                	and	a2,a2,a0
ffffffffc0202b6c:	00094497          	auipc	s1,0x94
ffffffffc0202b70:	d3448493          	addi	s1,s1,-716 # ffffffffc02968a0 <npage>
ffffffffc0202b74:	00c7d513          	srli	a0,a5,0xc
ffffffffc0202b78:	00094b97          	auipc	s7,0x94
ffffffffc0202b7c:	d30b8b93          	addi	s7,s7,-720 # ffffffffc02968a8 <pages>
ffffffffc0202b80:	e088                	sd	a0,0(s1)
ffffffffc0202b82:	00cbb023          	sd	a2,0(s7)
ffffffffc0202b86:	000807b7          	lui	a5,0x80
ffffffffc0202b8a:	86b2                	mv	a3,a2
ffffffffc0202b8c:	02f50863          	beq	a0,a5,ffffffffc0202bbc <pmm_init+0xec>
ffffffffc0202b90:	4781                	li	a5,0
ffffffffc0202b92:	4585                	li	a1,1
ffffffffc0202b94:	fff806b7          	lui	a3,0xfff80
ffffffffc0202b98:	00679513          	slli	a0,a5,0x6
ffffffffc0202b9c:	9532                	add	a0,a0,a2
ffffffffc0202b9e:	00850713          	addi	a4,a0,8 # fffffffffffff008 <end+0x3fd686f8>
ffffffffc0202ba2:	40b7302f          	amoor.d	zero,a1,(a4)
ffffffffc0202ba6:	6088                	ld	a0,0(s1)
ffffffffc0202ba8:	0785                	addi	a5,a5,1
ffffffffc0202baa:	000bb603          	ld	a2,0(s7)
ffffffffc0202bae:	00d50733          	add	a4,a0,a3
ffffffffc0202bb2:	fee7e3e3          	bltu	a5,a4,ffffffffc0202b98 <pmm_init+0xc8>
ffffffffc0202bb6:	071a                	slli	a4,a4,0x6
ffffffffc0202bb8:	00e606b3          	add	a3,a2,a4
ffffffffc0202bbc:	c02007b7          	lui	a5,0xc0200
ffffffffc0202bc0:	3af6eae3          	bltu	a3,a5,ffffffffc0203774 <pmm_init+0xca4>
ffffffffc0202bc4:	0009b583          	ld	a1,0(s3)
ffffffffc0202bc8:	77fd                	lui	a5,0xfffff
ffffffffc0202bca:	8c7d                	and	s0,s0,a5
ffffffffc0202bcc:	8e8d                	sub	a3,a3,a1
ffffffffc0202bce:	5e86e363          	bltu	a3,s0,ffffffffc02031b4 <pmm_init+0x6e4>
ffffffffc0202bd2:	0000a517          	auipc	a0,0xa
ffffffffc0202bd6:	ba650513          	addi	a0,a0,-1114 # ffffffffc020c778 <default_pmm_manager+0x248>
ffffffffc0202bda:	dccfd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202bde:	000b3783          	ld	a5,0(s6)
ffffffffc0202be2:	7b9c                	ld	a5,48(a5)
ffffffffc0202be4:	9782                	jalr	a5
ffffffffc0202be6:	0000a517          	auipc	a0,0xa
ffffffffc0202bea:	baa50513          	addi	a0,a0,-1110 # ffffffffc020c790 <default_pmm_manager+0x260>
ffffffffc0202bee:	db8fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202bf2:	100027f3          	csrr	a5,sstatus
ffffffffc0202bf6:	8b89                	andi	a5,a5,2
ffffffffc0202bf8:	5a079363          	bnez	a5,ffffffffc020319e <pmm_init+0x6ce>
ffffffffc0202bfc:	000b3783          	ld	a5,0(s6)
ffffffffc0202c00:	4505                	li	a0,1
ffffffffc0202c02:	6f9c                	ld	a5,24(a5)
ffffffffc0202c04:	9782                	jalr	a5
ffffffffc0202c06:	842a                	mv	s0,a0
ffffffffc0202c08:	180408e3          	beqz	s0,ffffffffc0203598 <pmm_init+0xac8>
ffffffffc0202c0c:	000bb683          	ld	a3,0(s7)
ffffffffc0202c10:	5a7d                	li	s4,-1
ffffffffc0202c12:	6098                	ld	a4,0(s1)
ffffffffc0202c14:	40d406b3          	sub	a3,s0,a3
ffffffffc0202c18:	8699                	srai	a3,a3,0x6
ffffffffc0202c1a:	00080437          	lui	s0,0x80
ffffffffc0202c1e:	96a2                	add	a3,a3,s0
ffffffffc0202c20:	00ca5793          	srli	a5,s4,0xc
ffffffffc0202c24:	8ff5                	and	a5,a5,a3
ffffffffc0202c26:	06b2                	slli	a3,a3,0xc
ffffffffc0202c28:	30e7fde3          	bgeu	a5,a4,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0202c2c:	0009b403          	ld	s0,0(s3)
ffffffffc0202c30:	6605                	lui	a2,0x1
ffffffffc0202c32:	4581                	li	a1,0
ffffffffc0202c34:	9436                	add	s0,s0,a3
ffffffffc0202c36:	8522                	mv	a0,s0
ffffffffc0202c38:	12f080ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc0202c3c:	0009b683          	ld	a3,0(s3)
ffffffffc0202c40:	77fd                	lui	a5,0xfffff
ffffffffc0202c42:	0000a917          	auipc	s2,0xa
ffffffffc0202c46:	98d90913          	addi	s2,s2,-1651 # ffffffffc020c5cf <default_pmm_manager+0x9f>
ffffffffc0202c4a:	00f97933          	and	s2,s2,a5
ffffffffc0202c4e:	c0200ab7          	lui	s5,0xc0200
ffffffffc0202c52:	3fe00637          	lui	a2,0x3fe00
ffffffffc0202c56:	964a                	add	a2,a2,s2
ffffffffc0202c58:	4729                	li	a4,10
ffffffffc0202c5a:	40da86b3          	sub	a3,s5,a3
ffffffffc0202c5e:	c02005b7          	lui	a1,0xc0200
ffffffffc0202c62:	8522                	mv	a0,s0
ffffffffc0202c64:	fe8ff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0202c68:	c8000637          	lui	a2,0xc8000
ffffffffc0202c6c:	41260633          	sub	a2,a2,s2
ffffffffc0202c70:	3f596ce3          	bltu	s2,s5,ffffffffc0203868 <pmm_init+0xd98>
ffffffffc0202c74:	0009b683          	ld	a3,0(s3)
ffffffffc0202c78:	85ca                	mv	a1,s2
ffffffffc0202c7a:	4719                	li	a4,6
ffffffffc0202c7c:	40d906b3          	sub	a3,s2,a3
ffffffffc0202c80:	8522                	mv	a0,s0
ffffffffc0202c82:	00094917          	auipc	s2,0x94
ffffffffc0202c86:	c1690913          	addi	s2,s2,-1002 # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0202c8a:	fc2ff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0202c8e:	00893023          	sd	s0,0(s2)
ffffffffc0202c92:	2d5464e3          	bltu	s0,s5,ffffffffc020375a <pmm_init+0xc8a>
ffffffffc0202c96:	0009b783          	ld	a5,0(s3)
ffffffffc0202c9a:	1a7e                	slli	s4,s4,0x3f
ffffffffc0202c9c:	8c1d                	sub	s0,s0,a5
ffffffffc0202c9e:	00c45793          	srli	a5,s0,0xc
ffffffffc0202ca2:	00094717          	auipc	a4,0x94
ffffffffc0202ca6:	be873723          	sd	s0,-1042(a4) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0202caa:	0147ea33          	or	s4,a5,s4
ffffffffc0202cae:	180a1073          	csrw	satp,s4
ffffffffc0202cb2:	12000073          	sfence.vma
ffffffffc0202cb6:	0000a517          	auipc	a0,0xa
ffffffffc0202cba:	b1a50513          	addi	a0,a0,-1254 # ffffffffc020c7d0 <default_pmm_manager+0x2a0>
ffffffffc0202cbe:	ce8fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202cc2:	0000e717          	auipc	a4,0xe
ffffffffc0202cc6:	33e70713          	addi	a4,a4,830 # ffffffffc0211000 <bootstack>
ffffffffc0202cca:	0000e797          	auipc	a5,0xe
ffffffffc0202cce:	33678793          	addi	a5,a5,822 # ffffffffc0211000 <bootstack>
ffffffffc0202cd2:	5cf70d63          	beq	a4,a5,ffffffffc02032ac <pmm_init+0x7dc>
ffffffffc0202cd6:	100027f3          	csrr	a5,sstatus
ffffffffc0202cda:	8b89                	andi	a5,a5,2
ffffffffc0202cdc:	4a079763          	bnez	a5,ffffffffc020318a <pmm_init+0x6ba>
ffffffffc0202ce0:	000b3783          	ld	a5,0(s6)
ffffffffc0202ce4:	779c                	ld	a5,40(a5)
ffffffffc0202ce6:	9782                	jalr	a5
ffffffffc0202ce8:	842a                	mv	s0,a0
ffffffffc0202cea:	6098                	ld	a4,0(s1)
ffffffffc0202cec:	c80007b7          	lui	a5,0xc8000
ffffffffc0202cf0:	83b1                	srli	a5,a5,0xc
ffffffffc0202cf2:	08e7e3e3          	bltu	a5,a4,ffffffffc0203578 <pmm_init+0xaa8>
ffffffffc0202cf6:	00093503          	ld	a0,0(s2)
ffffffffc0202cfa:	04050fe3          	beqz	a0,ffffffffc0203558 <pmm_init+0xa88>
ffffffffc0202cfe:	03451793          	slli	a5,a0,0x34
ffffffffc0202d02:	04079be3          	bnez	a5,ffffffffc0203558 <pmm_init+0xa88>
ffffffffc0202d06:	4601                	li	a2,0
ffffffffc0202d08:	4581                	li	a1,0
ffffffffc0202d0a:	809ff0ef          	jal	ra,ffffffffc0202512 <get_page>
ffffffffc0202d0e:	2e0511e3          	bnez	a0,ffffffffc02037f0 <pmm_init+0xd20>
ffffffffc0202d12:	100027f3          	csrr	a5,sstatus
ffffffffc0202d16:	8b89                	andi	a5,a5,2
ffffffffc0202d18:	44079e63          	bnez	a5,ffffffffc0203174 <pmm_init+0x6a4>
ffffffffc0202d1c:	000b3783          	ld	a5,0(s6)
ffffffffc0202d20:	4505                	li	a0,1
ffffffffc0202d22:	6f9c                	ld	a5,24(a5)
ffffffffc0202d24:	9782                	jalr	a5
ffffffffc0202d26:	8a2a                	mv	s4,a0
ffffffffc0202d28:	00093503          	ld	a0,0(s2)
ffffffffc0202d2c:	4681                	li	a3,0
ffffffffc0202d2e:	4601                	li	a2,0
ffffffffc0202d30:	85d2                	mv	a1,s4
ffffffffc0202d32:	ca9ff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202d36:	26051be3          	bnez	a0,ffffffffc02037ac <pmm_init+0xcdc>
ffffffffc0202d3a:	00093503          	ld	a0,0(s2)
ffffffffc0202d3e:	4601                	li	a2,0
ffffffffc0202d40:	4581                	li	a1,0
ffffffffc0202d42:	ce2ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202d46:	280505e3          	beqz	a0,ffffffffc02037d0 <pmm_init+0xd00>
ffffffffc0202d4a:	611c                	ld	a5,0(a0)
ffffffffc0202d4c:	0017f713          	andi	a4,a5,1
ffffffffc0202d50:	26070ee3          	beqz	a4,ffffffffc02037cc <pmm_init+0xcfc>
ffffffffc0202d54:	6098                	ld	a4,0(s1)
ffffffffc0202d56:	078a                	slli	a5,a5,0x2
ffffffffc0202d58:	83b1                	srli	a5,a5,0xc
ffffffffc0202d5a:	62e7f363          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202d5e:	000bb683          	ld	a3,0(s7)
ffffffffc0202d62:	fff80637          	lui	a2,0xfff80
ffffffffc0202d66:	97b2                	add	a5,a5,a2
ffffffffc0202d68:	079a                	slli	a5,a5,0x6
ffffffffc0202d6a:	97b6                	add	a5,a5,a3
ffffffffc0202d6c:	2afa12e3          	bne	s4,a5,ffffffffc0203810 <pmm_init+0xd40>
ffffffffc0202d70:	000a2683          	lw	a3,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202d74:	4785                	li	a5,1
ffffffffc0202d76:	2cf699e3          	bne	a3,a5,ffffffffc0203848 <pmm_init+0xd78>
ffffffffc0202d7a:	00093503          	ld	a0,0(s2)
ffffffffc0202d7e:	77fd                	lui	a5,0xfffff
ffffffffc0202d80:	6114                	ld	a3,0(a0)
ffffffffc0202d82:	068a                	slli	a3,a3,0x2
ffffffffc0202d84:	8efd                	and	a3,a3,a5
ffffffffc0202d86:	00c6d613          	srli	a2,a3,0xc
ffffffffc0202d8a:	2ae673e3          	bgeu	a2,a4,ffffffffc0203830 <pmm_init+0xd60>
ffffffffc0202d8e:	0009bc03          	ld	s8,0(s3)
ffffffffc0202d92:	96e2                	add	a3,a3,s8
ffffffffc0202d94:	0006ba83          	ld	s5,0(a3) # fffffffffff80000 <end+0x3fce96f0>
ffffffffc0202d98:	0a8a                	slli	s5,s5,0x2
ffffffffc0202d9a:	00fafab3          	and	s5,s5,a5
ffffffffc0202d9e:	00cad793          	srli	a5,s5,0xc
ffffffffc0202da2:	06e7f3e3          	bgeu	a5,a4,ffffffffc0203608 <pmm_init+0xb38>
ffffffffc0202da6:	4601                	li	a2,0
ffffffffc0202da8:	6585                	lui	a1,0x1
ffffffffc0202daa:	9ae2                	add	s5,s5,s8
ffffffffc0202dac:	c78ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202db0:	0aa1                	addi	s5,s5,8
ffffffffc0202db2:	03551be3          	bne	a0,s5,ffffffffc02035e8 <pmm_init+0xb18>
ffffffffc0202db6:	100027f3          	csrr	a5,sstatus
ffffffffc0202dba:	8b89                	andi	a5,a5,2
ffffffffc0202dbc:	3a079163          	bnez	a5,ffffffffc020315e <pmm_init+0x68e>
ffffffffc0202dc0:	000b3783          	ld	a5,0(s6)
ffffffffc0202dc4:	4505                	li	a0,1
ffffffffc0202dc6:	6f9c                	ld	a5,24(a5)
ffffffffc0202dc8:	9782                	jalr	a5
ffffffffc0202dca:	8c2a                	mv	s8,a0
ffffffffc0202dcc:	00093503          	ld	a0,0(s2)
ffffffffc0202dd0:	46d1                	li	a3,20
ffffffffc0202dd2:	6605                	lui	a2,0x1
ffffffffc0202dd4:	85e2                	mv	a1,s8
ffffffffc0202dd6:	c05ff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202dda:	1a0519e3          	bnez	a0,ffffffffc020378c <pmm_init+0xcbc>
ffffffffc0202dde:	00093503          	ld	a0,0(s2)
ffffffffc0202de2:	4601                	li	a2,0
ffffffffc0202de4:	6585                	lui	a1,0x1
ffffffffc0202de6:	c3eff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202dea:	10050ce3          	beqz	a0,ffffffffc0203702 <pmm_init+0xc32>
ffffffffc0202dee:	611c                	ld	a5,0(a0)
ffffffffc0202df0:	0107f713          	andi	a4,a5,16
ffffffffc0202df4:	0e0707e3          	beqz	a4,ffffffffc02036e2 <pmm_init+0xc12>
ffffffffc0202df8:	8b91                	andi	a5,a5,4
ffffffffc0202dfa:	0c0784e3          	beqz	a5,ffffffffc02036c2 <pmm_init+0xbf2>
ffffffffc0202dfe:	00093503          	ld	a0,0(s2)
ffffffffc0202e02:	611c                	ld	a5,0(a0)
ffffffffc0202e04:	8bc1                	andi	a5,a5,16
ffffffffc0202e06:	08078ee3          	beqz	a5,ffffffffc02036a2 <pmm_init+0xbd2>
ffffffffc0202e0a:	000c2703          	lw	a4,0(s8)
ffffffffc0202e0e:	4785                	li	a5,1
ffffffffc0202e10:	06f719e3          	bne	a4,a5,ffffffffc0203682 <pmm_init+0xbb2>
ffffffffc0202e14:	4681                	li	a3,0
ffffffffc0202e16:	6605                	lui	a2,0x1
ffffffffc0202e18:	85d2                	mv	a1,s4
ffffffffc0202e1a:	bc1ff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202e1e:	040512e3          	bnez	a0,ffffffffc0203662 <pmm_init+0xb92>
ffffffffc0202e22:	000a2703          	lw	a4,0(s4)
ffffffffc0202e26:	4789                	li	a5,2
ffffffffc0202e28:	00f71de3          	bne	a4,a5,ffffffffc0203642 <pmm_init+0xb72>
ffffffffc0202e2c:	000c2783          	lw	a5,0(s8)
ffffffffc0202e30:	7e079963          	bnez	a5,ffffffffc0203622 <pmm_init+0xb52>
ffffffffc0202e34:	00093503          	ld	a0,0(s2)
ffffffffc0202e38:	4601                	li	a2,0
ffffffffc0202e3a:	6585                	lui	a1,0x1
ffffffffc0202e3c:	be8ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202e40:	54050263          	beqz	a0,ffffffffc0203384 <pmm_init+0x8b4>
ffffffffc0202e44:	6118                	ld	a4,0(a0)
ffffffffc0202e46:	00177793          	andi	a5,a4,1
ffffffffc0202e4a:	180781e3          	beqz	a5,ffffffffc02037cc <pmm_init+0xcfc>
ffffffffc0202e4e:	6094                	ld	a3,0(s1)
ffffffffc0202e50:	00271793          	slli	a5,a4,0x2
ffffffffc0202e54:	83b1                	srli	a5,a5,0xc
ffffffffc0202e56:	52d7f563          	bgeu	a5,a3,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202e5a:	000bb683          	ld	a3,0(s7)
ffffffffc0202e5e:	fff80ab7          	lui	s5,0xfff80
ffffffffc0202e62:	97d6                	add	a5,a5,s5
ffffffffc0202e64:	079a                	slli	a5,a5,0x6
ffffffffc0202e66:	97b6                	add	a5,a5,a3
ffffffffc0202e68:	58fa1e63          	bne	s4,a5,ffffffffc0203404 <pmm_init+0x934>
ffffffffc0202e6c:	8b41                	andi	a4,a4,16
ffffffffc0202e6e:	56071b63          	bnez	a4,ffffffffc02033e4 <pmm_init+0x914>
ffffffffc0202e72:	00093503          	ld	a0,0(s2)
ffffffffc0202e76:	4581                	li	a1,0
ffffffffc0202e78:	ac7ff0ef          	jal	ra,ffffffffc020293e <page_remove>
ffffffffc0202e7c:	000a2c83          	lw	s9,0(s4)
ffffffffc0202e80:	4785                	li	a5,1
ffffffffc0202e82:	5cfc9163          	bne	s9,a5,ffffffffc0203444 <pmm_init+0x974>
ffffffffc0202e86:	000c2783          	lw	a5,0(s8)
ffffffffc0202e8a:	58079d63          	bnez	a5,ffffffffc0203424 <pmm_init+0x954>
ffffffffc0202e8e:	00093503          	ld	a0,0(s2)
ffffffffc0202e92:	6585                	lui	a1,0x1
ffffffffc0202e94:	aabff0ef          	jal	ra,ffffffffc020293e <page_remove>
ffffffffc0202e98:	000a2783          	lw	a5,0(s4)
ffffffffc0202e9c:	200793e3          	bnez	a5,ffffffffc02038a2 <pmm_init+0xdd2>
ffffffffc0202ea0:	000c2783          	lw	a5,0(s8)
ffffffffc0202ea4:	1c079fe3          	bnez	a5,ffffffffc0203882 <pmm_init+0xdb2>
ffffffffc0202ea8:	00093a03          	ld	s4,0(s2)
ffffffffc0202eac:	608c                	ld	a1,0(s1)
ffffffffc0202eae:	000a3683          	ld	a3,0(s4)
ffffffffc0202eb2:	068a                	slli	a3,a3,0x2
ffffffffc0202eb4:	82b1                	srli	a3,a3,0xc
ffffffffc0202eb6:	4cb6f563          	bgeu	a3,a1,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202eba:	000bb503          	ld	a0,0(s7)
ffffffffc0202ebe:	96d6                	add	a3,a3,s5
ffffffffc0202ec0:	069a                	slli	a3,a3,0x6
ffffffffc0202ec2:	00d507b3          	add	a5,a0,a3
ffffffffc0202ec6:	439c                	lw	a5,0(a5)
ffffffffc0202ec8:	4f979e63          	bne	a5,s9,ffffffffc02033c4 <pmm_init+0x8f4>
ffffffffc0202ecc:	8699                	srai	a3,a3,0x6
ffffffffc0202ece:	00080637          	lui	a2,0x80
ffffffffc0202ed2:	96b2                	add	a3,a3,a2
ffffffffc0202ed4:	00c69713          	slli	a4,a3,0xc
ffffffffc0202ed8:	8331                	srli	a4,a4,0xc
ffffffffc0202eda:	06b2                	slli	a3,a3,0xc
ffffffffc0202edc:	06b773e3          	bgeu	a4,a1,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0202ee0:	0009b703          	ld	a4,0(s3)
ffffffffc0202ee4:	96ba                	add	a3,a3,a4
ffffffffc0202ee6:	629c                	ld	a5,0(a3)
ffffffffc0202ee8:	078a                	slli	a5,a5,0x2
ffffffffc0202eea:	83b1                	srli	a5,a5,0xc
ffffffffc0202eec:	48b7fa63          	bgeu	a5,a1,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202ef0:	8f91                	sub	a5,a5,a2
ffffffffc0202ef2:	079a                	slli	a5,a5,0x6
ffffffffc0202ef4:	953e                	add	a0,a0,a5
ffffffffc0202ef6:	100027f3          	csrr	a5,sstatus
ffffffffc0202efa:	8b89                	andi	a5,a5,2
ffffffffc0202efc:	32079463          	bnez	a5,ffffffffc0203224 <pmm_init+0x754>
ffffffffc0202f00:	000b3783          	ld	a5,0(s6)
ffffffffc0202f04:	4585                	li	a1,1
ffffffffc0202f06:	739c                	ld	a5,32(a5)
ffffffffc0202f08:	9782                	jalr	a5
ffffffffc0202f0a:	000a3783          	ld	a5,0(s4)
ffffffffc0202f0e:	6098                	ld	a4,0(s1)
ffffffffc0202f10:	078a                	slli	a5,a5,0x2
ffffffffc0202f12:	83b1                	srli	a5,a5,0xc
ffffffffc0202f14:	46e7f663          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc0202f18:	000bb503          	ld	a0,0(s7)
ffffffffc0202f1c:	fff80737          	lui	a4,0xfff80
ffffffffc0202f20:	97ba                	add	a5,a5,a4
ffffffffc0202f22:	079a                	slli	a5,a5,0x6
ffffffffc0202f24:	953e                	add	a0,a0,a5
ffffffffc0202f26:	100027f3          	csrr	a5,sstatus
ffffffffc0202f2a:	8b89                	andi	a5,a5,2
ffffffffc0202f2c:	2e079063          	bnez	a5,ffffffffc020320c <pmm_init+0x73c>
ffffffffc0202f30:	000b3783          	ld	a5,0(s6)
ffffffffc0202f34:	4585                	li	a1,1
ffffffffc0202f36:	739c                	ld	a5,32(a5)
ffffffffc0202f38:	9782                	jalr	a5
ffffffffc0202f3a:	00093783          	ld	a5,0(s2)
ffffffffc0202f3e:	0007b023          	sd	zero,0(a5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc0202f42:	12000073          	sfence.vma
ffffffffc0202f46:	100027f3          	csrr	a5,sstatus
ffffffffc0202f4a:	8b89                	andi	a5,a5,2
ffffffffc0202f4c:	2a079663          	bnez	a5,ffffffffc02031f8 <pmm_init+0x728>
ffffffffc0202f50:	000b3783          	ld	a5,0(s6)
ffffffffc0202f54:	779c                	ld	a5,40(a5)
ffffffffc0202f56:	9782                	jalr	a5
ffffffffc0202f58:	8a2a                	mv	s4,a0
ffffffffc0202f5a:	7d441463          	bne	s0,s4,ffffffffc0203722 <pmm_init+0xc52>
ffffffffc0202f5e:	0000a517          	auipc	a0,0xa
ffffffffc0202f62:	bca50513          	addi	a0,a0,-1078 # ffffffffc020cb28 <default_pmm_manager+0x5f8>
ffffffffc0202f66:	a40fd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0202f6a:	100027f3          	csrr	a5,sstatus
ffffffffc0202f6e:	8b89                	andi	a5,a5,2
ffffffffc0202f70:	26079a63          	bnez	a5,ffffffffc02031e4 <pmm_init+0x714>
ffffffffc0202f74:	000b3783          	ld	a5,0(s6)
ffffffffc0202f78:	779c                	ld	a5,40(a5)
ffffffffc0202f7a:	9782                	jalr	a5
ffffffffc0202f7c:	8c2a                	mv	s8,a0
ffffffffc0202f7e:	6098                	ld	a4,0(s1)
ffffffffc0202f80:	c0200437          	lui	s0,0xc0200
ffffffffc0202f84:	7afd                	lui	s5,0xfffff
ffffffffc0202f86:	00c71793          	slli	a5,a4,0xc
ffffffffc0202f8a:	6a05                	lui	s4,0x1
ffffffffc0202f8c:	02f47c63          	bgeu	s0,a5,ffffffffc0202fc4 <pmm_init+0x4f4>
ffffffffc0202f90:	00c45793          	srli	a5,s0,0xc
ffffffffc0202f94:	00093503          	ld	a0,0(s2)
ffffffffc0202f98:	3ae7f763          	bgeu	a5,a4,ffffffffc0203346 <pmm_init+0x876>
ffffffffc0202f9c:	0009b583          	ld	a1,0(s3)
ffffffffc0202fa0:	4601                	li	a2,0
ffffffffc0202fa2:	95a2                	add	a1,a1,s0
ffffffffc0202fa4:	a80ff0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0202fa8:	36050f63          	beqz	a0,ffffffffc0203326 <pmm_init+0x856>
ffffffffc0202fac:	611c                	ld	a5,0(a0)
ffffffffc0202fae:	078a                	slli	a5,a5,0x2
ffffffffc0202fb0:	0157f7b3          	and	a5,a5,s5
ffffffffc0202fb4:	3a879663          	bne	a5,s0,ffffffffc0203360 <pmm_init+0x890>
ffffffffc0202fb8:	6098                	ld	a4,0(s1)
ffffffffc0202fba:	9452                	add	s0,s0,s4
ffffffffc0202fbc:	00c71793          	slli	a5,a4,0xc
ffffffffc0202fc0:	fcf468e3          	bltu	s0,a5,ffffffffc0202f90 <pmm_init+0x4c0>
ffffffffc0202fc4:	00093783          	ld	a5,0(s2)
ffffffffc0202fc8:	639c                	ld	a5,0(a5)
ffffffffc0202fca:	48079d63          	bnez	a5,ffffffffc0203464 <pmm_init+0x994>
ffffffffc0202fce:	100027f3          	csrr	a5,sstatus
ffffffffc0202fd2:	8b89                	andi	a5,a5,2
ffffffffc0202fd4:	26079463          	bnez	a5,ffffffffc020323c <pmm_init+0x76c>
ffffffffc0202fd8:	000b3783          	ld	a5,0(s6)
ffffffffc0202fdc:	4505                	li	a0,1
ffffffffc0202fde:	6f9c                	ld	a5,24(a5)
ffffffffc0202fe0:	9782                	jalr	a5
ffffffffc0202fe2:	8a2a                	mv	s4,a0
ffffffffc0202fe4:	00093503          	ld	a0,0(s2)
ffffffffc0202fe8:	4699                	li	a3,6
ffffffffc0202fea:	10000613          	li	a2,256
ffffffffc0202fee:	85d2                	mv	a1,s4
ffffffffc0202ff0:	9ebff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0202ff4:	4a051863          	bnez	a0,ffffffffc02034a4 <pmm_init+0x9d4>
ffffffffc0202ff8:	000a2703          	lw	a4,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0202ffc:	4785                	li	a5,1
ffffffffc0202ffe:	48f71363          	bne	a4,a5,ffffffffc0203484 <pmm_init+0x9b4>
ffffffffc0203002:	00093503          	ld	a0,0(s2)
ffffffffc0203006:	6405                	lui	s0,0x1
ffffffffc0203008:	4699                	li	a3,6
ffffffffc020300a:	10040613          	addi	a2,s0,256 # 1100 <_binary_bin_swap_img_size-0x6c00>
ffffffffc020300e:	85d2                	mv	a1,s4
ffffffffc0203010:	9cbff0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0203014:	38051863          	bnez	a0,ffffffffc02033a4 <pmm_init+0x8d4>
ffffffffc0203018:	000a2703          	lw	a4,0(s4)
ffffffffc020301c:	4789                	li	a5,2
ffffffffc020301e:	4ef71363          	bne	a4,a5,ffffffffc0203504 <pmm_init+0xa34>
ffffffffc0203022:	0000a597          	auipc	a1,0xa
ffffffffc0203026:	c4e58593          	addi	a1,a1,-946 # ffffffffc020cc70 <default_pmm_manager+0x740>
ffffffffc020302a:	10000513          	li	a0,256
ffffffffc020302e:	4cc080ef          	jal	ra,ffffffffc020b4fa <strcpy>
ffffffffc0203032:	10040593          	addi	a1,s0,256
ffffffffc0203036:	10000513          	li	a0,256
ffffffffc020303a:	4d2080ef          	jal	ra,ffffffffc020b50c <strcmp>
ffffffffc020303e:	4a051363          	bnez	a0,ffffffffc02034e4 <pmm_init+0xa14>
ffffffffc0203042:	000bb683          	ld	a3,0(s7)
ffffffffc0203046:	00080737          	lui	a4,0x80
ffffffffc020304a:	547d                	li	s0,-1
ffffffffc020304c:	40da06b3          	sub	a3,s4,a3
ffffffffc0203050:	8699                	srai	a3,a3,0x6
ffffffffc0203052:	609c                	ld	a5,0(s1)
ffffffffc0203054:	96ba                	add	a3,a3,a4
ffffffffc0203056:	8031                	srli	s0,s0,0xc
ffffffffc0203058:	0086f733          	and	a4,a3,s0
ffffffffc020305c:	06b2                	slli	a3,a3,0xc
ffffffffc020305e:	6ef77263          	bgeu	a4,a5,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0203062:	0009b783          	ld	a5,0(s3)
ffffffffc0203066:	10000513          	li	a0,256
ffffffffc020306a:	96be                	add	a3,a3,a5
ffffffffc020306c:	10068023          	sb	zero,256(a3)
ffffffffc0203070:	454080ef          	jal	ra,ffffffffc020b4c4 <strlen>
ffffffffc0203074:	44051863          	bnez	a0,ffffffffc02034c4 <pmm_init+0x9f4>
ffffffffc0203078:	00093a83          	ld	s5,0(s2)
ffffffffc020307c:	609c                	ld	a5,0(s1)
ffffffffc020307e:	000ab683          	ld	a3,0(s5) # fffffffffffff000 <end+0x3fd686f0>
ffffffffc0203082:	068a                	slli	a3,a3,0x2
ffffffffc0203084:	82b1                	srli	a3,a3,0xc
ffffffffc0203086:	2ef6fd63          	bgeu	a3,a5,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc020308a:	8c75                	and	s0,s0,a3
ffffffffc020308c:	06b2                	slli	a3,a3,0xc
ffffffffc020308e:	6af47a63          	bgeu	s0,a5,ffffffffc0203742 <pmm_init+0xc72>
ffffffffc0203092:	0009b403          	ld	s0,0(s3)
ffffffffc0203096:	9436                	add	s0,s0,a3
ffffffffc0203098:	100027f3          	csrr	a5,sstatus
ffffffffc020309c:	8b89                	andi	a5,a5,2
ffffffffc020309e:	1e079c63          	bnez	a5,ffffffffc0203296 <pmm_init+0x7c6>
ffffffffc02030a2:	000b3783          	ld	a5,0(s6)
ffffffffc02030a6:	4585                	li	a1,1
ffffffffc02030a8:	8552                	mv	a0,s4
ffffffffc02030aa:	739c                	ld	a5,32(a5)
ffffffffc02030ac:	9782                	jalr	a5
ffffffffc02030ae:	601c                	ld	a5,0(s0)
ffffffffc02030b0:	6098                	ld	a4,0(s1)
ffffffffc02030b2:	078a                	slli	a5,a5,0x2
ffffffffc02030b4:	83b1                	srli	a5,a5,0xc
ffffffffc02030b6:	2ce7f563          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc02030ba:	000bb503          	ld	a0,0(s7)
ffffffffc02030be:	fff80737          	lui	a4,0xfff80
ffffffffc02030c2:	97ba                	add	a5,a5,a4
ffffffffc02030c4:	079a                	slli	a5,a5,0x6
ffffffffc02030c6:	953e                	add	a0,a0,a5
ffffffffc02030c8:	100027f3          	csrr	a5,sstatus
ffffffffc02030cc:	8b89                	andi	a5,a5,2
ffffffffc02030ce:	1a079863          	bnez	a5,ffffffffc020327e <pmm_init+0x7ae>
ffffffffc02030d2:	000b3783          	ld	a5,0(s6)
ffffffffc02030d6:	4585                	li	a1,1
ffffffffc02030d8:	739c                	ld	a5,32(a5)
ffffffffc02030da:	9782                	jalr	a5
ffffffffc02030dc:	000ab783          	ld	a5,0(s5)
ffffffffc02030e0:	6098                	ld	a4,0(s1)
ffffffffc02030e2:	078a                	slli	a5,a5,0x2
ffffffffc02030e4:	83b1                	srli	a5,a5,0xc
ffffffffc02030e6:	28e7fd63          	bgeu	a5,a4,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc02030ea:	000bb503          	ld	a0,0(s7)
ffffffffc02030ee:	fff80737          	lui	a4,0xfff80
ffffffffc02030f2:	97ba                	add	a5,a5,a4
ffffffffc02030f4:	079a                	slli	a5,a5,0x6
ffffffffc02030f6:	953e                	add	a0,a0,a5
ffffffffc02030f8:	100027f3          	csrr	a5,sstatus
ffffffffc02030fc:	8b89                	andi	a5,a5,2
ffffffffc02030fe:	16079463          	bnez	a5,ffffffffc0203266 <pmm_init+0x796>
ffffffffc0203102:	000b3783          	ld	a5,0(s6)
ffffffffc0203106:	4585                	li	a1,1
ffffffffc0203108:	739c                	ld	a5,32(a5)
ffffffffc020310a:	9782                	jalr	a5
ffffffffc020310c:	00093783          	ld	a5,0(s2)
ffffffffc0203110:	0007b023          	sd	zero,0(a5)
ffffffffc0203114:	12000073          	sfence.vma
ffffffffc0203118:	100027f3          	csrr	a5,sstatus
ffffffffc020311c:	8b89                	andi	a5,a5,2
ffffffffc020311e:	12079a63          	bnez	a5,ffffffffc0203252 <pmm_init+0x782>
ffffffffc0203122:	000b3783          	ld	a5,0(s6)
ffffffffc0203126:	779c                	ld	a5,40(a5)
ffffffffc0203128:	9782                	jalr	a5
ffffffffc020312a:	842a                	mv	s0,a0
ffffffffc020312c:	488c1e63          	bne	s8,s0,ffffffffc02035c8 <pmm_init+0xaf8>
ffffffffc0203130:	0000a517          	auipc	a0,0xa
ffffffffc0203134:	bb850513          	addi	a0,a0,-1096 # ffffffffc020cce8 <default_pmm_manager+0x7b8>
ffffffffc0203138:	86efd0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020313c:	7406                	ld	s0,96(sp)
ffffffffc020313e:	70a6                	ld	ra,104(sp)
ffffffffc0203140:	64e6                	ld	s1,88(sp)
ffffffffc0203142:	6946                	ld	s2,80(sp)
ffffffffc0203144:	69a6                	ld	s3,72(sp)
ffffffffc0203146:	6a06                	ld	s4,64(sp)
ffffffffc0203148:	7ae2                	ld	s5,56(sp)
ffffffffc020314a:	7b42                	ld	s6,48(sp)
ffffffffc020314c:	7ba2                	ld	s7,40(sp)
ffffffffc020314e:	7c02                	ld	s8,32(sp)
ffffffffc0203150:	6ce2                	ld	s9,24(sp)
ffffffffc0203152:	6165                	addi	sp,sp,112
ffffffffc0203154:	e17fe06f          	j	ffffffffc0201f6a <kmalloc_init>
ffffffffc0203158:	c80007b7          	lui	a5,0xc8000
ffffffffc020315c:	b411                	j	ffffffffc0202b60 <pmm_init+0x90>
ffffffffc020315e:	b15fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203162:	000b3783          	ld	a5,0(s6)
ffffffffc0203166:	4505                	li	a0,1
ffffffffc0203168:	6f9c                	ld	a5,24(a5)
ffffffffc020316a:	9782                	jalr	a5
ffffffffc020316c:	8c2a                	mv	s8,a0
ffffffffc020316e:	afffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203172:	b9a9                	j	ffffffffc0202dcc <pmm_init+0x2fc>
ffffffffc0203174:	afffd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203178:	000b3783          	ld	a5,0(s6)
ffffffffc020317c:	4505                	li	a0,1
ffffffffc020317e:	6f9c                	ld	a5,24(a5)
ffffffffc0203180:	9782                	jalr	a5
ffffffffc0203182:	8a2a                	mv	s4,a0
ffffffffc0203184:	ae9fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203188:	b645                	j	ffffffffc0202d28 <pmm_init+0x258>
ffffffffc020318a:	ae9fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020318e:	000b3783          	ld	a5,0(s6)
ffffffffc0203192:	779c                	ld	a5,40(a5)
ffffffffc0203194:	9782                	jalr	a5
ffffffffc0203196:	842a                	mv	s0,a0
ffffffffc0203198:	ad5fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020319c:	b6b9                	j	ffffffffc0202cea <pmm_init+0x21a>
ffffffffc020319e:	ad5fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031a2:	000b3783          	ld	a5,0(s6)
ffffffffc02031a6:	4505                	li	a0,1
ffffffffc02031a8:	6f9c                	ld	a5,24(a5)
ffffffffc02031aa:	9782                	jalr	a5
ffffffffc02031ac:	842a                	mv	s0,a0
ffffffffc02031ae:	abffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02031b2:	bc99                	j	ffffffffc0202c08 <pmm_init+0x138>
ffffffffc02031b4:	6705                	lui	a4,0x1
ffffffffc02031b6:	177d                	addi	a4,a4,-1
ffffffffc02031b8:	96ba                	add	a3,a3,a4
ffffffffc02031ba:	8ff5                	and	a5,a5,a3
ffffffffc02031bc:	00c7d713          	srli	a4,a5,0xc
ffffffffc02031c0:	1ca77063          	bgeu	a4,a0,ffffffffc0203380 <pmm_init+0x8b0>
ffffffffc02031c4:	000b3683          	ld	a3,0(s6)
ffffffffc02031c8:	fff80537          	lui	a0,0xfff80
ffffffffc02031cc:	972a                	add	a4,a4,a0
ffffffffc02031ce:	6a94                	ld	a3,16(a3)
ffffffffc02031d0:	8c1d                	sub	s0,s0,a5
ffffffffc02031d2:	00671513          	slli	a0,a4,0x6
ffffffffc02031d6:	00c45593          	srli	a1,s0,0xc
ffffffffc02031da:	9532                	add	a0,a0,a2
ffffffffc02031dc:	9682                	jalr	a3
ffffffffc02031de:	0009b583          	ld	a1,0(s3)
ffffffffc02031e2:	bac5                	j	ffffffffc0202bd2 <pmm_init+0x102>
ffffffffc02031e4:	a8ffd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031e8:	000b3783          	ld	a5,0(s6)
ffffffffc02031ec:	779c                	ld	a5,40(a5)
ffffffffc02031ee:	9782                	jalr	a5
ffffffffc02031f0:	8c2a                	mv	s8,a0
ffffffffc02031f2:	a7bfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02031f6:	b361                	j	ffffffffc0202f7e <pmm_init+0x4ae>
ffffffffc02031f8:	a7bfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02031fc:	000b3783          	ld	a5,0(s6)
ffffffffc0203200:	779c                	ld	a5,40(a5)
ffffffffc0203202:	9782                	jalr	a5
ffffffffc0203204:	8a2a                	mv	s4,a0
ffffffffc0203206:	a67fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020320a:	bb81                	j	ffffffffc0202f5a <pmm_init+0x48a>
ffffffffc020320c:	e42a                	sd	a0,8(sp)
ffffffffc020320e:	a65fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203212:	000b3783          	ld	a5,0(s6)
ffffffffc0203216:	6522                	ld	a0,8(sp)
ffffffffc0203218:	4585                	li	a1,1
ffffffffc020321a:	739c                	ld	a5,32(a5)
ffffffffc020321c:	9782                	jalr	a5
ffffffffc020321e:	a4ffd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203222:	bb21                	j	ffffffffc0202f3a <pmm_init+0x46a>
ffffffffc0203224:	e42a                	sd	a0,8(sp)
ffffffffc0203226:	a4dfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020322a:	000b3783          	ld	a5,0(s6)
ffffffffc020322e:	6522                	ld	a0,8(sp)
ffffffffc0203230:	4585                	li	a1,1
ffffffffc0203232:	739c                	ld	a5,32(a5)
ffffffffc0203234:	9782                	jalr	a5
ffffffffc0203236:	a37fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020323a:	b9c1                	j	ffffffffc0202f0a <pmm_init+0x43a>
ffffffffc020323c:	a37fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203240:	000b3783          	ld	a5,0(s6)
ffffffffc0203244:	4505                	li	a0,1
ffffffffc0203246:	6f9c                	ld	a5,24(a5)
ffffffffc0203248:	9782                	jalr	a5
ffffffffc020324a:	8a2a                	mv	s4,a0
ffffffffc020324c:	a21fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203250:	bb51                	j	ffffffffc0202fe4 <pmm_init+0x514>
ffffffffc0203252:	a21fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203256:	000b3783          	ld	a5,0(s6)
ffffffffc020325a:	779c                	ld	a5,40(a5)
ffffffffc020325c:	9782                	jalr	a5
ffffffffc020325e:	842a                	mv	s0,a0
ffffffffc0203260:	a0dfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203264:	b5e1                	j	ffffffffc020312c <pmm_init+0x65c>
ffffffffc0203266:	e42a                	sd	a0,8(sp)
ffffffffc0203268:	a0bfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020326c:	000b3783          	ld	a5,0(s6)
ffffffffc0203270:	6522                	ld	a0,8(sp)
ffffffffc0203272:	4585                	li	a1,1
ffffffffc0203274:	739c                	ld	a5,32(a5)
ffffffffc0203276:	9782                	jalr	a5
ffffffffc0203278:	9f5fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020327c:	bd41                	j	ffffffffc020310c <pmm_init+0x63c>
ffffffffc020327e:	e42a                	sd	a0,8(sp)
ffffffffc0203280:	9f3fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203284:	000b3783          	ld	a5,0(s6)
ffffffffc0203288:	6522                	ld	a0,8(sp)
ffffffffc020328a:	4585                	li	a1,1
ffffffffc020328c:	739c                	ld	a5,32(a5)
ffffffffc020328e:	9782                	jalr	a5
ffffffffc0203290:	9ddfd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203294:	b5a1                	j	ffffffffc02030dc <pmm_init+0x60c>
ffffffffc0203296:	9ddfd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020329a:	000b3783          	ld	a5,0(s6)
ffffffffc020329e:	4585                	li	a1,1
ffffffffc02032a0:	8552                	mv	a0,s4
ffffffffc02032a2:	739c                	ld	a5,32(a5)
ffffffffc02032a4:	9782                	jalr	a5
ffffffffc02032a6:	9c7fd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02032aa:	b511                	j	ffffffffc02030ae <pmm_init+0x5de>
ffffffffc02032ac:	00010417          	auipc	s0,0x10
ffffffffc02032b0:	d5440413          	addi	s0,s0,-684 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc02032b4:	00010797          	auipc	a5,0x10
ffffffffc02032b8:	d4c78793          	addi	a5,a5,-692 # ffffffffc0213000 <boot_page_table_sv39>
ffffffffc02032bc:	a0f41de3          	bne	s0,a5,ffffffffc0202cd6 <pmm_init+0x206>
ffffffffc02032c0:	4581                	li	a1,0
ffffffffc02032c2:	6605                	lui	a2,0x1
ffffffffc02032c4:	8522                	mv	a0,s0
ffffffffc02032c6:	2a0080ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc02032ca:	0000d597          	auipc	a1,0xd
ffffffffc02032ce:	d3658593          	addi	a1,a1,-714 # ffffffffc0210000 <bootstackguard>
ffffffffc02032d2:	0000e797          	auipc	a5,0xe
ffffffffc02032d6:	d20786a3          	sb	zero,-723(a5) # ffffffffc0210fff <bootstackguard+0xfff>
ffffffffc02032da:	0000d797          	auipc	a5,0xd
ffffffffc02032de:	d2078323          	sb	zero,-730(a5) # ffffffffc0210000 <bootstackguard>
ffffffffc02032e2:	00093503          	ld	a0,0(s2)
ffffffffc02032e6:	2555ec63          	bltu	a1,s5,ffffffffc020353e <pmm_init+0xa6e>
ffffffffc02032ea:	0009b683          	ld	a3,0(s3)
ffffffffc02032ee:	4701                	li	a4,0
ffffffffc02032f0:	6605                	lui	a2,0x1
ffffffffc02032f2:	40d586b3          	sub	a3,a1,a3
ffffffffc02032f6:	956ff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc02032fa:	00093503          	ld	a0,0(s2)
ffffffffc02032fe:	23546363          	bltu	s0,s5,ffffffffc0203524 <pmm_init+0xa54>
ffffffffc0203302:	0009b683          	ld	a3,0(s3)
ffffffffc0203306:	4701                	li	a4,0
ffffffffc0203308:	6605                	lui	a2,0x1
ffffffffc020330a:	40d406b3          	sub	a3,s0,a3
ffffffffc020330e:	85a2                	mv	a1,s0
ffffffffc0203310:	93cff0ef          	jal	ra,ffffffffc020244c <boot_map_segment>
ffffffffc0203314:	12000073          	sfence.vma
ffffffffc0203318:	00009517          	auipc	a0,0x9
ffffffffc020331c:	4e050513          	addi	a0,a0,1248 # ffffffffc020c7f8 <default_pmm_manager+0x2c8>
ffffffffc0203320:	e87fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0203324:	ba4d                	j	ffffffffc0202cd6 <pmm_init+0x206>
ffffffffc0203326:	0000a697          	auipc	a3,0xa
ffffffffc020332a:	82268693          	addi	a3,a3,-2014 # ffffffffc020cb48 <default_pmm_manager+0x618>
ffffffffc020332e:	00008617          	auipc	a2,0x8
ffffffffc0203332:	71a60613          	addi	a2,a2,1818 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203336:	28d00593          	li	a1,653
ffffffffc020333a:	00009517          	auipc	a0,0x9
ffffffffc020333e:	34650513          	addi	a0,a0,838 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203342:	95cfd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203346:	86a2                	mv	a3,s0
ffffffffc0203348:	00009617          	auipc	a2,0x9
ffffffffc020334c:	22060613          	addi	a2,a2,544 # ffffffffc020c568 <default_pmm_manager+0x38>
ffffffffc0203350:	28d00593          	li	a1,653
ffffffffc0203354:	00009517          	auipc	a0,0x9
ffffffffc0203358:	32c50513          	addi	a0,a0,812 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc020335c:	942fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203360:	0000a697          	auipc	a3,0xa
ffffffffc0203364:	82868693          	addi	a3,a3,-2008 # ffffffffc020cb88 <default_pmm_manager+0x658>
ffffffffc0203368:	00008617          	auipc	a2,0x8
ffffffffc020336c:	6e060613          	addi	a2,a2,1760 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203370:	28e00593          	li	a1,654
ffffffffc0203374:	00009517          	auipc	a0,0x9
ffffffffc0203378:	30c50513          	addi	a0,a0,780 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc020337c:	922fd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203380:	db5fe0ef          	jal	ra,ffffffffc0202134 <pa2page.part.0>
ffffffffc0203384:	00009697          	auipc	a3,0x9
ffffffffc0203388:	62c68693          	addi	a3,a3,1580 # ffffffffc020c9b0 <default_pmm_manager+0x480>
ffffffffc020338c:	00008617          	auipc	a2,0x8
ffffffffc0203390:	6bc60613          	addi	a2,a2,1724 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203394:	26a00593          	li	a1,618
ffffffffc0203398:	00009517          	auipc	a0,0x9
ffffffffc020339c:	2e850513          	addi	a0,a0,744 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02033a0:	8fefd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033a4:	0000a697          	auipc	a3,0xa
ffffffffc02033a8:	86c68693          	addi	a3,a3,-1940 # ffffffffc020cc10 <default_pmm_manager+0x6e0>
ffffffffc02033ac:	00008617          	auipc	a2,0x8
ffffffffc02033b0:	69c60613          	addi	a2,a2,1692 # ffffffffc020ba48 <commands+0x210>
ffffffffc02033b4:	29700593          	li	a1,663
ffffffffc02033b8:	00009517          	auipc	a0,0x9
ffffffffc02033bc:	2c850513          	addi	a0,a0,712 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02033c0:	8defd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033c4:	00009697          	auipc	a3,0x9
ffffffffc02033c8:	70c68693          	addi	a3,a3,1804 # ffffffffc020cad0 <default_pmm_manager+0x5a0>
ffffffffc02033cc:	00008617          	auipc	a2,0x8
ffffffffc02033d0:	67c60613          	addi	a2,a2,1660 # ffffffffc020ba48 <commands+0x210>
ffffffffc02033d4:	27600593          	li	a1,630
ffffffffc02033d8:	00009517          	auipc	a0,0x9
ffffffffc02033dc:	2a850513          	addi	a0,a0,680 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02033e0:	8befd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02033e4:	00009697          	auipc	a3,0x9
ffffffffc02033e8:	6bc68693          	addi	a3,a3,1724 # ffffffffc020caa0 <default_pmm_manager+0x570>
ffffffffc02033ec:	00008617          	auipc	a2,0x8
ffffffffc02033f0:	65c60613          	addi	a2,a2,1628 # ffffffffc020ba48 <commands+0x210>
ffffffffc02033f4:	26c00593          	li	a1,620
ffffffffc02033f8:	00009517          	auipc	a0,0x9
ffffffffc02033fc:	28850513          	addi	a0,a0,648 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203400:	89efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203404:	00009697          	auipc	a3,0x9
ffffffffc0203408:	50c68693          	addi	a3,a3,1292 # ffffffffc020c910 <default_pmm_manager+0x3e0>
ffffffffc020340c:	00008617          	auipc	a2,0x8
ffffffffc0203410:	63c60613          	addi	a2,a2,1596 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203414:	26b00593          	li	a1,619
ffffffffc0203418:	00009517          	auipc	a0,0x9
ffffffffc020341c:	26850513          	addi	a0,a0,616 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203420:	87efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203424:	00009697          	auipc	a3,0x9
ffffffffc0203428:	66468693          	addi	a3,a3,1636 # ffffffffc020ca88 <default_pmm_manager+0x558>
ffffffffc020342c:	00008617          	auipc	a2,0x8
ffffffffc0203430:	61c60613          	addi	a2,a2,1564 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203434:	27000593          	li	a1,624
ffffffffc0203438:	00009517          	auipc	a0,0x9
ffffffffc020343c:	24850513          	addi	a0,a0,584 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203440:	85efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203444:	00009697          	auipc	a3,0x9
ffffffffc0203448:	4e468693          	addi	a3,a3,1252 # ffffffffc020c928 <default_pmm_manager+0x3f8>
ffffffffc020344c:	00008617          	auipc	a2,0x8
ffffffffc0203450:	5fc60613          	addi	a2,a2,1532 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203454:	26f00593          	li	a1,623
ffffffffc0203458:	00009517          	auipc	a0,0x9
ffffffffc020345c:	22850513          	addi	a0,a0,552 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203460:	83efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203464:	00009697          	auipc	a3,0x9
ffffffffc0203468:	73c68693          	addi	a3,a3,1852 # ffffffffc020cba0 <default_pmm_manager+0x670>
ffffffffc020346c:	00008617          	auipc	a2,0x8
ffffffffc0203470:	5dc60613          	addi	a2,a2,1500 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203474:	29100593          	li	a1,657
ffffffffc0203478:	00009517          	auipc	a0,0x9
ffffffffc020347c:	20850513          	addi	a0,a0,520 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203480:	81efd0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203484:	00009697          	auipc	a3,0x9
ffffffffc0203488:	77468693          	addi	a3,a3,1908 # ffffffffc020cbf8 <default_pmm_manager+0x6c8>
ffffffffc020348c:	00008617          	auipc	a2,0x8
ffffffffc0203490:	5bc60613          	addi	a2,a2,1468 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203494:	29600593          	li	a1,662
ffffffffc0203498:	00009517          	auipc	a0,0x9
ffffffffc020349c:	1e850513          	addi	a0,a0,488 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02034a0:	ffffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034a4:	00009697          	auipc	a3,0x9
ffffffffc02034a8:	71468693          	addi	a3,a3,1812 # ffffffffc020cbb8 <default_pmm_manager+0x688>
ffffffffc02034ac:	00008617          	auipc	a2,0x8
ffffffffc02034b0:	59c60613          	addi	a2,a2,1436 # ffffffffc020ba48 <commands+0x210>
ffffffffc02034b4:	29500593          	li	a1,661
ffffffffc02034b8:	00009517          	auipc	a0,0x9
ffffffffc02034bc:	1c850513          	addi	a0,a0,456 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02034c0:	fdffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034c4:	00009697          	auipc	a3,0x9
ffffffffc02034c8:	7fc68693          	addi	a3,a3,2044 # ffffffffc020ccc0 <default_pmm_manager+0x790>
ffffffffc02034cc:	00008617          	auipc	a2,0x8
ffffffffc02034d0:	57c60613          	addi	a2,a2,1404 # ffffffffc020ba48 <commands+0x210>
ffffffffc02034d4:	29f00593          	li	a1,671
ffffffffc02034d8:	00009517          	auipc	a0,0x9
ffffffffc02034dc:	1a850513          	addi	a0,a0,424 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02034e0:	fbffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02034e4:	00009697          	auipc	a3,0x9
ffffffffc02034e8:	7a468693          	addi	a3,a3,1956 # ffffffffc020cc88 <default_pmm_manager+0x758>
ffffffffc02034ec:	00008617          	auipc	a2,0x8
ffffffffc02034f0:	55c60613          	addi	a2,a2,1372 # ffffffffc020ba48 <commands+0x210>
ffffffffc02034f4:	29c00593          	li	a1,668
ffffffffc02034f8:	00009517          	auipc	a0,0x9
ffffffffc02034fc:	18850513          	addi	a0,a0,392 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203500:	f9ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203504:	00009697          	auipc	a3,0x9
ffffffffc0203508:	75468693          	addi	a3,a3,1876 # ffffffffc020cc58 <default_pmm_manager+0x728>
ffffffffc020350c:	00008617          	auipc	a2,0x8
ffffffffc0203510:	53c60613          	addi	a2,a2,1340 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203514:	29800593          	li	a1,664
ffffffffc0203518:	00009517          	auipc	a0,0x9
ffffffffc020351c:	16850513          	addi	a0,a0,360 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203520:	f7ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203524:	86a2                	mv	a3,s0
ffffffffc0203526:	00009617          	auipc	a2,0x9
ffffffffc020352a:	0ea60613          	addi	a2,a2,234 # ffffffffc020c610 <default_pmm_manager+0xe0>
ffffffffc020352e:	0dc00593          	li	a1,220
ffffffffc0203532:	00009517          	auipc	a0,0x9
ffffffffc0203536:	14e50513          	addi	a0,a0,334 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc020353a:	f65fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020353e:	86ae                	mv	a3,a1
ffffffffc0203540:	00009617          	auipc	a2,0x9
ffffffffc0203544:	0d060613          	addi	a2,a2,208 # ffffffffc020c610 <default_pmm_manager+0xe0>
ffffffffc0203548:	0db00593          	li	a1,219
ffffffffc020354c:	00009517          	auipc	a0,0x9
ffffffffc0203550:	13450513          	addi	a0,a0,308 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203554:	f4bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203558:	00009697          	auipc	a3,0x9
ffffffffc020355c:	2e868693          	addi	a3,a3,744 # ffffffffc020c840 <default_pmm_manager+0x310>
ffffffffc0203560:	00008617          	auipc	a2,0x8
ffffffffc0203564:	4e860613          	addi	a2,a2,1256 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203568:	24f00593          	li	a1,591
ffffffffc020356c:	00009517          	auipc	a0,0x9
ffffffffc0203570:	11450513          	addi	a0,a0,276 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203574:	f2bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203578:	00009697          	auipc	a3,0x9
ffffffffc020357c:	2a868693          	addi	a3,a3,680 # ffffffffc020c820 <default_pmm_manager+0x2f0>
ffffffffc0203580:	00008617          	auipc	a2,0x8
ffffffffc0203584:	4c860613          	addi	a2,a2,1224 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203588:	24e00593          	li	a1,590
ffffffffc020358c:	00009517          	auipc	a0,0x9
ffffffffc0203590:	0f450513          	addi	a0,a0,244 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203594:	f0bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203598:	00009617          	auipc	a2,0x9
ffffffffc020359c:	21860613          	addi	a2,a2,536 # ffffffffc020c7b0 <default_pmm_manager+0x280>
ffffffffc02035a0:	0aa00593          	li	a1,170
ffffffffc02035a4:	00009517          	auipc	a0,0x9
ffffffffc02035a8:	0dc50513          	addi	a0,a0,220 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02035ac:	ef3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035b0:	00009617          	auipc	a2,0x9
ffffffffc02035b4:	16860613          	addi	a2,a2,360 # ffffffffc020c718 <default_pmm_manager+0x1e8>
ffffffffc02035b8:	06500593          	li	a1,101
ffffffffc02035bc:	00009517          	auipc	a0,0x9
ffffffffc02035c0:	0c450513          	addi	a0,a0,196 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02035c4:	edbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035c8:	00009697          	auipc	a3,0x9
ffffffffc02035cc:	53868693          	addi	a3,a3,1336 # ffffffffc020cb00 <default_pmm_manager+0x5d0>
ffffffffc02035d0:	00008617          	auipc	a2,0x8
ffffffffc02035d4:	47860613          	addi	a2,a2,1144 # ffffffffc020ba48 <commands+0x210>
ffffffffc02035d8:	2a800593          	li	a1,680
ffffffffc02035dc:	00009517          	auipc	a0,0x9
ffffffffc02035e0:	0a450513          	addi	a0,a0,164 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02035e4:	ebbfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02035e8:	00009697          	auipc	a3,0x9
ffffffffc02035ec:	35868693          	addi	a3,a3,856 # ffffffffc020c940 <default_pmm_manager+0x410>
ffffffffc02035f0:	00008617          	auipc	a2,0x8
ffffffffc02035f4:	45860613          	addi	a2,a2,1112 # ffffffffc020ba48 <commands+0x210>
ffffffffc02035f8:	25d00593          	li	a1,605
ffffffffc02035fc:	00009517          	auipc	a0,0x9
ffffffffc0203600:	08450513          	addi	a0,a0,132 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203604:	e9bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203608:	86d6                	mv	a3,s5
ffffffffc020360a:	00009617          	auipc	a2,0x9
ffffffffc020360e:	f5e60613          	addi	a2,a2,-162 # ffffffffc020c568 <default_pmm_manager+0x38>
ffffffffc0203612:	25c00593          	li	a1,604
ffffffffc0203616:	00009517          	auipc	a0,0x9
ffffffffc020361a:	06a50513          	addi	a0,a0,106 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc020361e:	e81fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203622:	00009697          	auipc	a3,0x9
ffffffffc0203626:	46668693          	addi	a3,a3,1126 # ffffffffc020ca88 <default_pmm_manager+0x558>
ffffffffc020362a:	00008617          	auipc	a2,0x8
ffffffffc020362e:	41e60613          	addi	a2,a2,1054 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203632:	26900593          	li	a1,617
ffffffffc0203636:	00009517          	auipc	a0,0x9
ffffffffc020363a:	04a50513          	addi	a0,a0,74 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc020363e:	e61fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203642:	00009697          	auipc	a3,0x9
ffffffffc0203646:	42e68693          	addi	a3,a3,1070 # ffffffffc020ca70 <default_pmm_manager+0x540>
ffffffffc020364a:	00008617          	auipc	a2,0x8
ffffffffc020364e:	3fe60613          	addi	a2,a2,1022 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203652:	26800593          	li	a1,616
ffffffffc0203656:	00009517          	auipc	a0,0x9
ffffffffc020365a:	02a50513          	addi	a0,a0,42 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc020365e:	e41fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203662:	00009697          	auipc	a3,0x9
ffffffffc0203666:	3de68693          	addi	a3,a3,990 # ffffffffc020ca40 <default_pmm_manager+0x510>
ffffffffc020366a:	00008617          	auipc	a2,0x8
ffffffffc020366e:	3de60613          	addi	a2,a2,990 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203672:	26700593          	li	a1,615
ffffffffc0203676:	00009517          	auipc	a0,0x9
ffffffffc020367a:	00a50513          	addi	a0,a0,10 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc020367e:	e21fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203682:	00009697          	auipc	a3,0x9
ffffffffc0203686:	3a668693          	addi	a3,a3,934 # ffffffffc020ca28 <default_pmm_manager+0x4f8>
ffffffffc020368a:	00008617          	auipc	a2,0x8
ffffffffc020368e:	3be60613          	addi	a2,a2,958 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203692:	26500593          	li	a1,613
ffffffffc0203696:	00009517          	auipc	a0,0x9
ffffffffc020369a:	fea50513          	addi	a0,a0,-22 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc020369e:	e01fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036a2:	00009697          	auipc	a3,0x9
ffffffffc02036a6:	36668693          	addi	a3,a3,870 # ffffffffc020ca08 <default_pmm_manager+0x4d8>
ffffffffc02036aa:	00008617          	auipc	a2,0x8
ffffffffc02036ae:	39e60613          	addi	a2,a2,926 # ffffffffc020ba48 <commands+0x210>
ffffffffc02036b2:	26400593          	li	a1,612
ffffffffc02036b6:	00009517          	auipc	a0,0x9
ffffffffc02036ba:	fca50513          	addi	a0,a0,-54 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02036be:	de1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036c2:	00009697          	auipc	a3,0x9
ffffffffc02036c6:	33668693          	addi	a3,a3,822 # ffffffffc020c9f8 <default_pmm_manager+0x4c8>
ffffffffc02036ca:	00008617          	auipc	a2,0x8
ffffffffc02036ce:	37e60613          	addi	a2,a2,894 # ffffffffc020ba48 <commands+0x210>
ffffffffc02036d2:	26300593          	li	a1,611
ffffffffc02036d6:	00009517          	auipc	a0,0x9
ffffffffc02036da:	faa50513          	addi	a0,a0,-86 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02036de:	dc1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02036e2:	00009697          	auipc	a3,0x9
ffffffffc02036e6:	30668693          	addi	a3,a3,774 # ffffffffc020c9e8 <default_pmm_manager+0x4b8>
ffffffffc02036ea:	00008617          	auipc	a2,0x8
ffffffffc02036ee:	35e60613          	addi	a2,a2,862 # ffffffffc020ba48 <commands+0x210>
ffffffffc02036f2:	26200593          	li	a1,610
ffffffffc02036f6:	00009517          	auipc	a0,0x9
ffffffffc02036fa:	f8a50513          	addi	a0,a0,-118 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02036fe:	da1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203702:	00009697          	auipc	a3,0x9
ffffffffc0203706:	2ae68693          	addi	a3,a3,686 # ffffffffc020c9b0 <default_pmm_manager+0x480>
ffffffffc020370a:	00008617          	auipc	a2,0x8
ffffffffc020370e:	33e60613          	addi	a2,a2,830 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203712:	26100593          	li	a1,609
ffffffffc0203716:	00009517          	auipc	a0,0x9
ffffffffc020371a:	f6a50513          	addi	a0,a0,-150 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc020371e:	d81fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203722:	00009697          	auipc	a3,0x9
ffffffffc0203726:	3de68693          	addi	a3,a3,990 # ffffffffc020cb00 <default_pmm_manager+0x5d0>
ffffffffc020372a:	00008617          	auipc	a2,0x8
ffffffffc020372e:	31e60613          	addi	a2,a2,798 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203732:	27e00593          	li	a1,638
ffffffffc0203736:	00009517          	auipc	a0,0x9
ffffffffc020373a:	f4a50513          	addi	a0,a0,-182 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc020373e:	d61fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203742:	00009617          	auipc	a2,0x9
ffffffffc0203746:	e2660613          	addi	a2,a2,-474 # ffffffffc020c568 <default_pmm_manager+0x38>
ffffffffc020374a:	07100593          	li	a1,113
ffffffffc020374e:	00009517          	auipc	a0,0x9
ffffffffc0203752:	e4250513          	addi	a0,a0,-446 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc0203756:	d49fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020375a:	86a2                	mv	a3,s0
ffffffffc020375c:	00009617          	auipc	a2,0x9
ffffffffc0203760:	eb460613          	addi	a2,a2,-332 # ffffffffc020c610 <default_pmm_manager+0xe0>
ffffffffc0203764:	0ca00593          	li	a1,202
ffffffffc0203768:	00009517          	auipc	a0,0x9
ffffffffc020376c:	f1850513          	addi	a0,a0,-232 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203770:	d2ffc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203774:	00009617          	auipc	a2,0x9
ffffffffc0203778:	e9c60613          	addi	a2,a2,-356 # ffffffffc020c610 <default_pmm_manager+0xe0>
ffffffffc020377c:	08100593          	li	a1,129
ffffffffc0203780:	00009517          	auipc	a0,0x9
ffffffffc0203784:	f0050513          	addi	a0,a0,-256 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203788:	d17fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020378c:	00009697          	auipc	a3,0x9
ffffffffc0203790:	1e468693          	addi	a3,a3,484 # ffffffffc020c970 <default_pmm_manager+0x440>
ffffffffc0203794:	00008617          	auipc	a2,0x8
ffffffffc0203798:	2b460613          	addi	a2,a2,692 # ffffffffc020ba48 <commands+0x210>
ffffffffc020379c:	26000593          	li	a1,608
ffffffffc02037a0:	00009517          	auipc	a0,0x9
ffffffffc02037a4:	ee050513          	addi	a0,a0,-288 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02037a8:	cf7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037ac:	00009697          	auipc	a3,0x9
ffffffffc02037b0:	10468693          	addi	a3,a3,260 # ffffffffc020c8b0 <default_pmm_manager+0x380>
ffffffffc02037b4:	00008617          	auipc	a2,0x8
ffffffffc02037b8:	29460613          	addi	a2,a2,660 # ffffffffc020ba48 <commands+0x210>
ffffffffc02037bc:	25400593          	li	a1,596
ffffffffc02037c0:	00009517          	auipc	a0,0x9
ffffffffc02037c4:	ec050513          	addi	a0,a0,-320 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02037c8:	cd7fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037cc:	985fe0ef          	jal	ra,ffffffffc0202150 <pte2page.part.0>
ffffffffc02037d0:	00009697          	auipc	a3,0x9
ffffffffc02037d4:	11068693          	addi	a3,a3,272 # ffffffffc020c8e0 <default_pmm_manager+0x3b0>
ffffffffc02037d8:	00008617          	auipc	a2,0x8
ffffffffc02037dc:	27060613          	addi	a2,a2,624 # ffffffffc020ba48 <commands+0x210>
ffffffffc02037e0:	25700593          	li	a1,599
ffffffffc02037e4:	00009517          	auipc	a0,0x9
ffffffffc02037e8:	e9c50513          	addi	a0,a0,-356 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02037ec:	cb3fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02037f0:	00009697          	auipc	a3,0x9
ffffffffc02037f4:	09068693          	addi	a3,a3,144 # ffffffffc020c880 <default_pmm_manager+0x350>
ffffffffc02037f8:	00008617          	auipc	a2,0x8
ffffffffc02037fc:	25060613          	addi	a2,a2,592 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203800:	25000593          	li	a1,592
ffffffffc0203804:	00009517          	auipc	a0,0x9
ffffffffc0203808:	e7c50513          	addi	a0,a0,-388 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc020380c:	c93fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203810:	00009697          	auipc	a3,0x9
ffffffffc0203814:	10068693          	addi	a3,a3,256 # ffffffffc020c910 <default_pmm_manager+0x3e0>
ffffffffc0203818:	00008617          	auipc	a2,0x8
ffffffffc020381c:	23060613          	addi	a2,a2,560 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203820:	25800593          	li	a1,600
ffffffffc0203824:	00009517          	auipc	a0,0x9
ffffffffc0203828:	e5c50513          	addi	a0,a0,-420 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc020382c:	c73fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203830:	00009617          	auipc	a2,0x9
ffffffffc0203834:	d3860613          	addi	a2,a2,-712 # ffffffffc020c568 <default_pmm_manager+0x38>
ffffffffc0203838:	25b00593          	li	a1,603
ffffffffc020383c:	00009517          	auipc	a0,0x9
ffffffffc0203840:	e4450513          	addi	a0,a0,-444 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203844:	c5bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203848:	00009697          	auipc	a3,0x9
ffffffffc020384c:	0e068693          	addi	a3,a3,224 # ffffffffc020c928 <default_pmm_manager+0x3f8>
ffffffffc0203850:	00008617          	auipc	a2,0x8
ffffffffc0203854:	1f860613          	addi	a2,a2,504 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203858:	25900593          	li	a1,601
ffffffffc020385c:	00009517          	auipc	a0,0x9
ffffffffc0203860:	e2450513          	addi	a0,a0,-476 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203864:	c3bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203868:	86ca                	mv	a3,s2
ffffffffc020386a:	00009617          	auipc	a2,0x9
ffffffffc020386e:	da660613          	addi	a2,a2,-602 # ffffffffc020c610 <default_pmm_manager+0xe0>
ffffffffc0203872:	0c600593          	li	a1,198
ffffffffc0203876:	00009517          	auipc	a0,0x9
ffffffffc020387a:	e0a50513          	addi	a0,a0,-502 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc020387e:	c21fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203882:	00009697          	auipc	a3,0x9
ffffffffc0203886:	20668693          	addi	a3,a3,518 # ffffffffc020ca88 <default_pmm_manager+0x558>
ffffffffc020388a:	00008617          	auipc	a2,0x8
ffffffffc020388e:	1be60613          	addi	a2,a2,446 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203892:	27400593          	li	a1,628
ffffffffc0203896:	00009517          	auipc	a0,0x9
ffffffffc020389a:	dea50513          	addi	a0,a0,-534 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc020389e:	c01fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02038a2:	00009697          	auipc	a3,0x9
ffffffffc02038a6:	21668693          	addi	a3,a3,534 # ffffffffc020cab8 <default_pmm_manager+0x588>
ffffffffc02038aa:	00008617          	auipc	a2,0x8
ffffffffc02038ae:	19e60613          	addi	a2,a2,414 # ffffffffc020ba48 <commands+0x210>
ffffffffc02038b2:	27300593          	li	a1,627
ffffffffc02038b6:	00009517          	auipc	a0,0x9
ffffffffc02038ba:	dca50513          	addi	a0,a0,-566 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc02038be:	be1fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02038c2 <copy_range>:
ffffffffc02038c2:	7159                	addi	sp,sp,-112
ffffffffc02038c4:	00d667b3          	or	a5,a2,a3
ffffffffc02038c8:	f486                	sd	ra,104(sp)
ffffffffc02038ca:	f0a2                	sd	s0,96(sp)
ffffffffc02038cc:	eca6                	sd	s1,88(sp)
ffffffffc02038ce:	e8ca                	sd	s2,80(sp)
ffffffffc02038d0:	e4ce                	sd	s3,72(sp)
ffffffffc02038d2:	e0d2                	sd	s4,64(sp)
ffffffffc02038d4:	fc56                	sd	s5,56(sp)
ffffffffc02038d6:	f85a                	sd	s6,48(sp)
ffffffffc02038d8:	f45e                	sd	s7,40(sp)
ffffffffc02038da:	f062                	sd	s8,32(sp)
ffffffffc02038dc:	ec66                	sd	s9,24(sp)
ffffffffc02038de:	e86a                	sd	s10,16(sp)
ffffffffc02038e0:	e46e                	sd	s11,8(sp)
ffffffffc02038e2:	17d2                	slli	a5,a5,0x34
ffffffffc02038e4:	20079f63          	bnez	a5,ffffffffc0203b02 <copy_range+0x240>
ffffffffc02038e8:	002007b7          	lui	a5,0x200
ffffffffc02038ec:	8432                	mv	s0,a2
ffffffffc02038ee:	1af66263          	bltu	a2,a5,ffffffffc0203a92 <copy_range+0x1d0>
ffffffffc02038f2:	8936                	mv	s2,a3
ffffffffc02038f4:	18d67f63          	bgeu	a2,a3,ffffffffc0203a92 <copy_range+0x1d0>
ffffffffc02038f8:	4785                	li	a5,1
ffffffffc02038fa:	07fe                	slli	a5,a5,0x1f
ffffffffc02038fc:	18d7eb63          	bltu	a5,a3,ffffffffc0203a92 <copy_range+0x1d0>
ffffffffc0203900:	5b7d                	li	s6,-1
ffffffffc0203902:	8aaa                	mv	s5,a0
ffffffffc0203904:	89ae                	mv	s3,a1
ffffffffc0203906:	6a05                	lui	s4,0x1
ffffffffc0203908:	00093c17          	auipc	s8,0x93
ffffffffc020390c:	f98c0c13          	addi	s8,s8,-104 # ffffffffc02968a0 <npage>
ffffffffc0203910:	00093b97          	auipc	s7,0x93
ffffffffc0203914:	f98b8b93          	addi	s7,s7,-104 # ffffffffc02968a8 <pages>
ffffffffc0203918:	00cb5b13          	srli	s6,s6,0xc
ffffffffc020391c:	00093c97          	auipc	s9,0x93
ffffffffc0203920:	f94c8c93          	addi	s9,s9,-108 # ffffffffc02968b0 <pmm_manager>
ffffffffc0203924:	4601                	li	a2,0
ffffffffc0203926:	85a2                	mv	a1,s0
ffffffffc0203928:	854e                	mv	a0,s3
ffffffffc020392a:	8fbfe0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc020392e:	84aa                	mv	s1,a0
ffffffffc0203930:	0e050c63          	beqz	a0,ffffffffc0203a28 <copy_range+0x166>
ffffffffc0203934:	611c                	ld	a5,0(a0)
ffffffffc0203936:	8b85                	andi	a5,a5,1
ffffffffc0203938:	e785                	bnez	a5,ffffffffc0203960 <copy_range+0x9e>
ffffffffc020393a:	9452                	add	s0,s0,s4
ffffffffc020393c:	ff2464e3          	bltu	s0,s2,ffffffffc0203924 <copy_range+0x62>
ffffffffc0203940:	4501                	li	a0,0
ffffffffc0203942:	70a6                	ld	ra,104(sp)
ffffffffc0203944:	7406                	ld	s0,96(sp)
ffffffffc0203946:	64e6                	ld	s1,88(sp)
ffffffffc0203948:	6946                	ld	s2,80(sp)
ffffffffc020394a:	69a6                	ld	s3,72(sp)
ffffffffc020394c:	6a06                	ld	s4,64(sp)
ffffffffc020394e:	7ae2                	ld	s5,56(sp)
ffffffffc0203950:	7b42                	ld	s6,48(sp)
ffffffffc0203952:	7ba2                	ld	s7,40(sp)
ffffffffc0203954:	7c02                	ld	s8,32(sp)
ffffffffc0203956:	6ce2                	ld	s9,24(sp)
ffffffffc0203958:	6d42                	ld	s10,16(sp)
ffffffffc020395a:	6da2                	ld	s11,8(sp)
ffffffffc020395c:	6165                	addi	sp,sp,112
ffffffffc020395e:	8082                	ret
ffffffffc0203960:	4605                	li	a2,1
ffffffffc0203962:	85a2                	mv	a1,s0
ffffffffc0203964:	8556                	mv	a0,s5
ffffffffc0203966:	8bffe0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc020396a:	c56d                	beqz	a0,ffffffffc0203a54 <copy_range+0x192>
ffffffffc020396c:	609c                	ld	a5,0(s1)
ffffffffc020396e:	0017f713          	andi	a4,a5,1
ffffffffc0203972:	01f7f493          	andi	s1,a5,31
ffffffffc0203976:	16070a63          	beqz	a4,ffffffffc0203aea <copy_range+0x228>
ffffffffc020397a:	000c3683          	ld	a3,0(s8)
ffffffffc020397e:	078a                	slli	a5,a5,0x2
ffffffffc0203980:	00c7d713          	srli	a4,a5,0xc
ffffffffc0203984:	14d77763          	bgeu	a4,a3,ffffffffc0203ad2 <copy_range+0x210>
ffffffffc0203988:	000bb783          	ld	a5,0(s7)
ffffffffc020398c:	fff806b7          	lui	a3,0xfff80
ffffffffc0203990:	9736                	add	a4,a4,a3
ffffffffc0203992:	071a                	slli	a4,a4,0x6
ffffffffc0203994:	00e78db3          	add	s11,a5,a4
ffffffffc0203998:	10002773          	csrr	a4,sstatus
ffffffffc020399c:	8b09                	andi	a4,a4,2
ffffffffc020399e:	e345                	bnez	a4,ffffffffc0203a3e <copy_range+0x17c>
ffffffffc02039a0:	000cb703          	ld	a4,0(s9)
ffffffffc02039a4:	4505                	li	a0,1
ffffffffc02039a6:	6f18                	ld	a4,24(a4)
ffffffffc02039a8:	9702                	jalr	a4
ffffffffc02039aa:	8d2a                	mv	s10,a0
ffffffffc02039ac:	0c0d8363          	beqz	s11,ffffffffc0203a72 <copy_range+0x1b0>
ffffffffc02039b0:	100d0163          	beqz	s10,ffffffffc0203ab2 <copy_range+0x1f0>
ffffffffc02039b4:	000bb703          	ld	a4,0(s7)
ffffffffc02039b8:	000805b7          	lui	a1,0x80
ffffffffc02039bc:	000c3603          	ld	a2,0(s8)
ffffffffc02039c0:	40ed86b3          	sub	a3,s11,a4
ffffffffc02039c4:	8699                	srai	a3,a3,0x6
ffffffffc02039c6:	96ae                	add	a3,a3,a1
ffffffffc02039c8:	0166f7b3          	and	a5,a3,s6
ffffffffc02039cc:	06b2                	slli	a3,a3,0xc
ffffffffc02039ce:	08c7f663          	bgeu	a5,a2,ffffffffc0203a5a <copy_range+0x198>
ffffffffc02039d2:	40ed07b3          	sub	a5,s10,a4
ffffffffc02039d6:	00093717          	auipc	a4,0x93
ffffffffc02039da:	ee270713          	addi	a4,a4,-286 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02039de:	6308                	ld	a0,0(a4)
ffffffffc02039e0:	8799                	srai	a5,a5,0x6
ffffffffc02039e2:	97ae                	add	a5,a5,a1
ffffffffc02039e4:	0167f733          	and	a4,a5,s6
ffffffffc02039e8:	00a685b3          	add	a1,a3,a0
ffffffffc02039ec:	07b2                	slli	a5,a5,0xc
ffffffffc02039ee:	06c77563          	bgeu	a4,a2,ffffffffc0203a58 <copy_range+0x196>
ffffffffc02039f2:	6605                	lui	a2,0x1
ffffffffc02039f4:	953e                	add	a0,a0,a5
ffffffffc02039f6:	3c3070ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc02039fa:	86a6                	mv	a3,s1
ffffffffc02039fc:	8622                	mv	a2,s0
ffffffffc02039fe:	85ea                	mv	a1,s10
ffffffffc0203a00:	8556                	mv	a0,s5
ffffffffc0203a02:	fd9fe0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0203a06:	d915                	beqz	a0,ffffffffc020393a <copy_range+0x78>
ffffffffc0203a08:	00009697          	auipc	a3,0x9
ffffffffc0203a0c:	32068693          	addi	a3,a3,800 # ffffffffc020cd28 <default_pmm_manager+0x7f8>
ffffffffc0203a10:	00008617          	auipc	a2,0x8
ffffffffc0203a14:	03860613          	addi	a2,a2,56 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203a18:	1ec00593          	li	a1,492
ffffffffc0203a1c:	00009517          	auipc	a0,0x9
ffffffffc0203a20:	c6450513          	addi	a0,a0,-924 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203a24:	a7bfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a28:	00200637          	lui	a2,0x200
ffffffffc0203a2c:	9432                	add	s0,s0,a2
ffffffffc0203a2e:	ffe00637          	lui	a2,0xffe00
ffffffffc0203a32:	8c71                	and	s0,s0,a2
ffffffffc0203a34:	f00406e3          	beqz	s0,ffffffffc0203940 <copy_range+0x7e>
ffffffffc0203a38:	ef2466e3          	bltu	s0,s2,ffffffffc0203924 <copy_range+0x62>
ffffffffc0203a3c:	b711                	j	ffffffffc0203940 <copy_range+0x7e>
ffffffffc0203a3e:	a34fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203a42:	000cb703          	ld	a4,0(s9)
ffffffffc0203a46:	4505                	li	a0,1
ffffffffc0203a48:	6f18                	ld	a4,24(a4)
ffffffffc0203a4a:	9702                	jalr	a4
ffffffffc0203a4c:	8d2a                	mv	s10,a0
ffffffffc0203a4e:	a1efd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203a52:	bfa9                	j	ffffffffc02039ac <copy_range+0xea>
ffffffffc0203a54:	5571                	li	a0,-4
ffffffffc0203a56:	b5f5                	j	ffffffffc0203942 <copy_range+0x80>
ffffffffc0203a58:	86be                	mv	a3,a5
ffffffffc0203a5a:	00009617          	auipc	a2,0x9
ffffffffc0203a5e:	b0e60613          	addi	a2,a2,-1266 # ffffffffc020c568 <default_pmm_manager+0x38>
ffffffffc0203a62:	07100593          	li	a1,113
ffffffffc0203a66:	00009517          	auipc	a0,0x9
ffffffffc0203a6a:	b2a50513          	addi	a0,a0,-1238 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc0203a6e:	a31fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a72:	00009697          	auipc	a3,0x9
ffffffffc0203a76:	29668693          	addi	a3,a3,662 # ffffffffc020cd08 <default_pmm_manager+0x7d8>
ffffffffc0203a7a:	00008617          	auipc	a2,0x8
ffffffffc0203a7e:	fce60613          	addi	a2,a2,-50 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203a82:	1ce00593          	li	a1,462
ffffffffc0203a86:	00009517          	auipc	a0,0x9
ffffffffc0203a8a:	bfa50513          	addi	a0,a0,-1030 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203a8e:	a11fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203a92:	00009697          	auipc	a3,0x9
ffffffffc0203a96:	c5668693          	addi	a3,a3,-938 # ffffffffc020c6e8 <default_pmm_manager+0x1b8>
ffffffffc0203a9a:	00008617          	auipc	a2,0x8
ffffffffc0203a9e:	fae60613          	addi	a2,a2,-82 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203aa2:	1b600593          	li	a1,438
ffffffffc0203aa6:	00009517          	auipc	a0,0x9
ffffffffc0203aaa:	bda50513          	addi	a0,a0,-1062 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203aae:	9f1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203ab2:	00009697          	auipc	a3,0x9
ffffffffc0203ab6:	26668693          	addi	a3,a3,614 # ffffffffc020cd18 <default_pmm_manager+0x7e8>
ffffffffc0203aba:	00008617          	auipc	a2,0x8
ffffffffc0203abe:	f8e60613          	addi	a2,a2,-114 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203ac2:	1cf00593          	li	a1,463
ffffffffc0203ac6:	00009517          	auipc	a0,0x9
ffffffffc0203aca:	bba50513          	addi	a0,a0,-1094 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203ace:	9d1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203ad2:	00009617          	auipc	a2,0x9
ffffffffc0203ad6:	b6660613          	addi	a2,a2,-1178 # ffffffffc020c638 <default_pmm_manager+0x108>
ffffffffc0203ada:	06900593          	li	a1,105
ffffffffc0203ade:	00009517          	auipc	a0,0x9
ffffffffc0203ae2:	ab250513          	addi	a0,a0,-1358 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc0203ae6:	9b9fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203aea:	00009617          	auipc	a2,0x9
ffffffffc0203aee:	b6e60613          	addi	a2,a2,-1170 # ffffffffc020c658 <default_pmm_manager+0x128>
ffffffffc0203af2:	07f00593          	li	a1,127
ffffffffc0203af6:	00009517          	auipc	a0,0x9
ffffffffc0203afa:	a9a50513          	addi	a0,a0,-1382 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc0203afe:	9a1fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203b02:	00009697          	auipc	a3,0x9
ffffffffc0203b06:	bb668693          	addi	a3,a3,-1098 # ffffffffc020c6b8 <default_pmm_manager+0x188>
ffffffffc0203b0a:	00008617          	auipc	a2,0x8
ffffffffc0203b0e:	f3e60613          	addi	a2,a2,-194 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203b12:	1b500593          	li	a1,437
ffffffffc0203b16:	00009517          	auipc	a0,0x9
ffffffffc0203b1a:	b6a50513          	addi	a0,a0,-1174 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203b1e:	981fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203b22 <pgdir_alloc_page>:
ffffffffc0203b22:	7179                	addi	sp,sp,-48
ffffffffc0203b24:	ec26                	sd	s1,24(sp)
ffffffffc0203b26:	e84a                	sd	s2,16(sp)
ffffffffc0203b28:	e052                	sd	s4,0(sp)
ffffffffc0203b2a:	f406                	sd	ra,40(sp)
ffffffffc0203b2c:	f022                	sd	s0,32(sp)
ffffffffc0203b2e:	e44e                	sd	s3,8(sp)
ffffffffc0203b30:	8a2a                	mv	s4,a0
ffffffffc0203b32:	84ae                	mv	s1,a1
ffffffffc0203b34:	8932                	mv	s2,a2
ffffffffc0203b36:	100027f3          	csrr	a5,sstatus
ffffffffc0203b3a:	8b89                	andi	a5,a5,2
ffffffffc0203b3c:	00093997          	auipc	s3,0x93
ffffffffc0203b40:	d7498993          	addi	s3,s3,-652 # ffffffffc02968b0 <pmm_manager>
ffffffffc0203b44:	ef8d                	bnez	a5,ffffffffc0203b7e <pgdir_alloc_page+0x5c>
ffffffffc0203b46:	0009b783          	ld	a5,0(s3)
ffffffffc0203b4a:	4505                	li	a0,1
ffffffffc0203b4c:	6f9c                	ld	a5,24(a5)
ffffffffc0203b4e:	9782                	jalr	a5
ffffffffc0203b50:	842a                	mv	s0,a0
ffffffffc0203b52:	cc09                	beqz	s0,ffffffffc0203b6c <pgdir_alloc_page+0x4a>
ffffffffc0203b54:	86ca                	mv	a3,s2
ffffffffc0203b56:	8626                	mv	a2,s1
ffffffffc0203b58:	85a2                	mv	a1,s0
ffffffffc0203b5a:	8552                	mv	a0,s4
ffffffffc0203b5c:	e7ffe0ef          	jal	ra,ffffffffc02029da <page_insert>
ffffffffc0203b60:	e915                	bnez	a0,ffffffffc0203b94 <pgdir_alloc_page+0x72>
ffffffffc0203b62:	4018                	lw	a4,0(s0)
ffffffffc0203b64:	fc04                	sd	s1,56(s0)
ffffffffc0203b66:	4785                	li	a5,1
ffffffffc0203b68:	04f71e63          	bne	a4,a5,ffffffffc0203bc4 <pgdir_alloc_page+0xa2>
ffffffffc0203b6c:	70a2                	ld	ra,40(sp)
ffffffffc0203b6e:	8522                	mv	a0,s0
ffffffffc0203b70:	7402                	ld	s0,32(sp)
ffffffffc0203b72:	64e2                	ld	s1,24(sp)
ffffffffc0203b74:	6942                	ld	s2,16(sp)
ffffffffc0203b76:	69a2                	ld	s3,8(sp)
ffffffffc0203b78:	6a02                	ld	s4,0(sp)
ffffffffc0203b7a:	6145                	addi	sp,sp,48
ffffffffc0203b7c:	8082                	ret
ffffffffc0203b7e:	8f4fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203b82:	0009b783          	ld	a5,0(s3)
ffffffffc0203b86:	4505                	li	a0,1
ffffffffc0203b88:	6f9c                	ld	a5,24(a5)
ffffffffc0203b8a:	9782                	jalr	a5
ffffffffc0203b8c:	842a                	mv	s0,a0
ffffffffc0203b8e:	8defd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203b92:	b7c1                	j	ffffffffc0203b52 <pgdir_alloc_page+0x30>
ffffffffc0203b94:	100027f3          	csrr	a5,sstatus
ffffffffc0203b98:	8b89                	andi	a5,a5,2
ffffffffc0203b9a:	eb89                	bnez	a5,ffffffffc0203bac <pgdir_alloc_page+0x8a>
ffffffffc0203b9c:	0009b783          	ld	a5,0(s3)
ffffffffc0203ba0:	8522                	mv	a0,s0
ffffffffc0203ba2:	4585                	li	a1,1
ffffffffc0203ba4:	739c                	ld	a5,32(a5)
ffffffffc0203ba6:	4401                	li	s0,0
ffffffffc0203ba8:	9782                	jalr	a5
ffffffffc0203baa:	b7c9                	j	ffffffffc0203b6c <pgdir_alloc_page+0x4a>
ffffffffc0203bac:	8c6fd0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0203bb0:	0009b783          	ld	a5,0(s3)
ffffffffc0203bb4:	8522                	mv	a0,s0
ffffffffc0203bb6:	4585                	li	a1,1
ffffffffc0203bb8:	739c                	ld	a5,32(a5)
ffffffffc0203bba:	4401                	li	s0,0
ffffffffc0203bbc:	9782                	jalr	a5
ffffffffc0203bbe:	8aefd0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0203bc2:	b76d                	j	ffffffffc0203b6c <pgdir_alloc_page+0x4a>
ffffffffc0203bc4:	00009697          	auipc	a3,0x9
ffffffffc0203bc8:	17468693          	addi	a3,a3,372 # ffffffffc020cd38 <default_pmm_manager+0x808>
ffffffffc0203bcc:	00008617          	auipc	a2,0x8
ffffffffc0203bd0:	e7c60613          	addi	a2,a2,-388 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203bd4:	23500593          	li	a1,565
ffffffffc0203bd8:	00009517          	auipc	a0,0x9
ffffffffc0203bdc:	aa850513          	addi	a0,a0,-1368 # ffffffffc020c680 <default_pmm_manager+0x150>
ffffffffc0203be0:	8bffc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203be4 <check_vma_overlap.part.0>:
ffffffffc0203be4:	1141                	addi	sp,sp,-16
ffffffffc0203be6:	00009697          	auipc	a3,0x9
ffffffffc0203bea:	16a68693          	addi	a3,a3,362 # ffffffffc020cd50 <default_pmm_manager+0x820>
ffffffffc0203bee:	00008617          	auipc	a2,0x8
ffffffffc0203bf2:	e5a60613          	addi	a2,a2,-422 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203bf6:	07400593          	li	a1,116
ffffffffc0203bfa:	00009517          	auipc	a0,0x9
ffffffffc0203bfe:	17650513          	addi	a0,a0,374 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc0203c02:	e406                	sd	ra,8(sp)
ffffffffc0203c04:	89bfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203c08 <mm_create>:
ffffffffc0203c08:	1141                	addi	sp,sp,-16
ffffffffc0203c0a:	05800513          	li	a0,88
ffffffffc0203c0e:	e022                	sd	s0,0(sp)
ffffffffc0203c10:	e406                	sd	ra,8(sp)
ffffffffc0203c12:	b7cfe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203c16:	842a                	mv	s0,a0
ffffffffc0203c18:	c115                	beqz	a0,ffffffffc0203c3c <mm_create+0x34>
ffffffffc0203c1a:	e408                	sd	a0,8(s0)
ffffffffc0203c1c:	e008                	sd	a0,0(s0)
ffffffffc0203c1e:	00053823          	sd	zero,16(a0)
ffffffffc0203c22:	00053c23          	sd	zero,24(a0)
ffffffffc0203c26:	02052023          	sw	zero,32(a0)
ffffffffc0203c2a:	02053423          	sd	zero,40(a0)
ffffffffc0203c2e:	02052823          	sw	zero,48(a0)
ffffffffc0203c32:	4585                	li	a1,1
ffffffffc0203c34:	03850513          	addi	a0,a0,56
ffffffffc0203c38:	123000ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc0203c3c:	60a2                	ld	ra,8(sp)
ffffffffc0203c3e:	8522                	mv	a0,s0
ffffffffc0203c40:	6402                	ld	s0,0(sp)
ffffffffc0203c42:	0141                	addi	sp,sp,16
ffffffffc0203c44:	8082                	ret

ffffffffc0203c46 <find_vma>:
ffffffffc0203c46:	86aa                	mv	a3,a0
ffffffffc0203c48:	c505                	beqz	a0,ffffffffc0203c70 <find_vma+0x2a>
ffffffffc0203c4a:	6908                	ld	a0,16(a0)
ffffffffc0203c4c:	c501                	beqz	a0,ffffffffc0203c54 <find_vma+0xe>
ffffffffc0203c4e:	651c                	ld	a5,8(a0)
ffffffffc0203c50:	02f5f263          	bgeu	a1,a5,ffffffffc0203c74 <find_vma+0x2e>
ffffffffc0203c54:	669c                	ld	a5,8(a3)
ffffffffc0203c56:	00f68d63          	beq	a3,a5,ffffffffc0203c70 <find_vma+0x2a>
ffffffffc0203c5a:	fe87b703          	ld	a4,-24(a5) # 1fffe8 <_binary_bin_sfs_img_size+0x18ace8>
ffffffffc0203c5e:	00e5e663          	bltu	a1,a4,ffffffffc0203c6a <find_vma+0x24>
ffffffffc0203c62:	ff07b703          	ld	a4,-16(a5)
ffffffffc0203c66:	00e5ec63          	bltu	a1,a4,ffffffffc0203c7e <find_vma+0x38>
ffffffffc0203c6a:	679c                	ld	a5,8(a5)
ffffffffc0203c6c:	fef697e3          	bne	a3,a5,ffffffffc0203c5a <find_vma+0x14>
ffffffffc0203c70:	4501                	li	a0,0
ffffffffc0203c72:	8082                	ret
ffffffffc0203c74:	691c                	ld	a5,16(a0)
ffffffffc0203c76:	fcf5ffe3          	bgeu	a1,a5,ffffffffc0203c54 <find_vma+0xe>
ffffffffc0203c7a:	ea88                	sd	a0,16(a3)
ffffffffc0203c7c:	8082                	ret
ffffffffc0203c7e:	fe078513          	addi	a0,a5,-32
ffffffffc0203c82:	ea88                	sd	a0,16(a3)
ffffffffc0203c84:	8082                	ret

ffffffffc0203c86 <insert_vma_struct>:
ffffffffc0203c86:	6590                	ld	a2,8(a1)
ffffffffc0203c88:	0105b803          	ld	a6,16(a1) # 80010 <_binary_bin_sfs_img_size+0xad10>
ffffffffc0203c8c:	1141                	addi	sp,sp,-16
ffffffffc0203c8e:	e406                	sd	ra,8(sp)
ffffffffc0203c90:	87aa                	mv	a5,a0
ffffffffc0203c92:	01066763          	bltu	a2,a6,ffffffffc0203ca0 <insert_vma_struct+0x1a>
ffffffffc0203c96:	a085                	j	ffffffffc0203cf6 <insert_vma_struct+0x70>
ffffffffc0203c98:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203c9c:	04e66863          	bltu	a2,a4,ffffffffc0203cec <insert_vma_struct+0x66>
ffffffffc0203ca0:	86be                	mv	a3,a5
ffffffffc0203ca2:	679c                	ld	a5,8(a5)
ffffffffc0203ca4:	fef51ae3          	bne	a0,a5,ffffffffc0203c98 <insert_vma_struct+0x12>
ffffffffc0203ca8:	02a68463          	beq	a3,a0,ffffffffc0203cd0 <insert_vma_struct+0x4a>
ffffffffc0203cac:	ff06b703          	ld	a4,-16(a3)
ffffffffc0203cb0:	fe86b883          	ld	a7,-24(a3)
ffffffffc0203cb4:	08e8f163          	bgeu	a7,a4,ffffffffc0203d36 <insert_vma_struct+0xb0>
ffffffffc0203cb8:	04e66f63          	bltu	a2,a4,ffffffffc0203d16 <insert_vma_struct+0x90>
ffffffffc0203cbc:	00f50a63          	beq	a0,a5,ffffffffc0203cd0 <insert_vma_struct+0x4a>
ffffffffc0203cc0:	fe87b703          	ld	a4,-24(a5)
ffffffffc0203cc4:	05076963          	bltu	a4,a6,ffffffffc0203d16 <insert_vma_struct+0x90>
ffffffffc0203cc8:	ff07b603          	ld	a2,-16(a5)
ffffffffc0203ccc:	02c77363          	bgeu	a4,a2,ffffffffc0203cf2 <insert_vma_struct+0x6c>
ffffffffc0203cd0:	5118                	lw	a4,32(a0)
ffffffffc0203cd2:	e188                	sd	a0,0(a1)
ffffffffc0203cd4:	02058613          	addi	a2,a1,32
ffffffffc0203cd8:	e390                	sd	a2,0(a5)
ffffffffc0203cda:	e690                	sd	a2,8(a3)
ffffffffc0203cdc:	60a2                	ld	ra,8(sp)
ffffffffc0203cde:	f59c                	sd	a5,40(a1)
ffffffffc0203ce0:	f194                	sd	a3,32(a1)
ffffffffc0203ce2:	0017079b          	addiw	a5,a4,1
ffffffffc0203ce6:	d11c                	sw	a5,32(a0)
ffffffffc0203ce8:	0141                	addi	sp,sp,16
ffffffffc0203cea:	8082                	ret
ffffffffc0203cec:	fca690e3          	bne	a3,a0,ffffffffc0203cac <insert_vma_struct+0x26>
ffffffffc0203cf0:	bfd1                	j	ffffffffc0203cc4 <insert_vma_struct+0x3e>
ffffffffc0203cf2:	ef3ff0ef          	jal	ra,ffffffffc0203be4 <check_vma_overlap.part.0>
ffffffffc0203cf6:	00009697          	auipc	a3,0x9
ffffffffc0203cfa:	08a68693          	addi	a3,a3,138 # ffffffffc020cd80 <default_pmm_manager+0x850>
ffffffffc0203cfe:	00008617          	auipc	a2,0x8
ffffffffc0203d02:	d4a60613          	addi	a2,a2,-694 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203d06:	07a00593          	li	a1,122
ffffffffc0203d0a:	00009517          	auipc	a0,0x9
ffffffffc0203d0e:	06650513          	addi	a0,a0,102 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc0203d12:	f8cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203d16:	00009697          	auipc	a3,0x9
ffffffffc0203d1a:	0aa68693          	addi	a3,a3,170 # ffffffffc020cdc0 <default_pmm_manager+0x890>
ffffffffc0203d1e:	00008617          	auipc	a2,0x8
ffffffffc0203d22:	d2a60613          	addi	a2,a2,-726 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203d26:	07300593          	li	a1,115
ffffffffc0203d2a:	00009517          	auipc	a0,0x9
ffffffffc0203d2e:	04650513          	addi	a0,a0,70 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc0203d32:	f6cfc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203d36:	00009697          	auipc	a3,0x9
ffffffffc0203d3a:	06a68693          	addi	a3,a3,106 # ffffffffc020cda0 <default_pmm_manager+0x870>
ffffffffc0203d3e:	00008617          	auipc	a2,0x8
ffffffffc0203d42:	d0a60613          	addi	a2,a2,-758 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203d46:	07200593          	li	a1,114
ffffffffc0203d4a:	00009517          	auipc	a0,0x9
ffffffffc0203d4e:	02650513          	addi	a0,a0,38 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc0203d52:	f4cfc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203d56 <mm_destroy>:
ffffffffc0203d56:	591c                	lw	a5,48(a0)
ffffffffc0203d58:	1141                	addi	sp,sp,-16
ffffffffc0203d5a:	e406                	sd	ra,8(sp)
ffffffffc0203d5c:	e022                	sd	s0,0(sp)
ffffffffc0203d5e:	e78d                	bnez	a5,ffffffffc0203d88 <mm_destroy+0x32>
ffffffffc0203d60:	842a                	mv	s0,a0
ffffffffc0203d62:	6508                	ld	a0,8(a0)
ffffffffc0203d64:	00a40c63          	beq	s0,a0,ffffffffc0203d7c <mm_destroy+0x26>
ffffffffc0203d68:	6118                	ld	a4,0(a0)
ffffffffc0203d6a:	651c                	ld	a5,8(a0)
ffffffffc0203d6c:	1501                	addi	a0,a0,-32
ffffffffc0203d6e:	e71c                	sd	a5,8(a4)
ffffffffc0203d70:	e398                	sd	a4,0(a5)
ffffffffc0203d72:	accfe0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0203d76:	6408                	ld	a0,8(s0)
ffffffffc0203d78:	fea418e3          	bne	s0,a0,ffffffffc0203d68 <mm_destroy+0x12>
ffffffffc0203d7c:	8522                	mv	a0,s0
ffffffffc0203d7e:	6402                	ld	s0,0(sp)
ffffffffc0203d80:	60a2                	ld	ra,8(sp)
ffffffffc0203d82:	0141                	addi	sp,sp,16
ffffffffc0203d84:	abafe06f          	j	ffffffffc020203e <kfree>
ffffffffc0203d88:	00009697          	auipc	a3,0x9
ffffffffc0203d8c:	05868693          	addi	a3,a3,88 # ffffffffc020cde0 <default_pmm_manager+0x8b0>
ffffffffc0203d90:	00008617          	auipc	a2,0x8
ffffffffc0203d94:	cb860613          	addi	a2,a2,-840 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203d98:	09e00593          	li	a1,158
ffffffffc0203d9c:	00009517          	auipc	a0,0x9
ffffffffc0203da0:	fd450513          	addi	a0,a0,-44 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc0203da4:	efafc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203da8 <mm_map>:
ffffffffc0203da8:	7139                	addi	sp,sp,-64
ffffffffc0203daa:	f822                	sd	s0,48(sp)
ffffffffc0203dac:	6405                	lui	s0,0x1
ffffffffc0203dae:	147d                	addi	s0,s0,-1
ffffffffc0203db0:	77fd                	lui	a5,0xfffff
ffffffffc0203db2:	9622                	add	a2,a2,s0
ffffffffc0203db4:	962e                	add	a2,a2,a1
ffffffffc0203db6:	f426                	sd	s1,40(sp)
ffffffffc0203db8:	fc06                	sd	ra,56(sp)
ffffffffc0203dba:	00f5f4b3          	and	s1,a1,a5
ffffffffc0203dbe:	f04a                	sd	s2,32(sp)
ffffffffc0203dc0:	ec4e                	sd	s3,24(sp)
ffffffffc0203dc2:	e852                	sd	s4,16(sp)
ffffffffc0203dc4:	e456                	sd	s5,8(sp)
ffffffffc0203dc6:	002005b7          	lui	a1,0x200
ffffffffc0203dca:	00f67433          	and	s0,a2,a5
ffffffffc0203dce:	06b4e363          	bltu	s1,a1,ffffffffc0203e34 <mm_map+0x8c>
ffffffffc0203dd2:	0684f163          	bgeu	s1,s0,ffffffffc0203e34 <mm_map+0x8c>
ffffffffc0203dd6:	4785                	li	a5,1
ffffffffc0203dd8:	07fe                	slli	a5,a5,0x1f
ffffffffc0203dda:	0487ed63          	bltu	a5,s0,ffffffffc0203e34 <mm_map+0x8c>
ffffffffc0203dde:	89aa                	mv	s3,a0
ffffffffc0203de0:	cd21                	beqz	a0,ffffffffc0203e38 <mm_map+0x90>
ffffffffc0203de2:	85a6                	mv	a1,s1
ffffffffc0203de4:	8ab6                	mv	s5,a3
ffffffffc0203de6:	8a3a                	mv	s4,a4
ffffffffc0203de8:	e5fff0ef          	jal	ra,ffffffffc0203c46 <find_vma>
ffffffffc0203dec:	c501                	beqz	a0,ffffffffc0203df4 <mm_map+0x4c>
ffffffffc0203dee:	651c                	ld	a5,8(a0)
ffffffffc0203df0:	0487e263          	bltu	a5,s0,ffffffffc0203e34 <mm_map+0x8c>
ffffffffc0203df4:	03000513          	li	a0,48
ffffffffc0203df8:	996fe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203dfc:	892a                	mv	s2,a0
ffffffffc0203dfe:	5571                	li	a0,-4
ffffffffc0203e00:	02090163          	beqz	s2,ffffffffc0203e22 <mm_map+0x7a>
ffffffffc0203e04:	854e                	mv	a0,s3
ffffffffc0203e06:	00993423          	sd	s1,8(s2)
ffffffffc0203e0a:	00893823          	sd	s0,16(s2)
ffffffffc0203e0e:	01592c23          	sw	s5,24(s2)
ffffffffc0203e12:	85ca                	mv	a1,s2
ffffffffc0203e14:	e73ff0ef          	jal	ra,ffffffffc0203c86 <insert_vma_struct>
ffffffffc0203e18:	4501                	li	a0,0
ffffffffc0203e1a:	000a0463          	beqz	s4,ffffffffc0203e22 <mm_map+0x7a>
ffffffffc0203e1e:	012a3023          	sd	s2,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0203e22:	70e2                	ld	ra,56(sp)
ffffffffc0203e24:	7442                	ld	s0,48(sp)
ffffffffc0203e26:	74a2                	ld	s1,40(sp)
ffffffffc0203e28:	7902                	ld	s2,32(sp)
ffffffffc0203e2a:	69e2                	ld	s3,24(sp)
ffffffffc0203e2c:	6a42                	ld	s4,16(sp)
ffffffffc0203e2e:	6aa2                	ld	s5,8(sp)
ffffffffc0203e30:	6121                	addi	sp,sp,64
ffffffffc0203e32:	8082                	ret
ffffffffc0203e34:	5575                	li	a0,-3
ffffffffc0203e36:	b7f5                	j	ffffffffc0203e22 <mm_map+0x7a>
ffffffffc0203e38:	00009697          	auipc	a3,0x9
ffffffffc0203e3c:	fc068693          	addi	a3,a3,-64 # ffffffffc020cdf8 <default_pmm_manager+0x8c8>
ffffffffc0203e40:	00008617          	auipc	a2,0x8
ffffffffc0203e44:	c0860613          	addi	a2,a2,-1016 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203e48:	0b300593          	li	a1,179
ffffffffc0203e4c:	00009517          	auipc	a0,0x9
ffffffffc0203e50:	f2450513          	addi	a0,a0,-220 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc0203e54:	e4afc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203e58 <dup_mmap>:
ffffffffc0203e58:	7139                	addi	sp,sp,-64
ffffffffc0203e5a:	fc06                	sd	ra,56(sp)
ffffffffc0203e5c:	f822                	sd	s0,48(sp)
ffffffffc0203e5e:	f426                	sd	s1,40(sp)
ffffffffc0203e60:	f04a                	sd	s2,32(sp)
ffffffffc0203e62:	ec4e                	sd	s3,24(sp)
ffffffffc0203e64:	e852                	sd	s4,16(sp)
ffffffffc0203e66:	e456                	sd	s5,8(sp)
ffffffffc0203e68:	c52d                	beqz	a0,ffffffffc0203ed2 <dup_mmap+0x7a>
ffffffffc0203e6a:	892a                	mv	s2,a0
ffffffffc0203e6c:	84ae                	mv	s1,a1
ffffffffc0203e6e:	842e                	mv	s0,a1
ffffffffc0203e70:	e595                	bnez	a1,ffffffffc0203e9c <dup_mmap+0x44>
ffffffffc0203e72:	a085                	j	ffffffffc0203ed2 <dup_mmap+0x7a>
ffffffffc0203e74:	854a                	mv	a0,s2
ffffffffc0203e76:	0155b423          	sd	s5,8(a1) # 200008 <_binary_bin_sfs_img_size+0x18ad08>
ffffffffc0203e7a:	0145b823          	sd	s4,16(a1)
ffffffffc0203e7e:	0135ac23          	sw	s3,24(a1)
ffffffffc0203e82:	e05ff0ef          	jal	ra,ffffffffc0203c86 <insert_vma_struct>
ffffffffc0203e86:	ff043683          	ld	a3,-16(s0) # ff0 <_binary_bin_swap_img_size-0x6d10>
ffffffffc0203e8a:	fe843603          	ld	a2,-24(s0)
ffffffffc0203e8e:	6c8c                	ld	a1,24(s1)
ffffffffc0203e90:	01893503          	ld	a0,24(s2)
ffffffffc0203e94:	4701                	li	a4,0
ffffffffc0203e96:	a2dff0ef          	jal	ra,ffffffffc02038c2 <copy_range>
ffffffffc0203e9a:	e105                	bnez	a0,ffffffffc0203eba <dup_mmap+0x62>
ffffffffc0203e9c:	6000                	ld	s0,0(s0)
ffffffffc0203e9e:	02848863          	beq	s1,s0,ffffffffc0203ece <dup_mmap+0x76>
ffffffffc0203ea2:	03000513          	li	a0,48
ffffffffc0203ea6:	fe843a83          	ld	s5,-24(s0)
ffffffffc0203eaa:	ff043a03          	ld	s4,-16(s0)
ffffffffc0203eae:	ff842983          	lw	s3,-8(s0)
ffffffffc0203eb2:	8dcfe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203eb6:	85aa                	mv	a1,a0
ffffffffc0203eb8:	fd55                	bnez	a0,ffffffffc0203e74 <dup_mmap+0x1c>
ffffffffc0203eba:	5571                	li	a0,-4
ffffffffc0203ebc:	70e2                	ld	ra,56(sp)
ffffffffc0203ebe:	7442                	ld	s0,48(sp)
ffffffffc0203ec0:	74a2                	ld	s1,40(sp)
ffffffffc0203ec2:	7902                	ld	s2,32(sp)
ffffffffc0203ec4:	69e2                	ld	s3,24(sp)
ffffffffc0203ec6:	6a42                	ld	s4,16(sp)
ffffffffc0203ec8:	6aa2                	ld	s5,8(sp)
ffffffffc0203eca:	6121                	addi	sp,sp,64
ffffffffc0203ecc:	8082                	ret
ffffffffc0203ece:	4501                	li	a0,0
ffffffffc0203ed0:	b7f5                	j	ffffffffc0203ebc <dup_mmap+0x64>
ffffffffc0203ed2:	00009697          	auipc	a3,0x9
ffffffffc0203ed6:	f3668693          	addi	a3,a3,-202 # ffffffffc020ce08 <default_pmm_manager+0x8d8>
ffffffffc0203eda:	00008617          	auipc	a2,0x8
ffffffffc0203ede:	b6e60613          	addi	a2,a2,-1170 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203ee2:	0cf00593          	li	a1,207
ffffffffc0203ee6:	00009517          	auipc	a0,0x9
ffffffffc0203eea:	e8a50513          	addi	a0,a0,-374 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc0203eee:	db0fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203ef2 <exit_mmap>:
ffffffffc0203ef2:	1101                	addi	sp,sp,-32
ffffffffc0203ef4:	ec06                	sd	ra,24(sp)
ffffffffc0203ef6:	e822                	sd	s0,16(sp)
ffffffffc0203ef8:	e426                	sd	s1,8(sp)
ffffffffc0203efa:	e04a                	sd	s2,0(sp)
ffffffffc0203efc:	c531                	beqz	a0,ffffffffc0203f48 <exit_mmap+0x56>
ffffffffc0203efe:	591c                	lw	a5,48(a0)
ffffffffc0203f00:	84aa                	mv	s1,a0
ffffffffc0203f02:	e3b9                	bnez	a5,ffffffffc0203f48 <exit_mmap+0x56>
ffffffffc0203f04:	6500                	ld	s0,8(a0)
ffffffffc0203f06:	01853903          	ld	s2,24(a0)
ffffffffc0203f0a:	02850663          	beq	a0,s0,ffffffffc0203f36 <exit_mmap+0x44>
ffffffffc0203f0e:	ff043603          	ld	a2,-16(s0)
ffffffffc0203f12:	fe843583          	ld	a1,-24(s0)
ffffffffc0203f16:	854a                	mv	a0,s2
ffffffffc0203f18:	e4efe0ef          	jal	ra,ffffffffc0202566 <unmap_range>
ffffffffc0203f1c:	6400                	ld	s0,8(s0)
ffffffffc0203f1e:	fe8498e3          	bne	s1,s0,ffffffffc0203f0e <exit_mmap+0x1c>
ffffffffc0203f22:	6400                	ld	s0,8(s0)
ffffffffc0203f24:	00848c63          	beq	s1,s0,ffffffffc0203f3c <exit_mmap+0x4a>
ffffffffc0203f28:	ff043603          	ld	a2,-16(s0)
ffffffffc0203f2c:	fe843583          	ld	a1,-24(s0)
ffffffffc0203f30:	854a                	mv	a0,s2
ffffffffc0203f32:	f7afe0ef          	jal	ra,ffffffffc02026ac <exit_range>
ffffffffc0203f36:	6400                	ld	s0,8(s0)
ffffffffc0203f38:	fe8498e3          	bne	s1,s0,ffffffffc0203f28 <exit_mmap+0x36>
ffffffffc0203f3c:	60e2                	ld	ra,24(sp)
ffffffffc0203f3e:	6442                	ld	s0,16(sp)
ffffffffc0203f40:	64a2                	ld	s1,8(sp)
ffffffffc0203f42:	6902                	ld	s2,0(sp)
ffffffffc0203f44:	6105                	addi	sp,sp,32
ffffffffc0203f46:	8082                	ret
ffffffffc0203f48:	00009697          	auipc	a3,0x9
ffffffffc0203f4c:	ee068693          	addi	a3,a3,-288 # ffffffffc020ce28 <default_pmm_manager+0x8f8>
ffffffffc0203f50:	00008617          	auipc	a2,0x8
ffffffffc0203f54:	af860613          	addi	a2,a2,-1288 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203f58:	0e800593          	li	a1,232
ffffffffc0203f5c:	00009517          	auipc	a0,0x9
ffffffffc0203f60:	e1450513          	addi	a0,a0,-492 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc0203f64:	d3afc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0203f68 <vmm_init>:
ffffffffc0203f68:	7139                	addi	sp,sp,-64
ffffffffc0203f6a:	05800513          	li	a0,88
ffffffffc0203f6e:	fc06                	sd	ra,56(sp)
ffffffffc0203f70:	f822                	sd	s0,48(sp)
ffffffffc0203f72:	f426                	sd	s1,40(sp)
ffffffffc0203f74:	f04a                	sd	s2,32(sp)
ffffffffc0203f76:	ec4e                	sd	s3,24(sp)
ffffffffc0203f78:	e852                	sd	s4,16(sp)
ffffffffc0203f7a:	e456                	sd	s5,8(sp)
ffffffffc0203f7c:	812fe0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203f80:	2e050963          	beqz	a0,ffffffffc0204272 <vmm_init+0x30a>
ffffffffc0203f84:	e508                	sd	a0,8(a0)
ffffffffc0203f86:	e108                	sd	a0,0(a0)
ffffffffc0203f88:	00053823          	sd	zero,16(a0)
ffffffffc0203f8c:	00053c23          	sd	zero,24(a0)
ffffffffc0203f90:	02052023          	sw	zero,32(a0)
ffffffffc0203f94:	02053423          	sd	zero,40(a0)
ffffffffc0203f98:	02052823          	sw	zero,48(a0)
ffffffffc0203f9c:	84aa                	mv	s1,a0
ffffffffc0203f9e:	4585                	li	a1,1
ffffffffc0203fa0:	03850513          	addi	a0,a0,56
ffffffffc0203fa4:	5b6000ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc0203fa8:	03200413          	li	s0,50
ffffffffc0203fac:	a811                	j	ffffffffc0203fc0 <vmm_init+0x58>
ffffffffc0203fae:	e500                	sd	s0,8(a0)
ffffffffc0203fb0:	e91c                	sd	a5,16(a0)
ffffffffc0203fb2:	00052c23          	sw	zero,24(a0)
ffffffffc0203fb6:	146d                	addi	s0,s0,-5
ffffffffc0203fb8:	8526                	mv	a0,s1
ffffffffc0203fba:	ccdff0ef          	jal	ra,ffffffffc0203c86 <insert_vma_struct>
ffffffffc0203fbe:	c80d                	beqz	s0,ffffffffc0203ff0 <vmm_init+0x88>
ffffffffc0203fc0:	03000513          	li	a0,48
ffffffffc0203fc4:	fcbfd0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0203fc8:	85aa                	mv	a1,a0
ffffffffc0203fca:	00240793          	addi	a5,s0,2
ffffffffc0203fce:	f165                	bnez	a0,ffffffffc0203fae <vmm_init+0x46>
ffffffffc0203fd0:	00009697          	auipc	a3,0x9
ffffffffc0203fd4:	ff068693          	addi	a3,a3,-16 # ffffffffc020cfc0 <default_pmm_manager+0xa90>
ffffffffc0203fd8:	00008617          	auipc	a2,0x8
ffffffffc0203fdc:	a7060613          	addi	a2,a2,-1424 # ffffffffc020ba48 <commands+0x210>
ffffffffc0203fe0:	12c00593          	li	a1,300
ffffffffc0203fe4:	00009517          	auipc	a0,0x9
ffffffffc0203fe8:	d8c50513          	addi	a0,a0,-628 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc0203fec:	cb2fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0203ff0:	03700413          	li	s0,55
ffffffffc0203ff4:	1f900913          	li	s2,505
ffffffffc0203ff8:	a819                	j	ffffffffc020400e <vmm_init+0xa6>
ffffffffc0203ffa:	e500                	sd	s0,8(a0)
ffffffffc0203ffc:	e91c                	sd	a5,16(a0)
ffffffffc0203ffe:	00052c23          	sw	zero,24(a0)
ffffffffc0204002:	0415                	addi	s0,s0,5
ffffffffc0204004:	8526                	mv	a0,s1
ffffffffc0204006:	c81ff0ef          	jal	ra,ffffffffc0203c86 <insert_vma_struct>
ffffffffc020400a:	03240a63          	beq	s0,s2,ffffffffc020403e <vmm_init+0xd6>
ffffffffc020400e:	03000513          	li	a0,48
ffffffffc0204012:	f7dfd0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0204016:	85aa                	mv	a1,a0
ffffffffc0204018:	00240793          	addi	a5,s0,2
ffffffffc020401c:	fd79                	bnez	a0,ffffffffc0203ffa <vmm_init+0x92>
ffffffffc020401e:	00009697          	auipc	a3,0x9
ffffffffc0204022:	fa268693          	addi	a3,a3,-94 # ffffffffc020cfc0 <default_pmm_manager+0xa90>
ffffffffc0204026:	00008617          	auipc	a2,0x8
ffffffffc020402a:	a2260613          	addi	a2,a2,-1502 # ffffffffc020ba48 <commands+0x210>
ffffffffc020402e:	13300593          	li	a1,307
ffffffffc0204032:	00009517          	auipc	a0,0x9
ffffffffc0204036:	d3e50513          	addi	a0,a0,-706 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc020403a:	c64fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020403e:	649c                	ld	a5,8(s1)
ffffffffc0204040:	471d                	li	a4,7
ffffffffc0204042:	1fb00593          	li	a1,507
ffffffffc0204046:	16f48663          	beq	s1,a5,ffffffffc02041b2 <vmm_init+0x24a>
ffffffffc020404a:	fe87b603          	ld	a2,-24(a5) # ffffffffffffefe8 <end+0x3fd686d8>
ffffffffc020404e:	ffe70693          	addi	a3,a4,-2
ffffffffc0204052:	10d61063          	bne	a2,a3,ffffffffc0204152 <vmm_init+0x1ea>
ffffffffc0204056:	ff07b683          	ld	a3,-16(a5)
ffffffffc020405a:	0ed71c63          	bne	a4,a3,ffffffffc0204152 <vmm_init+0x1ea>
ffffffffc020405e:	0715                	addi	a4,a4,5
ffffffffc0204060:	679c                	ld	a5,8(a5)
ffffffffc0204062:	feb712e3          	bne	a4,a1,ffffffffc0204046 <vmm_init+0xde>
ffffffffc0204066:	4a1d                	li	s4,7
ffffffffc0204068:	4415                	li	s0,5
ffffffffc020406a:	1f900a93          	li	s5,505
ffffffffc020406e:	85a2                	mv	a1,s0
ffffffffc0204070:	8526                	mv	a0,s1
ffffffffc0204072:	bd5ff0ef          	jal	ra,ffffffffc0203c46 <find_vma>
ffffffffc0204076:	892a                	mv	s2,a0
ffffffffc0204078:	16050d63          	beqz	a0,ffffffffc02041f2 <vmm_init+0x28a>
ffffffffc020407c:	00140593          	addi	a1,s0,1
ffffffffc0204080:	8526                	mv	a0,s1
ffffffffc0204082:	bc5ff0ef          	jal	ra,ffffffffc0203c46 <find_vma>
ffffffffc0204086:	89aa                	mv	s3,a0
ffffffffc0204088:	14050563          	beqz	a0,ffffffffc02041d2 <vmm_init+0x26a>
ffffffffc020408c:	85d2                	mv	a1,s4
ffffffffc020408e:	8526                	mv	a0,s1
ffffffffc0204090:	bb7ff0ef          	jal	ra,ffffffffc0203c46 <find_vma>
ffffffffc0204094:	16051f63          	bnez	a0,ffffffffc0204212 <vmm_init+0x2aa>
ffffffffc0204098:	00340593          	addi	a1,s0,3
ffffffffc020409c:	8526                	mv	a0,s1
ffffffffc020409e:	ba9ff0ef          	jal	ra,ffffffffc0203c46 <find_vma>
ffffffffc02040a2:	1a051863          	bnez	a0,ffffffffc0204252 <vmm_init+0x2ea>
ffffffffc02040a6:	00440593          	addi	a1,s0,4
ffffffffc02040aa:	8526                	mv	a0,s1
ffffffffc02040ac:	b9bff0ef          	jal	ra,ffffffffc0203c46 <find_vma>
ffffffffc02040b0:	18051163          	bnez	a0,ffffffffc0204232 <vmm_init+0x2ca>
ffffffffc02040b4:	00893783          	ld	a5,8(s2)
ffffffffc02040b8:	0a879d63          	bne	a5,s0,ffffffffc0204172 <vmm_init+0x20a>
ffffffffc02040bc:	01093783          	ld	a5,16(s2)
ffffffffc02040c0:	0b479963          	bne	a5,s4,ffffffffc0204172 <vmm_init+0x20a>
ffffffffc02040c4:	0089b783          	ld	a5,8(s3)
ffffffffc02040c8:	0c879563          	bne	a5,s0,ffffffffc0204192 <vmm_init+0x22a>
ffffffffc02040cc:	0109b783          	ld	a5,16(s3)
ffffffffc02040d0:	0d479163          	bne	a5,s4,ffffffffc0204192 <vmm_init+0x22a>
ffffffffc02040d4:	0415                	addi	s0,s0,5
ffffffffc02040d6:	0a15                	addi	s4,s4,5
ffffffffc02040d8:	f9541be3          	bne	s0,s5,ffffffffc020406e <vmm_init+0x106>
ffffffffc02040dc:	4411                	li	s0,4
ffffffffc02040de:	597d                	li	s2,-1
ffffffffc02040e0:	85a2                	mv	a1,s0
ffffffffc02040e2:	8526                	mv	a0,s1
ffffffffc02040e4:	b63ff0ef          	jal	ra,ffffffffc0203c46 <find_vma>
ffffffffc02040e8:	0004059b          	sext.w	a1,s0
ffffffffc02040ec:	c90d                	beqz	a0,ffffffffc020411e <vmm_init+0x1b6>
ffffffffc02040ee:	6914                	ld	a3,16(a0)
ffffffffc02040f0:	6510                	ld	a2,8(a0)
ffffffffc02040f2:	00009517          	auipc	a0,0x9
ffffffffc02040f6:	e5650513          	addi	a0,a0,-426 # ffffffffc020cf48 <default_pmm_manager+0xa18>
ffffffffc02040fa:	8acfc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02040fe:	00009697          	auipc	a3,0x9
ffffffffc0204102:	e7268693          	addi	a3,a3,-398 # ffffffffc020cf70 <default_pmm_manager+0xa40>
ffffffffc0204106:	00008617          	auipc	a2,0x8
ffffffffc020410a:	94260613          	addi	a2,a2,-1726 # ffffffffc020ba48 <commands+0x210>
ffffffffc020410e:	15900593          	li	a1,345
ffffffffc0204112:	00009517          	auipc	a0,0x9
ffffffffc0204116:	c5e50513          	addi	a0,a0,-930 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc020411a:	b84fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020411e:	147d                	addi	s0,s0,-1
ffffffffc0204120:	fd2410e3          	bne	s0,s2,ffffffffc02040e0 <vmm_init+0x178>
ffffffffc0204124:	8526                	mv	a0,s1
ffffffffc0204126:	c31ff0ef          	jal	ra,ffffffffc0203d56 <mm_destroy>
ffffffffc020412a:	00009517          	auipc	a0,0x9
ffffffffc020412e:	e5e50513          	addi	a0,a0,-418 # ffffffffc020cf88 <default_pmm_manager+0xa58>
ffffffffc0204132:	874fc0ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0204136:	7442                	ld	s0,48(sp)
ffffffffc0204138:	70e2                	ld	ra,56(sp)
ffffffffc020413a:	74a2                	ld	s1,40(sp)
ffffffffc020413c:	7902                	ld	s2,32(sp)
ffffffffc020413e:	69e2                	ld	s3,24(sp)
ffffffffc0204140:	6a42                	ld	s4,16(sp)
ffffffffc0204142:	6aa2                	ld	s5,8(sp)
ffffffffc0204144:	00009517          	auipc	a0,0x9
ffffffffc0204148:	e6450513          	addi	a0,a0,-412 # ffffffffc020cfa8 <default_pmm_manager+0xa78>
ffffffffc020414c:	6121                	addi	sp,sp,64
ffffffffc020414e:	858fc06f          	j	ffffffffc02001a6 <cprintf>
ffffffffc0204152:	00009697          	auipc	a3,0x9
ffffffffc0204156:	d0e68693          	addi	a3,a3,-754 # ffffffffc020ce60 <default_pmm_manager+0x930>
ffffffffc020415a:	00008617          	auipc	a2,0x8
ffffffffc020415e:	8ee60613          	addi	a2,a2,-1810 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204162:	13d00593          	li	a1,317
ffffffffc0204166:	00009517          	auipc	a0,0x9
ffffffffc020416a:	c0a50513          	addi	a0,a0,-1014 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc020416e:	b30fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204172:	00009697          	auipc	a3,0x9
ffffffffc0204176:	d7668693          	addi	a3,a3,-650 # ffffffffc020cee8 <default_pmm_manager+0x9b8>
ffffffffc020417a:	00008617          	auipc	a2,0x8
ffffffffc020417e:	8ce60613          	addi	a2,a2,-1842 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204182:	14e00593          	li	a1,334
ffffffffc0204186:	00009517          	auipc	a0,0x9
ffffffffc020418a:	bea50513          	addi	a0,a0,-1046 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc020418e:	b10fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204192:	00009697          	auipc	a3,0x9
ffffffffc0204196:	d8668693          	addi	a3,a3,-634 # ffffffffc020cf18 <default_pmm_manager+0x9e8>
ffffffffc020419a:	00008617          	auipc	a2,0x8
ffffffffc020419e:	8ae60613          	addi	a2,a2,-1874 # ffffffffc020ba48 <commands+0x210>
ffffffffc02041a2:	14f00593          	li	a1,335
ffffffffc02041a6:	00009517          	auipc	a0,0x9
ffffffffc02041aa:	bca50513          	addi	a0,a0,-1078 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc02041ae:	af0fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041b2:	00009697          	auipc	a3,0x9
ffffffffc02041b6:	c9668693          	addi	a3,a3,-874 # ffffffffc020ce48 <default_pmm_manager+0x918>
ffffffffc02041ba:	00008617          	auipc	a2,0x8
ffffffffc02041be:	88e60613          	addi	a2,a2,-1906 # ffffffffc020ba48 <commands+0x210>
ffffffffc02041c2:	13b00593          	li	a1,315
ffffffffc02041c6:	00009517          	auipc	a0,0x9
ffffffffc02041ca:	baa50513          	addi	a0,a0,-1110 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc02041ce:	ad0fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041d2:	00009697          	auipc	a3,0x9
ffffffffc02041d6:	cd668693          	addi	a3,a3,-810 # ffffffffc020cea8 <default_pmm_manager+0x978>
ffffffffc02041da:	00008617          	auipc	a2,0x8
ffffffffc02041de:	86e60613          	addi	a2,a2,-1938 # ffffffffc020ba48 <commands+0x210>
ffffffffc02041e2:	14600593          	li	a1,326
ffffffffc02041e6:	00009517          	auipc	a0,0x9
ffffffffc02041ea:	b8a50513          	addi	a0,a0,-1142 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc02041ee:	ab0fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02041f2:	00009697          	auipc	a3,0x9
ffffffffc02041f6:	ca668693          	addi	a3,a3,-858 # ffffffffc020ce98 <default_pmm_manager+0x968>
ffffffffc02041fa:	00008617          	auipc	a2,0x8
ffffffffc02041fe:	84e60613          	addi	a2,a2,-1970 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204202:	14400593          	li	a1,324
ffffffffc0204206:	00009517          	auipc	a0,0x9
ffffffffc020420a:	b6a50513          	addi	a0,a0,-1174 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc020420e:	a90fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204212:	00009697          	auipc	a3,0x9
ffffffffc0204216:	ca668693          	addi	a3,a3,-858 # ffffffffc020ceb8 <default_pmm_manager+0x988>
ffffffffc020421a:	00008617          	auipc	a2,0x8
ffffffffc020421e:	82e60613          	addi	a2,a2,-2002 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204222:	14800593          	li	a1,328
ffffffffc0204226:	00009517          	auipc	a0,0x9
ffffffffc020422a:	b4a50513          	addi	a0,a0,-1206 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc020422e:	a70fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204232:	00009697          	auipc	a3,0x9
ffffffffc0204236:	ca668693          	addi	a3,a3,-858 # ffffffffc020ced8 <default_pmm_manager+0x9a8>
ffffffffc020423a:	00008617          	auipc	a2,0x8
ffffffffc020423e:	80e60613          	addi	a2,a2,-2034 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204242:	14c00593          	li	a1,332
ffffffffc0204246:	00009517          	auipc	a0,0x9
ffffffffc020424a:	b2a50513          	addi	a0,a0,-1238 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc020424e:	a50fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204252:	00009697          	auipc	a3,0x9
ffffffffc0204256:	c7668693          	addi	a3,a3,-906 # ffffffffc020cec8 <default_pmm_manager+0x998>
ffffffffc020425a:	00007617          	auipc	a2,0x7
ffffffffc020425e:	7ee60613          	addi	a2,a2,2030 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204262:	14a00593          	li	a1,330
ffffffffc0204266:	00009517          	auipc	a0,0x9
ffffffffc020426a:	b0a50513          	addi	a0,a0,-1270 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc020426e:	a30fc0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204272:	00009697          	auipc	a3,0x9
ffffffffc0204276:	b8668693          	addi	a3,a3,-1146 # ffffffffc020cdf8 <default_pmm_manager+0x8c8>
ffffffffc020427a:	00007617          	auipc	a2,0x7
ffffffffc020427e:	7ce60613          	addi	a2,a2,1998 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204282:	12400593          	li	a1,292
ffffffffc0204286:	00009517          	auipc	a0,0x9
ffffffffc020428a:	aea50513          	addi	a0,a0,-1302 # ffffffffc020cd70 <default_pmm_manager+0x840>
ffffffffc020428e:	a10fc0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204292 <user_mem_check>:
ffffffffc0204292:	7179                	addi	sp,sp,-48
ffffffffc0204294:	f022                	sd	s0,32(sp)
ffffffffc0204296:	f406                	sd	ra,40(sp)
ffffffffc0204298:	ec26                	sd	s1,24(sp)
ffffffffc020429a:	e84a                	sd	s2,16(sp)
ffffffffc020429c:	e44e                	sd	s3,8(sp)
ffffffffc020429e:	e052                	sd	s4,0(sp)
ffffffffc02042a0:	842e                	mv	s0,a1
ffffffffc02042a2:	c135                	beqz	a0,ffffffffc0204306 <user_mem_check+0x74>
ffffffffc02042a4:	002007b7          	lui	a5,0x200
ffffffffc02042a8:	04f5e663          	bltu	a1,a5,ffffffffc02042f4 <user_mem_check+0x62>
ffffffffc02042ac:	00c584b3          	add	s1,a1,a2
ffffffffc02042b0:	0495f263          	bgeu	a1,s1,ffffffffc02042f4 <user_mem_check+0x62>
ffffffffc02042b4:	4785                	li	a5,1
ffffffffc02042b6:	07fe                	slli	a5,a5,0x1f
ffffffffc02042b8:	0297ee63          	bltu	a5,s1,ffffffffc02042f4 <user_mem_check+0x62>
ffffffffc02042bc:	892a                	mv	s2,a0
ffffffffc02042be:	89b6                	mv	s3,a3
ffffffffc02042c0:	6a05                	lui	s4,0x1
ffffffffc02042c2:	a821                	j	ffffffffc02042da <user_mem_check+0x48>
ffffffffc02042c4:	0027f693          	andi	a3,a5,2
ffffffffc02042c8:	9752                	add	a4,a4,s4
ffffffffc02042ca:	8ba1                	andi	a5,a5,8
ffffffffc02042cc:	c685                	beqz	a3,ffffffffc02042f4 <user_mem_check+0x62>
ffffffffc02042ce:	c399                	beqz	a5,ffffffffc02042d4 <user_mem_check+0x42>
ffffffffc02042d0:	02e46263          	bltu	s0,a4,ffffffffc02042f4 <user_mem_check+0x62>
ffffffffc02042d4:	6900                	ld	s0,16(a0)
ffffffffc02042d6:	04947663          	bgeu	s0,s1,ffffffffc0204322 <user_mem_check+0x90>
ffffffffc02042da:	85a2                	mv	a1,s0
ffffffffc02042dc:	854a                	mv	a0,s2
ffffffffc02042de:	969ff0ef          	jal	ra,ffffffffc0203c46 <find_vma>
ffffffffc02042e2:	c909                	beqz	a0,ffffffffc02042f4 <user_mem_check+0x62>
ffffffffc02042e4:	6518                	ld	a4,8(a0)
ffffffffc02042e6:	00e46763          	bltu	s0,a4,ffffffffc02042f4 <user_mem_check+0x62>
ffffffffc02042ea:	4d1c                	lw	a5,24(a0)
ffffffffc02042ec:	fc099ce3          	bnez	s3,ffffffffc02042c4 <user_mem_check+0x32>
ffffffffc02042f0:	8b85                	andi	a5,a5,1
ffffffffc02042f2:	f3ed                	bnez	a5,ffffffffc02042d4 <user_mem_check+0x42>
ffffffffc02042f4:	4501                	li	a0,0
ffffffffc02042f6:	70a2                	ld	ra,40(sp)
ffffffffc02042f8:	7402                	ld	s0,32(sp)
ffffffffc02042fa:	64e2                	ld	s1,24(sp)
ffffffffc02042fc:	6942                	ld	s2,16(sp)
ffffffffc02042fe:	69a2                	ld	s3,8(sp)
ffffffffc0204300:	6a02                	ld	s4,0(sp)
ffffffffc0204302:	6145                	addi	sp,sp,48
ffffffffc0204304:	8082                	ret
ffffffffc0204306:	c02007b7          	lui	a5,0xc0200
ffffffffc020430a:	4501                	li	a0,0
ffffffffc020430c:	fef5e5e3          	bltu	a1,a5,ffffffffc02042f6 <user_mem_check+0x64>
ffffffffc0204310:	962e                	add	a2,a2,a1
ffffffffc0204312:	fec5f2e3          	bgeu	a1,a2,ffffffffc02042f6 <user_mem_check+0x64>
ffffffffc0204316:	c8000537          	lui	a0,0xc8000
ffffffffc020431a:	0505                	addi	a0,a0,1
ffffffffc020431c:	00a63533          	sltu	a0,a2,a0
ffffffffc0204320:	bfd9                	j	ffffffffc02042f6 <user_mem_check+0x64>
ffffffffc0204322:	4505                	li	a0,1
ffffffffc0204324:	bfc9                	j	ffffffffc02042f6 <user_mem_check+0x64>

ffffffffc0204326 <copy_from_user>:
ffffffffc0204326:	1101                	addi	sp,sp,-32
ffffffffc0204328:	e822                	sd	s0,16(sp)
ffffffffc020432a:	e426                	sd	s1,8(sp)
ffffffffc020432c:	8432                	mv	s0,a2
ffffffffc020432e:	84b6                	mv	s1,a3
ffffffffc0204330:	e04a                	sd	s2,0(sp)
ffffffffc0204332:	86ba                	mv	a3,a4
ffffffffc0204334:	892e                	mv	s2,a1
ffffffffc0204336:	8626                	mv	a2,s1
ffffffffc0204338:	85a2                	mv	a1,s0
ffffffffc020433a:	ec06                	sd	ra,24(sp)
ffffffffc020433c:	f57ff0ef          	jal	ra,ffffffffc0204292 <user_mem_check>
ffffffffc0204340:	c519                	beqz	a0,ffffffffc020434e <copy_from_user+0x28>
ffffffffc0204342:	8626                	mv	a2,s1
ffffffffc0204344:	85a2                	mv	a1,s0
ffffffffc0204346:	854a                	mv	a0,s2
ffffffffc0204348:	270070ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc020434c:	4505                	li	a0,1
ffffffffc020434e:	60e2                	ld	ra,24(sp)
ffffffffc0204350:	6442                	ld	s0,16(sp)
ffffffffc0204352:	64a2                	ld	s1,8(sp)
ffffffffc0204354:	6902                	ld	s2,0(sp)
ffffffffc0204356:	6105                	addi	sp,sp,32
ffffffffc0204358:	8082                	ret

ffffffffc020435a <copy_to_user>:
ffffffffc020435a:	1101                	addi	sp,sp,-32
ffffffffc020435c:	e822                	sd	s0,16(sp)
ffffffffc020435e:	8436                	mv	s0,a3
ffffffffc0204360:	e04a                	sd	s2,0(sp)
ffffffffc0204362:	4685                	li	a3,1
ffffffffc0204364:	8932                	mv	s2,a2
ffffffffc0204366:	8622                	mv	a2,s0
ffffffffc0204368:	e426                	sd	s1,8(sp)
ffffffffc020436a:	ec06                	sd	ra,24(sp)
ffffffffc020436c:	84ae                	mv	s1,a1
ffffffffc020436e:	f25ff0ef          	jal	ra,ffffffffc0204292 <user_mem_check>
ffffffffc0204372:	c519                	beqz	a0,ffffffffc0204380 <copy_to_user+0x26>
ffffffffc0204374:	8622                	mv	a2,s0
ffffffffc0204376:	85ca                	mv	a1,s2
ffffffffc0204378:	8526                	mv	a0,s1
ffffffffc020437a:	23e070ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc020437e:	4505                	li	a0,1
ffffffffc0204380:	60e2                	ld	ra,24(sp)
ffffffffc0204382:	6442                	ld	s0,16(sp)
ffffffffc0204384:	64a2                	ld	s1,8(sp)
ffffffffc0204386:	6902                	ld	s2,0(sp)
ffffffffc0204388:	6105                	addi	sp,sp,32
ffffffffc020438a:	8082                	ret

ffffffffc020438c <copy_string>:
ffffffffc020438c:	7139                	addi	sp,sp,-64
ffffffffc020438e:	ec4e                	sd	s3,24(sp)
ffffffffc0204390:	6985                	lui	s3,0x1
ffffffffc0204392:	99b2                	add	s3,s3,a2
ffffffffc0204394:	77fd                	lui	a5,0xfffff
ffffffffc0204396:	00f9f9b3          	and	s3,s3,a5
ffffffffc020439a:	f426                	sd	s1,40(sp)
ffffffffc020439c:	f04a                	sd	s2,32(sp)
ffffffffc020439e:	e852                	sd	s4,16(sp)
ffffffffc02043a0:	e456                	sd	s5,8(sp)
ffffffffc02043a2:	fc06                	sd	ra,56(sp)
ffffffffc02043a4:	f822                	sd	s0,48(sp)
ffffffffc02043a6:	84b2                	mv	s1,a2
ffffffffc02043a8:	8aaa                	mv	s5,a0
ffffffffc02043aa:	8a2e                	mv	s4,a1
ffffffffc02043ac:	8936                	mv	s2,a3
ffffffffc02043ae:	40c989b3          	sub	s3,s3,a2
ffffffffc02043b2:	a015                	j	ffffffffc02043d6 <copy_string+0x4a>
ffffffffc02043b4:	12a070ef          	jal	ra,ffffffffc020b4de <strnlen>
ffffffffc02043b8:	87aa                	mv	a5,a0
ffffffffc02043ba:	85a6                	mv	a1,s1
ffffffffc02043bc:	8552                	mv	a0,s4
ffffffffc02043be:	8622                	mv	a2,s0
ffffffffc02043c0:	0487e363          	bltu	a5,s0,ffffffffc0204406 <copy_string+0x7a>
ffffffffc02043c4:	0329f763          	bgeu	s3,s2,ffffffffc02043f2 <copy_string+0x66>
ffffffffc02043c8:	1f0070ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc02043cc:	9a22                	add	s4,s4,s0
ffffffffc02043ce:	94a2                	add	s1,s1,s0
ffffffffc02043d0:	40890933          	sub	s2,s2,s0
ffffffffc02043d4:	6985                	lui	s3,0x1
ffffffffc02043d6:	4681                	li	a3,0
ffffffffc02043d8:	85a6                	mv	a1,s1
ffffffffc02043da:	8556                	mv	a0,s5
ffffffffc02043dc:	844a                	mv	s0,s2
ffffffffc02043de:	0129f363          	bgeu	s3,s2,ffffffffc02043e4 <copy_string+0x58>
ffffffffc02043e2:	844e                	mv	s0,s3
ffffffffc02043e4:	8622                	mv	a2,s0
ffffffffc02043e6:	eadff0ef          	jal	ra,ffffffffc0204292 <user_mem_check>
ffffffffc02043ea:	87aa                	mv	a5,a0
ffffffffc02043ec:	85a2                	mv	a1,s0
ffffffffc02043ee:	8526                	mv	a0,s1
ffffffffc02043f0:	f3f1                	bnez	a5,ffffffffc02043b4 <copy_string+0x28>
ffffffffc02043f2:	4501                	li	a0,0
ffffffffc02043f4:	70e2                	ld	ra,56(sp)
ffffffffc02043f6:	7442                	ld	s0,48(sp)
ffffffffc02043f8:	74a2                	ld	s1,40(sp)
ffffffffc02043fa:	7902                	ld	s2,32(sp)
ffffffffc02043fc:	69e2                	ld	s3,24(sp)
ffffffffc02043fe:	6a42                	ld	s4,16(sp)
ffffffffc0204400:	6aa2                	ld	s5,8(sp)
ffffffffc0204402:	6121                	addi	sp,sp,64
ffffffffc0204404:	8082                	ret
ffffffffc0204406:	00178613          	addi	a2,a5,1 # fffffffffffff001 <end+0x3fd686f1>
ffffffffc020440a:	1ae070ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc020440e:	4505                	li	a0,1
ffffffffc0204410:	b7d5                	j	ffffffffc02043f4 <copy_string+0x68>

ffffffffc0204412 <__down.constprop.0>:
ffffffffc0204412:	715d                	addi	sp,sp,-80
ffffffffc0204414:	e0a2                	sd	s0,64(sp)
ffffffffc0204416:	e486                	sd	ra,72(sp)
ffffffffc0204418:	fc26                	sd	s1,56(sp)
ffffffffc020441a:	842a                	mv	s0,a0
ffffffffc020441c:	100027f3          	csrr	a5,sstatus
ffffffffc0204420:	8b89                	andi	a5,a5,2
ffffffffc0204422:	ebb1                	bnez	a5,ffffffffc0204476 <__down.constprop.0+0x64>
ffffffffc0204424:	411c                	lw	a5,0(a0)
ffffffffc0204426:	00f05a63          	blez	a5,ffffffffc020443a <__down.constprop.0+0x28>
ffffffffc020442a:	37fd                	addiw	a5,a5,-1
ffffffffc020442c:	c11c                	sw	a5,0(a0)
ffffffffc020442e:	4501                	li	a0,0
ffffffffc0204430:	60a6                	ld	ra,72(sp)
ffffffffc0204432:	6406                	ld	s0,64(sp)
ffffffffc0204434:	74e2                	ld	s1,56(sp)
ffffffffc0204436:	6161                	addi	sp,sp,80
ffffffffc0204438:	8082                	ret
ffffffffc020443a:	00850413          	addi	s0,a0,8 # ffffffffc8000008 <end+0x7d696f8>
ffffffffc020443e:	0024                	addi	s1,sp,8
ffffffffc0204440:	10000613          	li	a2,256
ffffffffc0204444:	85a6                	mv	a1,s1
ffffffffc0204446:	8522                	mv	a0,s0
ffffffffc0204448:	2d8000ef          	jal	ra,ffffffffc0204720 <wait_current_set>
ffffffffc020444c:	797020ef          	jal	ra,ffffffffc02073e2 <schedule>
ffffffffc0204450:	100027f3          	csrr	a5,sstatus
ffffffffc0204454:	8b89                	andi	a5,a5,2
ffffffffc0204456:	efb9                	bnez	a5,ffffffffc02044b4 <__down.constprop.0+0xa2>
ffffffffc0204458:	8526                	mv	a0,s1
ffffffffc020445a:	19c000ef          	jal	ra,ffffffffc02045f6 <wait_in_queue>
ffffffffc020445e:	e531                	bnez	a0,ffffffffc02044aa <__down.constprop.0+0x98>
ffffffffc0204460:	4542                	lw	a0,16(sp)
ffffffffc0204462:	10000793          	li	a5,256
ffffffffc0204466:	fcf515e3          	bne	a0,a5,ffffffffc0204430 <__down.constprop.0+0x1e>
ffffffffc020446a:	60a6                	ld	ra,72(sp)
ffffffffc020446c:	6406                	ld	s0,64(sp)
ffffffffc020446e:	74e2                	ld	s1,56(sp)
ffffffffc0204470:	4501                	li	a0,0
ffffffffc0204472:	6161                	addi	sp,sp,80
ffffffffc0204474:	8082                	ret
ffffffffc0204476:	ffcfc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020447a:	401c                	lw	a5,0(s0)
ffffffffc020447c:	00f05c63          	blez	a5,ffffffffc0204494 <__down.constprop.0+0x82>
ffffffffc0204480:	37fd                	addiw	a5,a5,-1
ffffffffc0204482:	c01c                	sw	a5,0(s0)
ffffffffc0204484:	fe8fc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0204488:	60a6                	ld	ra,72(sp)
ffffffffc020448a:	6406                	ld	s0,64(sp)
ffffffffc020448c:	74e2                	ld	s1,56(sp)
ffffffffc020448e:	4501                	li	a0,0
ffffffffc0204490:	6161                	addi	sp,sp,80
ffffffffc0204492:	8082                	ret
ffffffffc0204494:	0421                	addi	s0,s0,8
ffffffffc0204496:	0024                	addi	s1,sp,8
ffffffffc0204498:	10000613          	li	a2,256
ffffffffc020449c:	85a6                	mv	a1,s1
ffffffffc020449e:	8522                	mv	a0,s0
ffffffffc02044a0:	280000ef          	jal	ra,ffffffffc0204720 <wait_current_set>
ffffffffc02044a4:	fc8fc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02044a8:	b755                	j	ffffffffc020444c <__down.constprop.0+0x3a>
ffffffffc02044aa:	85a6                	mv	a1,s1
ffffffffc02044ac:	8522                	mv	a0,s0
ffffffffc02044ae:	0ee000ef          	jal	ra,ffffffffc020459c <wait_queue_del>
ffffffffc02044b2:	b77d                	j	ffffffffc0204460 <__down.constprop.0+0x4e>
ffffffffc02044b4:	fbefc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02044b8:	8526                	mv	a0,s1
ffffffffc02044ba:	13c000ef          	jal	ra,ffffffffc02045f6 <wait_in_queue>
ffffffffc02044be:	e501                	bnez	a0,ffffffffc02044c6 <__down.constprop.0+0xb4>
ffffffffc02044c0:	facfc0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02044c4:	bf71                	j	ffffffffc0204460 <__down.constprop.0+0x4e>
ffffffffc02044c6:	85a6                	mv	a1,s1
ffffffffc02044c8:	8522                	mv	a0,s0
ffffffffc02044ca:	0d2000ef          	jal	ra,ffffffffc020459c <wait_queue_del>
ffffffffc02044ce:	bfcd                	j	ffffffffc02044c0 <__down.constprop.0+0xae>

ffffffffc02044d0 <__up.constprop.0>:
ffffffffc02044d0:	1101                	addi	sp,sp,-32
ffffffffc02044d2:	e822                	sd	s0,16(sp)
ffffffffc02044d4:	ec06                	sd	ra,24(sp)
ffffffffc02044d6:	e426                	sd	s1,8(sp)
ffffffffc02044d8:	e04a                	sd	s2,0(sp)
ffffffffc02044da:	842a                	mv	s0,a0
ffffffffc02044dc:	100027f3          	csrr	a5,sstatus
ffffffffc02044e0:	8b89                	andi	a5,a5,2
ffffffffc02044e2:	4901                	li	s2,0
ffffffffc02044e4:	eba1                	bnez	a5,ffffffffc0204534 <__up.constprop.0+0x64>
ffffffffc02044e6:	00840493          	addi	s1,s0,8
ffffffffc02044ea:	8526                	mv	a0,s1
ffffffffc02044ec:	0ee000ef          	jal	ra,ffffffffc02045da <wait_queue_first>
ffffffffc02044f0:	85aa                	mv	a1,a0
ffffffffc02044f2:	cd0d                	beqz	a0,ffffffffc020452c <__up.constprop.0+0x5c>
ffffffffc02044f4:	6118                	ld	a4,0(a0)
ffffffffc02044f6:	10000793          	li	a5,256
ffffffffc02044fa:	0ec72703          	lw	a4,236(a4)
ffffffffc02044fe:	02f71f63          	bne	a4,a5,ffffffffc020453c <__up.constprop.0+0x6c>
ffffffffc0204502:	4685                	li	a3,1
ffffffffc0204504:	10000613          	li	a2,256
ffffffffc0204508:	8526                	mv	a0,s1
ffffffffc020450a:	0fa000ef          	jal	ra,ffffffffc0204604 <wakeup_wait>
ffffffffc020450e:	00091863          	bnez	s2,ffffffffc020451e <__up.constprop.0+0x4e>
ffffffffc0204512:	60e2                	ld	ra,24(sp)
ffffffffc0204514:	6442                	ld	s0,16(sp)
ffffffffc0204516:	64a2                	ld	s1,8(sp)
ffffffffc0204518:	6902                	ld	s2,0(sp)
ffffffffc020451a:	6105                	addi	sp,sp,32
ffffffffc020451c:	8082                	ret
ffffffffc020451e:	6442                	ld	s0,16(sp)
ffffffffc0204520:	60e2                	ld	ra,24(sp)
ffffffffc0204522:	64a2                	ld	s1,8(sp)
ffffffffc0204524:	6902                	ld	s2,0(sp)
ffffffffc0204526:	6105                	addi	sp,sp,32
ffffffffc0204528:	f44fc06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc020452c:	401c                	lw	a5,0(s0)
ffffffffc020452e:	2785                	addiw	a5,a5,1
ffffffffc0204530:	c01c                	sw	a5,0(s0)
ffffffffc0204532:	bff1                	j	ffffffffc020450e <__up.constprop.0+0x3e>
ffffffffc0204534:	f3efc0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0204538:	4905                	li	s2,1
ffffffffc020453a:	b775                	j	ffffffffc02044e6 <__up.constprop.0+0x16>
ffffffffc020453c:	00009697          	auipc	a3,0x9
ffffffffc0204540:	a9468693          	addi	a3,a3,-1388 # ffffffffc020cfd0 <default_pmm_manager+0xaa0>
ffffffffc0204544:	00007617          	auipc	a2,0x7
ffffffffc0204548:	50460613          	addi	a2,a2,1284 # ffffffffc020ba48 <commands+0x210>
ffffffffc020454c:	45e5                	li	a1,25
ffffffffc020454e:	00009517          	auipc	a0,0x9
ffffffffc0204552:	aaa50513          	addi	a0,a0,-1366 # ffffffffc020cff8 <default_pmm_manager+0xac8>
ffffffffc0204556:	f49fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020455a <sem_init>:
ffffffffc020455a:	c10c                	sw	a1,0(a0)
ffffffffc020455c:	0521                	addi	a0,a0,8
ffffffffc020455e:	a825                	j	ffffffffc0204596 <wait_queue_init>

ffffffffc0204560 <up>:
ffffffffc0204560:	f71ff06f          	j	ffffffffc02044d0 <__up.constprop.0>

ffffffffc0204564 <down>:
ffffffffc0204564:	1141                	addi	sp,sp,-16
ffffffffc0204566:	e406                	sd	ra,8(sp)
ffffffffc0204568:	eabff0ef          	jal	ra,ffffffffc0204412 <__down.constprop.0>
ffffffffc020456c:	2501                	sext.w	a0,a0
ffffffffc020456e:	e501                	bnez	a0,ffffffffc0204576 <down+0x12>
ffffffffc0204570:	60a2                	ld	ra,8(sp)
ffffffffc0204572:	0141                	addi	sp,sp,16
ffffffffc0204574:	8082                	ret
ffffffffc0204576:	00009697          	auipc	a3,0x9
ffffffffc020457a:	a9268693          	addi	a3,a3,-1390 # ffffffffc020d008 <default_pmm_manager+0xad8>
ffffffffc020457e:	00007617          	auipc	a2,0x7
ffffffffc0204582:	4ca60613          	addi	a2,a2,1226 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204586:	04000593          	li	a1,64
ffffffffc020458a:	00009517          	auipc	a0,0x9
ffffffffc020458e:	a6e50513          	addi	a0,a0,-1426 # ffffffffc020cff8 <default_pmm_manager+0xac8>
ffffffffc0204592:	f0dfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204596 <wait_queue_init>:
ffffffffc0204596:	e508                	sd	a0,8(a0)
ffffffffc0204598:	e108                	sd	a0,0(a0)
ffffffffc020459a:	8082                	ret

ffffffffc020459c <wait_queue_del>:
ffffffffc020459c:	7198                	ld	a4,32(a1)
ffffffffc020459e:	01858793          	addi	a5,a1,24
ffffffffc02045a2:	00e78b63          	beq	a5,a4,ffffffffc02045b8 <wait_queue_del+0x1c>
ffffffffc02045a6:	6994                	ld	a3,16(a1)
ffffffffc02045a8:	00a69863          	bne	a3,a0,ffffffffc02045b8 <wait_queue_del+0x1c>
ffffffffc02045ac:	6d94                	ld	a3,24(a1)
ffffffffc02045ae:	e698                	sd	a4,8(a3)
ffffffffc02045b0:	e314                	sd	a3,0(a4)
ffffffffc02045b2:	f19c                	sd	a5,32(a1)
ffffffffc02045b4:	ed9c                	sd	a5,24(a1)
ffffffffc02045b6:	8082                	ret
ffffffffc02045b8:	1141                	addi	sp,sp,-16
ffffffffc02045ba:	00009697          	auipc	a3,0x9
ffffffffc02045be:	aae68693          	addi	a3,a3,-1362 # ffffffffc020d068 <default_pmm_manager+0xb38>
ffffffffc02045c2:	00007617          	auipc	a2,0x7
ffffffffc02045c6:	48660613          	addi	a2,a2,1158 # ffffffffc020ba48 <commands+0x210>
ffffffffc02045ca:	45f1                	li	a1,28
ffffffffc02045cc:	00009517          	auipc	a0,0x9
ffffffffc02045d0:	a8450513          	addi	a0,a0,-1404 # ffffffffc020d050 <default_pmm_manager+0xb20>
ffffffffc02045d4:	e406                	sd	ra,8(sp)
ffffffffc02045d6:	ec9fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02045da <wait_queue_first>:
ffffffffc02045da:	651c                	ld	a5,8(a0)
ffffffffc02045dc:	00f50563          	beq	a0,a5,ffffffffc02045e6 <wait_queue_first+0xc>
ffffffffc02045e0:	fe878513          	addi	a0,a5,-24
ffffffffc02045e4:	8082                	ret
ffffffffc02045e6:	4501                	li	a0,0
ffffffffc02045e8:	8082                	ret

ffffffffc02045ea <wait_queue_empty>:
ffffffffc02045ea:	651c                	ld	a5,8(a0)
ffffffffc02045ec:	40a78533          	sub	a0,a5,a0
ffffffffc02045f0:	00153513          	seqz	a0,a0
ffffffffc02045f4:	8082                	ret

ffffffffc02045f6 <wait_in_queue>:
ffffffffc02045f6:	711c                	ld	a5,32(a0)
ffffffffc02045f8:	0561                	addi	a0,a0,24
ffffffffc02045fa:	40a78533          	sub	a0,a5,a0
ffffffffc02045fe:	00a03533          	snez	a0,a0
ffffffffc0204602:	8082                	ret

ffffffffc0204604 <wakeup_wait>:
ffffffffc0204604:	e689                	bnez	a3,ffffffffc020460e <wakeup_wait+0xa>
ffffffffc0204606:	6188                	ld	a0,0(a1)
ffffffffc0204608:	c590                	sw	a2,8(a1)
ffffffffc020460a:	5270206f          	j	ffffffffc0207330 <wakeup_proc>
ffffffffc020460e:	7198                	ld	a4,32(a1)
ffffffffc0204610:	01858793          	addi	a5,a1,24
ffffffffc0204614:	00e78e63          	beq	a5,a4,ffffffffc0204630 <wakeup_wait+0x2c>
ffffffffc0204618:	6994                	ld	a3,16(a1)
ffffffffc020461a:	00d51b63          	bne	a0,a3,ffffffffc0204630 <wakeup_wait+0x2c>
ffffffffc020461e:	6d94                	ld	a3,24(a1)
ffffffffc0204620:	6188                	ld	a0,0(a1)
ffffffffc0204622:	e698                	sd	a4,8(a3)
ffffffffc0204624:	e314                	sd	a3,0(a4)
ffffffffc0204626:	f19c                	sd	a5,32(a1)
ffffffffc0204628:	ed9c                	sd	a5,24(a1)
ffffffffc020462a:	c590                	sw	a2,8(a1)
ffffffffc020462c:	5050206f          	j	ffffffffc0207330 <wakeup_proc>
ffffffffc0204630:	1141                	addi	sp,sp,-16
ffffffffc0204632:	00009697          	auipc	a3,0x9
ffffffffc0204636:	a3668693          	addi	a3,a3,-1482 # ffffffffc020d068 <default_pmm_manager+0xb38>
ffffffffc020463a:	00007617          	auipc	a2,0x7
ffffffffc020463e:	40e60613          	addi	a2,a2,1038 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204642:	45f1                	li	a1,28
ffffffffc0204644:	00009517          	auipc	a0,0x9
ffffffffc0204648:	a0c50513          	addi	a0,a0,-1524 # ffffffffc020d050 <default_pmm_manager+0xb20>
ffffffffc020464c:	e406                	sd	ra,8(sp)
ffffffffc020464e:	e51fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204652 <wakeup_queue>:
ffffffffc0204652:	651c                	ld	a5,8(a0)
ffffffffc0204654:	0ca78563          	beq	a5,a0,ffffffffc020471e <wakeup_queue+0xcc>
ffffffffc0204658:	1101                	addi	sp,sp,-32
ffffffffc020465a:	e822                	sd	s0,16(sp)
ffffffffc020465c:	e426                	sd	s1,8(sp)
ffffffffc020465e:	e04a                	sd	s2,0(sp)
ffffffffc0204660:	ec06                	sd	ra,24(sp)
ffffffffc0204662:	84aa                	mv	s1,a0
ffffffffc0204664:	892e                	mv	s2,a1
ffffffffc0204666:	fe878413          	addi	s0,a5,-24
ffffffffc020466a:	e23d                	bnez	a2,ffffffffc02046d0 <wakeup_queue+0x7e>
ffffffffc020466c:	6008                	ld	a0,0(s0)
ffffffffc020466e:	01242423          	sw	s2,8(s0)
ffffffffc0204672:	4bf020ef          	jal	ra,ffffffffc0207330 <wakeup_proc>
ffffffffc0204676:	701c                	ld	a5,32(s0)
ffffffffc0204678:	01840713          	addi	a4,s0,24
ffffffffc020467c:	02e78463          	beq	a5,a4,ffffffffc02046a4 <wakeup_queue+0x52>
ffffffffc0204680:	6818                	ld	a4,16(s0)
ffffffffc0204682:	02e49163          	bne	s1,a4,ffffffffc02046a4 <wakeup_queue+0x52>
ffffffffc0204686:	02f48f63          	beq	s1,a5,ffffffffc02046c4 <wakeup_queue+0x72>
ffffffffc020468a:	fe87b503          	ld	a0,-24(a5)
ffffffffc020468e:	ff27a823          	sw	s2,-16(a5)
ffffffffc0204692:	fe878413          	addi	s0,a5,-24
ffffffffc0204696:	49b020ef          	jal	ra,ffffffffc0207330 <wakeup_proc>
ffffffffc020469a:	701c                	ld	a5,32(s0)
ffffffffc020469c:	01840713          	addi	a4,s0,24
ffffffffc02046a0:	fee790e3          	bne	a5,a4,ffffffffc0204680 <wakeup_queue+0x2e>
ffffffffc02046a4:	00009697          	auipc	a3,0x9
ffffffffc02046a8:	9c468693          	addi	a3,a3,-1596 # ffffffffc020d068 <default_pmm_manager+0xb38>
ffffffffc02046ac:	00007617          	auipc	a2,0x7
ffffffffc02046b0:	39c60613          	addi	a2,a2,924 # ffffffffc020ba48 <commands+0x210>
ffffffffc02046b4:	02200593          	li	a1,34
ffffffffc02046b8:	00009517          	auipc	a0,0x9
ffffffffc02046bc:	99850513          	addi	a0,a0,-1640 # ffffffffc020d050 <default_pmm_manager+0xb20>
ffffffffc02046c0:	ddffb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02046c4:	60e2                	ld	ra,24(sp)
ffffffffc02046c6:	6442                	ld	s0,16(sp)
ffffffffc02046c8:	64a2                	ld	s1,8(sp)
ffffffffc02046ca:	6902                	ld	s2,0(sp)
ffffffffc02046cc:	6105                	addi	sp,sp,32
ffffffffc02046ce:	8082                	ret
ffffffffc02046d0:	6798                	ld	a4,8(a5)
ffffffffc02046d2:	02f70763          	beq	a4,a5,ffffffffc0204700 <wakeup_queue+0xae>
ffffffffc02046d6:	6814                	ld	a3,16(s0)
ffffffffc02046d8:	02d49463          	bne	s1,a3,ffffffffc0204700 <wakeup_queue+0xae>
ffffffffc02046dc:	6c14                	ld	a3,24(s0)
ffffffffc02046de:	6008                	ld	a0,0(s0)
ffffffffc02046e0:	e698                	sd	a4,8(a3)
ffffffffc02046e2:	e314                	sd	a3,0(a4)
ffffffffc02046e4:	f01c                	sd	a5,32(s0)
ffffffffc02046e6:	ec1c                	sd	a5,24(s0)
ffffffffc02046e8:	01242423          	sw	s2,8(s0)
ffffffffc02046ec:	445020ef          	jal	ra,ffffffffc0207330 <wakeup_proc>
ffffffffc02046f0:	6480                	ld	s0,8(s1)
ffffffffc02046f2:	fc8489e3          	beq	s1,s0,ffffffffc02046c4 <wakeup_queue+0x72>
ffffffffc02046f6:	6418                	ld	a4,8(s0)
ffffffffc02046f8:	87a2                	mv	a5,s0
ffffffffc02046fa:	1421                	addi	s0,s0,-24
ffffffffc02046fc:	fce79de3          	bne	a5,a4,ffffffffc02046d6 <wakeup_queue+0x84>
ffffffffc0204700:	00009697          	auipc	a3,0x9
ffffffffc0204704:	96868693          	addi	a3,a3,-1688 # ffffffffc020d068 <default_pmm_manager+0xb38>
ffffffffc0204708:	00007617          	auipc	a2,0x7
ffffffffc020470c:	34060613          	addi	a2,a2,832 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204710:	45f1                	li	a1,28
ffffffffc0204712:	00009517          	auipc	a0,0x9
ffffffffc0204716:	93e50513          	addi	a0,a0,-1730 # ffffffffc020d050 <default_pmm_manager+0xb20>
ffffffffc020471a:	d85fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020471e:	8082                	ret

ffffffffc0204720 <wait_current_set>:
ffffffffc0204720:	00092797          	auipc	a5,0x92
ffffffffc0204724:	1a07b783          	ld	a5,416(a5) # ffffffffc02968c0 <current>
ffffffffc0204728:	c39d                	beqz	a5,ffffffffc020474e <wait_current_set+0x2e>
ffffffffc020472a:	01858713          	addi	a4,a1,24
ffffffffc020472e:	800006b7          	lui	a3,0x80000
ffffffffc0204732:	ed98                	sd	a4,24(a1)
ffffffffc0204734:	e19c                	sd	a5,0(a1)
ffffffffc0204736:	c594                	sw	a3,8(a1)
ffffffffc0204738:	4685                	li	a3,1
ffffffffc020473a:	c394                	sw	a3,0(a5)
ffffffffc020473c:	0ec7a623          	sw	a2,236(a5)
ffffffffc0204740:	611c                	ld	a5,0(a0)
ffffffffc0204742:	e988                	sd	a0,16(a1)
ffffffffc0204744:	e118                	sd	a4,0(a0)
ffffffffc0204746:	e798                	sd	a4,8(a5)
ffffffffc0204748:	f188                	sd	a0,32(a1)
ffffffffc020474a:	ed9c                	sd	a5,24(a1)
ffffffffc020474c:	8082                	ret
ffffffffc020474e:	1141                	addi	sp,sp,-16
ffffffffc0204750:	00009697          	auipc	a3,0x9
ffffffffc0204754:	95868693          	addi	a3,a3,-1704 # ffffffffc020d0a8 <default_pmm_manager+0xb78>
ffffffffc0204758:	00007617          	auipc	a2,0x7
ffffffffc020475c:	2f060613          	addi	a2,a2,752 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204760:	07400593          	li	a1,116
ffffffffc0204764:	00009517          	auipc	a0,0x9
ffffffffc0204768:	8ec50513          	addi	a0,a0,-1812 # ffffffffc020d050 <default_pmm_manager+0xb20>
ffffffffc020476c:	e406                	sd	ra,8(sp)
ffffffffc020476e:	d31fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204772 <get_fd_array.part.0>:
ffffffffc0204772:	1141                	addi	sp,sp,-16
ffffffffc0204774:	00009697          	auipc	a3,0x9
ffffffffc0204778:	94468693          	addi	a3,a3,-1724 # ffffffffc020d0b8 <default_pmm_manager+0xb88>
ffffffffc020477c:	00007617          	auipc	a2,0x7
ffffffffc0204780:	2cc60613          	addi	a2,a2,716 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204784:	45d1                	li	a1,20
ffffffffc0204786:	00009517          	auipc	a0,0x9
ffffffffc020478a:	96250513          	addi	a0,a0,-1694 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc020478e:	e406                	sd	ra,8(sp)
ffffffffc0204790:	d0ffb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204794 <fd_array_alloc>:
ffffffffc0204794:	00092797          	auipc	a5,0x92
ffffffffc0204798:	12c7b783          	ld	a5,300(a5) # ffffffffc02968c0 <current>
ffffffffc020479c:	1487b783          	ld	a5,328(a5)
ffffffffc02047a0:	1141                	addi	sp,sp,-16
ffffffffc02047a2:	e406                	sd	ra,8(sp)
ffffffffc02047a4:	c3a5                	beqz	a5,ffffffffc0204804 <fd_array_alloc+0x70>
ffffffffc02047a6:	4b98                	lw	a4,16(a5)
ffffffffc02047a8:	04e05e63          	blez	a4,ffffffffc0204804 <fd_array_alloc+0x70>
ffffffffc02047ac:	775d                	lui	a4,0xffff7
ffffffffc02047ae:	ad970713          	addi	a4,a4,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc02047b2:	679c                	ld	a5,8(a5)
ffffffffc02047b4:	02e50863          	beq	a0,a4,ffffffffc02047e4 <fd_array_alloc+0x50>
ffffffffc02047b8:	04700713          	li	a4,71
ffffffffc02047bc:	04a76263          	bltu	a4,a0,ffffffffc0204800 <fd_array_alloc+0x6c>
ffffffffc02047c0:	00351713          	slli	a4,a0,0x3
ffffffffc02047c4:	40a70533          	sub	a0,a4,a0
ffffffffc02047c8:	050e                	slli	a0,a0,0x3
ffffffffc02047ca:	97aa                	add	a5,a5,a0
ffffffffc02047cc:	4398                	lw	a4,0(a5)
ffffffffc02047ce:	e71d                	bnez	a4,ffffffffc02047fc <fd_array_alloc+0x68>
ffffffffc02047d0:	5b88                	lw	a0,48(a5)
ffffffffc02047d2:	e91d                	bnez	a0,ffffffffc0204808 <fd_array_alloc+0x74>
ffffffffc02047d4:	4705                	li	a4,1
ffffffffc02047d6:	c398                	sw	a4,0(a5)
ffffffffc02047d8:	0207b423          	sd	zero,40(a5)
ffffffffc02047dc:	e19c                	sd	a5,0(a1)
ffffffffc02047de:	60a2                	ld	ra,8(sp)
ffffffffc02047e0:	0141                	addi	sp,sp,16
ffffffffc02047e2:	8082                	ret
ffffffffc02047e4:	6685                	lui	a3,0x1
ffffffffc02047e6:	fc068693          	addi	a3,a3,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc02047ea:	96be                	add	a3,a3,a5
ffffffffc02047ec:	4398                	lw	a4,0(a5)
ffffffffc02047ee:	d36d                	beqz	a4,ffffffffc02047d0 <fd_array_alloc+0x3c>
ffffffffc02047f0:	03878793          	addi	a5,a5,56
ffffffffc02047f4:	fef69ce3          	bne	a3,a5,ffffffffc02047ec <fd_array_alloc+0x58>
ffffffffc02047f8:	5529                	li	a0,-22
ffffffffc02047fa:	b7d5                	j	ffffffffc02047de <fd_array_alloc+0x4a>
ffffffffc02047fc:	5545                	li	a0,-15
ffffffffc02047fe:	b7c5                	j	ffffffffc02047de <fd_array_alloc+0x4a>
ffffffffc0204800:	5575                	li	a0,-3
ffffffffc0204802:	bff1                	j	ffffffffc02047de <fd_array_alloc+0x4a>
ffffffffc0204804:	f6fff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>
ffffffffc0204808:	00009697          	auipc	a3,0x9
ffffffffc020480c:	8f068693          	addi	a3,a3,-1808 # ffffffffc020d0f8 <default_pmm_manager+0xbc8>
ffffffffc0204810:	00007617          	auipc	a2,0x7
ffffffffc0204814:	23860613          	addi	a2,a2,568 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204818:	03b00593          	li	a1,59
ffffffffc020481c:	00009517          	auipc	a0,0x9
ffffffffc0204820:	8cc50513          	addi	a0,a0,-1844 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc0204824:	c7bfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204828 <fd_array_free>:
ffffffffc0204828:	411c                	lw	a5,0(a0)
ffffffffc020482a:	1141                	addi	sp,sp,-16
ffffffffc020482c:	e022                	sd	s0,0(sp)
ffffffffc020482e:	e406                	sd	ra,8(sp)
ffffffffc0204830:	4705                	li	a4,1
ffffffffc0204832:	842a                	mv	s0,a0
ffffffffc0204834:	04e78063          	beq	a5,a4,ffffffffc0204874 <fd_array_free+0x4c>
ffffffffc0204838:	470d                	li	a4,3
ffffffffc020483a:	04e79563          	bne	a5,a4,ffffffffc0204884 <fd_array_free+0x5c>
ffffffffc020483e:	591c                	lw	a5,48(a0)
ffffffffc0204840:	c38d                	beqz	a5,ffffffffc0204862 <fd_array_free+0x3a>
ffffffffc0204842:	00009697          	auipc	a3,0x9
ffffffffc0204846:	8b668693          	addi	a3,a3,-1866 # ffffffffc020d0f8 <default_pmm_manager+0xbc8>
ffffffffc020484a:	00007617          	auipc	a2,0x7
ffffffffc020484e:	1fe60613          	addi	a2,a2,510 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204852:	04500593          	li	a1,69
ffffffffc0204856:	00009517          	auipc	a0,0x9
ffffffffc020485a:	89250513          	addi	a0,a0,-1902 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc020485e:	c41fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204862:	7408                	ld	a0,40(s0)
ffffffffc0204864:	143030ef          	jal	ra,ffffffffc02081a6 <vfs_close>
ffffffffc0204868:	60a2                	ld	ra,8(sp)
ffffffffc020486a:	00042023          	sw	zero,0(s0)
ffffffffc020486e:	6402                	ld	s0,0(sp)
ffffffffc0204870:	0141                	addi	sp,sp,16
ffffffffc0204872:	8082                	ret
ffffffffc0204874:	591c                	lw	a5,48(a0)
ffffffffc0204876:	f7f1                	bnez	a5,ffffffffc0204842 <fd_array_free+0x1a>
ffffffffc0204878:	60a2                	ld	ra,8(sp)
ffffffffc020487a:	00042023          	sw	zero,0(s0)
ffffffffc020487e:	6402                	ld	s0,0(sp)
ffffffffc0204880:	0141                	addi	sp,sp,16
ffffffffc0204882:	8082                	ret
ffffffffc0204884:	00009697          	auipc	a3,0x9
ffffffffc0204888:	8ac68693          	addi	a3,a3,-1876 # ffffffffc020d130 <default_pmm_manager+0xc00>
ffffffffc020488c:	00007617          	auipc	a2,0x7
ffffffffc0204890:	1bc60613          	addi	a2,a2,444 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204894:	04400593          	li	a1,68
ffffffffc0204898:	00009517          	auipc	a0,0x9
ffffffffc020489c:	85050513          	addi	a0,a0,-1968 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc02048a0:	bfffb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02048a4 <fd_array_release>:
ffffffffc02048a4:	4118                	lw	a4,0(a0)
ffffffffc02048a6:	1141                	addi	sp,sp,-16
ffffffffc02048a8:	e406                	sd	ra,8(sp)
ffffffffc02048aa:	4685                	li	a3,1
ffffffffc02048ac:	3779                	addiw	a4,a4,-2
ffffffffc02048ae:	04e6e063          	bltu	a3,a4,ffffffffc02048ee <fd_array_release+0x4a>
ffffffffc02048b2:	5918                	lw	a4,48(a0)
ffffffffc02048b4:	00e05d63          	blez	a4,ffffffffc02048ce <fd_array_release+0x2a>
ffffffffc02048b8:	fff7069b          	addiw	a3,a4,-1
ffffffffc02048bc:	d914                	sw	a3,48(a0)
ffffffffc02048be:	c681                	beqz	a3,ffffffffc02048c6 <fd_array_release+0x22>
ffffffffc02048c0:	60a2                	ld	ra,8(sp)
ffffffffc02048c2:	0141                	addi	sp,sp,16
ffffffffc02048c4:	8082                	ret
ffffffffc02048c6:	60a2                	ld	ra,8(sp)
ffffffffc02048c8:	0141                	addi	sp,sp,16
ffffffffc02048ca:	f5fff06f          	j	ffffffffc0204828 <fd_array_free>
ffffffffc02048ce:	00009697          	auipc	a3,0x9
ffffffffc02048d2:	8d268693          	addi	a3,a3,-1838 # ffffffffc020d1a0 <default_pmm_manager+0xc70>
ffffffffc02048d6:	00007617          	auipc	a2,0x7
ffffffffc02048da:	17260613          	addi	a2,a2,370 # ffffffffc020ba48 <commands+0x210>
ffffffffc02048de:	05600593          	li	a1,86
ffffffffc02048e2:	00009517          	auipc	a0,0x9
ffffffffc02048e6:	80650513          	addi	a0,a0,-2042 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc02048ea:	bb5fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02048ee:	00009697          	auipc	a3,0x9
ffffffffc02048f2:	87a68693          	addi	a3,a3,-1926 # ffffffffc020d168 <default_pmm_manager+0xc38>
ffffffffc02048f6:	00007617          	auipc	a2,0x7
ffffffffc02048fa:	15260613          	addi	a2,a2,338 # ffffffffc020ba48 <commands+0x210>
ffffffffc02048fe:	05500593          	li	a1,85
ffffffffc0204902:	00008517          	auipc	a0,0x8
ffffffffc0204906:	7e650513          	addi	a0,a0,2022 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc020490a:	b95fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020490e <fd_array_open.part.0>:
ffffffffc020490e:	1141                	addi	sp,sp,-16
ffffffffc0204910:	00009697          	auipc	a3,0x9
ffffffffc0204914:	8a868693          	addi	a3,a3,-1880 # ffffffffc020d1b8 <default_pmm_manager+0xc88>
ffffffffc0204918:	00007617          	auipc	a2,0x7
ffffffffc020491c:	13060613          	addi	a2,a2,304 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204920:	05f00593          	li	a1,95
ffffffffc0204924:	00008517          	auipc	a0,0x8
ffffffffc0204928:	7c450513          	addi	a0,a0,1988 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc020492c:	e406                	sd	ra,8(sp)
ffffffffc020492e:	b71fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204932 <fd_array_init>:
ffffffffc0204932:	4781                	li	a5,0
ffffffffc0204934:	04800713          	li	a4,72
ffffffffc0204938:	cd1c                	sw	a5,24(a0)
ffffffffc020493a:	02052823          	sw	zero,48(a0)
ffffffffc020493e:	00052023          	sw	zero,0(a0)
ffffffffc0204942:	2785                	addiw	a5,a5,1
ffffffffc0204944:	03850513          	addi	a0,a0,56
ffffffffc0204948:	fee798e3          	bne	a5,a4,ffffffffc0204938 <fd_array_init+0x6>
ffffffffc020494c:	8082                	ret

ffffffffc020494e <fd_array_close>:
ffffffffc020494e:	4118                	lw	a4,0(a0)
ffffffffc0204950:	1141                	addi	sp,sp,-16
ffffffffc0204952:	e406                	sd	ra,8(sp)
ffffffffc0204954:	e022                	sd	s0,0(sp)
ffffffffc0204956:	4789                	li	a5,2
ffffffffc0204958:	04f71a63          	bne	a4,a5,ffffffffc02049ac <fd_array_close+0x5e>
ffffffffc020495c:	591c                	lw	a5,48(a0)
ffffffffc020495e:	842a                	mv	s0,a0
ffffffffc0204960:	02f05663          	blez	a5,ffffffffc020498c <fd_array_close+0x3e>
ffffffffc0204964:	37fd                	addiw	a5,a5,-1
ffffffffc0204966:	470d                	li	a4,3
ffffffffc0204968:	c118                	sw	a4,0(a0)
ffffffffc020496a:	d91c                	sw	a5,48(a0)
ffffffffc020496c:	0007871b          	sext.w	a4,a5
ffffffffc0204970:	c709                	beqz	a4,ffffffffc020497a <fd_array_close+0x2c>
ffffffffc0204972:	60a2                	ld	ra,8(sp)
ffffffffc0204974:	6402                	ld	s0,0(sp)
ffffffffc0204976:	0141                	addi	sp,sp,16
ffffffffc0204978:	8082                	ret
ffffffffc020497a:	7508                	ld	a0,40(a0)
ffffffffc020497c:	02b030ef          	jal	ra,ffffffffc02081a6 <vfs_close>
ffffffffc0204980:	60a2                	ld	ra,8(sp)
ffffffffc0204982:	00042023          	sw	zero,0(s0)
ffffffffc0204986:	6402                	ld	s0,0(sp)
ffffffffc0204988:	0141                	addi	sp,sp,16
ffffffffc020498a:	8082                	ret
ffffffffc020498c:	00009697          	auipc	a3,0x9
ffffffffc0204990:	81468693          	addi	a3,a3,-2028 # ffffffffc020d1a0 <default_pmm_manager+0xc70>
ffffffffc0204994:	00007617          	auipc	a2,0x7
ffffffffc0204998:	0b460613          	addi	a2,a2,180 # ffffffffc020ba48 <commands+0x210>
ffffffffc020499c:	06800593          	li	a1,104
ffffffffc02049a0:	00008517          	auipc	a0,0x8
ffffffffc02049a4:	74850513          	addi	a0,a0,1864 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc02049a8:	af7fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02049ac:	00008697          	auipc	a3,0x8
ffffffffc02049b0:	76468693          	addi	a3,a3,1892 # ffffffffc020d110 <default_pmm_manager+0xbe0>
ffffffffc02049b4:	00007617          	auipc	a2,0x7
ffffffffc02049b8:	09460613          	addi	a2,a2,148 # ffffffffc020ba48 <commands+0x210>
ffffffffc02049bc:	06700593          	li	a1,103
ffffffffc02049c0:	00008517          	auipc	a0,0x8
ffffffffc02049c4:	72850513          	addi	a0,a0,1832 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc02049c8:	ad7fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02049cc <fd_array_dup>:
ffffffffc02049cc:	7179                	addi	sp,sp,-48
ffffffffc02049ce:	e84a                	sd	s2,16(sp)
ffffffffc02049d0:	00052903          	lw	s2,0(a0)
ffffffffc02049d4:	f406                	sd	ra,40(sp)
ffffffffc02049d6:	f022                	sd	s0,32(sp)
ffffffffc02049d8:	ec26                	sd	s1,24(sp)
ffffffffc02049da:	e44e                	sd	s3,8(sp)
ffffffffc02049dc:	4785                	li	a5,1
ffffffffc02049de:	04f91663          	bne	s2,a5,ffffffffc0204a2a <fd_array_dup+0x5e>
ffffffffc02049e2:	0005a983          	lw	s3,0(a1)
ffffffffc02049e6:	4789                	li	a5,2
ffffffffc02049e8:	04f99163          	bne	s3,a5,ffffffffc0204a2a <fd_array_dup+0x5e>
ffffffffc02049ec:	7584                	ld	s1,40(a1)
ffffffffc02049ee:	699c                	ld	a5,16(a1)
ffffffffc02049f0:	7194                	ld	a3,32(a1)
ffffffffc02049f2:	6598                	ld	a4,8(a1)
ffffffffc02049f4:	842a                	mv	s0,a0
ffffffffc02049f6:	e91c                	sd	a5,16(a0)
ffffffffc02049f8:	f114                	sd	a3,32(a0)
ffffffffc02049fa:	e518                	sd	a4,8(a0)
ffffffffc02049fc:	8526                	mv	a0,s1
ffffffffc02049fe:	707020ef          	jal	ra,ffffffffc0207904 <inode_ref_inc>
ffffffffc0204a02:	8526                	mv	a0,s1
ffffffffc0204a04:	70d020ef          	jal	ra,ffffffffc0207910 <inode_open_inc>
ffffffffc0204a08:	401c                	lw	a5,0(s0)
ffffffffc0204a0a:	f404                	sd	s1,40(s0)
ffffffffc0204a0c:	03279f63          	bne	a5,s2,ffffffffc0204a4a <fd_array_dup+0x7e>
ffffffffc0204a10:	cc8d                	beqz	s1,ffffffffc0204a4a <fd_array_dup+0x7e>
ffffffffc0204a12:	581c                	lw	a5,48(s0)
ffffffffc0204a14:	01342023          	sw	s3,0(s0)
ffffffffc0204a18:	70a2                	ld	ra,40(sp)
ffffffffc0204a1a:	2785                	addiw	a5,a5,1
ffffffffc0204a1c:	d81c                	sw	a5,48(s0)
ffffffffc0204a1e:	7402                	ld	s0,32(sp)
ffffffffc0204a20:	64e2                	ld	s1,24(sp)
ffffffffc0204a22:	6942                	ld	s2,16(sp)
ffffffffc0204a24:	69a2                	ld	s3,8(sp)
ffffffffc0204a26:	6145                	addi	sp,sp,48
ffffffffc0204a28:	8082                	ret
ffffffffc0204a2a:	00008697          	auipc	a3,0x8
ffffffffc0204a2e:	7be68693          	addi	a3,a3,1982 # ffffffffc020d1e8 <default_pmm_manager+0xcb8>
ffffffffc0204a32:	00007617          	auipc	a2,0x7
ffffffffc0204a36:	01660613          	addi	a2,a2,22 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204a3a:	07300593          	li	a1,115
ffffffffc0204a3e:	00008517          	auipc	a0,0x8
ffffffffc0204a42:	6aa50513          	addi	a0,a0,1706 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc0204a46:	a59fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204a4a:	ec5ff0ef          	jal	ra,ffffffffc020490e <fd_array_open.part.0>

ffffffffc0204a4e <file_testfd>:
ffffffffc0204a4e:	04700793          	li	a5,71
ffffffffc0204a52:	04a7e263          	bltu	a5,a0,ffffffffc0204a96 <file_testfd+0x48>
ffffffffc0204a56:	00092797          	auipc	a5,0x92
ffffffffc0204a5a:	e6a7b783          	ld	a5,-406(a5) # ffffffffc02968c0 <current>
ffffffffc0204a5e:	1487b783          	ld	a5,328(a5)
ffffffffc0204a62:	cf85                	beqz	a5,ffffffffc0204a9a <file_testfd+0x4c>
ffffffffc0204a64:	4b98                	lw	a4,16(a5)
ffffffffc0204a66:	02e05a63          	blez	a4,ffffffffc0204a9a <file_testfd+0x4c>
ffffffffc0204a6a:	6798                	ld	a4,8(a5)
ffffffffc0204a6c:	00351793          	slli	a5,a0,0x3
ffffffffc0204a70:	8f89                	sub	a5,a5,a0
ffffffffc0204a72:	078e                	slli	a5,a5,0x3
ffffffffc0204a74:	97ba                	add	a5,a5,a4
ffffffffc0204a76:	4394                	lw	a3,0(a5)
ffffffffc0204a78:	4709                	li	a4,2
ffffffffc0204a7a:	00e69e63          	bne	a3,a4,ffffffffc0204a96 <file_testfd+0x48>
ffffffffc0204a7e:	4f98                	lw	a4,24(a5)
ffffffffc0204a80:	00a71b63          	bne	a4,a0,ffffffffc0204a96 <file_testfd+0x48>
ffffffffc0204a84:	c199                	beqz	a1,ffffffffc0204a8a <file_testfd+0x3c>
ffffffffc0204a86:	6788                	ld	a0,8(a5)
ffffffffc0204a88:	c901                	beqz	a0,ffffffffc0204a98 <file_testfd+0x4a>
ffffffffc0204a8a:	4505                	li	a0,1
ffffffffc0204a8c:	c611                	beqz	a2,ffffffffc0204a98 <file_testfd+0x4a>
ffffffffc0204a8e:	6b88                	ld	a0,16(a5)
ffffffffc0204a90:	00a03533          	snez	a0,a0
ffffffffc0204a94:	8082                	ret
ffffffffc0204a96:	4501                	li	a0,0
ffffffffc0204a98:	8082                	ret
ffffffffc0204a9a:	1141                	addi	sp,sp,-16
ffffffffc0204a9c:	e406                	sd	ra,8(sp)
ffffffffc0204a9e:	cd5ff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>

ffffffffc0204aa2 <file_open>:
ffffffffc0204aa2:	711d                	addi	sp,sp,-96
ffffffffc0204aa4:	ec86                	sd	ra,88(sp)
ffffffffc0204aa6:	e8a2                	sd	s0,80(sp)
ffffffffc0204aa8:	e4a6                	sd	s1,72(sp)
ffffffffc0204aaa:	e0ca                	sd	s2,64(sp)
ffffffffc0204aac:	fc4e                	sd	s3,56(sp)
ffffffffc0204aae:	f852                	sd	s4,48(sp)
ffffffffc0204ab0:	0035f793          	andi	a5,a1,3
ffffffffc0204ab4:	470d                	li	a4,3
ffffffffc0204ab6:	0ce78163          	beq	a5,a4,ffffffffc0204b78 <file_open+0xd6>
ffffffffc0204aba:	078e                	slli	a5,a5,0x3
ffffffffc0204abc:	00009717          	auipc	a4,0x9
ffffffffc0204ac0:	99c70713          	addi	a4,a4,-1636 # ffffffffc020d458 <CSWTCH.79>
ffffffffc0204ac4:	892a                	mv	s2,a0
ffffffffc0204ac6:	00009697          	auipc	a3,0x9
ffffffffc0204aca:	97a68693          	addi	a3,a3,-1670 # ffffffffc020d440 <CSWTCH.78>
ffffffffc0204ace:	755d                	lui	a0,0xffff7
ffffffffc0204ad0:	96be                	add	a3,a3,a5
ffffffffc0204ad2:	84ae                	mv	s1,a1
ffffffffc0204ad4:	97ba                	add	a5,a5,a4
ffffffffc0204ad6:	858a                	mv	a1,sp
ffffffffc0204ad8:	ad950513          	addi	a0,a0,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc0204adc:	0006ba03          	ld	s4,0(a3)
ffffffffc0204ae0:	0007b983          	ld	s3,0(a5)
ffffffffc0204ae4:	cb1ff0ef          	jal	ra,ffffffffc0204794 <fd_array_alloc>
ffffffffc0204ae8:	842a                	mv	s0,a0
ffffffffc0204aea:	c911                	beqz	a0,ffffffffc0204afe <file_open+0x5c>
ffffffffc0204aec:	60e6                	ld	ra,88(sp)
ffffffffc0204aee:	8522                	mv	a0,s0
ffffffffc0204af0:	6446                	ld	s0,80(sp)
ffffffffc0204af2:	64a6                	ld	s1,72(sp)
ffffffffc0204af4:	6906                	ld	s2,64(sp)
ffffffffc0204af6:	79e2                	ld	s3,56(sp)
ffffffffc0204af8:	7a42                	ld	s4,48(sp)
ffffffffc0204afa:	6125                	addi	sp,sp,96
ffffffffc0204afc:	8082                	ret
ffffffffc0204afe:	0030                	addi	a2,sp,8
ffffffffc0204b00:	85a6                	mv	a1,s1
ffffffffc0204b02:	854a                	mv	a0,s2
ffffffffc0204b04:	4fc030ef          	jal	ra,ffffffffc0208000 <vfs_open>
ffffffffc0204b08:	842a                	mv	s0,a0
ffffffffc0204b0a:	e13d                	bnez	a0,ffffffffc0204b70 <file_open+0xce>
ffffffffc0204b0c:	6782                	ld	a5,0(sp)
ffffffffc0204b0e:	0204f493          	andi	s1,s1,32
ffffffffc0204b12:	6422                	ld	s0,8(sp)
ffffffffc0204b14:	0207b023          	sd	zero,32(a5)
ffffffffc0204b18:	c885                	beqz	s1,ffffffffc0204b48 <file_open+0xa6>
ffffffffc0204b1a:	c03d                	beqz	s0,ffffffffc0204b80 <file_open+0xde>
ffffffffc0204b1c:	783c                	ld	a5,112(s0)
ffffffffc0204b1e:	c3ad                	beqz	a5,ffffffffc0204b80 <file_open+0xde>
ffffffffc0204b20:	779c                	ld	a5,40(a5)
ffffffffc0204b22:	cfb9                	beqz	a5,ffffffffc0204b80 <file_open+0xde>
ffffffffc0204b24:	8522                	mv	a0,s0
ffffffffc0204b26:	00008597          	auipc	a1,0x8
ffffffffc0204b2a:	74a58593          	addi	a1,a1,1866 # ffffffffc020d270 <default_pmm_manager+0xd40>
ffffffffc0204b2e:	5ef020ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc0204b32:	783c                	ld	a5,112(s0)
ffffffffc0204b34:	6522                	ld	a0,8(sp)
ffffffffc0204b36:	080c                	addi	a1,sp,16
ffffffffc0204b38:	779c                	ld	a5,40(a5)
ffffffffc0204b3a:	9782                	jalr	a5
ffffffffc0204b3c:	842a                	mv	s0,a0
ffffffffc0204b3e:	e515                	bnez	a0,ffffffffc0204b6a <file_open+0xc8>
ffffffffc0204b40:	6782                	ld	a5,0(sp)
ffffffffc0204b42:	7722                	ld	a4,40(sp)
ffffffffc0204b44:	6422                	ld	s0,8(sp)
ffffffffc0204b46:	f398                	sd	a4,32(a5)
ffffffffc0204b48:	4394                	lw	a3,0(a5)
ffffffffc0204b4a:	f780                	sd	s0,40(a5)
ffffffffc0204b4c:	0147b423          	sd	s4,8(a5)
ffffffffc0204b50:	0137b823          	sd	s3,16(a5)
ffffffffc0204b54:	4705                	li	a4,1
ffffffffc0204b56:	02e69363          	bne	a3,a4,ffffffffc0204b7c <file_open+0xda>
ffffffffc0204b5a:	c00d                	beqz	s0,ffffffffc0204b7c <file_open+0xda>
ffffffffc0204b5c:	5b98                	lw	a4,48(a5)
ffffffffc0204b5e:	4689                	li	a3,2
ffffffffc0204b60:	4f80                	lw	s0,24(a5)
ffffffffc0204b62:	2705                	addiw	a4,a4,1
ffffffffc0204b64:	c394                	sw	a3,0(a5)
ffffffffc0204b66:	db98                	sw	a4,48(a5)
ffffffffc0204b68:	b751                	j	ffffffffc0204aec <file_open+0x4a>
ffffffffc0204b6a:	6522                	ld	a0,8(sp)
ffffffffc0204b6c:	63a030ef          	jal	ra,ffffffffc02081a6 <vfs_close>
ffffffffc0204b70:	6502                	ld	a0,0(sp)
ffffffffc0204b72:	cb7ff0ef          	jal	ra,ffffffffc0204828 <fd_array_free>
ffffffffc0204b76:	bf9d                	j	ffffffffc0204aec <file_open+0x4a>
ffffffffc0204b78:	5475                	li	s0,-3
ffffffffc0204b7a:	bf8d                	j	ffffffffc0204aec <file_open+0x4a>
ffffffffc0204b7c:	d93ff0ef          	jal	ra,ffffffffc020490e <fd_array_open.part.0>
ffffffffc0204b80:	00008697          	auipc	a3,0x8
ffffffffc0204b84:	6a068693          	addi	a3,a3,1696 # ffffffffc020d220 <default_pmm_manager+0xcf0>
ffffffffc0204b88:	00007617          	auipc	a2,0x7
ffffffffc0204b8c:	ec060613          	addi	a2,a2,-320 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204b90:	0b500593          	li	a1,181
ffffffffc0204b94:	00008517          	auipc	a0,0x8
ffffffffc0204b98:	55450513          	addi	a0,a0,1364 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc0204b9c:	903fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204ba0 <file_close>:
ffffffffc0204ba0:	04700713          	li	a4,71
ffffffffc0204ba4:	04a76563          	bltu	a4,a0,ffffffffc0204bee <file_close+0x4e>
ffffffffc0204ba8:	00092717          	auipc	a4,0x92
ffffffffc0204bac:	d1873703          	ld	a4,-744(a4) # ffffffffc02968c0 <current>
ffffffffc0204bb0:	14873703          	ld	a4,328(a4)
ffffffffc0204bb4:	1141                	addi	sp,sp,-16
ffffffffc0204bb6:	e406                	sd	ra,8(sp)
ffffffffc0204bb8:	cf0d                	beqz	a4,ffffffffc0204bf2 <file_close+0x52>
ffffffffc0204bba:	4b14                	lw	a3,16(a4)
ffffffffc0204bbc:	02d05b63          	blez	a3,ffffffffc0204bf2 <file_close+0x52>
ffffffffc0204bc0:	6718                	ld	a4,8(a4)
ffffffffc0204bc2:	87aa                	mv	a5,a0
ffffffffc0204bc4:	050e                	slli	a0,a0,0x3
ffffffffc0204bc6:	8d1d                	sub	a0,a0,a5
ffffffffc0204bc8:	050e                	slli	a0,a0,0x3
ffffffffc0204bca:	953a                	add	a0,a0,a4
ffffffffc0204bcc:	4114                	lw	a3,0(a0)
ffffffffc0204bce:	4709                	li	a4,2
ffffffffc0204bd0:	00e69b63          	bne	a3,a4,ffffffffc0204be6 <file_close+0x46>
ffffffffc0204bd4:	4d18                	lw	a4,24(a0)
ffffffffc0204bd6:	00f71863          	bne	a4,a5,ffffffffc0204be6 <file_close+0x46>
ffffffffc0204bda:	d75ff0ef          	jal	ra,ffffffffc020494e <fd_array_close>
ffffffffc0204bde:	60a2                	ld	ra,8(sp)
ffffffffc0204be0:	4501                	li	a0,0
ffffffffc0204be2:	0141                	addi	sp,sp,16
ffffffffc0204be4:	8082                	ret
ffffffffc0204be6:	60a2                	ld	ra,8(sp)
ffffffffc0204be8:	5575                	li	a0,-3
ffffffffc0204bea:	0141                	addi	sp,sp,16
ffffffffc0204bec:	8082                	ret
ffffffffc0204bee:	5575                	li	a0,-3
ffffffffc0204bf0:	8082                	ret
ffffffffc0204bf2:	b81ff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>

ffffffffc0204bf6 <file_read>:
ffffffffc0204bf6:	715d                	addi	sp,sp,-80
ffffffffc0204bf8:	e486                	sd	ra,72(sp)
ffffffffc0204bfa:	e0a2                	sd	s0,64(sp)
ffffffffc0204bfc:	fc26                	sd	s1,56(sp)
ffffffffc0204bfe:	f84a                	sd	s2,48(sp)
ffffffffc0204c00:	f44e                	sd	s3,40(sp)
ffffffffc0204c02:	f052                	sd	s4,32(sp)
ffffffffc0204c04:	0006b023          	sd	zero,0(a3)
ffffffffc0204c08:	04700793          	li	a5,71
ffffffffc0204c0c:	0aa7e463          	bltu	a5,a0,ffffffffc0204cb4 <file_read+0xbe>
ffffffffc0204c10:	00092797          	auipc	a5,0x92
ffffffffc0204c14:	cb07b783          	ld	a5,-848(a5) # ffffffffc02968c0 <current>
ffffffffc0204c18:	1487b783          	ld	a5,328(a5)
ffffffffc0204c1c:	cfd1                	beqz	a5,ffffffffc0204cb8 <file_read+0xc2>
ffffffffc0204c1e:	4b98                	lw	a4,16(a5)
ffffffffc0204c20:	08e05c63          	blez	a4,ffffffffc0204cb8 <file_read+0xc2>
ffffffffc0204c24:	6780                	ld	s0,8(a5)
ffffffffc0204c26:	00351793          	slli	a5,a0,0x3
ffffffffc0204c2a:	8f89                	sub	a5,a5,a0
ffffffffc0204c2c:	078e                	slli	a5,a5,0x3
ffffffffc0204c2e:	943e                	add	s0,s0,a5
ffffffffc0204c30:	00042983          	lw	s3,0(s0)
ffffffffc0204c34:	4789                	li	a5,2
ffffffffc0204c36:	06f99f63          	bne	s3,a5,ffffffffc0204cb4 <file_read+0xbe>
ffffffffc0204c3a:	4c1c                	lw	a5,24(s0)
ffffffffc0204c3c:	06a79c63          	bne	a5,a0,ffffffffc0204cb4 <file_read+0xbe>
ffffffffc0204c40:	641c                	ld	a5,8(s0)
ffffffffc0204c42:	cbad                	beqz	a5,ffffffffc0204cb4 <file_read+0xbe>
ffffffffc0204c44:	581c                	lw	a5,48(s0)
ffffffffc0204c46:	8a36                	mv	s4,a3
ffffffffc0204c48:	7014                	ld	a3,32(s0)
ffffffffc0204c4a:	2785                	addiw	a5,a5,1
ffffffffc0204c4c:	850a                	mv	a0,sp
ffffffffc0204c4e:	d81c                	sw	a5,48(s0)
ffffffffc0204c50:	792000ef          	jal	ra,ffffffffc02053e2 <iobuf_init>
ffffffffc0204c54:	02843903          	ld	s2,40(s0)
ffffffffc0204c58:	84aa                	mv	s1,a0
ffffffffc0204c5a:	06090163          	beqz	s2,ffffffffc0204cbc <file_read+0xc6>
ffffffffc0204c5e:	07093783          	ld	a5,112(s2)
ffffffffc0204c62:	cfa9                	beqz	a5,ffffffffc0204cbc <file_read+0xc6>
ffffffffc0204c64:	6f9c                	ld	a5,24(a5)
ffffffffc0204c66:	cbb9                	beqz	a5,ffffffffc0204cbc <file_read+0xc6>
ffffffffc0204c68:	00008597          	auipc	a1,0x8
ffffffffc0204c6c:	66058593          	addi	a1,a1,1632 # ffffffffc020d2c8 <default_pmm_manager+0xd98>
ffffffffc0204c70:	854a                	mv	a0,s2
ffffffffc0204c72:	4ab020ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc0204c76:	07093783          	ld	a5,112(s2)
ffffffffc0204c7a:	7408                	ld	a0,40(s0)
ffffffffc0204c7c:	85a6                	mv	a1,s1
ffffffffc0204c7e:	6f9c                	ld	a5,24(a5)
ffffffffc0204c80:	9782                	jalr	a5
ffffffffc0204c82:	689c                	ld	a5,16(s1)
ffffffffc0204c84:	6c94                	ld	a3,24(s1)
ffffffffc0204c86:	4018                	lw	a4,0(s0)
ffffffffc0204c88:	84aa                	mv	s1,a0
ffffffffc0204c8a:	8f95                	sub	a5,a5,a3
ffffffffc0204c8c:	03370063          	beq	a4,s3,ffffffffc0204cac <file_read+0xb6>
ffffffffc0204c90:	00fa3023          	sd	a5,0(s4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0204c94:	8522                	mv	a0,s0
ffffffffc0204c96:	c0fff0ef          	jal	ra,ffffffffc02048a4 <fd_array_release>
ffffffffc0204c9a:	60a6                	ld	ra,72(sp)
ffffffffc0204c9c:	6406                	ld	s0,64(sp)
ffffffffc0204c9e:	7942                	ld	s2,48(sp)
ffffffffc0204ca0:	79a2                	ld	s3,40(sp)
ffffffffc0204ca2:	7a02                	ld	s4,32(sp)
ffffffffc0204ca4:	8526                	mv	a0,s1
ffffffffc0204ca6:	74e2                	ld	s1,56(sp)
ffffffffc0204ca8:	6161                	addi	sp,sp,80
ffffffffc0204caa:	8082                	ret
ffffffffc0204cac:	7018                	ld	a4,32(s0)
ffffffffc0204cae:	973e                	add	a4,a4,a5
ffffffffc0204cb0:	f018                	sd	a4,32(s0)
ffffffffc0204cb2:	bff9                	j	ffffffffc0204c90 <file_read+0x9a>
ffffffffc0204cb4:	54f5                	li	s1,-3
ffffffffc0204cb6:	b7d5                	j	ffffffffc0204c9a <file_read+0xa4>
ffffffffc0204cb8:	abbff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>
ffffffffc0204cbc:	00008697          	auipc	a3,0x8
ffffffffc0204cc0:	5bc68693          	addi	a3,a3,1468 # ffffffffc020d278 <default_pmm_manager+0xd48>
ffffffffc0204cc4:	00007617          	auipc	a2,0x7
ffffffffc0204cc8:	d8460613          	addi	a2,a2,-636 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204ccc:	0de00593          	li	a1,222
ffffffffc0204cd0:	00008517          	auipc	a0,0x8
ffffffffc0204cd4:	41850513          	addi	a0,a0,1048 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc0204cd8:	fc6fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204cdc <file_write>:
ffffffffc0204cdc:	715d                	addi	sp,sp,-80
ffffffffc0204cde:	e486                	sd	ra,72(sp)
ffffffffc0204ce0:	e0a2                	sd	s0,64(sp)
ffffffffc0204ce2:	fc26                	sd	s1,56(sp)
ffffffffc0204ce4:	f84a                	sd	s2,48(sp)
ffffffffc0204ce6:	f44e                	sd	s3,40(sp)
ffffffffc0204ce8:	f052                	sd	s4,32(sp)
ffffffffc0204cea:	0006b023          	sd	zero,0(a3)
ffffffffc0204cee:	04700793          	li	a5,71
ffffffffc0204cf2:	0aa7e463          	bltu	a5,a0,ffffffffc0204d9a <file_write+0xbe>
ffffffffc0204cf6:	00092797          	auipc	a5,0x92
ffffffffc0204cfa:	bca7b783          	ld	a5,-1078(a5) # ffffffffc02968c0 <current>
ffffffffc0204cfe:	1487b783          	ld	a5,328(a5)
ffffffffc0204d02:	cfd1                	beqz	a5,ffffffffc0204d9e <file_write+0xc2>
ffffffffc0204d04:	4b98                	lw	a4,16(a5)
ffffffffc0204d06:	08e05c63          	blez	a4,ffffffffc0204d9e <file_write+0xc2>
ffffffffc0204d0a:	6780                	ld	s0,8(a5)
ffffffffc0204d0c:	00351793          	slli	a5,a0,0x3
ffffffffc0204d10:	8f89                	sub	a5,a5,a0
ffffffffc0204d12:	078e                	slli	a5,a5,0x3
ffffffffc0204d14:	943e                	add	s0,s0,a5
ffffffffc0204d16:	00042983          	lw	s3,0(s0)
ffffffffc0204d1a:	4789                	li	a5,2
ffffffffc0204d1c:	06f99f63          	bne	s3,a5,ffffffffc0204d9a <file_write+0xbe>
ffffffffc0204d20:	4c1c                	lw	a5,24(s0)
ffffffffc0204d22:	06a79c63          	bne	a5,a0,ffffffffc0204d9a <file_write+0xbe>
ffffffffc0204d26:	681c                	ld	a5,16(s0)
ffffffffc0204d28:	cbad                	beqz	a5,ffffffffc0204d9a <file_write+0xbe>
ffffffffc0204d2a:	581c                	lw	a5,48(s0)
ffffffffc0204d2c:	8a36                	mv	s4,a3
ffffffffc0204d2e:	7014                	ld	a3,32(s0)
ffffffffc0204d30:	2785                	addiw	a5,a5,1
ffffffffc0204d32:	850a                	mv	a0,sp
ffffffffc0204d34:	d81c                	sw	a5,48(s0)
ffffffffc0204d36:	6ac000ef          	jal	ra,ffffffffc02053e2 <iobuf_init>
ffffffffc0204d3a:	02843903          	ld	s2,40(s0)
ffffffffc0204d3e:	84aa                	mv	s1,a0
ffffffffc0204d40:	06090163          	beqz	s2,ffffffffc0204da2 <file_write+0xc6>
ffffffffc0204d44:	07093783          	ld	a5,112(s2)
ffffffffc0204d48:	cfa9                	beqz	a5,ffffffffc0204da2 <file_write+0xc6>
ffffffffc0204d4a:	739c                	ld	a5,32(a5)
ffffffffc0204d4c:	cbb9                	beqz	a5,ffffffffc0204da2 <file_write+0xc6>
ffffffffc0204d4e:	00008597          	auipc	a1,0x8
ffffffffc0204d52:	5d258593          	addi	a1,a1,1490 # ffffffffc020d320 <default_pmm_manager+0xdf0>
ffffffffc0204d56:	854a                	mv	a0,s2
ffffffffc0204d58:	3c5020ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc0204d5c:	07093783          	ld	a5,112(s2)
ffffffffc0204d60:	7408                	ld	a0,40(s0)
ffffffffc0204d62:	85a6                	mv	a1,s1
ffffffffc0204d64:	739c                	ld	a5,32(a5)
ffffffffc0204d66:	9782                	jalr	a5
ffffffffc0204d68:	689c                	ld	a5,16(s1)
ffffffffc0204d6a:	6c94                	ld	a3,24(s1)
ffffffffc0204d6c:	4018                	lw	a4,0(s0)
ffffffffc0204d6e:	84aa                	mv	s1,a0
ffffffffc0204d70:	8f95                	sub	a5,a5,a3
ffffffffc0204d72:	03370063          	beq	a4,s3,ffffffffc0204d92 <file_write+0xb6>
ffffffffc0204d76:	00fa3023          	sd	a5,0(s4)
ffffffffc0204d7a:	8522                	mv	a0,s0
ffffffffc0204d7c:	b29ff0ef          	jal	ra,ffffffffc02048a4 <fd_array_release>
ffffffffc0204d80:	60a6                	ld	ra,72(sp)
ffffffffc0204d82:	6406                	ld	s0,64(sp)
ffffffffc0204d84:	7942                	ld	s2,48(sp)
ffffffffc0204d86:	79a2                	ld	s3,40(sp)
ffffffffc0204d88:	7a02                	ld	s4,32(sp)
ffffffffc0204d8a:	8526                	mv	a0,s1
ffffffffc0204d8c:	74e2                	ld	s1,56(sp)
ffffffffc0204d8e:	6161                	addi	sp,sp,80
ffffffffc0204d90:	8082                	ret
ffffffffc0204d92:	7018                	ld	a4,32(s0)
ffffffffc0204d94:	973e                	add	a4,a4,a5
ffffffffc0204d96:	f018                	sd	a4,32(s0)
ffffffffc0204d98:	bff9                	j	ffffffffc0204d76 <file_write+0x9a>
ffffffffc0204d9a:	54f5                	li	s1,-3
ffffffffc0204d9c:	b7d5                	j	ffffffffc0204d80 <file_write+0xa4>
ffffffffc0204d9e:	9d5ff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>
ffffffffc0204da2:	00008697          	auipc	a3,0x8
ffffffffc0204da6:	52e68693          	addi	a3,a3,1326 # ffffffffc020d2d0 <default_pmm_manager+0xda0>
ffffffffc0204daa:	00007617          	auipc	a2,0x7
ffffffffc0204dae:	c9e60613          	addi	a2,a2,-866 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204db2:	0f800593          	li	a1,248
ffffffffc0204db6:	00008517          	auipc	a0,0x8
ffffffffc0204dba:	33250513          	addi	a0,a0,818 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc0204dbe:	ee0fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204dc2 <file_seek>:
ffffffffc0204dc2:	7139                	addi	sp,sp,-64
ffffffffc0204dc4:	fc06                	sd	ra,56(sp)
ffffffffc0204dc6:	f822                	sd	s0,48(sp)
ffffffffc0204dc8:	f426                	sd	s1,40(sp)
ffffffffc0204dca:	f04a                	sd	s2,32(sp)
ffffffffc0204dcc:	04700793          	li	a5,71
ffffffffc0204dd0:	08a7e863          	bltu	a5,a0,ffffffffc0204e60 <file_seek+0x9e>
ffffffffc0204dd4:	00092797          	auipc	a5,0x92
ffffffffc0204dd8:	aec7b783          	ld	a5,-1300(a5) # ffffffffc02968c0 <current>
ffffffffc0204ddc:	1487b783          	ld	a5,328(a5)
ffffffffc0204de0:	cfdd                	beqz	a5,ffffffffc0204e9e <file_seek+0xdc>
ffffffffc0204de2:	4b98                	lw	a4,16(a5)
ffffffffc0204de4:	0ae05d63          	blez	a4,ffffffffc0204e9e <file_seek+0xdc>
ffffffffc0204de8:	6780                	ld	s0,8(a5)
ffffffffc0204dea:	00351793          	slli	a5,a0,0x3
ffffffffc0204dee:	8f89                	sub	a5,a5,a0
ffffffffc0204df0:	078e                	slli	a5,a5,0x3
ffffffffc0204df2:	943e                	add	s0,s0,a5
ffffffffc0204df4:	4018                	lw	a4,0(s0)
ffffffffc0204df6:	4789                	li	a5,2
ffffffffc0204df8:	06f71463          	bne	a4,a5,ffffffffc0204e60 <file_seek+0x9e>
ffffffffc0204dfc:	4c1c                	lw	a5,24(s0)
ffffffffc0204dfe:	06a79163          	bne	a5,a0,ffffffffc0204e60 <file_seek+0x9e>
ffffffffc0204e02:	581c                	lw	a5,48(s0)
ffffffffc0204e04:	4685                	li	a3,1
ffffffffc0204e06:	892e                	mv	s2,a1
ffffffffc0204e08:	2785                	addiw	a5,a5,1
ffffffffc0204e0a:	d81c                	sw	a5,48(s0)
ffffffffc0204e0c:	02d60063          	beq	a2,a3,ffffffffc0204e2c <file_seek+0x6a>
ffffffffc0204e10:	06e60063          	beq	a2,a4,ffffffffc0204e70 <file_seek+0xae>
ffffffffc0204e14:	54f5                	li	s1,-3
ffffffffc0204e16:	ce11                	beqz	a2,ffffffffc0204e32 <file_seek+0x70>
ffffffffc0204e18:	8522                	mv	a0,s0
ffffffffc0204e1a:	a8bff0ef          	jal	ra,ffffffffc02048a4 <fd_array_release>
ffffffffc0204e1e:	70e2                	ld	ra,56(sp)
ffffffffc0204e20:	7442                	ld	s0,48(sp)
ffffffffc0204e22:	7902                	ld	s2,32(sp)
ffffffffc0204e24:	8526                	mv	a0,s1
ffffffffc0204e26:	74a2                	ld	s1,40(sp)
ffffffffc0204e28:	6121                	addi	sp,sp,64
ffffffffc0204e2a:	8082                	ret
ffffffffc0204e2c:	701c                	ld	a5,32(s0)
ffffffffc0204e2e:	00f58933          	add	s2,a1,a5
ffffffffc0204e32:	7404                	ld	s1,40(s0)
ffffffffc0204e34:	c4bd                	beqz	s1,ffffffffc0204ea2 <file_seek+0xe0>
ffffffffc0204e36:	78bc                	ld	a5,112(s1)
ffffffffc0204e38:	c7ad                	beqz	a5,ffffffffc0204ea2 <file_seek+0xe0>
ffffffffc0204e3a:	6fbc                	ld	a5,88(a5)
ffffffffc0204e3c:	c3bd                	beqz	a5,ffffffffc0204ea2 <file_seek+0xe0>
ffffffffc0204e3e:	8526                	mv	a0,s1
ffffffffc0204e40:	00008597          	auipc	a1,0x8
ffffffffc0204e44:	53858593          	addi	a1,a1,1336 # ffffffffc020d378 <default_pmm_manager+0xe48>
ffffffffc0204e48:	2d5020ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc0204e4c:	78bc                	ld	a5,112(s1)
ffffffffc0204e4e:	7408                	ld	a0,40(s0)
ffffffffc0204e50:	85ca                	mv	a1,s2
ffffffffc0204e52:	6fbc                	ld	a5,88(a5)
ffffffffc0204e54:	9782                	jalr	a5
ffffffffc0204e56:	84aa                	mv	s1,a0
ffffffffc0204e58:	f161                	bnez	a0,ffffffffc0204e18 <file_seek+0x56>
ffffffffc0204e5a:	03243023          	sd	s2,32(s0)
ffffffffc0204e5e:	bf6d                	j	ffffffffc0204e18 <file_seek+0x56>
ffffffffc0204e60:	70e2                	ld	ra,56(sp)
ffffffffc0204e62:	7442                	ld	s0,48(sp)
ffffffffc0204e64:	54f5                	li	s1,-3
ffffffffc0204e66:	7902                	ld	s2,32(sp)
ffffffffc0204e68:	8526                	mv	a0,s1
ffffffffc0204e6a:	74a2                	ld	s1,40(sp)
ffffffffc0204e6c:	6121                	addi	sp,sp,64
ffffffffc0204e6e:	8082                	ret
ffffffffc0204e70:	7404                	ld	s1,40(s0)
ffffffffc0204e72:	c8a1                	beqz	s1,ffffffffc0204ec2 <file_seek+0x100>
ffffffffc0204e74:	78bc                	ld	a5,112(s1)
ffffffffc0204e76:	c7b1                	beqz	a5,ffffffffc0204ec2 <file_seek+0x100>
ffffffffc0204e78:	779c                	ld	a5,40(a5)
ffffffffc0204e7a:	c7a1                	beqz	a5,ffffffffc0204ec2 <file_seek+0x100>
ffffffffc0204e7c:	8526                	mv	a0,s1
ffffffffc0204e7e:	00008597          	auipc	a1,0x8
ffffffffc0204e82:	3f258593          	addi	a1,a1,1010 # ffffffffc020d270 <default_pmm_manager+0xd40>
ffffffffc0204e86:	297020ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc0204e8a:	78bc                	ld	a5,112(s1)
ffffffffc0204e8c:	7408                	ld	a0,40(s0)
ffffffffc0204e8e:	858a                	mv	a1,sp
ffffffffc0204e90:	779c                	ld	a5,40(a5)
ffffffffc0204e92:	9782                	jalr	a5
ffffffffc0204e94:	84aa                	mv	s1,a0
ffffffffc0204e96:	f149                	bnez	a0,ffffffffc0204e18 <file_seek+0x56>
ffffffffc0204e98:	67e2                	ld	a5,24(sp)
ffffffffc0204e9a:	993e                	add	s2,s2,a5
ffffffffc0204e9c:	bf59                	j	ffffffffc0204e32 <file_seek+0x70>
ffffffffc0204e9e:	8d5ff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>
ffffffffc0204ea2:	00008697          	auipc	a3,0x8
ffffffffc0204ea6:	48668693          	addi	a3,a3,1158 # ffffffffc020d328 <default_pmm_manager+0xdf8>
ffffffffc0204eaa:	00007617          	auipc	a2,0x7
ffffffffc0204eae:	b9e60613          	addi	a2,a2,-1122 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204eb2:	11a00593          	li	a1,282
ffffffffc0204eb6:	00008517          	auipc	a0,0x8
ffffffffc0204eba:	23250513          	addi	a0,a0,562 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc0204ebe:	de0fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204ec2:	00008697          	auipc	a3,0x8
ffffffffc0204ec6:	35e68693          	addi	a3,a3,862 # ffffffffc020d220 <default_pmm_manager+0xcf0>
ffffffffc0204eca:	00007617          	auipc	a2,0x7
ffffffffc0204ece:	b7e60613          	addi	a2,a2,-1154 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204ed2:	11200593          	li	a1,274
ffffffffc0204ed6:	00008517          	auipc	a0,0x8
ffffffffc0204eda:	21250513          	addi	a0,a0,530 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc0204ede:	dc0fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0204ee2 <file_fstat>:
ffffffffc0204ee2:	1101                	addi	sp,sp,-32
ffffffffc0204ee4:	ec06                	sd	ra,24(sp)
ffffffffc0204ee6:	e822                	sd	s0,16(sp)
ffffffffc0204ee8:	e426                	sd	s1,8(sp)
ffffffffc0204eea:	e04a                	sd	s2,0(sp)
ffffffffc0204eec:	04700793          	li	a5,71
ffffffffc0204ef0:	06a7ef63          	bltu	a5,a0,ffffffffc0204f6e <file_fstat+0x8c>
ffffffffc0204ef4:	00092797          	auipc	a5,0x92
ffffffffc0204ef8:	9cc7b783          	ld	a5,-1588(a5) # ffffffffc02968c0 <current>
ffffffffc0204efc:	1487b783          	ld	a5,328(a5)
ffffffffc0204f00:	cfd9                	beqz	a5,ffffffffc0204f9e <file_fstat+0xbc>
ffffffffc0204f02:	4b98                	lw	a4,16(a5)
ffffffffc0204f04:	08e05d63          	blez	a4,ffffffffc0204f9e <file_fstat+0xbc>
ffffffffc0204f08:	6780                	ld	s0,8(a5)
ffffffffc0204f0a:	00351793          	slli	a5,a0,0x3
ffffffffc0204f0e:	8f89                	sub	a5,a5,a0
ffffffffc0204f10:	078e                	slli	a5,a5,0x3
ffffffffc0204f12:	943e                	add	s0,s0,a5
ffffffffc0204f14:	4018                	lw	a4,0(s0)
ffffffffc0204f16:	4789                	li	a5,2
ffffffffc0204f18:	04f71b63          	bne	a4,a5,ffffffffc0204f6e <file_fstat+0x8c>
ffffffffc0204f1c:	4c1c                	lw	a5,24(s0)
ffffffffc0204f1e:	04a79863          	bne	a5,a0,ffffffffc0204f6e <file_fstat+0x8c>
ffffffffc0204f22:	581c                	lw	a5,48(s0)
ffffffffc0204f24:	02843903          	ld	s2,40(s0)
ffffffffc0204f28:	2785                	addiw	a5,a5,1
ffffffffc0204f2a:	d81c                	sw	a5,48(s0)
ffffffffc0204f2c:	04090963          	beqz	s2,ffffffffc0204f7e <file_fstat+0x9c>
ffffffffc0204f30:	07093783          	ld	a5,112(s2)
ffffffffc0204f34:	c7a9                	beqz	a5,ffffffffc0204f7e <file_fstat+0x9c>
ffffffffc0204f36:	779c                	ld	a5,40(a5)
ffffffffc0204f38:	c3b9                	beqz	a5,ffffffffc0204f7e <file_fstat+0x9c>
ffffffffc0204f3a:	84ae                	mv	s1,a1
ffffffffc0204f3c:	854a                	mv	a0,s2
ffffffffc0204f3e:	00008597          	auipc	a1,0x8
ffffffffc0204f42:	33258593          	addi	a1,a1,818 # ffffffffc020d270 <default_pmm_manager+0xd40>
ffffffffc0204f46:	1d7020ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc0204f4a:	07093783          	ld	a5,112(s2)
ffffffffc0204f4e:	7408                	ld	a0,40(s0)
ffffffffc0204f50:	85a6                	mv	a1,s1
ffffffffc0204f52:	779c                	ld	a5,40(a5)
ffffffffc0204f54:	9782                	jalr	a5
ffffffffc0204f56:	87aa                	mv	a5,a0
ffffffffc0204f58:	8522                	mv	a0,s0
ffffffffc0204f5a:	843e                	mv	s0,a5
ffffffffc0204f5c:	949ff0ef          	jal	ra,ffffffffc02048a4 <fd_array_release>
ffffffffc0204f60:	60e2                	ld	ra,24(sp)
ffffffffc0204f62:	8522                	mv	a0,s0
ffffffffc0204f64:	6442                	ld	s0,16(sp)
ffffffffc0204f66:	64a2                	ld	s1,8(sp)
ffffffffc0204f68:	6902                	ld	s2,0(sp)
ffffffffc0204f6a:	6105                	addi	sp,sp,32
ffffffffc0204f6c:	8082                	ret
ffffffffc0204f6e:	5475                	li	s0,-3
ffffffffc0204f70:	60e2                	ld	ra,24(sp)
ffffffffc0204f72:	8522                	mv	a0,s0
ffffffffc0204f74:	6442                	ld	s0,16(sp)
ffffffffc0204f76:	64a2                	ld	s1,8(sp)
ffffffffc0204f78:	6902                	ld	s2,0(sp)
ffffffffc0204f7a:	6105                	addi	sp,sp,32
ffffffffc0204f7c:	8082                	ret
ffffffffc0204f7e:	00008697          	auipc	a3,0x8
ffffffffc0204f82:	2a268693          	addi	a3,a3,674 # ffffffffc020d220 <default_pmm_manager+0xcf0>
ffffffffc0204f86:	00007617          	auipc	a2,0x7
ffffffffc0204f8a:	ac260613          	addi	a2,a2,-1342 # ffffffffc020ba48 <commands+0x210>
ffffffffc0204f8e:	12c00593          	li	a1,300
ffffffffc0204f92:	00008517          	auipc	a0,0x8
ffffffffc0204f96:	15650513          	addi	a0,a0,342 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc0204f9a:	d04fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0204f9e:	fd4ff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>

ffffffffc0204fa2 <file_fsync>:
ffffffffc0204fa2:	1101                	addi	sp,sp,-32
ffffffffc0204fa4:	ec06                	sd	ra,24(sp)
ffffffffc0204fa6:	e822                	sd	s0,16(sp)
ffffffffc0204fa8:	e426                	sd	s1,8(sp)
ffffffffc0204faa:	04700793          	li	a5,71
ffffffffc0204fae:	06a7e863          	bltu	a5,a0,ffffffffc020501e <file_fsync+0x7c>
ffffffffc0204fb2:	00092797          	auipc	a5,0x92
ffffffffc0204fb6:	90e7b783          	ld	a5,-1778(a5) # ffffffffc02968c0 <current>
ffffffffc0204fba:	1487b783          	ld	a5,328(a5)
ffffffffc0204fbe:	c7d9                	beqz	a5,ffffffffc020504c <file_fsync+0xaa>
ffffffffc0204fc0:	4b98                	lw	a4,16(a5)
ffffffffc0204fc2:	08e05563          	blez	a4,ffffffffc020504c <file_fsync+0xaa>
ffffffffc0204fc6:	6780                	ld	s0,8(a5)
ffffffffc0204fc8:	00351793          	slli	a5,a0,0x3
ffffffffc0204fcc:	8f89                	sub	a5,a5,a0
ffffffffc0204fce:	078e                	slli	a5,a5,0x3
ffffffffc0204fd0:	943e                	add	s0,s0,a5
ffffffffc0204fd2:	4018                	lw	a4,0(s0)
ffffffffc0204fd4:	4789                	li	a5,2
ffffffffc0204fd6:	04f71463          	bne	a4,a5,ffffffffc020501e <file_fsync+0x7c>
ffffffffc0204fda:	4c1c                	lw	a5,24(s0)
ffffffffc0204fdc:	04a79163          	bne	a5,a0,ffffffffc020501e <file_fsync+0x7c>
ffffffffc0204fe0:	581c                	lw	a5,48(s0)
ffffffffc0204fe2:	7404                	ld	s1,40(s0)
ffffffffc0204fe4:	2785                	addiw	a5,a5,1
ffffffffc0204fe6:	d81c                	sw	a5,48(s0)
ffffffffc0204fe8:	c0b1                	beqz	s1,ffffffffc020502c <file_fsync+0x8a>
ffffffffc0204fea:	78bc                	ld	a5,112(s1)
ffffffffc0204fec:	c3a1                	beqz	a5,ffffffffc020502c <file_fsync+0x8a>
ffffffffc0204fee:	7b9c                	ld	a5,48(a5)
ffffffffc0204ff0:	cf95                	beqz	a5,ffffffffc020502c <file_fsync+0x8a>
ffffffffc0204ff2:	00008597          	auipc	a1,0x8
ffffffffc0204ff6:	3de58593          	addi	a1,a1,990 # ffffffffc020d3d0 <default_pmm_manager+0xea0>
ffffffffc0204ffa:	8526                	mv	a0,s1
ffffffffc0204ffc:	121020ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc0205000:	78bc                	ld	a5,112(s1)
ffffffffc0205002:	7408                	ld	a0,40(s0)
ffffffffc0205004:	7b9c                	ld	a5,48(a5)
ffffffffc0205006:	9782                	jalr	a5
ffffffffc0205008:	87aa                	mv	a5,a0
ffffffffc020500a:	8522                	mv	a0,s0
ffffffffc020500c:	843e                	mv	s0,a5
ffffffffc020500e:	897ff0ef          	jal	ra,ffffffffc02048a4 <fd_array_release>
ffffffffc0205012:	60e2                	ld	ra,24(sp)
ffffffffc0205014:	8522                	mv	a0,s0
ffffffffc0205016:	6442                	ld	s0,16(sp)
ffffffffc0205018:	64a2                	ld	s1,8(sp)
ffffffffc020501a:	6105                	addi	sp,sp,32
ffffffffc020501c:	8082                	ret
ffffffffc020501e:	5475                	li	s0,-3
ffffffffc0205020:	60e2                	ld	ra,24(sp)
ffffffffc0205022:	8522                	mv	a0,s0
ffffffffc0205024:	6442                	ld	s0,16(sp)
ffffffffc0205026:	64a2                	ld	s1,8(sp)
ffffffffc0205028:	6105                	addi	sp,sp,32
ffffffffc020502a:	8082                	ret
ffffffffc020502c:	00008697          	auipc	a3,0x8
ffffffffc0205030:	35468693          	addi	a3,a3,852 # ffffffffc020d380 <default_pmm_manager+0xe50>
ffffffffc0205034:	00007617          	auipc	a2,0x7
ffffffffc0205038:	a1460613          	addi	a2,a2,-1516 # ffffffffc020ba48 <commands+0x210>
ffffffffc020503c:	13a00593          	li	a1,314
ffffffffc0205040:	00008517          	auipc	a0,0x8
ffffffffc0205044:	0a850513          	addi	a0,a0,168 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc0205048:	c56fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020504c:	f26ff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>

ffffffffc0205050 <file_getdirentry>:
ffffffffc0205050:	715d                	addi	sp,sp,-80
ffffffffc0205052:	e486                	sd	ra,72(sp)
ffffffffc0205054:	e0a2                	sd	s0,64(sp)
ffffffffc0205056:	fc26                	sd	s1,56(sp)
ffffffffc0205058:	f84a                	sd	s2,48(sp)
ffffffffc020505a:	f44e                	sd	s3,40(sp)
ffffffffc020505c:	04700793          	li	a5,71
ffffffffc0205060:	0aa7e063          	bltu	a5,a0,ffffffffc0205100 <file_getdirentry+0xb0>
ffffffffc0205064:	00092797          	auipc	a5,0x92
ffffffffc0205068:	85c7b783          	ld	a5,-1956(a5) # ffffffffc02968c0 <current>
ffffffffc020506c:	1487b783          	ld	a5,328(a5)
ffffffffc0205070:	c3e9                	beqz	a5,ffffffffc0205132 <file_getdirentry+0xe2>
ffffffffc0205072:	4b98                	lw	a4,16(a5)
ffffffffc0205074:	0ae05f63          	blez	a4,ffffffffc0205132 <file_getdirentry+0xe2>
ffffffffc0205078:	6780                	ld	s0,8(a5)
ffffffffc020507a:	00351793          	slli	a5,a0,0x3
ffffffffc020507e:	8f89                	sub	a5,a5,a0
ffffffffc0205080:	078e                	slli	a5,a5,0x3
ffffffffc0205082:	943e                	add	s0,s0,a5
ffffffffc0205084:	4018                	lw	a4,0(s0)
ffffffffc0205086:	4789                	li	a5,2
ffffffffc0205088:	06f71c63          	bne	a4,a5,ffffffffc0205100 <file_getdirentry+0xb0>
ffffffffc020508c:	4c1c                	lw	a5,24(s0)
ffffffffc020508e:	06a79963          	bne	a5,a0,ffffffffc0205100 <file_getdirentry+0xb0>
ffffffffc0205092:	581c                	lw	a5,48(s0)
ffffffffc0205094:	6194                	ld	a3,0(a1)
ffffffffc0205096:	84ae                	mv	s1,a1
ffffffffc0205098:	2785                	addiw	a5,a5,1
ffffffffc020509a:	10000613          	li	a2,256
ffffffffc020509e:	d81c                	sw	a5,48(s0)
ffffffffc02050a0:	05a1                	addi	a1,a1,8
ffffffffc02050a2:	850a                	mv	a0,sp
ffffffffc02050a4:	33e000ef          	jal	ra,ffffffffc02053e2 <iobuf_init>
ffffffffc02050a8:	02843983          	ld	s3,40(s0)
ffffffffc02050ac:	892a                	mv	s2,a0
ffffffffc02050ae:	06098263          	beqz	s3,ffffffffc0205112 <file_getdirentry+0xc2>
ffffffffc02050b2:	0709b783          	ld	a5,112(s3) # 1070 <_binary_bin_swap_img_size-0x6c90>
ffffffffc02050b6:	cfb1                	beqz	a5,ffffffffc0205112 <file_getdirentry+0xc2>
ffffffffc02050b8:	63bc                	ld	a5,64(a5)
ffffffffc02050ba:	cfa1                	beqz	a5,ffffffffc0205112 <file_getdirentry+0xc2>
ffffffffc02050bc:	854e                	mv	a0,s3
ffffffffc02050be:	00008597          	auipc	a1,0x8
ffffffffc02050c2:	37258593          	addi	a1,a1,882 # ffffffffc020d430 <default_pmm_manager+0xf00>
ffffffffc02050c6:	057020ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc02050ca:	0709b783          	ld	a5,112(s3)
ffffffffc02050ce:	7408                	ld	a0,40(s0)
ffffffffc02050d0:	85ca                	mv	a1,s2
ffffffffc02050d2:	63bc                	ld	a5,64(a5)
ffffffffc02050d4:	9782                	jalr	a5
ffffffffc02050d6:	89aa                	mv	s3,a0
ffffffffc02050d8:	e909                	bnez	a0,ffffffffc02050ea <file_getdirentry+0x9a>
ffffffffc02050da:	609c                	ld	a5,0(s1)
ffffffffc02050dc:	01093683          	ld	a3,16(s2)
ffffffffc02050e0:	01893703          	ld	a4,24(s2)
ffffffffc02050e4:	97b6                	add	a5,a5,a3
ffffffffc02050e6:	8f99                	sub	a5,a5,a4
ffffffffc02050e8:	e09c                	sd	a5,0(s1)
ffffffffc02050ea:	8522                	mv	a0,s0
ffffffffc02050ec:	fb8ff0ef          	jal	ra,ffffffffc02048a4 <fd_array_release>
ffffffffc02050f0:	60a6                	ld	ra,72(sp)
ffffffffc02050f2:	6406                	ld	s0,64(sp)
ffffffffc02050f4:	74e2                	ld	s1,56(sp)
ffffffffc02050f6:	7942                	ld	s2,48(sp)
ffffffffc02050f8:	854e                	mv	a0,s3
ffffffffc02050fa:	79a2                	ld	s3,40(sp)
ffffffffc02050fc:	6161                	addi	sp,sp,80
ffffffffc02050fe:	8082                	ret
ffffffffc0205100:	60a6                	ld	ra,72(sp)
ffffffffc0205102:	6406                	ld	s0,64(sp)
ffffffffc0205104:	59f5                	li	s3,-3
ffffffffc0205106:	74e2                	ld	s1,56(sp)
ffffffffc0205108:	7942                	ld	s2,48(sp)
ffffffffc020510a:	854e                	mv	a0,s3
ffffffffc020510c:	79a2                	ld	s3,40(sp)
ffffffffc020510e:	6161                	addi	sp,sp,80
ffffffffc0205110:	8082                	ret
ffffffffc0205112:	00008697          	auipc	a3,0x8
ffffffffc0205116:	2c668693          	addi	a3,a3,710 # ffffffffc020d3d8 <default_pmm_manager+0xea8>
ffffffffc020511a:	00007617          	auipc	a2,0x7
ffffffffc020511e:	92e60613          	addi	a2,a2,-1746 # ffffffffc020ba48 <commands+0x210>
ffffffffc0205122:	14a00593          	li	a1,330
ffffffffc0205126:	00008517          	auipc	a0,0x8
ffffffffc020512a:	fc250513          	addi	a0,a0,-62 # ffffffffc020d0e8 <default_pmm_manager+0xbb8>
ffffffffc020512e:	b70fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205132:	e40ff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>

ffffffffc0205136 <file_dup>:
ffffffffc0205136:	04700713          	li	a4,71
ffffffffc020513a:	06a76463          	bltu	a4,a0,ffffffffc02051a2 <file_dup+0x6c>
ffffffffc020513e:	00091717          	auipc	a4,0x91
ffffffffc0205142:	78273703          	ld	a4,1922(a4) # ffffffffc02968c0 <current>
ffffffffc0205146:	14873703          	ld	a4,328(a4)
ffffffffc020514a:	1101                	addi	sp,sp,-32
ffffffffc020514c:	ec06                	sd	ra,24(sp)
ffffffffc020514e:	e822                	sd	s0,16(sp)
ffffffffc0205150:	cb39                	beqz	a4,ffffffffc02051a6 <file_dup+0x70>
ffffffffc0205152:	4b14                	lw	a3,16(a4)
ffffffffc0205154:	04d05963          	blez	a3,ffffffffc02051a6 <file_dup+0x70>
ffffffffc0205158:	6700                	ld	s0,8(a4)
ffffffffc020515a:	00351713          	slli	a4,a0,0x3
ffffffffc020515e:	8f09                	sub	a4,a4,a0
ffffffffc0205160:	070e                	slli	a4,a4,0x3
ffffffffc0205162:	943a                	add	s0,s0,a4
ffffffffc0205164:	4014                	lw	a3,0(s0)
ffffffffc0205166:	4709                	li	a4,2
ffffffffc0205168:	02e69863          	bne	a3,a4,ffffffffc0205198 <file_dup+0x62>
ffffffffc020516c:	4c18                	lw	a4,24(s0)
ffffffffc020516e:	02a71563          	bne	a4,a0,ffffffffc0205198 <file_dup+0x62>
ffffffffc0205172:	852e                	mv	a0,a1
ffffffffc0205174:	002c                	addi	a1,sp,8
ffffffffc0205176:	e1eff0ef          	jal	ra,ffffffffc0204794 <fd_array_alloc>
ffffffffc020517a:	c509                	beqz	a0,ffffffffc0205184 <file_dup+0x4e>
ffffffffc020517c:	60e2                	ld	ra,24(sp)
ffffffffc020517e:	6442                	ld	s0,16(sp)
ffffffffc0205180:	6105                	addi	sp,sp,32
ffffffffc0205182:	8082                	ret
ffffffffc0205184:	6522                	ld	a0,8(sp)
ffffffffc0205186:	85a2                	mv	a1,s0
ffffffffc0205188:	845ff0ef          	jal	ra,ffffffffc02049cc <fd_array_dup>
ffffffffc020518c:	67a2                	ld	a5,8(sp)
ffffffffc020518e:	60e2                	ld	ra,24(sp)
ffffffffc0205190:	6442                	ld	s0,16(sp)
ffffffffc0205192:	4f88                	lw	a0,24(a5)
ffffffffc0205194:	6105                	addi	sp,sp,32
ffffffffc0205196:	8082                	ret
ffffffffc0205198:	60e2                	ld	ra,24(sp)
ffffffffc020519a:	6442                	ld	s0,16(sp)
ffffffffc020519c:	5575                	li	a0,-3
ffffffffc020519e:	6105                	addi	sp,sp,32
ffffffffc02051a0:	8082                	ret
ffffffffc02051a2:	5575                	li	a0,-3
ffffffffc02051a4:	8082                	ret
ffffffffc02051a6:	dccff0ef          	jal	ra,ffffffffc0204772 <get_fd_array.part.0>

ffffffffc02051aa <fs_init>:
ffffffffc02051aa:	1141                	addi	sp,sp,-16
ffffffffc02051ac:	e406                	sd	ra,8(sp)
ffffffffc02051ae:	18d020ef          	jal	ra,ffffffffc0207b3a <vfs_init>
ffffffffc02051b2:	664030ef          	jal	ra,ffffffffc0208816 <dev_init>
ffffffffc02051b6:	60a2                	ld	ra,8(sp)
ffffffffc02051b8:	0141                	addi	sp,sp,16
ffffffffc02051ba:	7b50306f          	j	ffffffffc020916e <sfs_init>

ffffffffc02051be <fs_cleanup>:
ffffffffc02051be:	3cf0206f          	j	ffffffffc0207d8c <vfs_cleanup>

ffffffffc02051c2 <lock_files>:
ffffffffc02051c2:	0561                	addi	a0,a0,24
ffffffffc02051c4:	ba0ff06f          	j	ffffffffc0204564 <down>

ffffffffc02051c8 <unlock_files>:
ffffffffc02051c8:	0561                	addi	a0,a0,24
ffffffffc02051ca:	b96ff06f          	j	ffffffffc0204560 <up>

ffffffffc02051ce <files_create>:
ffffffffc02051ce:	1141                	addi	sp,sp,-16
ffffffffc02051d0:	6505                	lui	a0,0x1
ffffffffc02051d2:	e022                	sd	s0,0(sp)
ffffffffc02051d4:	e406                	sd	ra,8(sp)
ffffffffc02051d6:	db9fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02051da:	842a                	mv	s0,a0
ffffffffc02051dc:	cd19                	beqz	a0,ffffffffc02051fa <files_create+0x2c>
ffffffffc02051de:	03050793          	addi	a5,a0,48 # 1030 <_binary_bin_swap_img_size-0x6cd0>
ffffffffc02051e2:	00043023          	sd	zero,0(s0)
ffffffffc02051e6:	0561                	addi	a0,a0,24
ffffffffc02051e8:	e41c                	sd	a5,8(s0)
ffffffffc02051ea:	00042823          	sw	zero,16(s0)
ffffffffc02051ee:	4585                	li	a1,1
ffffffffc02051f0:	b6aff0ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc02051f4:	6408                	ld	a0,8(s0)
ffffffffc02051f6:	f3cff0ef          	jal	ra,ffffffffc0204932 <fd_array_init>
ffffffffc02051fa:	60a2                	ld	ra,8(sp)
ffffffffc02051fc:	8522                	mv	a0,s0
ffffffffc02051fe:	6402                	ld	s0,0(sp)
ffffffffc0205200:	0141                	addi	sp,sp,16
ffffffffc0205202:	8082                	ret

ffffffffc0205204 <files_destroy>:
ffffffffc0205204:	7179                	addi	sp,sp,-48
ffffffffc0205206:	f406                	sd	ra,40(sp)
ffffffffc0205208:	f022                	sd	s0,32(sp)
ffffffffc020520a:	ec26                	sd	s1,24(sp)
ffffffffc020520c:	e84a                	sd	s2,16(sp)
ffffffffc020520e:	e44e                	sd	s3,8(sp)
ffffffffc0205210:	c52d                	beqz	a0,ffffffffc020527a <files_destroy+0x76>
ffffffffc0205212:	491c                	lw	a5,16(a0)
ffffffffc0205214:	89aa                	mv	s3,a0
ffffffffc0205216:	e3b5                	bnez	a5,ffffffffc020527a <files_destroy+0x76>
ffffffffc0205218:	6108                	ld	a0,0(a0)
ffffffffc020521a:	c119                	beqz	a0,ffffffffc0205220 <files_destroy+0x1c>
ffffffffc020521c:	7b6020ef          	jal	ra,ffffffffc02079d2 <inode_ref_dec>
ffffffffc0205220:	0089b403          	ld	s0,8(s3)
ffffffffc0205224:	6485                	lui	s1,0x1
ffffffffc0205226:	fc048493          	addi	s1,s1,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc020522a:	94a2                	add	s1,s1,s0
ffffffffc020522c:	4909                	li	s2,2
ffffffffc020522e:	401c                	lw	a5,0(s0)
ffffffffc0205230:	03278063          	beq	a5,s2,ffffffffc0205250 <files_destroy+0x4c>
ffffffffc0205234:	e39d                	bnez	a5,ffffffffc020525a <files_destroy+0x56>
ffffffffc0205236:	03840413          	addi	s0,s0,56
ffffffffc020523a:	fe849ae3          	bne	s1,s0,ffffffffc020522e <files_destroy+0x2a>
ffffffffc020523e:	7402                	ld	s0,32(sp)
ffffffffc0205240:	70a2                	ld	ra,40(sp)
ffffffffc0205242:	64e2                	ld	s1,24(sp)
ffffffffc0205244:	6942                	ld	s2,16(sp)
ffffffffc0205246:	854e                	mv	a0,s3
ffffffffc0205248:	69a2                	ld	s3,8(sp)
ffffffffc020524a:	6145                	addi	sp,sp,48
ffffffffc020524c:	df3fc06f          	j	ffffffffc020203e <kfree>
ffffffffc0205250:	8522                	mv	a0,s0
ffffffffc0205252:	efcff0ef          	jal	ra,ffffffffc020494e <fd_array_close>
ffffffffc0205256:	401c                	lw	a5,0(s0)
ffffffffc0205258:	bff1                	j	ffffffffc0205234 <files_destroy+0x30>
ffffffffc020525a:	00008697          	auipc	a3,0x8
ffffffffc020525e:	25668693          	addi	a3,a3,598 # ffffffffc020d4b0 <CSWTCH.79+0x58>
ffffffffc0205262:	00006617          	auipc	a2,0x6
ffffffffc0205266:	7e660613          	addi	a2,a2,2022 # ffffffffc020ba48 <commands+0x210>
ffffffffc020526a:	03d00593          	li	a1,61
ffffffffc020526e:	00008517          	auipc	a0,0x8
ffffffffc0205272:	23250513          	addi	a0,a0,562 # ffffffffc020d4a0 <CSWTCH.79+0x48>
ffffffffc0205276:	a28fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020527a:	00008697          	auipc	a3,0x8
ffffffffc020527e:	1f668693          	addi	a3,a3,502 # ffffffffc020d470 <CSWTCH.79+0x18>
ffffffffc0205282:	00006617          	auipc	a2,0x6
ffffffffc0205286:	7c660613          	addi	a2,a2,1990 # ffffffffc020ba48 <commands+0x210>
ffffffffc020528a:	03300593          	li	a1,51
ffffffffc020528e:	00008517          	auipc	a0,0x8
ffffffffc0205292:	21250513          	addi	a0,a0,530 # ffffffffc020d4a0 <CSWTCH.79+0x48>
ffffffffc0205296:	a08fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020529a <files_closeall>:
ffffffffc020529a:	1101                	addi	sp,sp,-32
ffffffffc020529c:	ec06                	sd	ra,24(sp)
ffffffffc020529e:	e822                	sd	s0,16(sp)
ffffffffc02052a0:	e426                	sd	s1,8(sp)
ffffffffc02052a2:	e04a                	sd	s2,0(sp)
ffffffffc02052a4:	c129                	beqz	a0,ffffffffc02052e6 <files_closeall+0x4c>
ffffffffc02052a6:	491c                	lw	a5,16(a0)
ffffffffc02052a8:	02f05f63          	blez	a5,ffffffffc02052e6 <files_closeall+0x4c>
ffffffffc02052ac:	6504                	ld	s1,8(a0)
ffffffffc02052ae:	6785                	lui	a5,0x1
ffffffffc02052b0:	fc078793          	addi	a5,a5,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc02052b4:	07048413          	addi	s0,s1,112
ffffffffc02052b8:	4909                	li	s2,2
ffffffffc02052ba:	94be                	add	s1,s1,a5
ffffffffc02052bc:	a029                	j	ffffffffc02052c6 <files_closeall+0x2c>
ffffffffc02052be:	03840413          	addi	s0,s0,56
ffffffffc02052c2:	00848c63          	beq	s1,s0,ffffffffc02052da <files_closeall+0x40>
ffffffffc02052c6:	401c                	lw	a5,0(s0)
ffffffffc02052c8:	ff279be3          	bne	a5,s2,ffffffffc02052be <files_closeall+0x24>
ffffffffc02052cc:	8522                	mv	a0,s0
ffffffffc02052ce:	03840413          	addi	s0,s0,56
ffffffffc02052d2:	e7cff0ef          	jal	ra,ffffffffc020494e <fd_array_close>
ffffffffc02052d6:	fe8498e3          	bne	s1,s0,ffffffffc02052c6 <files_closeall+0x2c>
ffffffffc02052da:	60e2                	ld	ra,24(sp)
ffffffffc02052dc:	6442                	ld	s0,16(sp)
ffffffffc02052de:	64a2                	ld	s1,8(sp)
ffffffffc02052e0:	6902                	ld	s2,0(sp)
ffffffffc02052e2:	6105                	addi	sp,sp,32
ffffffffc02052e4:	8082                	ret
ffffffffc02052e6:	00008697          	auipc	a3,0x8
ffffffffc02052ea:	dd268693          	addi	a3,a3,-558 # ffffffffc020d0b8 <default_pmm_manager+0xb88>
ffffffffc02052ee:	00006617          	auipc	a2,0x6
ffffffffc02052f2:	75a60613          	addi	a2,a2,1882 # ffffffffc020ba48 <commands+0x210>
ffffffffc02052f6:	04500593          	li	a1,69
ffffffffc02052fa:	00008517          	auipc	a0,0x8
ffffffffc02052fe:	1a650513          	addi	a0,a0,422 # ffffffffc020d4a0 <CSWTCH.79+0x48>
ffffffffc0205302:	99cfb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205306 <dup_files>:
ffffffffc0205306:	7179                	addi	sp,sp,-48
ffffffffc0205308:	f406                	sd	ra,40(sp)
ffffffffc020530a:	f022                	sd	s0,32(sp)
ffffffffc020530c:	ec26                	sd	s1,24(sp)
ffffffffc020530e:	e84a                	sd	s2,16(sp)
ffffffffc0205310:	e44e                	sd	s3,8(sp)
ffffffffc0205312:	e052                	sd	s4,0(sp)
ffffffffc0205314:	c52d                	beqz	a0,ffffffffc020537e <dup_files+0x78>
ffffffffc0205316:	842e                	mv	s0,a1
ffffffffc0205318:	c1bd                	beqz	a1,ffffffffc020537e <dup_files+0x78>
ffffffffc020531a:	491c                	lw	a5,16(a0)
ffffffffc020531c:	84aa                	mv	s1,a0
ffffffffc020531e:	e3c1                	bnez	a5,ffffffffc020539e <dup_files+0x98>
ffffffffc0205320:	499c                	lw	a5,16(a1)
ffffffffc0205322:	06f05e63          	blez	a5,ffffffffc020539e <dup_files+0x98>
ffffffffc0205326:	6188                	ld	a0,0(a1)
ffffffffc0205328:	e088                	sd	a0,0(s1)
ffffffffc020532a:	c119                	beqz	a0,ffffffffc0205330 <dup_files+0x2a>
ffffffffc020532c:	5d8020ef          	jal	ra,ffffffffc0207904 <inode_ref_inc>
ffffffffc0205330:	6400                	ld	s0,8(s0)
ffffffffc0205332:	6905                	lui	s2,0x1
ffffffffc0205334:	fc090913          	addi	s2,s2,-64 # fc0 <_binary_bin_swap_img_size-0x6d40>
ffffffffc0205338:	6484                	ld	s1,8(s1)
ffffffffc020533a:	9922                	add	s2,s2,s0
ffffffffc020533c:	4989                	li	s3,2
ffffffffc020533e:	4a05                	li	s4,1
ffffffffc0205340:	a039                	j	ffffffffc020534e <dup_files+0x48>
ffffffffc0205342:	03840413          	addi	s0,s0,56
ffffffffc0205346:	03848493          	addi	s1,s1,56
ffffffffc020534a:	02890163          	beq	s2,s0,ffffffffc020536c <dup_files+0x66>
ffffffffc020534e:	401c                	lw	a5,0(s0)
ffffffffc0205350:	ff3799e3          	bne	a5,s3,ffffffffc0205342 <dup_files+0x3c>
ffffffffc0205354:	0144a023          	sw	s4,0(s1)
ffffffffc0205358:	85a2                	mv	a1,s0
ffffffffc020535a:	8526                	mv	a0,s1
ffffffffc020535c:	03840413          	addi	s0,s0,56
ffffffffc0205360:	e6cff0ef          	jal	ra,ffffffffc02049cc <fd_array_dup>
ffffffffc0205364:	03848493          	addi	s1,s1,56
ffffffffc0205368:	fe8913e3          	bne	s2,s0,ffffffffc020534e <dup_files+0x48>
ffffffffc020536c:	70a2                	ld	ra,40(sp)
ffffffffc020536e:	7402                	ld	s0,32(sp)
ffffffffc0205370:	64e2                	ld	s1,24(sp)
ffffffffc0205372:	6942                	ld	s2,16(sp)
ffffffffc0205374:	69a2                	ld	s3,8(sp)
ffffffffc0205376:	6a02                	ld	s4,0(sp)
ffffffffc0205378:	4501                	li	a0,0
ffffffffc020537a:	6145                	addi	sp,sp,48
ffffffffc020537c:	8082                	ret
ffffffffc020537e:	00008697          	auipc	a3,0x8
ffffffffc0205382:	a8a68693          	addi	a3,a3,-1398 # ffffffffc020ce08 <default_pmm_manager+0x8d8>
ffffffffc0205386:	00006617          	auipc	a2,0x6
ffffffffc020538a:	6c260613          	addi	a2,a2,1730 # ffffffffc020ba48 <commands+0x210>
ffffffffc020538e:	05300593          	li	a1,83
ffffffffc0205392:	00008517          	auipc	a0,0x8
ffffffffc0205396:	10e50513          	addi	a0,a0,270 # ffffffffc020d4a0 <CSWTCH.79+0x48>
ffffffffc020539a:	904fb0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020539e:	00008697          	auipc	a3,0x8
ffffffffc02053a2:	12a68693          	addi	a3,a3,298 # ffffffffc020d4c8 <CSWTCH.79+0x70>
ffffffffc02053a6:	00006617          	auipc	a2,0x6
ffffffffc02053aa:	6a260613          	addi	a2,a2,1698 # ffffffffc020ba48 <commands+0x210>
ffffffffc02053ae:	05400593          	li	a1,84
ffffffffc02053b2:	00008517          	auipc	a0,0x8
ffffffffc02053b6:	0ee50513          	addi	a0,a0,238 # ffffffffc020d4a0 <CSWTCH.79+0x48>
ffffffffc02053ba:	8e4fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02053be <iobuf_skip.part.0>:
ffffffffc02053be:	1141                	addi	sp,sp,-16
ffffffffc02053c0:	00008697          	auipc	a3,0x8
ffffffffc02053c4:	13868693          	addi	a3,a3,312 # ffffffffc020d4f8 <CSWTCH.79+0xa0>
ffffffffc02053c8:	00006617          	auipc	a2,0x6
ffffffffc02053cc:	68060613          	addi	a2,a2,1664 # ffffffffc020ba48 <commands+0x210>
ffffffffc02053d0:	04a00593          	li	a1,74
ffffffffc02053d4:	00008517          	auipc	a0,0x8
ffffffffc02053d8:	13c50513          	addi	a0,a0,316 # ffffffffc020d510 <CSWTCH.79+0xb8>
ffffffffc02053dc:	e406                	sd	ra,8(sp)
ffffffffc02053de:	8c0fb0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02053e2 <iobuf_init>:
ffffffffc02053e2:	e10c                	sd	a1,0(a0)
ffffffffc02053e4:	e514                	sd	a3,8(a0)
ffffffffc02053e6:	ed10                	sd	a2,24(a0)
ffffffffc02053e8:	e910                	sd	a2,16(a0)
ffffffffc02053ea:	8082                	ret

ffffffffc02053ec <iobuf_move>:
ffffffffc02053ec:	7179                	addi	sp,sp,-48
ffffffffc02053ee:	ec26                	sd	s1,24(sp)
ffffffffc02053f0:	6d04                	ld	s1,24(a0)
ffffffffc02053f2:	f022                	sd	s0,32(sp)
ffffffffc02053f4:	e84a                	sd	s2,16(sp)
ffffffffc02053f6:	e44e                	sd	s3,8(sp)
ffffffffc02053f8:	f406                	sd	ra,40(sp)
ffffffffc02053fa:	842a                	mv	s0,a0
ffffffffc02053fc:	8932                	mv	s2,a2
ffffffffc02053fe:	852e                	mv	a0,a1
ffffffffc0205400:	89ba                	mv	s3,a4
ffffffffc0205402:	00967363          	bgeu	a2,s1,ffffffffc0205408 <iobuf_move+0x1c>
ffffffffc0205406:	84b2                	mv	s1,a2
ffffffffc0205408:	c495                	beqz	s1,ffffffffc0205434 <iobuf_move+0x48>
ffffffffc020540a:	600c                	ld	a1,0(s0)
ffffffffc020540c:	c681                	beqz	a3,ffffffffc0205414 <iobuf_move+0x28>
ffffffffc020540e:	87ae                	mv	a5,a1
ffffffffc0205410:	85aa                	mv	a1,a0
ffffffffc0205412:	853e                	mv	a0,a5
ffffffffc0205414:	8626                	mv	a2,s1
ffffffffc0205416:	162060ef          	jal	ra,ffffffffc020b578 <memmove>
ffffffffc020541a:	6c1c                	ld	a5,24(s0)
ffffffffc020541c:	0297ea63          	bltu	a5,s1,ffffffffc0205450 <iobuf_move+0x64>
ffffffffc0205420:	6014                	ld	a3,0(s0)
ffffffffc0205422:	6418                	ld	a4,8(s0)
ffffffffc0205424:	8f85                	sub	a5,a5,s1
ffffffffc0205426:	96a6                	add	a3,a3,s1
ffffffffc0205428:	9726                	add	a4,a4,s1
ffffffffc020542a:	e014                	sd	a3,0(s0)
ffffffffc020542c:	e418                	sd	a4,8(s0)
ffffffffc020542e:	ec1c                	sd	a5,24(s0)
ffffffffc0205430:	40990933          	sub	s2,s2,s1
ffffffffc0205434:	00098463          	beqz	s3,ffffffffc020543c <iobuf_move+0x50>
ffffffffc0205438:	0099b023          	sd	s1,0(s3)
ffffffffc020543c:	4501                	li	a0,0
ffffffffc020543e:	00091b63          	bnez	s2,ffffffffc0205454 <iobuf_move+0x68>
ffffffffc0205442:	70a2                	ld	ra,40(sp)
ffffffffc0205444:	7402                	ld	s0,32(sp)
ffffffffc0205446:	64e2                	ld	s1,24(sp)
ffffffffc0205448:	6942                	ld	s2,16(sp)
ffffffffc020544a:	69a2                	ld	s3,8(sp)
ffffffffc020544c:	6145                	addi	sp,sp,48
ffffffffc020544e:	8082                	ret
ffffffffc0205450:	f6fff0ef          	jal	ra,ffffffffc02053be <iobuf_skip.part.0>
ffffffffc0205454:	5571                	li	a0,-4
ffffffffc0205456:	b7f5                	j	ffffffffc0205442 <iobuf_move+0x56>

ffffffffc0205458 <iobuf_skip>:
ffffffffc0205458:	6d1c                	ld	a5,24(a0)
ffffffffc020545a:	00b7eb63          	bltu	a5,a1,ffffffffc0205470 <iobuf_skip+0x18>
ffffffffc020545e:	6114                	ld	a3,0(a0)
ffffffffc0205460:	6518                	ld	a4,8(a0)
ffffffffc0205462:	8f8d                	sub	a5,a5,a1
ffffffffc0205464:	96ae                	add	a3,a3,a1
ffffffffc0205466:	95ba                	add	a1,a1,a4
ffffffffc0205468:	e114                	sd	a3,0(a0)
ffffffffc020546a:	e50c                	sd	a1,8(a0)
ffffffffc020546c:	ed1c                	sd	a5,24(a0)
ffffffffc020546e:	8082                	ret
ffffffffc0205470:	1141                	addi	sp,sp,-16
ffffffffc0205472:	e406                	sd	ra,8(sp)
ffffffffc0205474:	f4bff0ef          	jal	ra,ffffffffc02053be <iobuf_skip.part.0>

ffffffffc0205478 <copy_path>:
ffffffffc0205478:	7139                	addi	sp,sp,-64
ffffffffc020547a:	f04a                	sd	s2,32(sp)
ffffffffc020547c:	00091917          	auipc	s2,0x91
ffffffffc0205480:	44490913          	addi	s2,s2,1092 # ffffffffc02968c0 <current>
ffffffffc0205484:	00093703          	ld	a4,0(s2)
ffffffffc0205488:	ec4e                	sd	s3,24(sp)
ffffffffc020548a:	89aa                	mv	s3,a0
ffffffffc020548c:	6505                	lui	a0,0x1
ffffffffc020548e:	f426                	sd	s1,40(sp)
ffffffffc0205490:	e852                	sd	s4,16(sp)
ffffffffc0205492:	fc06                	sd	ra,56(sp)
ffffffffc0205494:	f822                	sd	s0,48(sp)
ffffffffc0205496:	e456                	sd	s5,8(sp)
ffffffffc0205498:	02873a03          	ld	s4,40(a4)
ffffffffc020549c:	84ae                	mv	s1,a1
ffffffffc020549e:	af1fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02054a2:	c141                	beqz	a0,ffffffffc0205522 <copy_path+0xaa>
ffffffffc02054a4:	842a                	mv	s0,a0
ffffffffc02054a6:	040a0563          	beqz	s4,ffffffffc02054f0 <copy_path+0x78>
ffffffffc02054aa:	038a0a93          	addi	s5,s4,56
ffffffffc02054ae:	8556                	mv	a0,s5
ffffffffc02054b0:	8b4ff0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc02054b4:	00093783          	ld	a5,0(s2)
ffffffffc02054b8:	cba1                	beqz	a5,ffffffffc0205508 <copy_path+0x90>
ffffffffc02054ba:	43dc                	lw	a5,4(a5)
ffffffffc02054bc:	6685                	lui	a3,0x1
ffffffffc02054be:	8626                	mv	a2,s1
ffffffffc02054c0:	04fa2823          	sw	a5,80(s4)
ffffffffc02054c4:	85a2                	mv	a1,s0
ffffffffc02054c6:	8552                	mv	a0,s4
ffffffffc02054c8:	ec5fe0ef          	jal	ra,ffffffffc020438c <copy_string>
ffffffffc02054cc:	c529                	beqz	a0,ffffffffc0205516 <copy_path+0x9e>
ffffffffc02054ce:	8556                	mv	a0,s5
ffffffffc02054d0:	890ff0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc02054d4:	040a2823          	sw	zero,80(s4)
ffffffffc02054d8:	0089b023          	sd	s0,0(s3)
ffffffffc02054dc:	4501                	li	a0,0
ffffffffc02054de:	70e2                	ld	ra,56(sp)
ffffffffc02054e0:	7442                	ld	s0,48(sp)
ffffffffc02054e2:	74a2                	ld	s1,40(sp)
ffffffffc02054e4:	7902                	ld	s2,32(sp)
ffffffffc02054e6:	69e2                	ld	s3,24(sp)
ffffffffc02054e8:	6a42                	ld	s4,16(sp)
ffffffffc02054ea:	6aa2                	ld	s5,8(sp)
ffffffffc02054ec:	6121                	addi	sp,sp,64
ffffffffc02054ee:	8082                	ret
ffffffffc02054f0:	85aa                	mv	a1,a0
ffffffffc02054f2:	6685                	lui	a3,0x1
ffffffffc02054f4:	8626                	mv	a2,s1
ffffffffc02054f6:	4501                	li	a0,0
ffffffffc02054f8:	e95fe0ef          	jal	ra,ffffffffc020438c <copy_string>
ffffffffc02054fc:	fd71                	bnez	a0,ffffffffc02054d8 <copy_path+0x60>
ffffffffc02054fe:	8522                	mv	a0,s0
ffffffffc0205500:	b3ffc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205504:	5575                	li	a0,-3
ffffffffc0205506:	bfe1                	j	ffffffffc02054de <copy_path+0x66>
ffffffffc0205508:	6685                	lui	a3,0x1
ffffffffc020550a:	8626                	mv	a2,s1
ffffffffc020550c:	85a2                	mv	a1,s0
ffffffffc020550e:	8552                	mv	a0,s4
ffffffffc0205510:	e7dfe0ef          	jal	ra,ffffffffc020438c <copy_string>
ffffffffc0205514:	fd4d                	bnez	a0,ffffffffc02054ce <copy_path+0x56>
ffffffffc0205516:	8556                	mv	a0,s5
ffffffffc0205518:	848ff0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020551c:	040a2823          	sw	zero,80(s4)
ffffffffc0205520:	bff9                	j	ffffffffc02054fe <copy_path+0x86>
ffffffffc0205522:	5571                	li	a0,-4
ffffffffc0205524:	bf6d                	j	ffffffffc02054de <copy_path+0x66>

ffffffffc0205526 <sysfile_open>:
ffffffffc0205526:	7179                	addi	sp,sp,-48
ffffffffc0205528:	872a                	mv	a4,a0
ffffffffc020552a:	ec26                	sd	s1,24(sp)
ffffffffc020552c:	0028                	addi	a0,sp,8
ffffffffc020552e:	84ae                	mv	s1,a1
ffffffffc0205530:	85ba                	mv	a1,a4
ffffffffc0205532:	f022                	sd	s0,32(sp)
ffffffffc0205534:	f406                	sd	ra,40(sp)
ffffffffc0205536:	f43ff0ef          	jal	ra,ffffffffc0205478 <copy_path>
ffffffffc020553a:	842a                	mv	s0,a0
ffffffffc020553c:	e909                	bnez	a0,ffffffffc020554e <sysfile_open+0x28>
ffffffffc020553e:	6522                	ld	a0,8(sp)
ffffffffc0205540:	85a6                	mv	a1,s1
ffffffffc0205542:	d60ff0ef          	jal	ra,ffffffffc0204aa2 <file_open>
ffffffffc0205546:	842a                	mv	s0,a0
ffffffffc0205548:	6522                	ld	a0,8(sp)
ffffffffc020554a:	af5fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020554e:	70a2                	ld	ra,40(sp)
ffffffffc0205550:	8522                	mv	a0,s0
ffffffffc0205552:	7402                	ld	s0,32(sp)
ffffffffc0205554:	64e2                	ld	s1,24(sp)
ffffffffc0205556:	6145                	addi	sp,sp,48
ffffffffc0205558:	8082                	ret

ffffffffc020555a <sysfile_close>:
ffffffffc020555a:	e46ff06f          	j	ffffffffc0204ba0 <file_close>

ffffffffc020555e <sysfile_read>:
ffffffffc020555e:	7159                	addi	sp,sp,-112
ffffffffc0205560:	f0a2                	sd	s0,96(sp)
ffffffffc0205562:	f486                	sd	ra,104(sp)
ffffffffc0205564:	eca6                	sd	s1,88(sp)
ffffffffc0205566:	e8ca                	sd	s2,80(sp)
ffffffffc0205568:	e4ce                	sd	s3,72(sp)
ffffffffc020556a:	e0d2                	sd	s4,64(sp)
ffffffffc020556c:	fc56                	sd	s5,56(sp)
ffffffffc020556e:	f85a                	sd	s6,48(sp)
ffffffffc0205570:	f45e                	sd	s7,40(sp)
ffffffffc0205572:	f062                	sd	s8,32(sp)
ffffffffc0205574:	ec66                	sd	s9,24(sp)
ffffffffc0205576:	4401                	li	s0,0
ffffffffc0205578:	ee19                	bnez	a2,ffffffffc0205596 <sysfile_read+0x38>
ffffffffc020557a:	70a6                	ld	ra,104(sp)
ffffffffc020557c:	8522                	mv	a0,s0
ffffffffc020557e:	7406                	ld	s0,96(sp)
ffffffffc0205580:	64e6                	ld	s1,88(sp)
ffffffffc0205582:	6946                	ld	s2,80(sp)
ffffffffc0205584:	69a6                	ld	s3,72(sp)
ffffffffc0205586:	6a06                	ld	s4,64(sp)
ffffffffc0205588:	7ae2                	ld	s5,56(sp)
ffffffffc020558a:	7b42                	ld	s6,48(sp)
ffffffffc020558c:	7ba2                	ld	s7,40(sp)
ffffffffc020558e:	7c02                	ld	s8,32(sp)
ffffffffc0205590:	6ce2                	ld	s9,24(sp)
ffffffffc0205592:	6165                	addi	sp,sp,112
ffffffffc0205594:	8082                	ret
ffffffffc0205596:	00091c97          	auipc	s9,0x91
ffffffffc020559a:	32ac8c93          	addi	s9,s9,810 # ffffffffc02968c0 <current>
ffffffffc020559e:	000cb783          	ld	a5,0(s9)
ffffffffc02055a2:	84b2                	mv	s1,a2
ffffffffc02055a4:	8b2e                	mv	s6,a1
ffffffffc02055a6:	4601                	li	a2,0
ffffffffc02055a8:	4585                	li	a1,1
ffffffffc02055aa:	0287b903          	ld	s2,40(a5)
ffffffffc02055ae:	8aaa                	mv	s5,a0
ffffffffc02055b0:	c9eff0ef          	jal	ra,ffffffffc0204a4e <file_testfd>
ffffffffc02055b4:	c959                	beqz	a0,ffffffffc020564a <sysfile_read+0xec>
ffffffffc02055b6:	6505                	lui	a0,0x1
ffffffffc02055b8:	9d7fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02055bc:	89aa                	mv	s3,a0
ffffffffc02055be:	c941                	beqz	a0,ffffffffc020564e <sysfile_read+0xf0>
ffffffffc02055c0:	4b81                	li	s7,0
ffffffffc02055c2:	6a05                	lui	s4,0x1
ffffffffc02055c4:	03890c13          	addi	s8,s2,56
ffffffffc02055c8:	0744ec63          	bltu	s1,s4,ffffffffc0205640 <sysfile_read+0xe2>
ffffffffc02055cc:	e452                	sd	s4,8(sp)
ffffffffc02055ce:	6605                	lui	a2,0x1
ffffffffc02055d0:	0034                	addi	a3,sp,8
ffffffffc02055d2:	85ce                	mv	a1,s3
ffffffffc02055d4:	8556                	mv	a0,s5
ffffffffc02055d6:	e20ff0ef          	jal	ra,ffffffffc0204bf6 <file_read>
ffffffffc02055da:	66a2                	ld	a3,8(sp)
ffffffffc02055dc:	842a                	mv	s0,a0
ffffffffc02055de:	ca9d                	beqz	a3,ffffffffc0205614 <sysfile_read+0xb6>
ffffffffc02055e0:	00090c63          	beqz	s2,ffffffffc02055f8 <sysfile_read+0x9a>
ffffffffc02055e4:	8562                	mv	a0,s8
ffffffffc02055e6:	f7ffe0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc02055ea:	000cb783          	ld	a5,0(s9)
ffffffffc02055ee:	cfa1                	beqz	a5,ffffffffc0205646 <sysfile_read+0xe8>
ffffffffc02055f0:	43dc                	lw	a5,4(a5)
ffffffffc02055f2:	66a2                	ld	a3,8(sp)
ffffffffc02055f4:	04f92823          	sw	a5,80(s2)
ffffffffc02055f8:	864e                	mv	a2,s3
ffffffffc02055fa:	85da                	mv	a1,s6
ffffffffc02055fc:	854a                	mv	a0,s2
ffffffffc02055fe:	d5dfe0ef          	jal	ra,ffffffffc020435a <copy_to_user>
ffffffffc0205602:	c50d                	beqz	a0,ffffffffc020562c <sysfile_read+0xce>
ffffffffc0205604:	67a2                	ld	a5,8(sp)
ffffffffc0205606:	04f4e663          	bltu	s1,a5,ffffffffc0205652 <sysfile_read+0xf4>
ffffffffc020560a:	9b3e                	add	s6,s6,a5
ffffffffc020560c:	8c9d                	sub	s1,s1,a5
ffffffffc020560e:	9bbe                	add	s7,s7,a5
ffffffffc0205610:	02091263          	bnez	s2,ffffffffc0205634 <sysfile_read+0xd6>
ffffffffc0205614:	e401                	bnez	s0,ffffffffc020561c <sysfile_read+0xbe>
ffffffffc0205616:	67a2                	ld	a5,8(sp)
ffffffffc0205618:	c391                	beqz	a5,ffffffffc020561c <sysfile_read+0xbe>
ffffffffc020561a:	f4dd                	bnez	s1,ffffffffc02055c8 <sysfile_read+0x6a>
ffffffffc020561c:	854e                	mv	a0,s3
ffffffffc020561e:	a21fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205622:	f40b8ce3          	beqz	s7,ffffffffc020557a <sysfile_read+0x1c>
ffffffffc0205626:	000b841b          	sext.w	s0,s7
ffffffffc020562a:	bf81                	j	ffffffffc020557a <sysfile_read+0x1c>
ffffffffc020562c:	e011                	bnez	s0,ffffffffc0205630 <sysfile_read+0xd2>
ffffffffc020562e:	5475                	li	s0,-3
ffffffffc0205630:	fe0906e3          	beqz	s2,ffffffffc020561c <sysfile_read+0xbe>
ffffffffc0205634:	8562                	mv	a0,s8
ffffffffc0205636:	f2bfe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020563a:	04092823          	sw	zero,80(s2)
ffffffffc020563e:	bfd9                	j	ffffffffc0205614 <sysfile_read+0xb6>
ffffffffc0205640:	e426                	sd	s1,8(sp)
ffffffffc0205642:	8626                	mv	a2,s1
ffffffffc0205644:	b771                	j	ffffffffc02055d0 <sysfile_read+0x72>
ffffffffc0205646:	66a2                	ld	a3,8(sp)
ffffffffc0205648:	bf45                	j	ffffffffc02055f8 <sysfile_read+0x9a>
ffffffffc020564a:	5475                	li	s0,-3
ffffffffc020564c:	b73d                	j	ffffffffc020557a <sysfile_read+0x1c>
ffffffffc020564e:	5471                	li	s0,-4
ffffffffc0205650:	b72d                	j	ffffffffc020557a <sysfile_read+0x1c>
ffffffffc0205652:	00008697          	auipc	a3,0x8
ffffffffc0205656:	ece68693          	addi	a3,a3,-306 # ffffffffc020d520 <CSWTCH.79+0xc8>
ffffffffc020565a:	00006617          	auipc	a2,0x6
ffffffffc020565e:	3ee60613          	addi	a2,a2,1006 # ffffffffc020ba48 <commands+0x210>
ffffffffc0205662:	05500593          	li	a1,85
ffffffffc0205666:	00008517          	auipc	a0,0x8
ffffffffc020566a:	eca50513          	addi	a0,a0,-310 # ffffffffc020d530 <CSWTCH.79+0xd8>
ffffffffc020566e:	e31fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205672 <sysfile_write>:
ffffffffc0205672:	7159                	addi	sp,sp,-112
ffffffffc0205674:	e8ca                	sd	s2,80(sp)
ffffffffc0205676:	f486                	sd	ra,104(sp)
ffffffffc0205678:	f0a2                	sd	s0,96(sp)
ffffffffc020567a:	eca6                	sd	s1,88(sp)
ffffffffc020567c:	e4ce                	sd	s3,72(sp)
ffffffffc020567e:	e0d2                	sd	s4,64(sp)
ffffffffc0205680:	fc56                	sd	s5,56(sp)
ffffffffc0205682:	f85a                	sd	s6,48(sp)
ffffffffc0205684:	f45e                	sd	s7,40(sp)
ffffffffc0205686:	f062                	sd	s8,32(sp)
ffffffffc0205688:	ec66                	sd	s9,24(sp)
ffffffffc020568a:	4901                	li	s2,0
ffffffffc020568c:	ee19                	bnez	a2,ffffffffc02056aa <sysfile_write+0x38>
ffffffffc020568e:	70a6                	ld	ra,104(sp)
ffffffffc0205690:	7406                	ld	s0,96(sp)
ffffffffc0205692:	64e6                	ld	s1,88(sp)
ffffffffc0205694:	69a6                	ld	s3,72(sp)
ffffffffc0205696:	6a06                	ld	s4,64(sp)
ffffffffc0205698:	7ae2                	ld	s5,56(sp)
ffffffffc020569a:	7b42                	ld	s6,48(sp)
ffffffffc020569c:	7ba2                	ld	s7,40(sp)
ffffffffc020569e:	7c02                	ld	s8,32(sp)
ffffffffc02056a0:	6ce2                	ld	s9,24(sp)
ffffffffc02056a2:	854a                	mv	a0,s2
ffffffffc02056a4:	6946                	ld	s2,80(sp)
ffffffffc02056a6:	6165                	addi	sp,sp,112
ffffffffc02056a8:	8082                	ret
ffffffffc02056aa:	00091c17          	auipc	s8,0x91
ffffffffc02056ae:	216c0c13          	addi	s8,s8,534 # ffffffffc02968c0 <current>
ffffffffc02056b2:	000c3783          	ld	a5,0(s8)
ffffffffc02056b6:	8432                	mv	s0,a2
ffffffffc02056b8:	89ae                	mv	s3,a1
ffffffffc02056ba:	4605                	li	a2,1
ffffffffc02056bc:	4581                	li	a1,0
ffffffffc02056be:	7784                	ld	s1,40(a5)
ffffffffc02056c0:	8baa                	mv	s7,a0
ffffffffc02056c2:	b8cff0ef          	jal	ra,ffffffffc0204a4e <file_testfd>
ffffffffc02056c6:	cd59                	beqz	a0,ffffffffc0205764 <sysfile_write+0xf2>
ffffffffc02056c8:	6505                	lui	a0,0x1
ffffffffc02056ca:	8c5fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02056ce:	8a2a                	mv	s4,a0
ffffffffc02056d0:	cd41                	beqz	a0,ffffffffc0205768 <sysfile_write+0xf6>
ffffffffc02056d2:	4c81                	li	s9,0
ffffffffc02056d4:	6a85                	lui	s5,0x1
ffffffffc02056d6:	03848b13          	addi	s6,s1,56
ffffffffc02056da:	05546a63          	bltu	s0,s5,ffffffffc020572e <sysfile_write+0xbc>
ffffffffc02056de:	e456                	sd	s5,8(sp)
ffffffffc02056e0:	c8a9                	beqz	s1,ffffffffc0205732 <sysfile_write+0xc0>
ffffffffc02056e2:	855a                	mv	a0,s6
ffffffffc02056e4:	e81fe0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc02056e8:	000c3783          	ld	a5,0(s8)
ffffffffc02056ec:	c399                	beqz	a5,ffffffffc02056f2 <sysfile_write+0x80>
ffffffffc02056ee:	43dc                	lw	a5,4(a5)
ffffffffc02056f0:	c8bc                	sw	a5,80(s1)
ffffffffc02056f2:	66a2                	ld	a3,8(sp)
ffffffffc02056f4:	4701                	li	a4,0
ffffffffc02056f6:	864e                	mv	a2,s3
ffffffffc02056f8:	85d2                	mv	a1,s4
ffffffffc02056fa:	8526                	mv	a0,s1
ffffffffc02056fc:	c2bfe0ef          	jal	ra,ffffffffc0204326 <copy_from_user>
ffffffffc0205700:	c139                	beqz	a0,ffffffffc0205746 <sysfile_write+0xd4>
ffffffffc0205702:	855a                	mv	a0,s6
ffffffffc0205704:	e5dfe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0205708:	0404a823          	sw	zero,80(s1)
ffffffffc020570c:	6622                	ld	a2,8(sp)
ffffffffc020570e:	0034                	addi	a3,sp,8
ffffffffc0205710:	85d2                	mv	a1,s4
ffffffffc0205712:	855e                	mv	a0,s7
ffffffffc0205714:	dc8ff0ef          	jal	ra,ffffffffc0204cdc <file_write>
ffffffffc0205718:	67a2                	ld	a5,8(sp)
ffffffffc020571a:	892a                	mv	s2,a0
ffffffffc020571c:	ef85                	bnez	a5,ffffffffc0205754 <sysfile_write+0xe2>
ffffffffc020571e:	8552                	mv	a0,s4
ffffffffc0205720:	91ffc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205724:	f60c85e3          	beqz	s9,ffffffffc020568e <sysfile_write+0x1c>
ffffffffc0205728:	000c891b          	sext.w	s2,s9
ffffffffc020572c:	b78d                	j	ffffffffc020568e <sysfile_write+0x1c>
ffffffffc020572e:	e422                	sd	s0,8(sp)
ffffffffc0205730:	f8cd                	bnez	s1,ffffffffc02056e2 <sysfile_write+0x70>
ffffffffc0205732:	66a2                	ld	a3,8(sp)
ffffffffc0205734:	4701                	li	a4,0
ffffffffc0205736:	864e                	mv	a2,s3
ffffffffc0205738:	85d2                	mv	a1,s4
ffffffffc020573a:	4501                	li	a0,0
ffffffffc020573c:	bebfe0ef          	jal	ra,ffffffffc0204326 <copy_from_user>
ffffffffc0205740:	f571                	bnez	a0,ffffffffc020570c <sysfile_write+0x9a>
ffffffffc0205742:	5975                	li	s2,-3
ffffffffc0205744:	bfe9                	j	ffffffffc020571e <sysfile_write+0xac>
ffffffffc0205746:	855a                	mv	a0,s6
ffffffffc0205748:	e19fe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020574c:	5975                	li	s2,-3
ffffffffc020574e:	0404a823          	sw	zero,80(s1)
ffffffffc0205752:	b7f1                	j	ffffffffc020571e <sysfile_write+0xac>
ffffffffc0205754:	00f46c63          	bltu	s0,a5,ffffffffc020576c <sysfile_write+0xfa>
ffffffffc0205758:	99be                	add	s3,s3,a5
ffffffffc020575a:	8c1d                	sub	s0,s0,a5
ffffffffc020575c:	9cbe                	add	s9,s9,a5
ffffffffc020575e:	f161                	bnez	a0,ffffffffc020571e <sysfile_write+0xac>
ffffffffc0205760:	fc2d                	bnez	s0,ffffffffc02056da <sysfile_write+0x68>
ffffffffc0205762:	bf75                	j	ffffffffc020571e <sysfile_write+0xac>
ffffffffc0205764:	5975                	li	s2,-3
ffffffffc0205766:	b725                	j	ffffffffc020568e <sysfile_write+0x1c>
ffffffffc0205768:	5971                	li	s2,-4
ffffffffc020576a:	b715                	j	ffffffffc020568e <sysfile_write+0x1c>
ffffffffc020576c:	00008697          	auipc	a3,0x8
ffffffffc0205770:	db468693          	addi	a3,a3,-588 # ffffffffc020d520 <CSWTCH.79+0xc8>
ffffffffc0205774:	00006617          	auipc	a2,0x6
ffffffffc0205778:	2d460613          	addi	a2,a2,724 # ffffffffc020ba48 <commands+0x210>
ffffffffc020577c:	08a00593          	li	a1,138
ffffffffc0205780:	00008517          	auipc	a0,0x8
ffffffffc0205784:	db050513          	addi	a0,a0,-592 # ffffffffc020d530 <CSWTCH.79+0xd8>
ffffffffc0205788:	d17fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020578c <sysfile_seek>:
ffffffffc020578c:	e36ff06f          	j	ffffffffc0204dc2 <file_seek>

ffffffffc0205790 <sysfile_fstat>:
ffffffffc0205790:	715d                	addi	sp,sp,-80
ffffffffc0205792:	f44e                	sd	s3,40(sp)
ffffffffc0205794:	00091997          	auipc	s3,0x91
ffffffffc0205798:	12c98993          	addi	s3,s3,300 # ffffffffc02968c0 <current>
ffffffffc020579c:	0009b703          	ld	a4,0(s3)
ffffffffc02057a0:	fc26                	sd	s1,56(sp)
ffffffffc02057a2:	84ae                	mv	s1,a1
ffffffffc02057a4:	858a                	mv	a1,sp
ffffffffc02057a6:	e0a2                	sd	s0,64(sp)
ffffffffc02057a8:	f84a                	sd	s2,48(sp)
ffffffffc02057aa:	e486                	sd	ra,72(sp)
ffffffffc02057ac:	02873903          	ld	s2,40(a4)
ffffffffc02057b0:	f052                	sd	s4,32(sp)
ffffffffc02057b2:	f30ff0ef          	jal	ra,ffffffffc0204ee2 <file_fstat>
ffffffffc02057b6:	842a                	mv	s0,a0
ffffffffc02057b8:	e91d                	bnez	a0,ffffffffc02057ee <sysfile_fstat+0x5e>
ffffffffc02057ba:	04090363          	beqz	s2,ffffffffc0205800 <sysfile_fstat+0x70>
ffffffffc02057be:	03890a13          	addi	s4,s2,56
ffffffffc02057c2:	8552                	mv	a0,s4
ffffffffc02057c4:	da1fe0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc02057c8:	0009b783          	ld	a5,0(s3)
ffffffffc02057cc:	c3b9                	beqz	a5,ffffffffc0205812 <sysfile_fstat+0x82>
ffffffffc02057ce:	43dc                	lw	a5,4(a5)
ffffffffc02057d0:	02000693          	li	a3,32
ffffffffc02057d4:	860a                	mv	a2,sp
ffffffffc02057d6:	04f92823          	sw	a5,80(s2)
ffffffffc02057da:	85a6                	mv	a1,s1
ffffffffc02057dc:	854a                	mv	a0,s2
ffffffffc02057de:	b7dfe0ef          	jal	ra,ffffffffc020435a <copy_to_user>
ffffffffc02057e2:	c121                	beqz	a0,ffffffffc0205822 <sysfile_fstat+0x92>
ffffffffc02057e4:	8552                	mv	a0,s4
ffffffffc02057e6:	d7bfe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc02057ea:	04092823          	sw	zero,80(s2)
ffffffffc02057ee:	60a6                	ld	ra,72(sp)
ffffffffc02057f0:	8522                	mv	a0,s0
ffffffffc02057f2:	6406                	ld	s0,64(sp)
ffffffffc02057f4:	74e2                	ld	s1,56(sp)
ffffffffc02057f6:	7942                	ld	s2,48(sp)
ffffffffc02057f8:	79a2                	ld	s3,40(sp)
ffffffffc02057fa:	7a02                	ld	s4,32(sp)
ffffffffc02057fc:	6161                	addi	sp,sp,80
ffffffffc02057fe:	8082                	ret
ffffffffc0205800:	02000693          	li	a3,32
ffffffffc0205804:	860a                	mv	a2,sp
ffffffffc0205806:	85a6                	mv	a1,s1
ffffffffc0205808:	b53fe0ef          	jal	ra,ffffffffc020435a <copy_to_user>
ffffffffc020580c:	f16d                	bnez	a0,ffffffffc02057ee <sysfile_fstat+0x5e>
ffffffffc020580e:	5475                	li	s0,-3
ffffffffc0205810:	bff9                	j	ffffffffc02057ee <sysfile_fstat+0x5e>
ffffffffc0205812:	02000693          	li	a3,32
ffffffffc0205816:	860a                	mv	a2,sp
ffffffffc0205818:	85a6                	mv	a1,s1
ffffffffc020581a:	854a                	mv	a0,s2
ffffffffc020581c:	b3ffe0ef          	jal	ra,ffffffffc020435a <copy_to_user>
ffffffffc0205820:	f171                	bnez	a0,ffffffffc02057e4 <sysfile_fstat+0x54>
ffffffffc0205822:	8552                	mv	a0,s4
ffffffffc0205824:	d3dfe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0205828:	5475                	li	s0,-3
ffffffffc020582a:	04092823          	sw	zero,80(s2)
ffffffffc020582e:	b7c1                	j	ffffffffc02057ee <sysfile_fstat+0x5e>

ffffffffc0205830 <sysfile_fsync>:
ffffffffc0205830:	f72ff06f          	j	ffffffffc0204fa2 <file_fsync>

ffffffffc0205834 <sysfile_getcwd>:
ffffffffc0205834:	715d                	addi	sp,sp,-80
ffffffffc0205836:	f44e                	sd	s3,40(sp)
ffffffffc0205838:	00091997          	auipc	s3,0x91
ffffffffc020583c:	08898993          	addi	s3,s3,136 # ffffffffc02968c0 <current>
ffffffffc0205840:	0009b783          	ld	a5,0(s3)
ffffffffc0205844:	f84a                	sd	s2,48(sp)
ffffffffc0205846:	e486                	sd	ra,72(sp)
ffffffffc0205848:	e0a2                	sd	s0,64(sp)
ffffffffc020584a:	fc26                	sd	s1,56(sp)
ffffffffc020584c:	f052                	sd	s4,32(sp)
ffffffffc020584e:	0287b903          	ld	s2,40(a5)
ffffffffc0205852:	cda9                	beqz	a1,ffffffffc02058ac <sysfile_getcwd+0x78>
ffffffffc0205854:	842e                	mv	s0,a1
ffffffffc0205856:	84aa                	mv	s1,a0
ffffffffc0205858:	04090363          	beqz	s2,ffffffffc020589e <sysfile_getcwd+0x6a>
ffffffffc020585c:	03890a13          	addi	s4,s2,56
ffffffffc0205860:	8552                	mv	a0,s4
ffffffffc0205862:	d03fe0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0205866:	0009b783          	ld	a5,0(s3)
ffffffffc020586a:	c781                	beqz	a5,ffffffffc0205872 <sysfile_getcwd+0x3e>
ffffffffc020586c:	43dc                	lw	a5,4(a5)
ffffffffc020586e:	04f92823          	sw	a5,80(s2)
ffffffffc0205872:	4685                	li	a3,1
ffffffffc0205874:	8622                	mv	a2,s0
ffffffffc0205876:	85a6                	mv	a1,s1
ffffffffc0205878:	854a                	mv	a0,s2
ffffffffc020587a:	a19fe0ef          	jal	ra,ffffffffc0204292 <user_mem_check>
ffffffffc020587e:	e90d                	bnez	a0,ffffffffc02058b0 <sysfile_getcwd+0x7c>
ffffffffc0205880:	5475                	li	s0,-3
ffffffffc0205882:	8552                	mv	a0,s4
ffffffffc0205884:	cddfe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0205888:	04092823          	sw	zero,80(s2)
ffffffffc020588c:	60a6                	ld	ra,72(sp)
ffffffffc020588e:	8522                	mv	a0,s0
ffffffffc0205890:	6406                	ld	s0,64(sp)
ffffffffc0205892:	74e2                	ld	s1,56(sp)
ffffffffc0205894:	7942                	ld	s2,48(sp)
ffffffffc0205896:	79a2                	ld	s3,40(sp)
ffffffffc0205898:	7a02                	ld	s4,32(sp)
ffffffffc020589a:	6161                	addi	sp,sp,80
ffffffffc020589c:	8082                	ret
ffffffffc020589e:	862e                	mv	a2,a1
ffffffffc02058a0:	4685                	li	a3,1
ffffffffc02058a2:	85aa                	mv	a1,a0
ffffffffc02058a4:	4501                	li	a0,0
ffffffffc02058a6:	9edfe0ef          	jal	ra,ffffffffc0204292 <user_mem_check>
ffffffffc02058aa:	ed09                	bnez	a0,ffffffffc02058c4 <sysfile_getcwd+0x90>
ffffffffc02058ac:	5475                	li	s0,-3
ffffffffc02058ae:	bff9                	j	ffffffffc020588c <sysfile_getcwd+0x58>
ffffffffc02058b0:	8622                	mv	a2,s0
ffffffffc02058b2:	4681                	li	a3,0
ffffffffc02058b4:	85a6                	mv	a1,s1
ffffffffc02058b6:	850a                	mv	a0,sp
ffffffffc02058b8:	b2bff0ef          	jal	ra,ffffffffc02053e2 <iobuf_init>
ffffffffc02058bc:	407020ef          	jal	ra,ffffffffc02084c2 <vfs_getcwd>
ffffffffc02058c0:	842a                	mv	s0,a0
ffffffffc02058c2:	b7c1                	j	ffffffffc0205882 <sysfile_getcwd+0x4e>
ffffffffc02058c4:	8622                	mv	a2,s0
ffffffffc02058c6:	4681                	li	a3,0
ffffffffc02058c8:	85a6                	mv	a1,s1
ffffffffc02058ca:	850a                	mv	a0,sp
ffffffffc02058cc:	b17ff0ef          	jal	ra,ffffffffc02053e2 <iobuf_init>
ffffffffc02058d0:	3f3020ef          	jal	ra,ffffffffc02084c2 <vfs_getcwd>
ffffffffc02058d4:	842a                	mv	s0,a0
ffffffffc02058d6:	bf5d                	j	ffffffffc020588c <sysfile_getcwd+0x58>

ffffffffc02058d8 <sysfile_getdirentry>:
ffffffffc02058d8:	7139                	addi	sp,sp,-64
ffffffffc02058da:	e852                	sd	s4,16(sp)
ffffffffc02058dc:	00091a17          	auipc	s4,0x91
ffffffffc02058e0:	fe4a0a13          	addi	s4,s4,-28 # ffffffffc02968c0 <current>
ffffffffc02058e4:	000a3703          	ld	a4,0(s4)
ffffffffc02058e8:	ec4e                	sd	s3,24(sp)
ffffffffc02058ea:	89aa                	mv	s3,a0
ffffffffc02058ec:	10800513          	li	a0,264
ffffffffc02058f0:	f426                	sd	s1,40(sp)
ffffffffc02058f2:	f04a                	sd	s2,32(sp)
ffffffffc02058f4:	fc06                	sd	ra,56(sp)
ffffffffc02058f6:	f822                	sd	s0,48(sp)
ffffffffc02058f8:	e456                	sd	s5,8(sp)
ffffffffc02058fa:	7704                	ld	s1,40(a4)
ffffffffc02058fc:	892e                	mv	s2,a1
ffffffffc02058fe:	e90fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0205902:	c169                	beqz	a0,ffffffffc02059c4 <sysfile_getdirentry+0xec>
ffffffffc0205904:	842a                	mv	s0,a0
ffffffffc0205906:	c8c1                	beqz	s1,ffffffffc0205996 <sysfile_getdirentry+0xbe>
ffffffffc0205908:	03848a93          	addi	s5,s1,56
ffffffffc020590c:	8556                	mv	a0,s5
ffffffffc020590e:	c57fe0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0205912:	000a3783          	ld	a5,0(s4)
ffffffffc0205916:	c399                	beqz	a5,ffffffffc020591c <sysfile_getdirentry+0x44>
ffffffffc0205918:	43dc                	lw	a5,4(a5)
ffffffffc020591a:	c8bc                	sw	a5,80(s1)
ffffffffc020591c:	4705                	li	a4,1
ffffffffc020591e:	46a1                	li	a3,8
ffffffffc0205920:	864a                	mv	a2,s2
ffffffffc0205922:	85a2                	mv	a1,s0
ffffffffc0205924:	8526                	mv	a0,s1
ffffffffc0205926:	a01fe0ef          	jal	ra,ffffffffc0204326 <copy_from_user>
ffffffffc020592a:	e505                	bnez	a0,ffffffffc0205952 <sysfile_getdirentry+0x7a>
ffffffffc020592c:	8556                	mv	a0,s5
ffffffffc020592e:	c33fe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0205932:	59f5                	li	s3,-3
ffffffffc0205934:	0404a823          	sw	zero,80(s1)
ffffffffc0205938:	8522                	mv	a0,s0
ffffffffc020593a:	f04fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020593e:	70e2                	ld	ra,56(sp)
ffffffffc0205940:	7442                	ld	s0,48(sp)
ffffffffc0205942:	74a2                	ld	s1,40(sp)
ffffffffc0205944:	7902                	ld	s2,32(sp)
ffffffffc0205946:	6a42                	ld	s4,16(sp)
ffffffffc0205948:	6aa2                	ld	s5,8(sp)
ffffffffc020594a:	854e                	mv	a0,s3
ffffffffc020594c:	69e2                	ld	s3,24(sp)
ffffffffc020594e:	6121                	addi	sp,sp,64
ffffffffc0205950:	8082                	ret
ffffffffc0205952:	8556                	mv	a0,s5
ffffffffc0205954:	c0dfe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0205958:	854e                	mv	a0,s3
ffffffffc020595a:	85a2                	mv	a1,s0
ffffffffc020595c:	0404a823          	sw	zero,80(s1)
ffffffffc0205960:	ef0ff0ef          	jal	ra,ffffffffc0205050 <file_getdirentry>
ffffffffc0205964:	89aa                	mv	s3,a0
ffffffffc0205966:	f969                	bnez	a0,ffffffffc0205938 <sysfile_getdirentry+0x60>
ffffffffc0205968:	8556                	mv	a0,s5
ffffffffc020596a:	bfbfe0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc020596e:	000a3783          	ld	a5,0(s4)
ffffffffc0205972:	c399                	beqz	a5,ffffffffc0205978 <sysfile_getdirentry+0xa0>
ffffffffc0205974:	43dc                	lw	a5,4(a5)
ffffffffc0205976:	c8bc                	sw	a5,80(s1)
ffffffffc0205978:	10800693          	li	a3,264
ffffffffc020597c:	8622                	mv	a2,s0
ffffffffc020597e:	85ca                	mv	a1,s2
ffffffffc0205980:	8526                	mv	a0,s1
ffffffffc0205982:	9d9fe0ef          	jal	ra,ffffffffc020435a <copy_to_user>
ffffffffc0205986:	e111                	bnez	a0,ffffffffc020598a <sysfile_getdirentry+0xb2>
ffffffffc0205988:	59f5                	li	s3,-3
ffffffffc020598a:	8556                	mv	a0,s5
ffffffffc020598c:	bd5fe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0205990:	0404a823          	sw	zero,80(s1)
ffffffffc0205994:	b755                	j	ffffffffc0205938 <sysfile_getdirentry+0x60>
ffffffffc0205996:	85aa                	mv	a1,a0
ffffffffc0205998:	4705                	li	a4,1
ffffffffc020599a:	46a1                	li	a3,8
ffffffffc020599c:	864a                	mv	a2,s2
ffffffffc020599e:	4501                	li	a0,0
ffffffffc02059a0:	987fe0ef          	jal	ra,ffffffffc0204326 <copy_from_user>
ffffffffc02059a4:	cd11                	beqz	a0,ffffffffc02059c0 <sysfile_getdirentry+0xe8>
ffffffffc02059a6:	854e                	mv	a0,s3
ffffffffc02059a8:	85a2                	mv	a1,s0
ffffffffc02059aa:	ea6ff0ef          	jal	ra,ffffffffc0205050 <file_getdirentry>
ffffffffc02059ae:	89aa                	mv	s3,a0
ffffffffc02059b0:	f541                	bnez	a0,ffffffffc0205938 <sysfile_getdirentry+0x60>
ffffffffc02059b2:	10800693          	li	a3,264
ffffffffc02059b6:	8622                	mv	a2,s0
ffffffffc02059b8:	85ca                	mv	a1,s2
ffffffffc02059ba:	9a1fe0ef          	jal	ra,ffffffffc020435a <copy_to_user>
ffffffffc02059be:	fd2d                	bnez	a0,ffffffffc0205938 <sysfile_getdirentry+0x60>
ffffffffc02059c0:	59f5                	li	s3,-3
ffffffffc02059c2:	bf9d                	j	ffffffffc0205938 <sysfile_getdirentry+0x60>
ffffffffc02059c4:	59f1                	li	s3,-4
ffffffffc02059c6:	bfa5                	j	ffffffffc020593e <sysfile_getdirentry+0x66>

ffffffffc02059c8 <sysfile_dup>:
ffffffffc02059c8:	f6eff06f          	j	ffffffffc0205136 <file_dup>

ffffffffc02059cc <kernel_thread_entry>:
ffffffffc02059cc:	8526                	mv	a0,s1
ffffffffc02059ce:	9402                	jalr	s0
ffffffffc02059d0:	62c000ef          	jal	ra,ffffffffc0205ffc <do_exit>

ffffffffc02059d4 <alloc_proc>:
ffffffffc02059d4:	1141                	addi	sp,sp,-16
ffffffffc02059d6:	15000513          	li	a0,336
ffffffffc02059da:	e022                	sd	s0,0(sp)
ffffffffc02059dc:	e406                	sd	ra,8(sp)
ffffffffc02059de:	db0fc0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02059e2:	842a                	mv	s0,a0
ffffffffc02059e4:	c141                	beqz	a0,ffffffffc0205a64 <alloc_proc+0x90>
ffffffffc02059e6:	57fd                	li	a5,-1
ffffffffc02059e8:	1782                	slli	a5,a5,0x20
ffffffffc02059ea:	e11c                	sd	a5,0(a0)
ffffffffc02059ec:	07000613          	li	a2,112
ffffffffc02059f0:	4581                	li	a1,0
ffffffffc02059f2:	00052423          	sw	zero,8(a0)
ffffffffc02059f6:	00053823          	sd	zero,16(a0)
ffffffffc02059fa:	00053c23          	sd	zero,24(a0)
ffffffffc02059fe:	02053023          	sd	zero,32(a0)
ffffffffc0205a02:	02053423          	sd	zero,40(a0)
ffffffffc0205a06:	03050513          	addi	a0,a0,48
ffffffffc0205a0a:	35d050ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc0205a0e:	00091797          	auipc	a5,0x91
ffffffffc0205a12:	e827b783          	ld	a5,-382(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0205a16:	f45c                	sd	a5,168(s0)
ffffffffc0205a18:	0a043023          	sd	zero,160(s0)
ffffffffc0205a1c:	0a042823          	sw	zero,176(s0)
ffffffffc0205a20:	463d                	li	a2,15
ffffffffc0205a22:	4581                	li	a1,0
ffffffffc0205a24:	0b440513          	addi	a0,s0,180
ffffffffc0205a28:	33f050ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc0205a2c:	11040793          	addi	a5,s0,272
ffffffffc0205a30:	0e042623          	sw	zero,236(s0)
ffffffffc0205a34:	0e043c23          	sd	zero,248(s0)
ffffffffc0205a38:	10043023          	sd	zero,256(s0)
ffffffffc0205a3c:	0e043823          	sd	zero,240(s0)
ffffffffc0205a40:	10043423          	sd	zero,264(s0)
ffffffffc0205a44:	10f43c23          	sd	a5,280(s0)
ffffffffc0205a48:	10f43823          	sd	a5,272(s0)
ffffffffc0205a4c:	12042023          	sw	zero,288(s0)
ffffffffc0205a50:	12043423          	sd	zero,296(s0)
ffffffffc0205a54:	12043823          	sd	zero,304(s0)
ffffffffc0205a58:	12043c23          	sd	zero,312(s0)
ffffffffc0205a5c:	14043023          	sd	zero,320(s0)
ffffffffc0205a60:	14043423          	sd	zero,328(s0)
ffffffffc0205a64:	60a2                	ld	ra,8(sp)
ffffffffc0205a66:	8522                	mv	a0,s0
ffffffffc0205a68:	6402                	ld	s0,0(sp)
ffffffffc0205a6a:	0141                	addi	sp,sp,16
ffffffffc0205a6c:	8082                	ret

ffffffffc0205a6e <forkret>:
ffffffffc0205a6e:	00091797          	auipc	a5,0x91
ffffffffc0205a72:	e527b783          	ld	a5,-430(a5) # ffffffffc02968c0 <current>
ffffffffc0205a76:	73c8                	ld	a0,160(a5)
ffffffffc0205a78:	833fb06f          	j	ffffffffc02012aa <forkrets>

ffffffffc0205a7c <pa2page.part.0>:
ffffffffc0205a7c:	1141                	addi	sp,sp,-16
ffffffffc0205a7e:	00007617          	auipc	a2,0x7
ffffffffc0205a82:	bba60613          	addi	a2,a2,-1094 # ffffffffc020c638 <default_pmm_manager+0x108>
ffffffffc0205a86:	06900593          	li	a1,105
ffffffffc0205a8a:	00007517          	auipc	a0,0x7
ffffffffc0205a8e:	b0650513          	addi	a0,a0,-1274 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc0205a92:	e406                	sd	ra,8(sp)
ffffffffc0205a94:	a0bfa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205a98 <pte2page.part.0>:
ffffffffc0205a98:	1141                	addi	sp,sp,-16
ffffffffc0205a9a:	00007617          	auipc	a2,0x7
ffffffffc0205a9e:	bbe60613          	addi	a2,a2,-1090 # ffffffffc020c658 <default_pmm_manager+0x128>
ffffffffc0205aa2:	07f00593          	li	a1,127
ffffffffc0205aa6:	00007517          	auipc	a0,0x7
ffffffffc0205aaa:	aea50513          	addi	a0,a0,-1302 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc0205aae:	e406                	sd	ra,8(sp)
ffffffffc0205ab0:	9effa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205ab4 <put_pgdir.isra.0>:
ffffffffc0205ab4:	1141                	addi	sp,sp,-16
ffffffffc0205ab6:	e406                	sd	ra,8(sp)
ffffffffc0205ab8:	c02007b7          	lui	a5,0xc0200
ffffffffc0205abc:	02f56e63          	bltu	a0,a5,ffffffffc0205af8 <put_pgdir.isra.0+0x44>
ffffffffc0205ac0:	00091697          	auipc	a3,0x91
ffffffffc0205ac4:	df86b683          	ld	a3,-520(a3) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205ac8:	8d15                	sub	a0,a0,a3
ffffffffc0205aca:	8131                	srli	a0,a0,0xc
ffffffffc0205acc:	00091797          	auipc	a5,0x91
ffffffffc0205ad0:	dd47b783          	ld	a5,-556(a5) # ffffffffc02968a0 <npage>
ffffffffc0205ad4:	02f57f63          	bgeu	a0,a5,ffffffffc0205b12 <put_pgdir.isra.0+0x5e>
ffffffffc0205ad8:	0000a697          	auipc	a3,0xa
ffffffffc0205adc:	d786b683          	ld	a3,-648(a3) # ffffffffc020f850 <nbase>
ffffffffc0205ae0:	60a2                	ld	ra,8(sp)
ffffffffc0205ae2:	8d15                	sub	a0,a0,a3
ffffffffc0205ae4:	00091797          	auipc	a5,0x91
ffffffffc0205ae8:	dc47b783          	ld	a5,-572(a5) # ffffffffc02968a8 <pages>
ffffffffc0205aec:	051a                	slli	a0,a0,0x6
ffffffffc0205aee:	4585                	li	a1,1
ffffffffc0205af0:	953e                	add	a0,a0,a5
ffffffffc0205af2:	0141                	addi	sp,sp,16
ffffffffc0205af4:	eb6fc06f          	j	ffffffffc02021aa <free_pages>
ffffffffc0205af8:	86aa                	mv	a3,a0
ffffffffc0205afa:	00007617          	auipc	a2,0x7
ffffffffc0205afe:	b1660613          	addi	a2,a2,-1258 # ffffffffc020c610 <default_pmm_manager+0xe0>
ffffffffc0205b02:	07700593          	li	a1,119
ffffffffc0205b06:	00007517          	auipc	a0,0x7
ffffffffc0205b0a:	a8a50513          	addi	a0,a0,-1398 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc0205b0e:	991fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205b12:	f6bff0ef          	jal	ra,ffffffffc0205a7c <pa2page.part.0>

ffffffffc0205b16 <proc_run>:
ffffffffc0205b16:	1101                	addi	sp,sp,-32
ffffffffc0205b18:	e822                	sd	s0,16(sp)
ffffffffc0205b1a:	e04a                	sd	s2,0(sp)
ffffffffc0205b1c:	00091797          	auipc	a5,0x91
ffffffffc0205b20:	da478793          	addi	a5,a5,-604 # ffffffffc02968c0 <current>
ffffffffc0205b24:	ec06                	sd	ra,24(sp)
ffffffffc0205b26:	e426                	sd	s1,8(sp)
ffffffffc0205b28:	0007b903          	ld	s2,0(a5)
ffffffffc0205b2c:	842a                	mv	s0,a0
ffffffffc0205b2e:	e388                	sd	a0,0(a5)
ffffffffc0205b30:	100027f3          	csrr	a5,sstatus
ffffffffc0205b34:	8b89                	andi	a5,a5,2
ffffffffc0205b36:	4481                	li	s1,0
ffffffffc0205b38:	ef95                	bnez	a5,ffffffffc0205b74 <proc_run+0x5e>
ffffffffc0205b3a:	745c                	ld	a5,168(s0)
ffffffffc0205b3c:	577d                	li	a4,-1
ffffffffc0205b3e:	177e                	slli	a4,a4,0x3f
ffffffffc0205b40:	83b1                	srli	a5,a5,0xc
ffffffffc0205b42:	8fd9                	or	a5,a5,a4
ffffffffc0205b44:	18079073          	csrw	satp,a5
ffffffffc0205b48:	12000073          	sfence.vma
ffffffffc0205b4c:	03040593          	addi	a1,s0,48
ffffffffc0205b50:	03090513          	addi	a0,s2,48
ffffffffc0205b54:	638010ef          	jal	ra,ffffffffc020718c <switch_to>
ffffffffc0205b58:	e499                	bnez	s1,ffffffffc0205b66 <proc_run+0x50>
ffffffffc0205b5a:	60e2                	ld	ra,24(sp)
ffffffffc0205b5c:	6442                	ld	s0,16(sp)
ffffffffc0205b5e:	64a2                	ld	s1,8(sp)
ffffffffc0205b60:	6902                	ld	s2,0(sp)
ffffffffc0205b62:	6105                	addi	sp,sp,32
ffffffffc0205b64:	8082                	ret
ffffffffc0205b66:	6442                	ld	s0,16(sp)
ffffffffc0205b68:	60e2                	ld	ra,24(sp)
ffffffffc0205b6a:	64a2                	ld	s1,8(sp)
ffffffffc0205b6c:	6902                	ld	s2,0(sp)
ffffffffc0205b6e:	6105                	addi	sp,sp,32
ffffffffc0205b70:	8fcfb06f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0205b74:	8fefb0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0205b78:	4485                	li	s1,1
ffffffffc0205b7a:	b7c1                	j	ffffffffc0205b3a <proc_run+0x24>

ffffffffc0205b7c <do_fork>:
ffffffffc0205b7c:	7119                	addi	sp,sp,-128
ffffffffc0205b7e:	ecce                	sd	s3,88(sp)
ffffffffc0205b80:	00091997          	auipc	s3,0x91
ffffffffc0205b84:	d5898993          	addi	s3,s3,-680 # ffffffffc02968d8 <nr_process>
ffffffffc0205b88:	0009a703          	lw	a4,0(s3)
ffffffffc0205b8c:	fc86                	sd	ra,120(sp)
ffffffffc0205b8e:	f8a2                	sd	s0,112(sp)
ffffffffc0205b90:	f4a6                	sd	s1,104(sp)
ffffffffc0205b92:	f0ca                	sd	s2,96(sp)
ffffffffc0205b94:	e8d2                	sd	s4,80(sp)
ffffffffc0205b96:	e4d6                	sd	s5,72(sp)
ffffffffc0205b98:	e0da                	sd	s6,64(sp)
ffffffffc0205b9a:	fc5e                	sd	s7,56(sp)
ffffffffc0205b9c:	f862                	sd	s8,48(sp)
ffffffffc0205b9e:	f466                	sd	s9,40(sp)
ffffffffc0205ba0:	f06a                	sd	s10,32(sp)
ffffffffc0205ba2:	ec6e                	sd	s11,24(sp)
ffffffffc0205ba4:	6785                	lui	a5,0x1
ffffffffc0205ba6:	34f75263          	bge	a4,a5,ffffffffc0205eea <do_fork+0x36e>
ffffffffc0205baa:	84aa                	mv	s1,a0
ffffffffc0205bac:	892e                	mv	s2,a1
ffffffffc0205bae:	8432                	mv	s0,a2
ffffffffc0205bb0:	e25ff0ef          	jal	ra,ffffffffc02059d4 <alloc_proc>
ffffffffc0205bb4:	8aaa                	mv	s5,a0
ffffffffc0205bb6:	34050d63          	beqz	a0,ffffffffc0205f10 <do_fork+0x394>
ffffffffc0205bba:	00091b97          	auipc	s7,0x91
ffffffffc0205bbe:	d06b8b93          	addi	s7,s7,-762 # ffffffffc02968c0 <current>
ffffffffc0205bc2:	000bb783          	ld	a5,0(s7)
ffffffffc0205bc6:	0ec7a703          	lw	a4,236(a5) # 10ec <_binary_bin_swap_img_size-0x6c14>
ffffffffc0205bca:	f11c                	sd	a5,32(a0)
ffffffffc0205bcc:	38071363          	bnez	a4,ffffffffc0205f52 <do_fork+0x3d6>
ffffffffc0205bd0:	4509                	li	a0,2
ffffffffc0205bd2:	d9afc0ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0205bd6:	30050463          	beqz	a0,ffffffffc0205ede <do_fork+0x362>
ffffffffc0205bda:	00091c17          	auipc	s8,0x91
ffffffffc0205bde:	ccec0c13          	addi	s8,s8,-818 # ffffffffc02968a8 <pages>
ffffffffc0205be2:	000c3683          	ld	a3,0(s8)
ffffffffc0205be6:	00091c97          	auipc	s9,0x91
ffffffffc0205bea:	cbac8c93          	addi	s9,s9,-838 # ffffffffc02968a0 <npage>
ffffffffc0205bee:	0000aa17          	auipc	s4,0xa
ffffffffc0205bf2:	c62a3a03          	ld	s4,-926(s4) # ffffffffc020f850 <nbase>
ffffffffc0205bf6:	40d506b3          	sub	a3,a0,a3
ffffffffc0205bfa:	8699                	srai	a3,a3,0x6
ffffffffc0205bfc:	5b7d                	li	s6,-1
ffffffffc0205bfe:	000cb783          	ld	a5,0(s9)
ffffffffc0205c02:	96d2                	add	a3,a3,s4
ffffffffc0205c04:	00cb5b13          	srli	s6,s6,0xc
ffffffffc0205c08:	0166f733          	and	a4,a3,s6
ffffffffc0205c0c:	06b2                	slli	a3,a3,0xc
ffffffffc0205c0e:	30f77863          	bgeu	a4,a5,ffffffffc0205f1e <do_fork+0x3a2>
ffffffffc0205c12:	000bb703          	ld	a4,0(s7)
ffffffffc0205c16:	00091d97          	auipc	s11,0x91
ffffffffc0205c1a:	ca2d8d93          	addi	s11,s11,-862 # ffffffffc02968b8 <va_pa_offset>
ffffffffc0205c1e:	000db783          	ld	a5,0(s11)
ffffffffc0205c22:	02873d03          	ld	s10,40(a4)
ffffffffc0205c26:	96be                	add	a3,a3,a5
ffffffffc0205c28:	00dab823          	sd	a3,16(s5) # 1010 <_binary_bin_swap_img_size-0x6cf0>
ffffffffc0205c2c:	020d0a63          	beqz	s10,ffffffffc0205c60 <do_fork+0xe4>
ffffffffc0205c30:	1004f793          	andi	a5,s1,256
ffffffffc0205c34:	1c078763          	beqz	a5,ffffffffc0205e02 <do_fork+0x286>
ffffffffc0205c38:	030d2683          	lw	a3,48(s10)
ffffffffc0205c3c:	018d3783          	ld	a5,24(s10)
ffffffffc0205c40:	c0200637          	lui	a2,0xc0200
ffffffffc0205c44:	2685                	addiw	a3,a3,1
ffffffffc0205c46:	02dd2823          	sw	a3,48(s10)
ffffffffc0205c4a:	03aab423          	sd	s10,40(s5)
ffffffffc0205c4e:	34c7e263          	bltu	a5,a2,ffffffffc0205f92 <do_fork+0x416>
ffffffffc0205c52:	000db703          	ld	a4,0(s11)
ffffffffc0205c56:	010ab683          	ld	a3,16(s5)
ffffffffc0205c5a:	8f99                	sub	a5,a5,a4
ffffffffc0205c5c:	0afab423          	sd	a5,168(s5)
ffffffffc0205c60:	6789                	lui	a5,0x2
ffffffffc0205c62:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0205c66:	96be                	add	a3,a3,a5
ffffffffc0205c68:	0adab023          	sd	a3,160(s5)
ffffffffc0205c6c:	87b6                	mv	a5,a3
ffffffffc0205c6e:	12040813          	addi	a6,s0,288
ffffffffc0205c72:	6008                	ld	a0,0(s0)
ffffffffc0205c74:	640c                	ld	a1,8(s0)
ffffffffc0205c76:	6810                	ld	a2,16(s0)
ffffffffc0205c78:	6c18                	ld	a4,24(s0)
ffffffffc0205c7a:	e388                	sd	a0,0(a5)
ffffffffc0205c7c:	e78c                	sd	a1,8(a5)
ffffffffc0205c7e:	eb90                	sd	a2,16(a5)
ffffffffc0205c80:	ef98                	sd	a4,24(a5)
ffffffffc0205c82:	02040413          	addi	s0,s0,32
ffffffffc0205c86:	02078793          	addi	a5,a5,32
ffffffffc0205c8a:	ff0414e3          	bne	s0,a6,ffffffffc0205c72 <do_fork+0xf6>
ffffffffc0205c8e:	0406b823          	sd	zero,80(a3)
ffffffffc0205c92:	00091363          	bnez	s2,ffffffffc0205c98 <do_fork+0x11c>
ffffffffc0205c96:	8936                	mv	s2,a3
ffffffffc0205c98:	0008b817          	auipc	a6,0x8b
ffffffffc0205c9c:	3c080813          	addi	a6,a6,960 # ffffffffc0291058 <last_pid.1>
ffffffffc0205ca0:	00082783          	lw	a5,0(a6)
ffffffffc0205ca4:	0126b823          	sd	s2,16(a3)
ffffffffc0205ca8:	00000717          	auipc	a4,0x0
ffffffffc0205cac:	dc670713          	addi	a4,a4,-570 # ffffffffc0205a6e <forkret>
ffffffffc0205cb0:	0017851b          	addiw	a0,a5,1
ffffffffc0205cb4:	02eab823          	sd	a4,48(s5)
ffffffffc0205cb8:	02dabc23          	sd	a3,56(s5)
ffffffffc0205cbc:	00a82023          	sw	a0,0(a6)
ffffffffc0205cc0:	6789                	lui	a5,0x2
ffffffffc0205cc2:	1cf55163          	bge	a0,a5,ffffffffc0205e84 <do_fork+0x308>
ffffffffc0205cc6:	0008b317          	auipc	t1,0x8b
ffffffffc0205cca:	39630313          	addi	t1,t1,918 # ffffffffc029105c <next_safe.0>
ffffffffc0205cce:	00032783          	lw	a5,0(t1)
ffffffffc0205cd2:	00090417          	auipc	s0,0x90
ffffffffc0205cd6:	aee40413          	addi	s0,s0,-1298 # ffffffffc02957c0 <proc_list>
ffffffffc0205cda:	06f54063          	blt	a0,a5,ffffffffc0205d3a <do_fork+0x1be>
ffffffffc0205cde:	00090417          	auipc	s0,0x90
ffffffffc0205ce2:	ae240413          	addi	s0,s0,-1310 # ffffffffc02957c0 <proc_list>
ffffffffc0205ce6:	00843e03          	ld	t3,8(s0)
ffffffffc0205cea:	6789                	lui	a5,0x2
ffffffffc0205cec:	00f32023          	sw	a5,0(t1)
ffffffffc0205cf0:	86aa                	mv	a3,a0
ffffffffc0205cf2:	4581                	li	a1,0
ffffffffc0205cf4:	6e89                	lui	t4,0x2
ffffffffc0205cf6:	208e0863          	beq	t3,s0,ffffffffc0205f06 <do_fork+0x38a>
ffffffffc0205cfa:	88ae                	mv	a7,a1
ffffffffc0205cfc:	87f2                	mv	a5,t3
ffffffffc0205cfe:	6609                	lui	a2,0x2
ffffffffc0205d00:	a811                	j	ffffffffc0205d14 <do_fork+0x198>
ffffffffc0205d02:	00e6d663          	bge	a3,a4,ffffffffc0205d0e <do_fork+0x192>
ffffffffc0205d06:	00c75463          	bge	a4,a2,ffffffffc0205d0e <do_fork+0x192>
ffffffffc0205d0a:	863a                	mv	a2,a4
ffffffffc0205d0c:	4885                	li	a7,1
ffffffffc0205d0e:	679c                	ld	a5,8(a5)
ffffffffc0205d10:	00878d63          	beq	a5,s0,ffffffffc0205d2a <do_fork+0x1ae>
ffffffffc0205d14:	f3c7a703          	lw	a4,-196(a5) # 1f3c <_binary_bin_swap_img_size-0x5dc4>
ffffffffc0205d18:	fed715e3          	bne	a4,a3,ffffffffc0205d02 <do_fork+0x186>
ffffffffc0205d1c:	2685                	addiw	a3,a3,1
ffffffffc0205d1e:	1ac6db63          	bge	a3,a2,ffffffffc0205ed4 <do_fork+0x358>
ffffffffc0205d22:	679c                	ld	a5,8(a5)
ffffffffc0205d24:	4585                	li	a1,1
ffffffffc0205d26:	fe8797e3          	bne	a5,s0,ffffffffc0205d14 <do_fork+0x198>
ffffffffc0205d2a:	c581                	beqz	a1,ffffffffc0205d32 <do_fork+0x1b6>
ffffffffc0205d2c:	00d82023          	sw	a3,0(a6)
ffffffffc0205d30:	8536                	mv	a0,a3
ffffffffc0205d32:	00088463          	beqz	a7,ffffffffc0205d3a <do_fork+0x1be>
ffffffffc0205d36:	00c32023          	sw	a2,0(t1)
ffffffffc0205d3a:	00aaa223          	sw	a0,4(s5)
ffffffffc0205d3e:	45a9                	li	a1,10
ffffffffc0205d40:	2501                	sext.w	a0,a0
ffffffffc0205d42:	2f0050ef          	jal	ra,ffffffffc020b032 <hash32>
ffffffffc0205d46:	02051793          	slli	a5,a0,0x20
ffffffffc0205d4a:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0205d4e:	0008c797          	auipc	a5,0x8c
ffffffffc0205d52:	a7278793          	addi	a5,a5,-1422 # ffffffffc02917c0 <hash_list>
ffffffffc0205d56:	953e                	add	a0,a0,a5
ffffffffc0205d58:	650c                	ld	a1,8(a0)
ffffffffc0205d5a:	020ab683          	ld	a3,32(s5)
ffffffffc0205d5e:	0d8a8793          	addi	a5,s5,216
ffffffffc0205d62:	e19c                	sd	a5,0(a1)
ffffffffc0205d64:	6410                	ld	a2,8(s0)
ffffffffc0205d66:	e51c                	sd	a5,8(a0)
ffffffffc0205d68:	7af8                	ld	a4,240(a3)
ffffffffc0205d6a:	0c8a8793          	addi	a5,s5,200
ffffffffc0205d6e:	0ebab023          	sd	a1,224(s5)
ffffffffc0205d72:	0caabc23          	sd	a0,216(s5)
ffffffffc0205d76:	e21c                	sd	a5,0(a2)
ffffffffc0205d78:	e41c                	sd	a5,8(s0)
ffffffffc0205d7a:	0ccab823          	sd	a2,208(s5)
ffffffffc0205d7e:	0c8ab423          	sd	s0,200(s5)
ffffffffc0205d82:	0e0abc23          	sd	zero,248(s5)
ffffffffc0205d86:	10eab023          	sd	a4,256(s5)
ffffffffc0205d8a:	c319                	beqz	a4,ffffffffc0205d90 <do_fork+0x214>
ffffffffc0205d8c:	0f573c23          	sd	s5,248(a4)
ffffffffc0205d90:	000bb703          	ld	a4,0(s7)
ffffffffc0205d94:	0009a783          	lw	a5,0(s3)
ffffffffc0205d98:	0f56b823          	sd	s5,240(a3)
ffffffffc0205d9c:	14873903          	ld	s2,328(a4)
ffffffffc0205da0:	2785                	addiw	a5,a5,1
ffffffffc0205da2:	00f9a023          	sw	a5,0(s3)
ffffffffc0205da6:	1c090663          	beqz	s2,ffffffffc0205f72 <do_fork+0x3f6>
ffffffffc0205daa:	80ad                	srli	s1,s1,0xb
ffffffffc0205dac:	8885                	andi	s1,s1,1
ffffffffc0205dae:	ec91                	bnez	s1,ffffffffc0205dca <do_fork+0x24e>
ffffffffc0205db0:	004aa403          	lw	s0,4(s5)
ffffffffc0205db4:	c1aff0ef          	jal	ra,ffffffffc02051ce <files_create>
ffffffffc0205db8:	84aa                	mv	s1,a0
ffffffffc0205dba:	0e050263          	beqz	a0,ffffffffc0205e9e <do_fork+0x322>
ffffffffc0205dbe:	85ca                	mv	a1,s2
ffffffffc0205dc0:	d46ff0ef          	jal	ra,ffffffffc0205306 <dup_files>
ffffffffc0205dc4:	8926                	mv	s2,s1
ffffffffc0205dc6:	10051e63          	bnez	a0,ffffffffc0205ee2 <do_fork+0x366>
ffffffffc0205dca:	01092783          	lw	a5,16(s2)
ffffffffc0205dce:	8556                	mv	a0,s5
ffffffffc0205dd0:	2785                	addiw	a5,a5,1
ffffffffc0205dd2:	00f92823          	sw	a5,16(s2)
ffffffffc0205dd6:	152ab423          	sd	s2,328(s5)
ffffffffc0205dda:	556010ef          	jal	ra,ffffffffc0207330 <wakeup_proc>
ffffffffc0205dde:	004aa403          	lw	s0,4(s5)
ffffffffc0205de2:	70e6                	ld	ra,120(sp)
ffffffffc0205de4:	8522                	mv	a0,s0
ffffffffc0205de6:	7446                	ld	s0,112(sp)
ffffffffc0205de8:	74a6                	ld	s1,104(sp)
ffffffffc0205dea:	7906                	ld	s2,96(sp)
ffffffffc0205dec:	69e6                	ld	s3,88(sp)
ffffffffc0205dee:	6a46                	ld	s4,80(sp)
ffffffffc0205df0:	6aa6                	ld	s5,72(sp)
ffffffffc0205df2:	6b06                	ld	s6,64(sp)
ffffffffc0205df4:	7be2                	ld	s7,56(sp)
ffffffffc0205df6:	7c42                	ld	s8,48(sp)
ffffffffc0205df8:	7ca2                	ld	s9,40(sp)
ffffffffc0205dfa:	7d02                	ld	s10,32(sp)
ffffffffc0205dfc:	6de2                	ld	s11,24(sp)
ffffffffc0205dfe:	6109                	addi	sp,sp,128
ffffffffc0205e00:	8082                	ret
ffffffffc0205e02:	e07fd0ef          	jal	ra,ffffffffc0203c08 <mm_create>
ffffffffc0205e06:	e02a                	sd	a0,0(sp)
ffffffffc0205e08:	10050963          	beqz	a0,ffffffffc0205f1a <do_fork+0x39e>
ffffffffc0205e0c:	4505                	li	a0,1
ffffffffc0205e0e:	b5efc0ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc0205e12:	c151                	beqz	a0,ffffffffc0205e96 <do_fork+0x31a>
ffffffffc0205e14:	000c3683          	ld	a3,0(s8)
ffffffffc0205e18:	000cb783          	ld	a5,0(s9)
ffffffffc0205e1c:	40d506b3          	sub	a3,a0,a3
ffffffffc0205e20:	8699                	srai	a3,a3,0x6
ffffffffc0205e22:	96d2                	add	a3,a3,s4
ffffffffc0205e24:	0166fb33          	and	s6,a3,s6
ffffffffc0205e28:	06b2                	slli	a3,a3,0xc
ffffffffc0205e2a:	0efb7a63          	bgeu	s6,a5,ffffffffc0205f1e <do_fork+0x3a2>
ffffffffc0205e2e:	000dbb03          	ld	s6,0(s11)
ffffffffc0205e32:	6605                	lui	a2,0x1
ffffffffc0205e34:	00091597          	auipc	a1,0x91
ffffffffc0205e38:	a645b583          	ld	a1,-1436(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0205e3c:	9b36                	add	s6,s6,a3
ffffffffc0205e3e:	855a                	mv	a0,s6
ffffffffc0205e40:	778050ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc0205e44:	6702                	ld	a4,0(sp)
ffffffffc0205e46:	038d0793          	addi	a5,s10,56
ffffffffc0205e4a:	853e                	mv	a0,a5
ffffffffc0205e4c:	01673c23          	sd	s6,24(a4)
ffffffffc0205e50:	e43e                	sd	a5,8(sp)
ffffffffc0205e52:	f12fe0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0205e56:	000bb683          	ld	a3,0(s7)
ffffffffc0205e5a:	67a2                	ld	a5,8(sp)
ffffffffc0205e5c:	c681                	beqz	a3,ffffffffc0205e64 <do_fork+0x2e8>
ffffffffc0205e5e:	42d4                	lw	a3,4(a3)
ffffffffc0205e60:	04dd2823          	sw	a3,80(s10)
ffffffffc0205e64:	6502                	ld	a0,0(sp)
ffffffffc0205e66:	85ea                	mv	a1,s10
ffffffffc0205e68:	e43e                	sd	a5,8(sp)
ffffffffc0205e6a:	feffd0ef          	jal	ra,ffffffffc0203e58 <dup_mmap>
ffffffffc0205e6e:	67a2                	ld	a5,8(sp)
ffffffffc0205e70:	8b2a                	mv	s6,a0
ffffffffc0205e72:	853e                	mv	a0,a5
ffffffffc0205e74:	eecfe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0205e78:	040d2823          	sw	zero,80(s10)
ffffffffc0205e7c:	060b1963          	bnez	s6,ffffffffc0205eee <do_fork+0x372>
ffffffffc0205e80:	6d02                	ld	s10,0(sp)
ffffffffc0205e82:	bb5d                	j	ffffffffc0205c38 <do_fork+0xbc>
ffffffffc0205e84:	4785                	li	a5,1
ffffffffc0205e86:	00f82023          	sw	a5,0(a6)
ffffffffc0205e8a:	4505                	li	a0,1
ffffffffc0205e8c:	0008b317          	auipc	t1,0x8b
ffffffffc0205e90:	1d030313          	addi	t1,t1,464 # ffffffffc029105c <next_safe.0>
ffffffffc0205e94:	b5a9                	j	ffffffffc0205cde <do_fork+0x162>
ffffffffc0205e96:	6502                	ld	a0,0(sp)
ffffffffc0205e98:	5471                	li	s0,-4
ffffffffc0205e9a:	ebdfd0ef          	jal	ra,ffffffffc0203d56 <mm_destroy>
ffffffffc0205e9e:	010ab683          	ld	a3,16(s5)
ffffffffc0205ea2:	c02007b7          	lui	a5,0xc0200
ffffffffc0205ea6:	08f6e863          	bltu	a3,a5,ffffffffc0205f36 <do_fork+0x3ba>
ffffffffc0205eaa:	000db703          	ld	a4,0(s11)
ffffffffc0205eae:	000cb783          	ld	a5,0(s9)
ffffffffc0205eb2:	8e99                	sub	a3,a3,a4
ffffffffc0205eb4:	82b1                	srli	a3,a3,0xc
ffffffffc0205eb6:	08f6fc63          	bgeu	a3,a5,ffffffffc0205f4e <do_fork+0x3d2>
ffffffffc0205eba:	000c3503          	ld	a0,0(s8)
ffffffffc0205ebe:	414686b3          	sub	a3,a3,s4
ffffffffc0205ec2:	069a                	slli	a3,a3,0x6
ffffffffc0205ec4:	4589                	li	a1,2
ffffffffc0205ec6:	9536                	add	a0,a0,a3
ffffffffc0205ec8:	ae2fc0ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc0205ecc:	8556                	mv	a0,s5
ffffffffc0205ece:	970fc0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0205ed2:	bf01                	j	ffffffffc0205de2 <do_fork+0x266>
ffffffffc0205ed4:	01d6c363          	blt	a3,t4,ffffffffc0205eda <do_fork+0x35e>
ffffffffc0205ed8:	4685                	li	a3,1
ffffffffc0205eda:	4585                	li	a1,1
ffffffffc0205edc:	bd29                	j	ffffffffc0205cf6 <do_fork+0x17a>
ffffffffc0205ede:	5471                	li	s0,-4
ffffffffc0205ee0:	b7f5                	j	ffffffffc0205ecc <do_fork+0x350>
ffffffffc0205ee2:	8526                	mv	a0,s1
ffffffffc0205ee4:	b20ff0ef          	jal	ra,ffffffffc0205204 <files_destroy>
ffffffffc0205ee8:	bf5d                	j	ffffffffc0205e9e <do_fork+0x322>
ffffffffc0205eea:	546d                	li	s0,-5
ffffffffc0205eec:	bddd                	j	ffffffffc0205de2 <do_fork+0x266>
ffffffffc0205eee:	6482                	ld	s1,0(sp)
ffffffffc0205ef0:	5471                	li	s0,-4
ffffffffc0205ef2:	8526                	mv	a0,s1
ffffffffc0205ef4:	ffffd0ef          	jal	ra,ffffffffc0203ef2 <exit_mmap>
ffffffffc0205ef8:	6c88                	ld	a0,24(s1)
ffffffffc0205efa:	bbbff0ef          	jal	ra,ffffffffc0205ab4 <put_pgdir.isra.0>
ffffffffc0205efe:	8526                	mv	a0,s1
ffffffffc0205f00:	e57fd0ef          	jal	ra,ffffffffc0203d56 <mm_destroy>
ffffffffc0205f04:	bf69                	j	ffffffffc0205e9e <do_fork+0x322>
ffffffffc0205f06:	c599                	beqz	a1,ffffffffc0205f14 <do_fork+0x398>
ffffffffc0205f08:	00d82023          	sw	a3,0(a6)
ffffffffc0205f0c:	8536                	mv	a0,a3
ffffffffc0205f0e:	b535                	j	ffffffffc0205d3a <do_fork+0x1be>
ffffffffc0205f10:	5471                	li	s0,-4
ffffffffc0205f12:	bdc1                	j	ffffffffc0205de2 <do_fork+0x266>
ffffffffc0205f14:	00082503          	lw	a0,0(a6)
ffffffffc0205f18:	b50d                	j	ffffffffc0205d3a <do_fork+0x1be>
ffffffffc0205f1a:	5471                	li	s0,-4
ffffffffc0205f1c:	b749                	j	ffffffffc0205e9e <do_fork+0x322>
ffffffffc0205f1e:	00006617          	auipc	a2,0x6
ffffffffc0205f22:	64a60613          	addi	a2,a2,1610 # ffffffffc020c568 <default_pmm_manager+0x38>
ffffffffc0205f26:	07100593          	li	a1,113
ffffffffc0205f2a:	00006517          	auipc	a0,0x6
ffffffffc0205f2e:	66650513          	addi	a0,a0,1638 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc0205f32:	d6cfa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f36:	00006617          	auipc	a2,0x6
ffffffffc0205f3a:	6da60613          	addi	a2,a2,1754 # ffffffffc020c610 <default_pmm_manager+0xe0>
ffffffffc0205f3e:	07700593          	li	a1,119
ffffffffc0205f42:	00006517          	auipc	a0,0x6
ffffffffc0205f46:	64e50513          	addi	a0,a0,1614 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc0205f4a:	d54fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f4e:	b2fff0ef          	jal	ra,ffffffffc0205a7c <pa2page.part.0>
ffffffffc0205f52:	00007697          	auipc	a3,0x7
ffffffffc0205f56:	5f668693          	addi	a3,a3,1526 # ffffffffc020d548 <CSWTCH.79+0xf0>
ffffffffc0205f5a:	00006617          	auipc	a2,0x6
ffffffffc0205f5e:	aee60613          	addi	a2,a2,-1298 # ffffffffc020ba48 <commands+0x210>
ffffffffc0205f62:	23600593          	li	a1,566
ffffffffc0205f66:	00007517          	auipc	a0,0x7
ffffffffc0205f6a:	60250513          	addi	a0,a0,1538 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0205f6e:	d30fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f72:	00007697          	auipc	a3,0x7
ffffffffc0205f76:	60e68693          	addi	a3,a3,1550 # ffffffffc020d580 <CSWTCH.79+0x128>
ffffffffc0205f7a:	00006617          	auipc	a2,0x6
ffffffffc0205f7e:	ace60613          	addi	a2,a2,-1330 # ffffffffc020ba48 <commands+0x210>
ffffffffc0205f82:	1d300593          	li	a1,467
ffffffffc0205f86:	00007517          	auipc	a0,0x7
ffffffffc0205f8a:	5e250513          	addi	a0,a0,1506 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0205f8e:	d10fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0205f92:	86be                	mv	a3,a5
ffffffffc0205f94:	00006617          	auipc	a2,0x6
ffffffffc0205f98:	67c60613          	addi	a2,a2,1660 # ffffffffc020c610 <default_pmm_manager+0xe0>
ffffffffc0205f9c:	1b300593          	li	a1,435
ffffffffc0205fa0:	00007517          	auipc	a0,0x7
ffffffffc0205fa4:	5c850513          	addi	a0,a0,1480 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0205fa8:	cf6fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0205fac <kernel_thread>:
ffffffffc0205fac:	7129                	addi	sp,sp,-320
ffffffffc0205fae:	fa22                	sd	s0,304(sp)
ffffffffc0205fb0:	f626                	sd	s1,296(sp)
ffffffffc0205fb2:	f24a                	sd	s2,288(sp)
ffffffffc0205fb4:	84ae                	mv	s1,a1
ffffffffc0205fb6:	892a                	mv	s2,a0
ffffffffc0205fb8:	8432                	mv	s0,a2
ffffffffc0205fba:	4581                	li	a1,0
ffffffffc0205fbc:	12000613          	li	a2,288
ffffffffc0205fc0:	850a                	mv	a0,sp
ffffffffc0205fc2:	fe06                	sd	ra,312(sp)
ffffffffc0205fc4:	5a2050ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc0205fc8:	e0ca                	sd	s2,64(sp)
ffffffffc0205fca:	e4a6                	sd	s1,72(sp)
ffffffffc0205fcc:	100027f3          	csrr	a5,sstatus
ffffffffc0205fd0:	edd7f793          	andi	a5,a5,-291
ffffffffc0205fd4:	1207e793          	ori	a5,a5,288
ffffffffc0205fd8:	e23e                	sd	a5,256(sp)
ffffffffc0205fda:	860a                	mv	a2,sp
ffffffffc0205fdc:	10046513          	ori	a0,s0,256
ffffffffc0205fe0:	00000797          	auipc	a5,0x0
ffffffffc0205fe4:	9ec78793          	addi	a5,a5,-1556 # ffffffffc02059cc <kernel_thread_entry>
ffffffffc0205fe8:	4581                	li	a1,0
ffffffffc0205fea:	e63e                	sd	a5,264(sp)
ffffffffc0205fec:	b91ff0ef          	jal	ra,ffffffffc0205b7c <do_fork>
ffffffffc0205ff0:	70f2                	ld	ra,312(sp)
ffffffffc0205ff2:	7452                	ld	s0,304(sp)
ffffffffc0205ff4:	74b2                	ld	s1,296(sp)
ffffffffc0205ff6:	7912                	ld	s2,288(sp)
ffffffffc0205ff8:	6131                	addi	sp,sp,320
ffffffffc0205ffa:	8082                	ret

ffffffffc0205ffc <do_exit>:
ffffffffc0205ffc:	7179                	addi	sp,sp,-48
ffffffffc0205ffe:	f022                	sd	s0,32(sp)
ffffffffc0206000:	00091417          	auipc	s0,0x91
ffffffffc0206004:	8c040413          	addi	s0,s0,-1856 # ffffffffc02968c0 <current>
ffffffffc0206008:	601c                	ld	a5,0(s0)
ffffffffc020600a:	f406                	sd	ra,40(sp)
ffffffffc020600c:	ec26                	sd	s1,24(sp)
ffffffffc020600e:	e84a                	sd	s2,16(sp)
ffffffffc0206010:	e44e                	sd	s3,8(sp)
ffffffffc0206012:	e052                	sd	s4,0(sp)
ffffffffc0206014:	00091717          	auipc	a4,0x91
ffffffffc0206018:	8b473703          	ld	a4,-1868(a4) # ffffffffc02968c8 <idleproc>
ffffffffc020601c:	0ee78763          	beq	a5,a4,ffffffffc020610a <do_exit+0x10e>
ffffffffc0206020:	00091497          	auipc	s1,0x91
ffffffffc0206024:	8b048493          	addi	s1,s1,-1872 # ffffffffc02968d0 <initproc>
ffffffffc0206028:	6098                	ld	a4,0(s1)
ffffffffc020602a:	10e78763          	beq	a5,a4,ffffffffc0206138 <do_exit+0x13c>
ffffffffc020602e:	0287b983          	ld	s3,40(a5)
ffffffffc0206032:	892a                	mv	s2,a0
ffffffffc0206034:	02098e63          	beqz	s3,ffffffffc0206070 <do_exit+0x74>
ffffffffc0206038:	00091797          	auipc	a5,0x91
ffffffffc020603c:	8587b783          	ld	a5,-1960(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0206040:	577d                	li	a4,-1
ffffffffc0206042:	177e                	slli	a4,a4,0x3f
ffffffffc0206044:	83b1                	srli	a5,a5,0xc
ffffffffc0206046:	8fd9                	or	a5,a5,a4
ffffffffc0206048:	18079073          	csrw	satp,a5
ffffffffc020604c:	0309a783          	lw	a5,48(s3)
ffffffffc0206050:	fff7871b          	addiw	a4,a5,-1
ffffffffc0206054:	02e9a823          	sw	a4,48(s3)
ffffffffc0206058:	c769                	beqz	a4,ffffffffc0206122 <do_exit+0x126>
ffffffffc020605a:	601c                	ld	a5,0(s0)
ffffffffc020605c:	1487b503          	ld	a0,328(a5)
ffffffffc0206060:	0207b423          	sd	zero,40(a5)
ffffffffc0206064:	c511                	beqz	a0,ffffffffc0206070 <do_exit+0x74>
ffffffffc0206066:	491c                	lw	a5,16(a0)
ffffffffc0206068:	fff7871b          	addiw	a4,a5,-1
ffffffffc020606c:	c918                	sw	a4,16(a0)
ffffffffc020606e:	cb59                	beqz	a4,ffffffffc0206104 <do_exit+0x108>
ffffffffc0206070:	601c                	ld	a5,0(s0)
ffffffffc0206072:	470d                	li	a4,3
ffffffffc0206074:	c398                	sw	a4,0(a5)
ffffffffc0206076:	0f27a423          	sw	s2,232(a5)
ffffffffc020607a:	100027f3          	csrr	a5,sstatus
ffffffffc020607e:	8b89                	andi	a5,a5,2
ffffffffc0206080:	4a01                	li	s4,0
ffffffffc0206082:	e7f9                	bnez	a5,ffffffffc0206150 <do_exit+0x154>
ffffffffc0206084:	6018                	ld	a4,0(s0)
ffffffffc0206086:	800007b7          	lui	a5,0x80000
ffffffffc020608a:	0785                	addi	a5,a5,1
ffffffffc020608c:	7308                	ld	a0,32(a4)
ffffffffc020608e:	0ec52703          	lw	a4,236(a0)
ffffffffc0206092:	0cf70363          	beq	a4,a5,ffffffffc0206158 <do_exit+0x15c>
ffffffffc0206096:	6018                	ld	a4,0(s0)
ffffffffc0206098:	7b7c                	ld	a5,240(a4)
ffffffffc020609a:	c3a1                	beqz	a5,ffffffffc02060da <do_exit+0xde>
ffffffffc020609c:	800009b7          	lui	s3,0x80000
ffffffffc02060a0:	490d                	li	s2,3
ffffffffc02060a2:	0985                	addi	s3,s3,1
ffffffffc02060a4:	a021                	j	ffffffffc02060ac <do_exit+0xb0>
ffffffffc02060a6:	6018                	ld	a4,0(s0)
ffffffffc02060a8:	7b7c                	ld	a5,240(a4)
ffffffffc02060aa:	cb85                	beqz	a5,ffffffffc02060da <do_exit+0xde>
ffffffffc02060ac:	1007b683          	ld	a3,256(a5) # ffffffff80000100 <_binary_bin_sfs_img_size+0xffffffff7ff8ae00>
ffffffffc02060b0:	6088                	ld	a0,0(s1)
ffffffffc02060b2:	fb74                	sd	a3,240(a4)
ffffffffc02060b4:	7978                	ld	a4,240(a0)
ffffffffc02060b6:	0e07bc23          	sd	zero,248(a5)
ffffffffc02060ba:	10e7b023          	sd	a4,256(a5)
ffffffffc02060be:	c311                	beqz	a4,ffffffffc02060c2 <do_exit+0xc6>
ffffffffc02060c0:	ff7c                	sd	a5,248(a4)
ffffffffc02060c2:	4398                	lw	a4,0(a5)
ffffffffc02060c4:	f388                	sd	a0,32(a5)
ffffffffc02060c6:	f97c                	sd	a5,240(a0)
ffffffffc02060c8:	fd271fe3          	bne	a4,s2,ffffffffc02060a6 <do_exit+0xaa>
ffffffffc02060cc:	0ec52783          	lw	a5,236(a0)
ffffffffc02060d0:	fd379be3          	bne	a5,s3,ffffffffc02060a6 <do_exit+0xaa>
ffffffffc02060d4:	25c010ef          	jal	ra,ffffffffc0207330 <wakeup_proc>
ffffffffc02060d8:	b7f9                	j	ffffffffc02060a6 <do_exit+0xaa>
ffffffffc02060da:	020a1263          	bnez	s4,ffffffffc02060fe <do_exit+0x102>
ffffffffc02060de:	304010ef          	jal	ra,ffffffffc02073e2 <schedule>
ffffffffc02060e2:	601c                	ld	a5,0(s0)
ffffffffc02060e4:	00007617          	auipc	a2,0x7
ffffffffc02060e8:	4d460613          	addi	a2,a2,1236 # ffffffffc020d5b8 <CSWTCH.79+0x160>
ffffffffc02060ec:	29f00593          	li	a1,671
ffffffffc02060f0:	43d4                	lw	a3,4(a5)
ffffffffc02060f2:	00007517          	auipc	a0,0x7
ffffffffc02060f6:	47650513          	addi	a0,a0,1142 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc02060fa:	ba4fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02060fe:	b6ffa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0206102:	bff1                	j	ffffffffc02060de <do_exit+0xe2>
ffffffffc0206104:	900ff0ef          	jal	ra,ffffffffc0205204 <files_destroy>
ffffffffc0206108:	b7a5                	j	ffffffffc0206070 <do_exit+0x74>
ffffffffc020610a:	00007617          	auipc	a2,0x7
ffffffffc020610e:	48e60613          	addi	a2,a2,1166 # ffffffffc020d598 <CSWTCH.79+0x140>
ffffffffc0206112:	26a00593          	li	a1,618
ffffffffc0206116:	00007517          	auipc	a0,0x7
ffffffffc020611a:	45250513          	addi	a0,a0,1106 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc020611e:	b80fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206122:	854e                	mv	a0,s3
ffffffffc0206124:	dcffd0ef          	jal	ra,ffffffffc0203ef2 <exit_mmap>
ffffffffc0206128:	0189b503          	ld	a0,24(s3) # ffffffff80000018 <_binary_bin_sfs_img_size+0xffffffff7ff8ad18>
ffffffffc020612c:	989ff0ef          	jal	ra,ffffffffc0205ab4 <put_pgdir.isra.0>
ffffffffc0206130:	854e                	mv	a0,s3
ffffffffc0206132:	c25fd0ef          	jal	ra,ffffffffc0203d56 <mm_destroy>
ffffffffc0206136:	b715                	j	ffffffffc020605a <do_exit+0x5e>
ffffffffc0206138:	00007617          	auipc	a2,0x7
ffffffffc020613c:	47060613          	addi	a2,a2,1136 # ffffffffc020d5a8 <CSWTCH.79+0x150>
ffffffffc0206140:	26e00593          	li	a1,622
ffffffffc0206144:	00007517          	auipc	a0,0x7
ffffffffc0206148:	42450513          	addi	a0,a0,1060 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc020614c:	b52fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206150:	b23fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0206154:	4a05                	li	s4,1
ffffffffc0206156:	b73d                	j	ffffffffc0206084 <do_exit+0x88>
ffffffffc0206158:	1d8010ef          	jal	ra,ffffffffc0207330 <wakeup_proc>
ffffffffc020615c:	bf2d                	j	ffffffffc0206096 <do_exit+0x9a>

ffffffffc020615e <do_wait.part.0>:
ffffffffc020615e:	715d                	addi	sp,sp,-80
ffffffffc0206160:	f84a                	sd	s2,48(sp)
ffffffffc0206162:	f44e                	sd	s3,40(sp)
ffffffffc0206164:	80000937          	lui	s2,0x80000
ffffffffc0206168:	6989                	lui	s3,0x2
ffffffffc020616a:	fc26                	sd	s1,56(sp)
ffffffffc020616c:	f052                	sd	s4,32(sp)
ffffffffc020616e:	ec56                	sd	s5,24(sp)
ffffffffc0206170:	e85a                	sd	s6,16(sp)
ffffffffc0206172:	e45e                	sd	s7,8(sp)
ffffffffc0206174:	e486                	sd	ra,72(sp)
ffffffffc0206176:	e0a2                	sd	s0,64(sp)
ffffffffc0206178:	84aa                	mv	s1,a0
ffffffffc020617a:	8a2e                	mv	s4,a1
ffffffffc020617c:	00090b97          	auipc	s7,0x90
ffffffffc0206180:	744b8b93          	addi	s7,s7,1860 # ffffffffc02968c0 <current>
ffffffffc0206184:	00050b1b          	sext.w	s6,a0
ffffffffc0206188:	fff50a9b          	addiw	s5,a0,-1
ffffffffc020618c:	19f9                	addi	s3,s3,-2
ffffffffc020618e:	0905                	addi	s2,s2,1
ffffffffc0206190:	ccbd                	beqz	s1,ffffffffc020620e <do_wait.part.0+0xb0>
ffffffffc0206192:	0359e863          	bltu	s3,s5,ffffffffc02061c2 <do_wait.part.0+0x64>
ffffffffc0206196:	45a9                	li	a1,10
ffffffffc0206198:	855a                	mv	a0,s6
ffffffffc020619a:	699040ef          	jal	ra,ffffffffc020b032 <hash32>
ffffffffc020619e:	02051793          	slli	a5,a0,0x20
ffffffffc02061a2:	01c7d513          	srli	a0,a5,0x1c
ffffffffc02061a6:	0008b797          	auipc	a5,0x8b
ffffffffc02061aa:	61a78793          	addi	a5,a5,1562 # ffffffffc02917c0 <hash_list>
ffffffffc02061ae:	953e                	add	a0,a0,a5
ffffffffc02061b0:	842a                	mv	s0,a0
ffffffffc02061b2:	a029                	j	ffffffffc02061bc <do_wait.part.0+0x5e>
ffffffffc02061b4:	f2c42783          	lw	a5,-212(s0)
ffffffffc02061b8:	02978163          	beq	a5,s1,ffffffffc02061da <do_wait.part.0+0x7c>
ffffffffc02061bc:	6400                	ld	s0,8(s0)
ffffffffc02061be:	fe851be3          	bne	a0,s0,ffffffffc02061b4 <do_wait.part.0+0x56>
ffffffffc02061c2:	5579                	li	a0,-2
ffffffffc02061c4:	60a6                	ld	ra,72(sp)
ffffffffc02061c6:	6406                	ld	s0,64(sp)
ffffffffc02061c8:	74e2                	ld	s1,56(sp)
ffffffffc02061ca:	7942                	ld	s2,48(sp)
ffffffffc02061cc:	79a2                	ld	s3,40(sp)
ffffffffc02061ce:	7a02                	ld	s4,32(sp)
ffffffffc02061d0:	6ae2                	ld	s5,24(sp)
ffffffffc02061d2:	6b42                	ld	s6,16(sp)
ffffffffc02061d4:	6ba2                	ld	s7,8(sp)
ffffffffc02061d6:	6161                	addi	sp,sp,80
ffffffffc02061d8:	8082                	ret
ffffffffc02061da:	000bb683          	ld	a3,0(s7)
ffffffffc02061de:	f4843783          	ld	a5,-184(s0)
ffffffffc02061e2:	fed790e3          	bne	a5,a3,ffffffffc02061c2 <do_wait.part.0+0x64>
ffffffffc02061e6:	f2842703          	lw	a4,-216(s0)
ffffffffc02061ea:	478d                	li	a5,3
ffffffffc02061ec:	0ef70b63          	beq	a4,a5,ffffffffc02062e2 <do_wait.part.0+0x184>
ffffffffc02061f0:	4785                	li	a5,1
ffffffffc02061f2:	c29c                	sw	a5,0(a3)
ffffffffc02061f4:	0f26a623          	sw	s2,236(a3)
ffffffffc02061f8:	1ea010ef          	jal	ra,ffffffffc02073e2 <schedule>
ffffffffc02061fc:	000bb783          	ld	a5,0(s7)
ffffffffc0206200:	0b07a783          	lw	a5,176(a5)
ffffffffc0206204:	8b85                	andi	a5,a5,1
ffffffffc0206206:	d7c9                	beqz	a5,ffffffffc0206190 <do_wait.part.0+0x32>
ffffffffc0206208:	555d                	li	a0,-9
ffffffffc020620a:	df3ff0ef          	jal	ra,ffffffffc0205ffc <do_exit>
ffffffffc020620e:	000bb683          	ld	a3,0(s7)
ffffffffc0206212:	7ae0                	ld	s0,240(a3)
ffffffffc0206214:	d45d                	beqz	s0,ffffffffc02061c2 <do_wait.part.0+0x64>
ffffffffc0206216:	470d                	li	a4,3
ffffffffc0206218:	a021                	j	ffffffffc0206220 <do_wait.part.0+0xc2>
ffffffffc020621a:	10043403          	ld	s0,256(s0)
ffffffffc020621e:	d869                	beqz	s0,ffffffffc02061f0 <do_wait.part.0+0x92>
ffffffffc0206220:	401c                	lw	a5,0(s0)
ffffffffc0206222:	fee79ce3          	bne	a5,a4,ffffffffc020621a <do_wait.part.0+0xbc>
ffffffffc0206226:	00090797          	auipc	a5,0x90
ffffffffc020622a:	6a27b783          	ld	a5,1698(a5) # ffffffffc02968c8 <idleproc>
ffffffffc020622e:	0c878963          	beq	a5,s0,ffffffffc0206300 <do_wait.part.0+0x1a2>
ffffffffc0206232:	00090797          	auipc	a5,0x90
ffffffffc0206236:	69e7b783          	ld	a5,1694(a5) # ffffffffc02968d0 <initproc>
ffffffffc020623a:	0cf40363          	beq	s0,a5,ffffffffc0206300 <do_wait.part.0+0x1a2>
ffffffffc020623e:	000a0663          	beqz	s4,ffffffffc020624a <do_wait.part.0+0xec>
ffffffffc0206242:	0e842783          	lw	a5,232(s0)
ffffffffc0206246:	00fa2023          	sw	a5,0(s4)
ffffffffc020624a:	100027f3          	csrr	a5,sstatus
ffffffffc020624e:	8b89                	andi	a5,a5,2
ffffffffc0206250:	4581                	li	a1,0
ffffffffc0206252:	e7c1                	bnez	a5,ffffffffc02062da <do_wait.part.0+0x17c>
ffffffffc0206254:	6c70                	ld	a2,216(s0)
ffffffffc0206256:	7074                	ld	a3,224(s0)
ffffffffc0206258:	10043703          	ld	a4,256(s0)
ffffffffc020625c:	7c7c                	ld	a5,248(s0)
ffffffffc020625e:	e614                	sd	a3,8(a2)
ffffffffc0206260:	e290                	sd	a2,0(a3)
ffffffffc0206262:	6470                	ld	a2,200(s0)
ffffffffc0206264:	6874                	ld	a3,208(s0)
ffffffffc0206266:	e614                	sd	a3,8(a2)
ffffffffc0206268:	e290                	sd	a2,0(a3)
ffffffffc020626a:	c319                	beqz	a4,ffffffffc0206270 <do_wait.part.0+0x112>
ffffffffc020626c:	ff7c                	sd	a5,248(a4)
ffffffffc020626e:	7c7c                	ld	a5,248(s0)
ffffffffc0206270:	c3b5                	beqz	a5,ffffffffc02062d4 <do_wait.part.0+0x176>
ffffffffc0206272:	10e7b023          	sd	a4,256(a5)
ffffffffc0206276:	00090717          	auipc	a4,0x90
ffffffffc020627a:	66270713          	addi	a4,a4,1634 # ffffffffc02968d8 <nr_process>
ffffffffc020627e:	431c                	lw	a5,0(a4)
ffffffffc0206280:	37fd                	addiw	a5,a5,-1
ffffffffc0206282:	c31c                	sw	a5,0(a4)
ffffffffc0206284:	e5a9                	bnez	a1,ffffffffc02062ce <do_wait.part.0+0x170>
ffffffffc0206286:	6814                	ld	a3,16(s0)
ffffffffc0206288:	c02007b7          	lui	a5,0xc0200
ffffffffc020628c:	04f6ee63          	bltu	a3,a5,ffffffffc02062e8 <do_wait.part.0+0x18a>
ffffffffc0206290:	00090797          	auipc	a5,0x90
ffffffffc0206294:	6287b783          	ld	a5,1576(a5) # ffffffffc02968b8 <va_pa_offset>
ffffffffc0206298:	8e9d                	sub	a3,a3,a5
ffffffffc020629a:	82b1                	srli	a3,a3,0xc
ffffffffc020629c:	00090797          	auipc	a5,0x90
ffffffffc02062a0:	6047b783          	ld	a5,1540(a5) # ffffffffc02968a0 <npage>
ffffffffc02062a4:	06f6fa63          	bgeu	a3,a5,ffffffffc0206318 <do_wait.part.0+0x1ba>
ffffffffc02062a8:	00009517          	auipc	a0,0x9
ffffffffc02062ac:	5a853503          	ld	a0,1448(a0) # ffffffffc020f850 <nbase>
ffffffffc02062b0:	8e89                	sub	a3,a3,a0
ffffffffc02062b2:	069a                	slli	a3,a3,0x6
ffffffffc02062b4:	00090517          	auipc	a0,0x90
ffffffffc02062b8:	5f453503          	ld	a0,1524(a0) # ffffffffc02968a8 <pages>
ffffffffc02062bc:	9536                	add	a0,a0,a3
ffffffffc02062be:	4589                	li	a1,2
ffffffffc02062c0:	eebfb0ef          	jal	ra,ffffffffc02021aa <free_pages>
ffffffffc02062c4:	8522                	mv	a0,s0
ffffffffc02062c6:	d79fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02062ca:	4501                	li	a0,0
ffffffffc02062cc:	bde5                	j	ffffffffc02061c4 <do_wait.part.0+0x66>
ffffffffc02062ce:	99ffa0ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc02062d2:	bf55                	j	ffffffffc0206286 <do_wait.part.0+0x128>
ffffffffc02062d4:	701c                	ld	a5,32(s0)
ffffffffc02062d6:	fbf8                	sd	a4,240(a5)
ffffffffc02062d8:	bf79                	j	ffffffffc0206276 <do_wait.part.0+0x118>
ffffffffc02062da:	999fa0ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02062de:	4585                	li	a1,1
ffffffffc02062e0:	bf95                	j	ffffffffc0206254 <do_wait.part.0+0xf6>
ffffffffc02062e2:	f2840413          	addi	s0,s0,-216
ffffffffc02062e6:	b781                	j	ffffffffc0206226 <do_wait.part.0+0xc8>
ffffffffc02062e8:	00006617          	auipc	a2,0x6
ffffffffc02062ec:	32860613          	addi	a2,a2,808 # ffffffffc020c610 <default_pmm_manager+0xe0>
ffffffffc02062f0:	07700593          	li	a1,119
ffffffffc02062f4:	00006517          	auipc	a0,0x6
ffffffffc02062f8:	29c50513          	addi	a0,a0,668 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc02062fc:	9a2fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206300:	00007617          	auipc	a2,0x7
ffffffffc0206304:	2d860613          	addi	a2,a2,728 # ffffffffc020d5d8 <CSWTCH.79+0x180>
ffffffffc0206308:	45400593          	li	a1,1108
ffffffffc020630c:	00007517          	auipc	a0,0x7
ffffffffc0206310:	25c50513          	addi	a0,a0,604 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0206314:	98afa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206318:	f64ff0ef          	jal	ra,ffffffffc0205a7c <pa2page.part.0>

ffffffffc020631c <init_main>:
ffffffffc020631c:	1141                	addi	sp,sp,-16
ffffffffc020631e:	00007517          	auipc	a0,0x7
ffffffffc0206322:	2da50513          	addi	a0,a0,730 # ffffffffc020d5f8 <CSWTCH.79+0x1a0>
ffffffffc0206326:	e406                	sd	ra,8(sp)
ffffffffc0206328:	02b010ef          	jal	ra,ffffffffc0207b52 <vfs_set_bootfs>
ffffffffc020632c:	e179                	bnez	a0,ffffffffc02063f2 <init_main+0xd6>
ffffffffc020632e:	ebdfb0ef          	jal	ra,ffffffffc02021ea <nr_free_pages>
ffffffffc0206332:	c59fb0ef          	jal	ra,ffffffffc0201f8a <kallocated>
ffffffffc0206336:	4601                	li	a2,0
ffffffffc0206338:	4581                	li	a1,0
ffffffffc020633a:	00001517          	auipc	a0,0x1
ffffffffc020633e:	a5050513          	addi	a0,a0,-1456 # ffffffffc0206d8a <user_main>
ffffffffc0206342:	c6bff0ef          	jal	ra,ffffffffc0205fac <kernel_thread>
ffffffffc0206346:	00a04563          	bgtz	a0,ffffffffc0206350 <init_main+0x34>
ffffffffc020634a:	a841                	j	ffffffffc02063da <init_main+0xbe>
ffffffffc020634c:	096010ef          	jal	ra,ffffffffc02073e2 <schedule>
ffffffffc0206350:	4581                	li	a1,0
ffffffffc0206352:	4501                	li	a0,0
ffffffffc0206354:	e0bff0ef          	jal	ra,ffffffffc020615e <do_wait.part.0>
ffffffffc0206358:	d975                	beqz	a0,ffffffffc020634c <init_main+0x30>
ffffffffc020635a:	e65fe0ef          	jal	ra,ffffffffc02051be <fs_cleanup>
ffffffffc020635e:	00007517          	auipc	a0,0x7
ffffffffc0206362:	2e250513          	addi	a0,a0,738 # ffffffffc020d640 <CSWTCH.79+0x1e8>
ffffffffc0206366:	e41f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020636a:	00090797          	auipc	a5,0x90
ffffffffc020636e:	5667b783          	ld	a5,1382(a5) # ffffffffc02968d0 <initproc>
ffffffffc0206372:	7bf8                	ld	a4,240(a5)
ffffffffc0206374:	e339                	bnez	a4,ffffffffc02063ba <init_main+0x9e>
ffffffffc0206376:	7ff8                	ld	a4,248(a5)
ffffffffc0206378:	e329                	bnez	a4,ffffffffc02063ba <init_main+0x9e>
ffffffffc020637a:	1007b703          	ld	a4,256(a5)
ffffffffc020637e:	ef15                	bnez	a4,ffffffffc02063ba <init_main+0x9e>
ffffffffc0206380:	00090697          	auipc	a3,0x90
ffffffffc0206384:	5586a683          	lw	a3,1368(a3) # ffffffffc02968d8 <nr_process>
ffffffffc0206388:	4709                	li	a4,2
ffffffffc020638a:	0ce69163          	bne	a3,a4,ffffffffc020644c <init_main+0x130>
ffffffffc020638e:	0008f717          	auipc	a4,0x8f
ffffffffc0206392:	43270713          	addi	a4,a4,1074 # ffffffffc02957c0 <proc_list>
ffffffffc0206396:	6714                	ld	a3,8(a4)
ffffffffc0206398:	0c878793          	addi	a5,a5,200
ffffffffc020639c:	08d79863          	bne	a5,a3,ffffffffc020642c <init_main+0x110>
ffffffffc02063a0:	6318                	ld	a4,0(a4)
ffffffffc02063a2:	06e79563          	bne	a5,a4,ffffffffc020640c <init_main+0xf0>
ffffffffc02063a6:	00007517          	auipc	a0,0x7
ffffffffc02063aa:	38250513          	addi	a0,a0,898 # ffffffffc020d728 <CSWTCH.79+0x2d0>
ffffffffc02063ae:	df9f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02063b2:	60a2                	ld	ra,8(sp)
ffffffffc02063b4:	4501                	li	a0,0
ffffffffc02063b6:	0141                	addi	sp,sp,16
ffffffffc02063b8:	8082                	ret
ffffffffc02063ba:	00007697          	auipc	a3,0x7
ffffffffc02063be:	2ae68693          	addi	a3,a3,686 # ffffffffc020d668 <CSWTCH.79+0x210>
ffffffffc02063c2:	00005617          	auipc	a2,0x5
ffffffffc02063c6:	68660613          	addi	a2,a2,1670 # ffffffffc020ba48 <commands+0x210>
ffffffffc02063ca:	4cb00593          	li	a1,1227
ffffffffc02063ce:	00007517          	auipc	a0,0x7
ffffffffc02063d2:	19a50513          	addi	a0,a0,410 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc02063d6:	8c8fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02063da:	00007617          	auipc	a2,0x7
ffffffffc02063de:	24660613          	addi	a2,a2,582 # ffffffffc020d620 <CSWTCH.79+0x1c8>
ffffffffc02063e2:	4be00593          	li	a1,1214
ffffffffc02063e6:	00007517          	auipc	a0,0x7
ffffffffc02063ea:	18250513          	addi	a0,a0,386 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc02063ee:	8b0fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02063f2:	86aa                	mv	a3,a0
ffffffffc02063f4:	00007617          	auipc	a2,0x7
ffffffffc02063f8:	20c60613          	addi	a2,a2,524 # ffffffffc020d600 <CSWTCH.79+0x1a8>
ffffffffc02063fc:	4b600593          	li	a1,1206
ffffffffc0206400:	00007517          	auipc	a0,0x7
ffffffffc0206404:	16850513          	addi	a0,a0,360 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0206408:	896fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020640c:	00007697          	auipc	a3,0x7
ffffffffc0206410:	2ec68693          	addi	a3,a3,748 # ffffffffc020d6f8 <CSWTCH.79+0x2a0>
ffffffffc0206414:	00005617          	auipc	a2,0x5
ffffffffc0206418:	63460613          	addi	a2,a2,1588 # ffffffffc020ba48 <commands+0x210>
ffffffffc020641c:	4ce00593          	li	a1,1230
ffffffffc0206420:	00007517          	auipc	a0,0x7
ffffffffc0206424:	14850513          	addi	a0,a0,328 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0206428:	876fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020642c:	00007697          	auipc	a3,0x7
ffffffffc0206430:	29c68693          	addi	a3,a3,668 # ffffffffc020d6c8 <CSWTCH.79+0x270>
ffffffffc0206434:	00005617          	auipc	a2,0x5
ffffffffc0206438:	61460613          	addi	a2,a2,1556 # ffffffffc020ba48 <commands+0x210>
ffffffffc020643c:	4cd00593          	li	a1,1229
ffffffffc0206440:	00007517          	auipc	a0,0x7
ffffffffc0206444:	12850513          	addi	a0,a0,296 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0206448:	856fa0ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020644c:	00007697          	auipc	a3,0x7
ffffffffc0206450:	26c68693          	addi	a3,a3,620 # ffffffffc020d6b8 <CSWTCH.79+0x260>
ffffffffc0206454:	00005617          	auipc	a2,0x5
ffffffffc0206458:	5f460613          	addi	a2,a2,1524 # ffffffffc020ba48 <commands+0x210>
ffffffffc020645c:	4cc00593          	li	a1,1228
ffffffffc0206460:	00007517          	auipc	a0,0x7
ffffffffc0206464:	10850513          	addi	a0,a0,264 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0206468:	836fa0ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020646c <do_execve>:
ffffffffc020646c:	c9010113          	addi	sp,sp,-880
ffffffffc0206470:	31913c23          	sd	s9,792(sp)
ffffffffc0206474:	00090c97          	auipc	s9,0x90
ffffffffc0206478:	44cc8c93          	addi	s9,s9,1100 # ffffffffc02968c0 <current>
ffffffffc020647c:	000cb683          	ld	a3,0(s9)
ffffffffc0206480:	fff5871b          	addiw	a4,a1,-1
ffffffffc0206484:	33613823          	sd	s6,816(sp)
ffffffffc0206488:	36113423          	sd	ra,872(sp)
ffffffffc020648c:	36813023          	sd	s0,864(sp)
ffffffffc0206490:	34913c23          	sd	s1,856(sp)
ffffffffc0206494:	35213823          	sd	s2,848(sp)
ffffffffc0206498:	35313423          	sd	s3,840(sp)
ffffffffc020649c:	35413023          	sd	s4,832(sp)
ffffffffc02064a0:	33513c23          	sd	s5,824(sp)
ffffffffc02064a4:	33713423          	sd	s7,808(sp)
ffffffffc02064a8:	33813023          	sd	s8,800(sp)
ffffffffc02064ac:	31a13823          	sd	s10,784(sp)
ffffffffc02064b0:	31b13423          	sd	s11,776(sp)
ffffffffc02064b4:	c4ba                	sw	a4,72(sp)
ffffffffc02064b6:	47fd                	li	a5,31
ffffffffc02064b8:	0286bb03          	ld	s6,40(a3)
ffffffffc02064bc:	60e7ed63          	bltu	a5,a4,ffffffffc0206ad6 <do_execve+0x66a>
ffffffffc02064c0:	842e                	mv	s0,a1
ffffffffc02064c2:	84aa                	mv	s1,a0
ffffffffc02064c4:	8ab2                	mv	s5,a2
ffffffffc02064c6:	4581                	li	a1,0
ffffffffc02064c8:	4641                	li	a2,16
ffffffffc02064ca:	18a8                	addi	a0,sp,120
ffffffffc02064cc:	09a050ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc02064d0:	000b0c63          	beqz	s6,ffffffffc02064e8 <do_execve+0x7c>
ffffffffc02064d4:	038b0513          	addi	a0,s6,56
ffffffffc02064d8:	88cfe0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc02064dc:	000cb783          	ld	a5,0(s9)
ffffffffc02064e0:	c781                	beqz	a5,ffffffffc02064e8 <do_execve+0x7c>
ffffffffc02064e2:	43dc                	lw	a5,4(a5)
ffffffffc02064e4:	04fb2823          	sw	a5,80(s6)
ffffffffc02064e8:	3c048c63          	beqz	s1,ffffffffc02068c0 <do_execve+0x454>
ffffffffc02064ec:	46c1                	li	a3,16
ffffffffc02064ee:	8626                	mv	a2,s1
ffffffffc02064f0:	18ac                	addi	a1,sp,120
ffffffffc02064f2:	855a                	mv	a0,s6
ffffffffc02064f4:	e99fd0ef          	jal	ra,ffffffffc020438c <copy_string>
ffffffffc02064f8:	74050363          	beqz	a0,ffffffffc0206c3e <do_execve+0x7d2>
ffffffffc02064fc:	00341793          	slli	a5,s0,0x3
ffffffffc0206500:	4681                	li	a3,0
ffffffffc0206502:	863e                	mv	a2,a5
ffffffffc0206504:	85d6                	mv	a1,s5
ffffffffc0206506:	855a                	mv	a0,s6
ffffffffc0206508:	e8be                	sd	a5,80(sp)
ffffffffc020650a:	d89fd0ef          	jal	ra,ffffffffc0204292 <user_mem_check>
ffffffffc020650e:	89d6                	mv	s3,s5
ffffffffc0206510:	5c050b63          	beqz	a0,ffffffffc0206ae6 <do_execve+0x67a>
ffffffffc0206514:	10010a13          	addi	s4,sp,256
ffffffffc0206518:	4481                	li	s1,0
ffffffffc020651a:	a011                	j	ffffffffc020651e <do_execve+0xb2>
ffffffffc020651c:	84be                	mv	s1,a5
ffffffffc020651e:	6505                	lui	a0,0x1
ffffffffc0206520:	a6ffb0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0206524:	892a                	mv	s2,a0
ffffffffc0206526:	14050c63          	beqz	a0,ffffffffc020667e <do_execve+0x212>
ffffffffc020652a:	0009b603          	ld	a2,0(s3) # 2000 <_binary_bin_swap_img_size-0x5d00>
ffffffffc020652e:	85aa                	mv	a1,a0
ffffffffc0206530:	6685                	lui	a3,0x1
ffffffffc0206532:	855a                	mv	a0,s6
ffffffffc0206534:	e59fd0ef          	jal	ra,ffffffffc020438c <copy_string>
ffffffffc0206538:	1c050263          	beqz	a0,ffffffffc02066fc <do_execve+0x290>
ffffffffc020653c:	012a3023          	sd	s2,0(s4)
ffffffffc0206540:	0014879b          	addiw	a5,s1,1
ffffffffc0206544:	0a21                	addi	s4,s4,8
ffffffffc0206546:	09a1                	addi	s3,s3,8
ffffffffc0206548:	fcf41ae3          	bne	s0,a5,ffffffffc020651c <do_execve+0xb0>
ffffffffc020654c:	000ab903          	ld	s2,0(s5)
ffffffffc0206550:	100b0863          	beqz	s6,ffffffffc0206660 <do_execve+0x1f4>
ffffffffc0206554:	038b0513          	addi	a0,s6,56
ffffffffc0206558:	808fe0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020655c:	000cb783          	ld	a5,0(s9)
ffffffffc0206560:	040b2823          	sw	zero,80(s6)
ffffffffc0206564:	1487b503          	ld	a0,328(a5)
ffffffffc0206568:	d33fe0ef          	jal	ra,ffffffffc020529a <files_closeall>
ffffffffc020656c:	4581                	li	a1,0
ffffffffc020656e:	854a                	mv	a0,s2
ffffffffc0206570:	fb7fe0ef          	jal	ra,ffffffffc0205526 <sysfile_open>
ffffffffc0206574:	8aaa                	mv	s5,a0
ffffffffc0206576:	000547e3          	bltz	a0,ffffffffc0206d84 <do_execve+0x918>
ffffffffc020657a:	00090797          	auipc	a5,0x90
ffffffffc020657e:	3167b783          	ld	a5,790(a5) # ffffffffc0296890 <boot_pgdir_pa>
ffffffffc0206582:	577d                	li	a4,-1
ffffffffc0206584:	177e                	slli	a4,a4,0x3f
ffffffffc0206586:	83b1                	srli	a5,a5,0xc
ffffffffc0206588:	8fd9                	or	a5,a5,a4
ffffffffc020658a:	18079073          	csrw	satp,a5
ffffffffc020658e:	030b2783          	lw	a5,48(s6)
ffffffffc0206592:	fff7871b          	addiw	a4,a5,-1
ffffffffc0206596:	02eb2823          	sw	a4,48(s6)
ffffffffc020659a:	50070063          	beqz	a4,ffffffffc0206a9a <do_execve+0x62e>
ffffffffc020659e:	000cb783          	ld	a5,0(s9)
ffffffffc02065a2:	0207b423          	sd	zero,40(a5)
ffffffffc02065a6:	e62fd0ef          	jal	ra,ffffffffc0203c08 <mm_create>
ffffffffc02065aa:	8a2a                	mv	s4,a0
ffffffffc02065ac:	52050b63          	beqz	a0,ffffffffc0206ae2 <do_execve+0x676>
ffffffffc02065b0:	4505                	li	a0,1
ffffffffc02065b2:	bbbfb0ef          	jal	ra,ffffffffc020216c <alloc_pages>
ffffffffc02065b6:	52050363          	beqz	a0,ffffffffc0206adc <do_execve+0x670>
ffffffffc02065ba:	00090d97          	auipc	s11,0x90
ffffffffc02065be:	2eed8d93          	addi	s11,s11,750 # ffffffffc02968a8 <pages>
ffffffffc02065c2:	000db683          	ld	a3,0(s11)
ffffffffc02065c6:	00009717          	auipc	a4,0x9
ffffffffc02065ca:	28a73703          	ld	a4,650(a4) # ffffffffc020f850 <nbase>
ffffffffc02065ce:	00090d17          	auipc	s10,0x90
ffffffffc02065d2:	2d2d0d13          	addi	s10,s10,722 # ffffffffc02968a0 <npage>
ffffffffc02065d6:	40d506b3          	sub	a3,a0,a3
ffffffffc02065da:	8699                	srai	a3,a3,0x6
ffffffffc02065dc:	96ba                	add	a3,a3,a4
ffffffffc02065de:	ec3a                	sd	a4,24(sp)
ffffffffc02065e0:	000d3783          	ld	a5,0(s10)
ffffffffc02065e4:	577d                	li	a4,-1
ffffffffc02065e6:	8331                	srli	a4,a4,0xc
ffffffffc02065e8:	e83a                	sd	a4,16(sp)
ffffffffc02065ea:	8f75                	and	a4,a4,a3
ffffffffc02065ec:	06b2                	slli	a3,a3,0xc
ffffffffc02065ee:	6af77563          	bgeu	a4,a5,ffffffffc0206c98 <do_execve+0x82c>
ffffffffc02065f2:	00090b97          	auipc	s7,0x90
ffffffffc02065f6:	2c6b8b93          	addi	s7,s7,710 # ffffffffc02968b8 <va_pa_offset>
ffffffffc02065fa:	000bb903          	ld	s2,0(s7)
ffffffffc02065fe:	6605                	lui	a2,0x1
ffffffffc0206600:	00090597          	auipc	a1,0x90
ffffffffc0206604:	2985b583          	ld	a1,664(a1) # ffffffffc0296898 <boot_pgdir_va>
ffffffffc0206608:	9936                	add	s2,s2,a3
ffffffffc020660a:	854a                	mv	a0,s2
ffffffffc020660c:	7ad040ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc0206610:	4601                	li	a2,0
ffffffffc0206612:	012a3c23          	sd	s2,24(s4)
ffffffffc0206616:	4581                	li	a1,0
ffffffffc0206618:	8556                	mv	a0,s5
ffffffffc020661a:	972ff0ef          	jal	ra,ffffffffc020578c <sysfile_seek>
ffffffffc020661e:	f82a                	sd	a0,48(sp)
ffffffffc0206620:	892a                	mv	s2,a0
ffffffffc0206622:	0e050363          	beqz	a0,ffffffffc0206708 <do_execve+0x29c>
ffffffffc0206626:	8552                	mv	a0,s4
ffffffffc0206628:	f2efd0ef          	jal	ra,ffffffffc0203d56 <mm_destroy>
ffffffffc020662c:	000cb783          	ld	a5,0(s9)
ffffffffc0206630:	0207b423          	sd	zero,40(a5)
ffffffffc0206634:	67c6                	ld	a5,80(sp)
ffffffffc0206636:	1984                	addi	s1,sp,240
ffffffffc0206638:	147d                	addi	s0,s0,-1
ffffffffc020663a:	94be                	add	s1,s1,a5
ffffffffc020663c:	67a6                	ld	a5,72(sp)
ffffffffc020663e:	040e                	slli	s0,s0,0x3
ffffffffc0206640:	02079713          	slli	a4,a5,0x20
ffffffffc0206644:	01d75793          	srli	a5,a4,0x1d
ffffffffc0206648:	0218                	addi	a4,sp,256
ffffffffc020664a:	943a                	add	s0,s0,a4
ffffffffc020664c:	8c9d                	sub	s1,s1,a5
ffffffffc020664e:	6008                	ld	a0,0(s0)
ffffffffc0206650:	1461                	addi	s0,s0,-8
ffffffffc0206652:	9edfb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0206656:	fe941ce3          	bne	s0,s1,ffffffffc020664e <do_execve+0x1e2>
ffffffffc020665a:	854a                	mv	a0,s2
ffffffffc020665c:	9a1ff0ef          	jal	ra,ffffffffc0205ffc <do_exit>
ffffffffc0206660:	000cb783          	ld	a5,0(s9)
ffffffffc0206664:	1487b503          	ld	a0,328(a5)
ffffffffc0206668:	c33fe0ef          	jal	ra,ffffffffc020529a <files_closeall>
ffffffffc020666c:	4581                	li	a1,0
ffffffffc020666e:	854a                	mv	a0,s2
ffffffffc0206670:	eb7fe0ef          	jal	ra,ffffffffc0205526 <sysfile_open>
ffffffffc0206674:	8aaa                	mv	s5,a0
ffffffffc0206676:	f20558e3          	bgez	a0,ffffffffc02065a6 <do_execve+0x13a>
ffffffffc020667a:	892a                	mv	s2,a0
ffffffffc020667c:	bf65                	j	ffffffffc0206634 <do_execve+0x1c8>
ffffffffc020667e:	57f1                	li	a5,-4
ffffffffc0206680:	f83e                	sd	a5,48(sp)
ffffffffc0206682:	c49d                	beqz	s1,ffffffffc02066b0 <do_execve+0x244>
ffffffffc0206684:	00349713          	slli	a4,s1,0x3
ffffffffc0206688:	fff48413          	addi	s0,s1,-1
ffffffffc020668c:	199c                	addi	a5,sp,240
ffffffffc020668e:	34fd                	addiw	s1,s1,-1
ffffffffc0206690:	97ba                	add	a5,a5,a4
ffffffffc0206692:	02049713          	slli	a4,s1,0x20
ffffffffc0206696:	01d75493          	srli	s1,a4,0x1d
ffffffffc020669a:	040e                	slli	s0,s0,0x3
ffffffffc020669c:	0218                	addi	a4,sp,256
ffffffffc020669e:	943a                	add	s0,s0,a4
ffffffffc02066a0:	409784b3          	sub	s1,a5,s1
ffffffffc02066a4:	6008                	ld	a0,0(s0)
ffffffffc02066a6:	1461                	addi	s0,s0,-8
ffffffffc02066a8:	997fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02066ac:	fe849ce3          	bne	s1,s0,ffffffffc02066a4 <do_execve+0x238>
ffffffffc02066b0:	000b0863          	beqz	s6,ffffffffc02066c0 <do_execve+0x254>
ffffffffc02066b4:	038b0513          	addi	a0,s6,56
ffffffffc02066b8:	ea9fd0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc02066bc:	040b2823          	sw	zero,80(s6)
ffffffffc02066c0:	36813083          	ld	ra,872(sp)
ffffffffc02066c4:	36013403          	ld	s0,864(sp)
ffffffffc02066c8:	7542                	ld	a0,48(sp)
ffffffffc02066ca:	35813483          	ld	s1,856(sp)
ffffffffc02066ce:	35013903          	ld	s2,848(sp)
ffffffffc02066d2:	34813983          	ld	s3,840(sp)
ffffffffc02066d6:	34013a03          	ld	s4,832(sp)
ffffffffc02066da:	33813a83          	ld	s5,824(sp)
ffffffffc02066de:	33013b03          	ld	s6,816(sp)
ffffffffc02066e2:	32813b83          	ld	s7,808(sp)
ffffffffc02066e6:	32013c03          	ld	s8,800(sp)
ffffffffc02066ea:	31813c83          	ld	s9,792(sp)
ffffffffc02066ee:	31013d03          	ld	s10,784(sp)
ffffffffc02066f2:	30813d83          	ld	s11,776(sp)
ffffffffc02066f6:	37010113          	addi	sp,sp,880
ffffffffc02066fa:	8082                	ret
ffffffffc02066fc:	854a                	mv	a0,s2
ffffffffc02066fe:	941fb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0206702:	57f5                	li	a5,-3
ffffffffc0206704:	f83e                	sd	a5,48(sp)
ffffffffc0206706:	bfb5                	j	ffffffffc0206682 <do_execve+0x216>
ffffffffc0206708:	04000613          	li	a2,64
ffffffffc020670c:	018c                	addi	a1,sp,192
ffffffffc020670e:	8556                	mv	a0,s5
ffffffffc0206710:	e4ffe0ef          	jal	ra,ffffffffc020555e <sysfile_read>
ffffffffc0206714:	04000793          	li	a5,64
ffffffffc0206718:	18f51b63          	bne	a0,a5,ffffffffc02068ae <do_execve+0x442>
ffffffffc020671c:	470e                	lw	a4,192(sp)
ffffffffc020671e:	464c47b7          	lui	a5,0x464c4
ffffffffc0206722:	57f78793          	addi	a5,a5,1407 # 464c457f <_binary_bin_sfs_img_size+0x4644f27f>
ffffffffc0206726:	2ef71c63          	bne	a4,a5,ffffffffc0206a1e <do_execve+0x5b2>
ffffffffc020672a:	0f815783          	lhu	a5,248(sp)
ffffffffc020672e:	e082                	sd	zero,64(sp)
ffffffffc0206730:	f402                	sd	zero,40(sp)
ffffffffc0206732:	cba1                	beqz	a5,ffffffffc0206782 <do_execve+0x316>
ffffffffc0206734:	f4a6                	sd	s1,104(sp)
ffffffffc0206736:	f022                	sd	s0,32(sp)
ffffffffc0206738:	758e                	ld	a1,224(sp)
ffffffffc020673a:	77a2                	ld	a5,40(sp)
ffffffffc020673c:	4601                	li	a2,0
ffffffffc020673e:	8556                	mv	a0,s5
ffffffffc0206740:	95be                	add	a1,a1,a5
ffffffffc0206742:	84aff0ef          	jal	ra,ffffffffc020578c <sysfile_seek>
ffffffffc0206746:	842a                	mv	s0,a0
ffffffffc0206748:	16051963          	bnez	a0,ffffffffc02068ba <do_execve+0x44e>
ffffffffc020674c:	03800613          	li	a2,56
ffffffffc0206750:	012c                	addi	a1,sp,136
ffffffffc0206752:	8556                	mv	a0,s5
ffffffffc0206754:	e0bfe0ef          	jal	ra,ffffffffc020555e <sysfile_read>
ffffffffc0206758:	03800793          	li	a5,56
ffffffffc020675c:	14f51863          	bne	a0,a5,ffffffffc02068ac <do_execve+0x440>
ffffffffc0206760:	47aa                	lw	a5,136(sp)
ffffffffc0206762:	4705                	li	a4,1
ffffffffc0206764:	16e78a63          	beq	a5,a4,ffffffffc02068d8 <do_execve+0x46c>
ffffffffc0206768:	6706                	ld	a4,64(sp)
ffffffffc020676a:	76a2                	ld	a3,40(sp)
ffffffffc020676c:	0f815783          	lhu	a5,248(sp)
ffffffffc0206770:	2705                	addiw	a4,a4,1
ffffffffc0206772:	03868693          	addi	a3,a3,56 # 1038 <_binary_bin_swap_img_size-0x6cc8>
ffffffffc0206776:	e0ba                	sd	a4,64(sp)
ffffffffc0206778:	f436                	sd	a3,40(sp)
ffffffffc020677a:	faf74fe3          	blt	a4,a5,ffffffffc0206738 <do_execve+0x2cc>
ffffffffc020677e:	74a6                	ld	s1,104(sp)
ffffffffc0206780:	7402                	ld	s0,32(sp)
ffffffffc0206782:	4701                	li	a4,0
ffffffffc0206784:	46ad                	li	a3,11
ffffffffc0206786:	00100637          	lui	a2,0x100
ffffffffc020678a:	7ff005b7          	lui	a1,0x7ff00
ffffffffc020678e:	8552                	mv	a0,s4
ffffffffc0206790:	e18fd0ef          	jal	ra,ffffffffc0203da8 <mm_map>
ffffffffc0206794:	892a                	mv	s2,a0
ffffffffc0206796:	e80518e3          	bnez	a0,ffffffffc0206626 <do_execve+0x1ba>
ffffffffc020679a:	018a3503          	ld	a0,24(s4)
ffffffffc020679e:	467d                	li	a2,31
ffffffffc02067a0:	7ffff5b7          	lui	a1,0x7ffff
ffffffffc02067a4:	b7efd0ef          	jal	ra,ffffffffc0203b22 <pgdir_alloc_page>
ffffffffc02067a8:	58050f63          	beqz	a0,ffffffffc0206d46 <do_execve+0x8da>
ffffffffc02067ac:	018a3503          	ld	a0,24(s4)
ffffffffc02067b0:	467d                	li	a2,31
ffffffffc02067b2:	7fffe5b7          	lui	a1,0x7fffe
ffffffffc02067b6:	b6cfd0ef          	jal	ra,ffffffffc0203b22 <pgdir_alloc_page>
ffffffffc02067ba:	56050663          	beqz	a0,ffffffffc0206d26 <do_execve+0x8ba>
ffffffffc02067be:	018a3503          	ld	a0,24(s4)
ffffffffc02067c2:	467d                	li	a2,31
ffffffffc02067c4:	7fffd5b7          	lui	a1,0x7fffd
ffffffffc02067c8:	b5afd0ef          	jal	ra,ffffffffc0203b22 <pgdir_alloc_page>
ffffffffc02067cc:	52050d63          	beqz	a0,ffffffffc0206d06 <do_execve+0x89a>
ffffffffc02067d0:	018a3503          	ld	a0,24(s4)
ffffffffc02067d4:	467d                	li	a2,31
ffffffffc02067d6:	7fffc5b7          	lui	a1,0x7fffc
ffffffffc02067da:	b48fd0ef          	jal	ra,ffffffffc0203b22 <pgdir_alloc_page>
ffffffffc02067de:	50050463          	beqz	a0,ffffffffc0206ce6 <do_execve+0x87a>
ffffffffc02067e2:	041c                	addi	a5,sp,512
ffffffffc02067e4:	e43e                	sd	a5,8(sp)
ffffffffc02067e6:	5b7d                	li	s6,-1
ffffffffc02067e8:	4785                	li	a5,1
ffffffffc02067ea:	f026                	sd	s1,32(sp)
ffffffffc02067ec:	64e2                	ld	s1,24(sp)
ffffffffc02067ee:	01f79a93          	slli	s5,a5,0x1f
ffffffffc02067f2:	00cb5793          	srli	a5,s6,0xc
ffffffffc02067f6:	6d85                	lui	s11,0x1
ffffffffc02067f8:	10010c13          	addi	s8,sp,256
ffffffffc02067fc:	e802                	sd	zero,16(sp)
ffffffffc02067fe:	e03e                	sd	a5,0(sp)
ffffffffc0206800:	f44a                	sd	s2,40(sp)
ffffffffc0206802:	fc22                	sd	s0,56(sp)
ffffffffc0206804:	000c3983          	ld	s3,0(s8)
ffffffffc0206808:	6585                	lui	a1,0x1
ffffffffc020680a:	854e                	mv	a0,s3
ffffffffc020680c:	4d3040ef          	jal	ra,ffffffffc020b4de <strnlen>
ffffffffc0206810:	0015091b          	addiw	s2,a0,1
ffffffffc0206814:	0005041b          	sext.w	s0,a0
ffffffffc0206818:	87d6                	mv	a5,s5
ffffffffc020681a:	0405                	addi	s0,s0,1
ffffffffc020681c:	412a8ab3          	sub	s5,s5,s2
ffffffffc0206820:	9456                	add	s0,s0,s5
ffffffffc0206822:	8b56                	mv	s6,s5
ffffffffc0206824:	40f90933          	sub	s2,s2,a5
ffffffffc0206828:	068af463          	bgeu	s5,s0,ffffffffc0206890 <do_execve+0x424>
ffffffffc020682c:	018a3503          	ld	a0,24(s4)
ffffffffc0206830:	4601                	li	a2,0
ffffffffc0206832:	85da                	mv	a1,s6
ffffffffc0206834:	9f1fb0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0206838:	611c                	ld	a5,0(a0)
ffffffffc020683a:	0017f693          	andi	a3,a5,1
ffffffffc020683e:	48068563          	beqz	a3,ffffffffc0206cc8 <do_execve+0x85c>
ffffffffc0206842:	000d3683          	ld	a3,0(s10)
ffffffffc0206846:	078a                	slli	a5,a5,0x2
ffffffffc0206848:	83b1                	srli	a5,a5,0xc
ffffffffc020684a:	50d7fe63          	bgeu	a5,a3,ffffffffc0206d66 <do_execve+0x8fa>
ffffffffc020684e:	6705                	lui	a4,0x1
ffffffffc0206850:	177d                	addi	a4,a4,-1
ffffffffc0206852:	00eb7533          	and	a0,s6,a4
ffffffffc0206856:	40ad85b3          	sub	a1,s11,a0
ffffffffc020685a:	41640633          	sub	a2,s0,s6
ffffffffc020685e:	00c5f363          	bgeu	a1,a2,ffffffffc0206864 <do_execve+0x3f8>
ffffffffc0206862:	862e                	mv	a2,a1
ffffffffc0206864:	8f85                	sub	a5,a5,s1
ffffffffc0206866:	6702                	ld	a4,0(sp)
ffffffffc0206868:	079a                	slli	a5,a5,0x6
ffffffffc020686a:	8799                	srai	a5,a5,0x6
ffffffffc020686c:	97a6                	add	a5,a5,s1
ffffffffc020686e:	00e7f5b3          	and	a1,a5,a4
ffffffffc0206872:	07b2                	slli	a5,a5,0xc
ffffffffc0206874:	44d5fc63          	bgeu	a1,a3,ffffffffc0206ccc <do_execve+0x860>
ffffffffc0206878:	000bb683          	ld	a3,0(s7)
ffffffffc020687c:	016905b3          	add	a1,s2,s6
ffffffffc0206880:	95ce                	add	a1,a1,s3
ffffffffc0206882:	97b6                	add	a5,a5,a3
ffffffffc0206884:	9b32                	add	s6,s6,a2
ffffffffc0206886:	953e                	add	a0,a0,a5
ffffffffc0206888:	531040ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc020688c:	fa8b60e3          	bltu	s6,s0,ffffffffc020682c <do_execve+0x3c0>
ffffffffc0206890:	6722                	ld	a4,8(sp)
ffffffffc0206892:	66c2                	ld	a3,16(sp)
ffffffffc0206894:	0c21                	addi	s8,s8,8
ffffffffc0206896:	01573023          	sd	s5,0(a4) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc020689a:	0721                	addi	a4,a4,8
ffffffffc020689c:	e43a                	sd	a4,8(sp)
ffffffffc020689e:	7702                	ld	a4,32(sp)
ffffffffc02068a0:	0016879b          	addiw	a5,a3,1
ffffffffc02068a4:	24e6d663          	bge	a3,a4,ffffffffc0206af0 <do_execve+0x684>
ffffffffc02068a8:	e83e                	sd	a5,16(sp)
ffffffffc02068aa:	bfa9                	j	ffffffffc0206804 <do_execve+0x398>
ffffffffc02068ac:	7402                	ld	s0,32(sp)
ffffffffc02068ae:	0005091b          	sext.w	s2,a0
ffffffffc02068b2:	d6054ae3          	bltz	a0,ffffffffc0206626 <do_execve+0x1ba>
ffffffffc02068b6:	597d                	li	s2,-1
ffffffffc02068b8:	b3bd                	j	ffffffffc0206626 <do_execve+0x1ba>
ffffffffc02068ba:	8922                	mv	s2,s0
ffffffffc02068bc:	7402                	ld	s0,32(sp)
ffffffffc02068be:	b3a5                	j	ffffffffc0206626 <do_execve+0x1ba>
ffffffffc02068c0:	000cb783          	ld	a5,0(s9)
ffffffffc02068c4:	00007617          	auipc	a2,0x7
ffffffffc02068c8:	e8460613          	addi	a2,a2,-380 # ffffffffc020d748 <CSWTCH.79+0x2f0>
ffffffffc02068cc:	45c1                	li	a1,16
ffffffffc02068ce:	43d4                	lw	a3,4(a5)
ffffffffc02068d0:	18a8                	addi	a0,sp,120
ffffffffc02068d2:	3a5040ef          	jal	ra,ffffffffc020b476 <snprintf>
ffffffffc02068d6:	b11d                	j	ffffffffc02064fc <do_execve+0x90>
ffffffffc02068d8:	764a                	ld	a2,176(sp)
ffffffffc02068da:	77aa                	ld	a5,168(sp)
ffffffffc02068dc:	36f66c63          	bltu	a2,a5,ffffffffc0206c54 <do_execve+0x7e8>
ffffffffc02068e0:	47ba                	lw	a5,140(sp)
ffffffffc02068e2:	0017f693          	andi	a3,a5,1
ffffffffc02068e6:	c291                	beqz	a3,ffffffffc02068ea <do_execve+0x47e>
ffffffffc02068e8:	4691                	li	a3,4
ffffffffc02068ea:	0027f713          	andi	a4,a5,2
ffffffffc02068ee:	8b91                	andi	a5,a5,4
ffffffffc02068f0:	14071063          	bnez	a4,ffffffffc0206a30 <do_execve+0x5c4>
ffffffffc02068f4:	4945                	li	s2,17
ffffffffc02068f6:	c781                	beqz	a5,ffffffffc02068fe <do_execve+0x492>
ffffffffc02068f8:	0016e693          	ori	a3,a3,1
ffffffffc02068fc:	494d                	li	s2,19
ffffffffc02068fe:	0026f793          	andi	a5,a3,2
ffffffffc0206902:	12079c63          	bnez	a5,ffffffffc0206a3a <do_execve+0x5ce>
ffffffffc0206906:	0046f793          	andi	a5,a3,4
ffffffffc020690a:	c399                	beqz	a5,ffffffffc0206910 <do_execve+0x4a4>
ffffffffc020690c:	00896913          	ori	s2,s2,8
ffffffffc0206910:	65ea                	ld	a1,152(sp)
ffffffffc0206912:	4701                	li	a4,0
ffffffffc0206914:	8552                	mv	a0,s4
ffffffffc0206916:	c92fd0ef          	jal	ra,ffffffffc0203da8 <mm_map>
ffffffffc020691a:	842a                	mv	s0,a0
ffffffffc020691c:	fd59                	bnez	a0,ffffffffc02068ba <do_execve+0x44e>
ffffffffc020691e:	774a                	ld	a4,176(sp)
ffffffffc0206920:	67ea                	ld	a5,152(sp)
ffffffffc0206922:	7c2a                	ld	s8,168(sp)
ffffffffc0206924:	f0ba                	sd	a4,96(sp)
ffffffffc0206926:	777d                	lui	a4,0xfffff
ffffffffc0206928:	00e7fb33          	and	s6,a5,a4
ffffffffc020692c:	01878733          	add	a4,a5,s8
ffffffffc0206930:	ecbe                	sd	a5,88(sp)
ffffffffc0206932:	e03a                	sd	a4,0(sp)
ffffffffc0206934:	30e7f363          	bgeu	a5,a4,ffffffffc0206c3a <do_execve+0x7ce>
ffffffffc0206938:	5471                	li	s0,-4
ffffffffc020693a:	8c3e                	mv	s8,a5
ffffffffc020693c:	84a2                	mv	s1,s0
ffffffffc020693e:	018a3503          	ld	a0,24(s4)
ffffffffc0206942:	864a                	mv	a2,s2
ffffffffc0206944:	85da                	mv	a1,s6
ffffffffc0206946:	9dcfd0ef          	jal	ra,ffffffffc0203b22 <pgdir_alloc_page>
ffffffffc020694a:	10050263          	beqz	a0,ffffffffc0206a4e <do_execve+0x5e2>
ffffffffc020694e:	000db783          	ld	a5,0(s11) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc0206952:	6762                	ld	a4,24(sp)
ffffffffc0206954:	65ca                	ld	a1,144(sp)
ffffffffc0206956:	8d1d                	sub	a0,a0,a5
ffffffffc0206958:	8519                	srai	a0,a0,0x6
ffffffffc020695a:	953a                	add	a0,a0,a4
ffffffffc020695c:	676a                	ld	a4,152(sp)
ffffffffc020695e:	000d3783          	ld	a5,0(s10)
ffffffffc0206962:	00c51993          	slli	s3,a0,0xc
ffffffffc0206966:	8d99                	sub	a1,a1,a4
ffffffffc0206968:	6742                	ld	a4,16(sp)
ffffffffc020696a:	95e2                	add	a1,a1,s8
ffffffffc020696c:	8f69                	and	a4,a4,a0
ffffffffc020696e:	32f77463          	bgeu	a4,a5,ffffffffc0206c96 <do_execve+0x82a>
ffffffffc0206972:	4601                	li	a2,0
ffffffffc0206974:	8556                	mv	a0,s5
ffffffffc0206976:	000bb403          	ld	s0,0(s7)
ffffffffc020697a:	e13fe0ef          	jal	ra,ffffffffc020578c <sysfile_seek>
ffffffffc020697e:	84aa                	mv	s1,a0
ffffffffc0206980:	e161                	bnez	a0,ffffffffc0206a40 <do_execve+0x5d4>
ffffffffc0206982:	6785                	lui	a5,0x1
ffffffffc0206984:	00fb0733          	add	a4,s6,a5
ffffffffc0206988:	6782                	ld	a5,0(sp)
ffffffffc020698a:	41870633          	sub	a2,a4,s8
ffffffffc020698e:	418786b3          	sub	a3,a5,s8
ffffffffc0206992:	00c6f363          	bgeu	a3,a2,ffffffffc0206998 <do_execve+0x52c>
ffffffffc0206996:	8636                	mv	a2,a3
ffffffffc0206998:	944e                	add	s0,s0,s3
ffffffffc020699a:	416c05b3          	sub	a1,s8,s6
ffffffffc020699e:	95a2                	add	a1,a1,s0
ffffffffc02069a0:	8556                	mv	a0,s5
ffffffffc02069a2:	fc32                	sd	a2,56(sp)
ffffffffc02069a4:	e43a                	sd	a4,8(sp)
ffffffffc02069a6:	bb9fe0ef          	jal	ra,ffffffffc020555e <sysfile_read>
ffffffffc02069aa:	7662                	ld	a2,56(sp)
ffffffffc02069ac:	f0a610e3          	bne	a2,a0,ffffffffc02068ac <do_execve+0x440>
ffffffffc02069b0:	6782                	ld	a5,0(sp)
ffffffffc02069b2:	9c32                	add	s8,s8,a2
ffffffffc02069b4:	6722                	ld	a4,8(sp)
ffffffffc02069b6:	08fc6863          	bltu	s8,a5,ffffffffc0206a46 <do_execve+0x5da>
ffffffffc02069ba:	67e6                	ld	a5,88(sp)
ffffffffc02069bc:	7706                	ld	a4,96(sp)
ffffffffc02069be:	00e784b3          	add	s1,a5,a4
ffffffffc02069c2:	6782                	ld	a5,0(sp)
ffffffffc02069c4:	da97f2e3          	bgeu	a5,s1,ffffffffc0206768 <do_execve+0x2fc>
ffffffffc02069c8:	6785                	lui	a5,0x1
ffffffffc02069ca:	17fd                	addi	a5,a5,-1
ffffffffc02069cc:	00fc79b3          	and	s3,s8,a5
ffffffffc02069d0:	0e099063          	bnez	s3,ffffffffc0206ab0 <do_execve+0x644>
ffffffffc02069d4:	d89c7ae3          	bgeu	s8,s1,ffffffffc0206768 <do_execve+0x2fc>
ffffffffc02069d8:	6462                	ld	s0,24(sp)
ffffffffc02069da:	a805                	j	ffffffffc0206a0a <do_execve+0x59e>
ffffffffc02069dc:	000db703          	ld	a4,0(s11)
ffffffffc02069e0:	000d3783          	ld	a5,0(s10)
ffffffffc02069e4:	8d19                	sub	a0,a0,a4
ffffffffc02069e6:	6742                	ld	a4,16(sp)
ffffffffc02069e8:	8519                	srai	a0,a0,0x6
ffffffffc02069ea:	9522                	add	a0,a0,s0
ffffffffc02069ec:	8f69                	and	a4,a4,a0
ffffffffc02069ee:	0532                	slli	a0,a0,0xc
ffffffffc02069f0:	36f77d63          	bgeu	a4,a5,ffffffffc0206d6a <do_execve+0x8fe>
ffffffffc02069f4:	000bb783          	ld	a5,0(s7)
ffffffffc02069f8:	6605                	lui	a2,0x1
ffffffffc02069fa:	4581                	li	a1,0
ffffffffc02069fc:	953e                	add	a0,a0,a5
ffffffffc02069fe:	6785                	lui	a5,0x1
ffffffffc0206a00:	9c3e                	add	s8,s8,a5
ffffffffc0206a02:	365040ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc0206a06:	d69c71e3          	bgeu	s8,s1,ffffffffc0206768 <do_execve+0x2fc>
ffffffffc0206a0a:	018a3503          	ld	a0,24(s4)
ffffffffc0206a0e:	864a                	mv	a2,s2
ffffffffc0206a10:	85e2                	mv	a1,s8
ffffffffc0206a12:	910fd0ef          	jal	ra,ffffffffc0203b22 <pgdir_alloc_page>
ffffffffc0206a16:	f179                	bnez	a0,ffffffffc02069dc <do_execve+0x570>
ffffffffc0206a18:	7402                	ld	s0,32(sp)
ffffffffc0206a1a:	5971                	li	s2,-4
ffffffffc0206a1c:	b129                	j	ffffffffc0206626 <do_execve+0x1ba>
ffffffffc0206a1e:	8552                	mv	a0,s4
ffffffffc0206a20:	b36fd0ef          	jal	ra,ffffffffc0203d56 <mm_destroy>
ffffffffc0206a24:	000cb783          	ld	a5,0(s9)
ffffffffc0206a28:	5961                	li	s2,-8
ffffffffc0206a2a:	0207b423          	sd	zero,40(a5) # 1028 <_binary_bin_swap_img_size-0x6cd8>
ffffffffc0206a2e:	b119                	j	ffffffffc0206634 <do_execve+0x1c8>
ffffffffc0206a30:	0026e693          	ori	a3,a3,2
ffffffffc0206a34:	4945                	li	s2,17
ffffffffc0206a36:	ec0791e3          	bnez	a5,ffffffffc02068f8 <do_execve+0x48c>
ffffffffc0206a3a:	00496913          	ori	s2,s2,4
ffffffffc0206a3e:	b5e1                	j	ffffffffc0206906 <do_execve+0x49a>
ffffffffc0206a40:	7402                	ld	s0,32(sp)
ffffffffc0206a42:	892a                	mv	s2,a0
ffffffffc0206a44:	b6cd                	j	ffffffffc0206626 <do_execve+0x1ba>
ffffffffc0206a46:	eeec6ce3          	bltu	s8,a4,ffffffffc020693e <do_execve+0x4d2>
ffffffffc0206a4a:	8b3a                	mv	s6,a4
ffffffffc0206a4c:	bdcd                	j	ffffffffc020693e <do_execve+0x4d2>
ffffffffc0206a4e:	7402                	ld	s0,32(sp)
ffffffffc0206a50:	8926                	mv	s2,s1
ffffffffc0206a52:	bc049ae3          	bnez	s1,ffffffffc0206626 <do_execve+0x1ba>
ffffffffc0206a56:	67c6                	ld	a5,80(sp)
ffffffffc0206a58:	1984                	addi	s1,sp,240
ffffffffc0206a5a:	147d                	addi	s0,s0,-1
ffffffffc0206a5c:	94be                	add	s1,s1,a5
ffffffffc0206a5e:	67a6                	ld	a5,72(sp)
ffffffffc0206a60:	040e                	slli	s0,s0,0x3
ffffffffc0206a62:	02079713          	slli	a4,a5,0x20
ffffffffc0206a66:	01d75793          	srli	a5,a4,0x1d
ffffffffc0206a6a:	0218                	addi	a4,sp,256
ffffffffc0206a6c:	943a                	add	s0,s0,a4
ffffffffc0206a6e:	8c9d                	sub	s1,s1,a5
ffffffffc0206a70:	6008                	ld	a0,0(s0)
ffffffffc0206a72:	1461                	addi	s0,s0,-8
ffffffffc0206a74:	dcafb0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0206a78:	fe849ce3          	bne	s1,s0,ffffffffc0206a70 <do_execve+0x604>
ffffffffc0206a7c:	000cb403          	ld	s0,0(s9)
ffffffffc0206a80:	4641                	li	a2,16
ffffffffc0206a82:	4581                	li	a1,0
ffffffffc0206a84:	0b440413          	addi	s0,s0,180
ffffffffc0206a88:	8522                	mv	a0,s0
ffffffffc0206a8a:	2dd040ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc0206a8e:	463d                	li	a2,15
ffffffffc0206a90:	18ac                	addi	a1,sp,120
ffffffffc0206a92:	8522                	mv	a0,s0
ffffffffc0206a94:	325040ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc0206a98:	b125                	j	ffffffffc02066c0 <do_execve+0x254>
ffffffffc0206a9a:	855a                	mv	a0,s6
ffffffffc0206a9c:	c56fd0ef          	jal	ra,ffffffffc0203ef2 <exit_mmap>
ffffffffc0206aa0:	018b3503          	ld	a0,24(s6)
ffffffffc0206aa4:	810ff0ef          	jal	ra,ffffffffc0205ab4 <put_pgdir.isra.0>
ffffffffc0206aa8:	855a                	mv	a0,s6
ffffffffc0206aaa:	aacfd0ef          	jal	ra,ffffffffc0203d56 <mm_destroy>
ffffffffc0206aae:	bcc5                	j	ffffffffc020659e <do_execve+0x132>
ffffffffc0206ab0:	018a3503          	ld	a0,24(s4)
ffffffffc0206ab4:	4601                	li	a2,0
ffffffffc0206ab6:	85e2                	mv	a1,s8
ffffffffc0206ab8:	f6cfb0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0206abc:	c511                	beqz	a0,ffffffffc0206ac8 <do_execve+0x65c>
ffffffffc0206abe:	6118                	ld	a4,0(a0)
ffffffffc0206ac0:	00177693          	andi	a3,a4,1
ffffffffc0206ac4:	18069b63          	bnez	a3,ffffffffc0206c5a <do_execve+0x7ee>
ffffffffc0206ac8:	6785                	lui	a5,0x1
ffffffffc0206aca:	17fd                	addi	a5,a5,-1
ffffffffc0206acc:	97e2                	add	a5,a5,s8
ffffffffc0206ace:	777d                	lui	a4,0xfffff
ffffffffc0206ad0:	00e7fc33          	and	s8,a5,a4
ffffffffc0206ad4:	b701                	j	ffffffffc02069d4 <do_execve+0x568>
ffffffffc0206ad6:	57f5                	li	a5,-3
ffffffffc0206ad8:	f83e                	sd	a5,48(sp)
ffffffffc0206ada:	b6dd                	j	ffffffffc02066c0 <do_execve+0x254>
ffffffffc0206adc:	8552                	mv	a0,s4
ffffffffc0206ade:	a78fd0ef          	jal	ra,ffffffffc0203d56 <mm_destroy>
ffffffffc0206ae2:	5971                	li	s2,-4
ffffffffc0206ae4:	be81                	j	ffffffffc0206634 <do_execve+0x1c8>
ffffffffc0206ae6:	57f5                	li	a5,-3
ffffffffc0206ae8:	f83e                	sd	a5,48(sp)
ffffffffc0206aea:	bc0b15e3          	bnez	s6,ffffffffc02066b4 <do_execve+0x248>
ffffffffc0206aee:	bec9                	j	ffffffffc02066c0 <do_execve+0x254>
ffffffffc0206af0:	67c6                	ld	a5,80(sp)
ffffffffc0206af2:	7462                	ld	s0,56(sp)
ffffffffc0206af4:	7922                	ld	s2,40(sp)
ffffffffc0206af6:	00878b13          	addi	s6,a5,8 # 1008 <_binary_bin_swap_img_size-0x6cf8>
ffffffffc0206afa:	416a8b33          	sub	s6,s5,s6
ffffffffc0206afe:	ff0b7793          	andi	a5,s6,-16
ffffffffc0206b02:	20010b13          	addi	s6,sp,512
ffffffffc0206b06:	e03e                	sd	a5,0(sp)
ffffffffc0206b08:	41678ab3          	sub	s5,a5,s6
ffffffffc0206b0c:	6785                	lui	a5,0x1
ffffffffc0206b0e:	fff78d93          	addi	s11,a5,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0206b12:	57fd                	li	a5,-1
ffffffffc0206b14:	e422                	sd	s0,8(sp)
ffffffffc0206b16:	7482                	ld	s1,32(sp)
ffffffffc0206b18:	6c62                	ld	s8,24(sp)
ffffffffc0206b1a:	00c7d993          	srli	s3,a5,0xc
ffffffffc0206b1e:	844a                	mv	s0,s2
ffffffffc0206b20:	a011                	j	ffffffffc0206b24 <do_execve+0x6b8>
ffffffffc0206b22:	843a                	mv	s0,a4
ffffffffc0206b24:	018a3503          	ld	a0,24(s4)
ffffffffc0206b28:	016a8933          	add	s2,s5,s6
ffffffffc0206b2c:	4601                	li	a2,0
ffffffffc0206b2e:	85ca                	mv	a1,s2
ffffffffc0206b30:	ef4fb0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0206b34:	611c                	ld	a5,0(a0)
ffffffffc0206b36:	0017f713          	andi	a4,a5,1
ffffffffc0206b3a:	18070763          	beqz	a4,ffffffffc0206cc8 <do_execve+0x85c>
ffffffffc0206b3e:	000d3603          	ld	a2,0(s10)
ffffffffc0206b42:	078a                	slli	a5,a5,0x2
ffffffffc0206b44:	83b1                	srli	a5,a5,0xc
ffffffffc0206b46:	22c7f063          	bgeu	a5,a2,ffffffffc0206d66 <do_execve+0x8fa>
ffffffffc0206b4a:	418787b3          	sub	a5,a5,s8
ffffffffc0206b4e:	079a                	slli	a5,a5,0x6
ffffffffc0206b50:	8799                	srai	a5,a5,0x6
ffffffffc0206b52:	97e2                	add	a5,a5,s8
ffffffffc0206b54:	0137f533          	and	a0,a5,s3
ffffffffc0206b58:	000b3583          	ld	a1,0(s6)
ffffffffc0206b5c:	01b97733          	and	a4,s2,s11
ffffffffc0206b60:	00c79693          	slli	a3,a5,0xc
ffffffffc0206b64:	12c57a63          	bgeu	a0,a2,ffffffffc0206c98 <do_execve+0x82c>
ffffffffc0206b68:	000bb603          	ld	a2,0(s7)
ffffffffc0206b6c:	00d707b3          	add	a5,a4,a3
ffffffffc0206b70:	0b21                	addi	s6,s6,8
ffffffffc0206b72:	97b2                	add	a5,a5,a2
ffffffffc0206b74:	e38c                	sd	a1,0(a5)
ffffffffc0206b76:	0014071b          	addiw	a4,s0,1
ffffffffc0206b7a:	fa9444e3          	blt	s0,s1,ffffffffc0206b22 <do_execve+0x6b6>
ffffffffc0206b7e:	6782                	ld	a5,0(sp)
ffffffffc0206b80:	6746                	ld	a4,80(sp)
ffffffffc0206b82:	018a3503          	ld	a0,24(s4)
ffffffffc0206b86:	4601                	li	a2,0
ffffffffc0206b88:	00e784b3          	add	s1,a5,a4
ffffffffc0206b8c:	85a6                	mv	a1,s1
ffffffffc0206b8e:	6422                	ld	s0,8(sp)
ffffffffc0206b90:	e94fb0ef          	jal	ra,ffffffffc0202224 <get_pte>
ffffffffc0206b94:	611c                	ld	a5,0(a0)
ffffffffc0206b96:	0017f713          	andi	a4,a5,1
ffffffffc0206b9a:	12070763          	beqz	a4,ffffffffc0206cc8 <do_execve+0x85c>
ffffffffc0206b9e:	000d3703          	ld	a4,0(s10)
ffffffffc0206ba2:	078a                	slli	a5,a5,0x2
ffffffffc0206ba4:	83b1                	srli	a5,a5,0xc
ffffffffc0206ba6:	1ce7f063          	bgeu	a5,a4,ffffffffc0206d66 <do_execve+0x8fa>
ffffffffc0206baa:	66e2                	ld	a3,24(sp)
ffffffffc0206bac:	01b4f4b3          	and	s1,s1,s11
ffffffffc0206bb0:	8f95                	sub	a5,a5,a3
ffffffffc0206bb2:	079a                	slli	a5,a5,0x6
ffffffffc0206bb4:	8799                	srai	a5,a5,0x6
ffffffffc0206bb6:	97b6                	add	a5,a5,a3
ffffffffc0206bb8:	0137f9b3          	and	s3,a5,s3
ffffffffc0206bbc:	00c79693          	slli	a3,a5,0xc
ffffffffc0206bc0:	0ce9fc63          	bgeu	s3,a4,ffffffffc0206c98 <do_execve+0x82c>
ffffffffc0206bc4:	000bb583          	ld	a1,0(s7)
ffffffffc0206bc8:	030a2603          	lw	a2,48(s4)
ffffffffc0206bcc:	00d487b3          	add	a5,s1,a3
ffffffffc0206bd0:	000cb703          	ld	a4,0(s9)
ffffffffc0206bd4:	97ae                	add	a5,a5,a1
ffffffffc0206bd6:	0007b023          	sd	zero,0(a5)
ffffffffc0206bda:	018a3683          	ld	a3,24(s4)
ffffffffc0206bde:	0016079b          	addiw	a5,a2,1
ffffffffc0206be2:	02fa2823          	sw	a5,48(s4)
ffffffffc0206be6:	03473423          	sd	s4,40(a4) # fffffffffffff028 <end+0x3fd68718>
ffffffffc0206bea:	c02007b7          	lui	a5,0xc0200
ffffffffc0206bee:	0cf6e163          	bltu	a3,a5,ffffffffc0206cb0 <do_execve+0x844>
ffffffffc0206bf2:	000bb783          	ld	a5,0(s7)
ffffffffc0206bf6:	567d                	li	a2,-1
ffffffffc0206bf8:	03f61b93          	slli	s7,a2,0x3f
ffffffffc0206bfc:	8e9d                	sub	a3,a3,a5
ffffffffc0206bfe:	00c6d793          	srli	a5,a3,0xc
ffffffffc0206c02:	f754                	sd	a3,168(a4)
ffffffffc0206c04:	0177ebb3          	or	s7,a5,s7
ffffffffc0206c08:	180b9073          	csrw	satp,s7
ffffffffc0206c0c:	7344                	ld	s1,160(a4)
ffffffffc0206c0e:	12000613          	li	a2,288
ffffffffc0206c12:	4581                	li	a1,0
ffffffffc0206c14:	1004b903          	ld	s2,256(s1)
ffffffffc0206c18:	8526                	mv	a0,s1
ffffffffc0206c1a:	14d040ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc0206c1e:	edf97793          	andi	a5,s2,-289
ffffffffc0206c22:	0207e793          	ori	a5,a5,32
ffffffffc0206c26:	676e                	ld	a4,216(sp)
ffffffffc0206c28:	10f4b023          	sd	a5,256(s1)
ffffffffc0206c2c:	6782                	ld	a5,0(sp)
ffffffffc0206c2e:	10e4b423          	sd	a4,264(s1)
ffffffffc0206c32:	e8a0                	sd	s0,80(s1)
ffffffffc0206c34:	e89c                	sd	a5,16(s1)
ffffffffc0206c36:	ecbc                	sd	a5,88(s1)
ffffffffc0206c38:	bd39                	j	ffffffffc0206a56 <do_execve+0x5ea>
ffffffffc0206c3a:	6c66                	ld	s8,88(sp)
ffffffffc0206c3c:	bbbd                	j	ffffffffc02069ba <do_execve+0x54e>
ffffffffc0206c3e:	e80b0ce3          	beqz	s6,ffffffffc0206ad6 <do_execve+0x66a>
ffffffffc0206c42:	038b0513          	addi	a0,s6,56
ffffffffc0206c46:	91bfd0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0206c4a:	57f5                	li	a5,-3
ffffffffc0206c4c:	f83e                	sd	a5,48(sp)
ffffffffc0206c4e:	040b2823          	sw	zero,80(s6)
ffffffffc0206c52:	b4bd                	j	ffffffffc02066c0 <do_execve+0x254>
ffffffffc0206c54:	7402                	ld	s0,32(sp)
ffffffffc0206c56:	5961                	li	s2,-8
ffffffffc0206c58:	b2f9                	j	ffffffffc0206626 <do_execve+0x1ba>
ffffffffc0206c5a:	000d3603          	ld	a2,0(s10)
ffffffffc0206c5e:	070a                	slli	a4,a4,0x2
ffffffffc0206c60:	8331                	srli	a4,a4,0xc
ffffffffc0206c62:	10c77263          	bgeu	a4,a2,ffffffffc0206d66 <do_execve+0x8fa>
ffffffffc0206c66:	67e2                	ld	a5,24(sp)
ffffffffc0206c68:	8f1d                	sub	a4,a4,a5
ffffffffc0206c6a:	071a                	slli	a4,a4,0x6
ffffffffc0206c6c:	8719                	srai	a4,a4,0x6
ffffffffc0206c6e:	973e                	add	a4,a4,a5
ffffffffc0206c70:	67c2                	ld	a5,16(sp)
ffffffffc0206c72:	00c71693          	slli	a3,a4,0xc
ffffffffc0206c76:	00f775b3          	and	a1,a4,a5
ffffffffc0206c7a:	00c5ff63          	bgeu	a1,a2,ffffffffc0206c98 <do_execve+0x82c>
ffffffffc0206c7e:	000bb703          	ld	a4,0(s7)
ffffffffc0206c82:	6785                	lui	a5,0x1
ffffffffc0206c84:	41378633          	sub	a2,a5,s3
ffffffffc0206c88:	9736                	add	a4,a4,a3
ffffffffc0206c8a:	4581                	li	a1,0
ffffffffc0206c8c:	01370533          	add	a0,a4,s3
ffffffffc0206c90:	0d7040ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc0206c94:	bd15                	j	ffffffffc0206ac8 <do_execve+0x65c>
ffffffffc0206c96:	86ce                	mv	a3,s3
ffffffffc0206c98:	00006617          	auipc	a2,0x6
ffffffffc0206c9c:	8d060613          	addi	a2,a2,-1840 # ffffffffc020c568 <default_pmm_manager+0x38>
ffffffffc0206ca0:	07100593          	li	a1,113
ffffffffc0206ca4:	00006517          	auipc	a0,0x6
ffffffffc0206ca8:	8ec50513          	addi	a0,a0,-1812 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc0206cac:	ff2f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206cb0:	00006617          	auipc	a2,0x6
ffffffffc0206cb4:	96060613          	addi	a2,a2,-1696 # ffffffffc020c610 <default_pmm_manager+0xe0>
ffffffffc0206cb8:	38100593          	li	a1,897
ffffffffc0206cbc:	00007517          	auipc	a0,0x7
ffffffffc0206cc0:	8ac50513          	addi	a0,a0,-1876 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0206cc4:	fdaf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206cc8:	dd1fe0ef          	jal	ra,ffffffffc0205a98 <pte2page.part.0>
ffffffffc0206ccc:	86be                	mv	a3,a5
ffffffffc0206cce:	00006617          	auipc	a2,0x6
ffffffffc0206cd2:	89a60613          	addi	a2,a2,-1894 # ffffffffc020c568 <default_pmm_manager+0x38>
ffffffffc0206cd6:	07100593          	li	a1,113
ffffffffc0206cda:	00006517          	auipc	a0,0x6
ffffffffc0206cde:	8b650513          	addi	a0,a0,-1866 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc0206ce2:	fbcf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206ce6:	00007697          	auipc	a3,0x7
ffffffffc0206cea:	b4a68693          	addi	a3,a3,-1206 # ffffffffc020d830 <CSWTCH.79+0x3d8>
ffffffffc0206cee:	00005617          	auipc	a2,0x5
ffffffffc0206cf2:	d5a60613          	addi	a2,a2,-678 # ffffffffc020ba48 <commands+0x210>
ffffffffc0206cf6:	35000593          	li	a1,848
ffffffffc0206cfa:	00007517          	auipc	a0,0x7
ffffffffc0206cfe:	86e50513          	addi	a0,a0,-1938 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0206d02:	f9cf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206d06:	00007697          	auipc	a3,0x7
ffffffffc0206d0a:	ae268693          	addi	a3,a3,-1310 # ffffffffc020d7e8 <CSWTCH.79+0x390>
ffffffffc0206d0e:	00005617          	auipc	a2,0x5
ffffffffc0206d12:	d3a60613          	addi	a2,a2,-710 # ffffffffc020ba48 <commands+0x210>
ffffffffc0206d16:	34f00593          	li	a1,847
ffffffffc0206d1a:	00007517          	auipc	a0,0x7
ffffffffc0206d1e:	84e50513          	addi	a0,a0,-1970 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0206d22:	f7cf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206d26:	00007697          	auipc	a3,0x7
ffffffffc0206d2a:	a7a68693          	addi	a3,a3,-1414 # ffffffffc020d7a0 <CSWTCH.79+0x348>
ffffffffc0206d2e:	00005617          	auipc	a2,0x5
ffffffffc0206d32:	d1a60613          	addi	a2,a2,-742 # ffffffffc020ba48 <commands+0x210>
ffffffffc0206d36:	34e00593          	li	a1,846
ffffffffc0206d3a:	00007517          	auipc	a0,0x7
ffffffffc0206d3e:	82e50513          	addi	a0,a0,-2002 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0206d42:	f5cf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206d46:	00007697          	auipc	a3,0x7
ffffffffc0206d4a:	a1268693          	addi	a3,a3,-1518 # ffffffffc020d758 <CSWTCH.79+0x300>
ffffffffc0206d4e:	00005617          	auipc	a2,0x5
ffffffffc0206d52:	cfa60613          	addi	a2,a2,-774 # ffffffffc020ba48 <commands+0x210>
ffffffffc0206d56:	34d00593          	li	a1,845
ffffffffc0206d5a:	00007517          	auipc	a0,0x7
ffffffffc0206d5e:	80e50513          	addi	a0,a0,-2034 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0206d62:	f3cf90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206d66:	d17fe0ef          	jal	ra,ffffffffc0205a7c <pa2page.part.0>
ffffffffc0206d6a:	86aa                	mv	a3,a0
ffffffffc0206d6c:	00005617          	auipc	a2,0x5
ffffffffc0206d70:	7fc60613          	addi	a2,a2,2044 # ffffffffc020c568 <default_pmm_manager+0x38>
ffffffffc0206d74:	07100593          	li	a1,113
ffffffffc0206d78:	00006517          	auipc	a0,0x6
ffffffffc0206d7c:	81850513          	addi	a0,a0,-2024 # ffffffffc020c590 <default_pmm_manager+0x60>
ffffffffc0206d80:	f1ef90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206d84:	892a                	mv	s2,a0
ffffffffc0206d86:	8afff06f          	j	ffffffffc0206634 <do_execve+0x1c8>

ffffffffc0206d8a <user_main>:
ffffffffc0206d8a:	7179                	addi	sp,sp,-48
ffffffffc0206d8c:	e84a                	sd	s2,16(sp)
ffffffffc0206d8e:	00090917          	auipc	s2,0x90
ffffffffc0206d92:	b3290913          	addi	s2,s2,-1230 # ffffffffc02968c0 <current>
ffffffffc0206d96:	00093783          	ld	a5,0(s2)
ffffffffc0206d9a:	00007617          	auipc	a2,0x7
ffffffffc0206d9e:	ade60613          	addi	a2,a2,-1314 # ffffffffc020d878 <CSWTCH.79+0x420>
ffffffffc0206da2:	00007517          	auipc	a0,0x7
ffffffffc0206da6:	ade50513          	addi	a0,a0,-1314 # ffffffffc020d880 <CSWTCH.79+0x428>
ffffffffc0206daa:	43cc                	lw	a1,4(a5)
ffffffffc0206dac:	f406                	sd	ra,40(sp)
ffffffffc0206dae:	f022                	sd	s0,32(sp)
ffffffffc0206db0:	ec26                	sd	s1,24(sp)
ffffffffc0206db2:	e032                	sd	a2,0(sp)
ffffffffc0206db4:	e402                	sd	zero,8(sp)
ffffffffc0206db6:	bf0f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0206dba:	6782                	ld	a5,0(sp)
ffffffffc0206dbc:	cfb9                	beqz	a5,ffffffffc0206e1a <user_main+0x90>
ffffffffc0206dbe:	003c                	addi	a5,sp,8
ffffffffc0206dc0:	4401                	li	s0,0
ffffffffc0206dc2:	6398                	ld	a4,0(a5)
ffffffffc0206dc4:	0405                	addi	s0,s0,1
ffffffffc0206dc6:	07a1                	addi	a5,a5,8
ffffffffc0206dc8:	ff6d                	bnez	a4,ffffffffc0206dc2 <user_main+0x38>
ffffffffc0206dca:	00093783          	ld	a5,0(s2)
ffffffffc0206dce:	12000613          	li	a2,288
ffffffffc0206dd2:	6b84                	ld	s1,16(a5)
ffffffffc0206dd4:	73cc                	ld	a1,160(a5)
ffffffffc0206dd6:	6789                	lui	a5,0x2
ffffffffc0206dd8:	ee078793          	addi	a5,a5,-288 # 1ee0 <_binary_bin_swap_img_size-0x5e20>
ffffffffc0206ddc:	94be                	add	s1,s1,a5
ffffffffc0206dde:	8526                	mv	a0,s1
ffffffffc0206de0:	7d8040ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc0206de4:	00093783          	ld	a5,0(s2)
ffffffffc0206de8:	860a                	mv	a2,sp
ffffffffc0206dea:	0004059b          	sext.w	a1,s0
ffffffffc0206dee:	f3c4                	sd	s1,160(a5)
ffffffffc0206df0:	00007517          	auipc	a0,0x7
ffffffffc0206df4:	a8850513          	addi	a0,a0,-1400 # ffffffffc020d878 <CSWTCH.79+0x420>
ffffffffc0206df8:	e74ff0ef          	jal	ra,ffffffffc020646c <do_execve>
ffffffffc0206dfc:	8126                	mv	sp,s1
ffffffffc0206dfe:	c52fa06f          	j	ffffffffc0201250 <__trapret>
ffffffffc0206e02:	00007617          	auipc	a2,0x7
ffffffffc0206e06:	aa660613          	addi	a2,a2,-1370 # ffffffffc020d8a8 <CSWTCH.79+0x450>
ffffffffc0206e0a:	4ab00593          	li	a1,1195
ffffffffc0206e0e:	00006517          	auipc	a0,0x6
ffffffffc0206e12:	75a50513          	addi	a0,a0,1882 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0206e16:	e88f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0206e1a:	4401                	li	s0,0
ffffffffc0206e1c:	b77d                	j	ffffffffc0206dca <user_main+0x40>

ffffffffc0206e1e <do_yield>:
ffffffffc0206e1e:	00090797          	auipc	a5,0x90
ffffffffc0206e22:	aa27b783          	ld	a5,-1374(a5) # ffffffffc02968c0 <current>
ffffffffc0206e26:	4705                	li	a4,1
ffffffffc0206e28:	ef98                	sd	a4,24(a5)
ffffffffc0206e2a:	4501                	li	a0,0
ffffffffc0206e2c:	8082                	ret

ffffffffc0206e2e <do_wait>:
ffffffffc0206e2e:	1101                	addi	sp,sp,-32
ffffffffc0206e30:	e822                	sd	s0,16(sp)
ffffffffc0206e32:	e426                	sd	s1,8(sp)
ffffffffc0206e34:	ec06                	sd	ra,24(sp)
ffffffffc0206e36:	842e                	mv	s0,a1
ffffffffc0206e38:	84aa                	mv	s1,a0
ffffffffc0206e3a:	c999                	beqz	a1,ffffffffc0206e50 <do_wait+0x22>
ffffffffc0206e3c:	00090797          	auipc	a5,0x90
ffffffffc0206e40:	a847b783          	ld	a5,-1404(a5) # ffffffffc02968c0 <current>
ffffffffc0206e44:	7788                	ld	a0,40(a5)
ffffffffc0206e46:	4685                	li	a3,1
ffffffffc0206e48:	4611                	li	a2,4
ffffffffc0206e4a:	c48fd0ef          	jal	ra,ffffffffc0204292 <user_mem_check>
ffffffffc0206e4e:	c909                	beqz	a0,ffffffffc0206e60 <do_wait+0x32>
ffffffffc0206e50:	85a2                	mv	a1,s0
ffffffffc0206e52:	6442                	ld	s0,16(sp)
ffffffffc0206e54:	60e2                	ld	ra,24(sp)
ffffffffc0206e56:	8526                	mv	a0,s1
ffffffffc0206e58:	64a2                	ld	s1,8(sp)
ffffffffc0206e5a:	6105                	addi	sp,sp,32
ffffffffc0206e5c:	b02ff06f          	j	ffffffffc020615e <do_wait.part.0>
ffffffffc0206e60:	60e2                	ld	ra,24(sp)
ffffffffc0206e62:	6442                	ld	s0,16(sp)
ffffffffc0206e64:	64a2                	ld	s1,8(sp)
ffffffffc0206e66:	5575                	li	a0,-3
ffffffffc0206e68:	6105                	addi	sp,sp,32
ffffffffc0206e6a:	8082                	ret

ffffffffc0206e6c <do_kill>:
ffffffffc0206e6c:	1141                	addi	sp,sp,-16
ffffffffc0206e6e:	6789                	lui	a5,0x2
ffffffffc0206e70:	e406                	sd	ra,8(sp)
ffffffffc0206e72:	e022                	sd	s0,0(sp)
ffffffffc0206e74:	fff5071b          	addiw	a4,a0,-1
ffffffffc0206e78:	17f9                	addi	a5,a5,-2
ffffffffc0206e7a:	02e7e963          	bltu	a5,a4,ffffffffc0206eac <do_kill+0x40>
ffffffffc0206e7e:	842a                	mv	s0,a0
ffffffffc0206e80:	45a9                	li	a1,10
ffffffffc0206e82:	2501                	sext.w	a0,a0
ffffffffc0206e84:	1ae040ef          	jal	ra,ffffffffc020b032 <hash32>
ffffffffc0206e88:	02051793          	slli	a5,a0,0x20
ffffffffc0206e8c:	01c7d513          	srli	a0,a5,0x1c
ffffffffc0206e90:	0008b797          	auipc	a5,0x8b
ffffffffc0206e94:	93078793          	addi	a5,a5,-1744 # ffffffffc02917c0 <hash_list>
ffffffffc0206e98:	953e                	add	a0,a0,a5
ffffffffc0206e9a:	87aa                	mv	a5,a0
ffffffffc0206e9c:	a029                	j	ffffffffc0206ea6 <do_kill+0x3a>
ffffffffc0206e9e:	f2c7a703          	lw	a4,-212(a5)
ffffffffc0206ea2:	00870b63          	beq	a4,s0,ffffffffc0206eb8 <do_kill+0x4c>
ffffffffc0206ea6:	679c                	ld	a5,8(a5)
ffffffffc0206ea8:	fef51be3          	bne	a0,a5,ffffffffc0206e9e <do_kill+0x32>
ffffffffc0206eac:	5475                	li	s0,-3
ffffffffc0206eae:	60a2                	ld	ra,8(sp)
ffffffffc0206eb0:	8522                	mv	a0,s0
ffffffffc0206eb2:	6402                	ld	s0,0(sp)
ffffffffc0206eb4:	0141                	addi	sp,sp,16
ffffffffc0206eb6:	8082                	ret
ffffffffc0206eb8:	fd87a703          	lw	a4,-40(a5)
ffffffffc0206ebc:	00177693          	andi	a3,a4,1
ffffffffc0206ec0:	e295                	bnez	a3,ffffffffc0206ee4 <do_kill+0x78>
ffffffffc0206ec2:	4bd4                	lw	a3,20(a5)
ffffffffc0206ec4:	00176713          	ori	a4,a4,1
ffffffffc0206ec8:	fce7ac23          	sw	a4,-40(a5)
ffffffffc0206ecc:	4401                	li	s0,0
ffffffffc0206ece:	fe06d0e3          	bgez	a3,ffffffffc0206eae <do_kill+0x42>
ffffffffc0206ed2:	f2878513          	addi	a0,a5,-216
ffffffffc0206ed6:	45a000ef          	jal	ra,ffffffffc0207330 <wakeup_proc>
ffffffffc0206eda:	60a2                	ld	ra,8(sp)
ffffffffc0206edc:	8522                	mv	a0,s0
ffffffffc0206ede:	6402                	ld	s0,0(sp)
ffffffffc0206ee0:	0141                	addi	sp,sp,16
ffffffffc0206ee2:	8082                	ret
ffffffffc0206ee4:	545d                	li	s0,-9
ffffffffc0206ee6:	b7e1                	j	ffffffffc0206eae <do_kill+0x42>

ffffffffc0206ee8 <proc_init>:
ffffffffc0206ee8:	1101                	addi	sp,sp,-32
ffffffffc0206eea:	e426                	sd	s1,8(sp)
ffffffffc0206eec:	0008f797          	auipc	a5,0x8f
ffffffffc0206ef0:	8d478793          	addi	a5,a5,-1836 # ffffffffc02957c0 <proc_list>
ffffffffc0206ef4:	ec06                	sd	ra,24(sp)
ffffffffc0206ef6:	e822                	sd	s0,16(sp)
ffffffffc0206ef8:	e04a                	sd	s2,0(sp)
ffffffffc0206efa:	0008b497          	auipc	s1,0x8b
ffffffffc0206efe:	8c648493          	addi	s1,s1,-1850 # ffffffffc02917c0 <hash_list>
ffffffffc0206f02:	e79c                	sd	a5,8(a5)
ffffffffc0206f04:	e39c                	sd	a5,0(a5)
ffffffffc0206f06:	0008f717          	auipc	a4,0x8f
ffffffffc0206f0a:	8ba70713          	addi	a4,a4,-1862 # ffffffffc02957c0 <proc_list>
ffffffffc0206f0e:	87a6                	mv	a5,s1
ffffffffc0206f10:	e79c                	sd	a5,8(a5)
ffffffffc0206f12:	e39c                	sd	a5,0(a5)
ffffffffc0206f14:	07c1                	addi	a5,a5,16
ffffffffc0206f16:	fef71de3          	bne	a4,a5,ffffffffc0206f10 <proc_init+0x28>
ffffffffc0206f1a:	abbfe0ef          	jal	ra,ffffffffc02059d4 <alloc_proc>
ffffffffc0206f1e:	00090917          	auipc	s2,0x90
ffffffffc0206f22:	9aa90913          	addi	s2,s2,-1622 # ffffffffc02968c8 <idleproc>
ffffffffc0206f26:	00a93023          	sd	a0,0(s2)
ffffffffc0206f2a:	842a                	mv	s0,a0
ffffffffc0206f2c:	12050863          	beqz	a0,ffffffffc020705c <proc_init+0x174>
ffffffffc0206f30:	4789                	li	a5,2
ffffffffc0206f32:	e11c                	sd	a5,0(a0)
ffffffffc0206f34:	0000a797          	auipc	a5,0xa
ffffffffc0206f38:	0cc78793          	addi	a5,a5,204 # ffffffffc0211000 <bootstack>
ffffffffc0206f3c:	e91c                	sd	a5,16(a0)
ffffffffc0206f3e:	4785                	li	a5,1
ffffffffc0206f40:	ed1c                	sd	a5,24(a0)
ffffffffc0206f42:	a8cfe0ef          	jal	ra,ffffffffc02051ce <files_create>
ffffffffc0206f46:	14a43423          	sd	a0,328(s0)
ffffffffc0206f4a:	0e050d63          	beqz	a0,ffffffffc0207044 <proc_init+0x15c>
ffffffffc0206f4e:	00093403          	ld	s0,0(s2)
ffffffffc0206f52:	4641                	li	a2,16
ffffffffc0206f54:	4581                	li	a1,0
ffffffffc0206f56:	14843703          	ld	a4,328(s0)
ffffffffc0206f5a:	0b440413          	addi	s0,s0,180
ffffffffc0206f5e:	8522                	mv	a0,s0
ffffffffc0206f60:	4b1c                	lw	a5,16(a4)
ffffffffc0206f62:	2785                	addiw	a5,a5,1
ffffffffc0206f64:	cb1c                	sw	a5,16(a4)
ffffffffc0206f66:	600040ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc0206f6a:	463d                	li	a2,15
ffffffffc0206f6c:	00007597          	auipc	a1,0x7
ffffffffc0206f70:	99c58593          	addi	a1,a1,-1636 # ffffffffc020d908 <CSWTCH.79+0x4b0>
ffffffffc0206f74:	8522                	mv	a0,s0
ffffffffc0206f76:	642040ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc0206f7a:	00090717          	auipc	a4,0x90
ffffffffc0206f7e:	95e70713          	addi	a4,a4,-1698 # ffffffffc02968d8 <nr_process>
ffffffffc0206f82:	431c                	lw	a5,0(a4)
ffffffffc0206f84:	00093683          	ld	a3,0(s2)
ffffffffc0206f88:	4601                	li	a2,0
ffffffffc0206f8a:	2785                	addiw	a5,a5,1
ffffffffc0206f8c:	4581                	li	a1,0
ffffffffc0206f8e:	fffff517          	auipc	a0,0xfffff
ffffffffc0206f92:	38e50513          	addi	a0,a0,910 # ffffffffc020631c <init_main>
ffffffffc0206f96:	c31c                	sw	a5,0(a4)
ffffffffc0206f98:	00090797          	auipc	a5,0x90
ffffffffc0206f9c:	92d7b423          	sd	a3,-1752(a5) # ffffffffc02968c0 <current>
ffffffffc0206fa0:	80cff0ef          	jal	ra,ffffffffc0205fac <kernel_thread>
ffffffffc0206fa4:	842a                	mv	s0,a0
ffffffffc0206fa6:	08a05363          	blez	a0,ffffffffc020702c <proc_init+0x144>
ffffffffc0206faa:	6789                	lui	a5,0x2
ffffffffc0206fac:	fff5071b          	addiw	a4,a0,-1
ffffffffc0206fb0:	17f9                	addi	a5,a5,-2
ffffffffc0206fb2:	2501                	sext.w	a0,a0
ffffffffc0206fb4:	02e7e363          	bltu	a5,a4,ffffffffc0206fda <proc_init+0xf2>
ffffffffc0206fb8:	45a9                	li	a1,10
ffffffffc0206fba:	078040ef          	jal	ra,ffffffffc020b032 <hash32>
ffffffffc0206fbe:	02051793          	slli	a5,a0,0x20
ffffffffc0206fc2:	01c7d693          	srli	a3,a5,0x1c
ffffffffc0206fc6:	96a6                	add	a3,a3,s1
ffffffffc0206fc8:	87b6                	mv	a5,a3
ffffffffc0206fca:	a029                	j	ffffffffc0206fd4 <proc_init+0xec>
ffffffffc0206fcc:	f2c7a703          	lw	a4,-212(a5) # 1f2c <_binary_bin_swap_img_size-0x5dd4>
ffffffffc0206fd0:	04870b63          	beq	a4,s0,ffffffffc0207026 <proc_init+0x13e>
ffffffffc0206fd4:	679c                	ld	a5,8(a5)
ffffffffc0206fd6:	fef69be3          	bne	a3,a5,ffffffffc0206fcc <proc_init+0xe4>
ffffffffc0206fda:	4781                	li	a5,0
ffffffffc0206fdc:	0b478493          	addi	s1,a5,180
ffffffffc0206fe0:	4641                	li	a2,16
ffffffffc0206fe2:	4581                	li	a1,0
ffffffffc0206fe4:	00090417          	auipc	s0,0x90
ffffffffc0206fe8:	8ec40413          	addi	s0,s0,-1812 # ffffffffc02968d0 <initproc>
ffffffffc0206fec:	8526                	mv	a0,s1
ffffffffc0206fee:	e01c                	sd	a5,0(s0)
ffffffffc0206ff0:	576040ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc0206ff4:	463d                	li	a2,15
ffffffffc0206ff6:	00007597          	auipc	a1,0x7
ffffffffc0206ffa:	93a58593          	addi	a1,a1,-1734 # ffffffffc020d930 <CSWTCH.79+0x4d8>
ffffffffc0206ffe:	8526                	mv	a0,s1
ffffffffc0207000:	5b8040ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc0207004:	00093783          	ld	a5,0(s2)
ffffffffc0207008:	c7d1                	beqz	a5,ffffffffc0207094 <proc_init+0x1ac>
ffffffffc020700a:	43dc                	lw	a5,4(a5)
ffffffffc020700c:	e7c1                	bnez	a5,ffffffffc0207094 <proc_init+0x1ac>
ffffffffc020700e:	601c                	ld	a5,0(s0)
ffffffffc0207010:	c3b5                	beqz	a5,ffffffffc0207074 <proc_init+0x18c>
ffffffffc0207012:	43d8                	lw	a4,4(a5)
ffffffffc0207014:	4785                	li	a5,1
ffffffffc0207016:	04f71f63          	bne	a4,a5,ffffffffc0207074 <proc_init+0x18c>
ffffffffc020701a:	60e2                	ld	ra,24(sp)
ffffffffc020701c:	6442                	ld	s0,16(sp)
ffffffffc020701e:	64a2                	ld	s1,8(sp)
ffffffffc0207020:	6902                	ld	s2,0(sp)
ffffffffc0207022:	6105                	addi	sp,sp,32
ffffffffc0207024:	8082                	ret
ffffffffc0207026:	f2878793          	addi	a5,a5,-216
ffffffffc020702a:	bf4d                	j	ffffffffc0206fdc <proc_init+0xf4>
ffffffffc020702c:	00007617          	auipc	a2,0x7
ffffffffc0207030:	8e460613          	addi	a2,a2,-1820 # ffffffffc020d910 <CSWTCH.79+0x4b8>
ffffffffc0207034:	4f800593          	li	a1,1272
ffffffffc0207038:	00006517          	auipc	a0,0x6
ffffffffc020703c:	53050513          	addi	a0,a0,1328 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0207040:	c5ef90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207044:	00007617          	auipc	a2,0x7
ffffffffc0207048:	89c60613          	addi	a2,a2,-1892 # ffffffffc020d8e0 <CSWTCH.79+0x488>
ffffffffc020704c:	4ec00593          	li	a1,1260
ffffffffc0207050:	00006517          	auipc	a0,0x6
ffffffffc0207054:	51850513          	addi	a0,a0,1304 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0207058:	c46f90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020705c:	00007617          	auipc	a2,0x7
ffffffffc0207060:	86c60613          	addi	a2,a2,-1940 # ffffffffc020d8c8 <CSWTCH.79+0x470>
ffffffffc0207064:	4e200593          	li	a1,1250
ffffffffc0207068:	00006517          	auipc	a0,0x6
ffffffffc020706c:	50050513          	addi	a0,a0,1280 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0207070:	c2ef90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207074:	00007697          	auipc	a3,0x7
ffffffffc0207078:	8ec68693          	addi	a3,a3,-1812 # ffffffffc020d960 <CSWTCH.79+0x508>
ffffffffc020707c:	00005617          	auipc	a2,0x5
ffffffffc0207080:	9cc60613          	addi	a2,a2,-1588 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207084:	4ff00593          	li	a1,1279
ffffffffc0207088:	00006517          	auipc	a0,0x6
ffffffffc020708c:	4e050513          	addi	a0,a0,1248 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc0207090:	c0ef90ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207094:	00007697          	auipc	a3,0x7
ffffffffc0207098:	8a468693          	addi	a3,a3,-1884 # ffffffffc020d938 <CSWTCH.79+0x4e0>
ffffffffc020709c:	00005617          	auipc	a2,0x5
ffffffffc02070a0:	9ac60613          	addi	a2,a2,-1620 # ffffffffc020ba48 <commands+0x210>
ffffffffc02070a4:	4fe00593          	li	a1,1278
ffffffffc02070a8:	00006517          	auipc	a0,0x6
ffffffffc02070ac:	4c050513          	addi	a0,a0,1216 # ffffffffc020d568 <CSWTCH.79+0x110>
ffffffffc02070b0:	beef90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02070b4 <cpu_idle>:
ffffffffc02070b4:	1141                	addi	sp,sp,-16
ffffffffc02070b6:	e022                	sd	s0,0(sp)
ffffffffc02070b8:	e406                	sd	ra,8(sp)
ffffffffc02070ba:	00090417          	auipc	s0,0x90
ffffffffc02070be:	80640413          	addi	s0,s0,-2042 # ffffffffc02968c0 <current>
ffffffffc02070c2:	6018                	ld	a4,0(s0)
ffffffffc02070c4:	6f1c                	ld	a5,24(a4)
ffffffffc02070c6:	dffd                	beqz	a5,ffffffffc02070c4 <cpu_idle+0x10>
ffffffffc02070c8:	31a000ef          	jal	ra,ffffffffc02073e2 <schedule>
ffffffffc02070cc:	bfdd                	j	ffffffffc02070c2 <cpu_idle+0xe>

ffffffffc02070ce <lab6_set_priority>:
ffffffffc02070ce:	1141                	addi	sp,sp,-16
ffffffffc02070d0:	e022                	sd	s0,0(sp)
ffffffffc02070d2:	85aa                	mv	a1,a0
ffffffffc02070d4:	842a                	mv	s0,a0
ffffffffc02070d6:	00007517          	auipc	a0,0x7
ffffffffc02070da:	8b250513          	addi	a0,a0,-1870 # ffffffffc020d988 <CSWTCH.79+0x530>
ffffffffc02070de:	e406                	sd	ra,8(sp)
ffffffffc02070e0:	8c6f90ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02070e4:	0008f797          	auipc	a5,0x8f
ffffffffc02070e8:	7dc7b783          	ld	a5,2012(a5) # ffffffffc02968c0 <current>
ffffffffc02070ec:	e801                	bnez	s0,ffffffffc02070fc <lab6_set_priority+0x2e>
ffffffffc02070ee:	60a2                	ld	ra,8(sp)
ffffffffc02070f0:	6402                	ld	s0,0(sp)
ffffffffc02070f2:	4705                	li	a4,1
ffffffffc02070f4:	14e7a223          	sw	a4,324(a5)
ffffffffc02070f8:	0141                	addi	sp,sp,16
ffffffffc02070fa:	8082                	ret
ffffffffc02070fc:	60a2                	ld	ra,8(sp)
ffffffffc02070fe:	1487a223          	sw	s0,324(a5)
ffffffffc0207102:	6402                	ld	s0,0(sp)
ffffffffc0207104:	0141                	addi	sp,sp,16
ffffffffc0207106:	8082                	ret

ffffffffc0207108 <do_sleep>:
ffffffffc0207108:	c539                	beqz	a0,ffffffffc0207156 <do_sleep+0x4e>
ffffffffc020710a:	7179                	addi	sp,sp,-48
ffffffffc020710c:	f022                	sd	s0,32(sp)
ffffffffc020710e:	f406                	sd	ra,40(sp)
ffffffffc0207110:	842a                	mv	s0,a0
ffffffffc0207112:	100027f3          	csrr	a5,sstatus
ffffffffc0207116:	8b89                	andi	a5,a5,2
ffffffffc0207118:	e3a9                	bnez	a5,ffffffffc020715a <do_sleep+0x52>
ffffffffc020711a:	0008f797          	auipc	a5,0x8f
ffffffffc020711e:	7a67b783          	ld	a5,1958(a5) # ffffffffc02968c0 <current>
ffffffffc0207122:	0818                	addi	a4,sp,16
ffffffffc0207124:	c02a                	sw	a0,0(sp)
ffffffffc0207126:	ec3a                	sd	a4,24(sp)
ffffffffc0207128:	e83a                	sd	a4,16(sp)
ffffffffc020712a:	e43e                	sd	a5,8(sp)
ffffffffc020712c:	4705                	li	a4,1
ffffffffc020712e:	c398                	sw	a4,0(a5)
ffffffffc0207130:	80000737          	lui	a4,0x80000
ffffffffc0207134:	840a                	mv	s0,sp
ffffffffc0207136:	0709                	addi	a4,a4,2
ffffffffc0207138:	0ee7a623          	sw	a4,236(a5)
ffffffffc020713c:	8522                	mv	a0,s0
ffffffffc020713e:	364000ef          	jal	ra,ffffffffc02074a2 <add_timer>
ffffffffc0207142:	2a0000ef          	jal	ra,ffffffffc02073e2 <schedule>
ffffffffc0207146:	8522                	mv	a0,s0
ffffffffc0207148:	422000ef          	jal	ra,ffffffffc020756a <del_timer>
ffffffffc020714c:	70a2                	ld	ra,40(sp)
ffffffffc020714e:	7402                	ld	s0,32(sp)
ffffffffc0207150:	4501                	li	a0,0
ffffffffc0207152:	6145                	addi	sp,sp,48
ffffffffc0207154:	8082                	ret
ffffffffc0207156:	4501                	li	a0,0
ffffffffc0207158:	8082                	ret
ffffffffc020715a:	b19f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020715e:	0008f797          	auipc	a5,0x8f
ffffffffc0207162:	7627b783          	ld	a5,1890(a5) # ffffffffc02968c0 <current>
ffffffffc0207166:	0818                	addi	a4,sp,16
ffffffffc0207168:	c022                	sw	s0,0(sp)
ffffffffc020716a:	e43e                	sd	a5,8(sp)
ffffffffc020716c:	ec3a                	sd	a4,24(sp)
ffffffffc020716e:	e83a                	sd	a4,16(sp)
ffffffffc0207170:	4705                	li	a4,1
ffffffffc0207172:	c398                	sw	a4,0(a5)
ffffffffc0207174:	80000737          	lui	a4,0x80000
ffffffffc0207178:	0709                	addi	a4,a4,2
ffffffffc020717a:	840a                	mv	s0,sp
ffffffffc020717c:	8522                	mv	a0,s0
ffffffffc020717e:	0ee7a623          	sw	a4,236(a5)
ffffffffc0207182:	320000ef          	jal	ra,ffffffffc02074a2 <add_timer>
ffffffffc0207186:	ae7f90ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc020718a:	bf65                	j	ffffffffc0207142 <do_sleep+0x3a>

ffffffffc020718c <switch_to>:
ffffffffc020718c:	00153023          	sd	ra,0(a0)
ffffffffc0207190:	00253423          	sd	sp,8(a0)
ffffffffc0207194:	e900                	sd	s0,16(a0)
ffffffffc0207196:	ed04                	sd	s1,24(a0)
ffffffffc0207198:	03253023          	sd	s2,32(a0)
ffffffffc020719c:	03353423          	sd	s3,40(a0)
ffffffffc02071a0:	03453823          	sd	s4,48(a0)
ffffffffc02071a4:	03553c23          	sd	s5,56(a0)
ffffffffc02071a8:	05653023          	sd	s6,64(a0)
ffffffffc02071ac:	05753423          	sd	s7,72(a0)
ffffffffc02071b0:	05853823          	sd	s8,80(a0)
ffffffffc02071b4:	05953c23          	sd	s9,88(a0)
ffffffffc02071b8:	07a53023          	sd	s10,96(a0)
ffffffffc02071bc:	07b53423          	sd	s11,104(a0)
ffffffffc02071c0:	0005b083          	ld	ra,0(a1)
ffffffffc02071c4:	0085b103          	ld	sp,8(a1)
ffffffffc02071c8:	6980                	ld	s0,16(a1)
ffffffffc02071ca:	6d84                	ld	s1,24(a1)
ffffffffc02071cc:	0205b903          	ld	s2,32(a1)
ffffffffc02071d0:	0285b983          	ld	s3,40(a1)
ffffffffc02071d4:	0305ba03          	ld	s4,48(a1)
ffffffffc02071d8:	0385ba83          	ld	s5,56(a1)
ffffffffc02071dc:	0405bb03          	ld	s6,64(a1)
ffffffffc02071e0:	0485bb83          	ld	s7,72(a1)
ffffffffc02071e4:	0505bc03          	ld	s8,80(a1)
ffffffffc02071e8:	0585bc83          	ld	s9,88(a1)
ffffffffc02071ec:	0605bd03          	ld	s10,96(a1)
ffffffffc02071f0:	0685bd83          	ld	s11,104(a1)
ffffffffc02071f4:	8082                	ret

ffffffffc02071f6 <RR_init>:
ffffffffc02071f6:	e508                	sd	a0,8(a0)
ffffffffc02071f8:	e108                	sd	a0,0(a0)
ffffffffc02071fa:	00052823          	sw	zero,16(a0)
ffffffffc02071fe:	8082                	ret

ffffffffc0207200 <RR_pick_next>:
ffffffffc0207200:	651c                	ld	a5,8(a0)
ffffffffc0207202:	00f50563          	beq	a0,a5,ffffffffc020720c <RR_pick_next+0xc>
ffffffffc0207206:	ef078513          	addi	a0,a5,-272
ffffffffc020720a:	8082                	ret
ffffffffc020720c:	4501                	li	a0,0
ffffffffc020720e:	8082                	ret

ffffffffc0207210 <RR_proc_tick>:
ffffffffc0207210:	1205a783          	lw	a5,288(a1)
ffffffffc0207214:	00f05563          	blez	a5,ffffffffc020721e <RR_proc_tick+0xe>
ffffffffc0207218:	37fd                	addiw	a5,a5,-1
ffffffffc020721a:	12f5a023          	sw	a5,288(a1)
ffffffffc020721e:	e399                	bnez	a5,ffffffffc0207224 <RR_proc_tick+0x14>
ffffffffc0207220:	4785                	li	a5,1
ffffffffc0207222:	ed9c                	sd	a5,24(a1)
ffffffffc0207224:	8082                	ret

ffffffffc0207226 <RR_dequeue>:
ffffffffc0207226:	1185b703          	ld	a4,280(a1)
ffffffffc020722a:	11058793          	addi	a5,a1,272
ffffffffc020722e:	02e78363          	beq	a5,a4,ffffffffc0207254 <RR_dequeue+0x2e>
ffffffffc0207232:	1085b683          	ld	a3,264(a1)
ffffffffc0207236:	00a69f63          	bne	a3,a0,ffffffffc0207254 <RR_dequeue+0x2e>
ffffffffc020723a:	1105b503          	ld	a0,272(a1)
ffffffffc020723e:	4a90                	lw	a2,16(a3)
ffffffffc0207240:	e518                	sd	a4,8(a0)
ffffffffc0207242:	e308                	sd	a0,0(a4)
ffffffffc0207244:	10f5bc23          	sd	a5,280(a1)
ffffffffc0207248:	10f5b823          	sd	a5,272(a1)
ffffffffc020724c:	fff6079b          	addiw	a5,a2,-1
ffffffffc0207250:	ca9c                	sw	a5,16(a3)
ffffffffc0207252:	8082                	ret
ffffffffc0207254:	1141                	addi	sp,sp,-16
ffffffffc0207256:	00006697          	auipc	a3,0x6
ffffffffc020725a:	74a68693          	addi	a3,a3,1866 # ffffffffc020d9a0 <CSWTCH.79+0x548>
ffffffffc020725e:	00004617          	auipc	a2,0x4
ffffffffc0207262:	7ea60613          	addi	a2,a2,2026 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207266:	03c00593          	li	a1,60
ffffffffc020726a:	00006517          	auipc	a0,0x6
ffffffffc020726e:	76e50513          	addi	a0,a0,1902 # ffffffffc020d9d8 <CSWTCH.79+0x580>
ffffffffc0207272:	e406                	sd	ra,8(sp)
ffffffffc0207274:	a2af90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207278 <RR_enqueue>:
ffffffffc0207278:	1185b703          	ld	a4,280(a1)
ffffffffc020727c:	11058793          	addi	a5,a1,272
ffffffffc0207280:	02e79d63          	bne	a5,a4,ffffffffc02072ba <RR_enqueue+0x42>
ffffffffc0207284:	6118                	ld	a4,0(a0)
ffffffffc0207286:	1205a683          	lw	a3,288(a1)
ffffffffc020728a:	e11c                	sd	a5,0(a0)
ffffffffc020728c:	e71c                	sd	a5,8(a4)
ffffffffc020728e:	10a5bc23          	sd	a0,280(a1)
ffffffffc0207292:	10e5b823          	sd	a4,272(a1)
ffffffffc0207296:	495c                	lw	a5,20(a0)
ffffffffc0207298:	ea89                	bnez	a3,ffffffffc02072aa <RR_enqueue+0x32>
ffffffffc020729a:	12f5a023          	sw	a5,288(a1)
ffffffffc020729e:	491c                	lw	a5,16(a0)
ffffffffc02072a0:	10a5b423          	sd	a0,264(a1)
ffffffffc02072a4:	2785                	addiw	a5,a5,1
ffffffffc02072a6:	c91c                	sw	a5,16(a0)
ffffffffc02072a8:	8082                	ret
ffffffffc02072aa:	fed7c8e3          	blt	a5,a3,ffffffffc020729a <RR_enqueue+0x22>
ffffffffc02072ae:	491c                	lw	a5,16(a0)
ffffffffc02072b0:	10a5b423          	sd	a0,264(a1)
ffffffffc02072b4:	2785                	addiw	a5,a5,1
ffffffffc02072b6:	c91c                	sw	a5,16(a0)
ffffffffc02072b8:	8082                	ret
ffffffffc02072ba:	1141                	addi	sp,sp,-16
ffffffffc02072bc:	00006697          	auipc	a3,0x6
ffffffffc02072c0:	73c68693          	addi	a3,a3,1852 # ffffffffc020d9f8 <CSWTCH.79+0x5a0>
ffffffffc02072c4:	00004617          	auipc	a2,0x4
ffffffffc02072c8:	78460613          	addi	a2,a2,1924 # ffffffffc020ba48 <commands+0x210>
ffffffffc02072cc:	02800593          	li	a1,40
ffffffffc02072d0:	00006517          	auipc	a0,0x6
ffffffffc02072d4:	70850513          	addi	a0,a0,1800 # ffffffffc020d9d8 <CSWTCH.79+0x580>
ffffffffc02072d8:	e406                	sd	ra,8(sp)
ffffffffc02072da:	9c4f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02072de <sched_init>:
ffffffffc02072de:	1141                	addi	sp,sp,-16
ffffffffc02072e0:	0008a717          	auipc	a4,0x8a
ffffffffc02072e4:	d4070713          	addi	a4,a4,-704 # ffffffffc0291020 <default_sched_class>
ffffffffc02072e8:	e022                	sd	s0,0(sp)
ffffffffc02072ea:	e406                	sd	ra,8(sp)
ffffffffc02072ec:	0008e797          	auipc	a5,0x8e
ffffffffc02072f0:	50478793          	addi	a5,a5,1284 # ffffffffc02957f0 <timer_list>
ffffffffc02072f4:	6714                	ld	a3,8(a4)
ffffffffc02072f6:	0008e517          	auipc	a0,0x8e
ffffffffc02072fa:	4da50513          	addi	a0,a0,1242 # ffffffffc02957d0 <__rq>
ffffffffc02072fe:	e79c                	sd	a5,8(a5)
ffffffffc0207300:	e39c                	sd	a5,0(a5)
ffffffffc0207302:	4795                	li	a5,5
ffffffffc0207304:	c95c                	sw	a5,20(a0)
ffffffffc0207306:	0008f417          	auipc	s0,0x8f
ffffffffc020730a:	5e240413          	addi	s0,s0,1506 # ffffffffc02968e8 <sched_class>
ffffffffc020730e:	0008f797          	auipc	a5,0x8f
ffffffffc0207312:	5ca7b923          	sd	a0,1490(a5) # ffffffffc02968e0 <rq>
ffffffffc0207316:	e018                	sd	a4,0(s0)
ffffffffc0207318:	9682                	jalr	a3
ffffffffc020731a:	601c                	ld	a5,0(s0)
ffffffffc020731c:	6402                	ld	s0,0(sp)
ffffffffc020731e:	60a2                	ld	ra,8(sp)
ffffffffc0207320:	638c                	ld	a1,0(a5)
ffffffffc0207322:	00006517          	auipc	a0,0x6
ffffffffc0207326:	70650513          	addi	a0,a0,1798 # ffffffffc020da28 <CSWTCH.79+0x5d0>
ffffffffc020732a:	0141                	addi	sp,sp,16
ffffffffc020732c:	e7bf806f          	j	ffffffffc02001a6 <cprintf>

ffffffffc0207330 <wakeup_proc>:
ffffffffc0207330:	4118                	lw	a4,0(a0)
ffffffffc0207332:	1101                	addi	sp,sp,-32
ffffffffc0207334:	ec06                	sd	ra,24(sp)
ffffffffc0207336:	e822                	sd	s0,16(sp)
ffffffffc0207338:	e426                	sd	s1,8(sp)
ffffffffc020733a:	478d                	li	a5,3
ffffffffc020733c:	08f70363          	beq	a4,a5,ffffffffc02073c2 <wakeup_proc+0x92>
ffffffffc0207340:	842a                	mv	s0,a0
ffffffffc0207342:	100027f3          	csrr	a5,sstatus
ffffffffc0207346:	8b89                	andi	a5,a5,2
ffffffffc0207348:	4481                	li	s1,0
ffffffffc020734a:	e7bd                	bnez	a5,ffffffffc02073b8 <wakeup_proc+0x88>
ffffffffc020734c:	4789                	li	a5,2
ffffffffc020734e:	04f70863          	beq	a4,a5,ffffffffc020739e <wakeup_proc+0x6e>
ffffffffc0207352:	c01c                	sw	a5,0(s0)
ffffffffc0207354:	0e042623          	sw	zero,236(s0)
ffffffffc0207358:	0008f797          	auipc	a5,0x8f
ffffffffc020735c:	5687b783          	ld	a5,1384(a5) # ffffffffc02968c0 <current>
ffffffffc0207360:	02878363          	beq	a5,s0,ffffffffc0207386 <wakeup_proc+0x56>
ffffffffc0207364:	0008f797          	auipc	a5,0x8f
ffffffffc0207368:	5647b783          	ld	a5,1380(a5) # ffffffffc02968c8 <idleproc>
ffffffffc020736c:	00f40d63          	beq	s0,a5,ffffffffc0207386 <wakeup_proc+0x56>
ffffffffc0207370:	0008f797          	auipc	a5,0x8f
ffffffffc0207374:	5787b783          	ld	a5,1400(a5) # ffffffffc02968e8 <sched_class>
ffffffffc0207378:	6b9c                	ld	a5,16(a5)
ffffffffc020737a:	85a2                	mv	a1,s0
ffffffffc020737c:	0008f517          	auipc	a0,0x8f
ffffffffc0207380:	56453503          	ld	a0,1380(a0) # ffffffffc02968e0 <rq>
ffffffffc0207384:	9782                	jalr	a5
ffffffffc0207386:	e491                	bnez	s1,ffffffffc0207392 <wakeup_proc+0x62>
ffffffffc0207388:	60e2                	ld	ra,24(sp)
ffffffffc020738a:	6442                	ld	s0,16(sp)
ffffffffc020738c:	64a2                	ld	s1,8(sp)
ffffffffc020738e:	6105                	addi	sp,sp,32
ffffffffc0207390:	8082                	ret
ffffffffc0207392:	6442                	ld	s0,16(sp)
ffffffffc0207394:	60e2                	ld	ra,24(sp)
ffffffffc0207396:	64a2                	ld	s1,8(sp)
ffffffffc0207398:	6105                	addi	sp,sp,32
ffffffffc020739a:	8d3f906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc020739e:	00006617          	auipc	a2,0x6
ffffffffc02073a2:	6da60613          	addi	a2,a2,1754 # ffffffffc020da78 <CSWTCH.79+0x620>
ffffffffc02073a6:	05200593          	li	a1,82
ffffffffc02073aa:	00006517          	auipc	a0,0x6
ffffffffc02073ae:	6b650513          	addi	a0,a0,1718 # ffffffffc020da60 <CSWTCH.79+0x608>
ffffffffc02073b2:	954f90ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc02073b6:	bfc1                	j	ffffffffc0207386 <wakeup_proc+0x56>
ffffffffc02073b8:	8bbf90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02073bc:	4018                	lw	a4,0(s0)
ffffffffc02073be:	4485                	li	s1,1
ffffffffc02073c0:	b771                	j	ffffffffc020734c <wakeup_proc+0x1c>
ffffffffc02073c2:	00006697          	auipc	a3,0x6
ffffffffc02073c6:	67e68693          	addi	a3,a3,1662 # ffffffffc020da40 <CSWTCH.79+0x5e8>
ffffffffc02073ca:	00004617          	auipc	a2,0x4
ffffffffc02073ce:	67e60613          	addi	a2,a2,1662 # ffffffffc020ba48 <commands+0x210>
ffffffffc02073d2:	04300593          	li	a1,67
ffffffffc02073d6:	00006517          	auipc	a0,0x6
ffffffffc02073da:	68a50513          	addi	a0,a0,1674 # ffffffffc020da60 <CSWTCH.79+0x608>
ffffffffc02073de:	8c0f90ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02073e2 <schedule>:
ffffffffc02073e2:	7179                	addi	sp,sp,-48
ffffffffc02073e4:	f406                	sd	ra,40(sp)
ffffffffc02073e6:	f022                	sd	s0,32(sp)
ffffffffc02073e8:	ec26                	sd	s1,24(sp)
ffffffffc02073ea:	e84a                	sd	s2,16(sp)
ffffffffc02073ec:	e44e                	sd	s3,8(sp)
ffffffffc02073ee:	e052                	sd	s4,0(sp)
ffffffffc02073f0:	100027f3          	csrr	a5,sstatus
ffffffffc02073f4:	8b89                	andi	a5,a5,2
ffffffffc02073f6:	4a01                	li	s4,0
ffffffffc02073f8:	e3cd                	bnez	a5,ffffffffc020749a <schedule+0xb8>
ffffffffc02073fa:	0008f497          	auipc	s1,0x8f
ffffffffc02073fe:	4c648493          	addi	s1,s1,1222 # ffffffffc02968c0 <current>
ffffffffc0207402:	608c                	ld	a1,0(s1)
ffffffffc0207404:	0008f997          	auipc	s3,0x8f
ffffffffc0207408:	4e498993          	addi	s3,s3,1252 # ffffffffc02968e8 <sched_class>
ffffffffc020740c:	0008f917          	auipc	s2,0x8f
ffffffffc0207410:	4d490913          	addi	s2,s2,1236 # ffffffffc02968e0 <rq>
ffffffffc0207414:	4194                	lw	a3,0(a1)
ffffffffc0207416:	0005bc23          	sd	zero,24(a1)
ffffffffc020741a:	4709                	li	a4,2
ffffffffc020741c:	0009b783          	ld	a5,0(s3)
ffffffffc0207420:	00093503          	ld	a0,0(s2)
ffffffffc0207424:	04e68e63          	beq	a3,a4,ffffffffc0207480 <schedule+0x9e>
ffffffffc0207428:	739c                	ld	a5,32(a5)
ffffffffc020742a:	9782                	jalr	a5
ffffffffc020742c:	842a                	mv	s0,a0
ffffffffc020742e:	c521                	beqz	a0,ffffffffc0207476 <schedule+0x94>
ffffffffc0207430:	0009b783          	ld	a5,0(s3)
ffffffffc0207434:	00093503          	ld	a0,0(s2)
ffffffffc0207438:	85a2                	mv	a1,s0
ffffffffc020743a:	6f9c                	ld	a5,24(a5)
ffffffffc020743c:	9782                	jalr	a5
ffffffffc020743e:	441c                	lw	a5,8(s0)
ffffffffc0207440:	6098                	ld	a4,0(s1)
ffffffffc0207442:	2785                	addiw	a5,a5,1
ffffffffc0207444:	c41c                	sw	a5,8(s0)
ffffffffc0207446:	00870563          	beq	a4,s0,ffffffffc0207450 <schedule+0x6e>
ffffffffc020744a:	8522                	mv	a0,s0
ffffffffc020744c:	ecafe0ef          	jal	ra,ffffffffc0205b16 <proc_run>
ffffffffc0207450:	000a1a63          	bnez	s4,ffffffffc0207464 <schedule+0x82>
ffffffffc0207454:	70a2                	ld	ra,40(sp)
ffffffffc0207456:	7402                	ld	s0,32(sp)
ffffffffc0207458:	64e2                	ld	s1,24(sp)
ffffffffc020745a:	6942                	ld	s2,16(sp)
ffffffffc020745c:	69a2                	ld	s3,8(sp)
ffffffffc020745e:	6a02                	ld	s4,0(sp)
ffffffffc0207460:	6145                	addi	sp,sp,48
ffffffffc0207462:	8082                	ret
ffffffffc0207464:	7402                	ld	s0,32(sp)
ffffffffc0207466:	70a2                	ld	ra,40(sp)
ffffffffc0207468:	64e2                	ld	s1,24(sp)
ffffffffc020746a:	6942                	ld	s2,16(sp)
ffffffffc020746c:	69a2                	ld	s3,8(sp)
ffffffffc020746e:	6a02                	ld	s4,0(sp)
ffffffffc0207470:	6145                	addi	sp,sp,48
ffffffffc0207472:	ffaf906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0207476:	0008f417          	auipc	s0,0x8f
ffffffffc020747a:	45243403          	ld	s0,1106(s0) # ffffffffc02968c8 <idleproc>
ffffffffc020747e:	b7c1                	j	ffffffffc020743e <schedule+0x5c>
ffffffffc0207480:	0008f717          	auipc	a4,0x8f
ffffffffc0207484:	44873703          	ld	a4,1096(a4) # ffffffffc02968c8 <idleproc>
ffffffffc0207488:	fae580e3          	beq	a1,a4,ffffffffc0207428 <schedule+0x46>
ffffffffc020748c:	6b9c                	ld	a5,16(a5)
ffffffffc020748e:	9782                	jalr	a5
ffffffffc0207490:	0009b783          	ld	a5,0(s3)
ffffffffc0207494:	00093503          	ld	a0,0(s2)
ffffffffc0207498:	bf41                	j	ffffffffc0207428 <schedule+0x46>
ffffffffc020749a:	fd8f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc020749e:	4a05                	li	s4,1
ffffffffc02074a0:	bfa9                	j	ffffffffc02073fa <schedule+0x18>

ffffffffc02074a2 <add_timer>:
ffffffffc02074a2:	1141                	addi	sp,sp,-16
ffffffffc02074a4:	e022                	sd	s0,0(sp)
ffffffffc02074a6:	e406                	sd	ra,8(sp)
ffffffffc02074a8:	842a                	mv	s0,a0
ffffffffc02074aa:	100027f3          	csrr	a5,sstatus
ffffffffc02074ae:	8b89                	andi	a5,a5,2
ffffffffc02074b0:	4501                	li	a0,0
ffffffffc02074b2:	eba5                	bnez	a5,ffffffffc0207522 <add_timer+0x80>
ffffffffc02074b4:	401c                	lw	a5,0(s0)
ffffffffc02074b6:	cbb5                	beqz	a5,ffffffffc020752a <add_timer+0x88>
ffffffffc02074b8:	6418                	ld	a4,8(s0)
ffffffffc02074ba:	cb25                	beqz	a4,ffffffffc020752a <add_timer+0x88>
ffffffffc02074bc:	6c18                	ld	a4,24(s0)
ffffffffc02074be:	01040593          	addi	a1,s0,16
ffffffffc02074c2:	08e59463          	bne	a1,a4,ffffffffc020754a <add_timer+0xa8>
ffffffffc02074c6:	0008e617          	auipc	a2,0x8e
ffffffffc02074ca:	32a60613          	addi	a2,a2,810 # ffffffffc02957f0 <timer_list>
ffffffffc02074ce:	6618                	ld	a4,8(a2)
ffffffffc02074d0:	00c71863          	bne	a4,a2,ffffffffc02074e0 <add_timer+0x3e>
ffffffffc02074d4:	a80d                	j	ffffffffc0207506 <add_timer+0x64>
ffffffffc02074d6:	6718                	ld	a4,8(a4)
ffffffffc02074d8:	9f95                	subw	a5,a5,a3
ffffffffc02074da:	c01c                	sw	a5,0(s0)
ffffffffc02074dc:	02c70563          	beq	a4,a2,ffffffffc0207506 <add_timer+0x64>
ffffffffc02074e0:	ff072683          	lw	a3,-16(a4)
ffffffffc02074e4:	fed7f9e3          	bgeu	a5,a3,ffffffffc02074d6 <add_timer+0x34>
ffffffffc02074e8:	40f687bb          	subw	a5,a3,a5
ffffffffc02074ec:	fef72823          	sw	a5,-16(a4)
ffffffffc02074f0:	631c                	ld	a5,0(a4)
ffffffffc02074f2:	e30c                	sd	a1,0(a4)
ffffffffc02074f4:	e78c                	sd	a1,8(a5)
ffffffffc02074f6:	ec18                	sd	a4,24(s0)
ffffffffc02074f8:	e81c                	sd	a5,16(s0)
ffffffffc02074fa:	c105                	beqz	a0,ffffffffc020751a <add_timer+0x78>
ffffffffc02074fc:	6402                	ld	s0,0(sp)
ffffffffc02074fe:	60a2                	ld	ra,8(sp)
ffffffffc0207500:	0141                	addi	sp,sp,16
ffffffffc0207502:	f6af906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0207506:	0008e717          	auipc	a4,0x8e
ffffffffc020750a:	2ea70713          	addi	a4,a4,746 # ffffffffc02957f0 <timer_list>
ffffffffc020750e:	631c                	ld	a5,0(a4)
ffffffffc0207510:	e30c                	sd	a1,0(a4)
ffffffffc0207512:	e78c                	sd	a1,8(a5)
ffffffffc0207514:	ec18                	sd	a4,24(s0)
ffffffffc0207516:	e81c                	sd	a5,16(s0)
ffffffffc0207518:	f175                	bnez	a0,ffffffffc02074fc <add_timer+0x5a>
ffffffffc020751a:	60a2                	ld	ra,8(sp)
ffffffffc020751c:	6402                	ld	s0,0(sp)
ffffffffc020751e:	0141                	addi	sp,sp,16
ffffffffc0207520:	8082                	ret
ffffffffc0207522:	f50f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0207526:	4505                	li	a0,1
ffffffffc0207528:	b771                	j	ffffffffc02074b4 <add_timer+0x12>
ffffffffc020752a:	00006697          	auipc	a3,0x6
ffffffffc020752e:	56e68693          	addi	a3,a3,1390 # ffffffffc020da98 <CSWTCH.79+0x640>
ffffffffc0207532:	00004617          	auipc	a2,0x4
ffffffffc0207536:	51660613          	addi	a2,a2,1302 # ffffffffc020ba48 <commands+0x210>
ffffffffc020753a:	07a00593          	li	a1,122
ffffffffc020753e:	00006517          	auipc	a0,0x6
ffffffffc0207542:	52250513          	addi	a0,a0,1314 # ffffffffc020da60 <CSWTCH.79+0x608>
ffffffffc0207546:	f59f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020754a:	00006697          	auipc	a3,0x6
ffffffffc020754e:	57e68693          	addi	a3,a3,1406 # ffffffffc020dac8 <CSWTCH.79+0x670>
ffffffffc0207552:	00004617          	auipc	a2,0x4
ffffffffc0207556:	4f660613          	addi	a2,a2,1270 # ffffffffc020ba48 <commands+0x210>
ffffffffc020755a:	07b00593          	li	a1,123
ffffffffc020755e:	00006517          	auipc	a0,0x6
ffffffffc0207562:	50250513          	addi	a0,a0,1282 # ffffffffc020da60 <CSWTCH.79+0x608>
ffffffffc0207566:	f39f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020756a <del_timer>:
ffffffffc020756a:	1101                	addi	sp,sp,-32
ffffffffc020756c:	e822                	sd	s0,16(sp)
ffffffffc020756e:	ec06                	sd	ra,24(sp)
ffffffffc0207570:	e426                	sd	s1,8(sp)
ffffffffc0207572:	842a                	mv	s0,a0
ffffffffc0207574:	100027f3          	csrr	a5,sstatus
ffffffffc0207578:	8b89                	andi	a5,a5,2
ffffffffc020757a:	01050493          	addi	s1,a0,16
ffffffffc020757e:	eb9d                	bnez	a5,ffffffffc02075b4 <del_timer+0x4a>
ffffffffc0207580:	6d1c                	ld	a5,24(a0)
ffffffffc0207582:	02978463          	beq	a5,s1,ffffffffc02075aa <del_timer+0x40>
ffffffffc0207586:	4114                	lw	a3,0(a0)
ffffffffc0207588:	6918                	ld	a4,16(a0)
ffffffffc020758a:	ce81                	beqz	a3,ffffffffc02075a2 <del_timer+0x38>
ffffffffc020758c:	0008e617          	auipc	a2,0x8e
ffffffffc0207590:	26460613          	addi	a2,a2,612 # ffffffffc02957f0 <timer_list>
ffffffffc0207594:	00c78763          	beq	a5,a2,ffffffffc02075a2 <del_timer+0x38>
ffffffffc0207598:	ff07a603          	lw	a2,-16(a5)
ffffffffc020759c:	9eb1                	addw	a3,a3,a2
ffffffffc020759e:	fed7a823          	sw	a3,-16(a5)
ffffffffc02075a2:	e71c                	sd	a5,8(a4)
ffffffffc02075a4:	e398                	sd	a4,0(a5)
ffffffffc02075a6:	ec04                	sd	s1,24(s0)
ffffffffc02075a8:	e804                	sd	s1,16(s0)
ffffffffc02075aa:	60e2                	ld	ra,24(sp)
ffffffffc02075ac:	6442                	ld	s0,16(sp)
ffffffffc02075ae:	64a2                	ld	s1,8(sp)
ffffffffc02075b0:	6105                	addi	sp,sp,32
ffffffffc02075b2:	8082                	ret
ffffffffc02075b4:	ebef90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02075b8:	6c1c                	ld	a5,24(s0)
ffffffffc02075ba:	02978463          	beq	a5,s1,ffffffffc02075e2 <del_timer+0x78>
ffffffffc02075be:	4014                	lw	a3,0(s0)
ffffffffc02075c0:	6818                	ld	a4,16(s0)
ffffffffc02075c2:	ce81                	beqz	a3,ffffffffc02075da <del_timer+0x70>
ffffffffc02075c4:	0008e617          	auipc	a2,0x8e
ffffffffc02075c8:	22c60613          	addi	a2,a2,556 # ffffffffc02957f0 <timer_list>
ffffffffc02075cc:	00c78763          	beq	a5,a2,ffffffffc02075da <del_timer+0x70>
ffffffffc02075d0:	ff07a603          	lw	a2,-16(a5)
ffffffffc02075d4:	9eb1                	addw	a3,a3,a2
ffffffffc02075d6:	fed7a823          	sw	a3,-16(a5)
ffffffffc02075da:	e71c                	sd	a5,8(a4)
ffffffffc02075dc:	e398                	sd	a4,0(a5)
ffffffffc02075de:	ec04                	sd	s1,24(s0)
ffffffffc02075e0:	e804                	sd	s1,16(s0)
ffffffffc02075e2:	6442                	ld	s0,16(sp)
ffffffffc02075e4:	60e2                	ld	ra,24(sp)
ffffffffc02075e6:	64a2                	ld	s1,8(sp)
ffffffffc02075e8:	6105                	addi	sp,sp,32
ffffffffc02075ea:	e82f906f          	j	ffffffffc0200c6c <intr_enable>

ffffffffc02075ee <run_timer_list>:
ffffffffc02075ee:	7139                	addi	sp,sp,-64
ffffffffc02075f0:	fc06                	sd	ra,56(sp)
ffffffffc02075f2:	f822                	sd	s0,48(sp)
ffffffffc02075f4:	f426                	sd	s1,40(sp)
ffffffffc02075f6:	f04a                	sd	s2,32(sp)
ffffffffc02075f8:	ec4e                	sd	s3,24(sp)
ffffffffc02075fa:	e852                	sd	s4,16(sp)
ffffffffc02075fc:	e456                	sd	s5,8(sp)
ffffffffc02075fe:	e05a                	sd	s6,0(sp)
ffffffffc0207600:	100027f3          	csrr	a5,sstatus
ffffffffc0207604:	8b89                	andi	a5,a5,2
ffffffffc0207606:	4b01                	li	s6,0
ffffffffc0207608:	efe9                	bnez	a5,ffffffffc02076e2 <run_timer_list+0xf4>
ffffffffc020760a:	0008e997          	auipc	s3,0x8e
ffffffffc020760e:	1e698993          	addi	s3,s3,486 # ffffffffc02957f0 <timer_list>
ffffffffc0207612:	0089b403          	ld	s0,8(s3)
ffffffffc0207616:	07340a63          	beq	s0,s3,ffffffffc020768a <run_timer_list+0x9c>
ffffffffc020761a:	ff042783          	lw	a5,-16(s0)
ffffffffc020761e:	ff040913          	addi	s2,s0,-16
ffffffffc0207622:	0e078763          	beqz	a5,ffffffffc0207710 <run_timer_list+0x122>
ffffffffc0207626:	fff7871b          	addiw	a4,a5,-1
ffffffffc020762a:	fee42823          	sw	a4,-16(s0)
ffffffffc020762e:	ef31                	bnez	a4,ffffffffc020768a <run_timer_list+0x9c>
ffffffffc0207630:	00006a97          	auipc	s5,0x6
ffffffffc0207634:	500a8a93          	addi	s5,s5,1280 # ffffffffc020db30 <CSWTCH.79+0x6d8>
ffffffffc0207638:	00006a17          	auipc	s4,0x6
ffffffffc020763c:	428a0a13          	addi	s4,s4,1064 # ffffffffc020da60 <CSWTCH.79+0x608>
ffffffffc0207640:	a005                	j	ffffffffc0207660 <run_timer_list+0x72>
ffffffffc0207642:	0a07d763          	bgez	a5,ffffffffc02076f0 <run_timer_list+0x102>
ffffffffc0207646:	8526                	mv	a0,s1
ffffffffc0207648:	ce9ff0ef          	jal	ra,ffffffffc0207330 <wakeup_proc>
ffffffffc020764c:	854a                	mv	a0,s2
ffffffffc020764e:	f1dff0ef          	jal	ra,ffffffffc020756a <del_timer>
ffffffffc0207652:	03340c63          	beq	s0,s3,ffffffffc020768a <run_timer_list+0x9c>
ffffffffc0207656:	ff042783          	lw	a5,-16(s0)
ffffffffc020765a:	ff040913          	addi	s2,s0,-16
ffffffffc020765e:	e795                	bnez	a5,ffffffffc020768a <run_timer_list+0x9c>
ffffffffc0207660:	00893483          	ld	s1,8(s2)
ffffffffc0207664:	6400                	ld	s0,8(s0)
ffffffffc0207666:	0ec4a783          	lw	a5,236(s1)
ffffffffc020766a:	ffe1                	bnez	a5,ffffffffc0207642 <run_timer_list+0x54>
ffffffffc020766c:	40d4                	lw	a3,4(s1)
ffffffffc020766e:	8656                	mv	a2,s5
ffffffffc0207670:	0ba00593          	li	a1,186
ffffffffc0207674:	8552                	mv	a0,s4
ffffffffc0207676:	e91f80ef          	jal	ra,ffffffffc0200506 <__warn>
ffffffffc020767a:	8526                	mv	a0,s1
ffffffffc020767c:	cb5ff0ef          	jal	ra,ffffffffc0207330 <wakeup_proc>
ffffffffc0207680:	854a                	mv	a0,s2
ffffffffc0207682:	ee9ff0ef          	jal	ra,ffffffffc020756a <del_timer>
ffffffffc0207686:	fd3418e3          	bne	s0,s3,ffffffffc0207656 <run_timer_list+0x68>
ffffffffc020768a:	0008f597          	auipc	a1,0x8f
ffffffffc020768e:	2365b583          	ld	a1,566(a1) # ffffffffc02968c0 <current>
ffffffffc0207692:	c18d                	beqz	a1,ffffffffc02076b4 <run_timer_list+0xc6>
ffffffffc0207694:	0008f797          	auipc	a5,0x8f
ffffffffc0207698:	2347b783          	ld	a5,564(a5) # ffffffffc02968c8 <idleproc>
ffffffffc020769c:	04f58763          	beq	a1,a5,ffffffffc02076ea <run_timer_list+0xfc>
ffffffffc02076a0:	0008f797          	auipc	a5,0x8f
ffffffffc02076a4:	2487b783          	ld	a5,584(a5) # ffffffffc02968e8 <sched_class>
ffffffffc02076a8:	779c                	ld	a5,40(a5)
ffffffffc02076aa:	0008f517          	auipc	a0,0x8f
ffffffffc02076ae:	23653503          	ld	a0,566(a0) # ffffffffc02968e0 <rq>
ffffffffc02076b2:	9782                	jalr	a5
ffffffffc02076b4:	000b1c63          	bnez	s6,ffffffffc02076cc <run_timer_list+0xde>
ffffffffc02076b8:	70e2                	ld	ra,56(sp)
ffffffffc02076ba:	7442                	ld	s0,48(sp)
ffffffffc02076bc:	74a2                	ld	s1,40(sp)
ffffffffc02076be:	7902                	ld	s2,32(sp)
ffffffffc02076c0:	69e2                	ld	s3,24(sp)
ffffffffc02076c2:	6a42                	ld	s4,16(sp)
ffffffffc02076c4:	6aa2                	ld	s5,8(sp)
ffffffffc02076c6:	6b02                	ld	s6,0(sp)
ffffffffc02076c8:	6121                	addi	sp,sp,64
ffffffffc02076ca:	8082                	ret
ffffffffc02076cc:	7442                	ld	s0,48(sp)
ffffffffc02076ce:	70e2                	ld	ra,56(sp)
ffffffffc02076d0:	74a2                	ld	s1,40(sp)
ffffffffc02076d2:	7902                	ld	s2,32(sp)
ffffffffc02076d4:	69e2                	ld	s3,24(sp)
ffffffffc02076d6:	6a42                	ld	s4,16(sp)
ffffffffc02076d8:	6aa2                	ld	s5,8(sp)
ffffffffc02076da:	6b02                	ld	s6,0(sp)
ffffffffc02076dc:	6121                	addi	sp,sp,64
ffffffffc02076de:	d8ef906f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc02076e2:	d90f90ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc02076e6:	4b05                	li	s6,1
ffffffffc02076e8:	b70d                	j	ffffffffc020760a <run_timer_list+0x1c>
ffffffffc02076ea:	4785                	li	a5,1
ffffffffc02076ec:	ed9c                	sd	a5,24(a1)
ffffffffc02076ee:	b7d9                	j	ffffffffc02076b4 <run_timer_list+0xc6>
ffffffffc02076f0:	00006697          	auipc	a3,0x6
ffffffffc02076f4:	41868693          	addi	a3,a3,1048 # ffffffffc020db08 <CSWTCH.79+0x6b0>
ffffffffc02076f8:	00004617          	auipc	a2,0x4
ffffffffc02076fc:	35060613          	addi	a2,a2,848 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207700:	0b600593          	li	a1,182
ffffffffc0207704:	00006517          	auipc	a0,0x6
ffffffffc0207708:	35c50513          	addi	a0,a0,860 # ffffffffc020da60 <CSWTCH.79+0x608>
ffffffffc020770c:	d93f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207710:	00006697          	auipc	a3,0x6
ffffffffc0207714:	3e068693          	addi	a3,a3,992 # ffffffffc020daf0 <CSWTCH.79+0x698>
ffffffffc0207718:	00004617          	auipc	a2,0x4
ffffffffc020771c:	33060613          	addi	a2,a2,816 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207720:	0ae00593          	li	a1,174
ffffffffc0207724:	00006517          	auipc	a0,0x6
ffffffffc0207728:	33c50513          	addi	a0,a0,828 # ffffffffc020da60 <CSWTCH.79+0x608>
ffffffffc020772c:	d73f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207730 <sys_getpid>:
ffffffffc0207730:	0008f797          	auipc	a5,0x8f
ffffffffc0207734:	1907b783          	ld	a5,400(a5) # ffffffffc02968c0 <current>
ffffffffc0207738:	43c8                	lw	a0,4(a5)
ffffffffc020773a:	8082                	ret

ffffffffc020773c <sys_pgdir>:
ffffffffc020773c:	4501                	li	a0,0
ffffffffc020773e:	8082                	ret

ffffffffc0207740 <sys_gettime>:
ffffffffc0207740:	0008f797          	auipc	a5,0x8f
ffffffffc0207744:	1307b783          	ld	a5,304(a5) # ffffffffc0296870 <ticks>
ffffffffc0207748:	0027951b          	slliw	a0,a5,0x2
ffffffffc020774c:	9d3d                	addw	a0,a0,a5
ffffffffc020774e:	0015151b          	slliw	a0,a0,0x1
ffffffffc0207752:	8082                	ret

ffffffffc0207754 <sys_lab6_set_priority>:
ffffffffc0207754:	4108                	lw	a0,0(a0)
ffffffffc0207756:	1141                	addi	sp,sp,-16
ffffffffc0207758:	e406                	sd	ra,8(sp)
ffffffffc020775a:	975ff0ef          	jal	ra,ffffffffc02070ce <lab6_set_priority>
ffffffffc020775e:	60a2                	ld	ra,8(sp)
ffffffffc0207760:	4501                	li	a0,0
ffffffffc0207762:	0141                	addi	sp,sp,16
ffffffffc0207764:	8082                	ret

ffffffffc0207766 <sys_dup>:
ffffffffc0207766:	450c                	lw	a1,8(a0)
ffffffffc0207768:	4108                	lw	a0,0(a0)
ffffffffc020776a:	a5efe06f          	j	ffffffffc02059c8 <sysfile_dup>

ffffffffc020776e <sys_getdirentry>:
ffffffffc020776e:	650c                	ld	a1,8(a0)
ffffffffc0207770:	4108                	lw	a0,0(a0)
ffffffffc0207772:	966fe06f          	j	ffffffffc02058d8 <sysfile_getdirentry>

ffffffffc0207776 <sys_getcwd>:
ffffffffc0207776:	650c                	ld	a1,8(a0)
ffffffffc0207778:	6108                	ld	a0,0(a0)
ffffffffc020777a:	8bafe06f          	j	ffffffffc0205834 <sysfile_getcwd>

ffffffffc020777e <sys_fsync>:
ffffffffc020777e:	4108                	lw	a0,0(a0)
ffffffffc0207780:	8b0fe06f          	j	ffffffffc0205830 <sysfile_fsync>

ffffffffc0207784 <sys_fstat>:
ffffffffc0207784:	650c                	ld	a1,8(a0)
ffffffffc0207786:	4108                	lw	a0,0(a0)
ffffffffc0207788:	808fe06f          	j	ffffffffc0205790 <sysfile_fstat>

ffffffffc020778c <sys_seek>:
ffffffffc020778c:	4910                	lw	a2,16(a0)
ffffffffc020778e:	650c                	ld	a1,8(a0)
ffffffffc0207790:	4108                	lw	a0,0(a0)
ffffffffc0207792:	ffbfd06f          	j	ffffffffc020578c <sysfile_seek>

ffffffffc0207796 <sys_write>:
ffffffffc0207796:	6910                	ld	a2,16(a0)
ffffffffc0207798:	650c                	ld	a1,8(a0)
ffffffffc020779a:	4108                	lw	a0,0(a0)
ffffffffc020779c:	ed7fd06f          	j	ffffffffc0205672 <sysfile_write>

ffffffffc02077a0 <sys_read>:
ffffffffc02077a0:	6910                	ld	a2,16(a0)
ffffffffc02077a2:	650c                	ld	a1,8(a0)
ffffffffc02077a4:	4108                	lw	a0,0(a0)
ffffffffc02077a6:	db9fd06f          	j	ffffffffc020555e <sysfile_read>

ffffffffc02077aa <sys_close>:
ffffffffc02077aa:	4108                	lw	a0,0(a0)
ffffffffc02077ac:	daffd06f          	j	ffffffffc020555a <sysfile_close>

ffffffffc02077b0 <sys_open>:
ffffffffc02077b0:	450c                	lw	a1,8(a0)
ffffffffc02077b2:	6108                	ld	a0,0(a0)
ffffffffc02077b4:	d73fd06f          	j	ffffffffc0205526 <sysfile_open>

ffffffffc02077b8 <sys_putc>:
ffffffffc02077b8:	4108                	lw	a0,0(a0)
ffffffffc02077ba:	1141                	addi	sp,sp,-16
ffffffffc02077bc:	e406                	sd	ra,8(sp)
ffffffffc02077be:	a25f80ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc02077c2:	60a2                	ld	ra,8(sp)
ffffffffc02077c4:	4501                	li	a0,0
ffffffffc02077c6:	0141                	addi	sp,sp,16
ffffffffc02077c8:	8082                	ret

ffffffffc02077ca <sys_kill>:
ffffffffc02077ca:	4108                	lw	a0,0(a0)
ffffffffc02077cc:	ea0ff06f          	j	ffffffffc0206e6c <do_kill>

ffffffffc02077d0 <sys_sleep>:
ffffffffc02077d0:	4108                	lw	a0,0(a0)
ffffffffc02077d2:	937ff06f          	j	ffffffffc0207108 <do_sleep>

ffffffffc02077d6 <sys_yield>:
ffffffffc02077d6:	e48ff06f          	j	ffffffffc0206e1e <do_yield>

ffffffffc02077da <sys_exec>:
ffffffffc02077da:	6910                	ld	a2,16(a0)
ffffffffc02077dc:	450c                	lw	a1,8(a0)
ffffffffc02077de:	6108                	ld	a0,0(a0)
ffffffffc02077e0:	c8dfe06f          	j	ffffffffc020646c <do_execve>

ffffffffc02077e4 <sys_wait>:
ffffffffc02077e4:	650c                	ld	a1,8(a0)
ffffffffc02077e6:	4108                	lw	a0,0(a0)
ffffffffc02077e8:	e46ff06f          	j	ffffffffc0206e2e <do_wait>

ffffffffc02077ec <sys_fork>:
ffffffffc02077ec:	0008f797          	auipc	a5,0x8f
ffffffffc02077f0:	0d47b783          	ld	a5,212(a5) # ffffffffc02968c0 <current>
ffffffffc02077f4:	73d0                	ld	a2,160(a5)
ffffffffc02077f6:	4501                	li	a0,0
ffffffffc02077f8:	6a0c                	ld	a1,16(a2)
ffffffffc02077fa:	b82fe06f          	j	ffffffffc0205b7c <do_fork>

ffffffffc02077fe <sys_exit>:
ffffffffc02077fe:	4108                	lw	a0,0(a0)
ffffffffc0207800:	ffcfe06f          	j	ffffffffc0205ffc <do_exit>

ffffffffc0207804 <syscall>:
ffffffffc0207804:	715d                	addi	sp,sp,-80
ffffffffc0207806:	fc26                	sd	s1,56(sp)
ffffffffc0207808:	0008f497          	auipc	s1,0x8f
ffffffffc020780c:	0b848493          	addi	s1,s1,184 # ffffffffc02968c0 <current>
ffffffffc0207810:	6098                	ld	a4,0(s1)
ffffffffc0207812:	e0a2                	sd	s0,64(sp)
ffffffffc0207814:	f84a                	sd	s2,48(sp)
ffffffffc0207816:	7340                	ld	s0,160(a4)
ffffffffc0207818:	e486                	sd	ra,72(sp)
ffffffffc020781a:	0ff00793          	li	a5,255
ffffffffc020781e:	05042903          	lw	s2,80(s0)
ffffffffc0207822:	0327ee63          	bltu	a5,s2,ffffffffc020785e <syscall+0x5a>
ffffffffc0207826:	00391713          	slli	a4,s2,0x3
ffffffffc020782a:	00006797          	auipc	a5,0x6
ffffffffc020782e:	36e78793          	addi	a5,a5,878 # ffffffffc020db98 <syscalls>
ffffffffc0207832:	97ba                	add	a5,a5,a4
ffffffffc0207834:	639c                	ld	a5,0(a5)
ffffffffc0207836:	c785                	beqz	a5,ffffffffc020785e <syscall+0x5a>
ffffffffc0207838:	6c28                	ld	a0,88(s0)
ffffffffc020783a:	702c                	ld	a1,96(s0)
ffffffffc020783c:	7430                	ld	a2,104(s0)
ffffffffc020783e:	7834                	ld	a3,112(s0)
ffffffffc0207840:	7c38                	ld	a4,120(s0)
ffffffffc0207842:	e42a                	sd	a0,8(sp)
ffffffffc0207844:	e82e                	sd	a1,16(sp)
ffffffffc0207846:	ec32                	sd	a2,24(sp)
ffffffffc0207848:	f036                	sd	a3,32(sp)
ffffffffc020784a:	f43a                	sd	a4,40(sp)
ffffffffc020784c:	0028                	addi	a0,sp,8
ffffffffc020784e:	9782                	jalr	a5
ffffffffc0207850:	60a6                	ld	ra,72(sp)
ffffffffc0207852:	e828                	sd	a0,80(s0)
ffffffffc0207854:	6406                	ld	s0,64(sp)
ffffffffc0207856:	74e2                	ld	s1,56(sp)
ffffffffc0207858:	7942                	ld	s2,48(sp)
ffffffffc020785a:	6161                	addi	sp,sp,80
ffffffffc020785c:	8082                	ret
ffffffffc020785e:	8522                	mv	a0,s0
ffffffffc0207860:	f2af90ef          	jal	ra,ffffffffc0200f8a <print_trapframe>
ffffffffc0207864:	609c                	ld	a5,0(s1)
ffffffffc0207866:	86ca                	mv	a3,s2
ffffffffc0207868:	00006617          	auipc	a2,0x6
ffffffffc020786c:	2e860613          	addi	a2,a2,744 # ffffffffc020db50 <CSWTCH.79+0x6f8>
ffffffffc0207870:	43d8                	lw	a4,4(a5)
ffffffffc0207872:	0d800593          	li	a1,216
ffffffffc0207876:	0b478793          	addi	a5,a5,180
ffffffffc020787a:	00006517          	auipc	a0,0x6
ffffffffc020787e:	30650513          	addi	a0,a0,774 # ffffffffc020db80 <CSWTCH.79+0x728>
ffffffffc0207882:	c1df80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207886 <__alloc_inode>:
ffffffffc0207886:	1141                	addi	sp,sp,-16
ffffffffc0207888:	e022                	sd	s0,0(sp)
ffffffffc020788a:	842a                	mv	s0,a0
ffffffffc020788c:	07800513          	li	a0,120
ffffffffc0207890:	e406                	sd	ra,8(sp)
ffffffffc0207892:	efcfa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0207896:	c111                	beqz	a0,ffffffffc020789a <__alloc_inode+0x14>
ffffffffc0207898:	cd20                	sw	s0,88(a0)
ffffffffc020789a:	60a2                	ld	ra,8(sp)
ffffffffc020789c:	6402                	ld	s0,0(sp)
ffffffffc020789e:	0141                	addi	sp,sp,16
ffffffffc02078a0:	8082                	ret

ffffffffc02078a2 <inode_init>:
ffffffffc02078a2:	4785                	li	a5,1
ffffffffc02078a4:	06052023          	sw	zero,96(a0)
ffffffffc02078a8:	f92c                	sd	a1,112(a0)
ffffffffc02078aa:	f530                	sd	a2,104(a0)
ffffffffc02078ac:	cd7c                	sw	a5,92(a0)
ffffffffc02078ae:	8082                	ret

ffffffffc02078b0 <inode_kill>:
ffffffffc02078b0:	4d78                	lw	a4,92(a0)
ffffffffc02078b2:	1141                	addi	sp,sp,-16
ffffffffc02078b4:	e406                	sd	ra,8(sp)
ffffffffc02078b6:	e719                	bnez	a4,ffffffffc02078c4 <inode_kill+0x14>
ffffffffc02078b8:	513c                	lw	a5,96(a0)
ffffffffc02078ba:	e78d                	bnez	a5,ffffffffc02078e4 <inode_kill+0x34>
ffffffffc02078bc:	60a2                	ld	ra,8(sp)
ffffffffc02078be:	0141                	addi	sp,sp,16
ffffffffc02078c0:	f7efa06f          	j	ffffffffc020203e <kfree>
ffffffffc02078c4:	00007697          	auipc	a3,0x7
ffffffffc02078c8:	ad468693          	addi	a3,a3,-1324 # ffffffffc020e398 <syscalls+0x800>
ffffffffc02078cc:	00004617          	auipc	a2,0x4
ffffffffc02078d0:	17c60613          	addi	a2,a2,380 # ffffffffc020ba48 <commands+0x210>
ffffffffc02078d4:	02900593          	li	a1,41
ffffffffc02078d8:	00007517          	auipc	a0,0x7
ffffffffc02078dc:	ae050513          	addi	a0,a0,-1312 # ffffffffc020e3b8 <syscalls+0x820>
ffffffffc02078e0:	bbff80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02078e4:	00007697          	auipc	a3,0x7
ffffffffc02078e8:	aec68693          	addi	a3,a3,-1300 # ffffffffc020e3d0 <syscalls+0x838>
ffffffffc02078ec:	00004617          	auipc	a2,0x4
ffffffffc02078f0:	15c60613          	addi	a2,a2,348 # ffffffffc020ba48 <commands+0x210>
ffffffffc02078f4:	02a00593          	li	a1,42
ffffffffc02078f8:	00007517          	auipc	a0,0x7
ffffffffc02078fc:	ac050513          	addi	a0,a0,-1344 # ffffffffc020e3b8 <syscalls+0x820>
ffffffffc0207900:	b9ff80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207904 <inode_ref_inc>:
ffffffffc0207904:	4d7c                	lw	a5,92(a0)
ffffffffc0207906:	2785                	addiw	a5,a5,1
ffffffffc0207908:	cd7c                	sw	a5,92(a0)
ffffffffc020790a:	0007851b          	sext.w	a0,a5
ffffffffc020790e:	8082                	ret

ffffffffc0207910 <inode_open_inc>:
ffffffffc0207910:	513c                	lw	a5,96(a0)
ffffffffc0207912:	2785                	addiw	a5,a5,1
ffffffffc0207914:	d13c                	sw	a5,96(a0)
ffffffffc0207916:	0007851b          	sext.w	a0,a5
ffffffffc020791a:	8082                	ret

ffffffffc020791c <inode_check>:
ffffffffc020791c:	1141                	addi	sp,sp,-16
ffffffffc020791e:	e406                	sd	ra,8(sp)
ffffffffc0207920:	c90d                	beqz	a0,ffffffffc0207952 <inode_check+0x36>
ffffffffc0207922:	793c                	ld	a5,112(a0)
ffffffffc0207924:	c79d                	beqz	a5,ffffffffc0207952 <inode_check+0x36>
ffffffffc0207926:	6398                	ld	a4,0(a5)
ffffffffc0207928:	4625d7b7          	lui	a5,0x4625d
ffffffffc020792c:	0786                	slli	a5,a5,0x1
ffffffffc020792e:	47678793          	addi	a5,a5,1142 # 4625d476 <_binary_bin_sfs_img_size+0x461e8176>
ffffffffc0207932:	08f71063          	bne	a4,a5,ffffffffc02079b2 <inode_check+0x96>
ffffffffc0207936:	4d78                	lw	a4,92(a0)
ffffffffc0207938:	513c                	lw	a5,96(a0)
ffffffffc020793a:	04f74c63          	blt	a4,a5,ffffffffc0207992 <inode_check+0x76>
ffffffffc020793e:	0407ca63          	bltz	a5,ffffffffc0207992 <inode_check+0x76>
ffffffffc0207942:	66c1                	lui	a3,0x10
ffffffffc0207944:	02d75763          	bge	a4,a3,ffffffffc0207972 <inode_check+0x56>
ffffffffc0207948:	02d7d563          	bge	a5,a3,ffffffffc0207972 <inode_check+0x56>
ffffffffc020794c:	60a2                	ld	ra,8(sp)
ffffffffc020794e:	0141                	addi	sp,sp,16
ffffffffc0207950:	8082                	ret
ffffffffc0207952:	00007697          	auipc	a3,0x7
ffffffffc0207956:	a9e68693          	addi	a3,a3,-1378 # ffffffffc020e3f0 <syscalls+0x858>
ffffffffc020795a:	00004617          	auipc	a2,0x4
ffffffffc020795e:	0ee60613          	addi	a2,a2,238 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207962:	06e00593          	li	a1,110
ffffffffc0207966:	00007517          	auipc	a0,0x7
ffffffffc020796a:	a5250513          	addi	a0,a0,-1454 # ffffffffc020e3b8 <syscalls+0x820>
ffffffffc020796e:	b31f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207972:	00007697          	auipc	a3,0x7
ffffffffc0207976:	afe68693          	addi	a3,a3,-1282 # ffffffffc020e470 <syscalls+0x8d8>
ffffffffc020797a:	00004617          	auipc	a2,0x4
ffffffffc020797e:	0ce60613          	addi	a2,a2,206 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207982:	07200593          	li	a1,114
ffffffffc0207986:	00007517          	auipc	a0,0x7
ffffffffc020798a:	a3250513          	addi	a0,a0,-1486 # ffffffffc020e3b8 <syscalls+0x820>
ffffffffc020798e:	b11f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207992:	00007697          	auipc	a3,0x7
ffffffffc0207996:	aae68693          	addi	a3,a3,-1362 # ffffffffc020e440 <syscalls+0x8a8>
ffffffffc020799a:	00004617          	auipc	a2,0x4
ffffffffc020799e:	0ae60613          	addi	a2,a2,174 # ffffffffc020ba48 <commands+0x210>
ffffffffc02079a2:	07100593          	li	a1,113
ffffffffc02079a6:	00007517          	auipc	a0,0x7
ffffffffc02079aa:	a1250513          	addi	a0,a0,-1518 # ffffffffc020e3b8 <syscalls+0x820>
ffffffffc02079ae:	af1f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02079b2:	00007697          	auipc	a3,0x7
ffffffffc02079b6:	a6668693          	addi	a3,a3,-1434 # ffffffffc020e418 <syscalls+0x880>
ffffffffc02079ba:	00004617          	auipc	a2,0x4
ffffffffc02079be:	08e60613          	addi	a2,a2,142 # ffffffffc020ba48 <commands+0x210>
ffffffffc02079c2:	06f00593          	li	a1,111
ffffffffc02079c6:	00007517          	auipc	a0,0x7
ffffffffc02079ca:	9f250513          	addi	a0,a0,-1550 # ffffffffc020e3b8 <syscalls+0x820>
ffffffffc02079ce:	ad1f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02079d2 <inode_ref_dec>:
ffffffffc02079d2:	4d7c                	lw	a5,92(a0)
ffffffffc02079d4:	1101                	addi	sp,sp,-32
ffffffffc02079d6:	ec06                	sd	ra,24(sp)
ffffffffc02079d8:	e822                	sd	s0,16(sp)
ffffffffc02079da:	e426                	sd	s1,8(sp)
ffffffffc02079dc:	e04a                	sd	s2,0(sp)
ffffffffc02079de:	06f05e63          	blez	a5,ffffffffc0207a5a <inode_ref_dec+0x88>
ffffffffc02079e2:	fff7849b          	addiw	s1,a5,-1
ffffffffc02079e6:	cd64                	sw	s1,92(a0)
ffffffffc02079e8:	842a                	mv	s0,a0
ffffffffc02079ea:	e09d                	bnez	s1,ffffffffc0207a10 <inode_ref_dec+0x3e>
ffffffffc02079ec:	793c                	ld	a5,112(a0)
ffffffffc02079ee:	c7b1                	beqz	a5,ffffffffc0207a3a <inode_ref_dec+0x68>
ffffffffc02079f0:	0487b903          	ld	s2,72(a5)
ffffffffc02079f4:	04090363          	beqz	s2,ffffffffc0207a3a <inode_ref_dec+0x68>
ffffffffc02079f8:	00007597          	auipc	a1,0x7
ffffffffc02079fc:	b2858593          	addi	a1,a1,-1240 # ffffffffc020e520 <syscalls+0x988>
ffffffffc0207a00:	f1dff0ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc0207a04:	8522                	mv	a0,s0
ffffffffc0207a06:	9902                	jalr	s2
ffffffffc0207a08:	c501                	beqz	a0,ffffffffc0207a10 <inode_ref_dec+0x3e>
ffffffffc0207a0a:	57c5                	li	a5,-15
ffffffffc0207a0c:	00f51963          	bne	a0,a5,ffffffffc0207a1e <inode_ref_dec+0x4c>
ffffffffc0207a10:	60e2                	ld	ra,24(sp)
ffffffffc0207a12:	6442                	ld	s0,16(sp)
ffffffffc0207a14:	6902                	ld	s2,0(sp)
ffffffffc0207a16:	8526                	mv	a0,s1
ffffffffc0207a18:	64a2                	ld	s1,8(sp)
ffffffffc0207a1a:	6105                	addi	sp,sp,32
ffffffffc0207a1c:	8082                	ret
ffffffffc0207a1e:	85aa                	mv	a1,a0
ffffffffc0207a20:	00007517          	auipc	a0,0x7
ffffffffc0207a24:	b0850513          	addi	a0,a0,-1272 # ffffffffc020e528 <syscalls+0x990>
ffffffffc0207a28:	f7ef80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207a2c:	60e2                	ld	ra,24(sp)
ffffffffc0207a2e:	6442                	ld	s0,16(sp)
ffffffffc0207a30:	6902                	ld	s2,0(sp)
ffffffffc0207a32:	8526                	mv	a0,s1
ffffffffc0207a34:	64a2                	ld	s1,8(sp)
ffffffffc0207a36:	6105                	addi	sp,sp,32
ffffffffc0207a38:	8082                	ret
ffffffffc0207a3a:	00007697          	auipc	a3,0x7
ffffffffc0207a3e:	a9668693          	addi	a3,a3,-1386 # ffffffffc020e4d0 <syscalls+0x938>
ffffffffc0207a42:	00004617          	auipc	a2,0x4
ffffffffc0207a46:	00660613          	addi	a2,a2,6 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207a4a:	04400593          	li	a1,68
ffffffffc0207a4e:	00007517          	auipc	a0,0x7
ffffffffc0207a52:	96a50513          	addi	a0,a0,-1686 # ffffffffc020e3b8 <syscalls+0x820>
ffffffffc0207a56:	a49f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207a5a:	00007697          	auipc	a3,0x7
ffffffffc0207a5e:	a5668693          	addi	a3,a3,-1450 # ffffffffc020e4b0 <syscalls+0x918>
ffffffffc0207a62:	00004617          	auipc	a2,0x4
ffffffffc0207a66:	fe660613          	addi	a2,a2,-26 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207a6a:	03f00593          	li	a1,63
ffffffffc0207a6e:	00007517          	auipc	a0,0x7
ffffffffc0207a72:	94a50513          	addi	a0,a0,-1718 # ffffffffc020e3b8 <syscalls+0x820>
ffffffffc0207a76:	a29f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207a7a <inode_open_dec>:
ffffffffc0207a7a:	513c                	lw	a5,96(a0)
ffffffffc0207a7c:	1101                	addi	sp,sp,-32
ffffffffc0207a7e:	ec06                	sd	ra,24(sp)
ffffffffc0207a80:	e822                	sd	s0,16(sp)
ffffffffc0207a82:	e426                	sd	s1,8(sp)
ffffffffc0207a84:	e04a                	sd	s2,0(sp)
ffffffffc0207a86:	06f05b63          	blez	a5,ffffffffc0207afc <inode_open_dec+0x82>
ffffffffc0207a8a:	fff7849b          	addiw	s1,a5,-1
ffffffffc0207a8e:	d124                	sw	s1,96(a0)
ffffffffc0207a90:	842a                	mv	s0,a0
ffffffffc0207a92:	e085                	bnez	s1,ffffffffc0207ab2 <inode_open_dec+0x38>
ffffffffc0207a94:	793c                	ld	a5,112(a0)
ffffffffc0207a96:	c3b9                	beqz	a5,ffffffffc0207adc <inode_open_dec+0x62>
ffffffffc0207a98:	0107b903          	ld	s2,16(a5)
ffffffffc0207a9c:	04090063          	beqz	s2,ffffffffc0207adc <inode_open_dec+0x62>
ffffffffc0207aa0:	00007597          	auipc	a1,0x7
ffffffffc0207aa4:	b1858593          	addi	a1,a1,-1256 # ffffffffc020e5b8 <syscalls+0xa20>
ffffffffc0207aa8:	e75ff0ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc0207aac:	8522                	mv	a0,s0
ffffffffc0207aae:	9902                	jalr	s2
ffffffffc0207ab0:	e901                	bnez	a0,ffffffffc0207ac0 <inode_open_dec+0x46>
ffffffffc0207ab2:	60e2                	ld	ra,24(sp)
ffffffffc0207ab4:	6442                	ld	s0,16(sp)
ffffffffc0207ab6:	6902                	ld	s2,0(sp)
ffffffffc0207ab8:	8526                	mv	a0,s1
ffffffffc0207aba:	64a2                	ld	s1,8(sp)
ffffffffc0207abc:	6105                	addi	sp,sp,32
ffffffffc0207abe:	8082                	ret
ffffffffc0207ac0:	85aa                	mv	a1,a0
ffffffffc0207ac2:	00007517          	auipc	a0,0x7
ffffffffc0207ac6:	afe50513          	addi	a0,a0,-1282 # ffffffffc020e5c0 <syscalls+0xa28>
ffffffffc0207aca:	edcf80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207ace:	60e2                	ld	ra,24(sp)
ffffffffc0207ad0:	6442                	ld	s0,16(sp)
ffffffffc0207ad2:	6902                	ld	s2,0(sp)
ffffffffc0207ad4:	8526                	mv	a0,s1
ffffffffc0207ad6:	64a2                	ld	s1,8(sp)
ffffffffc0207ad8:	6105                	addi	sp,sp,32
ffffffffc0207ada:	8082                	ret
ffffffffc0207adc:	00007697          	auipc	a3,0x7
ffffffffc0207ae0:	a8c68693          	addi	a3,a3,-1396 # ffffffffc020e568 <syscalls+0x9d0>
ffffffffc0207ae4:	00004617          	auipc	a2,0x4
ffffffffc0207ae8:	f6460613          	addi	a2,a2,-156 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207aec:	06100593          	li	a1,97
ffffffffc0207af0:	00007517          	auipc	a0,0x7
ffffffffc0207af4:	8c850513          	addi	a0,a0,-1848 # ffffffffc020e3b8 <syscalls+0x820>
ffffffffc0207af8:	9a7f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207afc:	00007697          	auipc	a3,0x7
ffffffffc0207b00:	a4c68693          	addi	a3,a3,-1460 # ffffffffc020e548 <syscalls+0x9b0>
ffffffffc0207b04:	00004617          	auipc	a2,0x4
ffffffffc0207b08:	f4460613          	addi	a2,a2,-188 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207b0c:	05c00593          	li	a1,92
ffffffffc0207b10:	00007517          	auipc	a0,0x7
ffffffffc0207b14:	8a850513          	addi	a0,a0,-1880 # ffffffffc020e3b8 <syscalls+0x820>
ffffffffc0207b18:	987f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207b1c <__alloc_fs>:
ffffffffc0207b1c:	1141                	addi	sp,sp,-16
ffffffffc0207b1e:	e022                	sd	s0,0(sp)
ffffffffc0207b20:	842a                	mv	s0,a0
ffffffffc0207b22:	0d800513          	li	a0,216
ffffffffc0207b26:	e406                	sd	ra,8(sp)
ffffffffc0207b28:	c66fa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0207b2c:	c119                	beqz	a0,ffffffffc0207b32 <__alloc_fs+0x16>
ffffffffc0207b2e:	0a852823          	sw	s0,176(a0)
ffffffffc0207b32:	60a2                	ld	ra,8(sp)
ffffffffc0207b34:	6402                	ld	s0,0(sp)
ffffffffc0207b36:	0141                	addi	sp,sp,16
ffffffffc0207b38:	8082                	ret

ffffffffc0207b3a <vfs_init>:
ffffffffc0207b3a:	1141                	addi	sp,sp,-16
ffffffffc0207b3c:	4585                	li	a1,1
ffffffffc0207b3e:	0008e517          	auipc	a0,0x8e
ffffffffc0207b42:	cc250513          	addi	a0,a0,-830 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207b46:	e406                	sd	ra,8(sp)
ffffffffc0207b48:	a13fc0ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc0207b4c:	60a2                	ld	ra,8(sp)
ffffffffc0207b4e:	0141                	addi	sp,sp,16
ffffffffc0207b50:	a40d                	j	ffffffffc0207d72 <vfs_devlist_init>

ffffffffc0207b52 <vfs_set_bootfs>:
ffffffffc0207b52:	7179                	addi	sp,sp,-48
ffffffffc0207b54:	f022                	sd	s0,32(sp)
ffffffffc0207b56:	f406                	sd	ra,40(sp)
ffffffffc0207b58:	ec26                	sd	s1,24(sp)
ffffffffc0207b5a:	e402                	sd	zero,8(sp)
ffffffffc0207b5c:	842a                	mv	s0,a0
ffffffffc0207b5e:	c915                	beqz	a0,ffffffffc0207b92 <vfs_set_bootfs+0x40>
ffffffffc0207b60:	03a00593          	li	a1,58
ffffffffc0207b64:	1ed030ef          	jal	ra,ffffffffc020b550 <strchr>
ffffffffc0207b68:	c135                	beqz	a0,ffffffffc0207bcc <vfs_set_bootfs+0x7a>
ffffffffc0207b6a:	00154783          	lbu	a5,1(a0)
ffffffffc0207b6e:	efb9                	bnez	a5,ffffffffc0207bcc <vfs_set_bootfs+0x7a>
ffffffffc0207b70:	8522                	mv	a0,s0
ffffffffc0207b72:	11f000ef          	jal	ra,ffffffffc0208490 <vfs_chdir>
ffffffffc0207b76:	842a                	mv	s0,a0
ffffffffc0207b78:	c519                	beqz	a0,ffffffffc0207b86 <vfs_set_bootfs+0x34>
ffffffffc0207b7a:	70a2                	ld	ra,40(sp)
ffffffffc0207b7c:	8522                	mv	a0,s0
ffffffffc0207b7e:	7402                	ld	s0,32(sp)
ffffffffc0207b80:	64e2                	ld	s1,24(sp)
ffffffffc0207b82:	6145                	addi	sp,sp,48
ffffffffc0207b84:	8082                	ret
ffffffffc0207b86:	0028                	addi	a0,sp,8
ffffffffc0207b88:	013000ef          	jal	ra,ffffffffc020839a <vfs_get_curdir>
ffffffffc0207b8c:	842a                	mv	s0,a0
ffffffffc0207b8e:	f575                	bnez	a0,ffffffffc0207b7a <vfs_set_bootfs+0x28>
ffffffffc0207b90:	6422                	ld	s0,8(sp)
ffffffffc0207b92:	0008e517          	auipc	a0,0x8e
ffffffffc0207b96:	c6e50513          	addi	a0,a0,-914 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207b9a:	9cbfc0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0207b9e:	0008f797          	auipc	a5,0x8f
ffffffffc0207ba2:	d5278793          	addi	a5,a5,-686 # ffffffffc02968f0 <bootfs_node>
ffffffffc0207ba6:	6384                	ld	s1,0(a5)
ffffffffc0207ba8:	0008e517          	auipc	a0,0x8e
ffffffffc0207bac:	c5850513          	addi	a0,a0,-936 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207bb0:	e380                	sd	s0,0(a5)
ffffffffc0207bb2:	4401                	li	s0,0
ffffffffc0207bb4:	9adfc0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0207bb8:	d0e9                	beqz	s1,ffffffffc0207b7a <vfs_set_bootfs+0x28>
ffffffffc0207bba:	8526                	mv	a0,s1
ffffffffc0207bbc:	e17ff0ef          	jal	ra,ffffffffc02079d2 <inode_ref_dec>
ffffffffc0207bc0:	70a2                	ld	ra,40(sp)
ffffffffc0207bc2:	8522                	mv	a0,s0
ffffffffc0207bc4:	7402                	ld	s0,32(sp)
ffffffffc0207bc6:	64e2                	ld	s1,24(sp)
ffffffffc0207bc8:	6145                	addi	sp,sp,48
ffffffffc0207bca:	8082                	ret
ffffffffc0207bcc:	5475                	li	s0,-3
ffffffffc0207bce:	b775                	j	ffffffffc0207b7a <vfs_set_bootfs+0x28>

ffffffffc0207bd0 <vfs_get_bootfs>:
ffffffffc0207bd0:	1101                	addi	sp,sp,-32
ffffffffc0207bd2:	e426                	sd	s1,8(sp)
ffffffffc0207bd4:	0008f497          	auipc	s1,0x8f
ffffffffc0207bd8:	d1c48493          	addi	s1,s1,-740 # ffffffffc02968f0 <bootfs_node>
ffffffffc0207bdc:	609c                	ld	a5,0(s1)
ffffffffc0207bde:	ec06                	sd	ra,24(sp)
ffffffffc0207be0:	e822                	sd	s0,16(sp)
ffffffffc0207be2:	c3a1                	beqz	a5,ffffffffc0207c22 <vfs_get_bootfs+0x52>
ffffffffc0207be4:	842a                	mv	s0,a0
ffffffffc0207be6:	0008e517          	auipc	a0,0x8e
ffffffffc0207bea:	c1a50513          	addi	a0,a0,-998 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207bee:	977fc0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0207bf2:	6084                	ld	s1,0(s1)
ffffffffc0207bf4:	c08d                	beqz	s1,ffffffffc0207c16 <vfs_get_bootfs+0x46>
ffffffffc0207bf6:	8526                	mv	a0,s1
ffffffffc0207bf8:	d0dff0ef          	jal	ra,ffffffffc0207904 <inode_ref_inc>
ffffffffc0207bfc:	0008e517          	auipc	a0,0x8e
ffffffffc0207c00:	c0450513          	addi	a0,a0,-1020 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207c04:	95dfc0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0207c08:	4501                	li	a0,0
ffffffffc0207c0a:	e004                	sd	s1,0(s0)
ffffffffc0207c0c:	60e2                	ld	ra,24(sp)
ffffffffc0207c0e:	6442                	ld	s0,16(sp)
ffffffffc0207c10:	64a2                	ld	s1,8(sp)
ffffffffc0207c12:	6105                	addi	sp,sp,32
ffffffffc0207c14:	8082                	ret
ffffffffc0207c16:	0008e517          	auipc	a0,0x8e
ffffffffc0207c1a:	bea50513          	addi	a0,a0,-1046 # ffffffffc0295800 <bootfs_sem>
ffffffffc0207c1e:	943fc0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0207c22:	5541                	li	a0,-16
ffffffffc0207c24:	b7e5                	j	ffffffffc0207c0c <vfs_get_bootfs+0x3c>

ffffffffc0207c26 <vfs_do_add>:
ffffffffc0207c26:	7139                	addi	sp,sp,-64
ffffffffc0207c28:	fc06                	sd	ra,56(sp)
ffffffffc0207c2a:	f822                	sd	s0,48(sp)
ffffffffc0207c2c:	f426                	sd	s1,40(sp)
ffffffffc0207c2e:	f04a                	sd	s2,32(sp)
ffffffffc0207c30:	ec4e                	sd	s3,24(sp)
ffffffffc0207c32:	e852                	sd	s4,16(sp)
ffffffffc0207c34:	e456                	sd	s5,8(sp)
ffffffffc0207c36:	e05a                	sd	s6,0(sp)
ffffffffc0207c38:	0e050b63          	beqz	a0,ffffffffc0207d2e <vfs_do_add+0x108>
ffffffffc0207c3c:	842a                	mv	s0,a0
ffffffffc0207c3e:	8a2e                	mv	s4,a1
ffffffffc0207c40:	8b32                	mv	s6,a2
ffffffffc0207c42:	8ab6                	mv	s5,a3
ffffffffc0207c44:	c5cd                	beqz	a1,ffffffffc0207cee <vfs_do_add+0xc8>
ffffffffc0207c46:	4db8                	lw	a4,88(a1)
ffffffffc0207c48:	6785                	lui	a5,0x1
ffffffffc0207c4a:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207c4e:	0af71163          	bne	a4,a5,ffffffffc0207cf0 <vfs_do_add+0xca>
ffffffffc0207c52:	8522                	mv	a0,s0
ffffffffc0207c54:	071030ef          	jal	ra,ffffffffc020b4c4 <strlen>
ffffffffc0207c58:	47fd                	li	a5,31
ffffffffc0207c5a:	0ca7e663          	bltu	a5,a0,ffffffffc0207d26 <vfs_do_add+0x100>
ffffffffc0207c5e:	8522                	mv	a0,s0
ffffffffc0207c60:	d94f80ef          	jal	ra,ffffffffc02001f4 <strdup>
ffffffffc0207c64:	84aa                	mv	s1,a0
ffffffffc0207c66:	c171                	beqz	a0,ffffffffc0207d2a <vfs_do_add+0x104>
ffffffffc0207c68:	03000513          	li	a0,48
ffffffffc0207c6c:	b22fa0ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0207c70:	89aa                	mv	s3,a0
ffffffffc0207c72:	c92d                	beqz	a0,ffffffffc0207ce4 <vfs_do_add+0xbe>
ffffffffc0207c74:	0008e517          	auipc	a0,0x8e
ffffffffc0207c78:	bb450513          	addi	a0,a0,-1100 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207c7c:	0008e917          	auipc	s2,0x8e
ffffffffc0207c80:	b9c90913          	addi	s2,s2,-1124 # ffffffffc0295818 <vdev_list>
ffffffffc0207c84:	8e1fc0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0207c88:	844a                	mv	s0,s2
ffffffffc0207c8a:	a039                	j	ffffffffc0207c98 <vfs_do_add+0x72>
ffffffffc0207c8c:	fe043503          	ld	a0,-32(s0)
ffffffffc0207c90:	85a6                	mv	a1,s1
ffffffffc0207c92:	07b030ef          	jal	ra,ffffffffc020b50c <strcmp>
ffffffffc0207c96:	cd2d                	beqz	a0,ffffffffc0207d10 <vfs_do_add+0xea>
ffffffffc0207c98:	6400                	ld	s0,8(s0)
ffffffffc0207c9a:	ff2419e3          	bne	s0,s2,ffffffffc0207c8c <vfs_do_add+0x66>
ffffffffc0207c9e:	6418                	ld	a4,8(s0)
ffffffffc0207ca0:	02098793          	addi	a5,s3,32
ffffffffc0207ca4:	0099b023          	sd	s1,0(s3)
ffffffffc0207ca8:	0149b423          	sd	s4,8(s3)
ffffffffc0207cac:	0159bc23          	sd	s5,24(s3)
ffffffffc0207cb0:	0169b823          	sd	s6,16(s3)
ffffffffc0207cb4:	e31c                	sd	a5,0(a4)
ffffffffc0207cb6:	0289b023          	sd	s0,32(s3)
ffffffffc0207cba:	02e9b423          	sd	a4,40(s3)
ffffffffc0207cbe:	0008e517          	auipc	a0,0x8e
ffffffffc0207cc2:	b6a50513          	addi	a0,a0,-1174 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207cc6:	e41c                	sd	a5,8(s0)
ffffffffc0207cc8:	4401                	li	s0,0
ffffffffc0207cca:	897fc0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0207cce:	70e2                	ld	ra,56(sp)
ffffffffc0207cd0:	8522                	mv	a0,s0
ffffffffc0207cd2:	7442                	ld	s0,48(sp)
ffffffffc0207cd4:	74a2                	ld	s1,40(sp)
ffffffffc0207cd6:	7902                	ld	s2,32(sp)
ffffffffc0207cd8:	69e2                	ld	s3,24(sp)
ffffffffc0207cda:	6a42                	ld	s4,16(sp)
ffffffffc0207cdc:	6aa2                	ld	s5,8(sp)
ffffffffc0207cde:	6b02                	ld	s6,0(sp)
ffffffffc0207ce0:	6121                	addi	sp,sp,64
ffffffffc0207ce2:	8082                	ret
ffffffffc0207ce4:	5471                	li	s0,-4
ffffffffc0207ce6:	8526                	mv	a0,s1
ffffffffc0207ce8:	b56fa0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0207cec:	b7cd                	j	ffffffffc0207cce <vfs_do_add+0xa8>
ffffffffc0207cee:	d2b5                	beqz	a3,ffffffffc0207c52 <vfs_do_add+0x2c>
ffffffffc0207cf0:	00007697          	auipc	a3,0x7
ffffffffc0207cf4:	91868693          	addi	a3,a3,-1768 # ffffffffc020e608 <syscalls+0xa70>
ffffffffc0207cf8:	00004617          	auipc	a2,0x4
ffffffffc0207cfc:	d5060613          	addi	a2,a2,-688 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207d00:	08f00593          	li	a1,143
ffffffffc0207d04:	00007517          	auipc	a0,0x7
ffffffffc0207d08:	8ec50513          	addi	a0,a0,-1812 # ffffffffc020e5f0 <syscalls+0xa58>
ffffffffc0207d0c:	f92f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207d10:	0008e517          	auipc	a0,0x8e
ffffffffc0207d14:	b1850513          	addi	a0,a0,-1256 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207d18:	849fc0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0207d1c:	854e                	mv	a0,s3
ffffffffc0207d1e:	b20fa0ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0207d22:	5425                	li	s0,-23
ffffffffc0207d24:	b7c9                	j	ffffffffc0207ce6 <vfs_do_add+0xc0>
ffffffffc0207d26:	5451                	li	s0,-12
ffffffffc0207d28:	b75d                	j	ffffffffc0207cce <vfs_do_add+0xa8>
ffffffffc0207d2a:	5471                	li	s0,-4
ffffffffc0207d2c:	b74d                	j	ffffffffc0207cce <vfs_do_add+0xa8>
ffffffffc0207d2e:	00007697          	auipc	a3,0x7
ffffffffc0207d32:	8b268693          	addi	a3,a3,-1870 # ffffffffc020e5e0 <syscalls+0xa48>
ffffffffc0207d36:	00004617          	auipc	a2,0x4
ffffffffc0207d3a:	d1260613          	addi	a2,a2,-750 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207d3e:	08e00593          	li	a1,142
ffffffffc0207d42:	00007517          	auipc	a0,0x7
ffffffffc0207d46:	8ae50513          	addi	a0,a0,-1874 # ffffffffc020e5f0 <syscalls+0xa58>
ffffffffc0207d4a:	f54f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207d4e <find_mount.part.0>:
ffffffffc0207d4e:	1141                	addi	sp,sp,-16
ffffffffc0207d50:	00007697          	auipc	a3,0x7
ffffffffc0207d54:	89068693          	addi	a3,a3,-1904 # ffffffffc020e5e0 <syscalls+0xa48>
ffffffffc0207d58:	00004617          	auipc	a2,0x4
ffffffffc0207d5c:	cf060613          	addi	a2,a2,-784 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207d60:	0cd00593          	li	a1,205
ffffffffc0207d64:	00007517          	auipc	a0,0x7
ffffffffc0207d68:	88c50513          	addi	a0,a0,-1908 # ffffffffc020e5f0 <syscalls+0xa58>
ffffffffc0207d6c:	e406                	sd	ra,8(sp)
ffffffffc0207d6e:	f30f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207d72 <vfs_devlist_init>:
ffffffffc0207d72:	0008e797          	auipc	a5,0x8e
ffffffffc0207d76:	aa678793          	addi	a5,a5,-1370 # ffffffffc0295818 <vdev_list>
ffffffffc0207d7a:	4585                	li	a1,1
ffffffffc0207d7c:	0008e517          	auipc	a0,0x8e
ffffffffc0207d80:	aac50513          	addi	a0,a0,-1364 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207d84:	e79c                	sd	a5,8(a5)
ffffffffc0207d86:	e39c                	sd	a5,0(a5)
ffffffffc0207d88:	fd2fc06f          	j	ffffffffc020455a <sem_init>

ffffffffc0207d8c <vfs_cleanup>:
ffffffffc0207d8c:	1101                	addi	sp,sp,-32
ffffffffc0207d8e:	e426                	sd	s1,8(sp)
ffffffffc0207d90:	0008e497          	auipc	s1,0x8e
ffffffffc0207d94:	a8848493          	addi	s1,s1,-1400 # ffffffffc0295818 <vdev_list>
ffffffffc0207d98:	649c                	ld	a5,8(s1)
ffffffffc0207d9a:	ec06                	sd	ra,24(sp)
ffffffffc0207d9c:	e822                	sd	s0,16(sp)
ffffffffc0207d9e:	02978e63          	beq	a5,s1,ffffffffc0207dda <vfs_cleanup+0x4e>
ffffffffc0207da2:	0008e517          	auipc	a0,0x8e
ffffffffc0207da6:	a8650513          	addi	a0,a0,-1402 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207daa:	fbafc0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0207dae:	6480                	ld	s0,8(s1)
ffffffffc0207db0:	00940b63          	beq	s0,s1,ffffffffc0207dc6 <vfs_cleanup+0x3a>
ffffffffc0207db4:	ff043783          	ld	a5,-16(s0)
ffffffffc0207db8:	853e                	mv	a0,a5
ffffffffc0207dba:	c399                	beqz	a5,ffffffffc0207dc0 <vfs_cleanup+0x34>
ffffffffc0207dbc:	6bfc                	ld	a5,208(a5)
ffffffffc0207dbe:	9782                	jalr	a5
ffffffffc0207dc0:	6400                	ld	s0,8(s0)
ffffffffc0207dc2:	fe9419e3          	bne	s0,s1,ffffffffc0207db4 <vfs_cleanup+0x28>
ffffffffc0207dc6:	6442                	ld	s0,16(sp)
ffffffffc0207dc8:	60e2                	ld	ra,24(sp)
ffffffffc0207dca:	64a2                	ld	s1,8(sp)
ffffffffc0207dcc:	0008e517          	auipc	a0,0x8e
ffffffffc0207dd0:	a5c50513          	addi	a0,a0,-1444 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207dd4:	6105                	addi	sp,sp,32
ffffffffc0207dd6:	f8afc06f          	j	ffffffffc0204560 <up>
ffffffffc0207dda:	60e2                	ld	ra,24(sp)
ffffffffc0207ddc:	6442                	ld	s0,16(sp)
ffffffffc0207dde:	64a2                	ld	s1,8(sp)
ffffffffc0207de0:	6105                	addi	sp,sp,32
ffffffffc0207de2:	8082                	ret

ffffffffc0207de4 <vfs_get_root>:
ffffffffc0207de4:	7179                	addi	sp,sp,-48
ffffffffc0207de6:	f406                	sd	ra,40(sp)
ffffffffc0207de8:	f022                	sd	s0,32(sp)
ffffffffc0207dea:	ec26                	sd	s1,24(sp)
ffffffffc0207dec:	e84a                	sd	s2,16(sp)
ffffffffc0207dee:	e44e                	sd	s3,8(sp)
ffffffffc0207df0:	e052                	sd	s4,0(sp)
ffffffffc0207df2:	c541                	beqz	a0,ffffffffc0207e7a <vfs_get_root+0x96>
ffffffffc0207df4:	0008e917          	auipc	s2,0x8e
ffffffffc0207df8:	a2490913          	addi	s2,s2,-1500 # ffffffffc0295818 <vdev_list>
ffffffffc0207dfc:	00893783          	ld	a5,8(s2)
ffffffffc0207e00:	07278b63          	beq	a5,s2,ffffffffc0207e76 <vfs_get_root+0x92>
ffffffffc0207e04:	89aa                	mv	s3,a0
ffffffffc0207e06:	0008e517          	auipc	a0,0x8e
ffffffffc0207e0a:	a2250513          	addi	a0,a0,-1502 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207e0e:	8a2e                	mv	s4,a1
ffffffffc0207e10:	844a                	mv	s0,s2
ffffffffc0207e12:	f52fc0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0207e16:	a801                	j	ffffffffc0207e26 <vfs_get_root+0x42>
ffffffffc0207e18:	fe043583          	ld	a1,-32(s0)
ffffffffc0207e1c:	854e                	mv	a0,s3
ffffffffc0207e1e:	6ee030ef          	jal	ra,ffffffffc020b50c <strcmp>
ffffffffc0207e22:	84aa                	mv	s1,a0
ffffffffc0207e24:	c505                	beqz	a0,ffffffffc0207e4c <vfs_get_root+0x68>
ffffffffc0207e26:	6400                	ld	s0,8(s0)
ffffffffc0207e28:	ff2418e3          	bne	s0,s2,ffffffffc0207e18 <vfs_get_root+0x34>
ffffffffc0207e2c:	54cd                	li	s1,-13
ffffffffc0207e2e:	0008e517          	auipc	a0,0x8e
ffffffffc0207e32:	9fa50513          	addi	a0,a0,-1542 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207e36:	f2afc0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0207e3a:	70a2                	ld	ra,40(sp)
ffffffffc0207e3c:	7402                	ld	s0,32(sp)
ffffffffc0207e3e:	6942                	ld	s2,16(sp)
ffffffffc0207e40:	69a2                	ld	s3,8(sp)
ffffffffc0207e42:	6a02                	ld	s4,0(sp)
ffffffffc0207e44:	8526                	mv	a0,s1
ffffffffc0207e46:	64e2                	ld	s1,24(sp)
ffffffffc0207e48:	6145                	addi	sp,sp,48
ffffffffc0207e4a:	8082                	ret
ffffffffc0207e4c:	ff043503          	ld	a0,-16(s0)
ffffffffc0207e50:	c519                	beqz	a0,ffffffffc0207e5e <vfs_get_root+0x7a>
ffffffffc0207e52:	617c                	ld	a5,192(a0)
ffffffffc0207e54:	9782                	jalr	a5
ffffffffc0207e56:	c519                	beqz	a0,ffffffffc0207e64 <vfs_get_root+0x80>
ffffffffc0207e58:	00aa3023          	sd	a0,0(s4)
ffffffffc0207e5c:	bfc9                	j	ffffffffc0207e2e <vfs_get_root+0x4a>
ffffffffc0207e5e:	ff843783          	ld	a5,-8(s0)
ffffffffc0207e62:	c399                	beqz	a5,ffffffffc0207e68 <vfs_get_root+0x84>
ffffffffc0207e64:	54c9                	li	s1,-14
ffffffffc0207e66:	b7e1                	j	ffffffffc0207e2e <vfs_get_root+0x4a>
ffffffffc0207e68:	fe843503          	ld	a0,-24(s0)
ffffffffc0207e6c:	a99ff0ef          	jal	ra,ffffffffc0207904 <inode_ref_inc>
ffffffffc0207e70:	fe843503          	ld	a0,-24(s0)
ffffffffc0207e74:	b7cd                	j	ffffffffc0207e56 <vfs_get_root+0x72>
ffffffffc0207e76:	54cd                	li	s1,-13
ffffffffc0207e78:	b7c9                	j	ffffffffc0207e3a <vfs_get_root+0x56>
ffffffffc0207e7a:	00006697          	auipc	a3,0x6
ffffffffc0207e7e:	76668693          	addi	a3,a3,1894 # ffffffffc020e5e0 <syscalls+0xa48>
ffffffffc0207e82:	00004617          	auipc	a2,0x4
ffffffffc0207e86:	bc660613          	addi	a2,a2,-1082 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207e8a:	04500593          	li	a1,69
ffffffffc0207e8e:	00006517          	auipc	a0,0x6
ffffffffc0207e92:	76250513          	addi	a0,a0,1890 # ffffffffc020e5f0 <syscalls+0xa58>
ffffffffc0207e96:	e08f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207e9a <vfs_get_devname>:
ffffffffc0207e9a:	0008e697          	auipc	a3,0x8e
ffffffffc0207e9e:	97e68693          	addi	a3,a3,-1666 # ffffffffc0295818 <vdev_list>
ffffffffc0207ea2:	87b6                	mv	a5,a3
ffffffffc0207ea4:	e511                	bnez	a0,ffffffffc0207eb0 <vfs_get_devname+0x16>
ffffffffc0207ea6:	a829                	j	ffffffffc0207ec0 <vfs_get_devname+0x26>
ffffffffc0207ea8:	ff07b703          	ld	a4,-16(a5)
ffffffffc0207eac:	00a70763          	beq	a4,a0,ffffffffc0207eba <vfs_get_devname+0x20>
ffffffffc0207eb0:	679c                	ld	a5,8(a5)
ffffffffc0207eb2:	fed79be3          	bne	a5,a3,ffffffffc0207ea8 <vfs_get_devname+0xe>
ffffffffc0207eb6:	4501                	li	a0,0
ffffffffc0207eb8:	8082                	ret
ffffffffc0207eba:	fe07b503          	ld	a0,-32(a5)
ffffffffc0207ebe:	8082                	ret
ffffffffc0207ec0:	1141                	addi	sp,sp,-16
ffffffffc0207ec2:	00006697          	auipc	a3,0x6
ffffffffc0207ec6:	7a668693          	addi	a3,a3,1958 # ffffffffc020e668 <syscalls+0xad0>
ffffffffc0207eca:	00004617          	auipc	a2,0x4
ffffffffc0207ece:	b7e60613          	addi	a2,a2,-1154 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207ed2:	06a00593          	li	a1,106
ffffffffc0207ed6:	00006517          	auipc	a0,0x6
ffffffffc0207eda:	71a50513          	addi	a0,a0,1818 # ffffffffc020e5f0 <syscalls+0xa58>
ffffffffc0207ede:	e406                	sd	ra,8(sp)
ffffffffc0207ee0:	dbef80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0207ee4 <vfs_add_dev>:
ffffffffc0207ee4:	86b2                	mv	a3,a2
ffffffffc0207ee6:	4601                	li	a2,0
ffffffffc0207ee8:	d3fff06f          	j	ffffffffc0207c26 <vfs_do_add>

ffffffffc0207eec <vfs_mount>:
ffffffffc0207eec:	7179                	addi	sp,sp,-48
ffffffffc0207eee:	e84a                	sd	s2,16(sp)
ffffffffc0207ef0:	892a                	mv	s2,a0
ffffffffc0207ef2:	0008e517          	auipc	a0,0x8e
ffffffffc0207ef6:	93650513          	addi	a0,a0,-1738 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207efa:	e44e                	sd	s3,8(sp)
ffffffffc0207efc:	f406                	sd	ra,40(sp)
ffffffffc0207efe:	f022                	sd	s0,32(sp)
ffffffffc0207f00:	ec26                	sd	s1,24(sp)
ffffffffc0207f02:	89ae                	mv	s3,a1
ffffffffc0207f04:	e60fc0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc0207f08:	08090a63          	beqz	s2,ffffffffc0207f9c <vfs_mount+0xb0>
ffffffffc0207f0c:	0008e497          	auipc	s1,0x8e
ffffffffc0207f10:	90c48493          	addi	s1,s1,-1780 # ffffffffc0295818 <vdev_list>
ffffffffc0207f14:	6480                	ld	s0,8(s1)
ffffffffc0207f16:	00941663          	bne	s0,s1,ffffffffc0207f22 <vfs_mount+0x36>
ffffffffc0207f1a:	a8ad                	j	ffffffffc0207f94 <vfs_mount+0xa8>
ffffffffc0207f1c:	6400                	ld	s0,8(s0)
ffffffffc0207f1e:	06940b63          	beq	s0,s1,ffffffffc0207f94 <vfs_mount+0xa8>
ffffffffc0207f22:	ff843783          	ld	a5,-8(s0)
ffffffffc0207f26:	dbfd                	beqz	a5,ffffffffc0207f1c <vfs_mount+0x30>
ffffffffc0207f28:	fe043503          	ld	a0,-32(s0)
ffffffffc0207f2c:	85ca                	mv	a1,s2
ffffffffc0207f2e:	5de030ef          	jal	ra,ffffffffc020b50c <strcmp>
ffffffffc0207f32:	f56d                	bnez	a0,ffffffffc0207f1c <vfs_mount+0x30>
ffffffffc0207f34:	ff043783          	ld	a5,-16(s0)
ffffffffc0207f38:	e3a5                	bnez	a5,ffffffffc0207f98 <vfs_mount+0xac>
ffffffffc0207f3a:	fe043783          	ld	a5,-32(s0)
ffffffffc0207f3e:	c3c9                	beqz	a5,ffffffffc0207fc0 <vfs_mount+0xd4>
ffffffffc0207f40:	ff843783          	ld	a5,-8(s0)
ffffffffc0207f44:	cfb5                	beqz	a5,ffffffffc0207fc0 <vfs_mount+0xd4>
ffffffffc0207f46:	fe843503          	ld	a0,-24(s0)
ffffffffc0207f4a:	c939                	beqz	a0,ffffffffc0207fa0 <vfs_mount+0xb4>
ffffffffc0207f4c:	4d38                	lw	a4,88(a0)
ffffffffc0207f4e:	6785                	lui	a5,0x1
ffffffffc0207f50:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0207f54:	04f71663          	bne	a4,a5,ffffffffc0207fa0 <vfs_mount+0xb4>
ffffffffc0207f58:	ff040593          	addi	a1,s0,-16
ffffffffc0207f5c:	9982                	jalr	s3
ffffffffc0207f5e:	84aa                	mv	s1,a0
ffffffffc0207f60:	ed01                	bnez	a0,ffffffffc0207f78 <vfs_mount+0x8c>
ffffffffc0207f62:	ff043783          	ld	a5,-16(s0)
ffffffffc0207f66:	cfad                	beqz	a5,ffffffffc0207fe0 <vfs_mount+0xf4>
ffffffffc0207f68:	fe043583          	ld	a1,-32(s0)
ffffffffc0207f6c:	00006517          	auipc	a0,0x6
ffffffffc0207f70:	78c50513          	addi	a0,a0,1932 # ffffffffc020e6f8 <syscalls+0xb60>
ffffffffc0207f74:	a32f80ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0207f78:	0008e517          	auipc	a0,0x8e
ffffffffc0207f7c:	8b050513          	addi	a0,a0,-1872 # ffffffffc0295828 <vdev_list_sem>
ffffffffc0207f80:	de0fc0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc0207f84:	70a2                	ld	ra,40(sp)
ffffffffc0207f86:	7402                	ld	s0,32(sp)
ffffffffc0207f88:	6942                	ld	s2,16(sp)
ffffffffc0207f8a:	69a2                	ld	s3,8(sp)
ffffffffc0207f8c:	8526                	mv	a0,s1
ffffffffc0207f8e:	64e2                	ld	s1,24(sp)
ffffffffc0207f90:	6145                	addi	sp,sp,48
ffffffffc0207f92:	8082                	ret
ffffffffc0207f94:	54cd                	li	s1,-13
ffffffffc0207f96:	b7cd                	j	ffffffffc0207f78 <vfs_mount+0x8c>
ffffffffc0207f98:	54c5                	li	s1,-15
ffffffffc0207f9a:	bff9                	j	ffffffffc0207f78 <vfs_mount+0x8c>
ffffffffc0207f9c:	db3ff0ef          	jal	ra,ffffffffc0207d4e <find_mount.part.0>
ffffffffc0207fa0:	00006697          	auipc	a3,0x6
ffffffffc0207fa4:	70868693          	addi	a3,a3,1800 # ffffffffc020e6a8 <syscalls+0xb10>
ffffffffc0207fa8:	00004617          	auipc	a2,0x4
ffffffffc0207fac:	aa060613          	addi	a2,a2,-1376 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207fb0:	0ed00593          	li	a1,237
ffffffffc0207fb4:	00006517          	auipc	a0,0x6
ffffffffc0207fb8:	63c50513          	addi	a0,a0,1596 # ffffffffc020e5f0 <syscalls+0xa58>
ffffffffc0207fbc:	ce2f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207fc0:	00006697          	auipc	a3,0x6
ffffffffc0207fc4:	6b868693          	addi	a3,a3,1720 # ffffffffc020e678 <syscalls+0xae0>
ffffffffc0207fc8:	00004617          	auipc	a2,0x4
ffffffffc0207fcc:	a8060613          	addi	a2,a2,-1408 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207fd0:	0eb00593          	li	a1,235
ffffffffc0207fd4:	00006517          	auipc	a0,0x6
ffffffffc0207fd8:	61c50513          	addi	a0,a0,1564 # ffffffffc020e5f0 <syscalls+0xa58>
ffffffffc0207fdc:	cc2f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0207fe0:	00006697          	auipc	a3,0x6
ffffffffc0207fe4:	70068693          	addi	a3,a3,1792 # ffffffffc020e6e0 <syscalls+0xb48>
ffffffffc0207fe8:	00004617          	auipc	a2,0x4
ffffffffc0207fec:	a6060613          	addi	a2,a2,-1440 # ffffffffc020ba48 <commands+0x210>
ffffffffc0207ff0:	0ef00593          	li	a1,239
ffffffffc0207ff4:	00006517          	auipc	a0,0x6
ffffffffc0207ff8:	5fc50513          	addi	a0,a0,1532 # ffffffffc020e5f0 <syscalls+0xa58>
ffffffffc0207ffc:	ca2f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208000 <vfs_open>:
ffffffffc0208000:	711d                	addi	sp,sp,-96
ffffffffc0208002:	e4a6                	sd	s1,72(sp)
ffffffffc0208004:	e0ca                	sd	s2,64(sp)
ffffffffc0208006:	fc4e                	sd	s3,56(sp)
ffffffffc0208008:	ec86                	sd	ra,88(sp)
ffffffffc020800a:	e8a2                	sd	s0,80(sp)
ffffffffc020800c:	f852                	sd	s4,48(sp)
ffffffffc020800e:	f456                	sd	s5,40(sp)
ffffffffc0208010:	0035f793          	andi	a5,a1,3
ffffffffc0208014:	84ae                	mv	s1,a1
ffffffffc0208016:	892a                	mv	s2,a0
ffffffffc0208018:	89b2                	mv	s3,a2
ffffffffc020801a:	0e078663          	beqz	a5,ffffffffc0208106 <vfs_open+0x106>
ffffffffc020801e:	470d                	li	a4,3
ffffffffc0208020:	0105fa93          	andi	s5,a1,16
ffffffffc0208024:	0ce78f63          	beq	a5,a4,ffffffffc0208102 <vfs_open+0x102>
ffffffffc0208028:	002c                	addi	a1,sp,8
ffffffffc020802a:	854a                	mv	a0,s2
ffffffffc020802c:	2ae000ef          	jal	ra,ffffffffc02082da <vfs_lookup>
ffffffffc0208030:	842a                	mv	s0,a0
ffffffffc0208032:	0044fa13          	andi	s4,s1,4
ffffffffc0208036:	e159                	bnez	a0,ffffffffc02080bc <vfs_open+0xbc>
ffffffffc0208038:	00c4f793          	andi	a5,s1,12
ffffffffc020803c:	4731                	li	a4,12
ffffffffc020803e:	0ee78263          	beq	a5,a4,ffffffffc0208122 <vfs_open+0x122>
ffffffffc0208042:	6422                	ld	s0,8(sp)
ffffffffc0208044:	12040163          	beqz	s0,ffffffffc0208166 <vfs_open+0x166>
ffffffffc0208048:	783c                	ld	a5,112(s0)
ffffffffc020804a:	cff1                	beqz	a5,ffffffffc0208126 <vfs_open+0x126>
ffffffffc020804c:	679c                	ld	a5,8(a5)
ffffffffc020804e:	cfe1                	beqz	a5,ffffffffc0208126 <vfs_open+0x126>
ffffffffc0208050:	8522                	mv	a0,s0
ffffffffc0208052:	00006597          	auipc	a1,0x6
ffffffffc0208056:	78658593          	addi	a1,a1,1926 # ffffffffc020e7d8 <syscalls+0xc40>
ffffffffc020805a:	8c3ff0ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc020805e:	783c                	ld	a5,112(s0)
ffffffffc0208060:	6522                	ld	a0,8(sp)
ffffffffc0208062:	85a6                	mv	a1,s1
ffffffffc0208064:	679c                	ld	a5,8(a5)
ffffffffc0208066:	9782                	jalr	a5
ffffffffc0208068:	842a                	mv	s0,a0
ffffffffc020806a:	6522                	ld	a0,8(sp)
ffffffffc020806c:	e845                	bnez	s0,ffffffffc020811c <vfs_open+0x11c>
ffffffffc020806e:	015a6a33          	or	s4,s4,s5
ffffffffc0208072:	89fff0ef          	jal	ra,ffffffffc0207910 <inode_open_inc>
ffffffffc0208076:	020a0663          	beqz	s4,ffffffffc02080a2 <vfs_open+0xa2>
ffffffffc020807a:	64a2                	ld	s1,8(sp)
ffffffffc020807c:	c4e9                	beqz	s1,ffffffffc0208146 <vfs_open+0x146>
ffffffffc020807e:	78bc                	ld	a5,112(s1)
ffffffffc0208080:	c3f9                	beqz	a5,ffffffffc0208146 <vfs_open+0x146>
ffffffffc0208082:	73bc                	ld	a5,96(a5)
ffffffffc0208084:	c3e9                	beqz	a5,ffffffffc0208146 <vfs_open+0x146>
ffffffffc0208086:	00006597          	auipc	a1,0x6
ffffffffc020808a:	7b258593          	addi	a1,a1,1970 # ffffffffc020e838 <syscalls+0xca0>
ffffffffc020808e:	8526                	mv	a0,s1
ffffffffc0208090:	88dff0ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc0208094:	78bc                	ld	a5,112(s1)
ffffffffc0208096:	6522                	ld	a0,8(sp)
ffffffffc0208098:	4581                	li	a1,0
ffffffffc020809a:	73bc                	ld	a5,96(a5)
ffffffffc020809c:	9782                	jalr	a5
ffffffffc020809e:	87aa                	mv	a5,a0
ffffffffc02080a0:	e92d                	bnez	a0,ffffffffc0208112 <vfs_open+0x112>
ffffffffc02080a2:	67a2                	ld	a5,8(sp)
ffffffffc02080a4:	00f9b023          	sd	a5,0(s3)
ffffffffc02080a8:	60e6                	ld	ra,88(sp)
ffffffffc02080aa:	8522                	mv	a0,s0
ffffffffc02080ac:	6446                	ld	s0,80(sp)
ffffffffc02080ae:	64a6                	ld	s1,72(sp)
ffffffffc02080b0:	6906                	ld	s2,64(sp)
ffffffffc02080b2:	79e2                	ld	s3,56(sp)
ffffffffc02080b4:	7a42                	ld	s4,48(sp)
ffffffffc02080b6:	7aa2                	ld	s5,40(sp)
ffffffffc02080b8:	6125                	addi	sp,sp,96
ffffffffc02080ba:	8082                	ret
ffffffffc02080bc:	57c1                	li	a5,-16
ffffffffc02080be:	fef515e3          	bne	a0,a5,ffffffffc02080a8 <vfs_open+0xa8>
ffffffffc02080c2:	fe0a03e3          	beqz	s4,ffffffffc02080a8 <vfs_open+0xa8>
ffffffffc02080c6:	0810                	addi	a2,sp,16
ffffffffc02080c8:	082c                	addi	a1,sp,24
ffffffffc02080ca:	854a                	mv	a0,s2
ffffffffc02080cc:	2a4000ef          	jal	ra,ffffffffc0208370 <vfs_lookup_parent>
ffffffffc02080d0:	842a                	mv	s0,a0
ffffffffc02080d2:	f979                	bnez	a0,ffffffffc02080a8 <vfs_open+0xa8>
ffffffffc02080d4:	6462                	ld	s0,24(sp)
ffffffffc02080d6:	c845                	beqz	s0,ffffffffc0208186 <vfs_open+0x186>
ffffffffc02080d8:	783c                	ld	a5,112(s0)
ffffffffc02080da:	c7d5                	beqz	a5,ffffffffc0208186 <vfs_open+0x186>
ffffffffc02080dc:	77bc                	ld	a5,104(a5)
ffffffffc02080de:	c7c5                	beqz	a5,ffffffffc0208186 <vfs_open+0x186>
ffffffffc02080e0:	8522                	mv	a0,s0
ffffffffc02080e2:	00006597          	auipc	a1,0x6
ffffffffc02080e6:	68e58593          	addi	a1,a1,1678 # ffffffffc020e770 <syscalls+0xbd8>
ffffffffc02080ea:	833ff0ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc02080ee:	783c                	ld	a5,112(s0)
ffffffffc02080f0:	65c2                	ld	a1,16(sp)
ffffffffc02080f2:	6562                	ld	a0,24(sp)
ffffffffc02080f4:	77bc                	ld	a5,104(a5)
ffffffffc02080f6:	4034d613          	srai	a2,s1,0x3
ffffffffc02080fa:	0034                	addi	a3,sp,8
ffffffffc02080fc:	8a05                	andi	a2,a2,1
ffffffffc02080fe:	9782                	jalr	a5
ffffffffc0208100:	b789                	j	ffffffffc0208042 <vfs_open+0x42>
ffffffffc0208102:	5475                	li	s0,-3
ffffffffc0208104:	b755                	j	ffffffffc02080a8 <vfs_open+0xa8>
ffffffffc0208106:	0105fa93          	andi	s5,a1,16
ffffffffc020810a:	5475                	li	s0,-3
ffffffffc020810c:	f80a9ee3          	bnez	s5,ffffffffc02080a8 <vfs_open+0xa8>
ffffffffc0208110:	bf21                	j	ffffffffc0208028 <vfs_open+0x28>
ffffffffc0208112:	6522                	ld	a0,8(sp)
ffffffffc0208114:	843e                	mv	s0,a5
ffffffffc0208116:	965ff0ef          	jal	ra,ffffffffc0207a7a <inode_open_dec>
ffffffffc020811a:	6522                	ld	a0,8(sp)
ffffffffc020811c:	8b7ff0ef          	jal	ra,ffffffffc02079d2 <inode_ref_dec>
ffffffffc0208120:	b761                	j	ffffffffc02080a8 <vfs_open+0xa8>
ffffffffc0208122:	5425                	li	s0,-23
ffffffffc0208124:	b751                	j	ffffffffc02080a8 <vfs_open+0xa8>
ffffffffc0208126:	00006697          	auipc	a3,0x6
ffffffffc020812a:	66268693          	addi	a3,a3,1634 # ffffffffc020e788 <syscalls+0xbf0>
ffffffffc020812e:	00004617          	auipc	a2,0x4
ffffffffc0208132:	91a60613          	addi	a2,a2,-1766 # ffffffffc020ba48 <commands+0x210>
ffffffffc0208136:	03300593          	li	a1,51
ffffffffc020813a:	00006517          	auipc	a0,0x6
ffffffffc020813e:	61e50513          	addi	a0,a0,1566 # ffffffffc020e758 <syscalls+0xbc0>
ffffffffc0208142:	b5cf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208146:	00006697          	auipc	a3,0x6
ffffffffc020814a:	69a68693          	addi	a3,a3,1690 # ffffffffc020e7e0 <syscalls+0xc48>
ffffffffc020814e:	00004617          	auipc	a2,0x4
ffffffffc0208152:	8fa60613          	addi	a2,a2,-1798 # ffffffffc020ba48 <commands+0x210>
ffffffffc0208156:	03a00593          	li	a1,58
ffffffffc020815a:	00006517          	auipc	a0,0x6
ffffffffc020815e:	5fe50513          	addi	a0,a0,1534 # ffffffffc020e758 <syscalls+0xbc0>
ffffffffc0208162:	b3cf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208166:	00006697          	auipc	a3,0x6
ffffffffc020816a:	61268693          	addi	a3,a3,1554 # ffffffffc020e778 <syscalls+0xbe0>
ffffffffc020816e:	00004617          	auipc	a2,0x4
ffffffffc0208172:	8da60613          	addi	a2,a2,-1830 # ffffffffc020ba48 <commands+0x210>
ffffffffc0208176:	03100593          	li	a1,49
ffffffffc020817a:	00006517          	auipc	a0,0x6
ffffffffc020817e:	5de50513          	addi	a0,a0,1502 # ffffffffc020e758 <syscalls+0xbc0>
ffffffffc0208182:	b1cf80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208186:	00006697          	auipc	a3,0x6
ffffffffc020818a:	58268693          	addi	a3,a3,1410 # ffffffffc020e708 <syscalls+0xb70>
ffffffffc020818e:	00004617          	auipc	a2,0x4
ffffffffc0208192:	8ba60613          	addi	a2,a2,-1862 # ffffffffc020ba48 <commands+0x210>
ffffffffc0208196:	02c00593          	li	a1,44
ffffffffc020819a:	00006517          	auipc	a0,0x6
ffffffffc020819e:	5be50513          	addi	a0,a0,1470 # ffffffffc020e758 <syscalls+0xbc0>
ffffffffc02081a2:	afcf80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02081a6 <vfs_close>:
ffffffffc02081a6:	1141                	addi	sp,sp,-16
ffffffffc02081a8:	e406                	sd	ra,8(sp)
ffffffffc02081aa:	e022                	sd	s0,0(sp)
ffffffffc02081ac:	842a                	mv	s0,a0
ffffffffc02081ae:	8cdff0ef          	jal	ra,ffffffffc0207a7a <inode_open_dec>
ffffffffc02081b2:	8522                	mv	a0,s0
ffffffffc02081b4:	81fff0ef          	jal	ra,ffffffffc02079d2 <inode_ref_dec>
ffffffffc02081b8:	60a2                	ld	ra,8(sp)
ffffffffc02081ba:	6402                	ld	s0,0(sp)
ffffffffc02081bc:	4501                	li	a0,0
ffffffffc02081be:	0141                	addi	sp,sp,16
ffffffffc02081c0:	8082                	ret

ffffffffc02081c2 <get_device>:
ffffffffc02081c2:	7179                	addi	sp,sp,-48
ffffffffc02081c4:	ec26                	sd	s1,24(sp)
ffffffffc02081c6:	e84a                	sd	s2,16(sp)
ffffffffc02081c8:	f406                	sd	ra,40(sp)
ffffffffc02081ca:	f022                	sd	s0,32(sp)
ffffffffc02081cc:	00054303          	lbu	t1,0(a0)
ffffffffc02081d0:	892e                	mv	s2,a1
ffffffffc02081d2:	84b2                	mv	s1,a2
ffffffffc02081d4:	02030463          	beqz	t1,ffffffffc02081fc <get_device+0x3a>
ffffffffc02081d8:	00150413          	addi	s0,a0,1
ffffffffc02081dc:	86a2                	mv	a3,s0
ffffffffc02081de:	879a                	mv	a5,t1
ffffffffc02081e0:	4701                	li	a4,0
ffffffffc02081e2:	03a00813          	li	a6,58
ffffffffc02081e6:	02f00893          	li	a7,47
ffffffffc02081ea:	03078263          	beq	a5,a6,ffffffffc020820e <get_device+0x4c>
ffffffffc02081ee:	05178963          	beq	a5,a7,ffffffffc0208240 <get_device+0x7e>
ffffffffc02081f2:	0006c783          	lbu	a5,0(a3)
ffffffffc02081f6:	2705                	addiw	a4,a4,1
ffffffffc02081f8:	0685                	addi	a3,a3,1
ffffffffc02081fa:	fbe5                	bnez	a5,ffffffffc02081ea <get_device+0x28>
ffffffffc02081fc:	7402                	ld	s0,32(sp)
ffffffffc02081fe:	00a93023          	sd	a0,0(s2)
ffffffffc0208202:	70a2                	ld	ra,40(sp)
ffffffffc0208204:	6942                	ld	s2,16(sp)
ffffffffc0208206:	8526                	mv	a0,s1
ffffffffc0208208:	64e2                	ld	s1,24(sp)
ffffffffc020820a:	6145                	addi	sp,sp,48
ffffffffc020820c:	a279                	j	ffffffffc020839a <vfs_get_curdir>
ffffffffc020820e:	cb15                	beqz	a4,ffffffffc0208242 <get_device+0x80>
ffffffffc0208210:	00e507b3          	add	a5,a0,a4
ffffffffc0208214:	0705                	addi	a4,a4,1
ffffffffc0208216:	00078023          	sb	zero,0(a5)
ffffffffc020821a:	972a                	add	a4,a4,a0
ffffffffc020821c:	02f00613          	li	a2,47
ffffffffc0208220:	00074783          	lbu	a5,0(a4)
ffffffffc0208224:	86ba                	mv	a3,a4
ffffffffc0208226:	0705                	addi	a4,a4,1
ffffffffc0208228:	fec78ce3          	beq	a5,a2,ffffffffc0208220 <get_device+0x5e>
ffffffffc020822c:	7402                	ld	s0,32(sp)
ffffffffc020822e:	70a2                	ld	ra,40(sp)
ffffffffc0208230:	00d93023          	sd	a3,0(s2)
ffffffffc0208234:	85a6                	mv	a1,s1
ffffffffc0208236:	6942                	ld	s2,16(sp)
ffffffffc0208238:	64e2                	ld	s1,24(sp)
ffffffffc020823a:	6145                	addi	sp,sp,48
ffffffffc020823c:	ba9ff06f          	j	ffffffffc0207de4 <vfs_get_root>
ffffffffc0208240:	ff55                	bnez	a4,ffffffffc02081fc <get_device+0x3a>
ffffffffc0208242:	02f00793          	li	a5,47
ffffffffc0208246:	04f30563          	beq	t1,a5,ffffffffc0208290 <get_device+0xce>
ffffffffc020824a:	03a00793          	li	a5,58
ffffffffc020824e:	06f31663          	bne	t1,a5,ffffffffc02082ba <get_device+0xf8>
ffffffffc0208252:	0028                	addi	a0,sp,8
ffffffffc0208254:	146000ef          	jal	ra,ffffffffc020839a <vfs_get_curdir>
ffffffffc0208258:	e515                	bnez	a0,ffffffffc0208284 <get_device+0xc2>
ffffffffc020825a:	67a2                	ld	a5,8(sp)
ffffffffc020825c:	77a8                	ld	a0,104(a5)
ffffffffc020825e:	cd15                	beqz	a0,ffffffffc020829a <get_device+0xd8>
ffffffffc0208260:	617c                	ld	a5,192(a0)
ffffffffc0208262:	9782                	jalr	a5
ffffffffc0208264:	87aa                	mv	a5,a0
ffffffffc0208266:	6522                	ld	a0,8(sp)
ffffffffc0208268:	e09c                	sd	a5,0(s1)
ffffffffc020826a:	f68ff0ef          	jal	ra,ffffffffc02079d2 <inode_ref_dec>
ffffffffc020826e:	02f00713          	li	a4,47
ffffffffc0208272:	a011                	j	ffffffffc0208276 <get_device+0xb4>
ffffffffc0208274:	0405                	addi	s0,s0,1
ffffffffc0208276:	00044783          	lbu	a5,0(s0)
ffffffffc020827a:	fee78de3          	beq	a5,a4,ffffffffc0208274 <get_device+0xb2>
ffffffffc020827e:	00893023          	sd	s0,0(s2)
ffffffffc0208282:	4501                	li	a0,0
ffffffffc0208284:	70a2                	ld	ra,40(sp)
ffffffffc0208286:	7402                	ld	s0,32(sp)
ffffffffc0208288:	64e2                	ld	s1,24(sp)
ffffffffc020828a:	6942                	ld	s2,16(sp)
ffffffffc020828c:	6145                	addi	sp,sp,48
ffffffffc020828e:	8082                	ret
ffffffffc0208290:	8526                	mv	a0,s1
ffffffffc0208292:	93fff0ef          	jal	ra,ffffffffc0207bd0 <vfs_get_bootfs>
ffffffffc0208296:	dd61                	beqz	a0,ffffffffc020826e <get_device+0xac>
ffffffffc0208298:	b7f5                	j	ffffffffc0208284 <get_device+0xc2>
ffffffffc020829a:	00006697          	auipc	a3,0x6
ffffffffc020829e:	5d668693          	addi	a3,a3,1494 # ffffffffc020e870 <syscalls+0xcd8>
ffffffffc02082a2:	00003617          	auipc	a2,0x3
ffffffffc02082a6:	7a660613          	addi	a2,a2,1958 # ffffffffc020ba48 <commands+0x210>
ffffffffc02082aa:	03900593          	li	a1,57
ffffffffc02082ae:	00006517          	auipc	a0,0x6
ffffffffc02082b2:	5aa50513          	addi	a0,a0,1450 # ffffffffc020e858 <syscalls+0xcc0>
ffffffffc02082b6:	9e8f80ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02082ba:	00006697          	auipc	a3,0x6
ffffffffc02082be:	58e68693          	addi	a3,a3,1422 # ffffffffc020e848 <syscalls+0xcb0>
ffffffffc02082c2:	00003617          	auipc	a2,0x3
ffffffffc02082c6:	78660613          	addi	a2,a2,1926 # ffffffffc020ba48 <commands+0x210>
ffffffffc02082ca:	03300593          	li	a1,51
ffffffffc02082ce:	00006517          	auipc	a0,0x6
ffffffffc02082d2:	58a50513          	addi	a0,a0,1418 # ffffffffc020e858 <syscalls+0xcc0>
ffffffffc02082d6:	9c8f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02082da <vfs_lookup>:
ffffffffc02082da:	7139                	addi	sp,sp,-64
ffffffffc02082dc:	f426                	sd	s1,40(sp)
ffffffffc02082de:	0830                	addi	a2,sp,24
ffffffffc02082e0:	84ae                	mv	s1,a1
ffffffffc02082e2:	002c                	addi	a1,sp,8
ffffffffc02082e4:	f822                	sd	s0,48(sp)
ffffffffc02082e6:	fc06                	sd	ra,56(sp)
ffffffffc02082e8:	f04a                	sd	s2,32(sp)
ffffffffc02082ea:	e42a                	sd	a0,8(sp)
ffffffffc02082ec:	ed7ff0ef          	jal	ra,ffffffffc02081c2 <get_device>
ffffffffc02082f0:	842a                	mv	s0,a0
ffffffffc02082f2:	ed1d                	bnez	a0,ffffffffc0208330 <vfs_lookup+0x56>
ffffffffc02082f4:	67a2                	ld	a5,8(sp)
ffffffffc02082f6:	6962                	ld	s2,24(sp)
ffffffffc02082f8:	0007c783          	lbu	a5,0(a5)
ffffffffc02082fc:	c3a9                	beqz	a5,ffffffffc020833e <vfs_lookup+0x64>
ffffffffc02082fe:	04090963          	beqz	s2,ffffffffc0208350 <vfs_lookup+0x76>
ffffffffc0208302:	07093783          	ld	a5,112(s2)
ffffffffc0208306:	c7a9                	beqz	a5,ffffffffc0208350 <vfs_lookup+0x76>
ffffffffc0208308:	7bbc                	ld	a5,112(a5)
ffffffffc020830a:	c3b9                	beqz	a5,ffffffffc0208350 <vfs_lookup+0x76>
ffffffffc020830c:	854a                	mv	a0,s2
ffffffffc020830e:	00006597          	auipc	a1,0x6
ffffffffc0208312:	5ca58593          	addi	a1,a1,1482 # ffffffffc020e8d8 <syscalls+0xd40>
ffffffffc0208316:	e06ff0ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc020831a:	07093783          	ld	a5,112(s2)
ffffffffc020831e:	65a2                	ld	a1,8(sp)
ffffffffc0208320:	6562                	ld	a0,24(sp)
ffffffffc0208322:	7bbc                	ld	a5,112(a5)
ffffffffc0208324:	8626                	mv	a2,s1
ffffffffc0208326:	9782                	jalr	a5
ffffffffc0208328:	842a                	mv	s0,a0
ffffffffc020832a:	6562                	ld	a0,24(sp)
ffffffffc020832c:	ea6ff0ef          	jal	ra,ffffffffc02079d2 <inode_ref_dec>
ffffffffc0208330:	70e2                	ld	ra,56(sp)
ffffffffc0208332:	8522                	mv	a0,s0
ffffffffc0208334:	7442                	ld	s0,48(sp)
ffffffffc0208336:	74a2                	ld	s1,40(sp)
ffffffffc0208338:	7902                	ld	s2,32(sp)
ffffffffc020833a:	6121                	addi	sp,sp,64
ffffffffc020833c:	8082                	ret
ffffffffc020833e:	70e2                	ld	ra,56(sp)
ffffffffc0208340:	8522                	mv	a0,s0
ffffffffc0208342:	7442                	ld	s0,48(sp)
ffffffffc0208344:	0124b023          	sd	s2,0(s1)
ffffffffc0208348:	74a2                	ld	s1,40(sp)
ffffffffc020834a:	7902                	ld	s2,32(sp)
ffffffffc020834c:	6121                	addi	sp,sp,64
ffffffffc020834e:	8082                	ret
ffffffffc0208350:	00006697          	auipc	a3,0x6
ffffffffc0208354:	53868693          	addi	a3,a3,1336 # ffffffffc020e888 <syscalls+0xcf0>
ffffffffc0208358:	00003617          	auipc	a2,0x3
ffffffffc020835c:	6f060613          	addi	a2,a2,1776 # ffffffffc020ba48 <commands+0x210>
ffffffffc0208360:	04f00593          	li	a1,79
ffffffffc0208364:	00006517          	auipc	a0,0x6
ffffffffc0208368:	4f450513          	addi	a0,a0,1268 # ffffffffc020e858 <syscalls+0xcc0>
ffffffffc020836c:	932f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208370 <vfs_lookup_parent>:
ffffffffc0208370:	7139                	addi	sp,sp,-64
ffffffffc0208372:	f822                	sd	s0,48(sp)
ffffffffc0208374:	f426                	sd	s1,40(sp)
ffffffffc0208376:	842e                	mv	s0,a1
ffffffffc0208378:	84b2                	mv	s1,a2
ffffffffc020837a:	002c                	addi	a1,sp,8
ffffffffc020837c:	0830                	addi	a2,sp,24
ffffffffc020837e:	fc06                	sd	ra,56(sp)
ffffffffc0208380:	e42a                	sd	a0,8(sp)
ffffffffc0208382:	e41ff0ef          	jal	ra,ffffffffc02081c2 <get_device>
ffffffffc0208386:	e509                	bnez	a0,ffffffffc0208390 <vfs_lookup_parent+0x20>
ffffffffc0208388:	67a2                	ld	a5,8(sp)
ffffffffc020838a:	e09c                	sd	a5,0(s1)
ffffffffc020838c:	67e2                	ld	a5,24(sp)
ffffffffc020838e:	e01c                	sd	a5,0(s0)
ffffffffc0208390:	70e2                	ld	ra,56(sp)
ffffffffc0208392:	7442                	ld	s0,48(sp)
ffffffffc0208394:	74a2                	ld	s1,40(sp)
ffffffffc0208396:	6121                	addi	sp,sp,64
ffffffffc0208398:	8082                	ret

ffffffffc020839a <vfs_get_curdir>:
ffffffffc020839a:	0008e797          	auipc	a5,0x8e
ffffffffc020839e:	5267b783          	ld	a5,1318(a5) # ffffffffc02968c0 <current>
ffffffffc02083a2:	1487b783          	ld	a5,328(a5)
ffffffffc02083a6:	1101                	addi	sp,sp,-32
ffffffffc02083a8:	e426                	sd	s1,8(sp)
ffffffffc02083aa:	6384                	ld	s1,0(a5)
ffffffffc02083ac:	ec06                	sd	ra,24(sp)
ffffffffc02083ae:	e822                	sd	s0,16(sp)
ffffffffc02083b0:	cc81                	beqz	s1,ffffffffc02083c8 <vfs_get_curdir+0x2e>
ffffffffc02083b2:	842a                	mv	s0,a0
ffffffffc02083b4:	8526                	mv	a0,s1
ffffffffc02083b6:	d4eff0ef          	jal	ra,ffffffffc0207904 <inode_ref_inc>
ffffffffc02083ba:	4501                	li	a0,0
ffffffffc02083bc:	e004                	sd	s1,0(s0)
ffffffffc02083be:	60e2                	ld	ra,24(sp)
ffffffffc02083c0:	6442                	ld	s0,16(sp)
ffffffffc02083c2:	64a2                	ld	s1,8(sp)
ffffffffc02083c4:	6105                	addi	sp,sp,32
ffffffffc02083c6:	8082                	ret
ffffffffc02083c8:	5541                	li	a0,-16
ffffffffc02083ca:	bfd5                	j	ffffffffc02083be <vfs_get_curdir+0x24>

ffffffffc02083cc <vfs_set_curdir>:
ffffffffc02083cc:	7139                	addi	sp,sp,-64
ffffffffc02083ce:	f04a                	sd	s2,32(sp)
ffffffffc02083d0:	0008e917          	auipc	s2,0x8e
ffffffffc02083d4:	4f090913          	addi	s2,s2,1264 # ffffffffc02968c0 <current>
ffffffffc02083d8:	00093783          	ld	a5,0(s2)
ffffffffc02083dc:	f822                	sd	s0,48(sp)
ffffffffc02083de:	842a                	mv	s0,a0
ffffffffc02083e0:	1487b503          	ld	a0,328(a5)
ffffffffc02083e4:	ec4e                	sd	s3,24(sp)
ffffffffc02083e6:	fc06                	sd	ra,56(sp)
ffffffffc02083e8:	f426                	sd	s1,40(sp)
ffffffffc02083ea:	dd9fc0ef          	jal	ra,ffffffffc02051c2 <lock_files>
ffffffffc02083ee:	00093783          	ld	a5,0(s2)
ffffffffc02083f2:	1487b503          	ld	a0,328(a5)
ffffffffc02083f6:	00053983          	ld	s3,0(a0)
ffffffffc02083fa:	07340963          	beq	s0,s3,ffffffffc020846c <vfs_set_curdir+0xa0>
ffffffffc02083fe:	cc39                	beqz	s0,ffffffffc020845c <vfs_set_curdir+0x90>
ffffffffc0208400:	783c                	ld	a5,112(s0)
ffffffffc0208402:	c7bd                	beqz	a5,ffffffffc0208470 <vfs_set_curdir+0xa4>
ffffffffc0208404:	6bbc                	ld	a5,80(a5)
ffffffffc0208406:	c7ad                	beqz	a5,ffffffffc0208470 <vfs_set_curdir+0xa4>
ffffffffc0208408:	00006597          	auipc	a1,0x6
ffffffffc020840c:	54058593          	addi	a1,a1,1344 # ffffffffc020e948 <syscalls+0xdb0>
ffffffffc0208410:	8522                	mv	a0,s0
ffffffffc0208412:	d0aff0ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc0208416:	783c                	ld	a5,112(s0)
ffffffffc0208418:	006c                	addi	a1,sp,12
ffffffffc020841a:	8522                	mv	a0,s0
ffffffffc020841c:	6bbc                	ld	a5,80(a5)
ffffffffc020841e:	9782                	jalr	a5
ffffffffc0208420:	84aa                	mv	s1,a0
ffffffffc0208422:	e901                	bnez	a0,ffffffffc0208432 <vfs_set_curdir+0x66>
ffffffffc0208424:	47b2                	lw	a5,12(sp)
ffffffffc0208426:	669d                	lui	a3,0x7
ffffffffc0208428:	6709                	lui	a4,0x2
ffffffffc020842a:	8ff5                	and	a5,a5,a3
ffffffffc020842c:	54b9                	li	s1,-18
ffffffffc020842e:	02e78063          	beq	a5,a4,ffffffffc020844e <vfs_set_curdir+0x82>
ffffffffc0208432:	00093783          	ld	a5,0(s2)
ffffffffc0208436:	1487b503          	ld	a0,328(a5)
ffffffffc020843a:	d8ffc0ef          	jal	ra,ffffffffc02051c8 <unlock_files>
ffffffffc020843e:	70e2                	ld	ra,56(sp)
ffffffffc0208440:	7442                	ld	s0,48(sp)
ffffffffc0208442:	7902                	ld	s2,32(sp)
ffffffffc0208444:	69e2                	ld	s3,24(sp)
ffffffffc0208446:	8526                	mv	a0,s1
ffffffffc0208448:	74a2                	ld	s1,40(sp)
ffffffffc020844a:	6121                	addi	sp,sp,64
ffffffffc020844c:	8082                	ret
ffffffffc020844e:	8522                	mv	a0,s0
ffffffffc0208450:	cb4ff0ef          	jal	ra,ffffffffc0207904 <inode_ref_inc>
ffffffffc0208454:	00093783          	ld	a5,0(s2)
ffffffffc0208458:	1487b503          	ld	a0,328(a5)
ffffffffc020845c:	e100                	sd	s0,0(a0)
ffffffffc020845e:	4481                	li	s1,0
ffffffffc0208460:	fc098de3          	beqz	s3,ffffffffc020843a <vfs_set_curdir+0x6e>
ffffffffc0208464:	854e                	mv	a0,s3
ffffffffc0208466:	d6cff0ef          	jal	ra,ffffffffc02079d2 <inode_ref_dec>
ffffffffc020846a:	b7e1                	j	ffffffffc0208432 <vfs_set_curdir+0x66>
ffffffffc020846c:	4481                	li	s1,0
ffffffffc020846e:	b7f1                	j	ffffffffc020843a <vfs_set_curdir+0x6e>
ffffffffc0208470:	00006697          	auipc	a3,0x6
ffffffffc0208474:	47068693          	addi	a3,a3,1136 # ffffffffc020e8e0 <syscalls+0xd48>
ffffffffc0208478:	00003617          	auipc	a2,0x3
ffffffffc020847c:	5d060613          	addi	a2,a2,1488 # ffffffffc020ba48 <commands+0x210>
ffffffffc0208480:	04300593          	li	a1,67
ffffffffc0208484:	00006517          	auipc	a0,0x6
ffffffffc0208488:	4ac50513          	addi	a0,a0,1196 # ffffffffc020e930 <syscalls+0xd98>
ffffffffc020848c:	812f80ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208490 <vfs_chdir>:
ffffffffc0208490:	1101                	addi	sp,sp,-32
ffffffffc0208492:	002c                	addi	a1,sp,8
ffffffffc0208494:	e822                	sd	s0,16(sp)
ffffffffc0208496:	ec06                	sd	ra,24(sp)
ffffffffc0208498:	e43ff0ef          	jal	ra,ffffffffc02082da <vfs_lookup>
ffffffffc020849c:	842a                	mv	s0,a0
ffffffffc020849e:	c511                	beqz	a0,ffffffffc02084aa <vfs_chdir+0x1a>
ffffffffc02084a0:	60e2                	ld	ra,24(sp)
ffffffffc02084a2:	8522                	mv	a0,s0
ffffffffc02084a4:	6442                	ld	s0,16(sp)
ffffffffc02084a6:	6105                	addi	sp,sp,32
ffffffffc02084a8:	8082                	ret
ffffffffc02084aa:	6522                	ld	a0,8(sp)
ffffffffc02084ac:	f21ff0ef          	jal	ra,ffffffffc02083cc <vfs_set_curdir>
ffffffffc02084b0:	842a                	mv	s0,a0
ffffffffc02084b2:	6522                	ld	a0,8(sp)
ffffffffc02084b4:	d1eff0ef          	jal	ra,ffffffffc02079d2 <inode_ref_dec>
ffffffffc02084b8:	60e2                	ld	ra,24(sp)
ffffffffc02084ba:	8522                	mv	a0,s0
ffffffffc02084bc:	6442                	ld	s0,16(sp)
ffffffffc02084be:	6105                	addi	sp,sp,32
ffffffffc02084c0:	8082                	ret

ffffffffc02084c2 <vfs_getcwd>:
ffffffffc02084c2:	0008e797          	auipc	a5,0x8e
ffffffffc02084c6:	3fe7b783          	ld	a5,1022(a5) # ffffffffc02968c0 <current>
ffffffffc02084ca:	1487b783          	ld	a5,328(a5)
ffffffffc02084ce:	7179                	addi	sp,sp,-48
ffffffffc02084d0:	ec26                	sd	s1,24(sp)
ffffffffc02084d2:	6384                	ld	s1,0(a5)
ffffffffc02084d4:	f406                	sd	ra,40(sp)
ffffffffc02084d6:	f022                	sd	s0,32(sp)
ffffffffc02084d8:	e84a                	sd	s2,16(sp)
ffffffffc02084da:	ccbd                	beqz	s1,ffffffffc0208558 <vfs_getcwd+0x96>
ffffffffc02084dc:	892a                	mv	s2,a0
ffffffffc02084de:	8526                	mv	a0,s1
ffffffffc02084e0:	c24ff0ef          	jal	ra,ffffffffc0207904 <inode_ref_inc>
ffffffffc02084e4:	74a8                	ld	a0,104(s1)
ffffffffc02084e6:	c93d                	beqz	a0,ffffffffc020855c <vfs_getcwd+0x9a>
ffffffffc02084e8:	9b3ff0ef          	jal	ra,ffffffffc0207e9a <vfs_get_devname>
ffffffffc02084ec:	842a                	mv	s0,a0
ffffffffc02084ee:	7d7020ef          	jal	ra,ffffffffc020b4c4 <strlen>
ffffffffc02084f2:	862a                	mv	a2,a0
ffffffffc02084f4:	85a2                	mv	a1,s0
ffffffffc02084f6:	4701                	li	a4,0
ffffffffc02084f8:	4685                	li	a3,1
ffffffffc02084fa:	854a                	mv	a0,s2
ffffffffc02084fc:	ef1fc0ef          	jal	ra,ffffffffc02053ec <iobuf_move>
ffffffffc0208500:	842a                	mv	s0,a0
ffffffffc0208502:	c919                	beqz	a0,ffffffffc0208518 <vfs_getcwd+0x56>
ffffffffc0208504:	8526                	mv	a0,s1
ffffffffc0208506:	cccff0ef          	jal	ra,ffffffffc02079d2 <inode_ref_dec>
ffffffffc020850a:	70a2                	ld	ra,40(sp)
ffffffffc020850c:	8522                	mv	a0,s0
ffffffffc020850e:	7402                	ld	s0,32(sp)
ffffffffc0208510:	64e2                	ld	s1,24(sp)
ffffffffc0208512:	6942                	ld	s2,16(sp)
ffffffffc0208514:	6145                	addi	sp,sp,48
ffffffffc0208516:	8082                	ret
ffffffffc0208518:	03a00793          	li	a5,58
ffffffffc020851c:	4701                	li	a4,0
ffffffffc020851e:	4685                	li	a3,1
ffffffffc0208520:	4605                	li	a2,1
ffffffffc0208522:	00f10593          	addi	a1,sp,15
ffffffffc0208526:	854a                	mv	a0,s2
ffffffffc0208528:	00f107a3          	sb	a5,15(sp)
ffffffffc020852c:	ec1fc0ef          	jal	ra,ffffffffc02053ec <iobuf_move>
ffffffffc0208530:	842a                	mv	s0,a0
ffffffffc0208532:	f969                	bnez	a0,ffffffffc0208504 <vfs_getcwd+0x42>
ffffffffc0208534:	78bc                	ld	a5,112(s1)
ffffffffc0208536:	c3b9                	beqz	a5,ffffffffc020857c <vfs_getcwd+0xba>
ffffffffc0208538:	7f9c                	ld	a5,56(a5)
ffffffffc020853a:	c3a9                	beqz	a5,ffffffffc020857c <vfs_getcwd+0xba>
ffffffffc020853c:	00006597          	auipc	a1,0x6
ffffffffc0208540:	46c58593          	addi	a1,a1,1132 # ffffffffc020e9a8 <syscalls+0xe10>
ffffffffc0208544:	8526                	mv	a0,s1
ffffffffc0208546:	bd6ff0ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc020854a:	78bc                	ld	a5,112(s1)
ffffffffc020854c:	85ca                	mv	a1,s2
ffffffffc020854e:	8526                	mv	a0,s1
ffffffffc0208550:	7f9c                	ld	a5,56(a5)
ffffffffc0208552:	9782                	jalr	a5
ffffffffc0208554:	842a                	mv	s0,a0
ffffffffc0208556:	b77d                	j	ffffffffc0208504 <vfs_getcwd+0x42>
ffffffffc0208558:	5441                	li	s0,-16
ffffffffc020855a:	bf45                	j	ffffffffc020850a <vfs_getcwd+0x48>
ffffffffc020855c:	00006697          	auipc	a3,0x6
ffffffffc0208560:	31468693          	addi	a3,a3,788 # ffffffffc020e870 <syscalls+0xcd8>
ffffffffc0208564:	00003617          	auipc	a2,0x3
ffffffffc0208568:	4e460613          	addi	a2,a2,1252 # ffffffffc020ba48 <commands+0x210>
ffffffffc020856c:	06e00593          	li	a1,110
ffffffffc0208570:	00006517          	auipc	a0,0x6
ffffffffc0208574:	3c050513          	addi	a0,a0,960 # ffffffffc020e930 <syscalls+0xd98>
ffffffffc0208578:	f27f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020857c:	00006697          	auipc	a3,0x6
ffffffffc0208580:	3d468693          	addi	a3,a3,980 # ffffffffc020e950 <syscalls+0xdb8>
ffffffffc0208584:	00003617          	auipc	a2,0x3
ffffffffc0208588:	4c460613          	addi	a2,a2,1220 # ffffffffc020ba48 <commands+0x210>
ffffffffc020858c:	07800593          	li	a1,120
ffffffffc0208590:	00006517          	auipc	a0,0x6
ffffffffc0208594:	3a050513          	addi	a0,a0,928 # ffffffffc020e930 <syscalls+0xd98>
ffffffffc0208598:	f07f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020859c <dev_lookup>:
ffffffffc020859c:	0005c783          	lbu	a5,0(a1)
ffffffffc02085a0:	e385                	bnez	a5,ffffffffc02085c0 <dev_lookup+0x24>
ffffffffc02085a2:	1101                	addi	sp,sp,-32
ffffffffc02085a4:	e822                	sd	s0,16(sp)
ffffffffc02085a6:	e426                	sd	s1,8(sp)
ffffffffc02085a8:	ec06                	sd	ra,24(sp)
ffffffffc02085aa:	84aa                	mv	s1,a0
ffffffffc02085ac:	8432                	mv	s0,a2
ffffffffc02085ae:	b56ff0ef          	jal	ra,ffffffffc0207904 <inode_ref_inc>
ffffffffc02085b2:	60e2                	ld	ra,24(sp)
ffffffffc02085b4:	e004                	sd	s1,0(s0)
ffffffffc02085b6:	6442                	ld	s0,16(sp)
ffffffffc02085b8:	64a2                	ld	s1,8(sp)
ffffffffc02085ba:	4501                	li	a0,0
ffffffffc02085bc:	6105                	addi	sp,sp,32
ffffffffc02085be:	8082                	ret
ffffffffc02085c0:	5541                	li	a0,-16
ffffffffc02085c2:	8082                	ret

ffffffffc02085c4 <dev_fstat>:
ffffffffc02085c4:	1101                	addi	sp,sp,-32
ffffffffc02085c6:	e426                	sd	s1,8(sp)
ffffffffc02085c8:	84ae                	mv	s1,a1
ffffffffc02085ca:	e822                	sd	s0,16(sp)
ffffffffc02085cc:	02000613          	li	a2,32
ffffffffc02085d0:	842a                	mv	s0,a0
ffffffffc02085d2:	4581                	li	a1,0
ffffffffc02085d4:	8526                	mv	a0,s1
ffffffffc02085d6:	ec06                	sd	ra,24(sp)
ffffffffc02085d8:	78f020ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc02085dc:	c429                	beqz	s0,ffffffffc0208626 <dev_fstat+0x62>
ffffffffc02085de:	783c                	ld	a5,112(s0)
ffffffffc02085e0:	c3b9                	beqz	a5,ffffffffc0208626 <dev_fstat+0x62>
ffffffffc02085e2:	6bbc                	ld	a5,80(a5)
ffffffffc02085e4:	c3a9                	beqz	a5,ffffffffc0208626 <dev_fstat+0x62>
ffffffffc02085e6:	00006597          	auipc	a1,0x6
ffffffffc02085ea:	36258593          	addi	a1,a1,866 # ffffffffc020e948 <syscalls+0xdb0>
ffffffffc02085ee:	8522                	mv	a0,s0
ffffffffc02085f0:	b2cff0ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc02085f4:	783c                	ld	a5,112(s0)
ffffffffc02085f6:	85a6                	mv	a1,s1
ffffffffc02085f8:	8522                	mv	a0,s0
ffffffffc02085fa:	6bbc                	ld	a5,80(a5)
ffffffffc02085fc:	9782                	jalr	a5
ffffffffc02085fe:	ed19                	bnez	a0,ffffffffc020861c <dev_fstat+0x58>
ffffffffc0208600:	4c38                	lw	a4,88(s0)
ffffffffc0208602:	6785                	lui	a5,0x1
ffffffffc0208604:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208608:	02f71f63          	bne	a4,a5,ffffffffc0208646 <dev_fstat+0x82>
ffffffffc020860c:	6018                	ld	a4,0(s0)
ffffffffc020860e:	641c                	ld	a5,8(s0)
ffffffffc0208610:	4685                	li	a3,1
ffffffffc0208612:	e494                	sd	a3,8(s1)
ffffffffc0208614:	02e787b3          	mul	a5,a5,a4
ffffffffc0208618:	e898                	sd	a4,16(s1)
ffffffffc020861a:	ec9c                	sd	a5,24(s1)
ffffffffc020861c:	60e2                	ld	ra,24(sp)
ffffffffc020861e:	6442                	ld	s0,16(sp)
ffffffffc0208620:	64a2                	ld	s1,8(sp)
ffffffffc0208622:	6105                	addi	sp,sp,32
ffffffffc0208624:	8082                	ret
ffffffffc0208626:	00006697          	auipc	a3,0x6
ffffffffc020862a:	2ba68693          	addi	a3,a3,698 # ffffffffc020e8e0 <syscalls+0xd48>
ffffffffc020862e:	00003617          	auipc	a2,0x3
ffffffffc0208632:	41a60613          	addi	a2,a2,1050 # ffffffffc020ba48 <commands+0x210>
ffffffffc0208636:	04200593          	li	a1,66
ffffffffc020863a:	00006517          	auipc	a0,0x6
ffffffffc020863e:	37e50513          	addi	a0,a0,894 # ffffffffc020e9b8 <syscalls+0xe20>
ffffffffc0208642:	e5df70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208646:	00006697          	auipc	a3,0x6
ffffffffc020864a:	06268693          	addi	a3,a3,98 # ffffffffc020e6a8 <syscalls+0xb10>
ffffffffc020864e:	00003617          	auipc	a2,0x3
ffffffffc0208652:	3fa60613          	addi	a2,a2,1018 # ffffffffc020ba48 <commands+0x210>
ffffffffc0208656:	04500593          	li	a1,69
ffffffffc020865a:	00006517          	auipc	a0,0x6
ffffffffc020865e:	35e50513          	addi	a0,a0,862 # ffffffffc020e9b8 <syscalls+0xe20>
ffffffffc0208662:	e3df70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208666 <dev_ioctl>:
ffffffffc0208666:	c909                	beqz	a0,ffffffffc0208678 <dev_ioctl+0x12>
ffffffffc0208668:	4d34                	lw	a3,88(a0)
ffffffffc020866a:	6705                	lui	a4,0x1
ffffffffc020866c:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208670:	00e69463          	bne	a3,a4,ffffffffc0208678 <dev_ioctl+0x12>
ffffffffc0208674:	751c                	ld	a5,40(a0)
ffffffffc0208676:	8782                	jr	a5
ffffffffc0208678:	1141                	addi	sp,sp,-16
ffffffffc020867a:	00006697          	auipc	a3,0x6
ffffffffc020867e:	02e68693          	addi	a3,a3,46 # ffffffffc020e6a8 <syscalls+0xb10>
ffffffffc0208682:	00003617          	auipc	a2,0x3
ffffffffc0208686:	3c660613          	addi	a2,a2,966 # ffffffffc020ba48 <commands+0x210>
ffffffffc020868a:	03500593          	li	a1,53
ffffffffc020868e:	00006517          	auipc	a0,0x6
ffffffffc0208692:	32a50513          	addi	a0,a0,810 # ffffffffc020e9b8 <syscalls+0xe20>
ffffffffc0208696:	e406                	sd	ra,8(sp)
ffffffffc0208698:	e07f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020869c <dev_tryseek>:
ffffffffc020869c:	c51d                	beqz	a0,ffffffffc02086ca <dev_tryseek+0x2e>
ffffffffc020869e:	4d38                	lw	a4,88(a0)
ffffffffc02086a0:	6785                	lui	a5,0x1
ffffffffc02086a2:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02086a6:	02f71263          	bne	a4,a5,ffffffffc02086ca <dev_tryseek+0x2e>
ffffffffc02086aa:	611c                	ld	a5,0(a0)
ffffffffc02086ac:	cf89                	beqz	a5,ffffffffc02086c6 <dev_tryseek+0x2a>
ffffffffc02086ae:	6518                	ld	a4,8(a0)
ffffffffc02086b0:	02e5f6b3          	remu	a3,a1,a4
ffffffffc02086b4:	ea89                	bnez	a3,ffffffffc02086c6 <dev_tryseek+0x2a>
ffffffffc02086b6:	0005c863          	bltz	a1,ffffffffc02086c6 <dev_tryseek+0x2a>
ffffffffc02086ba:	02e787b3          	mul	a5,a5,a4
ffffffffc02086be:	00f5f463          	bgeu	a1,a5,ffffffffc02086c6 <dev_tryseek+0x2a>
ffffffffc02086c2:	4501                	li	a0,0
ffffffffc02086c4:	8082                	ret
ffffffffc02086c6:	5575                	li	a0,-3
ffffffffc02086c8:	8082                	ret
ffffffffc02086ca:	1141                	addi	sp,sp,-16
ffffffffc02086cc:	00006697          	auipc	a3,0x6
ffffffffc02086d0:	fdc68693          	addi	a3,a3,-36 # ffffffffc020e6a8 <syscalls+0xb10>
ffffffffc02086d4:	00003617          	auipc	a2,0x3
ffffffffc02086d8:	37460613          	addi	a2,a2,884 # ffffffffc020ba48 <commands+0x210>
ffffffffc02086dc:	05f00593          	li	a1,95
ffffffffc02086e0:	00006517          	auipc	a0,0x6
ffffffffc02086e4:	2d850513          	addi	a0,a0,728 # ffffffffc020e9b8 <syscalls+0xe20>
ffffffffc02086e8:	e406                	sd	ra,8(sp)
ffffffffc02086ea:	db5f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02086ee <dev_gettype>:
ffffffffc02086ee:	c10d                	beqz	a0,ffffffffc0208710 <dev_gettype+0x22>
ffffffffc02086f0:	4d38                	lw	a4,88(a0)
ffffffffc02086f2:	6785                	lui	a5,0x1
ffffffffc02086f4:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02086f8:	00f71c63          	bne	a4,a5,ffffffffc0208710 <dev_gettype+0x22>
ffffffffc02086fc:	6118                	ld	a4,0(a0)
ffffffffc02086fe:	6795                	lui	a5,0x5
ffffffffc0208700:	c701                	beqz	a4,ffffffffc0208708 <dev_gettype+0x1a>
ffffffffc0208702:	c19c                	sw	a5,0(a1)
ffffffffc0208704:	4501                	li	a0,0
ffffffffc0208706:	8082                	ret
ffffffffc0208708:	6791                	lui	a5,0x4
ffffffffc020870a:	c19c                	sw	a5,0(a1)
ffffffffc020870c:	4501                	li	a0,0
ffffffffc020870e:	8082                	ret
ffffffffc0208710:	1141                	addi	sp,sp,-16
ffffffffc0208712:	00006697          	auipc	a3,0x6
ffffffffc0208716:	f9668693          	addi	a3,a3,-106 # ffffffffc020e6a8 <syscalls+0xb10>
ffffffffc020871a:	00003617          	auipc	a2,0x3
ffffffffc020871e:	32e60613          	addi	a2,a2,814 # ffffffffc020ba48 <commands+0x210>
ffffffffc0208722:	05300593          	li	a1,83
ffffffffc0208726:	00006517          	auipc	a0,0x6
ffffffffc020872a:	29250513          	addi	a0,a0,658 # ffffffffc020e9b8 <syscalls+0xe20>
ffffffffc020872e:	e406                	sd	ra,8(sp)
ffffffffc0208730:	d6ff70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208734 <dev_write>:
ffffffffc0208734:	c911                	beqz	a0,ffffffffc0208748 <dev_write+0x14>
ffffffffc0208736:	4d34                	lw	a3,88(a0)
ffffffffc0208738:	6705                	lui	a4,0x1
ffffffffc020873a:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc020873e:	00e69563          	bne	a3,a4,ffffffffc0208748 <dev_write+0x14>
ffffffffc0208742:	711c                	ld	a5,32(a0)
ffffffffc0208744:	4605                	li	a2,1
ffffffffc0208746:	8782                	jr	a5
ffffffffc0208748:	1141                	addi	sp,sp,-16
ffffffffc020874a:	00006697          	auipc	a3,0x6
ffffffffc020874e:	f5e68693          	addi	a3,a3,-162 # ffffffffc020e6a8 <syscalls+0xb10>
ffffffffc0208752:	00003617          	auipc	a2,0x3
ffffffffc0208756:	2f660613          	addi	a2,a2,758 # ffffffffc020ba48 <commands+0x210>
ffffffffc020875a:	02c00593          	li	a1,44
ffffffffc020875e:	00006517          	auipc	a0,0x6
ffffffffc0208762:	25a50513          	addi	a0,a0,602 # ffffffffc020e9b8 <syscalls+0xe20>
ffffffffc0208766:	e406                	sd	ra,8(sp)
ffffffffc0208768:	d37f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020876c <dev_read>:
ffffffffc020876c:	c911                	beqz	a0,ffffffffc0208780 <dev_read+0x14>
ffffffffc020876e:	4d34                	lw	a3,88(a0)
ffffffffc0208770:	6705                	lui	a4,0x1
ffffffffc0208772:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208776:	00e69563          	bne	a3,a4,ffffffffc0208780 <dev_read+0x14>
ffffffffc020877a:	711c                	ld	a5,32(a0)
ffffffffc020877c:	4601                	li	a2,0
ffffffffc020877e:	8782                	jr	a5
ffffffffc0208780:	1141                	addi	sp,sp,-16
ffffffffc0208782:	00006697          	auipc	a3,0x6
ffffffffc0208786:	f2668693          	addi	a3,a3,-218 # ffffffffc020e6a8 <syscalls+0xb10>
ffffffffc020878a:	00003617          	auipc	a2,0x3
ffffffffc020878e:	2be60613          	addi	a2,a2,702 # ffffffffc020ba48 <commands+0x210>
ffffffffc0208792:	02300593          	li	a1,35
ffffffffc0208796:	00006517          	auipc	a0,0x6
ffffffffc020879a:	22250513          	addi	a0,a0,546 # ffffffffc020e9b8 <syscalls+0xe20>
ffffffffc020879e:	e406                	sd	ra,8(sp)
ffffffffc02087a0:	cfff70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02087a4 <dev_close>:
ffffffffc02087a4:	c909                	beqz	a0,ffffffffc02087b6 <dev_close+0x12>
ffffffffc02087a6:	4d34                	lw	a3,88(a0)
ffffffffc02087a8:	6705                	lui	a4,0x1
ffffffffc02087aa:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02087ae:	00e69463          	bne	a3,a4,ffffffffc02087b6 <dev_close+0x12>
ffffffffc02087b2:	6d1c                	ld	a5,24(a0)
ffffffffc02087b4:	8782                	jr	a5
ffffffffc02087b6:	1141                	addi	sp,sp,-16
ffffffffc02087b8:	00006697          	auipc	a3,0x6
ffffffffc02087bc:	ef068693          	addi	a3,a3,-272 # ffffffffc020e6a8 <syscalls+0xb10>
ffffffffc02087c0:	00003617          	auipc	a2,0x3
ffffffffc02087c4:	28860613          	addi	a2,a2,648 # ffffffffc020ba48 <commands+0x210>
ffffffffc02087c8:	45e9                	li	a1,26
ffffffffc02087ca:	00006517          	auipc	a0,0x6
ffffffffc02087ce:	1ee50513          	addi	a0,a0,494 # ffffffffc020e9b8 <syscalls+0xe20>
ffffffffc02087d2:	e406                	sd	ra,8(sp)
ffffffffc02087d4:	ccbf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02087d8 <dev_open>:
ffffffffc02087d8:	03c5f713          	andi	a4,a1,60
ffffffffc02087dc:	eb11                	bnez	a4,ffffffffc02087f0 <dev_open+0x18>
ffffffffc02087de:	c919                	beqz	a0,ffffffffc02087f4 <dev_open+0x1c>
ffffffffc02087e0:	4d34                	lw	a3,88(a0)
ffffffffc02087e2:	6705                	lui	a4,0x1
ffffffffc02087e4:	23470713          	addi	a4,a4,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc02087e8:	00e69663          	bne	a3,a4,ffffffffc02087f4 <dev_open+0x1c>
ffffffffc02087ec:	691c                	ld	a5,16(a0)
ffffffffc02087ee:	8782                	jr	a5
ffffffffc02087f0:	5575                	li	a0,-3
ffffffffc02087f2:	8082                	ret
ffffffffc02087f4:	1141                	addi	sp,sp,-16
ffffffffc02087f6:	00006697          	auipc	a3,0x6
ffffffffc02087fa:	eb268693          	addi	a3,a3,-334 # ffffffffc020e6a8 <syscalls+0xb10>
ffffffffc02087fe:	00003617          	auipc	a2,0x3
ffffffffc0208802:	24a60613          	addi	a2,a2,586 # ffffffffc020ba48 <commands+0x210>
ffffffffc0208806:	45c5                	li	a1,17
ffffffffc0208808:	00006517          	auipc	a0,0x6
ffffffffc020880c:	1b050513          	addi	a0,a0,432 # ffffffffc020e9b8 <syscalls+0xe20>
ffffffffc0208810:	e406                	sd	ra,8(sp)
ffffffffc0208812:	c8df70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208816 <dev_init>:
ffffffffc0208816:	1141                	addi	sp,sp,-16
ffffffffc0208818:	e406                	sd	ra,8(sp)
ffffffffc020881a:	542000ef          	jal	ra,ffffffffc0208d5c <dev_init_stdin>
ffffffffc020881e:	65a000ef          	jal	ra,ffffffffc0208e78 <dev_init_stdout>
ffffffffc0208822:	60a2                	ld	ra,8(sp)
ffffffffc0208824:	0141                	addi	sp,sp,16
ffffffffc0208826:	a439                	j	ffffffffc0208a34 <dev_init_disk0>

ffffffffc0208828 <dev_create_inode>:
ffffffffc0208828:	6505                	lui	a0,0x1
ffffffffc020882a:	1141                	addi	sp,sp,-16
ffffffffc020882c:	23450513          	addi	a0,a0,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208830:	e022                	sd	s0,0(sp)
ffffffffc0208832:	e406                	sd	ra,8(sp)
ffffffffc0208834:	852ff0ef          	jal	ra,ffffffffc0207886 <__alloc_inode>
ffffffffc0208838:	842a                	mv	s0,a0
ffffffffc020883a:	c901                	beqz	a0,ffffffffc020884a <dev_create_inode+0x22>
ffffffffc020883c:	4601                	li	a2,0
ffffffffc020883e:	00006597          	auipc	a1,0x6
ffffffffc0208842:	19258593          	addi	a1,a1,402 # ffffffffc020e9d0 <dev_node_ops>
ffffffffc0208846:	85cff0ef          	jal	ra,ffffffffc02078a2 <inode_init>
ffffffffc020884a:	60a2                	ld	ra,8(sp)
ffffffffc020884c:	8522                	mv	a0,s0
ffffffffc020884e:	6402                	ld	s0,0(sp)
ffffffffc0208850:	0141                	addi	sp,sp,16
ffffffffc0208852:	8082                	ret

ffffffffc0208854 <disk0_open>:
ffffffffc0208854:	4501                	li	a0,0
ffffffffc0208856:	8082                	ret

ffffffffc0208858 <disk0_close>:
ffffffffc0208858:	4501                	li	a0,0
ffffffffc020885a:	8082                	ret

ffffffffc020885c <disk0_ioctl>:
ffffffffc020885c:	5531                	li	a0,-20
ffffffffc020885e:	8082                	ret

ffffffffc0208860 <disk0_io>:
ffffffffc0208860:	659c                	ld	a5,8(a1)
ffffffffc0208862:	7159                	addi	sp,sp,-112
ffffffffc0208864:	eca6                	sd	s1,88(sp)
ffffffffc0208866:	f45e                	sd	s7,40(sp)
ffffffffc0208868:	6d84                	ld	s1,24(a1)
ffffffffc020886a:	6b85                	lui	s7,0x1
ffffffffc020886c:	1bfd                	addi	s7,s7,-1
ffffffffc020886e:	e4ce                	sd	s3,72(sp)
ffffffffc0208870:	43f7d993          	srai	s3,a5,0x3f
ffffffffc0208874:	0179f9b3          	and	s3,s3,s7
ffffffffc0208878:	99be                	add	s3,s3,a5
ffffffffc020887a:	8fc5                	or	a5,a5,s1
ffffffffc020887c:	f486                	sd	ra,104(sp)
ffffffffc020887e:	f0a2                	sd	s0,96(sp)
ffffffffc0208880:	e8ca                	sd	s2,80(sp)
ffffffffc0208882:	e0d2                	sd	s4,64(sp)
ffffffffc0208884:	fc56                	sd	s5,56(sp)
ffffffffc0208886:	f85a                	sd	s6,48(sp)
ffffffffc0208888:	f062                	sd	s8,32(sp)
ffffffffc020888a:	ec66                	sd	s9,24(sp)
ffffffffc020888c:	e86a                	sd	s10,16(sp)
ffffffffc020888e:	0177f7b3          	and	a5,a5,s7
ffffffffc0208892:	10079d63          	bnez	a5,ffffffffc02089ac <disk0_io+0x14c>
ffffffffc0208896:	40c9d993          	srai	s3,s3,0xc
ffffffffc020889a:	00c4d713          	srli	a4,s1,0xc
ffffffffc020889e:	2981                	sext.w	s3,s3
ffffffffc02088a0:	2701                	sext.w	a4,a4
ffffffffc02088a2:	00e987bb          	addw	a5,s3,a4
ffffffffc02088a6:	6114                	ld	a3,0(a0)
ffffffffc02088a8:	1782                	slli	a5,a5,0x20
ffffffffc02088aa:	9381                	srli	a5,a5,0x20
ffffffffc02088ac:	10f6e063          	bltu	a3,a5,ffffffffc02089ac <disk0_io+0x14c>
ffffffffc02088b0:	4501                	li	a0,0
ffffffffc02088b2:	ef19                	bnez	a4,ffffffffc02088d0 <disk0_io+0x70>
ffffffffc02088b4:	70a6                	ld	ra,104(sp)
ffffffffc02088b6:	7406                	ld	s0,96(sp)
ffffffffc02088b8:	64e6                	ld	s1,88(sp)
ffffffffc02088ba:	6946                	ld	s2,80(sp)
ffffffffc02088bc:	69a6                	ld	s3,72(sp)
ffffffffc02088be:	6a06                	ld	s4,64(sp)
ffffffffc02088c0:	7ae2                	ld	s5,56(sp)
ffffffffc02088c2:	7b42                	ld	s6,48(sp)
ffffffffc02088c4:	7ba2                	ld	s7,40(sp)
ffffffffc02088c6:	7c02                	ld	s8,32(sp)
ffffffffc02088c8:	6ce2                	ld	s9,24(sp)
ffffffffc02088ca:	6d42                	ld	s10,16(sp)
ffffffffc02088cc:	6165                	addi	sp,sp,112
ffffffffc02088ce:	8082                	ret
ffffffffc02088d0:	0008d517          	auipc	a0,0x8d
ffffffffc02088d4:	f7050513          	addi	a0,a0,-144 # ffffffffc0295840 <disk0_sem>
ffffffffc02088d8:	8b2e                	mv	s6,a1
ffffffffc02088da:	8c32                	mv	s8,a2
ffffffffc02088dc:	0008ea97          	auipc	s5,0x8e
ffffffffc02088e0:	01ca8a93          	addi	s5,s5,28 # ffffffffc02968f8 <disk0_buffer>
ffffffffc02088e4:	c81fb0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc02088e8:	6c91                	lui	s9,0x4
ffffffffc02088ea:	e4b9                	bnez	s1,ffffffffc0208938 <disk0_io+0xd8>
ffffffffc02088ec:	a845                	j	ffffffffc020899c <disk0_io+0x13c>
ffffffffc02088ee:	00c4d413          	srli	s0,s1,0xc
ffffffffc02088f2:	0034169b          	slliw	a3,s0,0x3
ffffffffc02088f6:	00068d1b          	sext.w	s10,a3
ffffffffc02088fa:	1682                	slli	a3,a3,0x20
ffffffffc02088fc:	2401                	sext.w	s0,s0
ffffffffc02088fe:	9281                	srli	a3,a3,0x20
ffffffffc0208900:	8926                	mv	s2,s1
ffffffffc0208902:	00399a1b          	slliw	s4,s3,0x3
ffffffffc0208906:	862e                	mv	a2,a1
ffffffffc0208908:	4509                	li	a0,2
ffffffffc020890a:	85d2                	mv	a1,s4
ffffffffc020890c:	a34f80ef          	jal	ra,ffffffffc0200b40 <ide_read_secs>
ffffffffc0208910:	e165                	bnez	a0,ffffffffc02089f0 <disk0_io+0x190>
ffffffffc0208912:	000ab583          	ld	a1,0(s5)
ffffffffc0208916:	0038                	addi	a4,sp,8
ffffffffc0208918:	4685                	li	a3,1
ffffffffc020891a:	864a                	mv	a2,s2
ffffffffc020891c:	855a                	mv	a0,s6
ffffffffc020891e:	acffc0ef          	jal	ra,ffffffffc02053ec <iobuf_move>
ffffffffc0208922:	67a2                	ld	a5,8(sp)
ffffffffc0208924:	09279663          	bne	a5,s2,ffffffffc02089b0 <disk0_io+0x150>
ffffffffc0208928:	017977b3          	and	a5,s2,s7
ffffffffc020892c:	e3d1                	bnez	a5,ffffffffc02089b0 <disk0_io+0x150>
ffffffffc020892e:	412484b3          	sub	s1,s1,s2
ffffffffc0208932:	013409bb          	addw	s3,s0,s3
ffffffffc0208936:	c0bd                	beqz	s1,ffffffffc020899c <disk0_io+0x13c>
ffffffffc0208938:	000ab583          	ld	a1,0(s5)
ffffffffc020893c:	000c1b63          	bnez	s8,ffffffffc0208952 <disk0_io+0xf2>
ffffffffc0208940:	fb94e7e3          	bltu	s1,s9,ffffffffc02088ee <disk0_io+0x8e>
ffffffffc0208944:	02000693          	li	a3,32
ffffffffc0208948:	02000d13          	li	s10,32
ffffffffc020894c:	4411                	li	s0,4
ffffffffc020894e:	6911                	lui	s2,0x4
ffffffffc0208950:	bf4d                	j	ffffffffc0208902 <disk0_io+0xa2>
ffffffffc0208952:	0038                	addi	a4,sp,8
ffffffffc0208954:	4681                	li	a3,0
ffffffffc0208956:	6611                	lui	a2,0x4
ffffffffc0208958:	855a                	mv	a0,s6
ffffffffc020895a:	a93fc0ef          	jal	ra,ffffffffc02053ec <iobuf_move>
ffffffffc020895e:	6422                	ld	s0,8(sp)
ffffffffc0208960:	c825                	beqz	s0,ffffffffc02089d0 <disk0_io+0x170>
ffffffffc0208962:	0684e763          	bltu	s1,s0,ffffffffc02089d0 <disk0_io+0x170>
ffffffffc0208966:	017477b3          	and	a5,s0,s7
ffffffffc020896a:	e3bd                	bnez	a5,ffffffffc02089d0 <disk0_io+0x170>
ffffffffc020896c:	8031                	srli	s0,s0,0xc
ffffffffc020896e:	0034179b          	slliw	a5,s0,0x3
ffffffffc0208972:	000ab603          	ld	a2,0(s5)
ffffffffc0208976:	0039991b          	slliw	s2,s3,0x3
ffffffffc020897a:	02079693          	slli	a3,a5,0x20
ffffffffc020897e:	9281                	srli	a3,a3,0x20
ffffffffc0208980:	85ca                	mv	a1,s2
ffffffffc0208982:	4509                	li	a0,2
ffffffffc0208984:	2401                	sext.w	s0,s0
ffffffffc0208986:	00078a1b          	sext.w	s4,a5
ffffffffc020898a:	a4cf80ef          	jal	ra,ffffffffc0200bd6 <ide_write_secs>
ffffffffc020898e:	e151                	bnez	a0,ffffffffc0208a12 <disk0_io+0x1b2>
ffffffffc0208990:	6922                	ld	s2,8(sp)
ffffffffc0208992:	013409bb          	addw	s3,s0,s3
ffffffffc0208996:	412484b3          	sub	s1,s1,s2
ffffffffc020899a:	fcd9                	bnez	s1,ffffffffc0208938 <disk0_io+0xd8>
ffffffffc020899c:	0008d517          	auipc	a0,0x8d
ffffffffc02089a0:	ea450513          	addi	a0,a0,-348 # ffffffffc0295840 <disk0_sem>
ffffffffc02089a4:	bbdfb0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc02089a8:	4501                	li	a0,0
ffffffffc02089aa:	b729                	j	ffffffffc02088b4 <disk0_io+0x54>
ffffffffc02089ac:	5575                	li	a0,-3
ffffffffc02089ae:	b719                	j	ffffffffc02088b4 <disk0_io+0x54>
ffffffffc02089b0:	00006697          	auipc	a3,0x6
ffffffffc02089b4:	19868693          	addi	a3,a3,408 # ffffffffc020eb48 <dev_node_ops+0x178>
ffffffffc02089b8:	00003617          	auipc	a2,0x3
ffffffffc02089bc:	09060613          	addi	a2,a2,144 # ffffffffc020ba48 <commands+0x210>
ffffffffc02089c0:	06200593          	li	a1,98
ffffffffc02089c4:	00006517          	auipc	a0,0x6
ffffffffc02089c8:	0cc50513          	addi	a0,a0,204 # ffffffffc020ea90 <dev_node_ops+0xc0>
ffffffffc02089cc:	ad3f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02089d0:	00006697          	auipc	a3,0x6
ffffffffc02089d4:	08068693          	addi	a3,a3,128 # ffffffffc020ea50 <dev_node_ops+0x80>
ffffffffc02089d8:	00003617          	auipc	a2,0x3
ffffffffc02089dc:	07060613          	addi	a2,a2,112 # ffffffffc020ba48 <commands+0x210>
ffffffffc02089e0:	05700593          	li	a1,87
ffffffffc02089e4:	00006517          	auipc	a0,0x6
ffffffffc02089e8:	0ac50513          	addi	a0,a0,172 # ffffffffc020ea90 <dev_node_ops+0xc0>
ffffffffc02089ec:	ab3f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02089f0:	88aa                	mv	a7,a0
ffffffffc02089f2:	886a                	mv	a6,s10
ffffffffc02089f4:	87a2                	mv	a5,s0
ffffffffc02089f6:	8752                	mv	a4,s4
ffffffffc02089f8:	86ce                	mv	a3,s3
ffffffffc02089fa:	00006617          	auipc	a2,0x6
ffffffffc02089fe:	10660613          	addi	a2,a2,262 # ffffffffc020eb00 <dev_node_ops+0x130>
ffffffffc0208a02:	02d00593          	li	a1,45
ffffffffc0208a06:	00006517          	auipc	a0,0x6
ffffffffc0208a0a:	08a50513          	addi	a0,a0,138 # ffffffffc020ea90 <dev_node_ops+0xc0>
ffffffffc0208a0e:	a91f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208a12:	88aa                	mv	a7,a0
ffffffffc0208a14:	8852                	mv	a6,s4
ffffffffc0208a16:	87a2                	mv	a5,s0
ffffffffc0208a18:	874a                	mv	a4,s2
ffffffffc0208a1a:	86ce                	mv	a3,s3
ffffffffc0208a1c:	00006617          	auipc	a2,0x6
ffffffffc0208a20:	09460613          	addi	a2,a2,148 # ffffffffc020eab0 <dev_node_ops+0xe0>
ffffffffc0208a24:	03700593          	li	a1,55
ffffffffc0208a28:	00006517          	auipc	a0,0x6
ffffffffc0208a2c:	06850513          	addi	a0,a0,104 # ffffffffc020ea90 <dev_node_ops+0xc0>
ffffffffc0208a30:	a6ff70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208a34 <dev_init_disk0>:
ffffffffc0208a34:	1101                	addi	sp,sp,-32
ffffffffc0208a36:	ec06                	sd	ra,24(sp)
ffffffffc0208a38:	e822                	sd	s0,16(sp)
ffffffffc0208a3a:	e426                	sd	s1,8(sp)
ffffffffc0208a3c:	dedff0ef          	jal	ra,ffffffffc0208828 <dev_create_inode>
ffffffffc0208a40:	c541                	beqz	a0,ffffffffc0208ac8 <dev_init_disk0+0x94>
ffffffffc0208a42:	4d38                	lw	a4,88(a0)
ffffffffc0208a44:	6485                	lui	s1,0x1
ffffffffc0208a46:	23448793          	addi	a5,s1,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208a4a:	842a                	mv	s0,a0
ffffffffc0208a4c:	0cf71f63          	bne	a4,a5,ffffffffc0208b2a <dev_init_disk0+0xf6>
ffffffffc0208a50:	4509                	li	a0,2
ffffffffc0208a52:	8a2f80ef          	jal	ra,ffffffffc0200af4 <ide_device_valid>
ffffffffc0208a56:	cd55                	beqz	a0,ffffffffc0208b12 <dev_init_disk0+0xde>
ffffffffc0208a58:	4509                	li	a0,2
ffffffffc0208a5a:	8bef80ef          	jal	ra,ffffffffc0200b18 <ide_device_size>
ffffffffc0208a5e:	00355793          	srli	a5,a0,0x3
ffffffffc0208a62:	e01c                	sd	a5,0(s0)
ffffffffc0208a64:	00000797          	auipc	a5,0x0
ffffffffc0208a68:	df078793          	addi	a5,a5,-528 # ffffffffc0208854 <disk0_open>
ffffffffc0208a6c:	e81c                	sd	a5,16(s0)
ffffffffc0208a6e:	00000797          	auipc	a5,0x0
ffffffffc0208a72:	dea78793          	addi	a5,a5,-534 # ffffffffc0208858 <disk0_close>
ffffffffc0208a76:	ec1c                	sd	a5,24(s0)
ffffffffc0208a78:	00000797          	auipc	a5,0x0
ffffffffc0208a7c:	de878793          	addi	a5,a5,-536 # ffffffffc0208860 <disk0_io>
ffffffffc0208a80:	f01c                	sd	a5,32(s0)
ffffffffc0208a82:	00000797          	auipc	a5,0x0
ffffffffc0208a86:	dda78793          	addi	a5,a5,-550 # ffffffffc020885c <disk0_ioctl>
ffffffffc0208a8a:	f41c                	sd	a5,40(s0)
ffffffffc0208a8c:	4585                	li	a1,1
ffffffffc0208a8e:	0008d517          	auipc	a0,0x8d
ffffffffc0208a92:	db250513          	addi	a0,a0,-590 # ffffffffc0295840 <disk0_sem>
ffffffffc0208a96:	e404                	sd	s1,8(s0)
ffffffffc0208a98:	ac3fb0ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc0208a9c:	6511                	lui	a0,0x4
ffffffffc0208a9e:	cf0f90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0208aa2:	0008e797          	auipc	a5,0x8e
ffffffffc0208aa6:	e4a7bb23          	sd	a0,-426(a5) # ffffffffc02968f8 <disk0_buffer>
ffffffffc0208aaa:	c921                	beqz	a0,ffffffffc0208afa <dev_init_disk0+0xc6>
ffffffffc0208aac:	4605                	li	a2,1
ffffffffc0208aae:	85a2                	mv	a1,s0
ffffffffc0208ab0:	00006517          	auipc	a0,0x6
ffffffffc0208ab4:	12850513          	addi	a0,a0,296 # ffffffffc020ebd8 <dev_node_ops+0x208>
ffffffffc0208ab8:	c2cff0ef          	jal	ra,ffffffffc0207ee4 <vfs_add_dev>
ffffffffc0208abc:	e115                	bnez	a0,ffffffffc0208ae0 <dev_init_disk0+0xac>
ffffffffc0208abe:	60e2                	ld	ra,24(sp)
ffffffffc0208ac0:	6442                	ld	s0,16(sp)
ffffffffc0208ac2:	64a2                	ld	s1,8(sp)
ffffffffc0208ac4:	6105                	addi	sp,sp,32
ffffffffc0208ac6:	8082                	ret
ffffffffc0208ac8:	00006617          	auipc	a2,0x6
ffffffffc0208acc:	0b060613          	addi	a2,a2,176 # ffffffffc020eb78 <dev_node_ops+0x1a8>
ffffffffc0208ad0:	08700593          	li	a1,135
ffffffffc0208ad4:	00006517          	auipc	a0,0x6
ffffffffc0208ad8:	fbc50513          	addi	a0,a0,-68 # ffffffffc020ea90 <dev_node_ops+0xc0>
ffffffffc0208adc:	9c3f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208ae0:	86aa                	mv	a3,a0
ffffffffc0208ae2:	00006617          	auipc	a2,0x6
ffffffffc0208ae6:	0fe60613          	addi	a2,a2,254 # ffffffffc020ebe0 <dev_node_ops+0x210>
ffffffffc0208aea:	08d00593          	li	a1,141
ffffffffc0208aee:	00006517          	auipc	a0,0x6
ffffffffc0208af2:	fa250513          	addi	a0,a0,-94 # ffffffffc020ea90 <dev_node_ops+0xc0>
ffffffffc0208af6:	9a9f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208afa:	00006617          	auipc	a2,0x6
ffffffffc0208afe:	0be60613          	addi	a2,a2,190 # ffffffffc020ebb8 <dev_node_ops+0x1e8>
ffffffffc0208b02:	07f00593          	li	a1,127
ffffffffc0208b06:	00006517          	auipc	a0,0x6
ffffffffc0208b0a:	f8a50513          	addi	a0,a0,-118 # ffffffffc020ea90 <dev_node_ops+0xc0>
ffffffffc0208b0e:	991f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208b12:	00006617          	auipc	a2,0x6
ffffffffc0208b16:	08660613          	addi	a2,a2,134 # ffffffffc020eb98 <dev_node_ops+0x1c8>
ffffffffc0208b1a:	07300593          	li	a1,115
ffffffffc0208b1e:	00006517          	auipc	a0,0x6
ffffffffc0208b22:	f7250513          	addi	a0,a0,-142 # ffffffffc020ea90 <dev_node_ops+0xc0>
ffffffffc0208b26:	979f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208b2a:	00006697          	auipc	a3,0x6
ffffffffc0208b2e:	b7e68693          	addi	a3,a3,-1154 # ffffffffc020e6a8 <syscalls+0xb10>
ffffffffc0208b32:	00003617          	auipc	a2,0x3
ffffffffc0208b36:	f1660613          	addi	a2,a2,-234 # ffffffffc020ba48 <commands+0x210>
ffffffffc0208b3a:	08900593          	li	a1,137
ffffffffc0208b3e:	00006517          	auipc	a0,0x6
ffffffffc0208b42:	f5250513          	addi	a0,a0,-174 # ffffffffc020ea90 <dev_node_ops+0xc0>
ffffffffc0208b46:	959f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208b4a <stdin_open>:
ffffffffc0208b4a:	4501                	li	a0,0
ffffffffc0208b4c:	e191                	bnez	a1,ffffffffc0208b50 <stdin_open+0x6>
ffffffffc0208b4e:	8082                	ret
ffffffffc0208b50:	5575                	li	a0,-3
ffffffffc0208b52:	8082                	ret

ffffffffc0208b54 <stdin_close>:
ffffffffc0208b54:	4501                	li	a0,0
ffffffffc0208b56:	8082                	ret

ffffffffc0208b58 <stdin_ioctl>:
ffffffffc0208b58:	5575                	li	a0,-3
ffffffffc0208b5a:	8082                	ret

ffffffffc0208b5c <stdin_io>:
ffffffffc0208b5c:	7135                	addi	sp,sp,-160
ffffffffc0208b5e:	ed06                	sd	ra,152(sp)
ffffffffc0208b60:	e922                	sd	s0,144(sp)
ffffffffc0208b62:	e526                	sd	s1,136(sp)
ffffffffc0208b64:	e14a                	sd	s2,128(sp)
ffffffffc0208b66:	fcce                	sd	s3,120(sp)
ffffffffc0208b68:	f8d2                	sd	s4,112(sp)
ffffffffc0208b6a:	f4d6                	sd	s5,104(sp)
ffffffffc0208b6c:	f0da                	sd	s6,96(sp)
ffffffffc0208b6e:	ecde                	sd	s7,88(sp)
ffffffffc0208b70:	e8e2                	sd	s8,80(sp)
ffffffffc0208b72:	e4e6                	sd	s9,72(sp)
ffffffffc0208b74:	e0ea                	sd	s10,64(sp)
ffffffffc0208b76:	fc6e                	sd	s11,56(sp)
ffffffffc0208b78:	14061163          	bnez	a2,ffffffffc0208cba <stdin_io+0x15e>
ffffffffc0208b7c:	0005bd83          	ld	s11,0(a1)
ffffffffc0208b80:	0185bd03          	ld	s10,24(a1)
ffffffffc0208b84:	8b2e                	mv	s6,a1
ffffffffc0208b86:	100027f3          	csrr	a5,sstatus
ffffffffc0208b8a:	8b89                	andi	a5,a5,2
ffffffffc0208b8c:	10079e63          	bnez	a5,ffffffffc0208ca8 <stdin_io+0x14c>
ffffffffc0208b90:	4401                	li	s0,0
ffffffffc0208b92:	100d0963          	beqz	s10,ffffffffc0208ca4 <stdin_io+0x148>
ffffffffc0208b96:	0008e997          	auipc	s3,0x8e
ffffffffc0208b9a:	d6a98993          	addi	s3,s3,-662 # ffffffffc0296900 <p_rpos>
ffffffffc0208b9e:	0009b783          	ld	a5,0(s3)
ffffffffc0208ba2:	800004b7          	lui	s1,0x80000
ffffffffc0208ba6:	6c85                	lui	s9,0x1
ffffffffc0208ba8:	4a81                	li	s5,0
ffffffffc0208baa:	0008ea17          	auipc	s4,0x8e
ffffffffc0208bae:	d5ea0a13          	addi	s4,s4,-674 # ffffffffc0296908 <p_wpos>
ffffffffc0208bb2:	0491                	addi	s1,s1,4
ffffffffc0208bb4:	0008d917          	auipc	s2,0x8d
ffffffffc0208bb8:	ca490913          	addi	s2,s2,-860 # ffffffffc0295858 <__wait_queue>
ffffffffc0208bbc:	1cfd                	addi	s9,s9,-1
ffffffffc0208bbe:	000a3703          	ld	a4,0(s4)
ffffffffc0208bc2:	000a8c1b          	sext.w	s8,s5
ffffffffc0208bc6:	8be2                	mv	s7,s8
ffffffffc0208bc8:	02e7d763          	bge	a5,a4,ffffffffc0208bf6 <stdin_io+0x9a>
ffffffffc0208bcc:	a859                	j	ffffffffc0208c62 <stdin_io+0x106>
ffffffffc0208bce:	815fe0ef          	jal	ra,ffffffffc02073e2 <schedule>
ffffffffc0208bd2:	100027f3          	csrr	a5,sstatus
ffffffffc0208bd6:	8b89                	andi	a5,a5,2
ffffffffc0208bd8:	4401                	li	s0,0
ffffffffc0208bda:	ef8d                	bnez	a5,ffffffffc0208c14 <stdin_io+0xb8>
ffffffffc0208bdc:	0028                	addi	a0,sp,8
ffffffffc0208bde:	a19fb0ef          	jal	ra,ffffffffc02045f6 <wait_in_queue>
ffffffffc0208be2:	e121                	bnez	a0,ffffffffc0208c22 <stdin_io+0xc6>
ffffffffc0208be4:	47c2                	lw	a5,16(sp)
ffffffffc0208be6:	04979563          	bne	a5,s1,ffffffffc0208c30 <stdin_io+0xd4>
ffffffffc0208bea:	0009b783          	ld	a5,0(s3)
ffffffffc0208bee:	000a3703          	ld	a4,0(s4)
ffffffffc0208bf2:	06e7c863          	blt	a5,a4,ffffffffc0208c62 <stdin_io+0x106>
ffffffffc0208bf6:	8626                	mv	a2,s1
ffffffffc0208bf8:	002c                	addi	a1,sp,8
ffffffffc0208bfa:	854a                	mv	a0,s2
ffffffffc0208bfc:	b25fb0ef          	jal	ra,ffffffffc0204720 <wait_current_set>
ffffffffc0208c00:	d479                	beqz	s0,ffffffffc0208bce <stdin_io+0x72>
ffffffffc0208c02:	86af80ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208c06:	fdcfe0ef          	jal	ra,ffffffffc02073e2 <schedule>
ffffffffc0208c0a:	100027f3          	csrr	a5,sstatus
ffffffffc0208c0e:	8b89                	andi	a5,a5,2
ffffffffc0208c10:	4401                	li	s0,0
ffffffffc0208c12:	d7e9                	beqz	a5,ffffffffc0208bdc <stdin_io+0x80>
ffffffffc0208c14:	85ef80ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208c18:	0028                	addi	a0,sp,8
ffffffffc0208c1a:	4405                	li	s0,1
ffffffffc0208c1c:	9dbfb0ef          	jal	ra,ffffffffc02045f6 <wait_in_queue>
ffffffffc0208c20:	d171                	beqz	a0,ffffffffc0208be4 <stdin_io+0x88>
ffffffffc0208c22:	002c                	addi	a1,sp,8
ffffffffc0208c24:	854a                	mv	a0,s2
ffffffffc0208c26:	977fb0ef          	jal	ra,ffffffffc020459c <wait_queue_del>
ffffffffc0208c2a:	47c2                	lw	a5,16(sp)
ffffffffc0208c2c:	fa978fe3          	beq	a5,s1,ffffffffc0208bea <stdin_io+0x8e>
ffffffffc0208c30:	e435                	bnez	s0,ffffffffc0208c9c <stdin_io+0x140>
ffffffffc0208c32:	060b8963          	beqz	s7,ffffffffc0208ca4 <stdin_io+0x148>
ffffffffc0208c36:	018b3783          	ld	a5,24(s6)
ffffffffc0208c3a:	41578ab3          	sub	s5,a5,s5
ffffffffc0208c3e:	015b3c23          	sd	s5,24(s6)
ffffffffc0208c42:	60ea                	ld	ra,152(sp)
ffffffffc0208c44:	644a                	ld	s0,144(sp)
ffffffffc0208c46:	64aa                	ld	s1,136(sp)
ffffffffc0208c48:	690a                	ld	s2,128(sp)
ffffffffc0208c4a:	79e6                	ld	s3,120(sp)
ffffffffc0208c4c:	7a46                	ld	s4,112(sp)
ffffffffc0208c4e:	7aa6                	ld	s5,104(sp)
ffffffffc0208c50:	7b06                	ld	s6,96(sp)
ffffffffc0208c52:	6c46                	ld	s8,80(sp)
ffffffffc0208c54:	6ca6                	ld	s9,72(sp)
ffffffffc0208c56:	6d06                	ld	s10,64(sp)
ffffffffc0208c58:	7de2                	ld	s11,56(sp)
ffffffffc0208c5a:	855e                	mv	a0,s7
ffffffffc0208c5c:	6be6                	ld	s7,88(sp)
ffffffffc0208c5e:	610d                	addi	sp,sp,160
ffffffffc0208c60:	8082                	ret
ffffffffc0208c62:	43f7d713          	srai	a4,a5,0x3f
ffffffffc0208c66:	03475693          	srli	a3,a4,0x34
ffffffffc0208c6a:	00d78733          	add	a4,a5,a3
ffffffffc0208c6e:	01977733          	and	a4,a4,s9
ffffffffc0208c72:	8f15                	sub	a4,a4,a3
ffffffffc0208c74:	0008d697          	auipc	a3,0x8d
ffffffffc0208c78:	bf468693          	addi	a3,a3,-1036 # ffffffffc0295868 <stdin_buffer>
ffffffffc0208c7c:	9736                	add	a4,a4,a3
ffffffffc0208c7e:	00074683          	lbu	a3,0(a4)
ffffffffc0208c82:	0785                	addi	a5,a5,1
ffffffffc0208c84:	015d8733          	add	a4,s11,s5
ffffffffc0208c88:	00d70023          	sb	a3,0(a4)
ffffffffc0208c8c:	00f9b023          	sd	a5,0(s3)
ffffffffc0208c90:	0a85                	addi	s5,s5,1
ffffffffc0208c92:	001c0b9b          	addiw	s7,s8,1
ffffffffc0208c96:	f3aae4e3          	bltu	s5,s10,ffffffffc0208bbe <stdin_io+0x62>
ffffffffc0208c9a:	dc51                	beqz	s0,ffffffffc0208c36 <stdin_io+0xda>
ffffffffc0208c9c:	fd1f70ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208ca0:	f80b9be3          	bnez	s7,ffffffffc0208c36 <stdin_io+0xda>
ffffffffc0208ca4:	4b81                	li	s7,0
ffffffffc0208ca6:	bf71                	j	ffffffffc0208c42 <stdin_io+0xe6>
ffffffffc0208ca8:	fcbf70ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208cac:	4405                	li	s0,1
ffffffffc0208cae:	ee0d14e3          	bnez	s10,ffffffffc0208b96 <stdin_io+0x3a>
ffffffffc0208cb2:	fbbf70ef          	jal	ra,ffffffffc0200c6c <intr_enable>
ffffffffc0208cb6:	4b81                	li	s7,0
ffffffffc0208cb8:	b769                	j	ffffffffc0208c42 <stdin_io+0xe6>
ffffffffc0208cba:	5bf5                	li	s7,-3
ffffffffc0208cbc:	b759                	j	ffffffffc0208c42 <stdin_io+0xe6>

ffffffffc0208cbe <dev_stdin_write>:
ffffffffc0208cbe:	e111                	bnez	a0,ffffffffc0208cc2 <dev_stdin_write+0x4>
ffffffffc0208cc0:	8082                	ret
ffffffffc0208cc2:	1101                	addi	sp,sp,-32
ffffffffc0208cc4:	e822                	sd	s0,16(sp)
ffffffffc0208cc6:	ec06                	sd	ra,24(sp)
ffffffffc0208cc8:	e426                	sd	s1,8(sp)
ffffffffc0208cca:	842a                	mv	s0,a0
ffffffffc0208ccc:	100027f3          	csrr	a5,sstatus
ffffffffc0208cd0:	8b89                	andi	a5,a5,2
ffffffffc0208cd2:	4481                	li	s1,0
ffffffffc0208cd4:	e3c1                	bnez	a5,ffffffffc0208d54 <dev_stdin_write+0x96>
ffffffffc0208cd6:	0008e597          	auipc	a1,0x8e
ffffffffc0208cda:	c3258593          	addi	a1,a1,-974 # ffffffffc0296908 <p_wpos>
ffffffffc0208cde:	6198                	ld	a4,0(a1)
ffffffffc0208ce0:	6605                	lui	a2,0x1
ffffffffc0208ce2:	fff60513          	addi	a0,a2,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0208ce6:	43f75693          	srai	a3,a4,0x3f
ffffffffc0208cea:	92d1                	srli	a3,a3,0x34
ffffffffc0208cec:	00d707b3          	add	a5,a4,a3
ffffffffc0208cf0:	8fe9                	and	a5,a5,a0
ffffffffc0208cf2:	8f95                	sub	a5,a5,a3
ffffffffc0208cf4:	0008d697          	auipc	a3,0x8d
ffffffffc0208cf8:	b7468693          	addi	a3,a3,-1164 # ffffffffc0295868 <stdin_buffer>
ffffffffc0208cfc:	97b6                	add	a5,a5,a3
ffffffffc0208cfe:	00878023          	sb	s0,0(a5)
ffffffffc0208d02:	0008e797          	auipc	a5,0x8e
ffffffffc0208d06:	bfe7b783          	ld	a5,-1026(a5) # ffffffffc0296900 <p_rpos>
ffffffffc0208d0a:	40f707b3          	sub	a5,a4,a5
ffffffffc0208d0e:	00c7d463          	bge	a5,a2,ffffffffc0208d16 <dev_stdin_write+0x58>
ffffffffc0208d12:	0705                	addi	a4,a4,1
ffffffffc0208d14:	e198                	sd	a4,0(a1)
ffffffffc0208d16:	0008d517          	auipc	a0,0x8d
ffffffffc0208d1a:	b4250513          	addi	a0,a0,-1214 # ffffffffc0295858 <__wait_queue>
ffffffffc0208d1e:	8cdfb0ef          	jal	ra,ffffffffc02045ea <wait_queue_empty>
ffffffffc0208d22:	cd09                	beqz	a0,ffffffffc0208d3c <dev_stdin_write+0x7e>
ffffffffc0208d24:	e491                	bnez	s1,ffffffffc0208d30 <dev_stdin_write+0x72>
ffffffffc0208d26:	60e2                	ld	ra,24(sp)
ffffffffc0208d28:	6442                	ld	s0,16(sp)
ffffffffc0208d2a:	64a2                	ld	s1,8(sp)
ffffffffc0208d2c:	6105                	addi	sp,sp,32
ffffffffc0208d2e:	8082                	ret
ffffffffc0208d30:	6442                	ld	s0,16(sp)
ffffffffc0208d32:	60e2                	ld	ra,24(sp)
ffffffffc0208d34:	64a2                	ld	s1,8(sp)
ffffffffc0208d36:	6105                	addi	sp,sp,32
ffffffffc0208d38:	f35f706f          	j	ffffffffc0200c6c <intr_enable>
ffffffffc0208d3c:	800005b7          	lui	a1,0x80000
ffffffffc0208d40:	4605                	li	a2,1
ffffffffc0208d42:	0591                	addi	a1,a1,4
ffffffffc0208d44:	0008d517          	auipc	a0,0x8d
ffffffffc0208d48:	b1450513          	addi	a0,a0,-1260 # ffffffffc0295858 <__wait_queue>
ffffffffc0208d4c:	907fb0ef          	jal	ra,ffffffffc0204652 <wakeup_queue>
ffffffffc0208d50:	d8f9                	beqz	s1,ffffffffc0208d26 <dev_stdin_write+0x68>
ffffffffc0208d52:	bff9                	j	ffffffffc0208d30 <dev_stdin_write+0x72>
ffffffffc0208d54:	f1ff70ef          	jal	ra,ffffffffc0200c72 <intr_disable>
ffffffffc0208d58:	4485                	li	s1,1
ffffffffc0208d5a:	bfb5                	j	ffffffffc0208cd6 <dev_stdin_write+0x18>

ffffffffc0208d5c <dev_init_stdin>:
ffffffffc0208d5c:	1141                	addi	sp,sp,-16
ffffffffc0208d5e:	e406                	sd	ra,8(sp)
ffffffffc0208d60:	e022                	sd	s0,0(sp)
ffffffffc0208d62:	ac7ff0ef          	jal	ra,ffffffffc0208828 <dev_create_inode>
ffffffffc0208d66:	c93d                	beqz	a0,ffffffffc0208ddc <dev_init_stdin+0x80>
ffffffffc0208d68:	4d38                	lw	a4,88(a0)
ffffffffc0208d6a:	6785                	lui	a5,0x1
ffffffffc0208d6c:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208d70:	842a                	mv	s0,a0
ffffffffc0208d72:	08f71e63          	bne	a4,a5,ffffffffc0208e0e <dev_init_stdin+0xb2>
ffffffffc0208d76:	4785                	li	a5,1
ffffffffc0208d78:	e41c                	sd	a5,8(s0)
ffffffffc0208d7a:	00000797          	auipc	a5,0x0
ffffffffc0208d7e:	dd078793          	addi	a5,a5,-560 # ffffffffc0208b4a <stdin_open>
ffffffffc0208d82:	e81c                	sd	a5,16(s0)
ffffffffc0208d84:	00000797          	auipc	a5,0x0
ffffffffc0208d88:	dd078793          	addi	a5,a5,-560 # ffffffffc0208b54 <stdin_close>
ffffffffc0208d8c:	ec1c                	sd	a5,24(s0)
ffffffffc0208d8e:	00000797          	auipc	a5,0x0
ffffffffc0208d92:	dce78793          	addi	a5,a5,-562 # ffffffffc0208b5c <stdin_io>
ffffffffc0208d96:	f01c                	sd	a5,32(s0)
ffffffffc0208d98:	00000797          	auipc	a5,0x0
ffffffffc0208d9c:	dc078793          	addi	a5,a5,-576 # ffffffffc0208b58 <stdin_ioctl>
ffffffffc0208da0:	f41c                	sd	a5,40(s0)
ffffffffc0208da2:	0008d517          	auipc	a0,0x8d
ffffffffc0208da6:	ab650513          	addi	a0,a0,-1354 # ffffffffc0295858 <__wait_queue>
ffffffffc0208daa:	00043023          	sd	zero,0(s0)
ffffffffc0208dae:	0008e797          	auipc	a5,0x8e
ffffffffc0208db2:	b407bd23          	sd	zero,-1190(a5) # ffffffffc0296908 <p_wpos>
ffffffffc0208db6:	0008e797          	auipc	a5,0x8e
ffffffffc0208dba:	b407b523          	sd	zero,-1206(a5) # ffffffffc0296900 <p_rpos>
ffffffffc0208dbe:	fd8fb0ef          	jal	ra,ffffffffc0204596 <wait_queue_init>
ffffffffc0208dc2:	4601                	li	a2,0
ffffffffc0208dc4:	85a2                	mv	a1,s0
ffffffffc0208dc6:	00006517          	auipc	a0,0x6
ffffffffc0208dca:	e7a50513          	addi	a0,a0,-390 # ffffffffc020ec40 <dev_node_ops+0x270>
ffffffffc0208dce:	916ff0ef          	jal	ra,ffffffffc0207ee4 <vfs_add_dev>
ffffffffc0208dd2:	e10d                	bnez	a0,ffffffffc0208df4 <dev_init_stdin+0x98>
ffffffffc0208dd4:	60a2                	ld	ra,8(sp)
ffffffffc0208dd6:	6402                	ld	s0,0(sp)
ffffffffc0208dd8:	0141                	addi	sp,sp,16
ffffffffc0208dda:	8082                	ret
ffffffffc0208ddc:	00006617          	auipc	a2,0x6
ffffffffc0208de0:	e2460613          	addi	a2,a2,-476 # ffffffffc020ec00 <dev_node_ops+0x230>
ffffffffc0208de4:	07500593          	li	a1,117
ffffffffc0208de8:	00006517          	auipc	a0,0x6
ffffffffc0208dec:	e3850513          	addi	a0,a0,-456 # ffffffffc020ec20 <dev_node_ops+0x250>
ffffffffc0208df0:	eaef70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208df4:	86aa                	mv	a3,a0
ffffffffc0208df6:	00006617          	auipc	a2,0x6
ffffffffc0208dfa:	e5260613          	addi	a2,a2,-430 # ffffffffc020ec48 <dev_node_ops+0x278>
ffffffffc0208dfe:	07b00593          	li	a1,123
ffffffffc0208e02:	00006517          	auipc	a0,0x6
ffffffffc0208e06:	e1e50513          	addi	a0,a0,-482 # ffffffffc020ec20 <dev_node_ops+0x250>
ffffffffc0208e0a:	e94f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208e0e:	00006697          	auipc	a3,0x6
ffffffffc0208e12:	89a68693          	addi	a3,a3,-1894 # ffffffffc020e6a8 <syscalls+0xb10>
ffffffffc0208e16:	00003617          	auipc	a2,0x3
ffffffffc0208e1a:	c3260613          	addi	a2,a2,-974 # ffffffffc020ba48 <commands+0x210>
ffffffffc0208e1e:	07700593          	li	a1,119
ffffffffc0208e22:	00006517          	auipc	a0,0x6
ffffffffc0208e26:	dfe50513          	addi	a0,a0,-514 # ffffffffc020ec20 <dev_node_ops+0x250>
ffffffffc0208e2a:	e74f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208e2e <stdout_open>:
ffffffffc0208e2e:	4785                	li	a5,1
ffffffffc0208e30:	4501                	li	a0,0
ffffffffc0208e32:	00f59363          	bne	a1,a5,ffffffffc0208e38 <stdout_open+0xa>
ffffffffc0208e36:	8082                	ret
ffffffffc0208e38:	5575                	li	a0,-3
ffffffffc0208e3a:	8082                	ret

ffffffffc0208e3c <stdout_close>:
ffffffffc0208e3c:	4501                	li	a0,0
ffffffffc0208e3e:	8082                	ret

ffffffffc0208e40 <stdout_ioctl>:
ffffffffc0208e40:	5575                	li	a0,-3
ffffffffc0208e42:	8082                	ret

ffffffffc0208e44 <stdout_io>:
ffffffffc0208e44:	ca05                	beqz	a2,ffffffffc0208e74 <stdout_io+0x30>
ffffffffc0208e46:	6d9c                	ld	a5,24(a1)
ffffffffc0208e48:	1101                	addi	sp,sp,-32
ffffffffc0208e4a:	e822                	sd	s0,16(sp)
ffffffffc0208e4c:	e426                	sd	s1,8(sp)
ffffffffc0208e4e:	ec06                	sd	ra,24(sp)
ffffffffc0208e50:	6180                	ld	s0,0(a1)
ffffffffc0208e52:	84ae                	mv	s1,a1
ffffffffc0208e54:	cb91                	beqz	a5,ffffffffc0208e68 <stdout_io+0x24>
ffffffffc0208e56:	00044503          	lbu	a0,0(s0)
ffffffffc0208e5a:	0405                	addi	s0,s0,1
ffffffffc0208e5c:	b86f70ef          	jal	ra,ffffffffc02001e2 <cputchar>
ffffffffc0208e60:	6c9c                	ld	a5,24(s1)
ffffffffc0208e62:	17fd                	addi	a5,a5,-1
ffffffffc0208e64:	ec9c                	sd	a5,24(s1)
ffffffffc0208e66:	fbe5                	bnez	a5,ffffffffc0208e56 <stdout_io+0x12>
ffffffffc0208e68:	60e2                	ld	ra,24(sp)
ffffffffc0208e6a:	6442                	ld	s0,16(sp)
ffffffffc0208e6c:	64a2                	ld	s1,8(sp)
ffffffffc0208e6e:	4501                	li	a0,0
ffffffffc0208e70:	6105                	addi	sp,sp,32
ffffffffc0208e72:	8082                	ret
ffffffffc0208e74:	5575                	li	a0,-3
ffffffffc0208e76:	8082                	ret

ffffffffc0208e78 <dev_init_stdout>:
ffffffffc0208e78:	1141                	addi	sp,sp,-16
ffffffffc0208e7a:	e406                	sd	ra,8(sp)
ffffffffc0208e7c:	9adff0ef          	jal	ra,ffffffffc0208828 <dev_create_inode>
ffffffffc0208e80:	c939                	beqz	a0,ffffffffc0208ed6 <dev_init_stdout+0x5e>
ffffffffc0208e82:	4d38                	lw	a4,88(a0)
ffffffffc0208e84:	6785                	lui	a5,0x1
ffffffffc0208e86:	23478793          	addi	a5,a5,564 # 1234 <_binary_bin_swap_img_size-0x6acc>
ffffffffc0208e8a:	85aa                	mv	a1,a0
ffffffffc0208e8c:	06f71e63          	bne	a4,a5,ffffffffc0208f08 <dev_init_stdout+0x90>
ffffffffc0208e90:	4785                	li	a5,1
ffffffffc0208e92:	e51c                	sd	a5,8(a0)
ffffffffc0208e94:	00000797          	auipc	a5,0x0
ffffffffc0208e98:	f9a78793          	addi	a5,a5,-102 # ffffffffc0208e2e <stdout_open>
ffffffffc0208e9c:	e91c                	sd	a5,16(a0)
ffffffffc0208e9e:	00000797          	auipc	a5,0x0
ffffffffc0208ea2:	f9e78793          	addi	a5,a5,-98 # ffffffffc0208e3c <stdout_close>
ffffffffc0208ea6:	ed1c                	sd	a5,24(a0)
ffffffffc0208ea8:	00000797          	auipc	a5,0x0
ffffffffc0208eac:	f9c78793          	addi	a5,a5,-100 # ffffffffc0208e44 <stdout_io>
ffffffffc0208eb0:	f11c                	sd	a5,32(a0)
ffffffffc0208eb2:	00000797          	auipc	a5,0x0
ffffffffc0208eb6:	f8e78793          	addi	a5,a5,-114 # ffffffffc0208e40 <stdout_ioctl>
ffffffffc0208eba:	00053023          	sd	zero,0(a0)
ffffffffc0208ebe:	f51c                	sd	a5,40(a0)
ffffffffc0208ec0:	4601                	li	a2,0
ffffffffc0208ec2:	00006517          	auipc	a0,0x6
ffffffffc0208ec6:	de650513          	addi	a0,a0,-538 # ffffffffc020eca8 <dev_node_ops+0x2d8>
ffffffffc0208eca:	81aff0ef          	jal	ra,ffffffffc0207ee4 <vfs_add_dev>
ffffffffc0208ece:	e105                	bnez	a0,ffffffffc0208eee <dev_init_stdout+0x76>
ffffffffc0208ed0:	60a2                	ld	ra,8(sp)
ffffffffc0208ed2:	0141                	addi	sp,sp,16
ffffffffc0208ed4:	8082                	ret
ffffffffc0208ed6:	00006617          	auipc	a2,0x6
ffffffffc0208eda:	d9260613          	addi	a2,a2,-622 # ffffffffc020ec68 <dev_node_ops+0x298>
ffffffffc0208ede:	03700593          	li	a1,55
ffffffffc0208ee2:	00006517          	auipc	a0,0x6
ffffffffc0208ee6:	da650513          	addi	a0,a0,-602 # ffffffffc020ec88 <dev_node_ops+0x2b8>
ffffffffc0208eea:	db4f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208eee:	86aa                	mv	a3,a0
ffffffffc0208ef0:	00006617          	auipc	a2,0x6
ffffffffc0208ef4:	dc060613          	addi	a2,a2,-576 # ffffffffc020ecb0 <dev_node_ops+0x2e0>
ffffffffc0208ef8:	03d00593          	li	a1,61
ffffffffc0208efc:	00006517          	auipc	a0,0x6
ffffffffc0208f00:	d8c50513          	addi	a0,a0,-628 # ffffffffc020ec88 <dev_node_ops+0x2b8>
ffffffffc0208f04:	d9af70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0208f08:	00005697          	auipc	a3,0x5
ffffffffc0208f0c:	7a068693          	addi	a3,a3,1952 # ffffffffc020e6a8 <syscalls+0xb10>
ffffffffc0208f10:	00003617          	auipc	a2,0x3
ffffffffc0208f14:	b3860613          	addi	a2,a2,-1224 # ffffffffc020ba48 <commands+0x210>
ffffffffc0208f18:	03900593          	li	a1,57
ffffffffc0208f1c:	00006517          	auipc	a0,0x6
ffffffffc0208f20:	d6c50513          	addi	a0,a0,-660 # ffffffffc020ec88 <dev_node_ops+0x2b8>
ffffffffc0208f24:	d7af70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208f28 <bitmap_translate.part.0>:
ffffffffc0208f28:	1141                	addi	sp,sp,-16
ffffffffc0208f2a:	00006697          	auipc	a3,0x6
ffffffffc0208f2e:	da668693          	addi	a3,a3,-602 # ffffffffc020ecd0 <dev_node_ops+0x300>
ffffffffc0208f32:	00003617          	auipc	a2,0x3
ffffffffc0208f36:	b1660613          	addi	a2,a2,-1258 # ffffffffc020ba48 <commands+0x210>
ffffffffc0208f3a:	04c00593          	li	a1,76
ffffffffc0208f3e:	00006517          	auipc	a0,0x6
ffffffffc0208f42:	daa50513          	addi	a0,a0,-598 # ffffffffc020ece8 <dev_node_ops+0x318>
ffffffffc0208f46:	e406                	sd	ra,8(sp)
ffffffffc0208f48:	d56f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0208f4c <bitmap_create>:
ffffffffc0208f4c:	7139                	addi	sp,sp,-64
ffffffffc0208f4e:	fc06                	sd	ra,56(sp)
ffffffffc0208f50:	f822                	sd	s0,48(sp)
ffffffffc0208f52:	f426                	sd	s1,40(sp)
ffffffffc0208f54:	f04a                	sd	s2,32(sp)
ffffffffc0208f56:	ec4e                	sd	s3,24(sp)
ffffffffc0208f58:	e852                	sd	s4,16(sp)
ffffffffc0208f5a:	e456                	sd	s5,8(sp)
ffffffffc0208f5c:	c14d                	beqz	a0,ffffffffc0208ffe <bitmap_create+0xb2>
ffffffffc0208f5e:	842a                	mv	s0,a0
ffffffffc0208f60:	4541                	li	a0,16
ffffffffc0208f62:	82cf90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0208f66:	84aa                	mv	s1,a0
ffffffffc0208f68:	cd25                	beqz	a0,ffffffffc0208fe0 <bitmap_create+0x94>
ffffffffc0208f6a:	02041a13          	slli	s4,s0,0x20
ffffffffc0208f6e:	020a5a13          	srli	s4,s4,0x20
ffffffffc0208f72:	01fa0793          	addi	a5,s4,31
ffffffffc0208f76:	0057d993          	srli	s3,a5,0x5
ffffffffc0208f7a:	00299a93          	slli	s5,s3,0x2
ffffffffc0208f7e:	8556                	mv	a0,s5
ffffffffc0208f80:	894e                	mv	s2,s3
ffffffffc0208f82:	80cf90ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0208f86:	c53d                	beqz	a0,ffffffffc0208ff4 <bitmap_create+0xa8>
ffffffffc0208f88:	0134a223          	sw	s3,4(s1) # ffffffff80000004 <_binary_bin_sfs_img_size+0xffffffff7ff8ad04>
ffffffffc0208f8c:	c080                	sw	s0,0(s1)
ffffffffc0208f8e:	8656                	mv	a2,s5
ffffffffc0208f90:	0ff00593          	li	a1,255
ffffffffc0208f94:	5d2020ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc0208f98:	e488                	sd	a0,8(s1)
ffffffffc0208f9a:	0996                	slli	s3,s3,0x5
ffffffffc0208f9c:	053a0263          	beq	s4,s3,ffffffffc0208fe0 <bitmap_create+0x94>
ffffffffc0208fa0:	fff9079b          	addiw	a5,s2,-1
ffffffffc0208fa4:	0057969b          	slliw	a3,a5,0x5
ffffffffc0208fa8:	0054561b          	srliw	a2,s0,0x5
ffffffffc0208fac:	40d4073b          	subw	a4,s0,a3
ffffffffc0208fb0:	0054541b          	srliw	s0,s0,0x5
ffffffffc0208fb4:	08f61463          	bne	a2,a5,ffffffffc020903c <bitmap_create+0xf0>
ffffffffc0208fb8:	fff7069b          	addiw	a3,a4,-1
ffffffffc0208fbc:	47f9                	li	a5,30
ffffffffc0208fbe:	04d7ef63          	bltu	a5,a3,ffffffffc020901c <bitmap_create+0xd0>
ffffffffc0208fc2:	1402                	slli	s0,s0,0x20
ffffffffc0208fc4:	8079                	srli	s0,s0,0x1e
ffffffffc0208fc6:	9522                	add	a0,a0,s0
ffffffffc0208fc8:	411c                	lw	a5,0(a0)
ffffffffc0208fca:	4585                	li	a1,1
ffffffffc0208fcc:	02000613          	li	a2,32
ffffffffc0208fd0:	00e596bb          	sllw	a3,a1,a4
ffffffffc0208fd4:	8fb5                	xor	a5,a5,a3
ffffffffc0208fd6:	2705                	addiw	a4,a4,1
ffffffffc0208fd8:	2781                	sext.w	a5,a5
ffffffffc0208fda:	fec71be3          	bne	a4,a2,ffffffffc0208fd0 <bitmap_create+0x84>
ffffffffc0208fde:	c11c                	sw	a5,0(a0)
ffffffffc0208fe0:	70e2                	ld	ra,56(sp)
ffffffffc0208fe2:	7442                	ld	s0,48(sp)
ffffffffc0208fe4:	7902                	ld	s2,32(sp)
ffffffffc0208fe6:	69e2                	ld	s3,24(sp)
ffffffffc0208fe8:	6a42                	ld	s4,16(sp)
ffffffffc0208fea:	6aa2                	ld	s5,8(sp)
ffffffffc0208fec:	8526                	mv	a0,s1
ffffffffc0208fee:	74a2                	ld	s1,40(sp)
ffffffffc0208ff0:	6121                	addi	sp,sp,64
ffffffffc0208ff2:	8082                	ret
ffffffffc0208ff4:	8526                	mv	a0,s1
ffffffffc0208ff6:	848f90ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0208ffa:	4481                	li	s1,0
ffffffffc0208ffc:	b7d5                	j	ffffffffc0208fe0 <bitmap_create+0x94>
ffffffffc0208ffe:	00006697          	auipc	a3,0x6
ffffffffc0209002:	d0268693          	addi	a3,a3,-766 # ffffffffc020ed00 <dev_node_ops+0x330>
ffffffffc0209006:	00003617          	auipc	a2,0x3
ffffffffc020900a:	a4260613          	addi	a2,a2,-1470 # ffffffffc020ba48 <commands+0x210>
ffffffffc020900e:	45d5                	li	a1,21
ffffffffc0209010:	00006517          	auipc	a0,0x6
ffffffffc0209014:	cd850513          	addi	a0,a0,-808 # ffffffffc020ece8 <dev_node_ops+0x318>
ffffffffc0209018:	c86f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020901c:	00006697          	auipc	a3,0x6
ffffffffc0209020:	d2468693          	addi	a3,a3,-732 # ffffffffc020ed40 <dev_node_ops+0x370>
ffffffffc0209024:	00003617          	auipc	a2,0x3
ffffffffc0209028:	a2460613          	addi	a2,a2,-1500 # ffffffffc020ba48 <commands+0x210>
ffffffffc020902c:	02b00593          	li	a1,43
ffffffffc0209030:	00006517          	auipc	a0,0x6
ffffffffc0209034:	cb850513          	addi	a0,a0,-840 # ffffffffc020ece8 <dev_node_ops+0x318>
ffffffffc0209038:	c66f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020903c:	00006697          	auipc	a3,0x6
ffffffffc0209040:	cec68693          	addi	a3,a3,-788 # ffffffffc020ed28 <dev_node_ops+0x358>
ffffffffc0209044:	00003617          	auipc	a2,0x3
ffffffffc0209048:	a0460613          	addi	a2,a2,-1532 # ffffffffc020ba48 <commands+0x210>
ffffffffc020904c:	02a00593          	li	a1,42
ffffffffc0209050:	00006517          	auipc	a0,0x6
ffffffffc0209054:	c9850513          	addi	a0,a0,-872 # ffffffffc020ece8 <dev_node_ops+0x318>
ffffffffc0209058:	c46f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020905c <bitmap_alloc>:
ffffffffc020905c:	4150                	lw	a2,4(a0)
ffffffffc020905e:	651c                	ld	a5,8(a0)
ffffffffc0209060:	c231                	beqz	a2,ffffffffc02090a4 <bitmap_alloc+0x48>
ffffffffc0209062:	4701                	li	a4,0
ffffffffc0209064:	a029                	j	ffffffffc020906e <bitmap_alloc+0x12>
ffffffffc0209066:	2705                	addiw	a4,a4,1
ffffffffc0209068:	0791                	addi	a5,a5,4
ffffffffc020906a:	02e60d63          	beq	a2,a4,ffffffffc02090a4 <bitmap_alloc+0x48>
ffffffffc020906e:	4394                	lw	a3,0(a5)
ffffffffc0209070:	dafd                	beqz	a3,ffffffffc0209066 <bitmap_alloc+0xa>
ffffffffc0209072:	4501                	li	a0,0
ffffffffc0209074:	4885                	li	a7,1
ffffffffc0209076:	8e36                	mv	t3,a3
ffffffffc0209078:	02000313          	li	t1,32
ffffffffc020907c:	a021                	j	ffffffffc0209084 <bitmap_alloc+0x28>
ffffffffc020907e:	2505                	addiw	a0,a0,1
ffffffffc0209080:	02650463          	beq	a0,t1,ffffffffc02090a8 <bitmap_alloc+0x4c>
ffffffffc0209084:	00a8983b          	sllw	a6,a7,a0
ffffffffc0209088:	0106f633          	and	a2,a3,a6
ffffffffc020908c:	2601                	sext.w	a2,a2
ffffffffc020908e:	da65                	beqz	a2,ffffffffc020907e <bitmap_alloc+0x22>
ffffffffc0209090:	010e4833          	xor	a6,t3,a6
ffffffffc0209094:	0057171b          	slliw	a4,a4,0x5
ffffffffc0209098:	9f29                	addw	a4,a4,a0
ffffffffc020909a:	0107a023          	sw	a6,0(a5)
ffffffffc020909e:	c198                	sw	a4,0(a1)
ffffffffc02090a0:	4501                	li	a0,0
ffffffffc02090a2:	8082                	ret
ffffffffc02090a4:	5571                	li	a0,-4
ffffffffc02090a6:	8082                	ret
ffffffffc02090a8:	1141                	addi	sp,sp,-16
ffffffffc02090aa:	00004697          	auipc	a3,0x4
ffffffffc02090ae:	a1e68693          	addi	a3,a3,-1506 # ffffffffc020cac8 <default_pmm_manager+0x598>
ffffffffc02090b2:	00003617          	auipc	a2,0x3
ffffffffc02090b6:	99660613          	addi	a2,a2,-1642 # ffffffffc020ba48 <commands+0x210>
ffffffffc02090ba:	04300593          	li	a1,67
ffffffffc02090be:	00006517          	auipc	a0,0x6
ffffffffc02090c2:	c2a50513          	addi	a0,a0,-982 # ffffffffc020ece8 <dev_node_ops+0x318>
ffffffffc02090c6:	e406                	sd	ra,8(sp)
ffffffffc02090c8:	bd6f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02090cc <bitmap_test>:
ffffffffc02090cc:	411c                	lw	a5,0(a0)
ffffffffc02090ce:	00f5ff63          	bgeu	a1,a5,ffffffffc02090ec <bitmap_test+0x20>
ffffffffc02090d2:	651c                	ld	a5,8(a0)
ffffffffc02090d4:	0055d71b          	srliw	a4,a1,0x5
ffffffffc02090d8:	070a                	slli	a4,a4,0x2
ffffffffc02090da:	97ba                	add	a5,a5,a4
ffffffffc02090dc:	4388                	lw	a0,0(a5)
ffffffffc02090de:	4785                	li	a5,1
ffffffffc02090e0:	00b795bb          	sllw	a1,a5,a1
ffffffffc02090e4:	8d6d                	and	a0,a0,a1
ffffffffc02090e6:	1502                	slli	a0,a0,0x20
ffffffffc02090e8:	9101                	srli	a0,a0,0x20
ffffffffc02090ea:	8082                	ret
ffffffffc02090ec:	1141                	addi	sp,sp,-16
ffffffffc02090ee:	e406                	sd	ra,8(sp)
ffffffffc02090f0:	e39ff0ef          	jal	ra,ffffffffc0208f28 <bitmap_translate.part.0>

ffffffffc02090f4 <bitmap_free>:
ffffffffc02090f4:	411c                	lw	a5,0(a0)
ffffffffc02090f6:	1141                	addi	sp,sp,-16
ffffffffc02090f8:	e406                	sd	ra,8(sp)
ffffffffc02090fa:	02f5f463          	bgeu	a1,a5,ffffffffc0209122 <bitmap_free+0x2e>
ffffffffc02090fe:	651c                	ld	a5,8(a0)
ffffffffc0209100:	0055d71b          	srliw	a4,a1,0x5
ffffffffc0209104:	070a                	slli	a4,a4,0x2
ffffffffc0209106:	97ba                	add	a5,a5,a4
ffffffffc0209108:	4398                	lw	a4,0(a5)
ffffffffc020910a:	4685                	li	a3,1
ffffffffc020910c:	00b695bb          	sllw	a1,a3,a1
ffffffffc0209110:	00b776b3          	and	a3,a4,a1
ffffffffc0209114:	2681                	sext.w	a3,a3
ffffffffc0209116:	ea81                	bnez	a3,ffffffffc0209126 <bitmap_free+0x32>
ffffffffc0209118:	60a2                	ld	ra,8(sp)
ffffffffc020911a:	8f4d                	or	a4,a4,a1
ffffffffc020911c:	c398                	sw	a4,0(a5)
ffffffffc020911e:	0141                	addi	sp,sp,16
ffffffffc0209120:	8082                	ret
ffffffffc0209122:	e07ff0ef          	jal	ra,ffffffffc0208f28 <bitmap_translate.part.0>
ffffffffc0209126:	00006697          	auipc	a3,0x6
ffffffffc020912a:	c4268693          	addi	a3,a3,-958 # ffffffffc020ed68 <dev_node_ops+0x398>
ffffffffc020912e:	00003617          	auipc	a2,0x3
ffffffffc0209132:	91a60613          	addi	a2,a2,-1766 # ffffffffc020ba48 <commands+0x210>
ffffffffc0209136:	05f00593          	li	a1,95
ffffffffc020913a:	00006517          	auipc	a0,0x6
ffffffffc020913e:	bae50513          	addi	a0,a0,-1106 # ffffffffc020ece8 <dev_node_ops+0x318>
ffffffffc0209142:	b5cf70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209146 <bitmap_destroy>:
ffffffffc0209146:	1141                	addi	sp,sp,-16
ffffffffc0209148:	e022                	sd	s0,0(sp)
ffffffffc020914a:	842a                	mv	s0,a0
ffffffffc020914c:	6508                	ld	a0,8(a0)
ffffffffc020914e:	e406                	sd	ra,8(sp)
ffffffffc0209150:	eeff80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209154:	8522                	mv	a0,s0
ffffffffc0209156:	6402                	ld	s0,0(sp)
ffffffffc0209158:	60a2                	ld	ra,8(sp)
ffffffffc020915a:	0141                	addi	sp,sp,16
ffffffffc020915c:	ee3f806f          	j	ffffffffc020203e <kfree>

ffffffffc0209160 <bitmap_getdata>:
ffffffffc0209160:	c589                	beqz	a1,ffffffffc020916a <bitmap_getdata+0xa>
ffffffffc0209162:	00456783          	lwu	a5,4(a0)
ffffffffc0209166:	078a                	slli	a5,a5,0x2
ffffffffc0209168:	e19c                	sd	a5,0(a1)
ffffffffc020916a:	6508                	ld	a0,8(a0)
ffffffffc020916c:	8082                	ret

ffffffffc020916e <sfs_init>:
ffffffffc020916e:	1141                	addi	sp,sp,-16
ffffffffc0209170:	00006517          	auipc	a0,0x6
ffffffffc0209174:	a6850513          	addi	a0,a0,-1432 # ffffffffc020ebd8 <dev_node_ops+0x208>
ffffffffc0209178:	e406                	sd	ra,8(sp)
ffffffffc020917a:	554000ef          	jal	ra,ffffffffc02096ce <sfs_mount>
ffffffffc020917e:	e501                	bnez	a0,ffffffffc0209186 <sfs_init+0x18>
ffffffffc0209180:	60a2                	ld	ra,8(sp)
ffffffffc0209182:	0141                	addi	sp,sp,16
ffffffffc0209184:	8082                	ret
ffffffffc0209186:	86aa                	mv	a3,a0
ffffffffc0209188:	00006617          	auipc	a2,0x6
ffffffffc020918c:	bf060613          	addi	a2,a2,-1040 # ffffffffc020ed78 <dev_node_ops+0x3a8>
ffffffffc0209190:	45c1                	li	a1,16
ffffffffc0209192:	00006517          	auipc	a0,0x6
ffffffffc0209196:	c0650513          	addi	a0,a0,-1018 # ffffffffc020ed98 <dev_node_ops+0x3c8>
ffffffffc020919a:	b04f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020919e <sfs_unmount>:
ffffffffc020919e:	1141                	addi	sp,sp,-16
ffffffffc02091a0:	e406                	sd	ra,8(sp)
ffffffffc02091a2:	e022                	sd	s0,0(sp)
ffffffffc02091a4:	cd1d                	beqz	a0,ffffffffc02091e2 <sfs_unmount+0x44>
ffffffffc02091a6:	0b052783          	lw	a5,176(a0)
ffffffffc02091aa:	842a                	mv	s0,a0
ffffffffc02091ac:	eb9d                	bnez	a5,ffffffffc02091e2 <sfs_unmount+0x44>
ffffffffc02091ae:	7158                	ld	a4,160(a0)
ffffffffc02091b0:	09850793          	addi	a5,a0,152
ffffffffc02091b4:	02f71563          	bne	a4,a5,ffffffffc02091de <sfs_unmount+0x40>
ffffffffc02091b8:	613c                	ld	a5,64(a0)
ffffffffc02091ba:	e7a1                	bnez	a5,ffffffffc0209202 <sfs_unmount+0x64>
ffffffffc02091bc:	7d08                	ld	a0,56(a0)
ffffffffc02091be:	f89ff0ef          	jal	ra,ffffffffc0209146 <bitmap_destroy>
ffffffffc02091c2:	6428                	ld	a0,72(s0)
ffffffffc02091c4:	e7bf80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02091c8:	7448                	ld	a0,168(s0)
ffffffffc02091ca:	e75f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02091ce:	8522                	mv	a0,s0
ffffffffc02091d0:	e6ff80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc02091d4:	4501                	li	a0,0
ffffffffc02091d6:	60a2                	ld	ra,8(sp)
ffffffffc02091d8:	6402                	ld	s0,0(sp)
ffffffffc02091da:	0141                	addi	sp,sp,16
ffffffffc02091dc:	8082                	ret
ffffffffc02091de:	5545                	li	a0,-15
ffffffffc02091e0:	bfdd                	j	ffffffffc02091d6 <sfs_unmount+0x38>
ffffffffc02091e2:	00006697          	auipc	a3,0x6
ffffffffc02091e6:	bce68693          	addi	a3,a3,-1074 # ffffffffc020edb0 <dev_node_ops+0x3e0>
ffffffffc02091ea:	00003617          	auipc	a2,0x3
ffffffffc02091ee:	85e60613          	addi	a2,a2,-1954 # ffffffffc020ba48 <commands+0x210>
ffffffffc02091f2:	04100593          	li	a1,65
ffffffffc02091f6:	00006517          	auipc	a0,0x6
ffffffffc02091fa:	bea50513          	addi	a0,a0,-1046 # ffffffffc020ede0 <dev_node_ops+0x410>
ffffffffc02091fe:	aa0f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209202:	00006697          	auipc	a3,0x6
ffffffffc0209206:	bf668693          	addi	a3,a3,-1034 # ffffffffc020edf8 <dev_node_ops+0x428>
ffffffffc020920a:	00003617          	auipc	a2,0x3
ffffffffc020920e:	83e60613          	addi	a2,a2,-1986 # ffffffffc020ba48 <commands+0x210>
ffffffffc0209212:	04500593          	li	a1,69
ffffffffc0209216:	00006517          	auipc	a0,0x6
ffffffffc020921a:	bca50513          	addi	a0,a0,-1078 # ffffffffc020ede0 <dev_node_ops+0x410>
ffffffffc020921e:	a80f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209222 <sfs_cleanup>:
ffffffffc0209222:	1101                	addi	sp,sp,-32
ffffffffc0209224:	ec06                	sd	ra,24(sp)
ffffffffc0209226:	e822                	sd	s0,16(sp)
ffffffffc0209228:	e426                	sd	s1,8(sp)
ffffffffc020922a:	e04a                	sd	s2,0(sp)
ffffffffc020922c:	c525                	beqz	a0,ffffffffc0209294 <sfs_cleanup+0x72>
ffffffffc020922e:	0b052783          	lw	a5,176(a0)
ffffffffc0209232:	84aa                	mv	s1,a0
ffffffffc0209234:	e3a5                	bnez	a5,ffffffffc0209294 <sfs_cleanup+0x72>
ffffffffc0209236:	4158                	lw	a4,4(a0)
ffffffffc0209238:	4514                	lw	a3,8(a0)
ffffffffc020923a:	00c50913          	addi	s2,a0,12
ffffffffc020923e:	85ca                	mv	a1,s2
ffffffffc0209240:	40d7063b          	subw	a2,a4,a3
ffffffffc0209244:	00006517          	auipc	a0,0x6
ffffffffc0209248:	bcc50513          	addi	a0,a0,-1076 # ffffffffc020ee10 <dev_node_ops+0x440>
ffffffffc020924c:	f5bf60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc0209250:	02000413          	li	s0,32
ffffffffc0209254:	a019                	j	ffffffffc020925a <sfs_cleanup+0x38>
ffffffffc0209256:	347d                	addiw	s0,s0,-1
ffffffffc0209258:	c819                	beqz	s0,ffffffffc020926e <sfs_cleanup+0x4c>
ffffffffc020925a:	7cdc                	ld	a5,184(s1)
ffffffffc020925c:	8526                	mv	a0,s1
ffffffffc020925e:	9782                	jalr	a5
ffffffffc0209260:	f97d                	bnez	a0,ffffffffc0209256 <sfs_cleanup+0x34>
ffffffffc0209262:	60e2                	ld	ra,24(sp)
ffffffffc0209264:	6442                	ld	s0,16(sp)
ffffffffc0209266:	64a2                	ld	s1,8(sp)
ffffffffc0209268:	6902                	ld	s2,0(sp)
ffffffffc020926a:	6105                	addi	sp,sp,32
ffffffffc020926c:	8082                	ret
ffffffffc020926e:	6442                	ld	s0,16(sp)
ffffffffc0209270:	60e2                	ld	ra,24(sp)
ffffffffc0209272:	64a2                	ld	s1,8(sp)
ffffffffc0209274:	86ca                	mv	a3,s2
ffffffffc0209276:	6902                	ld	s2,0(sp)
ffffffffc0209278:	872a                	mv	a4,a0
ffffffffc020927a:	00006617          	auipc	a2,0x6
ffffffffc020927e:	bb660613          	addi	a2,a2,-1098 # ffffffffc020ee30 <dev_node_ops+0x460>
ffffffffc0209282:	05f00593          	li	a1,95
ffffffffc0209286:	00006517          	auipc	a0,0x6
ffffffffc020928a:	b5a50513          	addi	a0,a0,-1190 # ffffffffc020ede0 <dev_node_ops+0x410>
ffffffffc020928e:	6105                	addi	sp,sp,32
ffffffffc0209290:	a76f706f          	j	ffffffffc0200506 <__warn>
ffffffffc0209294:	00006697          	auipc	a3,0x6
ffffffffc0209298:	b1c68693          	addi	a3,a3,-1252 # ffffffffc020edb0 <dev_node_ops+0x3e0>
ffffffffc020929c:	00002617          	auipc	a2,0x2
ffffffffc02092a0:	7ac60613          	addi	a2,a2,1964 # ffffffffc020ba48 <commands+0x210>
ffffffffc02092a4:	05400593          	li	a1,84
ffffffffc02092a8:	00006517          	auipc	a0,0x6
ffffffffc02092ac:	b3850513          	addi	a0,a0,-1224 # ffffffffc020ede0 <dev_node_ops+0x410>
ffffffffc02092b0:	9eef70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02092b4 <sfs_sync>:
ffffffffc02092b4:	7179                	addi	sp,sp,-48
ffffffffc02092b6:	f406                	sd	ra,40(sp)
ffffffffc02092b8:	f022                	sd	s0,32(sp)
ffffffffc02092ba:	ec26                	sd	s1,24(sp)
ffffffffc02092bc:	e84a                	sd	s2,16(sp)
ffffffffc02092be:	e44e                	sd	s3,8(sp)
ffffffffc02092c0:	e052                	sd	s4,0(sp)
ffffffffc02092c2:	cd4d                	beqz	a0,ffffffffc020937c <sfs_sync+0xc8>
ffffffffc02092c4:	0b052783          	lw	a5,176(a0)
ffffffffc02092c8:	8a2a                	mv	s4,a0
ffffffffc02092ca:	ebcd                	bnez	a5,ffffffffc020937c <sfs_sync+0xc8>
ffffffffc02092cc:	547010ef          	jal	ra,ffffffffc020b012 <lock_sfs_fs>
ffffffffc02092d0:	0a0a3403          	ld	s0,160(s4)
ffffffffc02092d4:	098a0913          	addi	s2,s4,152
ffffffffc02092d8:	02890763          	beq	s2,s0,ffffffffc0209306 <sfs_sync+0x52>
ffffffffc02092dc:	00004997          	auipc	s3,0x4
ffffffffc02092e0:	0f498993          	addi	s3,s3,244 # ffffffffc020d3d0 <default_pmm_manager+0xea0>
ffffffffc02092e4:	7c1c                	ld	a5,56(s0)
ffffffffc02092e6:	fc840493          	addi	s1,s0,-56
ffffffffc02092ea:	cbb5                	beqz	a5,ffffffffc020935e <sfs_sync+0xaa>
ffffffffc02092ec:	7b9c                	ld	a5,48(a5)
ffffffffc02092ee:	cba5                	beqz	a5,ffffffffc020935e <sfs_sync+0xaa>
ffffffffc02092f0:	85ce                	mv	a1,s3
ffffffffc02092f2:	8526                	mv	a0,s1
ffffffffc02092f4:	e28fe0ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc02092f8:	7c1c                	ld	a5,56(s0)
ffffffffc02092fa:	8526                	mv	a0,s1
ffffffffc02092fc:	7b9c                	ld	a5,48(a5)
ffffffffc02092fe:	9782                	jalr	a5
ffffffffc0209300:	6400                	ld	s0,8(s0)
ffffffffc0209302:	fe8911e3          	bne	s2,s0,ffffffffc02092e4 <sfs_sync+0x30>
ffffffffc0209306:	8552                	mv	a0,s4
ffffffffc0209308:	51b010ef          	jal	ra,ffffffffc020b022 <unlock_sfs_fs>
ffffffffc020930c:	040a3783          	ld	a5,64(s4)
ffffffffc0209310:	4501                	li	a0,0
ffffffffc0209312:	eb89                	bnez	a5,ffffffffc0209324 <sfs_sync+0x70>
ffffffffc0209314:	70a2                	ld	ra,40(sp)
ffffffffc0209316:	7402                	ld	s0,32(sp)
ffffffffc0209318:	64e2                	ld	s1,24(sp)
ffffffffc020931a:	6942                	ld	s2,16(sp)
ffffffffc020931c:	69a2                	ld	s3,8(sp)
ffffffffc020931e:	6a02                	ld	s4,0(sp)
ffffffffc0209320:	6145                	addi	sp,sp,48
ffffffffc0209322:	8082                	ret
ffffffffc0209324:	040a3023          	sd	zero,64(s4)
ffffffffc0209328:	8552                	mv	a0,s4
ffffffffc020932a:	3cd010ef          	jal	ra,ffffffffc020aef6 <sfs_sync_super>
ffffffffc020932e:	cd01                	beqz	a0,ffffffffc0209346 <sfs_sync+0x92>
ffffffffc0209330:	70a2                	ld	ra,40(sp)
ffffffffc0209332:	7402                	ld	s0,32(sp)
ffffffffc0209334:	4785                	li	a5,1
ffffffffc0209336:	04fa3023          	sd	a5,64(s4)
ffffffffc020933a:	64e2                	ld	s1,24(sp)
ffffffffc020933c:	6942                	ld	s2,16(sp)
ffffffffc020933e:	69a2                	ld	s3,8(sp)
ffffffffc0209340:	6a02                	ld	s4,0(sp)
ffffffffc0209342:	6145                	addi	sp,sp,48
ffffffffc0209344:	8082                	ret
ffffffffc0209346:	8552                	mv	a0,s4
ffffffffc0209348:	3f5010ef          	jal	ra,ffffffffc020af3c <sfs_sync_freemap>
ffffffffc020934c:	f175                	bnez	a0,ffffffffc0209330 <sfs_sync+0x7c>
ffffffffc020934e:	70a2                	ld	ra,40(sp)
ffffffffc0209350:	7402                	ld	s0,32(sp)
ffffffffc0209352:	64e2                	ld	s1,24(sp)
ffffffffc0209354:	6942                	ld	s2,16(sp)
ffffffffc0209356:	69a2                	ld	s3,8(sp)
ffffffffc0209358:	6a02                	ld	s4,0(sp)
ffffffffc020935a:	6145                	addi	sp,sp,48
ffffffffc020935c:	8082                	ret
ffffffffc020935e:	00004697          	auipc	a3,0x4
ffffffffc0209362:	02268693          	addi	a3,a3,34 # ffffffffc020d380 <default_pmm_manager+0xe50>
ffffffffc0209366:	00002617          	auipc	a2,0x2
ffffffffc020936a:	6e260613          	addi	a2,a2,1762 # ffffffffc020ba48 <commands+0x210>
ffffffffc020936e:	45ed                	li	a1,27
ffffffffc0209370:	00006517          	auipc	a0,0x6
ffffffffc0209374:	a7050513          	addi	a0,a0,-1424 # ffffffffc020ede0 <dev_node_ops+0x410>
ffffffffc0209378:	926f70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020937c:	00006697          	auipc	a3,0x6
ffffffffc0209380:	a3468693          	addi	a3,a3,-1484 # ffffffffc020edb0 <dev_node_ops+0x3e0>
ffffffffc0209384:	00002617          	auipc	a2,0x2
ffffffffc0209388:	6c460613          	addi	a2,a2,1732 # ffffffffc020ba48 <commands+0x210>
ffffffffc020938c:	45d5                	li	a1,21
ffffffffc020938e:	00006517          	auipc	a0,0x6
ffffffffc0209392:	a5250513          	addi	a0,a0,-1454 # ffffffffc020ede0 <dev_node_ops+0x410>
ffffffffc0209396:	908f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020939a <sfs_get_root>:
ffffffffc020939a:	1101                	addi	sp,sp,-32
ffffffffc020939c:	ec06                	sd	ra,24(sp)
ffffffffc020939e:	cd09                	beqz	a0,ffffffffc02093b8 <sfs_get_root+0x1e>
ffffffffc02093a0:	0b052783          	lw	a5,176(a0)
ffffffffc02093a4:	eb91                	bnez	a5,ffffffffc02093b8 <sfs_get_root+0x1e>
ffffffffc02093a6:	4605                	li	a2,1
ffffffffc02093a8:	002c                	addi	a1,sp,8
ffffffffc02093aa:	37e010ef          	jal	ra,ffffffffc020a728 <sfs_load_inode>
ffffffffc02093ae:	e50d                	bnez	a0,ffffffffc02093d8 <sfs_get_root+0x3e>
ffffffffc02093b0:	60e2                	ld	ra,24(sp)
ffffffffc02093b2:	6522                	ld	a0,8(sp)
ffffffffc02093b4:	6105                	addi	sp,sp,32
ffffffffc02093b6:	8082                	ret
ffffffffc02093b8:	00006697          	auipc	a3,0x6
ffffffffc02093bc:	9f868693          	addi	a3,a3,-1544 # ffffffffc020edb0 <dev_node_ops+0x3e0>
ffffffffc02093c0:	00002617          	auipc	a2,0x2
ffffffffc02093c4:	68860613          	addi	a2,a2,1672 # ffffffffc020ba48 <commands+0x210>
ffffffffc02093c8:	03600593          	li	a1,54
ffffffffc02093cc:	00006517          	auipc	a0,0x6
ffffffffc02093d0:	a1450513          	addi	a0,a0,-1516 # ffffffffc020ede0 <dev_node_ops+0x410>
ffffffffc02093d4:	8caf70ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02093d8:	86aa                	mv	a3,a0
ffffffffc02093da:	00006617          	auipc	a2,0x6
ffffffffc02093de:	a7660613          	addi	a2,a2,-1418 # ffffffffc020ee50 <dev_node_ops+0x480>
ffffffffc02093e2:	03700593          	li	a1,55
ffffffffc02093e6:	00006517          	auipc	a0,0x6
ffffffffc02093ea:	9fa50513          	addi	a0,a0,-1542 # ffffffffc020ede0 <dev_node_ops+0x410>
ffffffffc02093ee:	8b0f70ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02093f2 <sfs_do_mount>:
ffffffffc02093f2:	6518                	ld	a4,8(a0)
ffffffffc02093f4:	7171                	addi	sp,sp,-176
ffffffffc02093f6:	f506                	sd	ra,168(sp)
ffffffffc02093f8:	f122                	sd	s0,160(sp)
ffffffffc02093fa:	ed26                	sd	s1,152(sp)
ffffffffc02093fc:	e94a                	sd	s2,144(sp)
ffffffffc02093fe:	e54e                	sd	s3,136(sp)
ffffffffc0209400:	e152                	sd	s4,128(sp)
ffffffffc0209402:	fcd6                	sd	s5,120(sp)
ffffffffc0209404:	f8da                	sd	s6,112(sp)
ffffffffc0209406:	f4de                	sd	s7,104(sp)
ffffffffc0209408:	f0e2                	sd	s8,96(sp)
ffffffffc020940a:	ece6                	sd	s9,88(sp)
ffffffffc020940c:	e8ea                	sd	s10,80(sp)
ffffffffc020940e:	e4ee                	sd	s11,72(sp)
ffffffffc0209410:	6785                	lui	a5,0x1
ffffffffc0209412:	24f71663          	bne	a4,a5,ffffffffc020965e <sfs_do_mount+0x26c>
ffffffffc0209416:	892a                	mv	s2,a0
ffffffffc0209418:	4501                	li	a0,0
ffffffffc020941a:	8aae                	mv	s5,a1
ffffffffc020941c:	f00fe0ef          	jal	ra,ffffffffc0207b1c <__alloc_fs>
ffffffffc0209420:	842a                	mv	s0,a0
ffffffffc0209422:	24050463          	beqz	a0,ffffffffc020966a <sfs_do_mount+0x278>
ffffffffc0209426:	0b052b03          	lw	s6,176(a0)
ffffffffc020942a:	260b1263          	bnez	s6,ffffffffc020968e <sfs_do_mount+0x29c>
ffffffffc020942e:	03253823          	sd	s2,48(a0)
ffffffffc0209432:	6505                	lui	a0,0x1
ffffffffc0209434:	b5bf80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc0209438:	e428                	sd	a0,72(s0)
ffffffffc020943a:	84aa                	mv	s1,a0
ffffffffc020943c:	16050363          	beqz	a0,ffffffffc02095a2 <sfs_do_mount+0x1b0>
ffffffffc0209440:	85aa                	mv	a1,a0
ffffffffc0209442:	4681                	li	a3,0
ffffffffc0209444:	6605                	lui	a2,0x1
ffffffffc0209446:	1008                	addi	a0,sp,32
ffffffffc0209448:	f9bfb0ef          	jal	ra,ffffffffc02053e2 <iobuf_init>
ffffffffc020944c:	02093783          	ld	a5,32(s2)
ffffffffc0209450:	85aa                	mv	a1,a0
ffffffffc0209452:	4601                	li	a2,0
ffffffffc0209454:	854a                	mv	a0,s2
ffffffffc0209456:	9782                	jalr	a5
ffffffffc0209458:	8a2a                	mv	s4,a0
ffffffffc020945a:	10051e63          	bnez	a0,ffffffffc0209576 <sfs_do_mount+0x184>
ffffffffc020945e:	408c                	lw	a1,0(s1)
ffffffffc0209460:	2f8dc637          	lui	a2,0x2f8dc
ffffffffc0209464:	e2a60613          	addi	a2,a2,-470 # 2f8dbe2a <_binary_bin_sfs_img_size+0x2f866b2a>
ffffffffc0209468:	14c59863          	bne	a1,a2,ffffffffc02095b8 <sfs_do_mount+0x1c6>
ffffffffc020946c:	40dc                	lw	a5,4(s1)
ffffffffc020946e:	00093603          	ld	a2,0(s2)
ffffffffc0209472:	02079713          	slli	a4,a5,0x20
ffffffffc0209476:	9301                	srli	a4,a4,0x20
ffffffffc0209478:	12e66763          	bltu	a2,a4,ffffffffc02095a6 <sfs_do_mount+0x1b4>
ffffffffc020947c:	020485a3          	sb	zero,43(s1)
ffffffffc0209480:	0084af03          	lw	t5,8(s1)
ffffffffc0209484:	00c4ae83          	lw	t4,12(s1)
ffffffffc0209488:	0104ae03          	lw	t3,16(s1)
ffffffffc020948c:	0144a303          	lw	t1,20(s1)
ffffffffc0209490:	0184a883          	lw	a7,24(s1)
ffffffffc0209494:	01c4a803          	lw	a6,28(s1)
ffffffffc0209498:	5090                	lw	a2,32(s1)
ffffffffc020949a:	50d4                	lw	a3,36(s1)
ffffffffc020949c:	5498                	lw	a4,40(s1)
ffffffffc020949e:	6511                	lui	a0,0x4
ffffffffc02094a0:	c00c                	sw	a1,0(s0)
ffffffffc02094a2:	c05c                	sw	a5,4(s0)
ffffffffc02094a4:	01e42423          	sw	t5,8(s0)
ffffffffc02094a8:	01d42623          	sw	t4,12(s0)
ffffffffc02094ac:	01c42823          	sw	t3,16(s0)
ffffffffc02094b0:	00642a23          	sw	t1,20(s0)
ffffffffc02094b4:	01142c23          	sw	a7,24(s0)
ffffffffc02094b8:	01042e23          	sw	a6,28(s0)
ffffffffc02094bc:	d010                	sw	a2,32(s0)
ffffffffc02094be:	d054                	sw	a3,36(s0)
ffffffffc02094c0:	d418                	sw	a4,40(s0)
ffffffffc02094c2:	acdf80ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc02094c6:	f448                	sd	a0,168(s0)
ffffffffc02094c8:	8c2a                	mv	s8,a0
ffffffffc02094ca:	18050c63          	beqz	a0,ffffffffc0209662 <sfs_do_mount+0x270>
ffffffffc02094ce:	6711                	lui	a4,0x4
ffffffffc02094d0:	87aa                	mv	a5,a0
ffffffffc02094d2:	972a                	add	a4,a4,a0
ffffffffc02094d4:	e79c                	sd	a5,8(a5)
ffffffffc02094d6:	e39c                	sd	a5,0(a5)
ffffffffc02094d8:	07c1                	addi	a5,a5,16
ffffffffc02094da:	fee79de3          	bne	a5,a4,ffffffffc02094d4 <sfs_do_mount+0xe2>
ffffffffc02094de:	0044eb83          	lwu	s7,4(s1)
ffffffffc02094e2:	67a1                	lui	a5,0x8
ffffffffc02094e4:	fff78993          	addi	s3,a5,-1 # 7fff <_binary_bin_swap_img_size+0x2ff>
ffffffffc02094e8:	9bce                	add	s7,s7,s3
ffffffffc02094ea:	77e1                	lui	a5,0xffff8
ffffffffc02094ec:	00fbfbb3          	and	s7,s7,a5
ffffffffc02094f0:	2b81                	sext.w	s7,s7
ffffffffc02094f2:	855e                	mv	a0,s7
ffffffffc02094f4:	a59ff0ef          	jal	ra,ffffffffc0208f4c <bitmap_create>
ffffffffc02094f8:	fc08                	sd	a0,56(s0)
ffffffffc02094fa:	8d2a                	mv	s10,a0
ffffffffc02094fc:	14050f63          	beqz	a0,ffffffffc020965a <sfs_do_mount+0x268>
ffffffffc0209500:	0044e783          	lwu	a5,4(s1)
ffffffffc0209504:	082c                	addi	a1,sp,24
ffffffffc0209506:	97ce                	add	a5,a5,s3
ffffffffc0209508:	00f7d713          	srli	a4,a5,0xf
ffffffffc020950c:	e43a                	sd	a4,8(sp)
ffffffffc020950e:	40f7d993          	srai	s3,a5,0xf
ffffffffc0209512:	c4fff0ef          	jal	ra,ffffffffc0209160 <bitmap_getdata>
ffffffffc0209516:	14050c63          	beqz	a0,ffffffffc020966e <sfs_do_mount+0x27c>
ffffffffc020951a:	00c9979b          	slliw	a5,s3,0xc
ffffffffc020951e:	66e2                	ld	a3,24(sp)
ffffffffc0209520:	1782                	slli	a5,a5,0x20
ffffffffc0209522:	9381                	srli	a5,a5,0x20
ffffffffc0209524:	14d79563          	bne	a5,a3,ffffffffc020966e <sfs_do_mount+0x27c>
ffffffffc0209528:	6722                	ld	a4,8(sp)
ffffffffc020952a:	6d89                	lui	s11,0x2
ffffffffc020952c:	89aa                	mv	s3,a0
ffffffffc020952e:	00c71c93          	slli	s9,a4,0xc
ffffffffc0209532:	9caa                	add	s9,s9,a0
ffffffffc0209534:	40ad8dbb          	subw	s11,s11,a0
ffffffffc0209538:	e711                	bnez	a4,ffffffffc0209544 <sfs_do_mount+0x152>
ffffffffc020953a:	a079                	j	ffffffffc02095c8 <sfs_do_mount+0x1d6>
ffffffffc020953c:	6785                	lui	a5,0x1
ffffffffc020953e:	99be                	add	s3,s3,a5
ffffffffc0209540:	093c8463          	beq	s9,s3,ffffffffc02095c8 <sfs_do_mount+0x1d6>
ffffffffc0209544:	013d86bb          	addw	a3,s11,s3
ffffffffc0209548:	1682                	slli	a3,a3,0x20
ffffffffc020954a:	6605                	lui	a2,0x1
ffffffffc020954c:	85ce                	mv	a1,s3
ffffffffc020954e:	9281                	srli	a3,a3,0x20
ffffffffc0209550:	1008                	addi	a0,sp,32
ffffffffc0209552:	e91fb0ef          	jal	ra,ffffffffc02053e2 <iobuf_init>
ffffffffc0209556:	02093783          	ld	a5,32(s2)
ffffffffc020955a:	85aa                	mv	a1,a0
ffffffffc020955c:	4601                	li	a2,0
ffffffffc020955e:	854a                	mv	a0,s2
ffffffffc0209560:	9782                	jalr	a5
ffffffffc0209562:	dd69                	beqz	a0,ffffffffc020953c <sfs_do_mount+0x14a>
ffffffffc0209564:	e42a                	sd	a0,8(sp)
ffffffffc0209566:	856a                	mv	a0,s10
ffffffffc0209568:	bdfff0ef          	jal	ra,ffffffffc0209146 <bitmap_destroy>
ffffffffc020956c:	67a2                	ld	a5,8(sp)
ffffffffc020956e:	8a3e                	mv	s4,a5
ffffffffc0209570:	8562                	mv	a0,s8
ffffffffc0209572:	acdf80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209576:	8526                	mv	a0,s1
ffffffffc0209578:	ac7f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020957c:	8522                	mv	a0,s0
ffffffffc020957e:	ac1f80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209582:	70aa                	ld	ra,168(sp)
ffffffffc0209584:	740a                	ld	s0,160(sp)
ffffffffc0209586:	64ea                	ld	s1,152(sp)
ffffffffc0209588:	694a                	ld	s2,144(sp)
ffffffffc020958a:	69aa                	ld	s3,136(sp)
ffffffffc020958c:	7ae6                	ld	s5,120(sp)
ffffffffc020958e:	7b46                	ld	s6,112(sp)
ffffffffc0209590:	7ba6                	ld	s7,104(sp)
ffffffffc0209592:	7c06                	ld	s8,96(sp)
ffffffffc0209594:	6ce6                	ld	s9,88(sp)
ffffffffc0209596:	6d46                	ld	s10,80(sp)
ffffffffc0209598:	6da6                	ld	s11,72(sp)
ffffffffc020959a:	8552                	mv	a0,s4
ffffffffc020959c:	6a0a                	ld	s4,128(sp)
ffffffffc020959e:	614d                	addi	sp,sp,176
ffffffffc02095a0:	8082                	ret
ffffffffc02095a2:	5a71                	li	s4,-4
ffffffffc02095a4:	bfe1                	j	ffffffffc020957c <sfs_do_mount+0x18a>
ffffffffc02095a6:	85be                	mv	a1,a5
ffffffffc02095a8:	00006517          	auipc	a0,0x6
ffffffffc02095ac:	90050513          	addi	a0,a0,-1792 # ffffffffc020eea8 <dev_node_ops+0x4d8>
ffffffffc02095b0:	bf7f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02095b4:	5a75                	li	s4,-3
ffffffffc02095b6:	b7c1                	j	ffffffffc0209576 <sfs_do_mount+0x184>
ffffffffc02095b8:	00006517          	auipc	a0,0x6
ffffffffc02095bc:	8b850513          	addi	a0,a0,-1864 # ffffffffc020ee70 <dev_node_ops+0x4a0>
ffffffffc02095c0:	be7f60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc02095c4:	5a75                	li	s4,-3
ffffffffc02095c6:	bf45                	j	ffffffffc0209576 <sfs_do_mount+0x184>
ffffffffc02095c8:	00442903          	lw	s2,4(s0)
ffffffffc02095cc:	4481                	li	s1,0
ffffffffc02095ce:	080b8c63          	beqz	s7,ffffffffc0209666 <sfs_do_mount+0x274>
ffffffffc02095d2:	85a6                	mv	a1,s1
ffffffffc02095d4:	856a                	mv	a0,s10
ffffffffc02095d6:	af7ff0ef          	jal	ra,ffffffffc02090cc <bitmap_test>
ffffffffc02095da:	c111                	beqz	a0,ffffffffc02095de <sfs_do_mount+0x1ec>
ffffffffc02095dc:	2b05                	addiw	s6,s6,1
ffffffffc02095de:	2485                	addiw	s1,s1,1
ffffffffc02095e0:	fe9b99e3          	bne	s7,s1,ffffffffc02095d2 <sfs_do_mount+0x1e0>
ffffffffc02095e4:	441c                	lw	a5,8(s0)
ffffffffc02095e6:	0d679463          	bne	a5,s6,ffffffffc02096ae <sfs_do_mount+0x2bc>
ffffffffc02095ea:	4585                	li	a1,1
ffffffffc02095ec:	05040513          	addi	a0,s0,80
ffffffffc02095f0:	04043023          	sd	zero,64(s0)
ffffffffc02095f4:	f67fa0ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc02095f8:	4585                	li	a1,1
ffffffffc02095fa:	06840513          	addi	a0,s0,104
ffffffffc02095fe:	f5dfa0ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc0209602:	4585                	li	a1,1
ffffffffc0209604:	08040513          	addi	a0,s0,128
ffffffffc0209608:	f53fa0ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc020960c:	09840793          	addi	a5,s0,152
ffffffffc0209610:	f05c                	sd	a5,160(s0)
ffffffffc0209612:	ec5c                	sd	a5,152(s0)
ffffffffc0209614:	874a                	mv	a4,s2
ffffffffc0209616:	86da                	mv	a3,s6
ffffffffc0209618:	4169063b          	subw	a2,s2,s6
ffffffffc020961c:	00c40593          	addi	a1,s0,12
ffffffffc0209620:	00006517          	auipc	a0,0x6
ffffffffc0209624:	91850513          	addi	a0,a0,-1768 # ffffffffc020ef38 <dev_node_ops+0x568>
ffffffffc0209628:	b7ff60ef          	jal	ra,ffffffffc02001a6 <cprintf>
ffffffffc020962c:	00000797          	auipc	a5,0x0
ffffffffc0209630:	c8878793          	addi	a5,a5,-888 # ffffffffc02092b4 <sfs_sync>
ffffffffc0209634:	fc5c                	sd	a5,184(s0)
ffffffffc0209636:	00000797          	auipc	a5,0x0
ffffffffc020963a:	d6478793          	addi	a5,a5,-668 # ffffffffc020939a <sfs_get_root>
ffffffffc020963e:	e07c                	sd	a5,192(s0)
ffffffffc0209640:	00000797          	auipc	a5,0x0
ffffffffc0209644:	b5e78793          	addi	a5,a5,-1186 # ffffffffc020919e <sfs_unmount>
ffffffffc0209648:	e47c                	sd	a5,200(s0)
ffffffffc020964a:	00000797          	auipc	a5,0x0
ffffffffc020964e:	bd878793          	addi	a5,a5,-1064 # ffffffffc0209222 <sfs_cleanup>
ffffffffc0209652:	e87c                	sd	a5,208(s0)
ffffffffc0209654:	008ab023          	sd	s0,0(s5)
ffffffffc0209658:	b72d                	j	ffffffffc0209582 <sfs_do_mount+0x190>
ffffffffc020965a:	5a71                	li	s4,-4
ffffffffc020965c:	bf11                	j	ffffffffc0209570 <sfs_do_mount+0x17e>
ffffffffc020965e:	5a49                	li	s4,-14
ffffffffc0209660:	b70d                	j	ffffffffc0209582 <sfs_do_mount+0x190>
ffffffffc0209662:	5a71                	li	s4,-4
ffffffffc0209664:	bf09                	j	ffffffffc0209576 <sfs_do_mount+0x184>
ffffffffc0209666:	4b01                	li	s6,0
ffffffffc0209668:	bfb5                	j	ffffffffc02095e4 <sfs_do_mount+0x1f2>
ffffffffc020966a:	5a71                	li	s4,-4
ffffffffc020966c:	bf19                	j	ffffffffc0209582 <sfs_do_mount+0x190>
ffffffffc020966e:	00006697          	auipc	a3,0x6
ffffffffc0209672:	86a68693          	addi	a3,a3,-1942 # ffffffffc020eed8 <dev_node_ops+0x508>
ffffffffc0209676:	00002617          	auipc	a2,0x2
ffffffffc020967a:	3d260613          	addi	a2,a2,978 # ffffffffc020ba48 <commands+0x210>
ffffffffc020967e:	08300593          	li	a1,131
ffffffffc0209682:	00005517          	auipc	a0,0x5
ffffffffc0209686:	75e50513          	addi	a0,a0,1886 # ffffffffc020ede0 <dev_node_ops+0x410>
ffffffffc020968a:	e15f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020968e:	00005697          	auipc	a3,0x5
ffffffffc0209692:	72268693          	addi	a3,a3,1826 # ffffffffc020edb0 <dev_node_ops+0x3e0>
ffffffffc0209696:	00002617          	auipc	a2,0x2
ffffffffc020969a:	3b260613          	addi	a2,a2,946 # ffffffffc020ba48 <commands+0x210>
ffffffffc020969e:	0a300593          	li	a1,163
ffffffffc02096a2:	00005517          	auipc	a0,0x5
ffffffffc02096a6:	73e50513          	addi	a0,a0,1854 # ffffffffc020ede0 <dev_node_ops+0x410>
ffffffffc02096aa:	df5f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02096ae:	00006697          	auipc	a3,0x6
ffffffffc02096b2:	85a68693          	addi	a3,a3,-1958 # ffffffffc020ef08 <dev_node_ops+0x538>
ffffffffc02096b6:	00002617          	auipc	a2,0x2
ffffffffc02096ba:	39260613          	addi	a2,a2,914 # ffffffffc020ba48 <commands+0x210>
ffffffffc02096be:	0e000593          	li	a1,224
ffffffffc02096c2:	00005517          	auipc	a0,0x5
ffffffffc02096c6:	71e50513          	addi	a0,a0,1822 # ffffffffc020ede0 <dev_node_ops+0x410>
ffffffffc02096ca:	dd5f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02096ce <sfs_mount>:
ffffffffc02096ce:	00000597          	auipc	a1,0x0
ffffffffc02096d2:	d2458593          	addi	a1,a1,-732 # ffffffffc02093f2 <sfs_do_mount>
ffffffffc02096d6:	817fe06f          	j	ffffffffc0207eec <vfs_mount>

ffffffffc02096da <sfs_opendir>:
ffffffffc02096da:	0235f593          	andi	a1,a1,35
ffffffffc02096de:	4501                	li	a0,0
ffffffffc02096e0:	e191                	bnez	a1,ffffffffc02096e4 <sfs_opendir+0xa>
ffffffffc02096e2:	8082                	ret
ffffffffc02096e4:	553d                	li	a0,-17
ffffffffc02096e6:	8082                	ret

ffffffffc02096e8 <sfs_openfile>:
ffffffffc02096e8:	4501                	li	a0,0
ffffffffc02096ea:	8082                	ret

ffffffffc02096ec <sfs_gettype>:
ffffffffc02096ec:	1141                	addi	sp,sp,-16
ffffffffc02096ee:	e406                	sd	ra,8(sp)
ffffffffc02096f0:	c939                	beqz	a0,ffffffffc0209746 <sfs_gettype+0x5a>
ffffffffc02096f2:	4d34                	lw	a3,88(a0)
ffffffffc02096f4:	6785                	lui	a5,0x1
ffffffffc02096f6:	23578713          	addi	a4,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02096fa:	04e69663          	bne	a3,a4,ffffffffc0209746 <sfs_gettype+0x5a>
ffffffffc02096fe:	6114                	ld	a3,0(a0)
ffffffffc0209700:	4709                	li	a4,2
ffffffffc0209702:	0046d683          	lhu	a3,4(a3)
ffffffffc0209706:	02e68a63          	beq	a3,a4,ffffffffc020973a <sfs_gettype+0x4e>
ffffffffc020970a:	470d                	li	a4,3
ffffffffc020970c:	02e68163          	beq	a3,a4,ffffffffc020972e <sfs_gettype+0x42>
ffffffffc0209710:	4705                	li	a4,1
ffffffffc0209712:	00e68f63          	beq	a3,a4,ffffffffc0209730 <sfs_gettype+0x44>
ffffffffc0209716:	00006617          	auipc	a2,0x6
ffffffffc020971a:	89260613          	addi	a2,a2,-1902 # ffffffffc020efa8 <dev_node_ops+0x5d8>
ffffffffc020971e:	3ff00593          	li	a1,1023
ffffffffc0209722:	00006517          	auipc	a0,0x6
ffffffffc0209726:	86e50513          	addi	a0,a0,-1938 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020972a:	d75f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020972e:	678d                	lui	a5,0x3
ffffffffc0209730:	60a2                	ld	ra,8(sp)
ffffffffc0209732:	c19c                	sw	a5,0(a1)
ffffffffc0209734:	4501                	li	a0,0
ffffffffc0209736:	0141                	addi	sp,sp,16
ffffffffc0209738:	8082                	ret
ffffffffc020973a:	60a2                	ld	ra,8(sp)
ffffffffc020973c:	6789                	lui	a5,0x2
ffffffffc020973e:	c19c                	sw	a5,0(a1)
ffffffffc0209740:	4501                	li	a0,0
ffffffffc0209742:	0141                	addi	sp,sp,16
ffffffffc0209744:	8082                	ret
ffffffffc0209746:	00006697          	auipc	a3,0x6
ffffffffc020974a:	81268693          	addi	a3,a3,-2030 # ffffffffc020ef58 <dev_node_ops+0x588>
ffffffffc020974e:	00002617          	auipc	a2,0x2
ffffffffc0209752:	2fa60613          	addi	a2,a2,762 # ffffffffc020ba48 <commands+0x210>
ffffffffc0209756:	3f300593          	li	a1,1011
ffffffffc020975a:	00006517          	auipc	a0,0x6
ffffffffc020975e:	83650513          	addi	a0,a0,-1994 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209762:	d3df60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209766 <sfs_fsync>:
ffffffffc0209766:	7179                	addi	sp,sp,-48
ffffffffc0209768:	ec26                	sd	s1,24(sp)
ffffffffc020976a:	7524                	ld	s1,104(a0)
ffffffffc020976c:	f406                	sd	ra,40(sp)
ffffffffc020976e:	f022                	sd	s0,32(sp)
ffffffffc0209770:	e84a                	sd	s2,16(sp)
ffffffffc0209772:	e44e                	sd	s3,8(sp)
ffffffffc0209774:	c4bd                	beqz	s1,ffffffffc02097e2 <sfs_fsync+0x7c>
ffffffffc0209776:	0b04a783          	lw	a5,176(s1)
ffffffffc020977a:	e7a5                	bnez	a5,ffffffffc02097e2 <sfs_fsync+0x7c>
ffffffffc020977c:	4d38                	lw	a4,88(a0)
ffffffffc020977e:	6785                	lui	a5,0x1
ffffffffc0209780:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209784:	842a                	mv	s0,a0
ffffffffc0209786:	06f71e63          	bne	a4,a5,ffffffffc0209802 <sfs_fsync+0x9c>
ffffffffc020978a:	691c                	ld	a5,16(a0)
ffffffffc020978c:	4901                	li	s2,0
ffffffffc020978e:	eb89                	bnez	a5,ffffffffc02097a0 <sfs_fsync+0x3a>
ffffffffc0209790:	70a2                	ld	ra,40(sp)
ffffffffc0209792:	7402                	ld	s0,32(sp)
ffffffffc0209794:	64e2                	ld	s1,24(sp)
ffffffffc0209796:	69a2                	ld	s3,8(sp)
ffffffffc0209798:	854a                	mv	a0,s2
ffffffffc020979a:	6942                	ld	s2,16(sp)
ffffffffc020979c:	6145                	addi	sp,sp,48
ffffffffc020979e:	8082                	ret
ffffffffc02097a0:	02050993          	addi	s3,a0,32
ffffffffc02097a4:	854e                	mv	a0,s3
ffffffffc02097a6:	dbffa0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc02097aa:	681c                	ld	a5,16(s0)
ffffffffc02097ac:	ef81                	bnez	a5,ffffffffc02097c4 <sfs_fsync+0x5e>
ffffffffc02097ae:	854e                	mv	a0,s3
ffffffffc02097b0:	db1fa0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc02097b4:	70a2                	ld	ra,40(sp)
ffffffffc02097b6:	7402                	ld	s0,32(sp)
ffffffffc02097b8:	64e2                	ld	s1,24(sp)
ffffffffc02097ba:	69a2                	ld	s3,8(sp)
ffffffffc02097bc:	854a                	mv	a0,s2
ffffffffc02097be:	6942                	ld	s2,16(sp)
ffffffffc02097c0:	6145                	addi	sp,sp,48
ffffffffc02097c2:	8082                	ret
ffffffffc02097c4:	4414                	lw	a3,8(s0)
ffffffffc02097c6:	600c                	ld	a1,0(s0)
ffffffffc02097c8:	00043823          	sd	zero,16(s0)
ffffffffc02097cc:	4701                	li	a4,0
ffffffffc02097ce:	04000613          	li	a2,64
ffffffffc02097d2:	8526                	mv	a0,s1
ffffffffc02097d4:	68e010ef          	jal	ra,ffffffffc020ae62 <sfs_wbuf>
ffffffffc02097d8:	892a                	mv	s2,a0
ffffffffc02097da:	d971                	beqz	a0,ffffffffc02097ae <sfs_fsync+0x48>
ffffffffc02097dc:	4785                	li	a5,1
ffffffffc02097de:	e81c                	sd	a5,16(s0)
ffffffffc02097e0:	b7f9                	j	ffffffffc02097ae <sfs_fsync+0x48>
ffffffffc02097e2:	00005697          	auipc	a3,0x5
ffffffffc02097e6:	5ce68693          	addi	a3,a3,1486 # ffffffffc020edb0 <dev_node_ops+0x3e0>
ffffffffc02097ea:	00002617          	auipc	a2,0x2
ffffffffc02097ee:	25e60613          	addi	a2,a2,606 # ffffffffc020ba48 <commands+0x210>
ffffffffc02097f2:	33700593          	li	a1,823
ffffffffc02097f6:	00005517          	auipc	a0,0x5
ffffffffc02097fa:	79a50513          	addi	a0,a0,1946 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc02097fe:	ca1f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209802:	00005697          	auipc	a3,0x5
ffffffffc0209806:	75668693          	addi	a3,a3,1878 # ffffffffc020ef58 <dev_node_ops+0x588>
ffffffffc020980a:	00002617          	auipc	a2,0x2
ffffffffc020980e:	23e60613          	addi	a2,a2,574 # ffffffffc020ba48 <commands+0x210>
ffffffffc0209812:	33800593          	li	a1,824
ffffffffc0209816:	00005517          	auipc	a0,0x5
ffffffffc020981a:	77a50513          	addi	a0,a0,1914 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020981e:	c81f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209822 <sfs_fstat>:
ffffffffc0209822:	1101                	addi	sp,sp,-32
ffffffffc0209824:	e426                	sd	s1,8(sp)
ffffffffc0209826:	84ae                	mv	s1,a1
ffffffffc0209828:	e822                	sd	s0,16(sp)
ffffffffc020982a:	02000613          	li	a2,32
ffffffffc020982e:	842a                	mv	s0,a0
ffffffffc0209830:	4581                	li	a1,0
ffffffffc0209832:	8526                	mv	a0,s1
ffffffffc0209834:	ec06                	sd	ra,24(sp)
ffffffffc0209836:	531010ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc020983a:	c439                	beqz	s0,ffffffffc0209888 <sfs_fstat+0x66>
ffffffffc020983c:	783c                	ld	a5,112(s0)
ffffffffc020983e:	c7a9                	beqz	a5,ffffffffc0209888 <sfs_fstat+0x66>
ffffffffc0209840:	6bbc                	ld	a5,80(a5)
ffffffffc0209842:	c3b9                	beqz	a5,ffffffffc0209888 <sfs_fstat+0x66>
ffffffffc0209844:	00005597          	auipc	a1,0x5
ffffffffc0209848:	10458593          	addi	a1,a1,260 # ffffffffc020e948 <syscalls+0xdb0>
ffffffffc020984c:	8522                	mv	a0,s0
ffffffffc020984e:	8cefe0ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc0209852:	783c                	ld	a5,112(s0)
ffffffffc0209854:	85a6                	mv	a1,s1
ffffffffc0209856:	8522                	mv	a0,s0
ffffffffc0209858:	6bbc                	ld	a5,80(a5)
ffffffffc020985a:	9782                	jalr	a5
ffffffffc020985c:	e10d                	bnez	a0,ffffffffc020987e <sfs_fstat+0x5c>
ffffffffc020985e:	4c38                	lw	a4,88(s0)
ffffffffc0209860:	6785                	lui	a5,0x1
ffffffffc0209862:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209866:	04f71163          	bne	a4,a5,ffffffffc02098a8 <sfs_fstat+0x86>
ffffffffc020986a:	601c                	ld	a5,0(s0)
ffffffffc020986c:	0067d683          	lhu	a3,6(a5)
ffffffffc0209870:	0087e703          	lwu	a4,8(a5)
ffffffffc0209874:	0007e783          	lwu	a5,0(a5)
ffffffffc0209878:	e494                	sd	a3,8(s1)
ffffffffc020987a:	e898                	sd	a4,16(s1)
ffffffffc020987c:	ec9c                	sd	a5,24(s1)
ffffffffc020987e:	60e2                	ld	ra,24(sp)
ffffffffc0209880:	6442                	ld	s0,16(sp)
ffffffffc0209882:	64a2                	ld	s1,8(sp)
ffffffffc0209884:	6105                	addi	sp,sp,32
ffffffffc0209886:	8082                	ret
ffffffffc0209888:	00005697          	auipc	a3,0x5
ffffffffc020988c:	05868693          	addi	a3,a3,88 # ffffffffc020e8e0 <syscalls+0xd48>
ffffffffc0209890:	00002617          	auipc	a2,0x2
ffffffffc0209894:	1b860613          	addi	a2,a2,440 # ffffffffc020ba48 <commands+0x210>
ffffffffc0209898:	32800593          	li	a1,808
ffffffffc020989c:	00005517          	auipc	a0,0x5
ffffffffc02098a0:	6f450513          	addi	a0,a0,1780 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc02098a4:	bfbf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc02098a8:	00005697          	auipc	a3,0x5
ffffffffc02098ac:	6b068693          	addi	a3,a3,1712 # ffffffffc020ef58 <dev_node_ops+0x588>
ffffffffc02098b0:	00002617          	auipc	a2,0x2
ffffffffc02098b4:	19860613          	addi	a2,a2,408 # ffffffffc020ba48 <commands+0x210>
ffffffffc02098b8:	32b00593          	li	a1,811
ffffffffc02098bc:	00005517          	auipc	a0,0x5
ffffffffc02098c0:	6d450513          	addi	a0,a0,1748 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc02098c4:	bdbf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02098c8 <sfs_tryseek>:
ffffffffc02098c8:	080007b7          	lui	a5,0x8000
ffffffffc02098cc:	04f5fd63          	bgeu	a1,a5,ffffffffc0209926 <sfs_tryseek+0x5e>
ffffffffc02098d0:	1101                	addi	sp,sp,-32
ffffffffc02098d2:	e822                	sd	s0,16(sp)
ffffffffc02098d4:	ec06                	sd	ra,24(sp)
ffffffffc02098d6:	e426                	sd	s1,8(sp)
ffffffffc02098d8:	842a                	mv	s0,a0
ffffffffc02098da:	c921                	beqz	a0,ffffffffc020992a <sfs_tryseek+0x62>
ffffffffc02098dc:	4d38                	lw	a4,88(a0)
ffffffffc02098de:	6785                	lui	a5,0x1
ffffffffc02098e0:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc02098e4:	04f71363          	bne	a4,a5,ffffffffc020992a <sfs_tryseek+0x62>
ffffffffc02098e8:	611c                	ld	a5,0(a0)
ffffffffc02098ea:	84ae                	mv	s1,a1
ffffffffc02098ec:	0007e783          	lwu	a5,0(a5)
ffffffffc02098f0:	02b7d563          	bge	a5,a1,ffffffffc020991a <sfs_tryseek+0x52>
ffffffffc02098f4:	793c                	ld	a5,112(a0)
ffffffffc02098f6:	cbb1                	beqz	a5,ffffffffc020994a <sfs_tryseek+0x82>
ffffffffc02098f8:	73bc                	ld	a5,96(a5)
ffffffffc02098fa:	cba1                	beqz	a5,ffffffffc020994a <sfs_tryseek+0x82>
ffffffffc02098fc:	00005597          	auipc	a1,0x5
ffffffffc0209900:	f3c58593          	addi	a1,a1,-196 # ffffffffc020e838 <syscalls+0xca0>
ffffffffc0209904:	818fe0ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc0209908:	783c                	ld	a5,112(s0)
ffffffffc020990a:	8522                	mv	a0,s0
ffffffffc020990c:	6442                	ld	s0,16(sp)
ffffffffc020990e:	60e2                	ld	ra,24(sp)
ffffffffc0209910:	73bc                	ld	a5,96(a5)
ffffffffc0209912:	85a6                	mv	a1,s1
ffffffffc0209914:	64a2                	ld	s1,8(sp)
ffffffffc0209916:	6105                	addi	sp,sp,32
ffffffffc0209918:	8782                	jr	a5
ffffffffc020991a:	60e2                	ld	ra,24(sp)
ffffffffc020991c:	6442                	ld	s0,16(sp)
ffffffffc020991e:	64a2                	ld	s1,8(sp)
ffffffffc0209920:	4501                	li	a0,0
ffffffffc0209922:	6105                	addi	sp,sp,32
ffffffffc0209924:	8082                	ret
ffffffffc0209926:	5575                	li	a0,-3
ffffffffc0209928:	8082                	ret
ffffffffc020992a:	00005697          	auipc	a3,0x5
ffffffffc020992e:	62e68693          	addi	a3,a3,1582 # ffffffffc020ef58 <dev_node_ops+0x588>
ffffffffc0209932:	00002617          	auipc	a2,0x2
ffffffffc0209936:	11660613          	addi	a2,a2,278 # ffffffffc020ba48 <commands+0x210>
ffffffffc020993a:	40a00593          	li	a1,1034
ffffffffc020993e:	00005517          	auipc	a0,0x5
ffffffffc0209942:	65250513          	addi	a0,a0,1618 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209946:	b59f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020994a:	00005697          	auipc	a3,0x5
ffffffffc020994e:	e9668693          	addi	a3,a3,-362 # ffffffffc020e7e0 <syscalls+0xc48>
ffffffffc0209952:	00002617          	auipc	a2,0x2
ffffffffc0209956:	0f660613          	addi	a2,a2,246 # ffffffffc020ba48 <commands+0x210>
ffffffffc020995a:	40c00593          	li	a1,1036
ffffffffc020995e:	00005517          	auipc	a0,0x5
ffffffffc0209962:	63250513          	addi	a0,a0,1586 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209966:	b39f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020996a <sfs_close>:
ffffffffc020996a:	1141                	addi	sp,sp,-16
ffffffffc020996c:	e406                	sd	ra,8(sp)
ffffffffc020996e:	e022                	sd	s0,0(sp)
ffffffffc0209970:	c11d                	beqz	a0,ffffffffc0209996 <sfs_close+0x2c>
ffffffffc0209972:	793c                	ld	a5,112(a0)
ffffffffc0209974:	842a                	mv	s0,a0
ffffffffc0209976:	c385                	beqz	a5,ffffffffc0209996 <sfs_close+0x2c>
ffffffffc0209978:	7b9c                	ld	a5,48(a5)
ffffffffc020997a:	cf91                	beqz	a5,ffffffffc0209996 <sfs_close+0x2c>
ffffffffc020997c:	00004597          	auipc	a1,0x4
ffffffffc0209980:	a5458593          	addi	a1,a1,-1452 # ffffffffc020d3d0 <default_pmm_manager+0xea0>
ffffffffc0209984:	f99fd0ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc0209988:	783c                	ld	a5,112(s0)
ffffffffc020998a:	8522                	mv	a0,s0
ffffffffc020998c:	6402                	ld	s0,0(sp)
ffffffffc020998e:	60a2                	ld	ra,8(sp)
ffffffffc0209990:	7b9c                	ld	a5,48(a5)
ffffffffc0209992:	0141                	addi	sp,sp,16
ffffffffc0209994:	8782                	jr	a5
ffffffffc0209996:	00004697          	auipc	a3,0x4
ffffffffc020999a:	9ea68693          	addi	a3,a3,-1558 # ffffffffc020d380 <default_pmm_manager+0xe50>
ffffffffc020999e:	00002617          	auipc	a2,0x2
ffffffffc02099a2:	0aa60613          	addi	a2,a2,170 # ffffffffc020ba48 <commands+0x210>
ffffffffc02099a6:	21c00593          	li	a1,540
ffffffffc02099aa:	00005517          	auipc	a0,0x5
ffffffffc02099ae:	5e650513          	addi	a0,a0,1510 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc02099b2:	aedf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02099b6 <sfs_io.part.0>:
ffffffffc02099b6:	1141                	addi	sp,sp,-16
ffffffffc02099b8:	00005697          	auipc	a3,0x5
ffffffffc02099bc:	5a068693          	addi	a3,a3,1440 # ffffffffc020ef58 <dev_node_ops+0x588>
ffffffffc02099c0:	00002617          	auipc	a2,0x2
ffffffffc02099c4:	08860613          	addi	a2,a2,136 # ffffffffc020ba48 <commands+0x210>
ffffffffc02099c8:	30700593          	li	a1,775
ffffffffc02099cc:	00005517          	auipc	a0,0x5
ffffffffc02099d0:	5c450513          	addi	a0,a0,1476 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc02099d4:	e406                	sd	ra,8(sp)
ffffffffc02099d6:	ac9f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc02099da <sfs_block_free>:
ffffffffc02099da:	1101                	addi	sp,sp,-32
ffffffffc02099dc:	e426                	sd	s1,8(sp)
ffffffffc02099de:	ec06                	sd	ra,24(sp)
ffffffffc02099e0:	e822                	sd	s0,16(sp)
ffffffffc02099e2:	4154                	lw	a3,4(a0)
ffffffffc02099e4:	84ae                	mv	s1,a1
ffffffffc02099e6:	c595                	beqz	a1,ffffffffc0209a12 <sfs_block_free+0x38>
ffffffffc02099e8:	02d5f563          	bgeu	a1,a3,ffffffffc0209a12 <sfs_block_free+0x38>
ffffffffc02099ec:	842a                	mv	s0,a0
ffffffffc02099ee:	7d08                	ld	a0,56(a0)
ffffffffc02099f0:	edcff0ef          	jal	ra,ffffffffc02090cc <bitmap_test>
ffffffffc02099f4:	ed05                	bnez	a0,ffffffffc0209a2c <sfs_block_free+0x52>
ffffffffc02099f6:	7c08                	ld	a0,56(s0)
ffffffffc02099f8:	85a6                	mv	a1,s1
ffffffffc02099fa:	efaff0ef          	jal	ra,ffffffffc02090f4 <bitmap_free>
ffffffffc02099fe:	441c                	lw	a5,8(s0)
ffffffffc0209a00:	4705                	li	a4,1
ffffffffc0209a02:	60e2                	ld	ra,24(sp)
ffffffffc0209a04:	2785                	addiw	a5,a5,1
ffffffffc0209a06:	e038                	sd	a4,64(s0)
ffffffffc0209a08:	c41c                	sw	a5,8(s0)
ffffffffc0209a0a:	6442                	ld	s0,16(sp)
ffffffffc0209a0c:	64a2                	ld	s1,8(sp)
ffffffffc0209a0e:	6105                	addi	sp,sp,32
ffffffffc0209a10:	8082                	ret
ffffffffc0209a12:	8726                	mv	a4,s1
ffffffffc0209a14:	00005617          	auipc	a2,0x5
ffffffffc0209a18:	5ac60613          	addi	a2,a2,1452 # ffffffffc020efc0 <dev_node_ops+0x5f0>
ffffffffc0209a1c:	05300593          	li	a1,83
ffffffffc0209a20:	00005517          	auipc	a0,0x5
ffffffffc0209a24:	57050513          	addi	a0,a0,1392 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209a28:	a77f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209a2c:	00005697          	auipc	a3,0x5
ffffffffc0209a30:	5cc68693          	addi	a3,a3,1484 # ffffffffc020eff8 <dev_node_ops+0x628>
ffffffffc0209a34:	00002617          	auipc	a2,0x2
ffffffffc0209a38:	01460613          	addi	a2,a2,20 # ffffffffc020ba48 <commands+0x210>
ffffffffc0209a3c:	06a00593          	li	a1,106
ffffffffc0209a40:	00005517          	auipc	a0,0x5
ffffffffc0209a44:	55050513          	addi	a0,a0,1360 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209a48:	a57f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209a4c <sfs_reclaim>:
ffffffffc0209a4c:	1101                	addi	sp,sp,-32
ffffffffc0209a4e:	e426                	sd	s1,8(sp)
ffffffffc0209a50:	7524                	ld	s1,104(a0)
ffffffffc0209a52:	ec06                	sd	ra,24(sp)
ffffffffc0209a54:	e822                	sd	s0,16(sp)
ffffffffc0209a56:	e04a                	sd	s2,0(sp)
ffffffffc0209a58:	0e048a63          	beqz	s1,ffffffffc0209b4c <sfs_reclaim+0x100>
ffffffffc0209a5c:	0b04a783          	lw	a5,176(s1)
ffffffffc0209a60:	0e079663          	bnez	a5,ffffffffc0209b4c <sfs_reclaim+0x100>
ffffffffc0209a64:	4d38                	lw	a4,88(a0)
ffffffffc0209a66:	6785                	lui	a5,0x1
ffffffffc0209a68:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc0209a6c:	842a                	mv	s0,a0
ffffffffc0209a6e:	10f71f63          	bne	a4,a5,ffffffffc0209b8c <sfs_reclaim+0x140>
ffffffffc0209a72:	8526                	mv	a0,s1
ffffffffc0209a74:	59e010ef          	jal	ra,ffffffffc020b012 <lock_sfs_fs>
ffffffffc0209a78:	4c1c                	lw	a5,24(s0)
ffffffffc0209a7a:	0ef05963          	blez	a5,ffffffffc0209b6c <sfs_reclaim+0x120>
ffffffffc0209a7e:	fff7871b          	addiw	a4,a5,-1
ffffffffc0209a82:	cc18                	sw	a4,24(s0)
ffffffffc0209a84:	eb59                	bnez	a4,ffffffffc0209b1a <sfs_reclaim+0xce>
ffffffffc0209a86:	05c42903          	lw	s2,92(s0)
ffffffffc0209a8a:	08091863          	bnez	s2,ffffffffc0209b1a <sfs_reclaim+0xce>
ffffffffc0209a8e:	601c                	ld	a5,0(s0)
ffffffffc0209a90:	0067d783          	lhu	a5,6(a5)
ffffffffc0209a94:	e785                	bnez	a5,ffffffffc0209abc <sfs_reclaim+0x70>
ffffffffc0209a96:	783c                	ld	a5,112(s0)
ffffffffc0209a98:	10078a63          	beqz	a5,ffffffffc0209bac <sfs_reclaim+0x160>
ffffffffc0209a9c:	73bc                	ld	a5,96(a5)
ffffffffc0209a9e:	10078763          	beqz	a5,ffffffffc0209bac <sfs_reclaim+0x160>
ffffffffc0209aa2:	00005597          	auipc	a1,0x5
ffffffffc0209aa6:	d9658593          	addi	a1,a1,-618 # ffffffffc020e838 <syscalls+0xca0>
ffffffffc0209aaa:	8522                	mv	a0,s0
ffffffffc0209aac:	e71fd0ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc0209ab0:	783c                	ld	a5,112(s0)
ffffffffc0209ab2:	4581                	li	a1,0
ffffffffc0209ab4:	8522                	mv	a0,s0
ffffffffc0209ab6:	73bc                	ld	a5,96(a5)
ffffffffc0209ab8:	9782                	jalr	a5
ffffffffc0209aba:	e559                	bnez	a0,ffffffffc0209b48 <sfs_reclaim+0xfc>
ffffffffc0209abc:	681c                	ld	a5,16(s0)
ffffffffc0209abe:	c39d                	beqz	a5,ffffffffc0209ae4 <sfs_reclaim+0x98>
ffffffffc0209ac0:	783c                	ld	a5,112(s0)
ffffffffc0209ac2:	10078563          	beqz	a5,ffffffffc0209bcc <sfs_reclaim+0x180>
ffffffffc0209ac6:	7b9c                	ld	a5,48(a5)
ffffffffc0209ac8:	10078263          	beqz	a5,ffffffffc0209bcc <sfs_reclaim+0x180>
ffffffffc0209acc:	8522                	mv	a0,s0
ffffffffc0209ace:	00004597          	auipc	a1,0x4
ffffffffc0209ad2:	90258593          	addi	a1,a1,-1790 # ffffffffc020d3d0 <default_pmm_manager+0xea0>
ffffffffc0209ad6:	e47fd0ef          	jal	ra,ffffffffc020791c <inode_check>
ffffffffc0209ada:	783c                	ld	a5,112(s0)
ffffffffc0209adc:	8522                	mv	a0,s0
ffffffffc0209ade:	7b9c                	ld	a5,48(a5)
ffffffffc0209ae0:	9782                	jalr	a5
ffffffffc0209ae2:	e13d                	bnez	a0,ffffffffc0209b48 <sfs_reclaim+0xfc>
ffffffffc0209ae4:	7c18                	ld	a4,56(s0)
ffffffffc0209ae6:	603c                	ld	a5,64(s0)
ffffffffc0209ae8:	8526                	mv	a0,s1
ffffffffc0209aea:	e71c                	sd	a5,8(a4)
ffffffffc0209aec:	e398                	sd	a4,0(a5)
ffffffffc0209aee:	6438                	ld	a4,72(s0)
ffffffffc0209af0:	683c                	ld	a5,80(s0)
ffffffffc0209af2:	e71c                	sd	a5,8(a4)
ffffffffc0209af4:	e398                	sd	a4,0(a5)
ffffffffc0209af6:	52c010ef          	jal	ra,ffffffffc020b022 <unlock_sfs_fs>
ffffffffc0209afa:	6008                	ld	a0,0(s0)
ffffffffc0209afc:	00655783          	lhu	a5,6(a0)
ffffffffc0209b00:	cb85                	beqz	a5,ffffffffc0209b30 <sfs_reclaim+0xe4>
ffffffffc0209b02:	d3cf80ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc0209b06:	8522                	mv	a0,s0
ffffffffc0209b08:	da9fd0ef          	jal	ra,ffffffffc02078b0 <inode_kill>
ffffffffc0209b0c:	60e2                	ld	ra,24(sp)
ffffffffc0209b0e:	6442                	ld	s0,16(sp)
ffffffffc0209b10:	64a2                	ld	s1,8(sp)
ffffffffc0209b12:	854a                	mv	a0,s2
ffffffffc0209b14:	6902                	ld	s2,0(sp)
ffffffffc0209b16:	6105                	addi	sp,sp,32
ffffffffc0209b18:	8082                	ret
ffffffffc0209b1a:	5945                	li	s2,-15
ffffffffc0209b1c:	8526                	mv	a0,s1
ffffffffc0209b1e:	504010ef          	jal	ra,ffffffffc020b022 <unlock_sfs_fs>
ffffffffc0209b22:	60e2                	ld	ra,24(sp)
ffffffffc0209b24:	6442                	ld	s0,16(sp)
ffffffffc0209b26:	64a2                	ld	s1,8(sp)
ffffffffc0209b28:	854a                	mv	a0,s2
ffffffffc0209b2a:	6902                	ld	s2,0(sp)
ffffffffc0209b2c:	6105                	addi	sp,sp,32
ffffffffc0209b2e:	8082                	ret
ffffffffc0209b30:	440c                	lw	a1,8(s0)
ffffffffc0209b32:	8526                	mv	a0,s1
ffffffffc0209b34:	ea7ff0ef          	jal	ra,ffffffffc02099da <sfs_block_free>
ffffffffc0209b38:	6008                	ld	a0,0(s0)
ffffffffc0209b3a:	5d4c                	lw	a1,60(a0)
ffffffffc0209b3c:	d1f9                	beqz	a1,ffffffffc0209b02 <sfs_reclaim+0xb6>
ffffffffc0209b3e:	8526                	mv	a0,s1
ffffffffc0209b40:	e9bff0ef          	jal	ra,ffffffffc02099da <sfs_block_free>
ffffffffc0209b44:	6008                	ld	a0,0(s0)
ffffffffc0209b46:	bf75                	j	ffffffffc0209b02 <sfs_reclaim+0xb6>
ffffffffc0209b48:	892a                	mv	s2,a0
ffffffffc0209b4a:	bfc9                	j	ffffffffc0209b1c <sfs_reclaim+0xd0>
ffffffffc0209b4c:	00005697          	auipc	a3,0x5
ffffffffc0209b50:	26468693          	addi	a3,a3,612 # ffffffffc020edb0 <dev_node_ops+0x3e0>
ffffffffc0209b54:	00002617          	auipc	a2,0x2
ffffffffc0209b58:	ef460613          	addi	a2,a2,-268 # ffffffffc020ba48 <commands+0x210>
ffffffffc0209b5c:	3c800593          	li	a1,968
ffffffffc0209b60:	00005517          	auipc	a0,0x5
ffffffffc0209b64:	43050513          	addi	a0,a0,1072 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209b68:	937f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209b6c:	00005697          	auipc	a3,0x5
ffffffffc0209b70:	4ac68693          	addi	a3,a3,1196 # ffffffffc020f018 <dev_node_ops+0x648>
ffffffffc0209b74:	00002617          	auipc	a2,0x2
ffffffffc0209b78:	ed460613          	addi	a2,a2,-300 # ffffffffc020ba48 <commands+0x210>
ffffffffc0209b7c:	3ce00593          	li	a1,974
ffffffffc0209b80:	00005517          	auipc	a0,0x5
ffffffffc0209b84:	41050513          	addi	a0,a0,1040 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209b88:	917f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209b8c:	00005697          	auipc	a3,0x5
ffffffffc0209b90:	3cc68693          	addi	a3,a3,972 # ffffffffc020ef58 <dev_node_ops+0x588>
ffffffffc0209b94:	00002617          	auipc	a2,0x2
ffffffffc0209b98:	eb460613          	addi	a2,a2,-332 # ffffffffc020ba48 <commands+0x210>
ffffffffc0209b9c:	3c900593          	li	a1,969
ffffffffc0209ba0:	00005517          	auipc	a0,0x5
ffffffffc0209ba4:	3f050513          	addi	a0,a0,1008 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209ba8:	8f7f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209bac:	00005697          	auipc	a3,0x5
ffffffffc0209bb0:	c3468693          	addi	a3,a3,-972 # ffffffffc020e7e0 <syscalls+0xc48>
ffffffffc0209bb4:	00002617          	auipc	a2,0x2
ffffffffc0209bb8:	e9460613          	addi	a2,a2,-364 # ffffffffc020ba48 <commands+0x210>
ffffffffc0209bbc:	3d300593          	li	a1,979
ffffffffc0209bc0:	00005517          	auipc	a0,0x5
ffffffffc0209bc4:	3d050513          	addi	a0,a0,976 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209bc8:	8d7f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209bcc:	00003697          	auipc	a3,0x3
ffffffffc0209bd0:	7b468693          	addi	a3,a3,1972 # ffffffffc020d380 <default_pmm_manager+0xe50>
ffffffffc0209bd4:	00002617          	auipc	a2,0x2
ffffffffc0209bd8:	e7460613          	addi	a2,a2,-396 # ffffffffc020ba48 <commands+0x210>
ffffffffc0209bdc:	3d800593          	li	a1,984
ffffffffc0209be0:	00005517          	auipc	a0,0x5
ffffffffc0209be4:	3b050513          	addi	a0,a0,944 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209be8:	8b7f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209bec <sfs_block_alloc>:
ffffffffc0209bec:	1101                	addi	sp,sp,-32
ffffffffc0209bee:	e822                	sd	s0,16(sp)
ffffffffc0209bf0:	842a                	mv	s0,a0
ffffffffc0209bf2:	7d08                	ld	a0,56(a0)
ffffffffc0209bf4:	e426                	sd	s1,8(sp)
ffffffffc0209bf6:	ec06                	sd	ra,24(sp)
ffffffffc0209bf8:	84ae                	mv	s1,a1
ffffffffc0209bfa:	c62ff0ef          	jal	ra,ffffffffc020905c <bitmap_alloc>
ffffffffc0209bfe:	e90d                	bnez	a0,ffffffffc0209c30 <sfs_block_alloc+0x44>
ffffffffc0209c00:	441c                	lw	a5,8(s0)
ffffffffc0209c02:	cbad                	beqz	a5,ffffffffc0209c74 <sfs_block_alloc+0x88>
ffffffffc0209c04:	37fd                	addiw	a5,a5,-1
ffffffffc0209c06:	c41c                	sw	a5,8(s0)
ffffffffc0209c08:	408c                	lw	a1,0(s1)
ffffffffc0209c0a:	4785                	li	a5,1
ffffffffc0209c0c:	e03c                	sd	a5,64(s0)
ffffffffc0209c0e:	4054                	lw	a3,4(s0)
ffffffffc0209c10:	c58d                	beqz	a1,ffffffffc0209c3a <sfs_block_alloc+0x4e>
ffffffffc0209c12:	02d5f463          	bgeu	a1,a3,ffffffffc0209c3a <sfs_block_alloc+0x4e>
ffffffffc0209c16:	7c08                	ld	a0,56(s0)
ffffffffc0209c18:	cb4ff0ef          	jal	ra,ffffffffc02090cc <bitmap_test>
ffffffffc0209c1c:	ed05                	bnez	a0,ffffffffc0209c54 <sfs_block_alloc+0x68>
ffffffffc0209c1e:	8522                	mv	a0,s0
ffffffffc0209c20:	6442                	ld	s0,16(sp)
ffffffffc0209c22:	408c                	lw	a1,0(s1)
ffffffffc0209c24:	60e2                	ld	ra,24(sp)
ffffffffc0209c26:	64a2                	ld	s1,8(sp)
ffffffffc0209c28:	4605                	li	a2,1
ffffffffc0209c2a:	6105                	addi	sp,sp,32
ffffffffc0209c2c:	3860106f          	j	ffffffffc020afb2 <sfs_clear_block>
ffffffffc0209c30:	60e2                	ld	ra,24(sp)
ffffffffc0209c32:	6442                	ld	s0,16(sp)
ffffffffc0209c34:	64a2                	ld	s1,8(sp)
ffffffffc0209c36:	6105                	addi	sp,sp,32
ffffffffc0209c38:	8082                	ret
ffffffffc0209c3a:	872e                	mv	a4,a1
ffffffffc0209c3c:	00005617          	auipc	a2,0x5
ffffffffc0209c40:	38460613          	addi	a2,a2,900 # ffffffffc020efc0 <dev_node_ops+0x5f0>
ffffffffc0209c44:	05300593          	li	a1,83
ffffffffc0209c48:	00005517          	auipc	a0,0x5
ffffffffc0209c4c:	34850513          	addi	a0,a0,840 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209c50:	84ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209c54:	00005697          	auipc	a3,0x5
ffffffffc0209c58:	3fc68693          	addi	a3,a3,1020 # ffffffffc020f050 <dev_node_ops+0x680>
ffffffffc0209c5c:	00002617          	auipc	a2,0x2
ffffffffc0209c60:	dec60613          	addi	a2,a2,-532 # ffffffffc020ba48 <commands+0x210>
ffffffffc0209c64:	06100593          	li	a1,97
ffffffffc0209c68:	00005517          	auipc	a0,0x5
ffffffffc0209c6c:	32850513          	addi	a0,a0,808 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209c70:	82ff60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209c74:	00005697          	auipc	a3,0x5
ffffffffc0209c78:	3bc68693          	addi	a3,a3,956 # ffffffffc020f030 <dev_node_ops+0x660>
ffffffffc0209c7c:	00002617          	auipc	a2,0x2
ffffffffc0209c80:	dcc60613          	addi	a2,a2,-564 # ffffffffc020ba48 <commands+0x210>
ffffffffc0209c84:	05f00593          	li	a1,95
ffffffffc0209c88:	00005517          	auipc	a0,0x5
ffffffffc0209c8c:	30850513          	addi	a0,a0,776 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209c90:	80ff60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209c94 <sfs_bmap_load_nolock>:
ffffffffc0209c94:	7159                	addi	sp,sp,-112
ffffffffc0209c96:	f85a                	sd	s6,48(sp)
ffffffffc0209c98:	0005bb03          	ld	s6,0(a1)
ffffffffc0209c9c:	f45e                	sd	s7,40(sp)
ffffffffc0209c9e:	f486                	sd	ra,104(sp)
ffffffffc0209ca0:	008b2b83          	lw	s7,8(s6)
ffffffffc0209ca4:	f0a2                	sd	s0,96(sp)
ffffffffc0209ca6:	eca6                	sd	s1,88(sp)
ffffffffc0209ca8:	e8ca                	sd	s2,80(sp)
ffffffffc0209caa:	e4ce                	sd	s3,72(sp)
ffffffffc0209cac:	e0d2                	sd	s4,64(sp)
ffffffffc0209cae:	fc56                	sd	s5,56(sp)
ffffffffc0209cb0:	f062                	sd	s8,32(sp)
ffffffffc0209cb2:	ec66                	sd	s9,24(sp)
ffffffffc0209cb4:	18cbe363          	bltu	s7,a2,ffffffffc0209e3a <sfs_bmap_load_nolock+0x1a6>
ffffffffc0209cb8:	47ad                	li	a5,11
ffffffffc0209cba:	8aae                	mv	s5,a1
ffffffffc0209cbc:	8432                	mv	s0,a2
ffffffffc0209cbe:	84aa                	mv	s1,a0
ffffffffc0209cc0:	89b6                	mv	s3,a3
ffffffffc0209cc2:	04c7f563          	bgeu	a5,a2,ffffffffc0209d0c <sfs_bmap_load_nolock+0x78>
ffffffffc0209cc6:	ff46071b          	addiw	a4,a2,-12
ffffffffc0209cca:	0007069b          	sext.w	a3,a4
ffffffffc0209cce:	3ff00793          	li	a5,1023
ffffffffc0209cd2:	1ad7e163          	bltu	a5,a3,ffffffffc0209e74 <sfs_bmap_load_nolock+0x1e0>
ffffffffc0209cd6:	03cb2a03          	lw	s4,60(s6)
ffffffffc0209cda:	02071793          	slli	a5,a4,0x20
ffffffffc0209cde:	c602                	sw	zero,12(sp)
ffffffffc0209ce0:	c452                	sw	s4,8(sp)
ffffffffc0209ce2:	01e7dc13          	srli	s8,a5,0x1e
ffffffffc0209ce6:	0e0a1e63          	bnez	s4,ffffffffc0209de2 <sfs_bmap_load_nolock+0x14e>
ffffffffc0209cea:	0acb8663          	beq	s7,a2,ffffffffc0209d96 <sfs_bmap_load_nolock+0x102>
ffffffffc0209cee:	4a01                	li	s4,0
ffffffffc0209cf0:	40d4                	lw	a3,4(s1)
ffffffffc0209cf2:	8752                	mv	a4,s4
ffffffffc0209cf4:	00005617          	auipc	a2,0x5
ffffffffc0209cf8:	2cc60613          	addi	a2,a2,716 # ffffffffc020efc0 <dev_node_ops+0x5f0>
ffffffffc0209cfc:	05300593          	li	a1,83
ffffffffc0209d00:	00005517          	auipc	a0,0x5
ffffffffc0209d04:	29050513          	addi	a0,a0,656 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209d08:	f96f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209d0c:	02061793          	slli	a5,a2,0x20
ffffffffc0209d10:	01e7da13          	srli	s4,a5,0x1e
ffffffffc0209d14:	9a5a                	add	s4,s4,s6
ffffffffc0209d16:	00ca2583          	lw	a1,12(s4)
ffffffffc0209d1a:	c22e                	sw	a1,4(sp)
ffffffffc0209d1c:	ed99                	bnez	a1,ffffffffc0209d3a <sfs_bmap_load_nolock+0xa6>
ffffffffc0209d1e:	fccb98e3          	bne	s7,a2,ffffffffc0209cee <sfs_bmap_load_nolock+0x5a>
ffffffffc0209d22:	004c                	addi	a1,sp,4
ffffffffc0209d24:	ec9ff0ef          	jal	ra,ffffffffc0209bec <sfs_block_alloc>
ffffffffc0209d28:	892a                	mv	s2,a0
ffffffffc0209d2a:	e921                	bnez	a0,ffffffffc0209d7a <sfs_bmap_load_nolock+0xe6>
ffffffffc0209d2c:	4592                	lw	a1,4(sp)
ffffffffc0209d2e:	4705                	li	a4,1
ffffffffc0209d30:	00ba2623          	sw	a1,12(s4)
ffffffffc0209d34:	00eab823          	sd	a4,16(s5)
ffffffffc0209d38:	d9dd                	beqz	a1,ffffffffc0209cee <sfs_bmap_load_nolock+0x5a>
ffffffffc0209d3a:	40d4                	lw	a3,4(s1)
ffffffffc0209d3c:	10d5ff63          	bgeu	a1,a3,ffffffffc0209e5a <sfs_bmap_load_nolock+0x1c6>
ffffffffc0209d40:	7c88                	ld	a0,56(s1)
ffffffffc0209d42:	b8aff0ef          	jal	ra,ffffffffc02090cc <bitmap_test>
ffffffffc0209d46:	18051363          	bnez	a0,ffffffffc0209ecc <sfs_bmap_load_nolock+0x238>
ffffffffc0209d4a:	4a12                	lw	s4,4(sp)
ffffffffc0209d4c:	fa0a02e3          	beqz	s4,ffffffffc0209cf0 <sfs_bmap_load_nolock+0x5c>
ffffffffc0209d50:	40dc                	lw	a5,4(s1)
ffffffffc0209d52:	f8fa7fe3          	bgeu	s4,a5,ffffffffc0209cf0 <sfs_bmap_load_nolock+0x5c>
ffffffffc0209d56:	7c88                	ld	a0,56(s1)
ffffffffc0209d58:	85d2                	mv	a1,s4
ffffffffc0209d5a:	b72ff0ef          	jal	ra,ffffffffc02090cc <bitmap_test>
ffffffffc0209d5e:	12051763          	bnez	a0,ffffffffc0209e8c <sfs_bmap_load_nolock+0x1f8>
ffffffffc0209d62:	008b9763          	bne	s7,s0,ffffffffc0209d70 <sfs_bmap_load_nolock+0xdc>
ffffffffc0209d66:	008b2783          	lw	a5,8(s6)
ffffffffc0209d6a:	2785                	addiw	a5,a5,1
ffffffffc0209d6c:	00fb2423          	sw	a5,8(s6)
ffffffffc0209d70:	4901                	li	s2,0
ffffffffc0209d72:	00098463          	beqz	s3,ffffffffc0209d7a <sfs_bmap_load_nolock+0xe6>
ffffffffc0209d76:	0149a023          	sw	s4,0(s3)
ffffffffc0209d7a:	70a6                	ld	ra,104(sp)
ffffffffc0209d7c:	7406                	ld	s0,96(sp)
ffffffffc0209d7e:	64e6                	ld	s1,88(sp)
ffffffffc0209d80:	69a6                	ld	s3,72(sp)
ffffffffc0209d82:	6a06                	ld	s4,64(sp)
ffffffffc0209d84:	7ae2                	ld	s5,56(sp)
ffffffffc0209d86:	7b42                	ld	s6,48(sp)
ffffffffc0209d88:	7ba2                	ld	s7,40(sp)
ffffffffc0209d8a:	7c02                	ld	s8,32(sp)
ffffffffc0209d8c:	6ce2                	ld	s9,24(sp)
ffffffffc0209d8e:	854a                	mv	a0,s2
ffffffffc0209d90:	6946                	ld	s2,80(sp)
ffffffffc0209d92:	6165                	addi	sp,sp,112
ffffffffc0209d94:	8082                	ret
ffffffffc0209d96:	002c                	addi	a1,sp,8
ffffffffc0209d98:	e55ff0ef          	jal	ra,ffffffffc0209bec <sfs_block_alloc>
ffffffffc0209d9c:	892a                	mv	s2,a0
ffffffffc0209d9e:	00c10c93          	addi	s9,sp,12
ffffffffc0209da2:	fd61                	bnez	a0,ffffffffc0209d7a <sfs_bmap_load_nolock+0xe6>
ffffffffc0209da4:	85e6                	mv	a1,s9
ffffffffc0209da6:	8526                	mv	a0,s1
ffffffffc0209da8:	e45ff0ef          	jal	ra,ffffffffc0209bec <sfs_block_alloc>
ffffffffc0209dac:	892a                	mv	s2,a0
ffffffffc0209dae:	e925                	bnez	a0,ffffffffc0209e1e <sfs_bmap_load_nolock+0x18a>
ffffffffc0209db0:	46a2                	lw	a3,8(sp)
ffffffffc0209db2:	85e6                	mv	a1,s9
ffffffffc0209db4:	8762                	mv	a4,s8
ffffffffc0209db6:	4611                	li	a2,4
ffffffffc0209db8:	8526                	mv	a0,s1
ffffffffc0209dba:	0a8010ef          	jal	ra,ffffffffc020ae62 <sfs_wbuf>
ffffffffc0209dbe:	45b2                	lw	a1,12(sp)
ffffffffc0209dc0:	892a                	mv	s2,a0
ffffffffc0209dc2:	e939                	bnez	a0,ffffffffc0209e18 <sfs_bmap_load_nolock+0x184>
ffffffffc0209dc4:	03cb2683          	lw	a3,60(s6)
ffffffffc0209dc8:	4722                	lw	a4,8(sp)
ffffffffc0209dca:	c22e                	sw	a1,4(sp)
ffffffffc0209dcc:	f6d706e3          	beq	a4,a3,ffffffffc0209d38 <sfs_bmap_load_nolock+0xa4>
ffffffffc0209dd0:	eef1                	bnez	a3,ffffffffc0209eac <sfs_bmap_load_nolock+0x218>
ffffffffc0209dd2:	02eb2e23          	sw	a4,60(s6)
ffffffffc0209dd6:	4705                	li	a4,1
ffffffffc0209dd8:	00eab823          	sd	a4,16(s5)
ffffffffc0209ddc:	f00589e3          	beqz	a1,ffffffffc0209cee <sfs_bmap_load_nolock+0x5a>
ffffffffc0209de0:	bfa9                	j	ffffffffc0209d3a <sfs_bmap_load_nolock+0xa6>
ffffffffc0209de2:	00c10c93          	addi	s9,sp,12
ffffffffc0209de6:	8762                	mv	a4,s8
ffffffffc0209de8:	86d2                	mv	a3,s4
ffffffffc0209dea:	4611                	li	a2,4
ffffffffc0209dec:	85e6                	mv	a1,s9
ffffffffc0209dee:	7f5000ef          	jal	ra,ffffffffc020ade2 <sfs_rbuf>
ffffffffc0209df2:	892a                	mv	s2,a0
ffffffffc0209df4:	f159                	bnez	a0,ffffffffc0209d7a <sfs_bmap_load_nolock+0xe6>
ffffffffc0209df6:	45b2                	lw	a1,12(sp)
ffffffffc0209df8:	e995                	bnez	a1,ffffffffc0209e2c <sfs_bmap_load_nolock+0x198>
ffffffffc0209dfa:	fa8b85e3          	beq	s7,s0,ffffffffc0209da4 <sfs_bmap_load_nolock+0x110>
ffffffffc0209dfe:	03cb2703          	lw	a4,60(s6)
ffffffffc0209e02:	47a2                	lw	a5,8(sp)
ffffffffc0209e04:	c202                	sw	zero,4(sp)
ffffffffc0209e06:	eee784e3          	beq	a5,a4,ffffffffc0209cee <sfs_bmap_load_nolock+0x5a>
ffffffffc0209e0a:	e34d                	bnez	a4,ffffffffc0209eac <sfs_bmap_load_nolock+0x218>
ffffffffc0209e0c:	02fb2e23          	sw	a5,60(s6)
ffffffffc0209e10:	4785                	li	a5,1
ffffffffc0209e12:	00fab823          	sd	a5,16(s5)
ffffffffc0209e16:	bde1                	j	ffffffffc0209cee <sfs_bmap_load_nolock+0x5a>
ffffffffc0209e18:	8526                	mv	a0,s1
ffffffffc0209e1a:	bc1ff0ef          	jal	ra,ffffffffc02099da <sfs_block_free>
ffffffffc0209e1e:	45a2                	lw	a1,8(sp)
ffffffffc0209e20:	f4ba0de3          	beq	s4,a1,ffffffffc0209d7a <sfs_bmap_load_nolock+0xe6>
ffffffffc0209e24:	8526                	mv	a0,s1
ffffffffc0209e26:	bb5ff0ef          	jal	ra,ffffffffc02099da <sfs_block_free>
ffffffffc0209e2a:	bf81                	j	ffffffffc0209d7a <sfs_bmap_load_nolock+0xe6>
ffffffffc0209e2c:	03cb2683          	lw	a3,60(s6)
ffffffffc0209e30:	4722                	lw	a4,8(sp)
ffffffffc0209e32:	c22e                	sw	a1,4(sp)
ffffffffc0209e34:	f8e69ee3          	bne	a3,a4,ffffffffc0209dd0 <sfs_bmap_load_nolock+0x13c>
ffffffffc0209e38:	b709                	j	ffffffffc0209d3a <sfs_bmap_load_nolock+0xa6>
ffffffffc0209e3a:	00005697          	auipc	a3,0x5
ffffffffc0209e3e:	23e68693          	addi	a3,a3,574 # ffffffffc020f078 <dev_node_ops+0x6a8>
ffffffffc0209e42:	00002617          	auipc	a2,0x2
ffffffffc0209e46:	c0660613          	addi	a2,a2,-1018 # ffffffffc020ba48 <commands+0x210>
ffffffffc0209e4a:	16400593          	li	a1,356
ffffffffc0209e4e:	00005517          	auipc	a0,0x5
ffffffffc0209e52:	14250513          	addi	a0,a0,322 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209e56:	e48f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209e5a:	872e                	mv	a4,a1
ffffffffc0209e5c:	00005617          	auipc	a2,0x5
ffffffffc0209e60:	16460613          	addi	a2,a2,356 # ffffffffc020efc0 <dev_node_ops+0x5f0>
ffffffffc0209e64:	05300593          	li	a1,83
ffffffffc0209e68:	00005517          	auipc	a0,0x5
ffffffffc0209e6c:	12850513          	addi	a0,a0,296 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209e70:	e2ef60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209e74:	00005617          	auipc	a2,0x5
ffffffffc0209e78:	23460613          	addi	a2,a2,564 # ffffffffc020f0a8 <dev_node_ops+0x6d8>
ffffffffc0209e7c:	11e00593          	li	a1,286
ffffffffc0209e80:	00005517          	auipc	a0,0x5
ffffffffc0209e84:	11050513          	addi	a0,a0,272 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209e88:	e16f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209e8c:	00005697          	auipc	a3,0x5
ffffffffc0209e90:	16c68693          	addi	a3,a3,364 # ffffffffc020eff8 <dev_node_ops+0x628>
ffffffffc0209e94:	00002617          	auipc	a2,0x2
ffffffffc0209e98:	bb460613          	addi	a2,a2,-1100 # ffffffffc020ba48 <commands+0x210>
ffffffffc0209e9c:	16b00593          	li	a1,363
ffffffffc0209ea0:	00005517          	auipc	a0,0x5
ffffffffc0209ea4:	0f050513          	addi	a0,a0,240 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209ea8:	df6f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209eac:	00005697          	auipc	a3,0x5
ffffffffc0209eb0:	1e468693          	addi	a3,a3,484 # ffffffffc020f090 <dev_node_ops+0x6c0>
ffffffffc0209eb4:	00002617          	auipc	a2,0x2
ffffffffc0209eb8:	b9460613          	addi	a2,a2,-1132 # ffffffffc020ba48 <commands+0x210>
ffffffffc0209ebc:	11800593          	li	a1,280
ffffffffc0209ec0:	00005517          	auipc	a0,0x5
ffffffffc0209ec4:	0d050513          	addi	a0,a0,208 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209ec8:	dd6f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc0209ecc:	00005697          	auipc	a3,0x5
ffffffffc0209ed0:	20c68693          	addi	a3,a3,524 # ffffffffc020f0d8 <dev_node_ops+0x708>
ffffffffc0209ed4:	00002617          	auipc	a2,0x2
ffffffffc0209ed8:	b7460613          	addi	a2,a2,-1164 # ffffffffc020ba48 <commands+0x210>
ffffffffc0209edc:	12100593          	li	a1,289
ffffffffc0209ee0:	00005517          	auipc	a0,0x5
ffffffffc0209ee4:	0b050513          	addi	a0,a0,176 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc0209ee8:	db6f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc0209eec <sfs_io_nolock>:
ffffffffc0209eec:	7175                	addi	sp,sp,-144
ffffffffc0209eee:	ecd6                	sd	s5,88(sp)
ffffffffc0209ef0:	8aae                	mv	s5,a1
ffffffffc0209ef2:	618c                	ld	a1,0(a1)
ffffffffc0209ef4:	e506                	sd	ra,136(sp)
ffffffffc0209ef6:	e122                	sd	s0,128(sp)
ffffffffc0209ef8:	0045d883          	lhu	a7,4(a1)
ffffffffc0209efc:	fca6                	sd	s1,120(sp)
ffffffffc0209efe:	f8ca                	sd	s2,112(sp)
ffffffffc0209f00:	f4ce                	sd	s3,104(sp)
ffffffffc0209f02:	f0d2                	sd	s4,96(sp)
ffffffffc0209f04:	e8da                	sd	s6,80(sp)
ffffffffc0209f06:	e4de                	sd	s7,72(sp)
ffffffffc0209f08:	e0e2                	sd	s8,64(sp)
ffffffffc0209f0a:	fc66                	sd	s9,56(sp)
ffffffffc0209f0c:	f86a                	sd	s10,48(sp)
ffffffffc0209f0e:	f46e                	sd	s11,40(sp)
ffffffffc0209f10:	4809                	li	a6,2
ffffffffc0209f12:	1b088363          	beq	a7,a6,ffffffffc020a0b8 <sfs_io_nolock+0x1cc>
ffffffffc0209f16:	00073b03          	ld	s6,0(a4) # 4000 <_binary_bin_swap_img_size-0x3d00>
ffffffffc0209f1a:	8c3a                	mv	s8,a4
ffffffffc0209f1c:	000c3023          	sd	zero,0(s8)
ffffffffc0209f20:	08000737          	lui	a4,0x8000
ffffffffc0209f24:	8db6                	mv	s11,a3
ffffffffc0209f26:	8d36                	mv	s10,a3
ffffffffc0209f28:	9b36                	add	s6,s6,a3
ffffffffc0209f2a:	18e6f563          	bgeu	a3,a4,ffffffffc020a0b4 <sfs_io_nolock+0x1c8>
ffffffffc0209f2e:	18db4363          	blt	s6,a3,ffffffffc020a0b4 <sfs_io_nolock+0x1c8>
ffffffffc0209f32:	8a2a                	mv	s4,a0
ffffffffc0209f34:	4501                	li	a0,0
ffffffffc0209f36:	0d668963          	beq	a3,s6,ffffffffc020a008 <sfs_io_nolock+0x11c>
ffffffffc0209f3a:	8932                	mv	s2,a2
ffffffffc0209f3c:	01677463          	bgeu	a4,s6,ffffffffc0209f44 <sfs_io_nolock+0x58>
ffffffffc0209f40:	08000b37          	lui	s6,0x8000
ffffffffc0209f44:	c3ed                	beqz	a5,ffffffffc020a026 <sfs_io_nolock+0x13a>
ffffffffc0209f46:	00001797          	auipc	a5,0x1
ffffffffc0209f4a:	f1c78793          	addi	a5,a5,-228 # ffffffffc020ae62 <sfs_wbuf>
ffffffffc0209f4e:	00001c97          	auipc	s9,0x1
ffffffffc0209f52:	e34c8c93          	addi	s9,s9,-460 # ffffffffc020ad82 <sfs_wblock>
ffffffffc0209f56:	e43e                	sd	a5,8(sp)
ffffffffc0209f58:	6785                	lui	a5,0x1
ffffffffc0209f5a:	fff78993          	addi	s3,a5,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0209f5e:	40cdd413          	srai	s0,s11,0xc
ffffffffc0209f62:	013df9b3          	and	s3,s11,s3
ffffffffc0209f66:	2401                	sext.w	s0,s0
ffffffffc0209f68:	84ce                	mv	s1,s3
ffffffffc0209f6a:	02098b63          	beqz	s3,ffffffffc0209fa0 <sfs_io_nolock+0xb4>
ffffffffc0209f6e:	40cb5713          	srai	a4,s6,0xc
ffffffffc0209f72:	2701                	sext.w	a4,a4
ffffffffc0209f74:	41bb04b3          	sub	s1,s6,s11
ffffffffc0209f78:	0c871863          	bne	a4,s0,ffffffffc020a048 <sfs_io_nolock+0x15c>
ffffffffc0209f7c:	0874                	addi	a3,sp,28
ffffffffc0209f7e:	8622                	mv	a2,s0
ffffffffc0209f80:	85d6                	mv	a1,s5
ffffffffc0209f82:	8552                	mv	a0,s4
ffffffffc0209f84:	d11ff0ef          	jal	ra,ffffffffc0209c94 <sfs_bmap_load_nolock>
ffffffffc0209f88:	e969                	bnez	a0,ffffffffc020a05a <sfs_io_nolock+0x16e>
ffffffffc0209f8a:	46f2                	lw	a3,28(sp)
ffffffffc0209f8c:	67a2                	ld	a5,8(sp)
ffffffffc0209f8e:	874e                	mv	a4,s3
ffffffffc0209f90:	8626                	mv	a2,s1
ffffffffc0209f92:	85ca                	mv	a1,s2
ffffffffc0209f94:	8552                	mv	a0,s4
ffffffffc0209f96:	9782                	jalr	a5
ffffffffc0209f98:	e169                	bnez	a0,ffffffffc020a05a <sfs_io_nolock+0x16e>
ffffffffc0209f9a:	9926                	add	s2,s2,s1
ffffffffc0209f9c:	9da6                	add	s11,s11,s1
ffffffffc0209f9e:	2405                	addiw	s0,s0,1
ffffffffc0209fa0:	6785                	lui	a5,0x1
ffffffffc0209fa2:	fff78713          	addi	a4,a5,-1 # fff <_binary_bin_swap_img_size-0x6d01>
ffffffffc0209fa6:	976e                	add	a4,a4,s11
ffffffffc0209fa8:	0d675663          	bge	a4,s6,ffffffffc020a074 <sfs_io_nolock+0x188>
ffffffffc0209fac:	40fb0bb3          	sub	s7,s6,a5
ffffffffc0209fb0:	41bb8bb3          	sub	s7,s7,s11
ffffffffc0209fb4:	00cbdb93          	srli	s7,s7,0xc
ffffffffc0209fb8:	0bb2                	slli	s7,s7,0xc
ffffffffc0209fba:	97a6                	add	a5,a5,s1
ffffffffc0209fbc:	9bbe                	add	s7,s7,a5
ffffffffc0209fbe:	6985                	lui	s3,0x1
ffffffffc0209fc0:	a829                	j	ffffffffc0209fda <sfs_io_nolock+0xee>
ffffffffc0209fc2:	4672                	lw	a2,28(sp)
ffffffffc0209fc4:	4685                	li	a3,1
ffffffffc0209fc6:	85ca                	mv	a1,s2
ffffffffc0209fc8:	8552                	mv	a0,s4
ffffffffc0209fca:	9c82                	jalr	s9
ffffffffc0209fcc:	ed11                	bnez	a0,ffffffffc0209fe8 <sfs_io_nolock+0xfc>
ffffffffc0209fce:	94ce                	add	s1,s1,s3
ffffffffc0209fd0:	994e                	add	s2,s2,s3
ffffffffc0209fd2:	9dce                	add	s11,s11,s3
ffffffffc0209fd4:	2405                	addiw	s0,s0,1
ffffffffc0209fd6:	0a9b8063          	beq	s7,s1,ffffffffc020a076 <sfs_io_nolock+0x18a>
ffffffffc0209fda:	0874                	addi	a3,sp,28
ffffffffc0209fdc:	8622                	mv	a2,s0
ffffffffc0209fde:	85d6                	mv	a1,s5
ffffffffc0209fe0:	8552                	mv	a0,s4
ffffffffc0209fe2:	cb3ff0ef          	jal	ra,ffffffffc0209c94 <sfs_bmap_load_nolock>
ffffffffc0209fe6:	dd71                	beqz	a0,ffffffffc0209fc2 <sfs_io_nolock+0xd6>
ffffffffc0209fe8:	009d8d33          	add	s10,s11,s1
ffffffffc0209fec:	000ab783          	ld	a5,0(s5)
ffffffffc0209ff0:	009c3023          	sd	s1,0(s8)
ffffffffc0209ff4:	0007e703          	lwu	a4,0(a5)
ffffffffc0209ff8:	01a77863          	bgeu	a4,s10,ffffffffc020a008 <sfs_io_nolock+0x11c>
ffffffffc0209ffc:	009d84bb          	addw	s1,s11,s1
ffffffffc020a000:	c384                	sw	s1,0(a5)
ffffffffc020a002:	4785                	li	a5,1
ffffffffc020a004:	00fab823          	sd	a5,16(s5)
ffffffffc020a008:	60aa                	ld	ra,136(sp)
ffffffffc020a00a:	640a                	ld	s0,128(sp)
ffffffffc020a00c:	74e6                	ld	s1,120(sp)
ffffffffc020a00e:	7946                	ld	s2,112(sp)
ffffffffc020a010:	79a6                	ld	s3,104(sp)
ffffffffc020a012:	7a06                	ld	s4,96(sp)
ffffffffc020a014:	6ae6                	ld	s5,88(sp)
ffffffffc020a016:	6b46                	ld	s6,80(sp)
ffffffffc020a018:	6ba6                	ld	s7,72(sp)
ffffffffc020a01a:	6c06                	ld	s8,64(sp)
ffffffffc020a01c:	7ce2                	ld	s9,56(sp)
ffffffffc020a01e:	7d42                	ld	s10,48(sp)
ffffffffc020a020:	7da2                	ld	s11,40(sp)
ffffffffc020a022:	6149                	addi	sp,sp,144
ffffffffc020a024:	8082                	ret
ffffffffc020a026:	0005e783          	lwu	a5,0(a1)
ffffffffc020a02a:	4501                	li	a0,0
ffffffffc020a02c:	fcfddee3          	bge	s11,a5,ffffffffc020a008 <sfs_io_nolock+0x11c>
ffffffffc020a030:	0367c763          	blt	a5,s6,ffffffffc020a05e <sfs_io_nolock+0x172>
ffffffffc020a034:	00001797          	auipc	a5,0x1
ffffffffc020a038:	dae78793          	addi	a5,a5,-594 # ffffffffc020ade2 <sfs_rbuf>
ffffffffc020a03c:	00001c97          	auipc	s9,0x1
ffffffffc020a040:	ce6c8c93          	addi	s9,s9,-794 # ffffffffc020ad22 <sfs_rblock>
ffffffffc020a044:	e43e                	sd	a5,8(sp)
ffffffffc020a046:	bf09                	j	ffffffffc0209f58 <sfs_io_nolock+0x6c>
ffffffffc020a048:	0874                	addi	a3,sp,28
ffffffffc020a04a:	8622                	mv	a2,s0
ffffffffc020a04c:	85d6                	mv	a1,s5
ffffffffc020a04e:	8552                	mv	a0,s4
ffffffffc020a050:	413784b3          	sub	s1,a5,s3
ffffffffc020a054:	c41ff0ef          	jal	ra,ffffffffc0209c94 <sfs_bmap_load_nolock>
ffffffffc020a058:	d90d                	beqz	a0,ffffffffc0209f8a <sfs_io_nolock+0x9e>
ffffffffc020a05a:	4481                	li	s1,0
ffffffffc020a05c:	bf41                	j	ffffffffc0209fec <sfs_io_nolock+0x100>
ffffffffc020a05e:	8b3e                	mv	s6,a5
ffffffffc020a060:	00001797          	auipc	a5,0x1
ffffffffc020a064:	d8278793          	addi	a5,a5,-638 # ffffffffc020ade2 <sfs_rbuf>
ffffffffc020a068:	00001c97          	auipc	s9,0x1
ffffffffc020a06c:	cbac8c93          	addi	s9,s9,-838 # ffffffffc020ad22 <sfs_rblock>
ffffffffc020a070:	e43e                	sd	a5,8(sp)
ffffffffc020a072:	b5dd                	j	ffffffffc0209f58 <sfs_io_nolock+0x6c>
ffffffffc020a074:	8ba6                	mv	s7,s1
ffffffffc020a076:	016dc763          	blt	s11,s6,ffffffffc020a084 <sfs_io_nolock+0x198>
ffffffffc020a07a:	01bb8d33          	add	s10,s7,s11
ffffffffc020a07e:	84de                	mv	s1,s7
ffffffffc020a080:	4501                	li	a0,0
ffffffffc020a082:	b7ad                	j	ffffffffc0209fec <sfs_io_nolock+0x100>
ffffffffc020a084:	0874                	addi	a3,sp,28
ffffffffc020a086:	8622                	mv	a2,s0
ffffffffc020a088:	85d6                	mv	a1,s5
ffffffffc020a08a:	8552                	mv	a0,s4
ffffffffc020a08c:	c09ff0ef          	jal	ra,ffffffffc0209c94 <sfs_bmap_load_nolock>
ffffffffc020a090:	ed11                	bnez	a0,ffffffffc020a0ac <sfs_io_nolock+0x1c0>
ffffffffc020a092:	46f2                	lw	a3,28(sp)
ffffffffc020a094:	67a2                	ld	a5,8(sp)
ffffffffc020a096:	41bb04b3          	sub	s1,s6,s11
ffffffffc020a09a:	8626                	mv	a2,s1
ffffffffc020a09c:	4701                	li	a4,0
ffffffffc020a09e:	85ca                	mv	a1,s2
ffffffffc020a0a0:	8552                	mv	a0,s4
ffffffffc020a0a2:	94de                	add	s1,s1,s7
ffffffffc020a0a4:	9782                	jalr	a5
ffffffffc020a0a6:	01b48d33          	add	s10,s1,s11
ffffffffc020a0aa:	d129                	beqz	a0,ffffffffc0209fec <sfs_io_nolock+0x100>
ffffffffc020a0ac:	01bb8d33          	add	s10,s7,s11
ffffffffc020a0b0:	84de                	mv	s1,s7
ffffffffc020a0b2:	bf2d                	j	ffffffffc0209fec <sfs_io_nolock+0x100>
ffffffffc020a0b4:	5575                	li	a0,-3
ffffffffc020a0b6:	bf89                	j	ffffffffc020a008 <sfs_io_nolock+0x11c>
ffffffffc020a0b8:	00005697          	auipc	a3,0x5
ffffffffc020a0bc:	04868693          	addi	a3,a3,72 # ffffffffc020f100 <dev_node_ops+0x730>
ffffffffc020a0c0:	00002617          	auipc	a2,0x2
ffffffffc020a0c4:	98860613          	addi	a2,a2,-1656 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a0c8:	2a100593          	li	a1,673
ffffffffc020a0cc:	00005517          	auipc	a0,0x5
ffffffffc020a0d0:	ec450513          	addi	a0,a0,-316 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a0d4:	bcaf60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a0d8 <sfs_read>:
ffffffffc020a0d8:	7139                	addi	sp,sp,-64
ffffffffc020a0da:	f04a                	sd	s2,32(sp)
ffffffffc020a0dc:	06853903          	ld	s2,104(a0)
ffffffffc020a0e0:	fc06                	sd	ra,56(sp)
ffffffffc020a0e2:	f822                	sd	s0,48(sp)
ffffffffc020a0e4:	f426                	sd	s1,40(sp)
ffffffffc020a0e6:	ec4e                	sd	s3,24(sp)
ffffffffc020a0e8:	04090f63          	beqz	s2,ffffffffc020a146 <sfs_read+0x6e>
ffffffffc020a0ec:	0b092783          	lw	a5,176(s2)
ffffffffc020a0f0:	ebb9                	bnez	a5,ffffffffc020a146 <sfs_read+0x6e>
ffffffffc020a0f2:	4d38                	lw	a4,88(a0)
ffffffffc020a0f4:	6785                	lui	a5,0x1
ffffffffc020a0f6:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a0fa:	842a                	mv	s0,a0
ffffffffc020a0fc:	06f71563          	bne	a4,a5,ffffffffc020a166 <sfs_read+0x8e>
ffffffffc020a100:	02050993          	addi	s3,a0,32
ffffffffc020a104:	854e                	mv	a0,s3
ffffffffc020a106:	84ae                	mv	s1,a1
ffffffffc020a108:	c5cfa0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc020a10c:	0184b803          	ld	a6,24(s1)
ffffffffc020a110:	6494                	ld	a3,8(s1)
ffffffffc020a112:	6090                	ld	a2,0(s1)
ffffffffc020a114:	85a2                	mv	a1,s0
ffffffffc020a116:	4781                	li	a5,0
ffffffffc020a118:	0038                	addi	a4,sp,8
ffffffffc020a11a:	854a                	mv	a0,s2
ffffffffc020a11c:	e442                	sd	a6,8(sp)
ffffffffc020a11e:	dcfff0ef          	jal	ra,ffffffffc0209eec <sfs_io_nolock>
ffffffffc020a122:	65a2                	ld	a1,8(sp)
ffffffffc020a124:	842a                	mv	s0,a0
ffffffffc020a126:	ed81                	bnez	a1,ffffffffc020a13e <sfs_read+0x66>
ffffffffc020a128:	854e                	mv	a0,s3
ffffffffc020a12a:	c36fa0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020a12e:	70e2                	ld	ra,56(sp)
ffffffffc020a130:	8522                	mv	a0,s0
ffffffffc020a132:	7442                	ld	s0,48(sp)
ffffffffc020a134:	74a2                	ld	s1,40(sp)
ffffffffc020a136:	7902                	ld	s2,32(sp)
ffffffffc020a138:	69e2                	ld	s3,24(sp)
ffffffffc020a13a:	6121                	addi	sp,sp,64
ffffffffc020a13c:	8082                	ret
ffffffffc020a13e:	8526                	mv	a0,s1
ffffffffc020a140:	b18fb0ef          	jal	ra,ffffffffc0205458 <iobuf_skip>
ffffffffc020a144:	b7d5                	j	ffffffffc020a128 <sfs_read+0x50>
ffffffffc020a146:	00005697          	auipc	a3,0x5
ffffffffc020a14a:	c6a68693          	addi	a3,a3,-918 # ffffffffc020edb0 <dev_node_ops+0x3e0>
ffffffffc020a14e:	00002617          	auipc	a2,0x2
ffffffffc020a152:	8fa60613          	addi	a2,a2,-1798 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a156:	30600593          	li	a1,774
ffffffffc020a15a:	00005517          	auipc	a0,0x5
ffffffffc020a15e:	e3650513          	addi	a0,a0,-458 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a162:	b3cf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a166:	851ff0ef          	jal	ra,ffffffffc02099b6 <sfs_io.part.0>

ffffffffc020a16a <sfs_write>:
ffffffffc020a16a:	7139                	addi	sp,sp,-64
ffffffffc020a16c:	f04a                	sd	s2,32(sp)
ffffffffc020a16e:	06853903          	ld	s2,104(a0)
ffffffffc020a172:	fc06                	sd	ra,56(sp)
ffffffffc020a174:	f822                	sd	s0,48(sp)
ffffffffc020a176:	f426                	sd	s1,40(sp)
ffffffffc020a178:	ec4e                	sd	s3,24(sp)
ffffffffc020a17a:	04090f63          	beqz	s2,ffffffffc020a1d8 <sfs_write+0x6e>
ffffffffc020a17e:	0b092783          	lw	a5,176(s2)
ffffffffc020a182:	ebb9                	bnez	a5,ffffffffc020a1d8 <sfs_write+0x6e>
ffffffffc020a184:	4d38                	lw	a4,88(a0)
ffffffffc020a186:	6785                	lui	a5,0x1
ffffffffc020a188:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a18c:	842a                	mv	s0,a0
ffffffffc020a18e:	06f71563          	bne	a4,a5,ffffffffc020a1f8 <sfs_write+0x8e>
ffffffffc020a192:	02050993          	addi	s3,a0,32
ffffffffc020a196:	854e                	mv	a0,s3
ffffffffc020a198:	84ae                	mv	s1,a1
ffffffffc020a19a:	bcafa0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc020a19e:	0184b803          	ld	a6,24(s1)
ffffffffc020a1a2:	6494                	ld	a3,8(s1)
ffffffffc020a1a4:	6090                	ld	a2,0(s1)
ffffffffc020a1a6:	85a2                	mv	a1,s0
ffffffffc020a1a8:	4785                	li	a5,1
ffffffffc020a1aa:	0038                	addi	a4,sp,8
ffffffffc020a1ac:	854a                	mv	a0,s2
ffffffffc020a1ae:	e442                	sd	a6,8(sp)
ffffffffc020a1b0:	d3dff0ef          	jal	ra,ffffffffc0209eec <sfs_io_nolock>
ffffffffc020a1b4:	65a2                	ld	a1,8(sp)
ffffffffc020a1b6:	842a                	mv	s0,a0
ffffffffc020a1b8:	ed81                	bnez	a1,ffffffffc020a1d0 <sfs_write+0x66>
ffffffffc020a1ba:	854e                	mv	a0,s3
ffffffffc020a1bc:	ba4fa0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020a1c0:	70e2                	ld	ra,56(sp)
ffffffffc020a1c2:	8522                	mv	a0,s0
ffffffffc020a1c4:	7442                	ld	s0,48(sp)
ffffffffc020a1c6:	74a2                	ld	s1,40(sp)
ffffffffc020a1c8:	7902                	ld	s2,32(sp)
ffffffffc020a1ca:	69e2                	ld	s3,24(sp)
ffffffffc020a1cc:	6121                	addi	sp,sp,64
ffffffffc020a1ce:	8082                	ret
ffffffffc020a1d0:	8526                	mv	a0,s1
ffffffffc020a1d2:	a86fb0ef          	jal	ra,ffffffffc0205458 <iobuf_skip>
ffffffffc020a1d6:	b7d5                	j	ffffffffc020a1ba <sfs_write+0x50>
ffffffffc020a1d8:	00005697          	auipc	a3,0x5
ffffffffc020a1dc:	bd868693          	addi	a3,a3,-1064 # ffffffffc020edb0 <dev_node_ops+0x3e0>
ffffffffc020a1e0:	00002617          	auipc	a2,0x2
ffffffffc020a1e4:	86860613          	addi	a2,a2,-1944 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a1e8:	30600593          	li	a1,774
ffffffffc020a1ec:	00005517          	auipc	a0,0x5
ffffffffc020a1f0:	da450513          	addi	a0,a0,-604 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a1f4:	aaaf60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a1f8:	fbeff0ef          	jal	ra,ffffffffc02099b6 <sfs_io.part.0>

ffffffffc020a1fc <sfs_dirent_read_nolock>:
ffffffffc020a1fc:	6198                	ld	a4,0(a1)
ffffffffc020a1fe:	7179                	addi	sp,sp,-48
ffffffffc020a200:	f406                	sd	ra,40(sp)
ffffffffc020a202:	00475883          	lhu	a7,4(a4) # 8000004 <_binary_bin_sfs_img_size+0x7f8ad04>
ffffffffc020a206:	f022                	sd	s0,32(sp)
ffffffffc020a208:	ec26                	sd	s1,24(sp)
ffffffffc020a20a:	4809                	li	a6,2
ffffffffc020a20c:	05089b63          	bne	a7,a6,ffffffffc020a262 <sfs_dirent_read_nolock+0x66>
ffffffffc020a210:	4718                	lw	a4,8(a4)
ffffffffc020a212:	87b2                	mv	a5,a2
ffffffffc020a214:	2601                	sext.w	a2,a2
ffffffffc020a216:	04e7f663          	bgeu	a5,a4,ffffffffc020a262 <sfs_dirent_read_nolock+0x66>
ffffffffc020a21a:	84b6                	mv	s1,a3
ffffffffc020a21c:	0074                	addi	a3,sp,12
ffffffffc020a21e:	842a                	mv	s0,a0
ffffffffc020a220:	a75ff0ef          	jal	ra,ffffffffc0209c94 <sfs_bmap_load_nolock>
ffffffffc020a224:	c511                	beqz	a0,ffffffffc020a230 <sfs_dirent_read_nolock+0x34>
ffffffffc020a226:	70a2                	ld	ra,40(sp)
ffffffffc020a228:	7402                	ld	s0,32(sp)
ffffffffc020a22a:	64e2                	ld	s1,24(sp)
ffffffffc020a22c:	6145                	addi	sp,sp,48
ffffffffc020a22e:	8082                	ret
ffffffffc020a230:	45b2                	lw	a1,12(sp)
ffffffffc020a232:	4054                	lw	a3,4(s0)
ffffffffc020a234:	c5b9                	beqz	a1,ffffffffc020a282 <sfs_dirent_read_nolock+0x86>
ffffffffc020a236:	04d5f663          	bgeu	a1,a3,ffffffffc020a282 <sfs_dirent_read_nolock+0x86>
ffffffffc020a23a:	7c08                	ld	a0,56(s0)
ffffffffc020a23c:	e91fe0ef          	jal	ra,ffffffffc02090cc <bitmap_test>
ffffffffc020a240:	ed31                	bnez	a0,ffffffffc020a29c <sfs_dirent_read_nolock+0xa0>
ffffffffc020a242:	46b2                	lw	a3,12(sp)
ffffffffc020a244:	4701                	li	a4,0
ffffffffc020a246:	10400613          	li	a2,260
ffffffffc020a24a:	85a6                	mv	a1,s1
ffffffffc020a24c:	8522                	mv	a0,s0
ffffffffc020a24e:	395000ef          	jal	ra,ffffffffc020ade2 <sfs_rbuf>
ffffffffc020a252:	f971                	bnez	a0,ffffffffc020a226 <sfs_dirent_read_nolock+0x2a>
ffffffffc020a254:	100481a3          	sb	zero,259(s1)
ffffffffc020a258:	70a2                	ld	ra,40(sp)
ffffffffc020a25a:	7402                	ld	s0,32(sp)
ffffffffc020a25c:	64e2                	ld	s1,24(sp)
ffffffffc020a25e:	6145                	addi	sp,sp,48
ffffffffc020a260:	8082                	ret
ffffffffc020a262:	00005697          	auipc	a3,0x5
ffffffffc020a266:	ebe68693          	addi	a3,a3,-322 # ffffffffc020f120 <dev_node_ops+0x750>
ffffffffc020a26a:	00001617          	auipc	a2,0x1
ffffffffc020a26e:	7de60613          	addi	a2,a2,2014 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a272:	18e00593          	li	a1,398
ffffffffc020a276:	00005517          	auipc	a0,0x5
ffffffffc020a27a:	d1a50513          	addi	a0,a0,-742 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a27e:	a20f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a282:	872e                	mv	a4,a1
ffffffffc020a284:	00005617          	auipc	a2,0x5
ffffffffc020a288:	d3c60613          	addi	a2,a2,-708 # ffffffffc020efc0 <dev_node_ops+0x5f0>
ffffffffc020a28c:	05300593          	li	a1,83
ffffffffc020a290:	00005517          	auipc	a0,0x5
ffffffffc020a294:	d0050513          	addi	a0,a0,-768 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a298:	a06f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a29c:	00005697          	auipc	a3,0x5
ffffffffc020a2a0:	d5c68693          	addi	a3,a3,-676 # ffffffffc020eff8 <dev_node_ops+0x628>
ffffffffc020a2a4:	00001617          	auipc	a2,0x1
ffffffffc020a2a8:	7a460613          	addi	a2,a2,1956 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a2ac:	19500593          	li	a1,405
ffffffffc020a2b0:	00005517          	auipc	a0,0x5
ffffffffc020a2b4:	ce050513          	addi	a0,a0,-800 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a2b8:	9e6f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a2bc <sfs_getdirentry>:
ffffffffc020a2bc:	715d                	addi	sp,sp,-80
ffffffffc020a2be:	ec56                	sd	s5,24(sp)
ffffffffc020a2c0:	8aaa                	mv	s5,a0
ffffffffc020a2c2:	10400513          	li	a0,260
ffffffffc020a2c6:	e85a                	sd	s6,16(sp)
ffffffffc020a2c8:	e486                	sd	ra,72(sp)
ffffffffc020a2ca:	e0a2                	sd	s0,64(sp)
ffffffffc020a2cc:	fc26                	sd	s1,56(sp)
ffffffffc020a2ce:	f84a                	sd	s2,48(sp)
ffffffffc020a2d0:	f44e                	sd	s3,40(sp)
ffffffffc020a2d2:	f052                	sd	s4,32(sp)
ffffffffc020a2d4:	e45e                	sd	s7,8(sp)
ffffffffc020a2d6:	e062                	sd	s8,0(sp)
ffffffffc020a2d8:	8b2e                	mv	s6,a1
ffffffffc020a2da:	cb5f70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020a2de:	cd61                	beqz	a0,ffffffffc020a3b6 <sfs_getdirentry+0xfa>
ffffffffc020a2e0:	068abb83          	ld	s7,104(s5)
ffffffffc020a2e4:	0c0b8b63          	beqz	s7,ffffffffc020a3ba <sfs_getdirentry+0xfe>
ffffffffc020a2e8:	0b0ba783          	lw	a5,176(s7) # 10b0 <_binary_bin_swap_img_size-0x6c50>
ffffffffc020a2ec:	e7f9                	bnez	a5,ffffffffc020a3ba <sfs_getdirentry+0xfe>
ffffffffc020a2ee:	058aa703          	lw	a4,88(s5)
ffffffffc020a2f2:	6785                	lui	a5,0x1
ffffffffc020a2f4:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a2f8:	0ef71163          	bne	a4,a5,ffffffffc020a3da <sfs_getdirentry+0x11e>
ffffffffc020a2fc:	008b3983          	ld	s3,8(s6) # 8000008 <_binary_bin_sfs_img_size+0x7f8ad08>
ffffffffc020a300:	892a                	mv	s2,a0
ffffffffc020a302:	0a09c163          	bltz	s3,ffffffffc020a3a4 <sfs_getdirentry+0xe8>
ffffffffc020a306:	0ff9f793          	zext.b	a5,s3
ffffffffc020a30a:	efc9                	bnez	a5,ffffffffc020a3a4 <sfs_getdirentry+0xe8>
ffffffffc020a30c:	000ab783          	ld	a5,0(s5)
ffffffffc020a310:	0089d993          	srli	s3,s3,0x8
ffffffffc020a314:	2981                	sext.w	s3,s3
ffffffffc020a316:	479c                	lw	a5,8(a5)
ffffffffc020a318:	0937eb63          	bltu	a5,s3,ffffffffc020a3ae <sfs_getdirentry+0xf2>
ffffffffc020a31c:	020a8c13          	addi	s8,s5,32
ffffffffc020a320:	8562                	mv	a0,s8
ffffffffc020a322:	a42fa0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc020a326:	000ab783          	ld	a5,0(s5)
ffffffffc020a32a:	0087aa03          	lw	s4,8(a5)
ffffffffc020a32e:	07405663          	blez	s4,ffffffffc020a39a <sfs_getdirentry+0xde>
ffffffffc020a332:	4481                	li	s1,0
ffffffffc020a334:	a811                	j	ffffffffc020a348 <sfs_getdirentry+0x8c>
ffffffffc020a336:	00092783          	lw	a5,0(s2)
ffffffffc020a33a:	c781                	beqz	a5,ffffffffc020a342 <sfs_getdirentry+0x86>
ffffffffc020a33c:	02098263          	beqz	s3,ffffffffc020a360 <sfs_getdirentry+0xa4>
ffffffffc020a340:	39fd                	addiw	s3,s3,-1
ffffffffc020a342:	2485                	addiw	s1,s1,1
ffffffffc020a344:	049a0b63          	beq	s4,s1,ffffffffc020a39a <sfs_getdirentry+0xde>
ffffffffc020a348:	86ca                	mv	a3,s2
ffffffffc020a34a:	8626                	mv	a2,s1
ffffffffc020a34c:	85d6                	mv	a1,s5
ffffffffc020a34e:	855e                	mv	a0,s7
ffffffffc020a350:	eadff0ef          	jal	ra,ffffffffc020a1fc <sfs_dirent_read_nolock>
ffffffffc020a354:	842a                	mv	s0,a0
ffffffffc020a356:	d165                	beqz	a0,ffffffffc020a336 <sfs_getdirentry+0x7a>
ffffffffc020a358:	8562                	mv	a0,s8
ffffffffc020a35a:	a06fa0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020a35e:	a831                	j	ffffffffc020a37a <sfs_getdirentry+0xbe>
ffffffffc020a360:	8562                	mv	a0,s8
ffffffffc020a362:	9fefa0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020a366:	4701                	li	a4,0
ffffffffc020a368:	4685                	li	a3,1
ffffffffc020a36a:	10000613          	li	a2,256
ffffffffc020a36e:	00490593          	addi	a1,s2,4
ffffffffc020a372:	855a                	mv	a0,s6
ffffffffc020a374:	878fb0ef          	jal	ra,ffffffffc02053ec <iobuf_move>
ffffffffc020a378:	842a                	mv	s0,a0
ffffffffc020a37a:	854a                	mv	a0,s2
ffffffffc020a37c:	cc3f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a380:	60a6                	ld	ra,72(sp)
ffffffffc020a382:	8522                	mv	a0,s0
ffffffffc020a384:	6406                	ld	s0,64(sp)
ffffffffc020a386:	74e2                	ld	s1,56(sp)
ffffffffc020a388:	7942                	ld	s2,48(sp)
ffffffffc020a38a:	79a2                	ld	s3,40(sp)
ffffffffc020a38c:	7a02                	ld	s4,32(sp)
ffffffffc020a38e:	6ae2                	ld	s5,24(sp)
ffffffffc020a390:	6b42                	ld	s6,16(sp)
ffffffffc020a392:	6ba2                	ld	s7,8(sp)
ffffffffc020a394:	6c02                	ld	s8,0(sp)
ffffffffc020a396:	6161                	addi	sp,sp,80
ffffffffc020a398:	8082                	ret
ffffffffc020a39a:	8562                	mv	a0,s8
ffffffffc020a39c:	5441                	li	s0,-16
ffffffffc020a39e:	9c2fa0ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020a3a2:	bfe1                	j	ffffffffc020a37a <sfs_getdirentry+0xbe>
ffffffffc020a3a4:	854a                	mv	a0,s2
ffffffffc020a3a6:	c99f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a3aa:	5475                	li	s0,-3
ffffffffc020a3ac:	bfd1                	j	ffffffffc020a380 <sfs_getdirentry+0xc4>
ffffffffc020a3ae:	c91f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a3b2:	5441                	li	s0,-16
ffffffffc020a3b4:	b7f1                	j	ffffffffc020a380 <sfs_getdirentry+0xc4>
ffffffffc020a3b6:	5471                	li	s0,-4
ffffffffc020a3b8:	b7e1                	j	ffffffffc020a380 <sfs_getdirentry+0xc4>
ffffffffc020a3ba:	00005697          	auipc	a3,0x5
ffffffffc020a3be:	9f668693          	addi	a3,a3,-1546 # ffffffffc020edb0 <dev_node_ops+0x3e0>
ffffffffc020a3c2:	00001617          	auipc	a2,0x1
ffffffffc020a3c6:	68660613          	addi	a2,a2,1670 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a3ca:	3aa00593          	li	a1,938
ffffffffc020a3ce:	00005517          	auipc	a0,0x5
ffffffffc020a3d2:	bc250513          	addi	a0,a0,-1086 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a3d6:	8c8f60ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a3da:	00005697          	auipc	a3,0x5
ffffffffc020a3de:	b7e68693          	addi	a3,a3,-1154 # ffffffffc020ef58 <dev_node_ops+0x588>
ffffffffc020a3e2:	00001617          	auipc	a2,0x1
ffffffffc020a3e6:	66660613          	addi	a2,a2,1638 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a3ea:	3ab00593          	li	a1,939
ffffffffc020a3ee:	00005517          	auipc	a0,0x5
ffffffffc020a3f2:	ba250513          	addi	a0,a0,-1118 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a3f6:	8a8f60ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a3fa <sfs_dirent_search_nolock.constprop.0>:
ffffffffc020a3fa:	715d                	addi	sp,sp,-80
ffffffffc020a3fc:	f052                	sd	s4,32(sp)
ffffffffc020a3fe:	8a2a                	mv	s4,a0
ffffffffc020a400:	8532                	mv	a0,a2
ffffffffc020a402:	f44e                	sd	s3,40(sp)
ffffffffc020a404:	e85a                	sd	s6,16(sp)
ffffffffc020a406:	e45e                	sd	s7,8(sp)
ffffffffc020a408:	e486                	sd	ra,72(sp)
ffffffffc020a40a:	e0a2                	sd	s0,64(sp)
ffffffffc020a40c:	fc26                	sd	s1,56(sp)
ffffffffc020a40e:	f84a                	sd	s2,48(sp)
ffffffffc020a410:	ec56                	sd	s5,24(sp)
ffffffffc020a412:	e062                	sd	s8,0(sp)
ffffffffc020a414:	8b32                	mv	s6,a2
ffffffffc020a416:	89ae                	mv	s3,a1
ffffffffc020a418:	8bb6                	mv	s7,a3
ffffffffc020a41a:	0aa010ef          	jal	ra,ffffffffc020b4c4 <strlen>
ffffffffc020a41e:	0ff00793          	li	a5,255
ffffffffc020a422:	06a7ef63          	bltu	a5,a0,ffffffffc020a4a0 <sfs_dirent_search_nolock.constprop.0+0xa6>
ffffffffc020a426:	10400513          	li	a0,260
ffffffffc020a42a:	b65f70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020a42e:	892a                	mv	s2,a0
ffffffffc020a430:	c535                	beqz	a0,ffffffffc020a49c <sfs_dirent_search_nolock.constprop.0+0xa2>
ffffffffc020a432:	0009b783          	ld	a5,0(s3) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc020a436:	0087aa83          	lw	s5,8(a5)
ffffffffc020a43a:	05505a63          	blez	s5,ffffffffc020a48e <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a43e:	4481                	li	s1,0
ffffffffc020a440:	00450c13          	addi	s8,a0,4
ffffffffc020a444:	a829                	j	ffffffffc020a45e <sfs_dirent_search_nolock.constprop.0+0x64>
ffffffffc020a446:	00092783          	lw	a5,0(s2)
ffffffffc020a44a:	c799                	beqz	a5,ffffffffc020a458 <sfs_dirent_search_nolock.constprop.0+0x5e>
ffffffffc020a44c:	85e2                	mv	a1,s8
ffffffffc020a44e:	855a                	mv	a0,s6
ffffffffc020a450:	0bc010ef          	jal	ra,ffffffffc020b50c <strcmp>
ffffffffc020a454:	842a                	mv	s0,a0
ffffffffc020a456:	cd15                	beqz	a0,ffffffffc020a492 <sfs_dirent_search_nolock.constprop.0+0x98>
ffffffffc020a458:	2485                	addiw	s1,s1,1
ffffffffc020a45a:	029a8a63          	beq	s5,s1,ffffffffc020a48e <sfs_dirent_search_nolock.constprop.0+0x94>
ffffffffc020a45e:	86ca                	mv	a3,s2
ffffffffc020a460:	8626                	mv	a2,s1
ffffffffc020a462:	85ce                	mv	a1,s3
ffffffffc020a464:	8552                	mv	a0,s4
ffffffffc020a466:	d97ff0ef          	jal	ra,ffffffffc020a1fc <sfs_dirent_read_nolock>
ffffffffc020a46a:	842a                	mv	s0,a0
ffffffffc020a46c:	dd69                	beqz	a0,ffffffffc020a446 <sfs_dirent_search_nolock.constprop.0+0x4c>
ffffffffc020a46e:	854a                	mv	a0,s2
ffffffffc020a470:	bcff70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a474:	60a6                	ld	ra,72(sp)
ffffffffc020a476:	8522                	mv	a0,s0
ffffffffc020a478:	6406                	ld	s0,64(sp)
ffffffffc020a47a:	74e2                	ld	s1,56(sp)
ffffffffc020a47c:	7942                	ld	s2,48(sp)
ffffffffc020a47e:	79a2                	ld	s3,40(sp)
ffffffffc020a480:	7a02                	ld	s4,32(sp)
ffffffffc020a482:	6ae2                	ld	s5,24(sp)
ffffffffc020a484:	6b42                	ld	s6,16(sp)
ffffffffc020a486:	6ba2                	ld	s7,8(sp)
ffffffffc020a488:	6c02                	ld	s8,0(sp)
ffffffffc020a48a:	6161                	addi	sp,sp,80
ffffffffc020a48c:	8082                	ret
ffffffffc020a48e:	5441                	li	s0,-16
ffffffffc020a490:	bff9                	j	ffffffffc020a46e <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a492:	00092783          	lw	a5,0(s2)
ffffffffc020a496:	00fba023          	sw	a5,0(s7)
ffffffffc020a49a:	bfd1                	j	ffffffffc020a46e <sfs_dirent_search_nolock.constprop.0+0x74>
ffffffffc020a49c:	5471                	li	s0,-4
ffffffffc020a49e:	bfd9                	j	ffffffffc020a474 <sfs_dirent_search_nolock.constprop.0+0x7a>
ffffffffc020a4a0:	00005697          	auipc	a3,0x5
ffffffffc020a4a4:	cd068693          	addi	a3,a3,-816 # ffffffffc020f170 <dev_node_ops+0x7a0>
ffffffffc020a4a8:	00001617          	auipc	a2,0x1
ffffffffc020a4ac:	5a060613          	addi	a2,a2,1440 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a4b0:	1ba00593          	li	a1,442
ffffffffc020a4b4:	00005517          	auipc	a0,0x5
ffffffffc020a4b8:	adc50513          	addi	a0,a0,-1316 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a4bc:	fe3f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a4c0 <sfs_truncfile>:
ffffffffc020a4c0:	7175                	addi	sp,sp,-144
ffffffffc020a4c2:	e506                	sd	ra,136(sp)
ffffffffc020a4c4:	e122                	sd	s0,128(sp)
ffffffffc020a4c6:	fca6                	sd	s1,120(sp)
ffffffffc020a4c8:	f8ca                	sd	s2,112(sp)
ffffffffc020a4ca:	f4ce                	sd	s3,104(sp)
ffffffffc020a4cc:	f0d2                	sd	s4,96(sp)
ffffffffc020a4ce:	ecd6                	sd	s5,88(sp)
ffffffffc020a4d0:	e8da                	sd	s6,80(sp)
ffffffffc020a4d2:	e4de                	sd	s7,72(sp)
ffffffffc020a4d4:	e0e2                	sd	s8,64(sp)
ffffffffc020a4d6:	fc66                	sd	s9,56(sp)
ffffffffc020a4d8:	f86a                	sd	s10,48(sp)
ffffffffc020a4da:	f46e                	sd	s11,40(sp)
ffffffffc020a4dc:	080007b7          	lui	a5,0x8000
ffffffffc020a4e0:	16b7e463          	bltu	a5,a1,ffffffffc020a648 <sfs_truncfile+0x188>
ffffffffc020a4e4:	06853c83          	ld	s9,104(a0)
ffffffffc020a4e8:	89aa                	mv	s3,a0
ffffffffc020a4ea:	160c8163          	beqz	s9,ffffffffc020a64c <sfs_truncfile+0x18c>
ffffffffc020a4ee:	0b0ca783          	lw	a5,176(s9)
ffffffffc020a4f2:	14079d63          	bnez	a5,ffffffffc020a64c <sfs_truncfile+0x18c>
ffffffffc020a4f6:	4d38                	lw	a4,88(a0)
ffffffffc020a4f8:	6405                	lui	s0,0x1
ffffffffc020a4fa:	23540793          	addi	a5,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a4fe:	16f71763          	bne	a4,a5,ffffffffc020a66c <sfs_truncfile+0x1ac>
ffffffffc020a502:	00053a83          	ld	s5,0(a0)
ffffffffc020a506:	147d                	addi	s0,s0,-1
ffffffffc020a508:	942e                	add	s0,s0,a1
ffffffffc020a50a:	000ae783          	lwu	a5,0(s5)
ffffffffc020a50e:	8031                	srli	s0,s0,0xc
ffffffffc020a510:	8a2e                	mv	s4,a1
ffffffffc020a512:	2401                	sext.w	s0,s0
ffffffffc020a514:	02b79763          	bne	a5,a1,ffffffffc020a542 <sfs_truncfile+0x82>
ffffffffc020a518:	008aa783          	lw	a5,8(s5)
ffffffffc020a51c:	4901                	li	s2,0
ffffffffc020a51e:	18879763          	bne	a5,s0,ffffffffc020a6ac <sfs_truncfile+0x1ec>
ffffffffc020a522:	60aa                	ld	ra,136(sp)
ffffffffc020a524:	640a                	ld	s0,128(sp)
ffffffffc020a526:	74e6                	ld	s1,120(sp)
ffffffffc020a528:	79a6                	ld	s3,104(sp)
ffffffffc020a52a:	7a06                	ld	s4,96(sp)
ffffffffc020a52c:	6ae6                	ld	s5,88(sp)
ffffffffc020a52e:	6b46                	ld	s6,80(sp)
ffffffffc020a530:	6ba6                	ld	s7,72(sp)
ffffffffc020a532:	6c06                	ld	s8,64(sp)
ffffffffc020a534:	7ce2                	ld	s9,56(sp)
ffffffffc020a536:	7d42                	ld	s10,48(sp)
ffffffffc020a538:	7da2                	ld	s11,40(sp)
ffffffffc020a53a:	854a                	mv	a0,s2
ffffffffc020a53c:	7946                	ld	s2,112(sp)
ffffffffc020a53e:	6149                	addi	sp,sp,144
ffffffffc020a540:	8082                	ret
ffffffffc020a542:	02050b13          	addi	s6,a0,32
ffffffffc020a546:	855a                	mv	a0,s6
ffffffffc020a548:	81cfa0ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc020a54c:	008aa483          	lw	s1,8(s5)
ffffffffc020a550:	0a84e663          	bltu	s1,s0,ffffffffc020a5fc <sfs_truncfile+0x13c>
ffffffffc020a554:	0c947163          	bgeu	s0,s1,ffffffffc020a616 <sfs_truncfile+0x156>
ffffffffc020a558:	4dad                	li	s11,11
ffffffffc020a55a:	4b85                	li	s7,1
ffffffffc020a55c:	a09d                	j	ffffffffc020a5c2 <sfs_truncfile+0x102>
ffffffffc020a55e:	ff37091b          	addiw	s2,a4,-13
ffffffffc020a562:	0009079b          	sext.w	a5,s2
ffffffffc020a566:	3ff00713          	li	a4,1023
ffffffffc020a56a:	04f76563          	bltu	a4,a5,ffffffffc020a5b4 <sfs_truncfile+0xf4>
ffffffffc020a56e:	03cd2c03          	lw	s8,60(s10)
ffffffffc020a572:	040c0163          	beqz	s8,ffffffffc020a5b4 <sfs_truncfile+0xf4>
ffffffffc020a576:	004ca783          	lw	a5,4(s9)
ffffffffc020a57a:	18fc7963          	bgeu	s8,a5,ffffffffc020a70c <sfs_truncfile+0x24c>
ffffffffc020a57e:	038cb503          	ld	a0,56(s9)
ffffffffc020a582:	85e2                	mv	a1,s8
ffffffffc020a584:	b49fe0ef          	jal	ra,ffffffffc02090cc <bitmap_test>
ffffffffc020a588:	16051263          	bnez	a0,ffffffffc020a6ec <sfs_truncfile+0x22c>
ffffffffc020a58c:	02091793          	slli	a5,s2,0x20
ffffffffc020a590:	01e7d713          	srli	a4,a5,0x1e
ffffffffc020a594:	86e2                	mv	a3,s8
ffffffffc020a596:	4611                	li	a2,4
ffffffffc020a598:	082c                	addi	a1,sp,24
ffffffffc020a59a:	8566                	mv	a0,s9
ffffffffc020a59c:	e43a                	sd	a4,8(sp)
ffffffffc020a59e:	ce02                	sw	zero,28(sp)
ffffffffc020a5a0:	043000ef          	jal	ra,ffffffffc020ade2 <sfs_rbuf>
ffffffffc020a5a4:	892a                	mv	s2,a0
ffffffffc020a5a6:	e141                	bnez	a0,ffffffffc020a626 <sfs_truncfile+0x166>
ffffffffc020a5a8:	47e2                	lw	a5,24(sp)
ffffffffc020a5aa:	6722                	ld	a4,8(sp)
ffffffffc020a5ac:	e3c9                	bnez	a5,ffffffffc020a62e <sfs_truncfile+0x16e>
ffffffffc020a5ae:	008d2603          	lw	a2,8(s10)
ffffffffc020a5b2:	367d                	addiw	a2,a2,-1
ffffffffc020a5b4:	00cd2423          	sw	a2,8(s10)
ffffffffc020a5b8:	0179b823          	sd	s7,16(s3)
ffffffffc020a5bc:	34fd                	addiw	s1,s1,-1
ffffffffc020a5be:	04940a63          	beq	s0,s1,ffffffffc020a612 <sfs_truncfile+0x152>
ffffffffc020a5c2:	0009bd03          	ld	s10,0(s3)
ffffffffc020a5c6:	008d2703          	lw	a4,8(s10)
ffffffffc020a5ca:	c369                	beqz	a4,ffffffffc020a68c <sfs_truncfile+0x1cc>
ffffffffc020a5cc:	fff7079b          	addiw	a5,a4,-1
ffffffffc020a5d0:	0007861b          	sext.w	a2,a5
ffffffffc020a5d4:	f8cde5e3          	bltu	s11,a2,ffffffffc020a55e <sfs_truncfile+0x9e>
ffffffffc020a5d8:	02079713          	slli	a4,a5,0x20
ffffffffc020a5dc:	01e75793          	srli	a5,a4,0x1e
ffffffffc020a5e0:	00fd0933          	add	s2,s10,a5
ffffffffc020a5e4:	00c92583          	lw	a1,12(s2)
ffffffffc020a5e8:	d5f1                	beqz	a1,ffffffffc020a5b4 <sfs_truncfile+0xf4>
ffffffffc020a5ea:	8566                	mv	a0,s9
ffffffffc020a5ec:	beeff0ef          	jal	ra,ffffffffc02099da <sfs_block_free>
ffffffffc020a5f0:	00092623          	sw	zero,12(s2)
ffffffffc020a5f4:	008d2603          	lw	a2,8(s10)
ffffffffc020a5f8:	367d                	addiw	a2,a2,-1
ffffffffc020a5fa:	bf6d                	j	ffffffffc020a5b4 <sfs_truncfile+0xf4>
ffffffffc020a5fc:	4681                	li	a3,0
ffffffffc020a5fe:	8626                	mv	a2,s1
ffffffffc020a600:	85ce                	mv	a1,s3
ffffffffc020a602:	8566                	mv	a0,s9
ffffffffc020a604:	e90ff0ef          	jal	ra,ffffffffc0209c94 <sfs_bmap_load_nolock>
ffffffffc020a608:	892a                	mv	s2,a0
ffffffffc020a60a:	ed11                	bnez	a0,ffffffffc020a626 <sfs_truncfile+0x166>
ffffffffc020a60c:	2485                	addiw	s1,s1,1
ffffffffc020a60e:	fe9417e3          	bne	s0,s1,ffffffffc020a5fc <sfs_truncfile+0x13c>
ffffffffc020a612:	008aa483          	lw	s1,8(s5)
ffffffffc020a616:	0a941b63          	bne	s0,s1,ffffffffc020a6cc <sfs_truncfile+0x20c>
ffffffffc020a61a:	014aa023          	sw	s4,0(s5)
ffffffffc020a61e:	4785                	li	a5,1
ffffffffc020a620:	00f9b823          	sd	a5,16(s3)
ffffffffc020a624:	4901                	li	s2,0
ffffffffc020a626:	855a                	mv	a0,s6
ffffffffc020a628:	f39f90ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020a62c:	bddd                	j	ffffffffc020a522 <sfs_truncfile+0x62>
ffffffffc020a62e:	86e2                	mv	a3,s8
ffffffffc020a630:	4611                	li	a2,4
ffffffffc020a632:	086c                	addi	a1,sp,28
ffffffffc020a634:	8566                	mv	a0,s9
ffffffffc020a636:	02d000ef          	jal	ra,ffffffffc020ae62 <sfs_wbuf>
ffffffffc020a63a:	892a                	mv	s2,a0
ffffffffc020a63c:	f56d                	bnez	a0,ffffffffc020a626 <sfs_truncfile+0x166>
ffffffffc020a63e:	45e2                	lw	a1,24(sp)
ffffffffc020a640:	8566                	mv	a0,s9
ffffffffc020a642:	b98ff0ef          	jal	ra,ffffffffc02099da <sfs_block_free>
ffffffffc020a646:	b7a5                	j	ffffffffc020a5ae <sfs_truncfile+0xee>
ffffffffc020a648:	5975                	li	s2,-3
ffffffffc020a64a:	bde1                	j	ffffffffc020a522 <sfs_truncfile+0x62>
ffffffffc020a64c:	00004697          	auipc	a3,0x4
ffffffffc020a650:	76468693          	addi	a3,a3,1892 # ffffffffc020edb0 <dev_node_ops+0x3e0>
ffffffffc020a654:	00001617          	auipc	a2,0x1
ffffffffc020a658:	3f460613          	addi	a2,a2,1012 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a65c:	41900593          	li	a1,1049
ffffffffc020a660:	00005517          	auipc	a0,0x5
ffffffffc020a664:	93050513          	addi	a0,a0,-1744 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a668:	e37f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a66c:	00005697          	auipc	a3,0x5
ffffffffc020a670:	8ec68693          	addi	a3,a3,-1812 # ffffffffc020ef58 <dev_node_ops+0x588>
ffffffffc020a674:	00001617          	auipc	a2,0x1
ffffffffc020a678:	3d460613          	addi	a2,a2,980 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a67c:	41a00593          	li	a1,1050
ffffffffc020a680:	00005517          	auipc	a0,0x5
ffffffffc020a684:	91050513          	addi	a0,a0,-1776 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a688:	e17f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a68c:	00005697          	auipc	a3,0x5
ffffffffc020a690:	b2468693          	addi	a3,a3,-1244 # ffffffffc020f1b0 <dev_node_ops+0x7e0>
ffffffffc020a694:	00001617          	auipc	a2,0x1
ffffffffc020a698:	3b460613          	addi	a2,a2,948 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a69c:	17b00593          	li	a1,379
ffffffffc020a6a0:	00005517          	auipc	a0,0x5
ffffffffc020a6a4:	8f050513          	addi	a0,a0,-1808 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a6a8:	df7f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a6ac:	00005697          	auipc	a3,0x5
ffffffffc020a6b0:	aec68693          	addi	a3,a3,-1300 # ffffffffc020f198 <dev_node_ops+0x7c8>
ffffffffc020a6b4:	00001617          	auipc	a2,0x1
ffffffffc020a6b8:	39460613          	addi	a2,a2,916 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a6bc:	42100593          	li	a1,1057
ffffffffc020a6c0:	00005517          	auipc	a0,0x5
ffffffffc020a6c4:	8d050513          	addi	a0,a0,-1840 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a6c8:	dd7f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a6cc:	00005697          	auipc	a3,0x5
ffffffffc020a6d0:	b3468693          	addi	a3,a3,-1228 # ffffffffc020f200 <dev_node_ops+0x830>
ffffffffc020a6d4:	00001617          	auipc	a2,0x1
ffffffffc020a6d8:	37460613          	addi	a2,a2,884 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a6dc:	43a00593          	li	a1,1082
ffffffffc020a6e0:	00005517          	auipc	a0,0x5
ffffffffc020a6e4:	8b050513          	addi	a0,a0,-1872 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a6e8:	db7f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a6ec:	00005697          	auipc	a3,0x5
ffffffffc020a6f0:	adc68693          	addi	a3,a3,-1316 # ffffffffc020f1c8 <dev_node_ops+0x7f8>
ffffffffc020a6f4:	00001617          	auipc	a2,0x1
ffffffffc020a6f8:	35460613          	addi	a2,a2,852 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a6fc:	12b00593          	li	a1,299
ffffffffc020a700:	00005517          	auipc	a0,0x5
ffffffffc020a704:	89050513          	addi	a0,a0,-1904 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a708:	d97f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a70c:	8762                	mv	a4,s8
ffffffffc020a70e:	86be                	mv	a3,a5
ffffffffc020a710:	00005617          	auipc	a2,0x5
ffffffffc020a714:	8b060613          	addi	a2,a2,-1872 # ffffffffc020efc0 <dev_node_ops+0x5f0>
ffffffffc020a718:	05300593          	li	a1,83
ffffffffc020a71c:	00005517          	auipc	a0,0x5
ffffffffc020a720:	87450513          	addi	a0,a0,-1932 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a724:	d7bf50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a728 <sfs_load_inode>:
ffffffffc020a728:	7139                	addi	sp,sp,-64
ffffffffc020a72a:	fc06                	sd	ra,56(sp)
ffffffffc020a72c:	f822                	sd	s0,48(sp)
ffffffffc020a72e:	f426                	sd	s1,40(sp)
ffffffffc020a730:	f04a                	sd	s2,32(sp)
ffffffffc020a732:	84b2                	mv	s1,a2
ffffffffc020a734:	892a                	mv	s2,a0
ffffffffc020a736:	ec4e                	sd	s3,24(sp)
ffffffffc020a738:	e852                	sd	s4,16(sp)
ffffffffc020a73a:	89ae                	mv	s3,a1
ffffffffc020a73c:	e456                	sd	s5,8(sp)
ffffffffc020a73e:	0d5000ef          	jal	ra,ffffffffc020b012 <lock_sfs_fs>
ffffffffc020a742:	45a9                	li	a1,10
ffffffffc020a744:	8526                	mv	a0,s1
ffffffffc020a746:	0a893403          	ld	s0,168(s2)
ffffffffc020a74a:	0e9000ef          	jal	ra,ffffffffc020b032 <hash32>
ffffffffc020a74e:	02051793          	slli	a5,a0,0x20
ffffffffc020a752:	01c7d713          	srli	a4,a5,0x1c
ffffffffc020a756:	9722                	add	a4,a4,s0
ffffffffc020a758:	843a                	mv	s0,a4
ffffffffc020a75a:	a029                	j	ffffffffc020a764 <sfs_load_inode+0x3c>
ffffffffc020a75c:	fc042783          	lw	a5,-64(s0)
ffffffffc020a760:	10978863          	beq	a5,s1,ffffffffc020a870 <sfs_load_inode+0x148>
ffffffffc020a764:	6400                	ld	s0,8(s0)
ffffffffc020a766:	fe871be3          	bne	a4,s0,ffffffffc020a75c <sfs_load_inode+0x34>
ffffffffc020a76a:	04000513          	li	a0,64
ffffffffc020a76e:	821f70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020a772:	8aaa                	mv	s5,a0
ffffffffc020a774:	16050563          	beqz	a0,ffffffffc020a8de <sfs_load_inode+0x1b6>
ffffffffc020a778:	00492683          	lw	a3,4(s2)
ffffffffc020a77c:	18048363          	beqz	s1,ffffffffc020a902 <sfs_load_inode+0x1da>
ffffffffc020a780:	18d4f163          	bgeu	s1,a3,ffffffffc020a902 <sfs_load_inode+0x1da>
ffffffffc020a784:	03893503          	ld	a0,56(s2)
ffffffffc020a788:	85a6                	mv	a1,s1
ffffffffc020a78a:	943fe0ef          	jal	ra,ffffffffc02090cc <bitmap_test>
ffffffffc020a78e:	18051763          	bnez	a0,ffffffffc020a91c <sfs_load_inode+0x1f4>
ffffffffc020a792:	4701                	li	a4,0
ffffffffc020a794:	86a6                	mv	a3,s1
ffffffffc020a796:	04000613          	li	a2,64
ffffffffc020a79a:	85d6                	mv	a1,s5
ffffffffc020a79c:	854a                	mv	a0,s2
ffffffffc020a79e:	644000ef          	jal	ra,ffffffffc020ade2 <sfs_rbuf>
ffffffffc020a7a2:	842a                	mv	s0,a0
ffffffffc020a7a4:	0e051563          	bnez	a0,ffffffffc020a88e <sfs_load_inode+0x166>
ffffffffc020a7a8:	006ad783          	lhu	a5,6(s5)
ffffffffc020a7ac:	12078b63          	beqz	a5,ffffffffc020a8e2 <sfs_load_inode+0x1ba>
ffffffffc020a7b0:	6405                	lui	s0,0x1
ffffffffc020a7b2:	23540513          	addi	a0,s0,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a7b6:	8d0fd0ef          	jal	ra,ffffffffc0207886 <__alloc_inode>
ffffffffc020a7ba:	8a2a                	mv	s4,a0
ffffffffc020a7bc:	c961                	beqz	a0,ffffffffc020a88c <sfs_load_inode+0x164>
ffffffffc020a7be:	004ad683          	lhu	a3,4(s5)
ffffffffc020a7c2:	4785                	li	a5,1
ffffffffc020a7c4:	0cf69c63          	bne	a3,a5,ffffffffc020a89c <sfs_load_inode+0x174>
ffffffffc020a7c8:	864a                	mv	a2,s2
ffffffffc020a7ca:	00005597          	auipc	a1,0x5
ffffffffc020a7ce:	b4658593          	addi	a1,a1,-1210 # ffffffffc020f310 <sfs_node_fileops>
ffffffffc020a7d2:	8d0fd0ef          	jal	ra,ffffffffc02078a2 <inode_init>
ffffffffc020a7d6:	058a2783          	lw	a5,88(s4)
ffffffffc020a7da:	23540413          	addi	s0,s0,565
ffffffffc020a7de:	0e879063          	bne	a5,s0,ffffffffc020a8be <sfs_load_inode+0x196>
ffffffffc020a7e2:	4785                	li	a5,1
ffffffffc020a7e4:	00fa2c23          	sw	a5,24(s4)
ffffffffc020a7e8:	015a3023          	sd	s5,0(s4)
ffffffffc020a7ec:	009a2423          	sw	s1,8(s4)
ffffffffc020a7f0:	000a3823          	sd	zero,16(s4)
ffffffffc020a7f4:	4585                	li	a1,1
ffffffffc020a7f6:	020a0513          	addi	a0,s4,32
ffffffffc020a7fa:	d61f90ef          	jal	ra,ffffffffc020455a <sem_init>
ffffffffc020a7fe:	058a2703          	lw	a4,88(s4)
ffffffffc020a802:	6785                	lui	a5,0x1
ffffffffc020a804:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a808:	14f71663          	bne	a4,a5,ffffffffc020a954 <sfs_load_inode+0x22c>
ffffffffc020a80c:	0a093703          	ld	a4,160(s2)
ffffffffc020a810:	038a0793          	addi	a5,s4,56
ffffffffc020a814:	008a2503          	lw	a0,8(s4)
ffffffffc020a818:	e31c                	sd	a5,0(a4)
ffffffffc020a81a:	0af93023          	sd	a5,160(s2)
ffffffffc020a81e:	09890793          	addi	a5,s2,152
ffffffffc020a822:	0a893403          	ld	s0,168(s2)
ffffffffc020a826:	45a9                	li	a1,10
ffffffffc020a828:	04ea3023          	sd	a4,64(s4)
ffffffffc020a82c:	02fa3c23          	sd	a5,56(s4)
ffffffffc020a830:	003000ef          	jal	ra,ffffffffc020b032 <hash32>
ffffffffc020a834:	02051713          	slli	a4,a0,0x20
ffffffffc020a838:	01c75793          	srli	a5,a4,0x1c
ffffffffc020a83c:	97a2                	add	a5,a5,s0
ffffffffc020a83e:	6798                	ld	a4,8(a5)
ffffffffc020a840:	048a0693          	addi	a3,s4,72
ffffffffc020a844:	e314                	sd	a3,0(a4)
ffffffffc020a846:	e794                	sd	a3,8(a5)
ffffffffc020a848:	04ea3823          	sd	a4,80(s4)
ffffffffc020a84c:	04fa3423          	sd	a5,72(s4)
ffffffffc020a850:	854a                	mv	a0,s2
ffffffffc020a852:	7d0000ef          	jal	ra,ffffffffc020b022 <unlock_sfs_fs>
ffffffffc020a856:	4401                	li	s0,0
ffffffffc020a858:	0149b023          	sd	s4,0(s3)
ffffffffc020a85c:	70e2                	ld	ra,56(sp)
ffffffffc020a85e:	8522                	mv	a0,s0
ffffffffc020a860:	7442                	ld	s0,48(sp)
ffffffffc020a862:	74a2                	ld	s1,40(sp)
ffffffffc020a864:	7902                	ld	s2,32(sp)
ffffffffc020a866:	69e2                	ld	s3,24(sp)
ffffffffc020a868:	6a42                	ld	s4,16(sp)
ffffffffc020a86a:	6aa2                	ld	s5,8(sp)
ffffffffc020a86c:	6121                	addi	sp,sp,64
ffffffffc020a86e:	8082                	ret
ffffffffc020a870:	fb840a13          	addi	s4,s0,-72
ffffffffc020a874:	8552                	mv	a0,s4
ffffffffc020a876:	88efd0ef          	jal	ra,ffffffffc0207904 <inode_ref_inc>
ffffffffc020a87a:	4785                	li	a5,1
ffffffffc020a87c:	fcf51ae3          	bne	a0,a5,ffffffffc020a850 <sfs_load_inode+0x128>
ffffffffc020a880:	fd042783          	lw	a5,-48(s0)
ffffffffc020a884:	2785                	addiw	a5,a5,1
ffffffffc020a886:	fcf42823          	sw	a5,-48(s0)
ffffffffc020a88a:	b7d9                	j	ffffffffc020a850 <sfs_load_inode+0x128>
ffffffffc020a88c:	5471                	li	s0,-4
ffffffffc020a88e:	8556                	mv	a0,s5
ffffffffc020a890:	faef70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020a894:	854a                	mv	a0,s2
ffffffffc020a896:	78c000ef          	jal	ra,ffffffffc020b022 <unlock_sfs_fs>
ffffffffc020a89a:	b7c9                	j	ffffffffc020a85c <sfs_load_inode+0x134>
ffffffffc020a89c:	4789                	li	a5,2
ffffffffc020a89e:	08f69f63          	bne	a3,a5,ffffffffc020a93c <sfs_load_inode+0x214>
ffffffffc020a8a2:	864a                	mv	a2,s2
ffffffffc020a8a4:	00005597          	auipc	a1,0x5
ffffffffc020a8a8:	9ec58593          	addi	a1,a1,-1556 # ffffffffc020f290 <sfs_node_dirops>
ffffffffc020a8ac:	ff7fc0ef          	jal	ra,ffffffffc02078a2 <inode_init>
ffffffffc020a8b0:	058a2703          	lw	a4,88(s4)
ffffffffc020a8b4:	6785                	lui	a5,0x1
ffffffffc020a8b6:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a8ba:	f2f704e3          	beq	a4,a5,ffffffffc020a7e2 <sfs_load_inode+0xba>
ffffffffc020a8be:	00004697          	auipc	a3,0x4
ffffffffc020a8c2:	69a68693          	addi	a3,a3,1690 # ffffffffc020ef58 <dev_node_ops+0x588>
ffffffffc020a8c6:	00001617          	auipc	a2,0x1
ffffffffc020a8ca:	18260613          	addi	a2,a2,386 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a8ce:	07700593          	li	a1,119
ffffffffc020a8d2:	00004517          	auipc	a0,0x4
ffffffffc020a8d6:	6be50513          	addi	a0,a0,1726 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a8da:	bc5f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a8de:	5471                	li	s0,-4
ffffffffc020a8e0:	bf55                	j	ffffffffc020a894 <sfs_load_inode+0x16c>
ffffffffc020a8e2:	00005697          	auipc	a3,0x5
ffffffffc020a8e6:	93668693          	addi	a3,a3,-1738 # ffffffffc020f218 <dev_node_ops+0x848>
ffffffffc020a8ea:	00001617          	auipc	a2,0x1
ffffffffc020a8ee:	15e60613          	addi	a2,a2,350 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a8f2:	0ad00593          	li	a1,173
ffffffffc020a8f6:	00004517          	auipc	a0,0x4
ffffffffc020a8fa:	69a50513          	addi	a0,a0,1690 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a8fe:	ba1f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a902:	8726                	mv	a4,s1
ffffffffc020a904:	00004617          	auipc	a2,0x4
ffffffffc020a908:	6bc60613          	addi	a2,a2,1724 # ffffffffc020efc0 <dev_node_ops+0x5f0>
ffffffffc020a90c:	05300593          	li	a1,83
ffffffffc020a910:	00004517          	auipc	a0,0x4
ffffffffc020a914:	68050513          	addi	a0,a0,1664 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a918:	b87f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a91c:	00004697          	auipc	a3,0x4
ffffffffc020a920:	6dc68693          	addi	a3,a3,1756 # ffffffffc020eff8 <dev_node_ops+0x628>
ffffffffc020a924:	00001617          	auipc	a2,0x1
ffffffffc020a928:	12460613          	addi	a2,a2,292 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a92c:	0a800593          	li	a1,168
ffffffffc020a930:	00004517          	auipc	a0,0x4
ffffffffc020a934:	66050513          	addi	a0,a0,1632 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a938:	b67f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a93c:	00004617          	auipc	a2,0x4
ffffffffc020a940:	66c60613          	addi	a2,a2,1644 # ffffffffc020efa8 <dev_node_ops+0x5d8>
ffffffffc020a944:	02e00593          	li	a1,46
ffffffffc020a948:	00004517          	auipc	a0,0x4
ffffffffc020a94c:	64850513          	addi	a0,a0,1608 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a950:	b4ff50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020a954:	00004697          	auipc	a3,0x4
ffffffffc020a958:	60468693          	addi	a3,a3,1540 # ffffffffc020ef58 <dev_node_ops+0x588>
ffffffffc020a95c:	00001617          	auipc	a2,0x1
ffffffffc020a960:	0ec60613          	addi	a2,a2,236 # ffffffffc020ba48 <commands+0x210>
ffffffffc020a964:	0b100593          	li	a1,177
ffffffffc020a968:	00004517          	auipc	a0,0x4
ffffffffc020a96c:	62850513          	addi	a0,a0,1576 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020a970:	b2ff50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020a974 <sfs_lookup>:
ffffffffc020a974:	7139                	addi	sp,sp,-64
ffffffffc020a976:	ec4e                	sd	s3,24(sp)
ffffffffc020a978:	06853983          	ld	s3,104(a0)
ffffffffc020a97c:	fc06                	sd	ra,56(sp)
ffffffffc020a97e:	f822                	sd	s0,48(sp)
ffffffffc020a980:	f426                	sd	s1,40(sp)
ffffffffc020a982:	f04a                	sd	s2,32(sp)
ffffffffc020a984:	e852                	sd	s4,16(sp)
ffffffffc020a986:	0a098c63          	beqz	s3,ffffffffc020aa3e <sfs_lookup+0xca>
ffffffffc020a98a:	0b09a783          	lw	a5,176(s3)
ffffffffc020a98e:	ebc5                	bnez	a5,ffffffffc020aa3e <sfs_lookup+0xca>
ffffffffc020a990:	0005c783          	lbu	a5,0(a1)
ffffffffc020a994:	84ae                	mv	s1,a1
ffffffffc020a996:	c7c1                	beqz	a5,ffffffffc020aa1e <sfs_lookup+0xaa>
ffffffffc020a998:	02f00713          	li	a4,47
ffffffffc020a99c:	08e78163          	beq	a5,a4,ffffffffc020aa1e <sfs_lookup+0xaa>
ffffffffc020a9a0:	842a                	mv	s0,a0
ffffffffc020a9a2:	8a32                	mv	s4,a2
ffffffffc020a9a4:	f61fc0ef          	jal	ra,ffffffffc0207904 <inode_ref_inc>
ffffffffc020a9a8:	4c38                	lw	a4,88(s0)
ffffffffc020a9aa:	6785                	lui	a5,0x1
ffffffffc020a9ac:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020a9b0:	0af71763          	bne	a4,a5,ffffffffc020aa5e <sfs_lookup+0xea>
ffffffffc020a9b4:	6018                	ld	a4,0(s0)
ffffffffc020a9b6:	4789                	li	a5,2
ffffffffc020a9b8:	00475703          	lhu	a4,4(a4)
ffffffffc020a9bc:	04f71c63          	bne	a4,a5,ffffffffc020aa14 <sfs_lookup+0xa0>
ffffffffc020a9c0:	02040913          	addi	s2,s0,32
ffffffffc020a9c4:	854a                	mv	a0,s2
ffffffffc020a9c6:	b9ff90ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc020a9ca:	8626                	mv	a2,s1
ffffffffc020a9cc:	0054                	addi	a3,sp,4
ffffffffc020a9ce:	85a2                	mv	a1,s0
ffffffffc020a9d0:	854e                	mv	a0,s3
ffffffffc020a9d2:	a29ff0ef          	jal	ra,ffffffffc020a3fa <sfs_dirent_search_nolock.constprop.0>
ffffffffc020a9d6:	84aa                	mv	s1,a0
ffffffffc020a9d8:	854a                	mv	a0,s2
ffffffffc020a9da:	b87f90ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020a9de:	cc89                	beqz	s1,ffffffffc020a9f8 <sfs_lookup+0x84>
ffffffffc020a9e0:	8522                	mv	a0,s0
ffffffffc020a9e2:	ff1fc0ef          	jal	ra,ffffffffc02079d2 <inode_ref_dec>
ffffffffc020a9e6:	70e2                	ld	ra,56(sp)
ffffffffc020a9e8:	7442                	ld	s0,48(sp)
ffffffffc020a9ea:	7902                	ld	s2,32(sp)
ffffffffc020a9ec:	69e2                	ld	s3,24(sp)
ffffffffc020a9ee:	6a42                	ld	s4,16(sp)
ffffffffc020a9f0:	8526                	mv	a0,s1
ffffffffc020a9f2:	74a2                	ld	s1,40(sp)
ffffffffc020a9f4:	6121                	addi	sp,sp,64
ffffffffc020a9f6:	8082                	ret
ffffffffc020a9f8:	4612                	lw	a2,4(sp)
ffffffffc020a9fa:	002c                	addi	a1,sp,8
ffffffffc020a9fc:	854e                	mv	a0,s3
ffffffffc020a9fe:	d2bff0ef          	jal	ra,ffffffffc020a728 <sfs_load_inode>
ffffffffc020aa02:	84aa                	mv	s1,a0
ffffffffc020aa04:	8522                	mv	a0,s0
ffffffffc020aa06:	fcdfc0ef          	jal	ra,ffffffffc02079d2 <inode_ref_dec>
ffffffffc020aa0a:	fcf1                	bnez	s1,ffffffffc020a9e6 <sfs_lookup+0x72>
ffffffffc020aa0c:	67a2                	ld	a5,8(sp)
ffffffffc020aa0e:	00fa3023          	sd	a5,0(s4)
ffffffffc020aa12:	bfd1                	j	ffffffffc020a9e6 <sfs_lookup+0x72>
ffffffffc020aa14:	8522                	mv	a0,s0
ffffffffc020aa16:	fbdfc0ef          	jal	ra,ffffffffc02079d2 <inode_ref_dec>
ffffffffc020aa1a:	54b9                	li	s1,-18
ffffffffc020aa1c:	b7e9                	j	ffffffffc020a9e6 <sfs_lookup+0x72>
ffffffffc020aa1e:	00005697          	auipc	a3,0x5
ffffffffc020aa22:	81268693          	addi	a3,a3,-2030 # ffffffffc020f230 <dev_node_ops+0x860>
ffffffffc020aa26:	00001617          	auipc	a2,0x1
ffffffffc020aa2a:	02260613          	addi	a2,a2,34 # ffffffffc020ba48 <commands+0x210>
ffffffffc020aa2e:	44b00593          	li	a1,1099
ffffffffc020aa32:	00004517          	auipc	a0,0x4
ffffffffc020aa36:	55e50513          	addi	a0,a0,1374 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020aa3a:	a65f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020aa3e:	00004697          	auipc	a3,0x4
ffffffffc020aa42:	37268693          	addi	a3,a3,882 # ffffffffc020edb0 <dev_node_ops+0x3e0>
ffffffffc020aa46:	00001617          	auipc	a2,0x1
ffffffffc020aa4a:	00260613          	addi	a2,a2,2 # ffffffffc020ba48 <commands+0x210>
ffffffffc020aa4e:	44a00593          	li	a1,1098
ffffffffc020aa52:	00004517          	auipc	a0,0x4
ffffffffc020aa56:	53e50513          	addi	a0,a0,1342 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020aa5a:	a45f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020aa5e:	00004697          	auipc	a3,0x4
ffffffffc020aa62:	4fa68693          	addi	a3,a3,1274 # ffffffffc020ef58 <dev_node_ops+0x588>
ffffffffc020aa66:	00001617          	auipc	a2,0x1
ffffffffc020aa6a:	fe260613          	addi	a2,a2,-30 # ffffffffc020ba48 <commands+0x210>
ffffffffc020aa6e:	44d00593          	li	a1,1101
ffffffffc020aa72:	00004517          	auipc	a0,0x4
ffffffffc020aa76:	51e50513          	addi	a0,a0,1310 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020aa7a:	a25f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020aa7e <sfs_namefile>:
ffffffffc020aa7e:	6d98                	ld	a4,24(a1)
ffffffffc020aa80:	7175                	addi	sp,sp,-144
ffffffffc020aa82:	e506                	sd	ra,136(sp)
ffffffffc020aa84:	e122                	sd	s0,128(sp)
ffffffffc020aa86:	fca6                	sd	s1,120(sp)
ffffffffc020aa88:	f8ca                	sd	s2,112(sp)
ffffffffc020aa8a:	f4ce                	sd	s3,104(sp)
ffffffffc020aa8c:	f0d2                	sd	s4,96(sp)
ffffffffc020aa8e:	ecd6                	sd	s5,88(sp)
ffffffffc020aa90:	e8da                	sd	s6,80(sp)
ffffffffc020aa92:	e4de                	sd	s7,72(sp)
ffffffffc020aa94:	e0e2                	sd	s8,64(sp)
ffffffffc020aa96:	fc66                	sd	s9,56(sp)
ffffffffc020aa98:	f86a                	sd	s10,48(sp)
ffffffffc020aa9a:	f46e                	sd	s11,40(sp)
ffffffffc020aa9c:	e42e                	sd	a1,8(sp)
ffffffffc020aa9e:	4789                	li	a5,2
ffffffffc020aaa0:	1ae7f363          	bgeu	a5,a4,ffffffffc020ac46 <sfs_namefile+0x1c8>
ffffffffc020aaa4:	89aa                	mv	s3,a0
ffffffffc020aaa6:	10400513          	li	a0,260
ffffffffc020aaaa:	ce4f70ef          	jal	ra,ffffffffc0201f8e <kmalloc>
ffffffffc020aaae:	842a                	mv	s0,a0
ffffffffc020aab0:	18050b63          	beqz	a0,ffffffffc020ac46 <sfs_namefile+0x1c8>
ffffffffc020aab4:	0689b483          	ld	s1,104(s3)
ffffffffc020aab8:	1e048963          	beqz	s1,ffffffffc020acaa <sfs_namefile+0x22c>
ffffffffc020aabc:	0b04a783          	lw	a5,176(s1)
ffffffffc020aac0:	1e079563          	bnez	a5,ffffffffc020acaa <sfs_namefile+0x22c>
ffffffffc020aac4:	0589ac83          	lw	s9,88(s3)
ffffffffc020aac8:	6785                	lui	a5,0x1
ffffffffc020aaca:	23578793          	addi	a5,a5,565 # 1235 <_binary_bin_swap_img_size-0x6acb>
ffffffffc020aace:	1afc9e63          	bne	s9,a5,ffffffffc020ac8a <sfs_namefile+0x20c>
ffffffffc020aad2:	6722                	ld	a4,8(sp)
ffffffffc020aad4:	854e                	mv	a0,s3
ffffffffc020aad6:	8ace                	mv	s5,s3
ffffffffc020aad8:	6f1c                	ld	a5,24(a4)
ffffffffc020aada:	00073b03          	ld	s6,0(a4)
ffffffffc020aade:	02098a13          	addi	s4,s3,32
ffffffffc020aae2:	ffe78b93          	addi	s7,a5,-2
ffffffffc020aae6:	9b3e                	add	s6,s6,a5
ffffffffc020aae8:	00004d17          	auipc	s10,0x4
ffffffffc020aaec:	768d0d13          	addi	s10,s10,1896 # ffffffffc020f250 <dev_node_ops+0x880>
ffffffffc020aaf0:	e15fc0ef          	jal	ra,ffffffffc0207904 <inode_ref_inc>
ffffffffc020aaf4:	00440c13          	addi	s8,s0,4
ffffffffc020aaf8:	e066                	sd	s9,0(sp)
ffffffffc020aafa:	8552                	mv	a0,s4
ffffffffc020aafc:	a69f90ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc020ab00:	0854                	addi	a3,sp,20
ffffffffc020ab02:	866a                	mv	a2,s10
ffffffffc020ab04:	85d6                	mv	a1,s5
ffffffffc020ab06:	8526                	mv	a0,s1
ffffffffc020ab08:	8f3ff0ef          	jal	ra,ffffffffc020a3fa <sfs_dirent_search_nolock.constprop.0>
ffffffffc020ab0c:	8daa                	mv	s11,a0
ffffffffc020ab0e:	8552                	mv	a0,s4
ffffffffc020ab10:	a51f90ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020ab14:	020d8863          	beqz	s11,ffffffffc020ab44 <sfs_namefile+0xc6>
ffffffffc020ab18:	854e                	mv	a0,s3
ffffffffc020ab1a:	eb9fc0ef          	jal	ra,ffffffffc02079d2 <inode_ref_dec>
ffffffffc020ab1e:	8522                	mv	a0,s0
ffffffffc020ab20:	d1ef70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020ab24:	60aa                	ld	ra,136(sp)
ffffffffc020ab26:	640a                	ld	s0,128(sp)
ffffffffc020ab28:	74e6                	ld	s1,120(sp)
ffffffffc020ab2a:	7946                	ld	s2,112(sp)
ffffffffc020ab2c:	79a6                	ld	s3,104(sp)
ffffffffc020ab2e:	7a06                	ld	s4,96(sp)
ffffffffc020ab30:	6ae6                	ld	s5,88(sp)
ffffffffc020ab32:	6b46                	ld	s6,80(sp)
ffffffffc020ab34:	6ba6                	ld	s7,72(sp)
ffffffffc020ab36:	6c06                	ld	s8,64(sp)
ffffffffc020ab38:	7ce2                	ld	s9,56(sp)
ffffffffc020ab3a:	7d42                	ld	s10,48(sp)
ffffffffc020ab3c:	856e                	mv	a0,s11
ffffffffc020ab3e:	7da2                	ld	s11,40(sp)
ffffffffc020ab40:	6149                	addi	sp,sp,144
ffffffffc020ab42:	8082                	ret
ffffffffc020ab44:	4652                	lw	a2,20(sp)
ffffffffc020ab46:	082c                	addi	a1,sp,24
ffffffffc020ab48:	8526                	mv	a0,s1
ffffffffc020ab4a:	bdfff0ef          	jal	ra,ffffffffc020a728 <sfs_load_inode>
ffffffffc020ab4e:	8daa                	mv	s11,a0
ffffffffc020ab50:	f561                	bnez	a0,ffffffffc020ab18 <sfs_namefile+0x9a>
ffffffffc020ab52:	854e                	mv	a0,s3
ffffffffc020ab54:	008aa903          	lw	s2,8(s5)
ffffffffc020ab58:	e7bfc0ef          	jal	ra,ffffffffc02079d2 <inode_ref_dec>
ffffffffc020ab5c:	6ce2                	ld	s9,24(sp)
ffffffffc020ab5e:	0b3c8463          	beq	s9,s3,ffffffffc020ac06 <sfs_namefile+0x188>
ffffffffc020ab62:	100c8463          	beqz	s9,ffffffffc020ac6a <sfs_namefile+0x1ec>
ffffffffc020ab66:	058ca703          	lw	a4,88(s9)
ffffffffc020ab6a:	6782                	ld	a5,0(sp)
ffffffffc020ab6c:	0ef71f63          	bne	a4,a5,ffffffffc020ac6a <sfs_namefile+0x1ec>
ffffffffc020ab70:	008ca703          	lw	a4,8(s9)
ffffffffc020ab74:	8ae6                	mv	s5,s9
ffffffffc020ab76:	0d270a63          	beq	a4,s2,ffffffffc020ac4a <sfs_namefile+0x1cc>
ffffffffc020ab7a:	000cb703          	ld	a4,0(s9)
ffffffffc020ab7e:	4789                	li	a5,2
ffffffffc020ab80:	00475703          	lhu	a4,4(a4)
ffffffffc020ab84:	0cf71363          	bne	a4,a5,ffffffffc020ac4a <sfs_namefile+0x1cc>
ffffffffc020ab88:	020c8a13          	addi	s4,s9,32
ffffffffc020ab8c:	8552                	mv	a0,s4
ffffffffc020ab8e:	9d7f90ef          	jal	ra,ffffffffc0204564 <down>
ffffffffc020ab92:	000cb703          	ld	a4,0(s9)
ffffffffc020ab96:	00872983          	lw	s3,8(a4)
ffffffffc020ab9a:	01304963          	bgtz	s3,ffffffffc020abac <sfs_namefile+0x12e>
ffffffffc020ab9e:	a899                	j	ffffffffc020abf4 <sfs_namefile+0x176>
ffffffffc020aba0:	4018                	lw	a4,0(s0)
ffffffffc020aba2:	01270e63          	beq	a4,s2,ffffffffc020abbe <sfs_namefile+0x140>
ffffffffc020aba6:	2d85                	addiw	s11,s11,1
ffffffffc020aba8:	05b98663          	beq	s3,s11,ffffffffc020abf4 <sfs_namefile+0x176>
ffffffffc020abac:	86a2                	mv	a3,s0
ffffffffc020abae:	866e                	mv	a2,s11
ffffffffc020abb0:	85e6                	mv	a1,s9
ffffffffc020abb2:	8526                	mv	a0,s1
ffffffffc020abb4:	e48ff0ef          	jal	ra,ffffffffc020a1fc <sfs_dirent_read_nolock>
ffffffffc020abb8:	872a                	mv	a4,a0
ffffffffc020abba:	d17d                	beqz	a0,ffffffffc020aba0 <sfs_namefile+0x122>
ffffffffc020abbc:	a82d                	j	ffffffffc020abf6 <sfs_namefile+0x178>
ffffffffc020abbe:	8552                	mv	a0,s4
ffffffffc020abc0:	9a1f90ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020abc4:	8562                	mv	a0,s8
ffffffffc020abc6:	0ff000ef          	jal	ra,ffffffffc020b4c4 <strlen>
ffffffffc020abca:	00150793          	addi	a5,a0,1
ffffffffc020abce:	862a                	mv	a2,a0
ffffffffc020abd0:	06fbe863          	bltu	s7,a5,ffffffffc020ac40 <sfs_namefile+0x1c2>
ffffffffc020abd4:	fff64913          	not	s2,a2
ffffffffc020abd8:	995a                	add	s2,s2,s6
ffffffffc020abda:	85e2                	mv	a1,s8
ffffffffc020abdc:	854a                	mv	a0,s2
ffffffffc020abde:	40fb8bb3          	sub	s7,s7,a5
ffffffffc020abe2:	1d7000ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc020abe6:	02f00793          	li	a5,47
ffffffffc020abea:	fefb0fa3          	sb	a5,-1(s6)
ffffffffc020abee:	89e6                	mv	s3,s9
ffffffffc020abf0:	8b4a                	mv	s6,s2
ffffffffc020abf2:	b721                	j	ffffffffc020aafa <sfs_namefile+0x7c>
ffffffffc020abf4:	5741                	li	a4,-16
ffffffffc020abf6:	8552                	mv	a0,s4
ffffffffc020abf8:	e03a                	sd	a4,0(sp)
ffffffffc020abfa:	967f90ef          	jal	ra,ffffffffc0204560 <up>
ffffffffc020abfe:	6702                	ld	a4,0(sp)
ffffffffc020ac00:	89e6                	mv	s3,s9
ffffffffc020ac02:	8dba                	mv	s11,a4
ffffffffc020ac04:	bf11                	j	ffffffffc020ab18 <sfs_namefile+0x9a>
ffffffffc020ac06:	854e                	mv	a0,s3
ffffffffc020ac08:	dcbfc0ef          	jal	ra,ffffffffc02079d2 <inode_ref_dec>
ffffffffc020ac0c:	64a2                	ld	s1,8(sp)
ffffffffc020ac0e:	85da                	mv	a1,s6
ffffffffc020ac10:	6c98                	ld	a4,24(s1)
ffffffffc020ac12:	6088                	ld	a0,0(s1)
ffffffffc020ac14:	1779                	addi	a4,a4,-2
ffffffffc020ac16:	41770bb3          	sub	s7,a4,s7
ffffffffc020ac1a:	865e                	mv	a2,s7
ffffffffc020ac1c:	0505                	addi	a0,a0,1
ffffffffc020ac1e:	15b000ef          	jal	ra,ffffffffc020b578 <memmove>
ffffffffc020ac22:	02f00713          	li	a4,47
ffffffffc020ac26:	fee50fa3          	sb	a4,-1(a0)
ffffffffc020ac2a:	955e                	add	a0,a0,s7
ffffffffc020ac2c:	00050023          	sb	zero,0(a0)
ffffffffc020ac30:	85de                	mv	a1,s7
ffffffffc020ac32:	8526                	mv	a0,s1
ffffffffc020ac34:	825fa0ef          	jal	ra,ffffffffc0205458 <iobuf_skip>
ffffffffc020ac38:	8522                	mv	a0,s0
ffffffffc020ac3a:	c04f70ef          	jal	ra,ffffffffc020203e <kfree>
ffffffffc020ac3e:	b5dd                	j	ffffffffc020ab24 <sfs_namefile+0xa6>
ffffffffc020ac40:	89e6                	mv	s3,s9
ffffffffc020ac42:	5df1                	li	s11,-4
ffffffffc020ac44:	bdd1                	j	ffffffffc020ab18 <sfs_namefile+0x9a>
ffffffffc020ac46:	5df1                	li	s11,-4
ffffffffc020ac48:	bdf1                	j	ffffffffc020ab24 <sfs_namefile+0xa6>
ffffffffc020ac4a:	00004697          	auipc	a3,0x4
ffffffffc020ac4e:	60e68693          	addi	a3,a3,1550 # ffffffffc020f258 <dev_node_ops+0x888>
ffffffffc020ac52:	00001617          	auipc	a2,0x1
ffffffffc020ac56:	df660613          	addi	a2,a2,-522 # ffffffffc020ba48 <commands+0x210>
ffffffffc020ac5a:	36900593          	li	a1,873
ffffffffc020ac5e:	00004517          	auipc	a0,0x4
ffffffffc020ac62:	33250513          	addi	a0,a0,818 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020ac66:	839f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020ac6a:	00004697          	auipc	a3,0x4
ffffffffc020ac6e:	2ee68693          	addi	a3,a3,750 # ffffffffc020ef58 <dev_node_ops+0x588>
ffffffffc020ac72:	00001617          	auipc	a2,0x1
ffffffffc020ac76:	dd660613          	addi	a2,a2,-554 # ffffffffc020ba48 <commands+0x210>
ffffffffc020ac7a:	36800593          	li	a1,872
ffffffffc020ac7e:	00004517          	auipc	a0,0x4
ffffffffc020ac82:	31250513          	addi	a0,a0,786 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020ac86:	819f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020ac8a:	00004697          	auipc	a3,0x4
ffffffffc020ac8e:	2ce68693          	addi	a3,a3,718 # ffffffffc020ef58 <dev_node_ops+0x588>
ffffffffc020ac92:	00001617          	auipc	a2,0x1
ffffffffc020ac96:	db660613          	addi	a2,a2,-586 # ffffffffc020ba48 <commands+0x210>
ffffffffc020ac9a:	35500593          	li	a1,853
ffffffffc020ac9e:	00004517          	auipc	a0,0x4
ffffffffc020aca2:	2f250513          	addi	a0,a0,754 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020aca6:	ff8f50ef          	jal	ra,ffffffffc020049e <__panic>
ffffffffc020acaa:	00004697          	auipc	a3,0x4
ffffffffc020acae:	10668693          	addi	a3,a3,262 # ffffffffc020edb0 <dev_node_ops+0x3e0>
ffffffffc020acb2:	00001617          	auipc	a2,0x1
ffffffffc020acb6:	d9660613          	addi	a2,a2,-618 # ffffffffc020ba48 <commands+0x210>
ffffffffc020acba:	35400593          	li	a1,852
ffffffffc020acbe:	00004517          	auipc	a0,0x4
ffffffffc020acc2:	2d250513          	addi	a0,a0,722 # ffffffffc020ef90 <dev_node_ops+0x5c0>
ffffffffc020acc6:	fd8f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020acca <sfs_rwblock_nolock>:
ffffffffc020acca:	7139                	addi	sp,sp,-64
ffffffffc020accc:	f822                	sd	s0,48(sp)
ffffffffc020acce:	f426                	sd	s1,40(sp)
ffffffffc020acd0:	fc06                	sd	ra,56(sp)
ffffffffc020acd2:	842a                	mv	s0,a0
ffffffffc020acd4:	84b6                	mv	s1,a3
ffffffffc020acd6:	e211                	bnez	a2,ffffffffc020acda <sfs_rwblock_nolock+0x10>
ffffffffc020acd8:	e715                	bnez	a4,ffffffffc020ad04 <sfs_rwblock_nolock+0x3a>
ffffffffc020acda:	405c                	lw	a5,4(s0)
ffffffffc020acdc:	02f67463          	bgeu	a2,a5,ffffffffc020ad04 <sfs_rwblock_nolock+0x3a>
ffffffffc020ace0:	00c6169b          	slliw	a3,a2,0xc
ffffffffc020ace4:	1682                	slli	a3,a3,0x20
ffffffffc020ace6:	6605                	lui	a2,0x1
ffffffffc020ace8:	9281                	srli	a3,a3,0x20
ffffffffc020acea:	850a                	mv	a0,sp
ffffffffc020acec:	ef6fa0ef          	jal	ra,ffffffffc02053e2 <iobuf_init>
ffffffffc020acf0:	85aa                	mv	a1,a0
ffffffffc020acf2:	7808                	ld	a0,48(s0)
ffffffffc020acf4:	8626                	mv	a2,s1
ffffffffc020acf6:	7118                	ld	a4,32(a0)
ffffffffc020acf8:	9702                	jalr	a4
ffffffffc020acfa:	70e2                	ld	ra,56(sp)
ffffffffc020acfc:	7442                	ld	s0,48(sp)
ffffffffc020acfe:	74a2                	ld	s1,40(sp)
ffffffffc020ad00:	6121                	addi	sp,sp,64
ffffffffc020ad02:	8082                	ret
ffffffffc020ad04:	00004697          	auipc	a3,0x4
ffffffffc020ad08:	68c68693          	addi	a3,a3,1676 # ffffffffc020f390 <sfs_node_fileops+0x80>
ffffffffc020ad0c:	00001617          	auipc	a2,0x1
ffffffffc020ad10:	d3c60613          	addi	a2,a2,-708 # ffffffffc020ba48 <commands+0x210>
ffffffffc020ad14:	45d5                	li	a1,21
ffffffffc020ad16:	00004517          	auipc	a0,0x4
ffffffffc020ad1a:	6b250513          	addi	a0,a0,1714 # ffffffffc020f3c8 <sfs_node_fileops+0xb8>
ffffffffc020ad1e:	f80f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ad22 <sfs_rblock>:
ffffffffc020ad22:	7139                	addi	sp,sp,-64
ffffffffc020ad24:	ec4e                	sd	s3,24(sp)
ffffffffc020ad26:	89b6                	mv	s3,a3
ffffffffc020ad28:	f822                	sd	s0,48(sp)
ffffffffc020ad2a:	f04a                	sd	s2,32(sp)
ffffffffc020ad2c:	e852                	sd	s4,16(sp)
ffffffffc020ad2e:	fc06                	sd	ra,56(sp)
ffffffffc020ad30:	f426                	sd	s1,40(sp)
ffffffffc020ad32:	e456                	sd	s5,8(sp)
ffffffffc020ad34:	8a2a                	mv	s4,a0
ffffffffc020ad36:	892e                	mv	s2,a1
ffffffffc020ad38:	8432                	mv	s0,a2
ffffffffc020ad3a:	2e0000ef          	jal	ra,ffffffffc020b01a <lock_sfs_io>
ffffffffc020ad3e:	04098063          	beqz	s3,ffffffffc020ad7e <sfs_rblock+0x5c>
ffffffffc020ad42:	013409bb          	addw	s3,s0,s3
ffffffffc020ad46:	6a85                	lui	s5,0x1
ffffffffc020ad48:	a021                	j	ffffffffc020ad50 <sfs_rblock+0x2e>
ffffffffc020ad4a:	9956                	add	s2,s2,s5
ffffffffc020ad4c:	02898963          	beq	s3,s0,ffffffffc020ad7e <sfs_rblock+0x5c>
ffffffffc020ad50:	8622                	mv	a2,s0
ffffffffc020ad52:	85ca                	mv	a1,s2
ffffffffc020ad54:	4705                	li	a4,1
ffffffffc020ad56:	4681                	li	a3,0
ffffffffc020ad58:	8552                	mv	a0,s4
ffffffffc020ad5a:	f71ff0ef          	jal	ra,ffffffffc020acca <sfs_rwblock_nolock>
ffffffffc020ad5e:	84aa                	mv	s1,a0
ffffffffc020ad60:	2405                	addiw	s0,s0,1
ffffffffc020ad62:	d565                	beqz	a0,ffffffffc020ad4a <sfs_rblock+0x28>
ffffffffc020ad64:	8552                	mv	a0,s4
ffffffffc020ad66:	2c4000ef          	jal	ra,ffffffffc020b02a <unlock_sfs_io>
ffffffffc020ad6a:	70e2                	ld	ra,56(sp)
ffffffffc020ad6c:	7442                	ld	s0,48(sp)
ffffffffc020ad6e:	7902                	ld	s2,32(sp)
ffffffffc020ad70:	69e2                	ld	s3,24(sp)
ffffffffc020ad72:	6a42                	ld	s4,16(sp)
ffffffffc020ad74:	6aa2                	ld	s5,8(sp)
ffffffffc020ad76:	8526                	mv	a0,s1
ffffffffc020ad78:	74a2                	ld	s1,40(sp)
ffffffffc020ad7a:	6121                	addi	sp,sp,64
ffffffffc020ad7c:	8082                	ret
ffffffffc020ad7e:	4481                	li	s1,0
ffffffffc020ad80:	b7d5                	j	ffffffffc020ad64 <sfs_rblock+0x42>

ffffffffc020ad82 <sfs_wblock>:
ffffffffc020ad82:	7139                	addi	sp,sp,-64
ffffffffc020ad84:	ec4e                	sd	s3,24(sp)
ffffffffc020ad86:	89b6                	mv	s3,a3
ffffffffc020ad88:	f822                	sd	s0,48(sp)
ffffffffc020ad8a:	f04a                	sd	s2,32(sp)
ffffffffc020ad8c:	e852                	sd	s4,16(sp)
ffffffffc020ad8e:	fc06                	sd	ra,56(sp)
ffffffffc020ad90:	f426                	sd	s1,40(sp)
ffffffffc020ad92:	e456                	sd	s5,8(sp)
ffffffffc020ad94:	8a2a                	mv	s4,a0
ffffffffc020ad96:	892e                	mv	s2,a1
ffffffffc020ad98:	8432                	mv	s0,a2
ffffffffc020ad9a:	280000ef          	jal	ra,ffffffffc020b01a <lock_sfs_io>
ffffffffc020ad9e:	04098063          	beqz	s3,ffffffffc020adde <sfs_wblock+0x5c>
ffffffffc020ada2:	013409bb          	addw	s3,s0,s3
ffffffffc020ada6:	6a85                	lui	s5,0x1
ffffffffc020ada8:	a021                	j	ffffffffc020adb0 <sfs_wblock+0x2e>
ffffffffc020adaa:	9956                	add	s2,s2,s5
ffffffffc020adac:	02898963          	beq	s3,s0,ffffffffc020adde <sfs_wblock+0x5c>
ffffffffc020adb0:	8622                	mv	a2,s0
ffffffffc020adb2:	85ca                	mv	a1,s2
ffffffffc020adb4:	4705                	li	a4,1
ffffffffc020adb6:	4685                	li	a3,1
ffffffffc020adb8:	8552                	mv	a0,s4
ffffffffc020adba:	f11ff0ef          	jal	ra,ffffffffc020acca <sfs_rwblock_nolock>
ffffffffc020adbe:	84aa                	mv	s1,a0
ffffffffc020adc0:	2405                	addiw	s0,s0,1
ffffffffc020adc2:	d565                	beqz	a0,ffffffffc020adaa <sfs_wblock+0x28>
ffffffffc020adc4:	8552                	mv	a0,s4
ffffffffc020adc6:	264000ef          	jal	ra,ffffffffc020b02a <unlock_sfs_io>
ffffffffc020adca:	70e2                	ld	ra,56(sp)
ffffffffc020adcc:	7442                	ld	s0,48(sp)
ffffffffc020adce:	7902                	ld	s2,32(sp)
ffffffffc020add0:	69e2                	ld	s3,24(sp)
ffffffffc020add2:	6a42                	ld	s4,16(sp)
ffffffffc020add4:	6aa2                	ld	s5,8(sp)
ffffffffc020add6:	8526                	mv	a0,s1
ffffffffc020add8:	74a2                	ld	s1,40(sp)
ffffffffc020adda:	6121                	addi	sp,sp,64
ffffffffc020addc:	8082                	ret
ffffffffc020adde:	4481                	li	s1,0
ffffffffc020ade0:	b7d5                	j	ffffffffc020adc4 <sfs_wblock+0x42>

ffffffffc020ade2 <sfs_rbuf>:
ffffffffc020ade2:	7179                	addi	sp,sp,-48
ffffffffc020ade4:	f406                	sd	ra,40(sp)
ffffffffc020ade6:	f022                	sd	s0,32(sp)
ffffffffc020ade8:	ec26                	sd	s1,24(sp)
ffffffffc020adea:	e84a                	sd	s2,16(sp)
ffffffffc020adec:	e44e                	sd	s3,8(sp)
ffffffffc020adee:	e052                	sd	s4,0(sp)
ffffffffc020adf0:	6785                	lui	a5,0x1
ffffffffc020adf2:	04f77863          	bgeu	a4,a5,ffffffffc020ae42 <sfs_rbuf+0x60>
ffffffffc020adf6:	84ba                	mv	s1,a4
ffffffffc020adf8:	9732                	add	a4,a4,a2
ffffffffc020adfa:	89b2                	mv	s3,a2
ffffffffc020adfc:	04e7e363          	bltu	a5,a4,ffffffffc020ae42 <sfs_rbuf+0x60>
ffffffffc020ae00:	8936                	mv	s2,a3
ffffffffc020ae02:	842a                	mv	s0,a0
ffffffffc020ae04:	8a2e                	mv	s4,a1
ffffffffc020ae06:	214000ef          	jal	ra,ffffffffc020b01a <lock_sfs_io>
ffffffffc020ae0a:	642c                	ld	a1,72(s0)
ffffffffc020ae0c:	864a                	mv	a2,s2
ffffffffc020ae0e:	4705                	li	a4,1
ffffffffc020ae10:	4681                	li	a3,0
ffffffffc020ae12:	8522                	mv	a0,s0
ffffffffc020ae14:	eb7ff0ef          	jal	ra,ffffffffc020acca <sfs_rwblock_nolock>
ffffffffc020ae18:	892a                	mv	s2,a0
ffffffffc020ae1a:	cd09                	beqz	a0,ffffffffc020ae34 <sfs_rbuf+0x52>
ffffffffc020ae1c:	8522                	mv	a0,s0
ffffffffc020ae1e:	20c000ef          	jal	ra,ffffffffc020b02a <unlock_sfs_io>
ffffffffc020ae22:	70a2                	ld	ra,40(sp)
ffffffffc020ae24:	7402                	ld	s0,32(sp)
ffffffffc020ae26:	64e2                	ld	s1,24(sp)
ffffffffc020ae28:	69a2                	ld	s3,8(sp)
ffffffffc020ae2a:	6a02                	ld	s4,0(sp)
ffffffffc020ae2c:	854a                	mv	a0,s2
ffffffffc020ae2e:	6942                	ld	s2,16(sp)
ffffffffc020ae30:	6145                	addi	sp,sp,48
ffffffffc020ae32:	8082                	ret
ffffffffc020ae34:	642c                	ld	a1,72(s0)
ffffffffc020ae36:	864e                	mv	a2,s3
ffffffffc020ae38:	8552                	mv	a0,s4
ffffffffc020ae3a:	95a6                	add	a1,a1,s1
ffffffffc020ae3c:	77c000ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc020ae40:	bff1                	j	ffffffffc020ae1c <sfs_rbuf+0x3a>
ffffffffc020ae42:	00004697          	auipc	a3,0x4
ffffffffc020ae46:	59e68693          	addi	a3,a3,1438 # ffffffffc020f3e0 <sfs_node_fileops+0xd0>
ffffffffc020ae4a:	00001617          	auipc	a2,0x1
ffffffffc020ae4e:	bfe60613          	addi	a2,a2,-1026 # ffffffffc020ba48 <commands+0x210>
ffffffffc020ae52:	05500593          	li	a1,85
ffffffffc020ae56:	00004517          	auipc	a0,0x4
ffffffffc020ae5a:	57250513          	addi	a0,a0,1394 # ffffffffc020f3c8 <sfs_node_fileops+0xb8>
ffffffffc020ae5e:	e40f50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020ae62 <sfs_wbuf>:
ffffffffc020ae62:	7139                	addi	sp,sp,-64
ffffffffc020ae64:	fc06                	sd	ra,56(sp)
ffffffffc020ae66:	f822                	sd	s0,48(sp)
ffffffffc020ae68:	f426                	sd	s1,40(sp)
ffffffffc020ae6a:	f04a                	sd	s2,32(sp)
ffffffffc020ae6c:	ec4e                	sd	s3,24(sp)
ffffffffc020ae6e:	e852                	sd	s4,16(sp)
ffffffffc020ae70:	e456                	sd	s5,8(sp)
ffffffffc020ae72:	6785                	lui	a5,0x1
ffffffffc020ae74:	06f77163          	bgeu	a4,a5,ffffffffc020aed6 <sfs_wbuf+0x74>
ffffffffc020ae78:	893a                	mv	s2,a4
ffffffffc020ae7a:	9732                	add	a4,a4,a2
ffffffffc020ae7c:	8a32                	mv	s4,a2
ffffffffc020ae7e:	04e7ec63          	bltu	a5,a4,ffffffffc020aed6 <sfs_wbuf+0x74>
ffffffffc020ae82:	842a                	mv	s0,a0
ffffffffc020ae84:	89b6                	mv	s3,a3
ffffffffc020ae86:	8aae                	mv	s5,a1
ffffffffc020ae88:	192000ef          	jal	ra,ffffffffc020b01a <lock_sfs_io>
ffffffffc020ae8c:	642c                	ld	a1,72(s0)
ffffffffc020ae8e:	4705                	li	a4,1
ffffffffc020ae90:	4681                	li	a3,0
ffffffffc020ae92:	864e                	mv	a2,s3
ffffffffc020ae94:	8522                	mv	a0,s0
ffffffffc020ae96:	e35ff0ef          	jal	ra,ffffffffc020acca <sfs_rwblock_nolock>
ffffffffc020ae9a:	84aa                	mv	s1,a0
ffffffffc020ae9c:	cd11                	beqz	a0,ffffffffc020aeb8 <sfs_wbuf+0x56>
ffffffffc020ae9e:	8522                	mv	a0,s0
ffffffffc020aea0:	18a000ef          	jal	ra,ffffffffc020b02a <unlock_sfs_io>
ffffffffc020aea4:	70e2                	ld	ra,56(sp)
ffffffffc020aea6:	7442                	ld	s0,48(sp)
ffffffffc020aea8:	7902                	ld	s2,32(sp)
ffffffffc020aeaa:	69e2                	ld	s3,24(sp)
ffffffffc020aeac:	6a42                	ld	s4,16(sp)
ffffffffc020aeae:	6aa2                	ld	s5,8(sp)
ffffffffc020aeb0:	8526                	mv	a0,s1
ffffffffc020aeb2:	74a2                	ld	s1,40(sp)
ffffffffc020aeb4:	6121                	addi	sp,sp,64
ffffffffc020aeb6:	8082                	ret
ffffffffc020aeb8:	6428                	ld	a0,72(s0)
ffffffffc020aeba:	8652                	mv	a2,s4
ffffffffc020aebc:	85d6                	mv	a1,s5
ffffffffc020aebe:	954a                	add	a0,a0,s2
ffffffffc020aec0:	6f8000ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc020aec4:	642c                	ld	a1,72(s0)
ffffffffc020aec6:	4705                	li	a4,1
ffffffffc020aec8:	4685                	li	a3,1
ffffffffc020aeca:	864e                	mv	a2,s3
ffffffffc020aecc:	8522                	mv	a0,s0
ffffffffc020aece:	dfdff0ef          	jal	ra,ffffffffc020acca <sfs_rwblock_nolock>
ffffffffc020aed2:	84aa                	mv	s1,a0
ffffffffc020aed4:	b7e9                	j	ffffffffc020ae9e <sfs_wbuf+0x3c>
ffffffffc020aed6:	00004697          	auipc	a3,0x4
ffffffffc020aeda:	50a68693          	addi	a3,a3,1290 # ffffffffc020f3e0 <sfs_node_fileops+0xd0>
ffffffffc020aede:	00001617          	auipc	a2,0x1
ffffffffc020aee2:	b6a60613          	addi	a2,a2,-1174 # ffffffffc020ba48 <commands+0x210>
ffffffffc020aee6:	06b00593          	li	a1,107
ffffffffc020aeea:	00004517          	auipc	a0,0x4
ffffffffc020aeee:	4de50513          	addi	a0,a0,1246 # ffffffffc020f3c8 <sfs_node_fileops+0xb8>
ffffffffc020aef2:	dacf50ef          	jal	ra,ffffffffc020049e <__panic>

ffffffffc020aef6 <sfs_sync_super>:
ffffffffc020aef6:	1101                	addi	sp,sp,-32
ffffffffc020aef8:	ec06                	sd	ra,24(sp)
ffffffffc020aefa:	e822                	sd	s0,16(sp)
ffffffffc020aefc:	e426                	sd	s1,8(sp)
ffffffffc020aefe:	842a                	mv	s0,a0
ffffffffc020af00:	11a000ef          	jal	ra,ffffffffc020b01a <lock_sfs_io>
ffffffffc020af04:	6428                	ld	a0,72(s0)
ffffffffc020af06:	6605                	lui	a2,0x1
ffffffffc020af08:	4581                	li	a1,0
ffffffffc020af0a:	65c000ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc020af0e:	6428                	ld	a0,72(s0)
ffffffffc020af10:	85a2                	mv	a1,s0
ffffffffc020af12:	02c00613          	li	a2,44
ffffffffc020af16:	6a2000ef          	jal	ra,ffffffffc020b5b8 <memcpy>
ffffffffc020af1a:	642c                	ld	a1,72(s0)
ffffffffc020af1c:	4701                	li	a4,0
ffffffffc020af1e:	4685                	li	a3,1
ffffffffc020af20:	4601                	li	a2,0
ffffffffc020af22:	8522                	mv	a0,s0
ffffffffc020af24:	da7ff0ef          	jal	ra,ffffffffc020acca <sfs_rwblock_nolock>
ffffffffc020af28:	84aa                	mv	s1,a0
ffffffffc020af2a:	8522                	mv	a0,s0
ffffffffc020af2c:	0fe000ef          	jal	ra,ffffffffc020b02a <unlock_sfs_io>
ffffffffc020af30:	60e2                	ld	ra,24(sp)
ffffffffc020af32:	6442                	ld	s0,16(sp)
ffffffffc020af34:	8526                	mv	a0,s1
ffffffffc020af36:	64a2                	ld	s1,8(sp)
ffffffffc020af38:	6105                	addi	sp,sp,32
ffffffffc020af3a:	8082                	ret

ffffffffc020af3c <sfs_sync_freemap>:
ffffffffc020af3c:	7139                	addi	sp,sp,-64
ffffffffc020af3e:	ec4e                	sd	s3,24(sp)
ffffffffc020af40:	e852                	sd	s4,16(sp)
ffffffffc020af42:	00456983          	lwu	s3,4(a0)
ffffffffc020af46:	8a2a                	mv	s4,a0
ffffffffc020af48:	7d08                	ld	a0,56(a0)
ffffffffc020af4a:	67a1                	lui	a5,0x8
ffffffffc020af4c:	17fd                	addi	a5,a5,-1
ffffffffc020af4e:	4581                	li	a1,0
ffffffffc020af50:	f822                	sd	s0,48(sp)
ffffffffc020af52:	fc06                	sd	ra,56(sp)
ffffffffc020af54:	f426                	sd	s1,40(sp)
ffffffffc020af56:	f04a                	sd	s2,32(sp)
ffffffffc020af58:	e456                	sd	s5,8(sp)
ffffffffc020af5a:	99be                	add	s3,s3,a5
ffffffffc020af5c:	a04fe0ef          	jal	ra,ffffffffc0209160 <bitmap_getdata>
ffffffffc020af60:	00f9d993          	srli	s3,s3,0xf
ffffffffc020af64:	842a                	mv	s0,a0
ffffffffc020af66:	8552                	mv	a0,s4
ffffffffc020af68:	0b2000ef          	jal	ra,ffffffffc020b01a <lock_sfs_io>
ffffffffc020af6c:	04098163          	beqz	s3,ffffffffc020afae <sfs_sync_freemap+0x72>
ffffffffc020af70:	09b2                	slli	s3,s3,0xc
ffffffffc020af72:	99a2                	add	s3,s3,s0
ffffffffc020af74:	4909                	li	s2,2
ffffffffc020af76:	6a85                	lui	s5,0x1
ffffffffc020af78:	a021                	j	ffffffffc020af80 <sfs_sync_freemap+0x44>
ffffffffc020af7a:	2905                	addiw	s2,s2,1
ffffffffc020af7c:	02898963          	beq	s3,s0,ffffffffc020afae <sfs_sync_freemap+0x72>
ffffffffc020af80:	85a2                	mv	a1,s0
ffffffffc020af82:	864a                	mv	a2,s2
ffffffffc020af84:	4705                	li	a4,1
ffffffffc020af86:	4685                	li	a3,1
ffffffffc020af88:	8552                	mv	a0,s4
ffffffffc020af8a:	d41ff0ef          	jal	ra,ffffffffc020acca <sfs_rwblock_nolock>
ffffffffc020af8e:	84aa                	mv	s1,a0
ffffffffc020af90:	9456                	add	s0,s0,s5
ffffffffc020af92:	d565                	beqz	a0,ffffffffc020af7a <sfs_sync_freemap+0x3e>
ffffffffc020af94:	8552                	mv	a0,s4
ffffffffc020af96:	094000ef          	jal	ra,ffffffffc020b02a <unlock_sfs_io>
ffffffffc020af9a:	70e2                	ld	ra,56(sp)
ffffffffc020af9c:	7442                	ld	s0,48(sp)
ffffffffc020af9e:	7902                	ld	s2,32(sp)
ffffffffc020afa0:	69e2                	ld	s3,24(sp)
ffffffffc020afa2:	6a42                	ld	s4,16(sp)
ffffffffc020afa4:	6aa2                	ld	s5,8(sp)
ffffffffc020afa6:	8526                	mv	a0,s1
ffffffffc020afa8:	74a2                	ld	s1,40(sp)
ffffffffc020afaa:	6121                	addi	sp,sp,64
ffffffffc020afac:	8082                	ret
ffffffffc020afae:	4481                	li	s1,0
ffffffffc020afb0:	b7d5                	j	ffffffffc020af94 <sfs_sync_freemap+0x58>

ffffffffc020afb2 <sfs_clear_block>:
ffffffffc020afb2:	7179                	addi	sp,sp,-48
ffffffffc020afb4:	f022                	sd	s0,32(sp)
ffffffffc020afb6:	e84a                	sd	s2,16(sp)
ffffffffc020afb8:	e44e                	sd	s3,8(sp)
ffffffffc020afba:	f406                	sd	ra,40(sp)
ffffffffc020afbc:	89b2                	mv	s3,a2
ffffffffc020afbe:	ec26                	sd	s1,24(sp)
ffffffffc020afc0:	892a                	mv	s2,a0
ffffffffc020afc2:	842e                	mv	s0,a1
ffffffffc020afc4:	056000ef          	jal	ra,ffffffffc020b01a <lock_sfs_io>
ffffffffc020afc8:	04893503          	ld	a0,72(s2)
ffffffffc020afcc:	6605                	lui	a2,0x1
ffffffffc020afce:	4581                	li	a1,0
ffffffffc020afd0:	596000ef          	jal	ra,ffffffffc020b566 <memset>
ffffffffc020afd4:	02098d63          	beqz	s3,ffffffffc020b00e <sfs_clear_block+0x5c>
ffffffffc020afd8:	013409bb          	addw	s3,s0,s3
ffffffffc020afdc:	a019                	j	ffffffffc020afe2 <sfs_clear_block+0x30>
ffffffffc020afde:	02898863          	beq	s3,s0,ffffffffc020b00e <sfs_clear_block+0x5c>
ffffffffc020afe2:	04893583          	ld	a1,72(s2)
ffffffffc020afe6:	8622                	mv	a2,s0
ffffffffc020afe8:	4705                	li	a4,1
ffffffffc020afea:	4685                	li	a3,1
ffffffffc020afec:	854a                	mv	a0,s2
ffffffffc020afee:	cddff0ef          	jal	ra,ffffffffc020acca <sfs_rwblock_nolock>
ffffffffc020aff2:	84aa                	mv	s1,a0
ffffffffc020aff4:	2405                	addiw	s0,s0,1
ffffffffc020aff6:	d565                	beqz	a0,ffffffffc020afde <sfs_clear_block+0x2c>
ffffffffc020aff8:	854a                	mv	a0,s2
ffffffffc020affa:	030000ef          	jal	ra,ffffffffc020b02a <unlock_sfs_io>
ffffffffc020affe:	70a2                	ld	ra,40(sp)
ffffffffc020b000:	7402                	ld	s0,32(sp)
ffffffffc020b002:	6942                	ld	s2,16(sp)
ffffffffc020b004:	69a2                	ld	s3,8(sp)
ffffffffc020b006:	8526                	mv	a0,s1
ffffffffc020b008:	64e2                	ld	s1,24(sp)
ffffffffc020b00a:	6145                	addi	sp,sp,48
ffffffffc020b00c:	8082                	ret
ffffffffc020b00e:	4481                	li	s1,0
ffffffffc020b010:	b7e5                	j	ffffffffc020aff8 <sfs_clear_block+0x46>

ffffffffc020b012 <lock_sfs_fs>:
ffffffffc020b012:	05050513          	addi	a0,a0,80
ffffffffc020b016:	d4ef906f          	j	ffffffffc0204564 <down>

ffffffffc020b01a <lock_sfs_io>:
ffffffffc020b01a:	06850513          	addi	a0,a0,104
ffffffffc020b01e:	d46f906f          	j	ffffffffc0204564 <down>

ffffffffc020b022 <unlock_sfs_fs>:
ffffffffc020b022:	05050513          	addi	a0,a0,80
ffffffffc020b026:	d3af906f          	j	ffffffffc0204560 <up>

ffffffffc020b02a <unlock_sfs_io>:
ffffffffc020b02a:	06850513          	addi	a0,a0,104
ffffffffc020b02e:	d32f906f          	j	ffffffffc0204560 <up>

ffffffffc020b032 <hash32>:
ffffffffc020b032:	9e3707b7          	lui	a5,0x9e370
ffffffffc020b036:	2785                	addiw	a5,a5,1
ffffffffc020b038:	02a7853b          	mulw	a0,a5,a0
ffffffffc020b03c:	02000793          	li	a5,32
ffffffffc020b040:	9f8d                	subw	a5,a5,a1
ffffffffc020b042:	00f5553b          	srlw	a0,a0,a5
ffffffffc020b046:	8082                	ret

ffffffffc020b048 <printnum>:
ffffffffc020b048:	02071893          	slli	a7,a4,0x20
ffffffffc020b04c:	7139                	addi	sp,sp,-64
ffffffffc020b04e:	0208d893          	srli	a7,a7,0x20
ffffffffc020b052:	e456                	sd	s5,8(sp)
ffffffffc020b054:	0316fab3          	remu	s5,a3,a7
ffffffffc020b058:	f822                	sd	s0,48(sp)
ffffffffc020b05a:	f426                	sd	s1,40(sp)
ffffffffc020b05c:	f04a                	sd	s2,32(sp)
ffffffffc020b05e:	ec4e                	sd	s3,24(sp)
ffffffffc020b060:	fc06                	sd	ra,56(sp)
ffffffffc020b062:	e852                	sd	s4,16(sp)
ffffffffc020b064:	84aa                	mv	s1,a0
ffffffffc020b066:	89ae                	mv	s3,a1
ffffffffc020b068:	8932                	mv	s2,a2
ffffffffc020b06a:	fff7841b          	addiw	s0,a5,-1
ffffffffc020b06e:	2a81                	sext.w	s5,s5
ffffffffc020b070:	0516f163          	bgeu	a3,a7,ffffffffc020b0b2 <printnum+0x6a>
ffffffffc020b074:	8a42                	mv	s4,a6
ffffffffc020b076:	00805863          	blez	s0,ffffffffc020b086 <printnum+0x3e>
ffffffffc020b07a:	347d                	addiw	s0,s0,-1
ffffffffc020b07c:	864e                	mv	a2,s3
ffffffffc020b07e:	85ca                	mv	a1,s2
ffffffffc020b080:	8552                	mv	a0,s4
ffffffffc020b082:	9482                	jalr	s1
ffffffffc020b084:	f87d                	bnez	s0,ffffffffc020b07a <printnum+0x32>
ffffffffc020b086:	1a82                	slli	s5,s5,0x20
ffffffffc020b088:	00004797          	auipc	a5,0x4
ffffffffc020b08c:	3a078793          	addi	a5,a5,928 # ffffffffc020f428 <sfs_node_fileops+0x118>
ffffffffc020b090:	020ada93          	srli	s5,s5,0x20
ffffffffc020b094:	9abe                	add	s5,s5,a5
ffffffffc020b096:	7442                	ld	s0,48(sp)
ffffffffc020b098:	000ac503          	lbu	a0,0(s5) # 1000 <_binary_bin_swap_img_size-0x6d00>
ffffffffc020b09c:	70e2                	ld	ra,56(sp)
ffffffffc020b09e:	6a42                	ld	s4,16(sp)
ffffffffc020b0a0:	6aa2                	ld	s5,8(sp)
ffffffffc020b0a2:	864e                	mv	a2,s3
ffffffffc020b0a4:	85ca                	mv	a1,s2
ffffffffc020b0a6:	69e2                	ld	s3,24(sp)
ffffffffc020b0a8:	7902                	ld	s2,32(sp)
ffffffffc020b0aa:	87a6                	mv	a5,s1
ffffffffc020b0ac:	74a2                	ld	s1,40(sp)
ffffffffc020b0ae:	6121                	addi	sp,sp,64
ffffffffc020b0b0:	8782                	jr	a5
ffffffffc020b0b2:	0316d6b3          	divu	a3,a3,a7
ffffffffc020b0b6:	87a2                	mv	a5,s0
ffffffffc020b0b8:	f91ff0ef          	jal	ra,ffffffffc020b048 <printnum>
ffffffffc020b0bc:	b7e9                	j	ffffffffc020b086 <printnum+0x3e>

ffffffffc020b0be <sprintputch>:
ffffffffc020b0be:	499c                	lw	a5,16(a1)
ffffffffc020b0c0:	6198                	ld	a4,0(a1)
ffffffffc020b0c2:	6594                	ld	a3,8(a1)
ffffffffc020b0c4:	2785                	addiw	a5,a5,1
ffffffffc020b0c6:	c99c                	sw	a5,16(a1)
ffffffffc020b0c8:	00d77763          	bgeu	a4,a3,ffffffffc020b0d6 <sprintputch+0x18>
ffffffffc020b0cc:	00170793          	addi	a5,a4,1
ffffffffc020b0d0:	e19c                	sd	a5,0(a1)
ffffffffc020b0d2:	00a70023          	sb	a0,0(a4)
ffffffffc020b0d6:	8082                	ret

ffffffffc020b0d8 <vprintfmt>:
ffffffffc020b0d8:	7119                	addi	sp,sp,-128
ffffffffc020b0da:	f4a6                	sd	s1,104(sp)
ffffffffc020b0dc:	f0ca                	sd	s2,96(sp)
ffffffffc020b0de:	ecce                	sd	s3,88(sp)
ffffffffc020b0e0:	e8d2                	sd	s4,80(sp)
ffffffffc020b0e2:	e4d6                	sd	s5,72(sp)
ffffffffc020b0e4:	e0da                	sd	s6,64(sp)
ffffffffc020b0e6:	fc5e                	sd	s7,56(sp)
ffffffffc020b0e8:	ec6e                	sd	s11,24(sp)
ffffffffc020b0ea:	fc86                	sd	ra,120(sp)
ffffffffc020b0ec:	f8a2                	sd	s0,112(sp)
ffffffffc020b0ee:	f862                	sd	s8,48(sp)
ffffffffc020b0f0:	f466                	sd	s9,40(sp)
ffffffffc020b0f2:	f06a                	sd	s10,32(sp)
ffffffffc020b0f4:	89aa                	mv	s3,a0
ffffffffc020b0f6:	892e                	mv	s2,a1
ffffffffc020b0f8:	84b2                	mv	s1,a2
ffffffffc020b0fa:	8db6                	mv	s11,a3
ffffffffc020b0fc:	8aba                	mv	s5,a4
ffffffffc020b0fe:	02500a13          	li	s4,37
ffffffffc020b102:	5bfd                	li	s7,-1
ffffffffc020b104:	00004b17          	auipc	s6,0x4
ffffffffc020b108:	350b0b13          	addi	s6,s6,848 # ffffffffc020f454 <sfs_node_fileops+0x144>
ffffffffc020b10c:	000dc503          	lbu	a0,0(s11) # 2000 <_binary_bin_swap_img_size-0x5d00>
ffffffffc020b110:	001d8413          	addi	s0,s11,1
ffffffffc020b114:	01450b63          	beq	a0,s4,ffffffffc020b12a <vprintfmt+0x52>
ffffffffc020b118:	c129                	beqz	a0,ffffffffc020b15a <vprintfmt+0x82>
ffffffffc020b11a:	864a                	mv	a2,s2
ffffffffc020b11c:	85a6                	mv	a1,s1
ffffffffc020b11e:	0405                	addi	s0,s0,1
ffffffffc020b120:	9982                	jalr	s3
ffffffffc020b122:	fff44503          	lbu	a0,-1(s0)
ffffffffc020b126:	ff4519e3          	bne	a0,s4,ffffffffc020b118 <vprintfmt+0x40>
ffffffffc020b12a:	00044583          	lbu	a1,0(s0)
ffffffffc020b12e:	02000813          	li	a6,32
ffffffffc020b132:	4d01                	li	s10,0
ffffffffc020b134:	4301                	li	t1,0
ffffffffc020b136:	5cfd                	li	s9,-1
ffffffffc020b138:	5c7d                	li	s8,-1
ffffffffc020b13a:	05500513          	li	a0,85
ffffffffc020b13e:	48a5                	li	a7,9
ffffffffc020b140:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020b144:	0ff67613          	zext.b	a2,a2
ffffffffc020b148:	00140d93          	addi	s11,s0,1
ffffffffc020b14c:	04c56263          	bltu	a0,a2,ffffffffc020b190 <vprintfmt+0xb8>
ffffffffc020b150:	060a                	slli	a2,a2,0x2
ffffffffc020b152:	965a                	add	a2,a2,s6
ffffffffc020b154:	4214                	lw	a3,0(a2)
ffffffffc020b156:	96da                	add	a3,a3,s6
ffffffffc020b158:	8682                	jr	a3
ffffffffc020b15a:	70e6                	ld	ra,120(sp)
ffffffffc020b15c:	7446                	ld	s0,112(sp)
ffffffffc020b15e:	74a6                	ld	s1,104(sp)
ffffffffc020b160:	7906                	ld	s2,96(sp)
ffffffffc020b162:	69e6                	ld	s3,88(sp)
ffffffffc020b164:	6a46                	ld	s4,80(sp)
ffffffffc020b166:	6aa6                	ld	s5,72(sp)
ffffffffc020b168:	6b06                	ld	s6,64(sp)
ffffffffc020b16a:	7be2                	ld	s7,56(sp)
ffffffffc020b16c:	7c42                	ld	s8,48(sp)
ffffffffc020b16e:	7ca2                	ld	s9,40(sp)
ffffffffc020b170:	7d02                	ld	s10,32(sp)
ffffffffc020b172:	6de2                	ld	s11,24(sp)
ffffffffc020b174:	6109                	addi	sp,sp,128
ffffffffc020b176:	8082                	ret
ffffffffc020b178:	882e                	mv	a6,a1
ffffffffc020b17a:	00144583          	lbu	a1,1(s0)
ffffffffc020b17e:	846e                	mv	s0,s11
ffffffffc020b180:	00140d93          	addi	s11,s0,1
ffffffffc020b184:	fdd5861b          	addiw	a2,a1,-35
ffffffffc020b188:	0ff67613          	zext.b	a2,a2
ffffffffc020b18c:	fcc572e3          	bgeu	a0,a2,ffffffffc020b150 <vprintfmt+0x78>
ffffffffc020b190:	864a                	mv	a2,s2
ffffffffc020b192:	85a6                	mv	a1,s1
ffffffffc020b194:	02500513          	li	a0,37
ffffffffc020b198:	9982                	jalr	s3
ffffffffc020b19a:	fff44783          	lbu	a5,-1(s0)
ffffffffc020b19e:	8da2                	mv	s11,s0
ffffffffc020b1a0:	f74786e3          	beq	a5,s4,ffffffffc020b10c <vprintfmt+0x34>
ffffffffc020b1a4:	ffedc783          	lbu	a5,-2(s11)
ffffffffc020b1a8:	1dfd                	addi	s11,s11,-1
ffffffffc020b1aa:	ff479de3          	bne	a5,s4,ffffffffc020b1a4 <vprintfmt+0xcc>
ffffffffc020b1ae:	bfb9                	j	ffffffffc020b10c <vprintfmt+0x34>
ffffffffc020b1b0:	fd058c9b          	addiw	s9,a1,-48
ffffffffc020b1b4:	00144583          	lbu	a1,1(s0)
ffffffffc020b1b8:	846e                	mv	s0,s11
ffffffffc020b1ba:	fd05869b          	addiw	a3,a1,-48
ffffffffc020b1be:	0005861b          	sext.w	a2,a1
ffffffffc020b1c2:	02d8e463          	bltu	a7,a3,ffffffffc020b1ea <vprintfmt+0x112>
ffffffffc020b1c6:	00144583          	lbu	a1,1(s0)
ffffffffc020b1ca:	002c969b          	slliw	a3,s9,0x2
ffffffffc020b1ce:	0196873b          	addw	a4,a3,s9
ffffffffc020b1d2:	0017171b          	slliw	a4,a4,0x1
ffffffffc020b1d6:	9f31                	addw	a4,a4,a2
ffffffffc020b1d8:	fd05869b          	addiw	a3,a1,-48
ffffffffc020b1dc:	0405                	addi	s0,s0,1
ffffffffc020b1de:	fd070c9b          	addiw	s9,a4,-48
ffffffffc020b1e2:	0005861b          	sext.w	a2,a1
ffffffffc020b1e6:	fed8f0e3          	bgeu	a7,a3,ffffffffc020b1c6 <vprintfmt+0xee>
ffffffffc020b1ea:	f40c5be3          	bgez	s8,ffffffffc020b140 <vprintfmt+0x68>
ffffffffc020b1ee:	8c66                	mv	s8,s9
ffffffffc020b1f0:	5cfd                	li	s9,-1
ffffffffc020b1f2:	b7b9                	j	ffffffffc020b140 <vprintfmt+0x68>
ffffffffc020b1f4:	fffc4693          	not	a3,s8
ffffffffc020b1f8:	96fd                	srai	a3,a3,0x3f
ffffffffc020b1fa:	00dc77b3          	and	a5,s8,a3
ffffffffc020b1fe:	00144583          	lbu	a1,1(s0)
ffffffffc020b202:	00078c1b          	sext.w	s8,a5
ffffffffc020b206:	846e                	mv	s0,s11
ffffffffc020b208:	bf25                	j	ffffffffc020b140 <vprintfmt+0x68>
ffffffffc020b20a:	000aac83          	lw	s9,0(s5)
ffffffffc020b20e:	00144583          	lbu	a1,1(s0)
ffffffffc020b212:	0aa1                	addi	s5,s5,8
ffffffffc020b214:	846e                	mv	s0,s11
ffffffffc020b216:	bfd1                	j	ffffffffc020b1ea <vprintfmt+0x112>
ffffffffc020b218:	4705                	li	a4,1
ffffffffc020b21a:	008a8613          	addi	a2,s5,8
ffffffffc020b21e:	00674463          	blt	a4,t1,ffffffffc020b226 <vprintfmt+0x14e>
ffffffffc020b222:	1c030c63          	beqz	t1,ffffffffc020b3fa <vprintfmt+0x322>
ffffffffc020b226:	000ab683          	ld	a3,0(s5)
ffffffffc020b22a:	4741                	li	a4,16
ffffffffc020b22c:	8ab2                	mv	s5,a2
ffffffffc020b22e:	2801                	sext.w	a6,a6
ffffffffc020b230:	87e2                	mv	a5,s8
ffffffffc020b232:	8626                	mv	a2,s1
ffffffffc020b234:	85ca                	mv	a1,s2
ffffffffc020b236:	854e                	mv	a0,s3
ffffffffc020b238:	e11ff0ef          	jal	ra,ffffffffc020b048 <printnum>
ffffffffc020b23c:	bdc1                	j	ffffffffc020b10c <vprintfmt+0x34>
ffffffffc020b23e:	000aa503          	lw	a0,0(s5)
ffffffffc020b242:	864a                	mv	a2,s2
ffffffffc020b244:	85a6                	mv	a1,s1
ffffffffc020b246:	0aa1                	addi	s5,s5,8
ffffffffc020b248:	9982                	jalr	s3
ffffffffc020b24a:	b5c9                	j	ffffffffc020b10c <vprintfmt+0x34>
ffffffffc020b24c:	4705                	li	a4,1
ffffffffc020b24e:	008a8613          	addi	a2,s5,8
ffffffffc020b252:	00674463          	blt	a4,t1,ffffffffc020b25a <vprintfmt+0x182>
ffffffffc020b256:	18030d63          	beqz	t1,ffffffffc020b3f0 <vprintfmt+0x318>
ffffffffc020b25a:	000ab683          	ld	a3,0(s5)
ffffffffc020b25e:	4729                	li	a4,10
ffffffffc020b260:	8ab2                	mv	s5,a2
ffffffffc020b262:	b7f1                	j	ffffffffc020b22e <vprintfmt+0x156>
ffffffffc020b264:	00144583          	lbu	a1,1(s0)
ffffffffc020b268:	4d05                	li	s10,1
ffffffffc020b26a:	846e                	mv	s0,s11
ffffffffc020b26c:	bdd1                	j	ffffffffc020b140 <vprintfmt+0x68>
ffffffffc020b26e:	864a                	mv	a2,s2
ffffffffc020b270:	85a6                	mv	a1,s1
ffffffffc020b272:	02500513          	li	a0,37
ffffffffc020b276:	9982                	jalr	s3
ffffffffc020b278:	bd51                	j	ffffffffc020b10c <vprintfmt+0x34>
ffffffffc020b27a:	00144583          	lbu	a1,1(s0)
ffffffffc020b27e:	2305                	addiw	t1,t1,1
ffffffffc020b280:	846e                	mv	s0,s11
ffffffffc020b282:	bd7d                	j	ffffffffc020b140 <vprintfmt+0x68>
ffffffffc020b284:	4705                	li	a4,1
ffffffffc020b286:	008a8613          	addi	a2,s5,8
ffffffffc020b28a:	00674463          	blt	a4,t1,ffffffffc020b292 <vprintfmt+0x1ba>
ffffffffc020b28e:	14030c63          	beqz	t1,ffffffffc020b3e6 <vprintfmt+0x30e>
ffffffffc020b292:	000ab683          	ld	a3,0(s5)
ffffffffc020b296:	4721                	li	a4,8
ffffffffc020b298:	8ab2                	mv	s5,a2
ffffffffc020b29a:	bf51                	j	ffffffffc020b22e <vprintfmt+0x156>
ffffffffc020b29c:	03000513          	li	a0,48
ffffffffc020b2a0:	864a                	mv	a2,s2
ffffffffc020b2a2:	85a6                	mv	a1,s1
ffffffffc020b2a4:	e042                	sd	a6,0(sp)
ffffffffc020b2a6:	9982                	jalr	s3
ffffffffc020b2a8:	864a                	mv	a2,s2
ffffffffc020b2aa:	85a6                	mv	a1,s1
ffffffffc020b2ac:	07800513          	li	a0,120
ffffffffc020b2b0:	9982                	jalr	s3
ffffffffc020b2b2:	0aa1                	addi	s5,s5,8
ffffffffc020b2b4:	6802                	ld	a6,0(sp)
ffffffffc020b2b6:	4741                	li	a4,16
ffffffffc020b2b8:	ff8ab683          	ld	a3,-8(s5)
ffffffffc020b2bc:	bf8d                	j	ffffffffc020b22e <vprintfmt+0x156>
ffffffffc020b2be:	000ab403          	ld	s0,0(s5)
ffffffffc020b2c2:	008a8793          	addi	a5,s5,8
ffffffffc020b2c6:	e03e                	sd	a5,0(sp)
ffffffffc020b2c8:	14040c63          	beqz	s0,ffffffffc020b420 <vprintfmt+0x348>
ffffffffc020b2cc:	11805063          	blez	s8,ffffffffc020b3cc <vprintfmt+0x2f4>
ffffffffc020b2d0:	02d00693          	li	a3,45
ffffffffc020b2d4:	0cd81963          	bne	a6,a3,ffffffffc020b3a6 <vprintfmt+0x2ce>
ffffffffc020b2d8:	00044683          	lbu	a3,0(s0)
ffffffffc020b2dc:	0006851b          	sext.w	a0,a3
ffffffffc020b2e0:	ce8d                	beqz	a3,ffffffffc020b31a <vprintfmt+0x242>
ffffffffc020b2e2:	00140a93          	addi	s5,s0,1
ffffffffc020b2e6:	05e00413          	li	s0,94
ffffffffc020b2ea:	000cc563          	bltz	s9,ffffffffc020b2f4 <vprintfmt+0x21c>
ffffffffc020b2ee:	3cfd                	addiw	s9,s9,-1
ffffffffc020b2f0:	037c8363          	beq	s9,s7,ffffffffc020b316 <vprintfmt+0x23e>
ffffffffc020b2f4:	864a                	mv	a2,s2
ffffffffc020b2f6:	85a6                	mv	a1,s1
ffffffffc020b2f8:	100d0663          	beqz	s10,ffffffffc020b404 <vprintfmt+0x32c>
ffffffffc020b2fc:	3681                	addiw	a3,a3,-32
ffffffffc020b2fe:	10d47363          	bgeu	s0,a3,ffffffffc020b404 <vprintfmt+0x32c>
ffffffffc020b302:	03f00513          	li	a0,63
ffffffffc020b306:	9982                	jalr	s3
ffffffffc020b308:	000ac683          	lbu	a3,0(s5)
ffffffffc020b30c:	3c7d                	addiw	s8,s8,-1
ffffffffc020b30e:	0a85                	addi	s5,s5,1
ffffffffc020b310:	0006851b          	sext.w	a0,a3
ffffffffc020b314:	faf9                	bnez	a3,ffffffffc020b2ea <vprintfmt+0x212>
ffffffffc020b316:	01805a63          	blez	s8,ffffffffc020b32a <vprintfmt+0x252>
ffffffffc020b31a:	3c7d                	addiw	s8,s8,-1
ffffffffc020b31c:	864a                	mv	a2,s2
ffffffffc020b31e:	85a6                	mv	a1,s1
ffffffffc020b320:	02000513          	li	a0,32
ffffffffc020b324:	9982                	jalr	s3
ffffffffc020b326:	fe0c1ae3          	bnez	s8,ffffffffc020b31a <vprintfmt+0x242>
ffffffffc020b32a:	6a82                	ld	s5,0(sp)
ffffffffc020b32c:	b3c5                	j	ffffffffc020b10c <vprintfmt+0x34>
ffffffffc020b32e:	4705                	li	a4,1
ffffffffc020b330:	008a8d13          	addi	s10,s5,8
ffffffffc020b334:	00674463          	blt	a4,t1,ffffffffc020b33c <vprintfmt+0x264>
ffffffffc020b338:	0a030463          	beqz	t1,ffffffffc020b3e0 <vprintfmt+0x308>
ffffffffc020b33c:	000ab403          	ld	s0,0(s5)
ffffffffc020b340:	0c044463          	bltz	s0,ffffffffc020b408 <vprintfmt+0x330>
ffffffffc020b344:	86a2                	mv	a3,s0
ffffffffc020b346:	8aea                	mv	s5,s10
ffffffffc020b348:	4729                	li	a4,10
ffffffffc020b34a:	b5d5                	j	ffffffffc020b22e <vprintfmt+0x156>
ffffffffc020b34c:	000aa783          	lw	a5,0(s5)
ffffffffc020b350:	46e1                	li	a3,24
ffffffffc020b352:	0aa1                	addi	s5,s5,8
ffffffffc020b354:	41f7d71b          	sraiw	a4,a5,0x1f
ffffffffc020b358:	8fb9                	xor	a5,a5,a4
ffffffffc020b35a:	40e7873b          	subw	a4,a5,a4
ffffffffc020b35e:	02e6c663          	blt	a3,a4,ffffffffc020b38a <vprintfmt+0x2b2>
ffffffffc020b362:	00371793          	slli	a5,a4,0x3
ffffffffc020b366:	00004697          	auipc	a3,0x4
ffffffffc020b36a:	42268693          	addi	a3,a3,1058 # ffffffffc020f788 <error_string>
ffffffffc020b36e:	97b6                	add	a5,a5,a3
ffffffffc020b370:	639c                	ld	a5,0(a5)
ffffffffc020b372:	cf81                	beqz	a5,ffffffffc020b38a <vprintfmt+0x2b2>
ffffffffc020b374:	873e                	mv	a4,a5
ffffffffc020b376:	00000697          	auipc	a3,0x0
ffffffffc020b37a:	28268693          	addi	a3,a3,642 # ffffffffc020b5f8 <etext+0x28>
ffffffffc020b37e:	8626                	mv	a2,s1
ffffffffc020b380:	85ca                	mv	a1,s2
ffffffffc020b382:	854e                	mv	a0,s3
ffffffffc020b384:	0d4000ef          	jal	ra,ffffffffc020b458 <printfmt>
ffffffffc020b388:	b351                	j	ffffffffc020b10c <vprintfmt+0x34>
ffffffffc020b38a:	00004697          	auipc	a3,0x4
ffffffffc020b38e:	0be68693          	addi	a3,a3,190 # ffffffffc020f448 <sfs_node_fileops+0x138>
ffffffffc020b392:	8626                	mv	a2,s1
ffffffffc020b394:	85ca                	mv	a1,s2
ffffffffc020b396:	854e                	mv	a0,s3
ffffffffc020b398:	0c0000ef          	jal	ra,ffffffffc020b458 <printfmt>
ffffffffc020b39c:	bb85                	j	ffffffffc020b10c <vprintfmt+0x34>
ffffffffc020b39e:	00004417          	auipc	s0,0x4
ffffffffc020b3a2:	0a240413          	addi	s0,s0,162 # ffffffffc020f440 <sfs_node_fileops+0x130>
ffffffffc020b3a6:	85e6                	mv	a1,s9
ffffffffc020b3a8:	8522                	mv	a0,s0
ffffffffc020b3aa:	e442                	sd	a6,8(sp)
ffffffffc020b3ac:	132000ef          	jal	ra,ffffffffc020b4de <strnlen>
ffffffffc020b3b0:	40ac0c3b          	subw	s8,s8,a0
ffffffffc020b3b4:	01805c63          	blez	s8,ffffffffc020b3cc <vprintfmt+0x2f4>
ffffffffc020b3b8:	6822                	ld	a6,8(sp)
ffffffffc020b3ba:	00080a9b          	sext.w	s5,a6
ffffffffc020b3be:	3c7d                	addiw	s8,s8,-1
ffffffffc020b3c0:	864a                	mv	a2,s2
ffffffffc020b3c2:	85a6                	mv	a1,s1
ffffffffc020b3c4:	8556                	mv	a0,s5
ffffffffc020b3c6:	9982                	jalr	s3
ffffffffc020b3c8:	fe0c1be3          	bnez	s8,ffffffffc020b3be <vprintfmt+0x2e6>
ffffffffc020b3cc:	00044683          	lbu	a3,0(s0)
ffffffffc020b3d0:	00140a93          	addi	s5,s0,1
ffffffffc020b3d4:	0006851b          	sext.w	a0,a3
ffffffffc020b3d8:	daa9                	beqz	a3,ffffffffc020b32a <vprintfmt+0x252>
ffffffffc020b3da:	05e00413          	li	s0,94
ffffffffc020b3de:	b731                	j	ffffffffc020b2ea <vprintfmt+0x212>
ffffffffc020b3e0:	000aa403          	lw	s0,0(s5)
ffffffffc020b3e4:	bfb1                	j	ffffffffc020b340 <vprintfmt+0x268>
ffffffffc020b3e6:	000ae683          	lwu	a3,0(s5)
ffffffffc020b3ea:	4721                	li	a4,8
ffffffffc020b3ec:	8ab2                	mv	s5,a2
ffffffffc020b3ee:	b581                	j	ffffffffc020b22e <vprintfmt+0x156>
ffffffffc020b3f0:	000ae683          	lwu	a3,0(s5)
ffffffffc020b3f4:	4729                	li	a4,10
ffffffffc020b3f6:	8ab2                	mv	s5,a2
ffffffffc020b3f8:	bd1d                	j	ffffffffc020b22e <vprintfmt+0x156>
ffffffffc020b3fa:	000ae683          	lwu	a3,0(s5)
ffffffffc020b3fe:	4741                	li	a4,16
ffffffffc020b400:	8ab2                	mv	s5,a2
ffffffffc020b402:	b535                	j	ffffffffc020b22e <vprintfmt+0x156>
ffffffffc020b404:	9982                	jalr	s3
ffffffffc020b406:	b709                	j	ffffffffc020b308 <vprintfmt+0x230>
ffffffffc020b408:	864a                	mv	a2,s2
ffffffffc020b40a:	85a6                	mv	a1,s1
ffffffffc020b40c:	02d00513          	li	a0,45
ffffffffc020b410:	e042                	sd	a6,0(sp)
ffffffffc020b412:	9982                	jalr	s3
ffffffffc020b414:	6802                	ld	a6,0(sp)
ffffffffc020b416:	8aea                	mv	s5,s10
ffffffffc020b418:	408006b3          	neg	a3,s0
ffffffffc020b41c:	4729                	li	a4,10
ffffffffc020b41e:	bd01                	j	ffffffffc020b22e <vprintfmt+0x156>
ffffffffc020b420:	03805163          	blez	s8,ffffffffc020b442 <vprintfmt+0x36a>
ffffffffc020b424:	02d00693          	li	a3,45
ffffffffc020b428:	f6d81be3          	bne	a6,a3,ffffffffc020b39e <vprintfmt+0x2c6>
ffffffffc020b42c:	00004417          	auipc	s0,0x4
ffffffffc020b430:	01440413          	addi	s0,s0,20 # ffffffffc020f440 <sfs_node_fileops+0x130>
ffffffffc020b434:	02800693          	li	a3,40
ffffffffc020b438:	02800513          	li	a0,40
ffffffffc020b43c:	00140a93          	addi	s5,s0,1
ffffffffc020b440:	b55d                	j	ffffffffc020b2e6 <vprintfmt+0x20e>
ffffffffc020b442:	00004a97          	auipc	s5,0x4
ffffffffc020b446:	fffa8a93          	addi	s5,s5,-1 # ffffffffc020f441 <sfs_node_fileops+0x131>
ffffffffc020b44a:	02800513          	li	a0,40
ffffffffc020b44e:	02800693          	li	a3,40
ffffffffc020b452:	05e00413          	li	s0,94
ffffffffc020b456:	bd51                	j	ffffffffc020b2ea <vprintfmt+0x212>

ffffffffc020b458 <printfmt>:
ffffffffc020b458:	7139                	addi	sp,sp,-64
ffffffffc020b45a:	02010313          	addi	t1,sp,32
ffffffffc020b45e:	f03a                	sd	a4,32(sp)
ffffffffc020b460:	871a                	mv	a4,t1
ffffffffc020b462:	ec06                	sd	ra,24(sp)
ffffffffc020b464:	f43e                	sd	a5,40(sp)
ffffffffc020b466:	f842                	sd	a6,48(sp)
ffffffffc020b468:	fc46                	sd	a7,56(sp)
ffffffffc020b46a:	e41a                	sd	t1,8(sp)
ffffffffc020b46c:	c6dff0ef          	jal	ra,ffffffffc020b0d8 <vprintfmt>
ffffffffc020b470:	60e2                	ld	ra,24(sp)
ffffffffc020b472:	6121                	addi	sp,sp,64
ffffffffc020b474:	8082                	ret

ffffffffc020b476 <snprintf>:
ffffffffc020b476:	711d                	addi	sp,sp,-96
ffffffffc020b478:	15fd                	addi	a1,a1,-1
ffffffffc020b47a:	03810313          	addi	t1,sp,56
ffffffffc020b47e:	95aa                	add	a1,a1,a0
ffffffffc020b480:	f406                	sd	ra,40(sp)
ffffffffc020b482:	fc36                	sd	a3,56(sp)
ffffffffc020b484:	e0ba                	sd	a4,64(sp)
ffffffffc020b486:	e4be                	sd	a5,72(sp)
ffffffffc020b488:	e8c2                	sd	a6,80(sp)
ffffffffc020b48a:	ecc6                	sd	a7,88(sp)
ffffffffc020b48c:	e01a                	sd	t1,0(sp)
ffffffffc020b48e:	e42a                	sd	a0,8(sp)
ffffffffc020b490:	e82e                	sd	a1,16(sp)
ffffffffc020b492:	cc02                	sw	zero,24(sp)
ffffffffc020b494:	c515                	beqz	a0,ffffffffc020b4c0 <snprintf+0x4a>
ffffffffc020b496:	02a5e563          	bltu	a1,a0,ffffffffc020b4c0 <snprintf+0x4a>
ffffffffc020b49a:	75dd                	lui	a1,0xffff7
ffffffffc020b49c:	86b2                	mv	a3,a2
ffffffffc020b49e:	00000517          	auipc	a0,0x0
ffffffffc020b4a2:	c2050513          	addi	a0,a0,-992 # ffffffffc020b0be <sprintputch>
ffffffffc020b4a6:	871a                	mv	a4,t1
ffffffffc020b4a8:	0030                	addi	a2,sp,8
ffffffffc020b4aa:	ad958593          	addi	a1,a1,-1319 # ffffffffffff6ad9 <end+0x3fd601c9>
ffffffffc020b4ae:	c2bff0ef          	jal	ra,ffffffffc020b0d8 <vprintfmt>
ffffffffc020b4b2:	67a2                	ld	a5,8(sp)
ffffffffc020b4b4:	00078023          	sb	zero,0(a5)
ffffffffc020b4b8:	4562                	lw	a0,24(sp)
ffffffffc020b4ba:	70a2                	ld	ra,40(sp)
ffffffffc020b4bc:	6125                	addi	sp,sp,96
ffffffffc020b4be:	8082                	ret
ffffffffc020b4c0:	5575                	li	a0,-3
ffffffffc020b4c2:	bfe5                	j	ffffffffc020b4ba <snprintf+0x44>

ffffffffc020b4c4 <strlen>:
ffffffffc020b4c4:	00054783          	lbu	a5,0(a0)
ffffffffc020b4c8:	872a                	mv	a4,a0
ffffffffc020b4ca:	4501                	li	a0,0
ffffffffc020b4cc:	cb81                	beqz	a5,ffffffffc020b4dc <strlen+0x18>
ffffffffc020b4ce:	0505                	addi	a0,a0,1
ffffffffc020b4d0:	00a707b3          	add	a5,a4,a0
ffffffffc020b4d4:	0007c783          	lbu	a5,0(a5)
ffffffffc020b4d8:	fbfd                	bnez	a5,ffffffffc020b4ce <strlen+0xa>
ffffffffc020b4da:	8082                	ret
ffffffffc020b4dc:	8082                	ret

ffffffffc020b4de <strnlen>:
ffffffffc020b4de:	4781                	li	a5,0
ffffffffc020b4e0:	e589                	bnez	a1,ffffffffc020b4ea <strnlen+0xc>
ffffffffc020b4e2:	a811                	j	ffffffffc020b4f6 <strnlen+0x18>
ffffffffc020b4e4:	0785                	addi	a5,a5,1
ffffffffc020b4e6:	00f58863          	beq	a1,a5,ffffffffc020b4f6 <strnlen+0x18>
ffffffffc020b4ea:	00f50733          	add	a4,a0,a5
ffffffffc020b4ee:	00074703          	lbu	a4,0(a4)
ffffffffc020b4f2:	fb6d                	bnez	a4,ffffffffc020b4e4 <strnlen+0x6>
ffffffffc020b4f4:	85be                	mv	a1,a5
ffffffffc020b4f6:	852e                	mv	a0,a1
ffffffffc020b4f8:	8082                	ret

ffffffffc020b4fa <strcpy>:
ffffffffc020b4fa:	87aa                	mv	a5,a0
ffffffffc020b4fc:	0005c703          	lbu	a4,0(a1)
ffffffffc020b500:	0785                	addi	a5,a5,1
ffffffffc020b502:	0585                	addi	a1,a1,1
ffffffffc020b504:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b508:	fb75                	bnez	a4,ffffffffc020b4fc <strcpy+0x2>
ffffffffc020b50a:	8082                	ret

ffffffffc020b50c <strcmp>:
ffffffffc020b50c:	00054783          	lbu	a5,0(a0)
ffffffffc020b510:	0005c703          	lbu	a4,0(a1)
ffffffffc020b514:	cb89                	beqz	a5,ffffffffc020b526 <strcmp+0x1a>
ffffffffc020b516:	0505                	addi	a0,a0,1
ffffffffc020b518:	0585                	addi	a1,a1,1
ffffffffc020b51a:	fee789e3          	beq	a5,a4,ffffffffc020b50c <strcmp>
ffffffffc020b51e:	0007851b          	sext.w	a0,a5
ffffffffc020b522:	9d19                	subw	a0,a0,a4
ffffffffc020b524:	8082                	ret
ffffffffc020b526:	4501                	li	a0,0
ffffffffc020b528:	bfed                	j	ffffffffc020b522 <strcmp+0x16>

ffffffffc020b52a <strncmp>:
ffffffffc020b52a:	c20d                	beqz	a2,ffffffffc020b54c <strncmp+0x22>
ffffffffc020b52c:	962e                	add	a2,a2,a1
ffffffffc020b52e:	a031                	j	ffffffffc020b53a <strncmp+0x10>
ffffffffc020b530:	0505                	addi	a0,a0,1
ffffffffc020b532:	00e79a63          	bne	a5,a4,ffffffffc020b546 <strncmp+0x1c>
ffffffffc020b536:	00b60b63          	beq	a2,a1,ffffffffc020b54c <strncmp+0x22>
ffffffffc020b53a:	00054783          	lbu	a5,0(a0)
ffffffffc020b53e:	0585                	addi	a1,a1,1
ffffffffc020b540:	fff5c703          	lbu	a4,-1(a1)
ffffffffc020b544:	f7f5                	bnez	a5,ffffffffc020b530 <strncmp+0x6>
ffffffffc020b546:	40e7853b          	subw	a0,a5,a4
ffffffffc020b54a:	8082                	ret
ffffffffc020b54c:	4501                	li	a0,0
ffffffffc020b54e:	8082                	ret

ffffffffc020b550 <strchr>:
ffffffffc020b550:	00054783          	lbu	a5,0(a0)
ffffffffc020b554:	c799                	beqz	a5,ffffffffc020b562 <strchr+0x12>
ffffffffc020b556:	00f58763          	beq	a1,a5,ffffffffc020b564 <strchr+0x14>
ffffffffc020b55a:	00154783          	lbu	a5,1(a0)
ffffffffc020b55e:	0505                	addi	a0,a0,1
ffffffffc020b560:	fbfd                	bnez	a5,ffffffffc020b556 <strchr+0x6>
ffffffffc020b562:	4501                	li	a0,0
ffffffffc020b564:	8082                	ret

ffffffffc020b566 <memset>:
ffffffffc020b566:	ca01                	beqz	a2,ffffffffc020b576 <memset+0x10>
ffffffffc020b568:	962a                	add	a2,a2,a0
ffffffffc020b56a:	87aa                	mv	a5,a0
ffffffffc020b56c:	0785                	addi	a5,a5,1
ffffffffc020b56e:	feb78fa3          	sb	a1,-1(a5)
ffffffffc020b572:	fec79de3          	bne	a5,a2,ffffffffc020b56c <memset+0x6>
ffffffffc020b576:	8082                	ret

ffffffffc020b578 <memmove>:
ffffffffc020b578:	02a5f263          	bgeu	a1,a0,ffffffffc020b59c <memmove+0x24>
ffffffffc020b57c:	00c587b3          	add	a5,a1,a2
ffffffffc020b580:	00f57e63          	bgeu	a0,a5,ffffffffc020b59c <memmove+0x24>
ffffffffc020b584:	00c50733          	add	a4,a0,a2
ffffffffc020b588:	c615                	beqz	a2,ffffffffc020b5b4 <memmove+0x3c>
ffffffffc020b58a:	fff7c683          	lbu	a3,-1(a5)
ffffffffc020b58e:	17fd                	addi	a5,a5,-1
ffffffffc020b590:	177d                	addi	a4,a4,-1
ffffffffc020b592:	00d70023          	sb	a3,0(a4)
ffffffffc020b596:	fef59ae3          	bne	a1,a5,ffffffffc020b58a <memmove+0x12>
ffffffffc020b59a:	8082                	ret
ffffffffc020b59c:	00c586b3          	add	a3,a1,a2
ffffffffc020b5a0:	87aa                	mv	a5,a0
ffffffffc020b5a2:	ca11                	beqz	a2,ffffffffc020b5b6 <memmove+0x3e>
ffffffffc020b5a4:	0005c703          	lbu	a4,0(a1)
ffffffffc020b5a8:	0585                	addi	a1,a1,1
ffffffffc020b5aa:	0785                	addi	a5,a5,1
ffffffffc020b5ac:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b5b0:	fed59ae3          	bne	a1,a3,ffffffffc020b5a4 <memmove+0x2c>
ffffffffc020b5b4:	8082                	ret
ffffffffc020b5b6:	8082                	ret

ffffffffc020b5b8 <memcpy>:
ffffffffc020b5b8:	ca19                	beqz	a2,ffffffffc020b5ce <memcpy+0x16>
ffffffffc020b5ba:	962e                	add	a2,a2,a1
ffffffffc020b5bc:	87aa                	mv	a5,a0
ffffffffc020b5be:	0005c703          	lbu	a4,0(a1)
ffffffffc020b5c2:	0585                	addi	a1,a1,1
ffffffffc020b5c4:	0785                	addi	a5,a5,1
ffffffffc020b5c6:	fee78fa3          	sb	a4,-1(a5)
ffffffffc020b5ca:	fec59ae3          	bne	a1,a2,ffffffffc020b5be <memcpy+0x6>
ffffffffc020b5ce:	8082                	ret
