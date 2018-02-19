.text
.align 4
.global strlen
.type strlen,%function


strlen:
	push {ip, lr}
	mov r2, #0
loop:
	ldrb r3, [r0]
	cmp r3, #0
	beq exit
	add r2,r2,#1
	add r0, r0, #1
	bal loop


	
exit:
	mov r0, r2
	pop {ip, pc}
	
