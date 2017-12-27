.text
.align 4
.global transform
.type transform,%function

.extern printf
.extern scanf
.extern strlen
.extern getchar
/*
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
	bne main_loop
	cmp r3, #81
	beq exit
	cmp r3, #113
	beq exit
*/
transform:
	push {ip, lr} 
transform_loop:
	cmp r3, #47
	ble done
	cmp r3, #57
	ble number
	cmp r3, #64
	ble done
	cmp r3, #90
	ble upper
	cmp r3, #96
	ble done
	cmp r3, #122
	ble lower
	bal done

number:
	cmp r3, #52
	addle r3, r3, #5
	subgt r3, r3, #5
	bal done

upper:
	add r3, r3, #32
	bal done
	
lower:
	sub r3, #32
	
done:
	strb r3, [r10]
	ldrb r3, [r10, #1]!
	subs r0, r0, #1
	bne transform_loop
	
	pop {ip, pc} 
/*	


	ldr r0, =output_str
	ldr r1, =str
	bl printf
	ldr r0, =output_int
@	ldr r1, =len
@	bl printf

	bal again
	pop {ip, pc} 

exit:
	ldr r0, =exit_str
	bl printf
	add r0,r0,r0
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
*/
