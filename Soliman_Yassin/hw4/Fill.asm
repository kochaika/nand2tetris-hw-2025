// Fill.asm - fills screen when key is pressed

(LOOP)
@KBD
D=M
@WHITE
D;JNE        // If key pressed, go white

// Else black
@SCREEN
D=A
@addr
M=D

(LOOP_BLACK)
@addr
D=M
@24576
D=D-A
@LOOP
D;JEQ

@addr
A=M
M=0         // Set pixel to black
@addr
M=M+1
@LOOP_BLACK
0;JMP

(WHITE)
@SCREEN
D=A
@addr
M=D

(LOOP_WHITE)
@addr
D=M
@24576
D=D-A
@LOOP
D;JEQ

@addr
A=M
M=-1        // Set pixel to white
@addr
M=M+1
@LOOP_WHITE
0;JMP
