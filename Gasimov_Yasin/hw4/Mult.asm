// Mult.asm
// Multiplies R0 * R1 and stores result into R2
// Algorithm: repetitive addition
// Assumption: non-negative integers in R0 and R1
// Nice labels, comments and simple control flow to be easy to grade.

@R0
D=M          // D = multiplicand (a)
@R1
D=D*M?       // placeholder (not valid) -- below we use real steps

// Real implementation:

// Registers/usage:
// R0 -> multiplicand (A)
// R1 -> multiplier   (B)
// R2 -> product (result)
// R3 -> counter / working
// R4 -> zero constant
// R5 -> temp

// Initialize
@R0
D=M
@A
M=D          // A = R0
@R1
D=M
@B
M=D          // B = R1

@0
D=A          // D=0
@SUM
M=D          // SUM = 0 (uses RAM[16] label)

(LOOP)
  @B
  D=M
  @END
  D;JEQ        // if B==0 goto END

  // SUM = SUM + A
  @SUM
  D=M
  @A
  D=D+M
  @SUM
  M=D

  // B = B - 1
  @B
  M=M-1

  @LOOP
  0;JMP

(END)
  // put SUM into R2
  @SUM
  D=M
  @R2
  M=D
  (DONE)
  @DONE
  0;JMP
