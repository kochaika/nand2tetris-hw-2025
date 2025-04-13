

(LOOP)
@24576
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
@count
M=D        

(BLACK_LOOP)
@addr
A=M
M=-1       

@addr
M=M+1      

@count
M=M-1
D=M
@BLACK_LOOP
D;JGT      

@LOOP
0;JMP

(WHITE)
@SCREEN
D=A
@addr
M=D

@8192
D=A
@count
M=D

(WHITE_LOOP)
@addr
A=M
M=0        

@addr
M=M+1

@count
M=M-1
D=M
@WHITE_LOOP
D;JGT

@LOOP
0;JMP
