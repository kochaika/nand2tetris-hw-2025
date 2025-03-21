
@color 
M=0      

(LOOP)

  @SCREEN
  D=A
  @pixels
  M=D         

  @KBD    
  D=M
  @BLACK
  D;JGT     
  
  @color
  M=0       
  @COLOR_SCREEN
  0;JMP     
  
  (BLACK)
    @color
    M=-1    

  (COLOR_SCREEN)
    @color
    D=M
    @pixels
    A=M         
    M=D         
    
    @pixels
    M=M+1
    D=M
        
    @24576
    D=D-A
    @COLOR_SCREEN
    D;JLT

@LOOP
0;JMP 
