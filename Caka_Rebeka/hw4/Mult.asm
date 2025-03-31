// Mult.asm - Multiplies R0 and R1 and stores the result in R2
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively)

@R2
M=0     // R2 = 0 (initialize result to 0)

@R1
D=M     // D = R1 (load multiplier)

@END
D;JEQ   // If R1 = 0, jump to end

(LOOP)
  @R0
  D=M     // D = R0 (load multiplicand)
  
  @R2
  M=D+M   // R2 = R2 + R0
  
  @R1
  M=M-1   // R1 = R1 - 1 (decrement counter)
  D=M     // D = R1
  
  @LOOP
  D;JGT   // If R1 > 0, jump to LOOP

(END)
  @END
  0;JMP   // Infinite loop (program ends)