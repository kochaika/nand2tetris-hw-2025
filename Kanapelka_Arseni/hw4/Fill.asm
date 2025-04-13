    @SCREEN
    D=A
    @screen_ptr 
    M=D // beg of screen memory

(MAIN_LOOP)
    @KBD
    D=M // кead keyboard (0 = no key, >0 = key pressed)
    
    // color: -1 (black) if key pressed, 0 (white) if not
    @SET_WHITE
    D;JEQ //  no key pressed (D == 0)
    
(SET_BLACK)
    @color
    M=-1 // set color to black (all 16 bits = 1)
    @FILL_SCREEN
    0;JMP // fill

(SET_WHITE)
    @color
    M=0 //  set color to white ( = 0)

(FILL_SCREEN)
    // ptr = start of screen
    @SCREEN
    D=A
    @screen_ptr
    M=D

(FILL_LOOP)
    @KBD      
    D=A
    @screen_ptr
    D=D-M // end
    @MAIN_LOOP    
    D;JLE

    @color
    D=M           
    @screen_ptr
    A=M // addr = cur screen pos
    M=D

    @screen_ptr
    M=M+1       
    
    @FILL_LOOP
    0;JMP       
