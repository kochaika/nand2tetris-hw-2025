// Mult.asm: Computes R2 = R0 * R1 using repetitive addition

@R0
D=M         
@R2
M=0        

@R1
D=M        
@END
D;JEQ       

(LOOP)
  @0
  D=M      
  @R2
  M=D+M    

  @R1
  M=M-1     
  D=M       
  @LOOP
  D;JGT    

(END)
@END
0;JMP       
