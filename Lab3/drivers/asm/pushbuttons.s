	.text
		.equ PUSH_BUTTON_DATA, 0xFF200050
		.equ PUSH_BUTTON_MASK, 0xFF200058
		.equ PUSH_BUTTON_EDGE, 0xFF20005C
		.global read_PB_data_ASM
		.global PB_data_is_pressed_ASM
		.global read_PB_edgecap_ASM
		.global PB_edgecap_is_pressed_ASM
		.global PB_clear_edgecap_ASM
		.global enable_PB_INT_ASM
		.global disable_PB_INT_ASM

read_PB_data_ASM:					//only access the pushbutton data register
		LDR R1, =PUSH_BUTTON_DATA	
		LDR R0, [R1]				//load the contents of the pushbutton register into R1
		BX LR						//USE R0 to pass arguments back		

PB_data_is_pressed_ASM:				//R0 contains which button to check, hot-one encoding
		LDR R1, =PUSH_BUTTON_DATA	
		LDR R2, [R1]				//load contents of register into R2
		AND R2, R2, R0
		CMP R2, R0
		MOVEQ R0, #1				//True if equal
		MOVNE R0, #0				//false, the button isnt pressed
		BX LR

read_PB_edgecap_ASM:				//no input, only access edgecapture register
		LDR R1, =PUSH_BUTTON_EDGE	
		LDR R0, [R1]				//load the contents of the pushbutton register into R1
		AND R0, R0, #0xF			//Get only edge cap bits
		BX LR						//USE R0 to pass arguments back		
		
PB_edgecap_is_pressed_ASM:			//R0 contains which button to check, hot-one encoding
		LDR R1, =PUSH_BUTTON_EDGE	
		LDR R2, [R1]				//load contents of register into R2
		AND R2, R2, R0
		CMP R2, R0
		MOVEQ R0, #1				//True if equal
		MOVNE R0, #0				//false, the button isnt pressed
		BX LR

PB_clear_edgecap_ASM:				//R0 contains which pushbutton
		LDR R1, =PUSH_BUTTON_EDGE
		MOV R2, R0					//storing any value in edgecap will reset, p.21 (anything but #0) would work
		STR R2, [R1]
		BX LR

enable_PB_INT_ASM:					//R0 contains which button to enable, hot-one encoding
		LDR R1, =PUSH_BUTTON_MASK
		AND R2, R0, #0xF			//since pushbuttons has only 4 digits that are used, use 0xF
		STR R2, [R1]				//store it back into location
		BX LR

disable_PB_INT_ASM:					//R0 is hot-one encoding of which button to disable
		LDR R1, =PUSH_BUTTON_MASK	//load mask location
		LDR R2, [R1]				//load mask bits
		BIC R2, R2, R0				//AND on the complement of R0
		STR R2, [R1]				//store it back into the mask
		BX LR
		.end