@2
M=0

@0
D=M

@Mult
M=D

@1
D=M

@count
M=D


(LOOP)
@count 
D=M
@END
D;JEQ

@Mult
D=M

@2
M=D+M

@count
M=M-1

@LOOP          
0;JMP

(END)
@END
0;JMP
