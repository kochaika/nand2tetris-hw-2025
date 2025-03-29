// Fill.asm

(MAIN_LOOP)
    @KBD
    D=M     // Reading input
    
    @BLACK
    D;JNE   // If button pressed, goto BLACK
    
    @WHITE
    D;JEQ   // If no button pressed, goto WHITE
    
(BLACK)
    @color
    M=-1    // Setting color to black
    0;JMP   // Goto FILL 
    
(WHITE)
    @color
    M=0     // Setting color to white
    @FILL
    0;JMP   // Goto FILL 
    
(FILL)
    // Initialize pointer to screen memory
    @SCREEN
    D=A
    @ptr
    M=D     // ptr = SCREEN
    
(FILL_LOOP)
    // Checking if we filled all screen memory
    @ptr
    D=M
    @KBD
    D=D-A
    @MAIN_LOOP
    D;JEQ   // If ptr == KBD, goto MAIN_LOOP
    
    @color
    D=M     // Getting  current color
    @ptr
    A=M     // Settong address to current pointer
    M=D     // Fill word
    
    // Increment pointer
    @ptr
    M=M+1
    
    @FILL_LOOP
    0;JMP   // Repeat loop