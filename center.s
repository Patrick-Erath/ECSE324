.text
.global _start

_start: 
        LDR R4, =AVERAGE
		LDR R2, [R4, #4] // Size of the list
		LDR R5, [R4, #4] // Size of the list
        LDR R9, [R4, #4] // Size of the list
        ADD R3, R4, #8 // first address in the list
        LDR R0, [R3] 	// r holds the first value in the list
		ADD R6, R4, #8 //first address in the list
		ADD R7, R4, #8  //first address in the list
		LDR R8, [R6] //content of R6 in R8

LOOP:   SUBS R2, R2, #1
        BEQ AVG
        ADD R3, R3, #4
	    LDR R1, [R3]
        ADD R0, R0, R1 
        B LOOP 

AVG:	LSR R9, #1
        CMP R9, #0
		MOV R4, R0 //store the avg in R4
        BLE LOOP2
		ASR R0, #1
		B AVG

LOOP2:  SUBS R5, R5, #1
        BMI END //when <0 exit loop (N subtractions)
		SUB R8, R8, R4
		STR R8, [R7]
		ADD R7, R7, #4
        ADD R6, R6, #4  //Accessing elements in the list
		LDR R8, [R6]
        B LOOP2 

END:    B END

AVERAGE: .word 0
N:       .word 4
NUMBERS: .word 2,4,6,8
		// -3, -1, 1, 3

