@R0       
D=M       

@temp     
M=D       

@R1       
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

@temp     
D=M       
@R2       
M=D+M   

@counter  
M=M-1     

@LOOP     
0;JMP     

(END)     
@END      
0;JMP     
