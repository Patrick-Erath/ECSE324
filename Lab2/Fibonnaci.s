.text
.global _start

_start: 
        LDR R4, INPUT        #Load into R4 starting address of INPUT (pointer)
	PUSH {R4, LR}        #Push linked register and R4 onto stack
        MOV R0, #0           #Initilalize R0 to 0
        BL LOOP              #Branch&Link to loop
        STR R0, RESULT
        LDR R4, [SP]
        LDR LR, [SP, #4]
        ADD SP, SP, #8 
        B END

LOOP:   LDR R4, [SP]         #Store in R4 value @ address SP
FIB:    CMP R4, #2           #Computer R4-2 and set flags
        ADDLT R0, #1
        BXLT LR
        SUB R4, R4, #2
        PUSH {LR}
        BL FIB
        POP {LR}
        ADD R4, R4, #1 
        PUSH {LR}
        BL FIB 
        POP {LR}
	ADD R4, R4, #1 
        BX LR
       
END:    B END                                                                                             

INPUT:  .word 12
RESULT: .word 0
