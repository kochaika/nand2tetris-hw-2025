(LOOP)
@SCREEN  
D=A //Screen assigned to register type d
@0  
M=D //Saving to register [0]

(KBDCHECK) 
@KBD       
D=M        
@BLACK     
D;JGT //Key is pressed, black
@WHITE     
D;JEQ //No key is pressed, white
@KBDCHECK  
0;JMP //loop back to (KBDCHECK) line

(BLACK)
@1        
M=-1 //Store -1 in RAM[1]
@CHANGE   
0;JMP 

(WHITE)
@1        
M=0 //Store 0 in RAM[1] 
@CHANGE   
0;JMP 

(CHANGE)
@1        
D=M //Load the color into D
@0        
A=M //Load the current screen address into A
M=D //Set that pixel to the color

@0        
D=M+1 //Increment screen address
@0        
M=D //Store new address in RAM[0]

@KBD      
D=A-D //Compare A (KBD address) with current screen address
@CHANGE   
D;JGT //If A > D (not done), keep looping
@LOOP  
0;JMP //If the entire screen is filled, loop to the beginning
