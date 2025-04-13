
@R0
D=M        
@R2
M=0     
@R1
D=M         
@COUNT
M=D          

(LOOP)
@COUNT
D=M
@END
D;JEQ        

@R0
D=M
@R2
M=D+M      

@COUNT
M=M-1    

@LOOP
0;JMP

(END)
@END
0;JMP  
