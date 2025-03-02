// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/4/fill/Fill.tst

// Tests the Fill.hack program in the CPU emulator.

load Fill.asm;
echo "Select the highest speed and 'enable keyboard'. Then press any key for some time, and inspect the screen.";

repeat {
  ticktock;
}