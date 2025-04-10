(LOOP)
@KBD
D=M
@BLACK
D;JNE
@WHITE
0;JMP

(BLACK)
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

(WHITE)
@SCREEN
D=A
@addr
M=D
@8192
D=A
@counter
M=D

(CLEAR_LOOP)
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
@CLEAR_LOOP
0;JMP

