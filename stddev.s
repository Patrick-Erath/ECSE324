.text
.global _start

_start: 
        LDR R4, =MAX  		//R4 points to the MAX location 
		LDR R5, =MIN		//R5 points to the MIN location
		LDR R2, [R4, #12] 	//R2 holds the number of elements in the list
        ADD R3, R4, #16 	//Points to the first number in the list
        LDR R0, [R3] 		//R0 holds the value of first number in the list of R3
        LDR R6, [R3]		//R6 holds the value of first number in the list of R3
        LDR R7, =RESULT		//Load RESULT into R7

LOOP:   SUBS R2, R2, #1		//Decrement the loop counter (The number of elements in the list) by 1  	
        BEQ DONE			//Exit Loop when done, ie once R2 reaches 0
        ADD R3, R3, #4 		//R3 points to the next number in the list
	    LDR R1, [R3] 		//Load content of R3 in R1, such that R1 holds the next number in the list
        CMP R0, R1 			//if R1>R0, update R0 to new max (ie to R1), if not go to branch mini and update the minimum
        BGE MINI 			//Branch to mini 
        MOV R0, R1			//Update R0 to the new max
        B LOOP 				// Branch back to the beggining of the loop

MINI: 	MOV R6, R1			//Move R1 into R6 such that R6 stores the current minimum
		B LOOP

DONE:   STR R0, [R4] 		// Store MAX value [R4] into R0
        STR R6, [R5] 		// Store MIN value [R5] into R6
        B FINAL		 		// Move to FINAL

FINAL:  SUB R7, R0, R6 		//Subtract R0 and R6 and store it in R7 (ie R7<- MAX-MIN)
        ASR R7, R7, #2 		//Divide R7 by 2 to the power of 2 and store in R7  (ie R7<- R7/4)
        STR R7, RESULT		//Store RESULT
        B END				//Exit Loop

END:    B END				// Infite loop

MAX:     .word 0			//Initial memory assigned to MAX value
MIN:     .word 0			//Initial memory assigned to MIN value
RESULT:  .word 0			//Initial memory assigned to RESULT value
N:       .word 4			//Initial memory assigned to Size of list N value
NUMBERS: .word 2, 8, 3, 1	//List Data