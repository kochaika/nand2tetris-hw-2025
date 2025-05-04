@16384
D=M 
@i 
M=D //gives i = SCREEN 

(LOOP)
@24576 
D=M //fetches the keyboard state

@BLACKEN
D;JNE //goes to BLACKEN if value is not 0
@CLEAR 
0;JMP //ELSE goes to CLEAR

(BLACKEN)
@i
D=M  //fetches current i value
@16384
D-A;JGE //goes to END_SCREEN if (i) >= END_SCREEN
@i 
D=D+A
@24576
A=D
M=-1 //darkens the cell at position (i+SCREEN)
@i
D=M //gets current i values
D=D+1
M=D //store incremented i value
@BLACKEN 
0;JMP //repats BLACKEN section

(CLEAR)
@i
D=M //fetches current i value
@16384
D-A;JGE //goes to END_SCREEN if (i) >= 0
@i 
D=M
@16384
A=D
M=0 //clears the cell at position (i+SCREEN)
@i
D=M //fetches current i values
D=D+1
M=D //stores incremented i value
@CLEAR
0;JMP //repeats CLEAR section


