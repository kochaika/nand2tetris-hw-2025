(LOOP)
@KBD
D=M
@DRAW_BLACK
D;JNE
@DRAW_WHITE
0;JMP

(DRAW_BLACK)
@SCREEN
D=A
@addr
M=D
@8192
D=A
@counter
M=D

(BLACK_LOOP)
@counter
D=M
@LOOP
D;JEQ

@addr
A=M
M=-1

@addr
M=M+1
@counter
M=M-1
@BLACK_LOOP
0;JMP

(DRAW_WHITE)
@SCREEN
D=A
@addr
M=D
@8192
D=A
@counter
M=D

(WHITE_LOOP)
@counter
D=M
@LOOP
D;JEQ

@addr
A=M
M=0

@addr
M=M+1
@counter
M=M-1
@WHITE_LOOP
0;JMP
