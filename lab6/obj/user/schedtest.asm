
obj/__user_schedtest.out:     file format elf64-littleriscv


Disassembly of section .text:

0000000000800020 <_start>:
    # move down the esp register
    # since it may cause page fault in backtrace
    // subl $0x20, %esp

    # call user-program function
    call umain
  800020:	0d0000ef          	jal	ra,8000f0 <umain>
1:  j 1b
  800024:	a001                	j	800024 <_start+0x4>

0000000000800026 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  800026:	1141                	addi	sp,sp,-16
  800028:	e022                	sd	s0,0(sp)
  80002a:	e406                	sd	ra,8(sp)
  80002c:	842e                	mv	s0,a1
    sys_putc(c);
  80002e:	096000ef          	jal	ra,8000c4 <sys_putc>
    (*cnt) ++;
  800032:	401c                	lw	a5,0(s0)
}
  800034:	60a2                	ld	ra,8(sp)
    (*cnt) ++;
  800036:	2785                	addiw	a5,a5,1
  800038:	c01c                	sw	a5,0(s0)
}
  80003a:	6402                	ld	s0,0(sp)
  80003c:	0141                	addi	sp,sp,16
  80003e:	8082                	ret

0000000000800040 <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  800040:	711d                	addi	sp,sp,-96
    va_list ap;

    va_start(ap, fmt);
  800042:	02810313          	addi	t1,sp,40
