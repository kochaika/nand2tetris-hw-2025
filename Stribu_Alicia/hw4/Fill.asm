@SCREEN
D=A
@screen
M=D  //here we have the start address

@KBD
D=A
@keyboard
M=D  //here we have the keyboard address

(LOOP)
    //if we have the key pressed
    @keyboard
    D=M
    @BLACK
    D;JNE  //if pressed we jump to black

    //if key not pressed we turn white
    @screen
    D=M
    @i
    M=D  //loop counter(i)

(CLEAR)
    @i
    D=M
    @24576
    D=D-A
    @LOOP
    D;JGE  // If we reached the end we will restart loop

    // we set the pixel to white (0)
    @i
    A=M
    M=0  //we write 0 to make pixel white

    // then move to the next pixel
    @i
    M=M+1
    @CLEAR
    0;JMP  //we repeat clearing

(BLACK)
    @screen
    D=M
    @i
    M=D  //reseting  i to start of screen

(FILL)
    @i
    D=M
    @24576
    D=D-A
    @LOOP
    D;JGE  //to restart the loop again

    //to set it to black
    @i
    A=M
    M=-1

    @i
    M=M+1
    @FILL
    0;JMP
