// Fill.asm - Interactive program that fills/clears the screen based on keyboard input
// When a key is pressed, the screen becomes black
// When no key is pressed, the screen becomes white

(MAIN_LOOP)
  @KBD          // Keyboard memory map address
  D=M           // D = current keyboard state
  
  @WHITE        // Jump to WHITE if no key is pressed
  D;JEQ
  
  // If we reach here, a key is pressed - fill screen black
  @color
  M=-1          // color = -1 (black: all bits are 1)
  @FILL_SCREEN
  0;JMP
  
(WHITE)
  @color
  M=0           // color = 0 (white: all bits are 0)
  
(FILL_SCREEN)
  // Initialize screen pointer to start of screen memory
  @SCREEN
  D=A           // D = SCREEN base address
  @pointer
  M=D           // pointer = SCREEN
  
  // Calculate screen size (number of 16-bit words)
  // Screen is 256 rows × 512 pixels = 131,072 bits = 8,192 words
  @8192
  D=A
  @counter
  M=D           
  
(FILL_LOOP)
  @counter
  D=M
  @MAIN_LOOP
  D;JLE         // If counter <= 0, go back to main loop
  
  @color
  D=M           // D = color (0 for white, -1 for black)
  
  @pointer
  A=M           // A = pointer (current address to fill)
  M=D           // Fill memory at pointer with color
  
  @pointer
  M=M+1         // pointer++
  
  @counter
  M=M-1         // counter--
  
  @FILL_LOOP
  0;JMP         // Continue loop
  
// Program never terminates - continuously responds to keyboard input