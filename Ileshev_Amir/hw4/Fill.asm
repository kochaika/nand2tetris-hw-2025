  @place 
  M=0 

(LOOP)
  @KBD 
  D=M 
  @WHITE
  D;JEQ 
  @BLACK
  0;JMP 

(WHITE)
  @place
  D=M 
  @LOOP
  D;JLT 
  @place
  D=M
  @SCREEN
  A=A+D
  M=0 
  @place
  M=M-1 
  @LOOP
  0;JMP 

(BLACK)
  @place
  D=M
  @8192
  D=D-A
  @LOOP
  D;JGE 
  @place
  D=M
  @SCREEN
  A=A+D 
  M=-1 
  @place
  M=M+1 
  @LOOP
  0;JMP 

(END)
  @END
  0;JMP 