@R0
D=M
@counter
M=D

@R2
M=0

(LOOP)
@counter
D=M
@END
D;JEQ

@R2
D=M
@R1
D=D+M
@R2
M=D

@counter
M=M-1

@LOOP
0;JMP

(END)
@END
0;JMP
