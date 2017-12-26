.text
.global main
.extern printf
.extern scanf
.extern strlen
.extern snprintf

main:
	push {ip, lr}

	@ Open file
	ldr r0, =filename
	movw r1, #65 @ #1092 @ O_RDWR | O_CREAT | O_APPEND
	mov r7, #5
	swi 0
	@ r0 has file descriptor
	push { r0 }
	
	ldr r0, =string
	bl printf
	ldr r0, =input
	ldr r1, =str
	bl scanf
	ldr r0, =str
	bl strlen  
	cmp r0, #33
	movgt r0, #33 @ r0 has length of input string 
	mov r7, r0    @ store it in r7
	push {r7}

	ldr r10, =str
	ldrb r3, [r10] @ load first char of string in r10

	cmp r0, #1
	bne loop
	cmp r3, #81
	beq exit
	cmp r3, #113
	beq exit 	@ if 'q' or 'Q' and length 1, exit
	

@ 2.2 starts
ldr r4, =frequency @r4 points at start of frequency array
loop:
	ldr r4, =frequency @r4 points at start of frequency array
	cmp r3, #32
	ble done
	cmp r3, #126
	bgt done
	sub r3, r3, #33
	add r4, r4, r3
	ldrb r5, [r4]
	add r5,r5,#1
	strb r5, [r4]
	
done:
	ldrb r3, [r10, #1]!
	subs r0, r0, #1
	bne loop



/*
ldr r4, =frequency @r4 points at start of frequency array
ldr r10, =str @ r4 still points at start of frequency array 
ldrb r1, [r10]
mov r14, #0
@ r7 has string length
print_loop:
	@ldr r4, =frequency @r4 points at start of frequency array
	ldr r0, =output_msg @ output message format
	
	sub r3, r1, #33 @ indexing in frequency array
	@add r4, r4, r3
	ldrb r2, [r4, r3]
	push {r3, r4, r7, r14}
	cmp r2, #0	@ if frequency[r3] == 0, don't print.
	blne printf
	pop {r3, r4, r7, r14}
	strb r14, [r4, r3]

@ next byte(char) in str
	ldrb r1, [r10, #1]!
	subs r7, r7, #1
	bne print_loop
*/
pop { r7 } 
pop { r0 }
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Don' t use r0... It has fd for write@
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
ldr r8, =frequency @ r8 points at start of frequency array
ldr r10, =str      @ r10 points at start of str
ldrb r3, [r10]     @ character for pretty printing
mov r14, #0	   @ always zero
 
write_loop:
@ r3 has the ascii 
@ r4 has the frequency for this ascii
	ldr r8, =frequency 	 @ r8 points at start of frequency array
	sub r5, r3, #33          @ indexing in frequency array
	add r8, r8, r5		 @ address of desired character in r8
	ldrb r4, [r8]	 	 @ frequency of current character

	cmp r4, #0		 @ if character at r3(ascii) has frequency 
				 @ equal to #0, don't print.
	beq next
				 @ else ...
	strb r14, [r8]	 	 @ make zero the frequency, 
				 @ so as not to print again
	ldr r0, =buffer    
	ldr r1, =BUFLEN
	ldr r2, =format_msg
@ r3 has the ascii for character to be printed	
	push { r0, r7, r8, r10, r14 }
	bl snprintf		 @ buffer created. Now write it to file
	pop { r0, r7, r8, r10, r14 }

@ write system call (#4):
	mov r0, #1
	ldr r1, =buffer
	ldr r2, =BUFLEN
	push { r0, r7 }
	mov r7, #4 		 @ write system call
	swi 0
	pop { r0, r7 }

@ next byte(char) in str
next:
	ldrb r3, [r10, #1]!
	subs r7, r7, #1
	bne write_loop

	pop {ip, pc}

exit:
	ldr r0, =exit_str
	bl printf
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
	buffer: 
		.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
	BUFLEN = . - buffer
	output_str: 
		.ascii "%s\n\0"
	output_msg: 
		.ascii "%c -> %ld\n\0"
	format_msg: 
		.ascii "%c -> %d\n\0"
	output_int: 
		.ascii "%d\n\0"
	exit_str: 
		.ascii "Exiting.\n\0"
	frequency:
		.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
	trans:
		.ascii " -> "
		
.end
