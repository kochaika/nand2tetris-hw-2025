// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)
// The algorithm is based on repetitive addition.

  @R2
  M=0 // Set the result to 0
  @R0
  D=M //Set value of R0 to the data
  @count
  M=D // count = R0, how many times to add R1

(LOOP) // Loop to repeat addition
  @count
  D=M // Setting D to the count
  @END
  D;JEQ // If the count is 0 jump to END
  @R1
  D=M // Setting D to R1
  @R2
  M=D+M // Adding R1 to the result
  @count
  M=M-1 // Decrease the count
  @LOOP
  0;JMP // Jump back to LOOP
(END)
    @END
    0;JMP
  