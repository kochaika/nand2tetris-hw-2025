// Fill.asm
// Listens to keyboard register; if any key is pressed, writes 0xFFFF to entire screen
// otherwise writes 0x0000 (clears). Uses Screen memory map [16384..24575] (8192 words).
// Uses pointer-based loop. Variables and labels provided for readability.

@KBD
D=M           // D = keyboard
@KEY_CHECK
M=D

@KEY_CHECK
D=M
@CLEAR_SCREEN
D;JEQ         // if KBD==0 -> clear
// else key pressed -> paint (fill with -1)

@PAINT
0;JMP

(CLEAR_SCREEN)
  // write 0 to entire screen
  @SCREEN_START
  D=A
  @PTR
  M=D         // PTR = 16384

  (CLR_LOOP)
    @PTR
    A=M
    M=0
    @PTR
    M=M+1
    @PTR
    D=M
    @SCREEN_END
    D=D-A
    @CLR_LOOP
    D;JLE     // while PTR <= SCREEN_END continue
  @MAIN_LOOP
  0;JMP

(PAINT)
  // write -1 to entire screen
  @SCREEN_START
  D=A
  @PTR
  M=D

  (PAINT_LOOP)
    @PTR
    A=M
    M=-1
    @PTR
    M=M+1
    @PTR
    D=M
    @SCREEN_END
    D=D-A
    @PAINT_LOOP
    D;JLE
  @MAIN_LOOP
  0;JMP

(MAIN_LOOP)
  @KBD
  D=M
  @KEY_CHECK
  M=D
  @KEY_CHECK
  D=M
  @CLEAR_SCREEN
  D;JEQ
  @PAINT
  0;JMP

// Variables and constants
// Symbolic addresses:
@16384
SCREEN_START = 16384
@24575
SCREEN_END = 24575
@KBD
KBD = 24576   // keyboard register at 24576 in nand2tetris map
@PTR
@24575
@KBD
@PTR
@TMP
