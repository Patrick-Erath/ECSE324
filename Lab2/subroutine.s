.text
.global _start

_start: 
        LDR R4, =RESULT
        LDR R2, N
        ADD R3, R4, #8
        LDR R0, [R3]
        PUSH { R2, R3, LR}
        BL MAXI
        LDR R0, [SP]
        STR R0, [R4]
        LDR LR, [SP, #8]
        ADD SP, SP, #12
        B END

MAXI:   PUSH {R0-R3}
        LDR R2, [SP, #16]
        LDR R3, [SP, #20]
MAX:    SUBS R2, R2, #1
        BEQ FINAL
        ADD R3, R3, #4
	    LDR R1, [R3]
        CMP R0, R1 
        BGE MAX // branch to mini to put min num into R6
        MOV R0, R1
        B MAX
FINAL:  STR R0, [SP, #16]
        POP {R0-R3}   
        BX LR 

END:    B END

RESULT:  .word 0
N:       .word 7
NUMBERS: .word 4, 5, 3, 6
         .word 1, 8, 2
