   .text
   .global _start

_start:
       
       LDR R0, NUM1     #Load NUM1 from memory into R0
       LDR R1, NUM2     #Load NUM2 from memory into R0
       LDR R2, NUM3     #Load NUM1 from memory into R0
       SUB SP, SP, #4   #Decrement StackPointer by 4 (clear stack)
       STMDB SP!, {R0-R2} #Store R0 through R1 at adress starting @ SP-4 (PUSH)
       LDMIA SP!, {R0-R2} #Load R0 through R1 at adress starting @ SP (POP)
       B END

END: B END
			
NUM1:  .word 5
NUM2:  .word 7
NUM3:  .word 9
   