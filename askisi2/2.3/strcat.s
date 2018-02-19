.text
.align 4
.global strcat
.type strcat, %function


strcat:
	push {ip, lr}
	
loop_over_dest:
	ldrb r3, [r0]
	cmp r3, #0
	beq concat	
	add r0, r0, #1
	bal loop_over_dest
	
concat:
	ldrb r2, [r1]
	cmp r2, #0
	beq exit
	strb r2, [r0]
	add r0, r0, #1
	add r1, r1, #1
	bal concat

exit:
	mov r4, #0
	strb r4, [r0]
	pop {ip, pc}
	
