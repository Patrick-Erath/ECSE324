.text
.global _start

_start: 
        LDR R4, INPUT
	PUSH {R4, LR}
        MOV R0, #0
        BL LOOP
        STR R0, RESULT
        LDR R4, [SP]
        LDR LR, [SP, #4]
        ADD SP, SP, #8 
        B END

LOOP:   LDR R4, [SP]
FIB:    CMP R4, #2
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
