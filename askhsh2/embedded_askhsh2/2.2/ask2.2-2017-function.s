.text
.global transform
.align 4
.type transform, %function

.extern printf
.extern scanf
.extern strlen
.extern snprintf
.extern strcpy
.extern memset

@ r3  : first byte of str
@ r6  : file descriptor
@ r9  : address of frequency array
@ r10 : address of str(input string)

transform:
push { ip, lr }
@ r10 is modified in loop
push { r0, r1, r2, r3, r6, r7, r9, r10 }

mov r0, r7 @ str length
loop:
	mov r4, r9
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
	
pop { r0, r1, r2, r3, r6, r7, r9, r10 }

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@ Don' t use r6... It has fd for write @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
mov r14, #0

@ write loop with unix open and write system calls
write_loop:
				 @ r3 has the ascii 
				 @ r4 has the frequency for this ascii
	mov r8, r9               @ r8 points at start of frequency array
	sub r5, r3, #33          @ indexing in frequency array
	add r8, r8, r5           @ address of desired character in r8
	ldrb r4, [r8]	 	 @ frequency of current character

	cmp r4, #0		 @ if character at r3(ascii) has frequency 
				 @ equal to #0, don't print.
	beq next
				 @ else ...
	strb r14, [r8]	 	 @ make zero the frequency, 
				 @ so as not to print again

	@ r3 has the ascii for character to be printed
	ldr r0, =buffer    
	ldr r1, =BUFLEN
	ldr r2, =format_msg
	push { r4, r6, r7, r9, r10, r14 }
	bl snprintf		 @ buffer created. Now write it to file
	pop { r4, r6, r7, r9, r10, r14 }


	@ write system call (#4):
	push { r0, r1, r2, r6, r7, r9, r10, r14 }
	mov r0, r6
	ldr r1, =buffer
	ldr r2, =BUFLEN
	mov r7, #4 		 @ write system call
	swi 0
	pop  { r0, r1, r2, r6, r7, r9, r10, r14 }

@ next byte(char) in str
next:
	ldrb r3, [r10, #1]!
	subs r7, r7, #1
	bne write_loop


pop { ip, pc } 
.data
	buffer: 
                .ascii "\0\0\0\0\0\0\0\0\0"
        BUFLEN = . - buffer
        format_msg: 
                .ascii "%c -> %ld\n\0"
