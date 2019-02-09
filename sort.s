.text
.global _start

_start: 
		LDR R4, =RESULT
		MOV R6, #0 //flag, boolean  value ( goes to 1 when swap happens)
		LDR R2, [R4, #4] //counter
        ADD R3, R4, #8  //adress of first nb in the list
		LDR R1, [R3]     //load content of R3 in R1
		ADD R5, R4, #8  //address of first nb in the list
        LDR R0, [R5]     //load content of R5 in R0

//Bubble sort
LOOP:   SUBS R2, R2, #1 //counter
        BEQ LOOP3
        ADD R3, R3, #4 //increment R3, R3 is now the 2nd element in the list

	    LDR R1, [R3]  //load in R1 the content of R3
		LDR R0, [R5]     //load content of R5 in R0

        CMP R0, R1	// if R1<R0, swap sinon loop
		
        BLE LOOP2 // loop
     	
		//swap
		STR R1, [R5]
		STR R0, [R3]
		ADD R5, R5, #4 //increment R5
	
		//FLAG is set to 1 when swap happens
		MOV R6, #1

        B LOOP 


LOOP2: ADD R5, R5, #4
       B LOOP

LOOP3: LDR R2, [R4, #4] //counter (Resetting everything)
	   ADD R5, R4, #8  //address of first nb in the list
       ADD R3, R4, #8  //adress of first nb in the list
	   CMP R6, #0  //if flag is zero, no swaps happened so array is sorted
	   BEQ END
	   MOV R6, #0 //reset flag, sinon infinite loop
	   B LOOP
   

END:    B END

RESULT:  .word 0
N:       .word 4
NUMBERS: .word 4, 5, 9, 2
        
