  @R2
  M=0 // Set R2=0
  @R0
  D=M
  @count
  M=D // initialize count to value in R0 - # of times to add R1

(LOOP)
  @count
  D=M // D=count
  @END
  D;JEQ // if count is 0 goto END
  @R1
  D=M // D=R1
  @R2
  M=D+M // add R1 to sum
  @count
  M=M-1 // decrement the count
  @LOOP
  0;JMP // Goto LOOP
(END)
  @END
  0;JMP // Infinite loop at end