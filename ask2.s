	.file	"ask2.c"
	.section	.rodata
.LC0:
	.string	"%s"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	-48(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movzbl	-48(%rbp), %eax
	cmpb	$113, %al
	je	.L2
	movzbl	-48(%rbp), %eax
	cmpb	$81, %al
	jne	.L3
.L2:
	movzbl	-47(%rbp), %eax
	testb	%al, %al
	je	.L14
.L3:
	leaq	-48(%rbp), %rax
	movq	%rax, -56(%rbp)
	jmp	.L5
.L10:
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$47, %al
	jle	.L6
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$52, %al
	jg	.L6
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	addl	$5, %eax
	movl	%eax, %edx
	movq	-56(%rbp), %rax
	movb	%dl, (%rax)
	jmp	.L7
.L6:
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$52, %al
	jle	.L8
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$57, %al
	jg	.L8
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	subl	$5, %eax
	movl	%eax, %edx
	movq	-56(%rbp), %rax
	movb	%dl, (%rax)
	jmp	.L7
.L8:
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$64, %al
	jle	.L9
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$90, %al
	jg	.L9
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	addl	$32, %eax
	movl	%eax, %edx
	movq	-56(%rbp), %rax
	movb	%dl, (%rax)
	jmp	.L7
.L9:
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$96, %al
	jle	.L7
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$122, %al
	jg	.L7
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	subl	$32, %eax
	movl	%eax, %edx
	movq	-56(%rbp), %rax
	movb	%dl, (%rax)
.L7:
	addq	$1, -56(%rbp)
.L5:
	movq	-56(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L10
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$0, %eax
	jmp	.L11
.L14:
	nop
	movl	$0, %eax
.L11:
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L12
	call	__stack_chk_fail@PLT
.L12:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 7.2.0-8ubuntu3) 7.2.0"
	.section	.note.GNU-stack,"",@progbits
