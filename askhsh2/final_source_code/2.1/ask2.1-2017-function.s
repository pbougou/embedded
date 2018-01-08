.text
.align 4
.global transform
.type transform,%function

.extern printf
.extern scanf
.extern strlen
.extern getchar

transform:
	push {ip, lr}  ;save program counter - pop it at exit
transform_loop:  ;for every ascii char  
	cmp r3, #47  
	ble done	 ;if lower than char '0' do nothing
	cmp r3, #57
	ble number   ;if char is in {'0','1',...,'9'} 
	cmp r3, #64
	ble done     ;if char in in {':',';','<',...,'@'} do nothing 
	cmp r3, #90
	ble upper    ;if char is uppercase letter
	cmp r3, #96
	ble done     ;if char is in {'[','\',...,'_'} do nothing
	cmp r3, #122
	ble lower    ;if char is lowercase letter   
	bal done     ;else do nothing

number:
	cmp r3, #52       
	addle r3, r3, #5  ;if number is less or equal to 4 just add 5
	subgt r3, r3, #5  ;else subtract 5
	bal done

upper:
	add r3, r3, #32   ;the correspondant lowercase letter is +32 places in ascii table
	bal done
	
lower:
	sub r3, #32       ; -32 places
	
done:
	strb r3, [r10]      ; save, load next char, check if remaining length is 0, loop again
	ldrb r3, [r10, #1]!
	subs r0, r0, #1
	bne transform_loop
	
	pop {ip, pc} 

