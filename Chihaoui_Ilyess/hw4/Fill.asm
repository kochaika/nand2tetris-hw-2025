(RESTART)
@SCREEN
D=A
@0
M=D

///////////////////////////
(KBDCHECK)

@KBD
D=M
@BLACK
D;JGT
@WHITE
D;JEQ

@KBDCHECK
0;JMP
///////////////////////////
(BLACK)
@1
M=-1
@CHANGE
0;JMP

(WHITE)
@1
M=0
@CHANGE
0;JMP
//////////////////////////
(CHANGE)
@1
D=M

@0
A=M
M=D

@0
D=M+1
@KBD
D=A-D

@0
M=M+1
A=M

@CHANGE
D;JGT
/////////////////////////
@RESTART
0;JMP