(MAIN_LOOP)
  @KBD
  D=M

  @PAINT_SCREEN
  D;JGT

  @WIPE_DISPLAY
  0;JMP

(WIPE_DISPLAY)
  @8192
  D=A
  @pixelCounter
  M=D

  @frameBuffer
  D=A
  @pixelAddr
  M=D

(ERASE_LOOP)
  @pixelCounter
  D=M
  @MAIN_LOOP
  D;JEQ

  @pixelAddr
  A=M
  M=0

  @pixelAddr
  M=M+1

  @pixelCounter
  M=M-1

  @ERASE_LOOP
  0;JMP

(PAINT_SCREEN)
  @8192
  D=A
  @pixelCounter
  M=D

  @frameBuffer
  D=A
  @pixelAddr
  M=D

(FILL_LOOP)
  @pixelCounter
  D=M
  @MAIN_LOOP
  D;JEQ

  @pixelAddr
  A=M
  M=-1

  @pixelAddr
  M=M+1

  @pixelCounter
  M=M-1

  @FILL_LOOP
  0;JMP
