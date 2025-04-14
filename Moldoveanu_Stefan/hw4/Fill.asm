// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, 
// the screen should be cleared.

(BLACK) 	  
@24576		        
D=M		           
@WHITE	     
D;JEQ		         
@24575		       
D=M		           
@WHITE	     
D;JLT		         
@i		          
D=M		         
@16384		      
D=D+A		       
A=D		         
M=-1		        
@i		        
M=M+1		       
@BLACk   
0;JMP		       

(WHITE)	    
@24576		      
D=M		           
@BLACK	     
D;JGT		       
@i		        
D=M		         
@16384		  
D=D+A		     
A=D		     
M=0		       
@i		    
M=M-1		   
@WHITE	
0;JMP		     