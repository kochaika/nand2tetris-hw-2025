//loading R0 into D
@0
D=M

//storing R0 in R3
@3
M=D

//loading R1 into D
@1
D=M

//storing R1 in R4
@4
M=D

//storing R2 = 0
@2
M=0

(LOOP) //loop
@4
D=M
@END
D;JEQ  //exit loop if R4 = 0

@3
D=M
@2
M=D+M

@4
M=M-1

@LOOP
0;JMP

(END)
@END
0;JMP