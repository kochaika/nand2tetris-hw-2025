
(INIT)
	@8192
	D=A
	@i
	M=D

(LOOP) 
	@i
	M=M-1
	D=M
	@INIT
	D;JLT
	@KBD
	D=M
	@WHITE
	D;JEQ
	@BLACK
	0;JMP

(BLACK)             
	@SCREEN
	D=A
	@i
	A=D+M
	M=-1 
	@LOOP
	0;JMP

(WHITE)
	@SCREEN
	D=A                
	@i        
	A=D+M 
	M=0 
	@LOOP
	0;JMP