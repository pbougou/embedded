.text
.global main
.extern printf
.extern scanf
.extern strlen
.extern getchar
.extern transform
.extern strcpy

main:
	push {ip, lr}     
again:
	ldr r0, =str          ;save str address to r0
	ldr r1, =cleanstr     ;save cleanstr address to r1
	bl strcpy             ;copy a cleanstr to str in every loop

	ldr r0, =print_str    ;save print_str address to r0
	ldr r1, =string       ;save string addres to r1
	bl printf             ; equavalent to printf("%s\0", string);

	ldr r0, =input        ; input is "%[^\n]s\0" -> regex for scanf
	ldr r1, =str          ; str is a clean string "\0\0\0\0...\0"
	bl scanf              ; scanf will save whole line until new line INCLUDING space
	bl getchar            ; finally consume the new line character

	ldr r0, =str          ; if length of input string is greater than 33 make it 33
	bl strlen  
	cmp r0, #33
	movgt r0, #33

	ldr r10, =str         ; load the first letter
	ldrb r3, [r10]
	add r11, r10, r0
	mov r12, #0           ; make the input string  null terminating in any case
	strb r12, [r11]

	cmp r0, #1            ; if input is not q or Q then go transform it
	blne transform        ; external function call to transform function
	cmp r3, #81
	beq exit
	cmp r3, #113
	beq exit


	ldr r0, =output_str   ; output_str is "%s\n\0"
	ldr r1, =str          ; str is the resulting string
	bl printf

	bal again             ; jump again, program exits only in 'q' or 'Q' input
	pop {ip, pc} 

exit:
	ldr r0, =exit_str     ; 'q' or 'Q' received, load exit_str = "Exiting.\n\0"
	bl printf
	pop {ip, pc} 

.data
	string: .ascii "Input a string up to 32 chars long: \0"
	str_len = . - string
	input: .ascii "%[^\n]s\0"
	str: .ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
	cleanstr: .ascii "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
	len = . - str
	output_str: .ascii "%s\n\0"
	print_str: .ascii "%s\0"
	output_int: .ascii "%d\n\0"
	exit_str: .ascii "Exiting.\n\0"
.end
