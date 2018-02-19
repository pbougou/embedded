.text
.align 4
.global transform
.type transform,%function

.extern printf
.extern scanf
.extern strlen
.extern getchar

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

