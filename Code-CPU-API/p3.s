	.file	"p3.c"
	.section	.rodata
.LC0:
	.string	"hello world (pid:%d)\n"
.LC1:
	.string	"fork failed\n"
.LC2:
	.string	"hello, I am child (pid:%d)\n"
.LC3:
	.string	"wc"
.LC4:
	.string	"p3.c"
.LC5:
	.string	"this shouldn't print out"
	.align 8
.LC6:
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
	subq	$64, %rsp
	movl	%edi, -52(%rbp)
	movq	%rsi, -64(%rbp)
	call	getpid
	movl	%eax, %esi
	movl	$.LC0, %edi
	movl	$0, %eax
	call	printf
	call	fork
	movl	%eax, -40(%rbp)
	cmpl	$0, -40(%rbp)
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
	cmpl	$0, -40(%rbp)
	jne	.L3
	call	getpid
	movl	%eax, %esi
	movl	$.LC2, %edi
	movl	$0, %eax
	call	printf
	movl	$.LC3, %edi
	call	strdup
	movq	%rax, -32(%rbp)
	movl	$.LC4, %edi
	call	strdup
	movq	%rax, -24(%rbp)
	movq	$0, -16(%rbp)
	movq	-32(%rbp), %rax
	leaq	-32(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	execvp
	movl	$.LC5, %edi
	movl	$0, %eax
	call	printf
	jmp	.L4
.L3:
	movl	$0, %eax
	movq	%rax, %rdi
	call	wait
	movl	%eax, -36(%rbp)
	call	getpid
	movl	%eax, %ecx
	movl	-36(%rbp), %edx
	movl	-40(%rbp), %eax
	movl	%eax, %esi
	movl	$.LC6, %edi
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
