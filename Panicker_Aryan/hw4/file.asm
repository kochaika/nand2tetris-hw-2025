// Fill.asm - A simple interactive program
// This program fills the screen with black when any key is pressed,
// and clears it when the key is released

// Pseudocode:
// INFINITE LOOP:
//   Check if keyboard key is pressed
//   If key is pressed:
//     Fill screen with black (write -1 to all pixels)
//   If no key is pressed:
//     Clear screen (write 0 to all pixels)

@SCREEN    // Screen memory map starts at 16384 (0x4000)
D=A
@screenAddress
M=D        // screenAddress = 16384

@8192      // Number of 16-bit words in the screen (512 * 256 / 16)
D=A
@screenSize
M=D        // screenSize = 8192

(LOOP)     // Main infinite loop
    @KBD   // Keyboard memory map at 24576 (0x6000)
    D=M    // D = current key pressed (or 0 if no key)
    
    @WHITE
    D;JEQ  // If no key pressed (D=0), go to WHITE
    
    // Key is pressed, fill screen with black
    @screenAddress
    D=M
    @pixelAddress
    M=D    // pixelAddress = screenAddress
    
    @screenSize
    D=M
    @counter
    M=D    // counter = screenSize
    
    @fillValue
    M=-1   // fillValue = -1 (black, all bits are 1)
    
    @FILL
    0;JMP  // Jump to FILL routine
    
(WHITE)    // No key is pressed, clear screen
    @screenAddress
    D=M
    @pixelAddress
    M=D    // pixelAddress = screenAddress
    
    @screenSize
    D=M
    @counter
    M=D    // counter = screenSize
    
    @fillValue
    M=0    // fillValue = 0 (white, all bits are 0)

(FILL)     // Fill routine that writes to screen memory
    @counter
    D=M
    @LOOP
    D;JLE  // If counter <= 0, go back to main loop
    
    @fillValue
    D=M
    @pixelAddress
    A=M    // Set address register to current pixel address
    M=D    // Memory[pixelAddress] = fillValue
    
    @pixelAddress
    M=M+1  // pixelAddress++
    
    @counter
    M=M-1  // counter--
    
    @FILL
    0;JMP  // Continue filling

(END)      // Program never reaches here due to infinite loop
    @END
    0;JMP