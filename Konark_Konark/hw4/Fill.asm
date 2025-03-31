@SCREEN
D=A
@screen
M=D  //start address

@KBD
D=A
@keyboard
M=D  //keyboard address

(LOOP)
    //if key is pressed
    @keyboard
    D=M
    @BLACK
    D;JNE  //if pressed,jump to black

    //if key not pressed,turn white
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
    D;JGE  // If we reached the end, restart loop

    // Set the pixel to white (0)
    @i
    A=M
    M=0  // Write 0 to make pixel white

    // Move to the next pixel
    @i
    M=M+1
    @CLEAR
    0;JMP  // Repeat clearing

(BLACK)
    @screen
    D=M
    @i
    M=D  // Reset i to start of screen

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