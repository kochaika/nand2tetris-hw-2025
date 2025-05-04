@24576
D=A
@keyboard
M=D

(CHECK_KEYBOARD)
@24575
D=A
@current
M=D

@keyboard
A=M
D=M
@fillvalue
M=-1
@DRAW
D;JNE

@fillvalue
M=0

(DRAW)
@fillvalue
D=M
@current
A=M
M=D

@current
D=M
@16384
D=D-A
@CHECK_KEYBOARD
D;JLE

@current
M=M-1
@DRAW
0;JMP
