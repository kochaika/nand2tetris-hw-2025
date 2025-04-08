// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

  @R2
  M=0       // Set R2 = 0
  @R0
  D=M
  @3        // Use RAM[3] as count
  M=D       // Initialize count = R0

(LOOP)
  @3
  D=M       // D = count
  @END
  D;JEQ     // If count == 0, goto END
  @R1
  D=M       // D = R1
  @R2
  M=D+M     // R2 = R2 + R1
  @3
  M=M-1     // count--
  @LOOP
  0;JMP     // Goto LOOP

(END)
  @END
  0;JMP     // Infinite loop

