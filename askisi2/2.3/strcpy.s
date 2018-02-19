.text
.align 4
.global strcpy_
.type strcpy_,%function


strcpy_:
	push {ip, lr}
	
	
loop:
	ldrb r2, [r1]
	cmp r2, #0
	beq exit
	strb r2, [r0]
	add r0, r0, #1
	add r1, r1, #1
	bal loop


	
exit:
	mov r4, #0
	strb r4, [r0]
	pop {ip, pc}
	
