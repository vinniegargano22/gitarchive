	.file	"p2.c"
	.section	.rodata
.LC0:
	.string	"hello world (pid:%d)\n"
.LC1:
	.string	"fork failed\n"
.LC2:
	.string	"hello, I am child (pid:%d)\n"
	.align 8
.LC3:
	.string	"hello, I am parent of %d (wc:%d) (pid:%d)\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB2:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	call	getpid
	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	call	fork
	movl	%eax, -8(%rbp)
	cmpl	$0, -8(%rbp)
	jns	.L2
	movq	stderr(%rip), %rax
	movq	%rax, %rcx
	movl	$12, %edx
	movl	$1, %esi
	movl	$.LC1, %edi
	call	fwrite
	movl	$1, %edi
	call	exit
.L2:
	cmpl	$0, -8(%rbp)
	jne	.L3
	call	getpid
	movl	%eax, %esi
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
	movl	$1, %edi
	call	sleep
	jmp	.L4
.L3:
	movl	$0, %eax
	movq	%rax, %rdi
	call	wait
	movl	%eax, -4(%rbp)
	call	getpid
	movl	%eax, %ecx
	movl	-4(%rbp), %edx
	movl	-8(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC3, %edi
	movl	$0, %eax
	call	printf
.L4:
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4"
	.section	.note.GNU-stack,"",@progbits
