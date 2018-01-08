.text
.align 4
.global strlen
.type strlen,%function


strlen:
	push {ip, lr}
	mov r2, #0         /* counter = 0; */
loop:
	ldrb r3, [r0]      /* load char until string is over */
	cmp r3, #0
	beq exit
	add r2,r2,#1       /* counter++; */
	add r0, r0, #1    
	bal loop


	
exit:
	mov r0, r2         /* return counter; */
	pop {ip, pc}
	
