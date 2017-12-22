.text
.align 4
.global strcmp
.type strcmp,%function


strcmp:
	push {ip, lr}
	
	
loop:
	ldrb r2, [r0]
	ldrb r3, [r1]



	cmp r2, #0
	beq exit
	cmp r3, #0
	beq exit
	cmp r2, r3
	bne exit

	add r0, r0, #1
	add r1, r1, #1
	bal loop


exit:
	cmp r2, r3
	movlt r0, #-1
	movgt r0, #1
	moveq r0, #0
	pop {ip, pc}
	
	
