// File: projects/4/Fill.asm
// Fills the screen with white pixels if a key is pressed, otherwise clears it.

(LOOP)
    @KBD
    D=M          //read keyboard input
    @FILL_SCREEN
    D;JNE        //if a key is pressed, fill the screen
    @CLEAR_SCREEN
    0;JMP        //otherwise, clear the screen

(FILL_SCREEN)
    @SCREEN
    D=A
    @i
    M=D          //i = SCREEN (starting address)
(LOOP_FILL)
    @i
    D=M
    @KBD
    D=D-A
    @END
    D;JGE        //if i >= KBD, stop

    @i
    A=M
    M=-1         //fill pixel (white)

    @i
    M=M+1        //i++
    @LOOP_FILL
    0;JMP        //repeat

(CLEAR_SCREEN)
    @SCREEN
    D=A
    @i
    M=D          //i = SCREEN
(LOOP_CLEAR)
    @i
    D=M
    @KBD
    D=D-A
    @END
    D;JGE        //if i >= KBD, stop

    @i
    A=M
    M=0          //clear pixel (black)

    @i
    M=M+1        //i++
    @LOOP_CLEAR
    0;JMP        //repeat

(END)
    @LOOP
    0;JMP        //repeat program
