.text
.align 4
.global strcat
.type strcat, %function


strcat:
	push {ip, lr} 
	
loop_over_dest:          /* first traverse the destination string until null terminating */
	ldrb r3, [r0]        /* char '\0' is found. */
	cmp r3, #0
	beq concat	
	add r0, r0, #1
	bal loop_over_dest
	
concat:                  /* replace '\0' of dest string with first char of src string */
	ldrb r2, [r1]        /* just copy the rest src string */
	cmp r2, #0
	beq exit
	strb r2, [r0]
	add r0, r0, #1
	add r1, r1, #1
	bal concat

exit:
	mov r4, #0           /* make the destination string a valid null terminating string */
	strb r4, [r0]      
	pop {ip, pc}
	
