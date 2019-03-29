.text

	.equ PS_2_BASE, 0xFF200100
	
	.global read_PS2_data_ASM
	
	
read_PS2_data_ASM:
	PUSH {R1-R5}
	LDR R4, =PS_2_BASE 
	LDR R5, [R4]	
	ANDS R3, R5, #0x8000 
	BNE RETURN  
	MOV R0, #0	
	POP {R1-R5}
	BX LR
	

RETURN: 
	AND R2, R5, #0xFF
	STRB R2, [R0]
	MOV R0, #1
	POP {R1-R5}
	BX LR	


	
	
.end