cprintf(const char *fmt, ...) {
  800046:	8e2a                	mv	t3,a0
  800048:	f42e                	sd	a1,40(sp)
  80004a:	f832                	sd	a2,48(sp)
  80004c:	fc36                	sd	a3,56(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80004e:	00000517          	auipc	a0,0x0
  800052:	fd850513          	addi	a0,a0,-40 # 800026 <cputch>
  800056:	004c                	addi	a1,sp,4
  800058:	869a                	mv	a3,t1
  80005a:	8672                	mv	a2,t3
cprintf(const char *fmt, ...) {
  80005c:	ec06                	sd	ra,24(sp)
  80005e:	e0ba                	sd	a4,64(sp)
  800060:	e4be                	sd	a5,72(sp)
  800062:	e8c2                	sd	a6,80(sp)
  800064:	ecc6                	sd	a7,88(sp)
    va_start(ap, fmt);
  800066:	e41a                	sd	t1,8(sp)
    int cnt = 0;
  800068:	c202                	sw	zero,4(sp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  80006a:	0fe000ef          	jal	ra,800168 <vprintfmt>
    int cnt = vcprintf(fmt, ap);
    va_end(ap);

    return cnt;
}
  80006e:	60e2                	ld	ra,24(sp)
  800070:	4512                	lw	a0,4(sp)
  800072:	6125                	addi	sp,sp,96
  800074:	8082                	ret

0000000000800076 <syscall>:
#include <syscall.h>

#define MAX_ARGS            5

static inline int
syscall(int64_t num, ...) {
  800076:	7175                	addi	sp,sp,-144
  800078:	f8ba                	sd	a4,112(sp)
    va_list ap;
    va_start(ap, num);
    uint64_t a[MAX_ARGS];
    int i, ret;
    for (i = 0; i < MAX_ARGS; i ++) {
        a[i] = va_arg(ap, uint64_t);
  80007a:	e0ba                	sd	a4,64(sp)
  80007c:	0118                	addi	a4,sp,128
syscall(int64_t num, ...) {
  80007e:	e42a                	sd	a0,8(sp)
  800080:	ecae                	sd	a1,88(sp)
  800082:	f0b2                	sd	a2,96(sp)
  800084:	f4b6                	sd	a3,104(sp)
  800086:	fcbe                	sd	a5,120(sp)
  800088:	e142                	sd	a6,128(sp)
  80008a:	e546                	sd	a7,136(sp)
        a[i] = va_arg(ap, uint64_t);
  80008c:	f42e                	sd	a1,40(sp)
  80008e:	f832                	sd	a2,48(sp)
  800090:	fc36                	sd	a3,56(sp)
  800092:	f03a                	sd	a4,32(sp)
  800094:	e4be                	sd	a5,72(sp)
    }
    va_end(ap);
    asm volatile (
  800096:	4522                	lw	a0,8(sp)
  800098:	55a2                	lw	a1,40(sp)
  80009a:	5642                	lw	a2,48(sp)
  80009c:	56e2                	lw	a3,56(sp)
  80009e:	4706                	lw	a4,64(sp)
  8000a0:	47a6                	lw	a5,72(sp)
  8000a2:	00000073          	ecall
  8000a6:	ce2a                	sw	a0,28(sp)
          "m" (a[3]),
          "m" (a[4])
        : "memory"
      );
    return ret;
}
  8000a8:	4572                	lw	a0,28(sp)
  8000aa:	6149                	addi	sp,sp,144
  8000ac:	8082                	ret

00000000008000ae <sys_exit>:

int
sys_exit(int64_t error_code) {
  8000ae:	85aa                	mv	a1,a0
    return syscall(SYS_exit, error_code);
  8000b0:	4505                	li	a0,1
  8000b2:	b7d1                	j	800076 <syscall>

00000000008000b4 <sys_fork>:
}

int
sys_fork(void) {
    return syscall(SYS_fork);
  8000b4:	4509                	li	a0,2
  8000b6:	b7c1                	j	800076 <syscall>

00000000008000b8 <sys_wait>:
}

int
sys_wait(int64_t pid, int *store) {
  8000b8:	862e                	mv	a2,a1
    return syscall(SYS_wait, pid, store);
  8000ba:	85aa                	mv	a1,a0
  8000bc:	450d                	li	a0,3
  8000be:	bf65                	j	800076 <syscall>

00000000008000c0 <sys_getpid>:
    return syscall(SYS_kill, pid);
}

int
sys_getpid(void) {
    return syscall(SYS_getpid);
  8000c0:	4549                	li	a0,18
  8000c2:	bf55                	j	800076 <syscall>

00000000008000c4 <sys_putc>:
}

int
sys_putc(int64_t c) {
  8000c4:	85aa                	mv	a1,a0
    return syscall(SYS_putc, c);
  8000c6:	4579                	li	a0,30
  8000c8:	b77d                	j	800076 <syscall>

00000000008000ca <sys_gettime>:
    return syscall(SYS_pgdir);
}

int
sys_gettime(void) {
    return syscall(SYS_gettime);
  8000ca:	4545                	li	a0,17
  8000cc:	b76d                	j	800076 <syscall>

00000000008000ce <exit>:
#include <syscall.h>
#include <stdio.h>
#include <ulib.h>

void
exit(int error_code) {
  8000ce:	1141                	addi	sp,sp,-16
  8000d0:	e406                	sd	ra,8(sp)
    sys_exit(error_code);
  8000d2:	fddff0ef          	jal	ra,8000ae <sys_exit>
    cprintf("BUG: exit failed.\n");
  8000d6:	00000517          	auipc	a0,0x0
  8000da:	4ea50513          	addi	a0,a0,1258 # 8005c0 <main+0x78>
  8000de:	f63ff0ef          	jal	ra,800040 <cprintf>
    while (1);
  8000e2:	a001                	j	8000e2 <exit+0x14>

00000000008000e4 <fork>:
}

int
fork(void) {
    return sys_fork();
  8000e4:	bfc1                	j	8000b4 <sys_fork>

00000000008000e6 <wait>:
}

int
wait(void) {
    return sys_wait(0, NULL);
  8000e6:	4581                	li	a1,0
  8000e8:	4501                	li	a0,0
  8000ea:	b7f9                	j	8000b8 <sys_wait>

00000000008000ec <getpid>:
    return sys_kill(pid);
}

int
getpid(void) {
    return sys_getpid();
  8000ec:	bfd1                	j	8000c0 <sys_getpid>

00000000008000ee <gettime_msec>:
    sys_pgdir();
}

unsigned int
gettime_msec(void) {
    return (unsigned int)sys_gettime();
  8000ee:	bff1                	j	8000ca <sys_gettime>

00000000008000f0 <umain>:
#include <ulib.h>

int main(void);

void
umain(void) {
  8000f0:	1141                	addi	sp,sp,-16
  8000f2:	e406                	sd	ra,8(sp)
    int ret = main();
  8000f4:	454000ef          	jal	ra,800548 <main>
    exit(ret);
  8000f8:	fd7ff0ef          	jal	ra,8000ce <exit>

00000000008000fc <printnum>:
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
    unsigned long long result = num;
    unsigned mod = do_div(result, base);
  8000fc:	02069813          	slli	a6,a3,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  800100:	7179                	addi	sp,sp,-48
    unsigned mod = do_div(result, base);
  800102:	02085813          	srli	a6,a6,0x20
        unsigned long long num, unsigned base, int width, int padc) {
  800106:	e052                	sd	s4,0(sp)
    unsigned mod = do_div(result, base);
  800108:	03067a33          	remu	s4,a2,a6
        unsigned long long num, unsigned base, int width, int padc) {
  80010c:	f022                	sd	s0,32(sp)
  80010e:	ec26                	sd	s1,24(sp)
  800110:	e84a                	sd	s2,16(sp)
  800112:	f406                	sd	ra,40(sp)
  800114:	e44e                	sd	s3,8(sp)
  800116:	84aa                	mv	s1,a0
  800118:	892e                	mv	s2,a1
    // first recursively print all preceding (more significant) digits
    if (num >= base) {
        printnum(putch, putdat, result, base, width - 1, padc);
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
  80011a:	fff7041b          	addiw	s0,a4,-1
    unsigned mod = do_div(result, base);
  80011e:	2a01                	sext.w	s4,s4
    if (num >= base) {
  800120:	03067e63          	bgeu	a2,a6,80015c <printnum+0x60>
  800124:	89be                	mv	s3,a5
        while (-- width > 0)
  800126:	00805763          	blez	s0,800134 <printnum+0x38>
  80012a:	347d                	addiw	s0,s0,-1
            putch(padc, putdat);
  80012c:	85ca                	mv	a1,s2
  80012e:	854e                	mv	a0,s3
  800130:	9482                	jalr	s1
        while (-- width > 0)
  800132:	fc65                	bnez	s0,80012a <printnum+0x2e>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  800134:	1a02                	slli	s4,s4,0x20
  800136:	00000797          	auipc	a5,0x0
  80013a:	4a278793          	addi	a5,a5,1186 # 8005d8 <main+0x90>
  80013e:	020a5a13          	srli	s4,s4,0x20
  800142:	9a3e                	add	s4,s4,a5
    // Crashes if num >= base. No idea what going on here
    // Here is a quick fix
    // update: Stack grows downward and destory the SBI
    // sbi_console_putchar("0123456789abcdef"[mod]);
    // (*(int *)putdat)++;
}
  800144:	7402                	ld	s0,32(sp)
    putch("0123456789abcdef"[mod], putdat);
  800146:	000a4503          	lbu	a0,0(s4)
}
  80014a:	70a2                	ld	ra,40(sp)
  80014c:	69a2                	ld	s3,8(sp)
  80014e:	6a02                	ld	s4,0(sp)
    putch("0123456789abcdef"[mod], putdat);
  800150:	85ca                	mv	a1,s2
  800152:	87a6                	mv	a5,s1
}
  800154:	6942                	ld	s2,16(sp)
  800156:	64e2                	ld	s1,24(sp)
  800158:	6145                	addi	sp,sp,48
    putch("0123456789abcdef"[mod], putdat);
  80015a:	8782                	jr	a5
        printnum(putch, putdat, result, base, width - 1, padc);
  80015c:	03065633          	divu	a2,a2,a6
  800160:	8722                	mv	a4,s0
  800162:	f9bff0ef          	jal	ra,8000fc <printnum>
  800166:	b7f9                	j	800134 <printnum+0x38>

0000000000800168 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  800168:	7119                	addi	sp,sp,-128
  80016a:	f4a6                	sd	s1,104(sp)
  80016c:	f0ca                	sd	s2,96(sp)
  80016e:	ecce                	sd	s3,88(sp)
  800170:	e8d2                	sd	s4,80(sp)
  800172:	e4d6                	sd	s5,72(sp)
  800174:	e0da                	sd	s6,64(sp)
  800176:	fc5e                	sd	s7,56(sp)
  800178:	f06a                	sd	s10,32(sp)
  80017a:	fc86                	sd	ra,120(sp)
  80017c:	f8a2                	sd	s0,112(sp)
  80017e:	f862                	sd	s8,48(sp)
  800180:	f466                	sd	s9,40(sp)
  800182:	ec6e                	sd	s11,24(sp)
  800184:	892a                	mv	s2,a0
  800186:	84ae                	mv	s1,a1
  800188:	8d32                	mv	s10,a2
  80018a:	8a36                	mv	s4,a3
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  80018c:	02500993          	li	s3,37
            putch(ch, putdat);
        }

        // Process a %-escape sequence
        char padc = ' ';
        width = precision = -1;
  800190:	5b7d                	li	s6,-1
  800192:	00000a97          	auipc	s5,0x0
  800196:	47aa8a93          	addi	s5,s5,1146 # 80060c <main+0xc4>
        case 'e':
            err = va_arg(ap, int);
            if (err < 0) {
                err = -err;
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  80019a:	00000b97          	auipc	s7,0x0
  80019e:	68eb8b93          	addi	s7,s7,1678 # 800828 <error_string>
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001a2:	000d4503          	lbu	a0,0(s10)
  8001a6:	001d0413          	addi	s0,s10,1
  8001aa:	01350a63          	beq	a0,s3,8001be <vprintfmt+0x56>
            if (ch == '\0') {
  8001ae:	c121                	beqz	a0,8001ee <vprintfmt+0x86>
            putch(ch, putdat);
  8001b0:	85a6                	mv	a1,s1
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001b2:	0405                	addi	s0,s0,1
            putch(ch, putdat);
  8001b4:	9902                	jalr	s2
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  8001b6:	fff44503          	lbu	a0,-1(s0)
  8001ba:	ff351ae3          	bne	a0,s3,8001ae <vprintfmt+0x46>
        switch (ch = *(unsigned char *)fmt ++) {
  8001be:	00044603          	lbu	a2,0(s0)
        char padc = ' ';
  8001c2:	02000793          	li	a5,32
        lflag = altflag = 0;
  8001c6:	4c81                	li	s9,0
  8001c8:	4881                	li	a7,0
        width = precision = -1;
  8001ca:	5c7d                	li	s8,-1
  8001cc:	5dfd                	li	s11,-1
  8001ce:	05500513          	li	a0,85
                if (ch < '0' || ch > '9') {
  8001d2:	4825                	li	a6,9
        switch (ch = *(unsigned char *)fmt ++) {
  8001d4:	fdd6059b          	addiw	a1,a2,-35
  8001d8:	0ff5f593          	zext.b	a1,a1
  8001dc:	00140d13          	addi	s10,s0,1
  8001e0:	04b56263          	bltu	a0,a1,800224 <vprintfmt+0xbc>
  8001e4:	058a                	slli	a1,a1,0x2
  8001e6:	95d6                	add	a1,a1,s5
  8001e8:	4194                	lw	a3,0(a1)
  8001ea:	96d6                	add	a3,a3,s5
  8001ec:	8682                	jr	a3
            for (fmt --; fmt[-1] != '%'; fmt --)
                /* do nothing */;
            break;
        }
    }
}
  8001ee:	70e6                	ld	ra,120(sp)
  8001f0:	7446                	ld	s0,112(sp)
  8001f2:	74a6                	ld	s1,104(sp)
  8001f4:	7906                	ld	s2,96(sp)
  8001f6:	69e6                	ld	s3,88(sp)
  8001f8:	6a46                	ld	s4,80(sp)
  8001fa:	6aa6                	ld	s5,72(sp)
  8001fc:	6b06                	ld	s6,64(sp)
  8001fe:	7be2                	ld	s7,56(sp)
  800200:	7c42                	ld	s8,48(sp)
  800202:	7ca2                	ld	s9,40(sp)
  800204:	7d02                	ld	s10,32(sp)
  800206:	6de2                	ld	s11,24(sp)
  800208:	6109                	addi	sp,sp,128
  80020a:	8082                	ret
            padc = '0';
  80020c:	87b2                	mv	a5,a2
            goto reswitch;
  80020e:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  800212:	846a                	mv	s0,s10
  800214:	00140d13          	addi	s10,s0,1
  800218:	fdd6059b          	addiw	a1,a2,-35
  80021c:	0ff5f593          	zext.b	a1,a1
  800220:	fcb572e3          	bgeu	a0,a1,8001e4 <vprintfmt+0x7c>
            putch('%', putdat);
  800224:	85a6                	mv	a1,s1
  800226:	02500513          	li	a0,37
  80022a:	9902                	jalr	s2
            for (fmt --; fmt[-1] != '%'; fmt --)
  80022c:	fff44783          	lbu	a5,-1(s0)
  800230:	8d22                	mv	s10,s0
  800232:	f73788e3          	beq	a5,s3,8001a2 <vprintfmt+0x3a>
  800236:	ffed4783          	lbu	a5,-2(s10)
  80023a:	1d7d                	addi	s10,s10,-1
  80023c:	ff379de3          	bne	a5,s3,800236 <vprintfmt+0xce>
  800240:	b78d                	j	8001a2 <vprintfmt+0x3a>
                precision = precision * 10 + ch - '0';
  800242:	fd060c1b          	addiw	s8,a2,-48
                ch = *fmt;
  800246:	00144603          	lbu	a2,1(s0)
        switch (ch = *(unsigned char *)fmt ++) {
  80024a:	846a                	mv	s0,s10
                if (ch < '0' || ch > '9') {
  80024c:	fd06069b          	addiw	a3,a2,-48
                ch = *fmt;
  800250:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  800254:	02d86463          	bltu	a6,a3,80027c <vprintfmt+0x114>
                ch = *fmt;
  800258:	00144603          	lbu	a2,1(s0)
                precision = precision * 10 + ch - '0';
  80025c:	002c169b          	slliw	a3,s8,0x2
  800260:	0186873b          	addw	a4,a3,s8
  800264:	0017171b          	slliw	a4,a4,0x1
  800268:	9f2d                	addw	a4,a4,a1
                if (ch < '0' || ch > '9') {
  80026a:	fd06069b          	addiw	a3,a2,-48
            for (precision = 0; ; ++ fmt) {
  80026e:	0405                	addi	s0,s0,1
                precision = precision * 10 + ch - '0';
  800270:	fd070c1b          	addiw	s8,a4,-48
                ch = *fmt;
  800274:	0006059b          	sext.w	a1,a2
                if (ch < '0' || ch > '9') {
  800278:	fed870e3          	bgeu	a6,a3,800258 <vprintfmt+0xf0>
            if (width < 0)
  80027c:	f40ddce3          	bgez	s11,8001d4 <vprintfmt+0x6c>
                width = precision, precision = -1;
  800280:	8de2                	mv	s11,s8
  800282:	5c7d                	li	s8,-1
  800284:	bf81                	j	8001d4 <vprintfmt+0x6c>
            if (width < 0)
  800286:	fffdc693          	not	a3,s11
  80028a:	96fd                	srai	a3,a3,0x3f
  80028c:	00ddfdb3          	and	s11,s11,a3
        switch (ch = *(unsigned char *)fmt ++) {
  800290:	00144603          	lbu	a2,1(s0)
  800294:	2d81                	sext.w	s11,s11
  800296:	846a                	mv	s0,s10
            goto reswitch;
  800298:	bf35                	j	8001d4 <vprintfmt+0x6c>
            precision = va_arg(ap, int);
  80029a:	000a2c03          	lw	s8,0(s4)
        switch (ch = *(unsigned char *)fmt ++) {
  80029e:	00144603          	lbu	a2,1(s0)
            precision = va_arg(ap, int);
  8002a2:	0a21                	addi	s4,s4,8
        switch (ch = *(unsigned char *)fmt ++) {
  8002a4:	846a                	mv	s0,s10
            goto process_precision;
  8002a6:	bfd9                	j	80027c <vprintfmt+0x114>
    if (lflag >= 2) {
  8002a8:	4705                	li	a4,1
            precision = va_arg(ap, int);
  8002aa:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  8002ae:	01174463          	blt	a4,a7,8002b6 <vprintfmt+0x14e>
    else if (lflag) {
  8002b2:	1a088e63          	beqz	a7,80046e <vprintfmt+0x306>
        return va_arg(*ap, unsigned long);
  8002b6:	000a3603          	ld	a2,0(s4)
  8002ba:	46c1                	li	a3,16
  8002bc:	8a2e                	mv	s4,a1
            printnum(putch, putdat, num, base, width, padc);
  8002be:	2781                	sext.w	a5,a5
  8002c0:	876e                	mv	a4,s11
  8002c2:	85a6                	mv	a1,s1
  8002c4:	854a                	mv	a0,s2
  8002c6:	e37ff0ef          	jal	ra,8000fc <printnum>
            break;
  8002ca:	bde1                	j	8001a2 <vprintfmt+0x3a>
            putch(va_arg(ap, int), putdat);
  8002cc:	000a2503          	lw	a0,0(s4)
  8002d0:	85a6                	mv	a1,s1
  8002d2:	0a21                	addi	s4,s4,8
  8002d4:	9902                	jalr	s2
            break;
  8002d6:	b5f1                	j	8001a2 <vprintfmt+0x3a>
    if (lflag >= 2) {
  8002d8:	4705                	li	a4,1
            precision = va_arg(ap, int);
  8002da:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  8002de:	01174463          	blt	a4,a7,8002e6 <vprintfmt+0x17e>
    else if (lflag) {
  8002e2:	18088163          	beqz	a7,800464 <vprintfmt+0x2fc>
        return va_arg(*ap, unsigned long);
  8002e6:	000a3603          	ld	a2,0(s4)
  8002ea:	46a9                	li	a3,10
  8002ec:	8a2e                	mv	s4,a1
  8002ee:	bfc1                	j	8002be <vprintfmt+0x156>
        switch (ch = *(unsigned char *)fmt ++) {
  8002f0:	00144603          	lbu	a2,1(s0)
            altflag = 1;
  8002f4:	4c85                	li	s9,1
        switch (ch = *(unsigned char *)fmt ++) {
  8002f6:	846a                	mv	s0,s10
            goto reswitch;
  8002f8:	bdf1                	j	8001d4 <vprintfmt+0x6c>
            putch(ch, putdat);
  8002fa:	85a6                	mv	a1,s1
  8002fc:	02500513          	li	a0,37
  800300:	9902                	jalr	s2
            break;
  800302:	b545                	j	8001a2 <vprintfmt+0x3a>
        switch (ch = *(unsigned char *)fmt ++) {
  800304:	00144603          	lbu	a2,1(s0)
            lflag ++;
  800308:	2885                	addiw	a7,a7,1
        switch (ch = *(unsigned char *)fmt ++) {
  80030a:	846a                	mv	s0,s10
            goto reswitch;
  80030c:	b5e1                	j	8001d4 <vprintfmt+0x6c>
    if (lflag >= 2) {
  80030e:	4705                	li	a4,1
            precision = va_arg(ap, int);
  800310:	008a0593          	addi	a1,s4,8
    if (lflag >= 2) {
  800314:	01174463          	blt	a4,a7,80031c <vprintfmt+0x1b4>
    else if (lflag) {
  800318:	14088163          	beqz	a7,80045a <vprintfmt+0x2f2>
        return va_arg(*ap, unsigned long);
  80031c:	000a3603          	ld	a2,0(s4)
  800320:	46a1                	li	a3,8
  800322:	8a2e                	mv	s4,a1
  800324:	bf69                	j	8002be <vprintfmt+0x156>
            putch('0', putdat);
  800326:	03000513          	li	a0,48
  80032a:	85a6                	mv	a1,s1
  80032c:	e03e                	sd	a5,0(sp)
  80032e:	9902                	jalr	s2
            putch('x', putdat);
  800330:	85a6                	mv	a1,s1
  800332:	07800513          	li	a0,120
  800336:	9902                	jalr	s2
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  800338:	0a21                	addi	s4,s4,8
            goto number;
  80033a:	6782                	ld	a5,0(sp)
  80033c:	46c1                	li	a3,16
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  80033e:	ff8a3603          	ld	a2,-8(s4)
            goto number;
  800342:	bfb5                	j	8002be <vprintfmt+0x156>
            if ((p = va_arg(ap, char *)) == NULL) {
  800344:	000a3403          	ld	s0,0(s4)
  800348:	008a0713          	addi	a4,s4,8
  80034c:	e03a                	sd	a4,0(sp)
  80034e:	14040263          	beqz	s0,800492 <vprintfmt+0x32a>
            if (width > 0 && padc != '-') {
  800352:	0fb05763          	blez	s11,800440 <vprintfmt+0x2d8>
  800356:	02d00693          	li	a3,45
  80035a:	0cd79163          	bne	a5,a3,80041c <vprintfmt+0x2b4>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  80035e:	00044783          	lbu	a5,0(s0)
  800362:	0007851b          	sext.w	a0,a5
  800366:	cf85                	beqz	a5,80039e <vprintfmt+0x236>
  800368:	00140a13          	addi	s4,s0,1
                if (altflag && (ch < ' ' || ch > '~')) {
  80036c:	05e00413          	li	s0,94
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800370:	000c4563          	bltz	s8,80037a <vprintfmt+0x212>
  800374:	3c7d                	addiw	s8,s8,-1
  800376:	036c0263          	beq	s8,s6,80039a <vprintfmt+0x232>
                    putch('?', putdat);
  80037a:	85a6                	mv	a1,s1
                if (altflag && (ch < ' ' || ch > '~')) {
  80037c:	0e0c8e63          	beqz	s9,800478 <vprintfmt+0x310>
  800380:	3781                	addiw	a5,a5,-32
  800382:	0ef47b63          	bgeu	s0,a5,800478 <vprintfmt+0x310>
                    putch('?', putdat);
  800386:	03f00513          	li	a0,63
  80038a:	9902                	jalr	s2
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  80038c:	000a4783          	lbu	a5,0(s4)
  800390:	3dfd                	addiw	s11,s11,-1
  800392:	0a05                	addi	s4,s4,1
  800394:	0007851b          	sext.w	a0,a5
  800398:	ffe1                	bnez	a5,800370 <vprintfmt+0x208>
            for (; width > 0; width --) {
  80039a:	01b05963          	blez	s11,8003ac <vprintfmt+0x244>
  80039e:	3dfd                	addiw	s11,s11,-1
                putch(' ', putdat);
  8003a0:	85a6                	mv	a1,s1
  8003a2:	02000513          	li	a0,32
  8003a6:	9902                	jalr	s2
            for (; width > 0; width --) {
  8003a8:	fe0d9be3          	bnez	s11,80039e <vprintfmt+0x236>
            if ((p = va_arg(ap, char *)) == NULL) {
  8003ac:	6a02                	ld	s4,0(sp)
  8003ae:	bbd5                	j	8001a2 <vprintfmt+0x3a>
    if (lflag >= 2) {
  8003b0:	4705                	li	a4,1
            precision = va_arg(ap, int);
  8003b2:	008a0c93          	addi	s9,s4,8
    if (lflag >= 2) {
  8003b6:	01174463          	blt	a4,a7,8003be <vprintfmt+0x256>
    else if (lflag) {
  8003ba:	08088d63          	beqz	a7,800454 <vprintfmt+0x2ec>
        return va_arg(*ap, long);
  8003be:	000a3403          	ld	s0,0(s4)
            if ((long long)num < 0) {
  8003c2:	0a044d63          	bltz	s0,80047c <vprintfmt+0x314>
            num = getint(&ap, lflag);
  8003c6:	8622                	mv	a2,s0
  8003c8:	8a66                	mv	s4,s9
  8003ca:	46a9                	li	a3,10
  8003cc:	bdcd                	j	8002be <vprintfmt+0x156>
            err = va_arg(ap, int);
  8003ce:	000a2783          	lw	a5,0(s4)
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  8003d2:	4761                	li	a4,24
            err = va_arg(ap, int);
  8003d4:	0a21                	addi	s4,s4,8
            if (err < 0) {
  8003d6:	41f7d69b          	sraiw	a3,a5,0x1f
  8003da:	8fb5                	xor	a5,a5,a3
  8003dc:	40d786bb          	subw	a3,a5,a3
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  8003e0:	02d74163          	blt	a4,a3,800402 <vprintfmt+0x29a>
  8003e4:	00369793          	slli	a5,a3,0x3
  8003e8:	97de                	add	a5,a5,s7
  8003ea:	639c                	ld	a5,0(a5)
  8003ec:	cb99                	beqz	a5,800402 <vprintfmt+0x29a>
                printfmt(putch, putdat, "%s", p);
  8003ee:	86be                	mv	a3,a5
  8003f0:	00000617          	auipc	a2,0x0
  8003f4:	21860613          	addi	a2,a2,536 # 800608 <main+0xc0>
  8003f8:	85a6                	mv	a1,s1
  8003fa:	854a                	mv	a0,s2
  8003fc:	0ce000ef          	jal	ra,8004ca <printfmt>
  800400:	b34d                	j	8001a2 <vprintfmt+0x3a>
                printfmt(putch, putdat, "error %d", err);
  800402:	00000617          	auipc	a2,0x0
  800406:	1f660613          	addi	a2,a2,502 # 8005f8 <main+0xb0>
  80040a:	85a6                	mv	a1,s1
  80040c:	854a                	mv	a0,s2
  80040e:	0bc000ef          	jal	ra,8004ca <printfmt>
  800412:	bb41                	j	8001a2 <vprintfmt+0x3a>
                p = "(null)";
  800414:	00000417          	auipc	s0,0x0
  800418:	1dc40413          	addi	s0,s0,476 # 8005f0 <main+0xa8>
                for (width -= strnlen(p, precision); width > 0; width --) {
  80041c:	85e2                	mv	a1,s8
  80041e:	8522                	mv	a0,s0
  800420:	e43e                	sd	a5,8(sp)
  800422:	0c8000ef          	jal	ra,8004ea <strnlen>
  800426:	40ad8dbb          	subw	s11,s11,a0
  80042a:	01b05b63          	blez	s11,800440 <vprintfmt+0x2d8>
                    putch(padc, putdat);
  80042e:	67a2                	ld	a5,8(sp)
  800430:	00078a1b          	sext.w	s4,a5
                for (width -= strnlen(p, precision); width > 0; width --) {
  800434:	3dfd                	addiw	s11,s11,-1
                    putch(padc, putdat);
  800436:	85a6                	mv	a1,s1
  800438:	8552                	mv	a0,s4
  80043a:	9902                	jalr	s2
                for (width -= strnlen(p, precision); width > 0; width --) {
  80043c:	fe0d9ce3          	bnez	s11,800434 <vprintfmt+0x2cc>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  800440:	00044783          	lbu	a5,0(s0)
  800444:	00140a13          	addi	s4,s0,1
  800448:	0007851b          	sext.w	a0,a5
  80044c:	d3a5                	beqz	a5,8003ac <vprintfmt+0x244>
                if (altflag && (ch < ' ' || ch > '~')) {
  80044e:	05e00413          	li	s0,94
  800452:	bf39                	j	800370 <vprintfmt+0x208>
        return va_arg(*ap, int);
  800454:	000a2403          	lw	s0,0(s4)
  800458:	b7ad                	j	8003c2 <vprintfmt+0x25a>
        return va_arg(*ap, unsigned int);
  80045a:	000a6603          	lwu	a2,0(s4)
  80045e:	46a1                	li	a3,8
  800460:	8a2e                	mv	s4,a1
  800462:	bdb1                	j	8002be <vprintfmt+0x156>
  800464:	000a6603          	lwu	a2,0(s4)
  800468:	46a9                	li	a3,10
  80046a:	8a2e                	mv	s4,a1
  80046c:	bd89                	j	8002be <vprintfmt+0x156>
  80046e:	000a6603          	lwu	a2,0(s4)
  800472:	46c1                	li	a3,16
  800474:	8a2e                	mv	s4,a1
  800476:	b5a1                	j	8002be <vprintfmt+0x156>
                    putch(ch, putdat);
  800478:	9902                	jalr	s2
  80047a:	bf09                	j	80038c <vprintfmt+0x224>
                putch('-', putdat);
  80047c:	85a6                	mv	a1,s1
  80047e:	02d00513          	li	a0,45
  800482:	e03e                	sd	a5,0(sp)
  800484:	9902                	jalr	s2
                num = -(long long)num;
  800486:	6782                	ld	a5,0(sp)
  800488:	8a66                	mv	s4,s9
  80048a:	40800633          	neg	a2,s0
  80048e:	46a9                	li	a3,10
  800490:	b53d                	j	8002be <vprintfmt+0x156>
            if (width > 0 && padc != '-') {
  800492:	03b05163          	blez	s11,8004b4 <vprintfmt+0x34c>
  800496:	02d00693          	li	a3,45
  80049a:	f6d79de3          	bne	a5,a3,800414 <vprintfmt+0x2ac>
                p = "(null)";
  80049e:	00000417          	auipc	s0,0x0
  8004a2:	15240413          	addi	s0,s0,338 # 8005f0 <main+0xa8>
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  8004a6:	02800793          	li	a5,40
  8004aa:	02800513          	li	a0,40
  8004ae:	00140a13          	addi	s4,s0,1
  8004b2:	bd6d                	j	80036c <vprintfmt+0x204>
  8004b4:	00000a17          	auipc	s4,0x0
  8004b8:	13da0a13          	addi	s4,s4,317 # 8005f1 <main+0xa9>
  8004bc:	02800513          	li	a0,40
  8004c0:	02800793          	li	a5,40
                if (altflag && (ch < ' ' || ch > '~')) {
  8004c4:	05e00413          	li	s0,94
  8004c8:	b565                	j	800370 <vprintfmt+0x208>

00000000008004ca <printfmt>:
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004ca:	715d                	addi	sp,sp,-80
    va_start(ap, fmt);
  8004cc:	02810313          	addi	t1,sp,40
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004d0:	f436                	sd	a3,40(sp)
    vprintfmt(putch, putdat, fmt, ap);
  8004d2:	869a                	mv	a3,t1
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  8004d4:	ec06                	sd	ra,24(sp)
  8004d6:	f83a                	sd	a4,48(sp)
  8004d8:	fc3e                	sd	a5,56(sp)
  8004da:	e0c2                	sd	a6,64(sp)
  8004dc:	e4c6                	sd	a7,72(sp)
    va_start(ap, fmt);
  8004de:	e41a                	sd	t1,8(sp)
    vprintfmt(putch, putdat, fmt, ap);
  8004e0:	c89ff0ef          	jal	ra,800168 <vprintfmt>
}
  8004e4:	60e2                	ld	ra,24(sp)
  8004e6:	6161                	addi	sp,sp,80
  8004e8:	8082                	ret

00000000008004ea <strnlen>:
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
    size_t cnt = 0;
  8004ea:	4781                	li	a5,0
    while (cnt < len && *s ++ != '\0') {
  8004ec:	e589                	bnez	a1,8004f6 <strnlen+0xc>
  8004ee:	a811                	j	800502 <strnlen+0x18>
        cnt ++;
  8004f0:	0785                	addi	a5,a5,1
    while (cnt < len && *s ++ != '\0') {
  8004f2:	00f58863          	beq	a1,a5,800502 <strnlen+0x18>
  8004f6:	00f50733          	add	a4,a0,a5
  8004fa:	00074703          	lbu	a4,0(a4)
  8004fe:	fb6d                	bnez	a4,8004f0 <strnlen+0x6>
  800500:	85be                	mv	a1,a5
    }
    return cnt;
}
  800502:	852e                	mv	a0,a1
  800504:	8082                	ret

0000000000800506 <cpu_bound_task>:
#include <string.h>

const int MAX_TIME = 100000000;

// 模拟 CPU 密集型任务
void cpu_bound_task(int pid, int duration) {
  800506:	7179                	addi	sp,sp,-48
  800508:	f022                	sd	s0,32(sp)
  80050a:	ec26                	sd	s1,24(sp)
  80050c:	842e                	mv	s0,a1
  80050e:	84aa                	mv	s1,a0
    int i;
    // 使用 volatile 防止编译器优化掉循环
    volatile int k = 0; 
    cprintf("Process %d (CPU-bound) started.\n", pid);
  800510:	85aa                	mv	a1,a0
  800512:	00000517          	auipc	a0,0x0
  800516:	3de50513          	addi	a0,a0,990 # 8008f0 <error_string+0xc8>
void cpu_bound_task(int pid, int duration) {
  80051a:	f406                	sd	ra,40(sp)
    volatile int k = 0; 
  80051c:	c602                	sw	zero,12(sp)
    cprintf("Process %d (CPU-bound) started.\n", pid);
  80051e:	b23ff0ef          	jal	ra,800040 <cprintf>
    for (i = 0; i < duration; i++) {
  800522:	00805963          	blez	s0,800534 <cpu_bound_task+0x2e>
  800526:	4701                	li	a4,0
        k++;
  800528:	47b2                	lw	a5,12(sp)
    for (i = 0; i < duration; i++) {
  80052a:	2705                	addiw	a4,a4,1
        k++;
  80052c:	2785                	addiw	a5,a5,1
  80052e:	c63e                	sw	a5,12(sp)
    for (i = 0; i < duration; i++) {
  800530:	fee41ce3          	bne	s0,a4,800528 <cpu_bound_task+0x22>
    }
    cprintf("Process %d (CPU-bound) finished.\n", pid);
}
  800534:	7402                	ld	s0,32(sp)
  800536:	70a2                	ld	ra,40(sp)
    cprintf("Process %d (CPU-bound) finished.\n", pid);
  800538:	85a6                	mv	a1,s1
}
  80053a:	64e2                	ld	s1,24(sp)
    cprintf("Process %d (CPU-bound) finished.\n", pid);
  80053c:	00000517          	auipc	a0,0x0
  800540:	3dc50513          	addi	a0,a0,988 # 800918 <error_string+0xf0>
}
  800544:	6145                	addi	sp,sp,48
    cprintf("Process %d (CPU-bound) finished.\n", pid);
  800546:	bced                	j	800040 <cprintf>

0000000000800548 <main>:
        yield(); // 主动让出 CPU，模拟等待 I/O
    }
    cprintf("Process %d (I/O-bound) finished.\n", pid);
}

int main(void) {
  800548:	1101                	addi	sp,sp,-32
  80054a:	e822                	sd	s0,16(sp)
  80054c:	e426                	sd	s1,8(sp)
  80054e:	ec06                	sd	ra,24(sp)
    // 创建混合负载
    // 0, 1: 长作业 (CPU 密集)
    // 2, 3, 4: 短作业 (可以理解为 I/O 密集或只需很短 CPU)
    
    int i;
    for (i = 0; i < 5; i++) {
  800550:	4401                	li	s0,0
    int start_time = gettime_msec(); // 需要在 ulib 中实现或使用系统 tick 估算
  800552:	b9dff0ef          	jal	ra,8000ee <gettime_msec>
    for (i = 0; i < 5; i++) {
  800556:	4495                	li	s1,5
        if ((pids[i] = fork()) == 0) {
  800558:	b8dff0ef          	jal	ra,8000e4 <fork>
  80055c:	c915                	beqz	a0,800590 <main+0x48>
    for (i = 0; i < 5; i++) {
  80055e:	2405                	addiw	s0,s0,1
  800560:	fe941ce3          	bne	s0,s1,800558 <main+0x10>
        }
    }

    // 父进程等待并统计
    for (i = 0; i < 5; i++) {
        wait();
  800564:	b83ff0ef          	jal	ra,8000e6 <wait>
  800568:	b7fff0ef          	jal	ra,8000e6 <wait>
  80056c:	b7bff0ef          	jal	ra,8000e6 <wait>
  800570:	b77ff0ef          	jal	ra,8000e6 <wait>
  800574:	b73ff0ef          	jal	ra,8000e6 <wait>
    }
    
    cprintf("All processes finished.\n");
  800578:	00000517          	auipc	a0,0x0
  80057c:	3c850513          	addi	a0,a0,968 # 800940 <error_string+0x118>
  800580:	ac1ff0ef          	jal	ra,800040 <cprintf>
    return 0;
  800584:	60e2                	ld	ra,24(sp)
  800586:	6442                	ld	s0,16(sp)
  800588:	64a2                	ld	s1,8(sp)
  80058a:	4501                	li	a0,0
  80058c:	6105                	addi	sp,sp,32
  80058e:	8082                	ret
            int current_pid = getpid();
  800590:	b5dff0ef          	jal	ra,8000ec <getpid>
            if (i < 2) {
  800594:	4785                	li	a5,1
  800596:	0087db63          	bge	a5,s0,8005ac <main+0x64>
                cpu_bound_task(current_pid, MAX_TIME / 10);
  80059a:	009895b7          	lui	a1,0x989
  80059e:	68058593          	addi	a1,a1,1664 # 989680 <error_string+0x188e58>
  8005a2:	f65ff0ef          	jal	ra,800506 <cpu_bound_task>
            exit(0);
  8005a6:	4501                	li	a0,0
  8005a8:	b27ff0ef          	jal	ra,8000ce <exit>
                cpu_bound_task(current_pid, MAX_TIME);
  8005ac:	05f5e5b7          	lui	a1,0x5f5e
  8005b0:	10058593          	addi	a1,a1,256 # 5f5e100 <error_string+0x575d8d8>
  8005b4:	f53ff0ef          	jal	ra,800506 <cpu_bound_task>
  8005b8:	b7fd                	j	8005a6 <main+0x5e>
