.text
.align 4
.global strcmp
.type strcmp,%function


strcmp:
	push {ip, lr}
	
	
loop:
	ldrb r2, [r0]
	ldrb r3, [r1]



	cmp r2, #0       /* if first string is over or second string is over or they differ*/
	beq exit         /* go exit and decide which string is bigger*/
	cmp r3, #0
	beq exit
	cmp r2, r3
	bne exit

	add r0, r0, #1
	add r1, r1, #1
	bal loop         /* loop again with the next pair of chars */


exit:
	cmp r2, r3
	movlt r0, #-1    /* this is the first time they differ. If first's string char is lower */
	movgt r0, #1     /* then return -1, if greater then 1, if equal return 0 */
	moveq r0, #0
	pop {ip, pc}
	
	
