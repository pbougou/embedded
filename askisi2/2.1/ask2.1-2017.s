.text
.global main
.extern printf
.extern scanf
.extern strlen
.extern getchar
.extern transform

main:
	push {ip, lr} 
again:
	ldr r0, =string
	bl printf

	ldr r0, =input
	ldr r1, =str
	bl scanf
	bl getchar

	ldr r0, =str
	bl strlen  
	cmp r0, #33
	movgt r0, #33

	ldr r10, =str
	ldrb r3, [r10]

	cmp r0, #1
	blne transform
	cmp r3, #81
	beq exit
	cmp r3, #113
	beq exit
<<<<<<< Updated upstream



	ldr r0, =output_str
	ldr r1, =str
	bl printf
	ldr r0, =output_int
=======
	
    ldr r0, =output_str
	ldr r1, =str
	bl printf
>>>>>>> Stashed changes

	bal again
	pop {ip, pc} 

exit:
	ldr r0, =exit_str
	bl printf
	pop {ip, pc} 

.data
	string: .ascii "Input a string up to 32 chars long: \0"
	input: .ascii "%[^\n]s\0"
	str: .ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
	len = . - str
	output_str: .ascii "%s\n\0"
	output_int: .ascii "%d\n\0"
	exit_str: .ascii "Exiting.\n\0"
.end
