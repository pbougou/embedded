.text
.global main
.extern printf
.extern scanf
.extern strlen


main:
	push {ip, lr}

	ldr r0, =string
	bl printf
	ldr r0, =input
	ldr r1, =str
	bl scanf
	ldr r0, =str
	bl strlen  
	cmp r0, #33
	movgt r0, #33 @ r0 has length of input string 
	mov r7, r0

	ldr r10, =str
	ldrb r3, [r10] @ load first char of string in r10

	cmp r0, #1
	bne loop
	cmp r3, #81
	beq exit
	cmp r3, #113
	beq exit 	@ if 'q' or 'Q' and length 1, exit


@ 2.2 starts
@ ldr r4, =frequency @r4 points at start of frequency array
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


ldr r4, =frequency @r4 points at start of frequency array
ldr r10, =str @ r4 still points at start of frequency array 
ldrb r1, [r10]
@ r7 has string length
print_loop:
	ldr r4, =frequency @r4 points at start of frequency array
	ldr r0, =output_msg @ output message format
	
	sub r3, r1, #33 @ indexing in frequency array
	add r4, r4, r3
	ldr r2, [r4]	 
	cmp r2, #0	@ if frequency[r3] == 0, don't print.
	blne printf
	mov r2, #0
	strb r2, [r4]

@ next byte(char) in str 
	ldrb r1, [r10, #1]!
	subs r7, r7, #1
	bne print_loop
	pop {ip, pc} 

exit:
	ldr r0, =exit_str
	bl printf
	pop {ip, pc} 

.data
	string: 
		.ascii "Input a string up to 32 chars long: \0"
	input: 
		.ascii "%[^\n]s\0"
	str: 
		.ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"

	len = . - str

	output_str: 
		.ascii "%s\n\0"
	output_msg: 
		.ascii "%c -> %d\n\0"
	output_int: 
		.ascii "%d\n"
	exit_str: 
		.ascii "Exiting.\n\0"
@ byte addressing logic
	.balign 4
    	frequency: 
		.skip 94
.end
