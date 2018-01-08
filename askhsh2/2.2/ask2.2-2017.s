.text
.global main
.extern printf
.extern scanf
.extern strlen
.extern snprintf
.extern strcpy
.extern memset

main:
	push {ip, lr}

	@ Open file
	ldr r0, =filename
	movw r1, #65 
			@ #1092 @ O_RDWR | O_CREAT | O_APPEND
	mov r7, #5
	swi 0
	@ r0 has file descriptor
	mov r6, r0
again:
	push { r6 }
	
	ldr r0, =string
	bl printf

@ Initialize frequency array
	ldr r0, =frequency
	mov r1, #0
	ldr r2, =freqlen
	bl memset

	ldr r0, =input
	ldr r1, =str
	bl scanf
	bl getchar    @ clear input stream

	ldr r0, =str
	bl strlen  
	cmp r0, #33
	movgt r0, #33 @ r0 has length of input string 
	mov r7, r0    @ store it in r7

	ldr r10, =str
	ldrb r3, [r10] @ load first char of string in r10

	@ Transform calling conventions:
	@       address of buffer : r0
	@       buffer length     : r1
	@       format msg        : r2
	@ 	first byte of str : r3
	@	file desriptor    : r6
	@       length str        : r7
	@ 	frequency address : r9
	@ 	str address	  : r10

	
	ldr r9, =frequency
	pop { r6 }

	cmp r0, #1
	bne transform_label
	cmp r3, #81
	beq exit
	cmp r3, #113
	beq exit 	@ if 'q' or 'Q' and length 1, exit
	
transform_label:
	bl transform
	
	mov r0, r6
	ldr r1, =newline
	ldr r2, =newline_len
	mov r7, #4
	push { r6 }
	swi 0
	pop { r6 }	
	
	b again
exit:
	mov r0, r6
	ldr r1, =exit_str
	ldr r2, =exit_str_len
	mov r7, #4
	swi 0

	/***************** 
	 * close fd here *  
	 *****************/
	mov r0, r6
	mov r7, #6
	swi 0
	
@	pop { r6 }

	pop {ip, pc}


.data
	filename:
		.ascii "outfile\0"
	string: 
		.ascii "Input a string up to 32 chars long: \0"
	input: 
		.ascii "%[^\n]s\0"
	str: 
		.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
	len = . - str
	buffer: 
		.ascii "\0\0\0\0\0\0\0\0\0"
	BUFLEN = . - buffer
	output_str: 
		.ascii "%s\n\0"
	output_msg: 
		.ascii "%c -> %ld\n\0"
	format_msg: 
		.ascii "%c -> %ld\n\0"
	output_int: 
		.ascii "%d\n\0"
	exit_str: 
		.ascii "Exiting...\n\0"
	exit_str_len = . - exit_str
	frequency:
		.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
	freqlen = . - frequency
	newline: 
		.ascii "\n\0"
	newline_len = . - newline

.end

/**************************************************************************** 
 *	Print loop with c library
 ****************************************************************************
 *	ldr r4, =frequency @r4 points at start of frequency array
 *	ldr r10, =str @ r4 still points at start of frequency array 
 *	ldrb r1, [r10]
 *	mov r14, #0
 *	@ r7 has string length
 *	print_loop:
 *		@ldr r4, =frequency @r4 points at start of frequency array
 *		ldr r0, =output_msg @ output message format
 *		
 *		sub r3, r1, #33 @ indexing in frequency array
 *		@add r4, r4, r3
 *		ldrb r2, [r4, r3]
 *		push {r3, r4, r7, r14}
 *		cmp r2, #0	@ if frequency[r3] == 0, don't print.
 *		blne printf
 *		pop {r3, r4, r7, r14}
 *		strb r14, [r4, r3]
 *
 *	@ next byte(char) in str
 *		ldrb r1, [r10, #1]!
 *		subs r7, r7, #1
 *		bne print_loop
 ****************************************************************************/


