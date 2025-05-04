@R0
D=M
@i
M=D

@R2
M=0

(LOOP)
@i
D=M
@END
D;JEQ

@R2
D=M
@R1
D=D+M
@R2
M=D

@i
M=M-1

@LOOP
0;JMP

(END)
@END
0;JMP
