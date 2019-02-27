.text
.global _start

_start: 
        LDR R4, =RESULT         #R4 points to the starting address of RESULT    
        LDR R2, N               #Load N into R2
        ADD R3, R4, #8          #Add 8 to address R4 and load into R3
        LDR R0, [R3]            #Load value att address R3 into R0
        PUSH { R2, R3, LR}      #Push LR, R3, R2 onto stack (in that order)
        BL MAXI                 #Branch & Link to Maxi
        LDR R0, [SP]
        STR R0, [R4]
        LDR LR, [SP, #8]
        ADD SP, SP, #12
        B END

MAXI:   PUSH {R0-R3}            #Push R0 through R3 onto stack 
        LDR R2, [SP, #16]       #Load into R2  the value at address stackpointer + 16
        LDR R3, [SP, #20]       #Load into R3  the value at address stackpointer + 20
MAX:    SUBS R2, R2, #1         #Subtract R2 by 1 and store in R2 & UPDATE FLAGS
        BEQ FINAL               #IF equal flag set, branch to final
        ADD R3, R3, #4          #Add 4 to R3 and store in R3
	    LDR R1, [R3]            #Load value @ address R3 into R1
        CMP R0, R1              #Computer R0-R1 and set flags
        BGE MAX                 #IF R0==R1 branch to mini to put min num into R6
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
