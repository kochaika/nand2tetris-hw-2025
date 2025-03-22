@result
M=0

@multiplier
D=M
@EXIT_LOOP
D;JEQ

@iterationCounter
M=D

(MULTIPLY_LOOP)
  @iterationCounter
  D=M
  @EXIT_LOOP
  D;JEQ

  @multiplicand
  D=M
  @result
  M=D+M

  @iterationCounter
  M=M-1

  @MULTIPLY_LOOP
  0;JMP

(EXIT_LOOP)
