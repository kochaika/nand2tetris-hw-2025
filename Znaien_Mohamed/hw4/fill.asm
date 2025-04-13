// Fill.asm - Turns screen black when a key is pressed, white otherwise

(LOOP)
  @KBD
  D=M         // Read keyboard input
  @DRAW_BLACK
  D;JNE       // If key pressed, go to DRAW_BLACK

  @DRAW_WHITE
  0;JMP       // Else, go to DRAW_WHITE

(DRAW_BLACK)
  @SCREEN
  D=A         // Load start of screen memory
  @i
  M=D         // i = SCREEN start

(BLACK_LOOP)
  @i
  D=M
  @24576
  D=D-A       // Check if i reached end of screen memory
  @LOOP
  D;JEQ       // If yes, go back to input check

  @i
  A=M
  M=-1        // Store -1 (black) in current memory address (fills 16 pixels)

  @i
  M=M+1       // i++
  @BLACK_LOOP
  0;JMP       // Repeat

(DRAW_WHITE)
  @SCREEN
  D=A
  @i
  M=D         // i = SCREEN start

(WHITE_LOOP)
  @i
  D=M
  @24576
  D=D-A
  @LOOP
  D;JEQ       // If i == end of screen memory, return to main loop

  @i
  A=M
  M=0         // Store 0 (white) in current memory address

  @i
  M=M+1       // i++
  @WHITE_LOOP
  0;JMP       // Repeat
