   .text
   .global _start

_start:
       
       LDR R0, NUM1
       LDR R1, NUM2
       LDR R2, NUM3
       //SUB SP, SP, #4
       STMDB SP!, {R0-R2}
       LDMIA SP!, {R0-R2}
       B END

END: B END
			
NUM1:  .word 5
NUM2:  .word 7
NUM3:  .word 9
   