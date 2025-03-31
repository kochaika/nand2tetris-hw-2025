

@0
D=M        
@i
M=D       

@1
D=M        
@sum
M=0        

(LOOP)
@i
D=M
@END
D;JEQ      

@1
D=M    
@sum
M=D+M      

@i
M=M-1      

@LOOP
0;JMP

(END)
@sum
D=M
@2
M=D        

(ENDLOOP)
@ENDLOOP
0;JMP
