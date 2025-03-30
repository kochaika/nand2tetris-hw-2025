(BEGIN)
	// Set keyboard to address for keyboard input value.
	@24576
	D=A
	@keyboard
	M=D
(CHECK_KEYBOARD)
	// Set current to last screen pixel map.
	@24575
	D=A
	@current
	M=D
	// If keyboard is pressed, fill the screen.
	@keyboard
	A=M
	D=M
	@fillvalue
	M=-1
	@DRAW
	D;JNE
	// Otherwise, clear the screen.
	@fillvalue
	M=0
(DRAW)
	// Fill or clear current pixel, depending on fillvalue.
	@fillvalue
	D=M
	@current
	A=M
	M=D
	// If current pixel map is first pixel map there is nothing left to draw, so
	//jump back to keyboard check.
	@current
	D=M
	@16384
	D=D-A
	@CHECK_KEYBOARD
	D;JLE
	// Decrement current pixel map.
	@current
	M=M-1
	// Continue drawing next pixel map.
	@DRAW
	0;JMP