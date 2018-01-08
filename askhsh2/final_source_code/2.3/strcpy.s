.text
.align 4
.global strcpy
.type strcpy,%function


strcpy:
	push {ip, lr}
	
	
loop:
	ldrb r2, [r1]    /*load source char until source string is over*/
	cmp r2, #0
	beq exit
	strb r2, [r0]    /*store the source char to destination */
	add r0, r0, #1
	add r1, r1, #1
	bal loop         /*loop*/


	
exit:
	mov r4, #0       /*null terminate the destination string*/
	strb r4, [r0]
	pop {ip, pc}
	
