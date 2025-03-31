(LOOP)
@KBD
D=M          //D=KBD

@FILL
D;JNE        //if any key is pressed jump to fill

@CLEAR
0;JMP        //nothing is pressed jump to clear

(FILL)
@SCREEN
D=A         //address of the screen
@i
M=D         //i=SCREEN

(FILL_LOOP)
@i
D=M        //D=i         the cuurent addresss
@24576
D=D-A      
@LOOP
D;JGE      //i>=24576 we reached the end of the screen so we restart the loop

@-1
D=A
@i
A=M
M=D           //set the pixel black

@i
M=M+1        //move to the next memory location
@FILL_LOOP
0;JMP

(CLEAR)
@SCREEN
D=A
@i
M=D       //i=SCREEN

(CLEAR_LOOP)
@i
D=M
@24576
D=D-A
@LOOP
D;JGE     //if i >= 24576 restart loop

@0
D=A
@i
A=M
M=D       //set pixel to white

@i
M=M+1
@CLEAR_LOOP
0;JMP

