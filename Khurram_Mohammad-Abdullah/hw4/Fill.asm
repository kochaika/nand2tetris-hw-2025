(LOOP)       
@KBD         
D=M          
@BLACK       
D;JNE        

@0           
D=A          
@temp        
M=D          

(WHITE_LOOP)
@temp        
D=M          
@8192        
D=D-A        
@LOOP        
D;JEQ        

@SCREEN      
D=A          
@temp        
A=D+M        
M=0          

@temp        
M=M+1        
@WHITE_LOOP  
0;JMP        

(BLACK)      
@0           
D=A          
@temp        
M=D          

(BLACK_LOOP)
@temp        
D=M          
@8192        
D=D-A        
@LOOP        
D;JEQ        

@SCREEN      
D=A          
@temp        
A=D+M        
M=-1         

@temp        
M=M+1        
@BLACK_LOOP  
0;JMP        
