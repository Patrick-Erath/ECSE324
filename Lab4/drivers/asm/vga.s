	.text
	
	.equ VGA_PIXEL_BUF_BASE, 0xC8000000
	.equ VGA_CHAR_BUF_BASE, 0xC9000000

	.global VGA_clear_charbuff_ASM
	.global VGA_clear_pixelbuff_ASM
	.global VGA_write_char_ASM
	.global VGA_write_byte_ASM
	.global VGA_draw_point_ASM
		
VGA_clear_pixelbuff_ASM:
	PUSH {R4-R5}	
	MOV R2, #0
	LDR R3, =VGA_PIXEL_BUF_BASE

	MOV R0, #0
PIXEL_LOOPX:
	MOV R1, #0
	ADD R4, R3, R0, LSL #1
PIXEL_LOOPY:
	ADD R5, R4, R1, LSL #10
	
	STRH R2, [R5]
	
	ADD R1, R1, #1
	CMP R1, #240
	BLT PIXEL_LOOPY
	
	ADD R0, R0, #1
	CMP R0, #320
	BLT PIXEL_LOOPX

	POP {R4-R5}
	BX LR

VGA_draw_point_ASM:
	LDR R3, =319 // x coordinate
	CMP R0, #0
	BXLT LR
	CMP R1, #0 //y coordinate
	BXLT LR
	CMP R0, R3 // compare x coord to its max value
	BXGT LR
	CMP R1, #239 //compare y coord to max value
	BXGT LR
	
	LDR R3, =VGA_PIXEL_BUF_BASE
	ADD R3, R3, R0, LSL #1 // pushes x coordinate one bit to the left
	ADD R3, R3, R1, LSL #10 //pushes y coordinate one bit to the left , R3 contains the x , y  and base address 
	STRH R2, [R3] //store the halfword pixel (write on screen)
	BX LR
	
VGA_clear_charbuff_ASM:
	PUSH {R3-R4}
	MOV R2, #0
	LDR R3, =VGA_CHAR_BUF_BASE
	MOV R0, #0 //x coord
LOOP1: 
	MOV R1, #0 // y coord
	ADD R4, R3, R0, LSL #1
LOOP2:
	ADD R5, R4, R1, LSL #7
	STRH R2, [R5]
	
	ADD R1, R1,#1
	CMP R1, #60
	BLT LOOP2
	
	ADD R0, R0, #1
	CMP R0, #80
	BLT LOOP1
	
	POP {R4-R5}
	BX LR

VGA_write_char_ASM:
	LDR R3 ,=VGA_CHAR_BUF_BASE
	CMP R0, #0
	BXLT LR
	CMP R1, #0
	BXLT LR
	CMP R0, #79
	BXGT LR
	CMP R1, #59
	BXGT LR
	
	ADD R3, R3, R0
	ADD R3, R3, R1, LSL #7
	STRB R2, [R3]

	BX LR
	
VGA_write_byte_ASM:
	LDR R3 ,=VGA_CHAR_BUF_BASE //checking limits
	CMP R0, #0
	BXLT LR
	CMP R1, #0
	BXLT LR
	CMP R0, #79
	BXGT LR
	CMP R1, #59
	BXGT LR
	
	MOV R5, #0
	MOV R6, #0
	MOV R7, #0

	PUSH {R5-R7}
	
	ADD R3, R3, R0
	ADD R3, R3, R1, LSL #7
	AND R5, R2, #0xF0  //240
	AND R6, R2, #0x0F //15 clear everything except first byte
	LSR R5, R5, #4

	LDR R4, =HEX_ASCII
	ADD R7, R4, R6
	ADD R4, R4, R5
	LDRB R4, [R4]
	STRB R4, [R3]

	LDRB R7, [R7]
	STRB R7, [R3, #1]
	POP {R5-R7}
	
	 
	
	BX LR
	
HEX_ASCII:
	.byte 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46
	//      0     1     2     3     4     5     6     7     8     9     A     B     C     D     E     F  // 
	.end
	
