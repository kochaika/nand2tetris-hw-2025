import sys
import re
from typing import Dict, List, Optional, Tuple

class HackAssembler:
    def __init__(self):
        self.symbol_table: Dict[str, int] = {
            'SP': 0,
            'LCL': 1,
            'ARG': 2,
            'THIS': 3,
            'THAT': 4,
            'R0': 0,
            'R1': 1,
            'R2': 2,
            'R3': 3,
            'R4': 4,
            'R5': 5,
            'R6': 6,
            'R7': 7,
            'R8': 8,
            'R9': 9,
            'R10': 10,
            'R11': 11,
            'R12': 12,
            'R13': 13,
            'R14': 14,
            'R15': 15,
            'SCREEN': 16384,
            'KBD': 24576,
        }
        
        self.comp_table: Dict[str, str] = {
            '0':   '0101010',
            '1':   '0111111',
            '-1':  '0111010',
            'D':   '0001100',
            'A':   '0110000',
            'M':   '1110000',
            '!D':  '0001101',
            '!A':  '0110001',
            '!M':  '1110001',
            '-D':  '0001111',
            '-A':  '0110011',
            '-M':  '1110011',
            'D+1': '0011111',
            'A+1': '0110111',
            'M+1': '1110111',
            'D-1': '0001110',
            'A-1': '0110010',
            'M-1': '1110010',
            'D+A': '0000010',
            'D+M': '1000010',
            'D-A': '0010011',
            'D-M': '1010011',
            'A-D': '0000111',
            'M-D': '1000111',
            'D&A': '0000000',
            'D&M': '1000000',
            'D|A': '0010101',
            'D|M': '1010101',
        }
        
        self.dest_table: Dict[str, str] = {
            '':    '000',
            'M':   '001',
            'D':   '010',
            'MD':  '011',
            'A':   '100',
            'AM':  '101',
            'AD':  '110',
            'AMD': '111',
        }
        
        self.jump_table: Dict[str, str] = {
            '':    '000',
            'JGT': '001',
            'JEQ': '010',
            'JGE': '011',
            'JLT': '100',
            'JNE': '101',
            'JLE': '110',
            'JMP': '111',
        }
        
        self.next_variable_address = 16

    def clean_line(self, line: str) -> str:
        line = re.sub(r'//.*$', '', line)
        line = line.strip()
        return line

    def parse_a_instruction(self, instruction: str) -> str:
        value = instruction[1:]
        
        if value.isdigit():
            decimal_value = int(value)
        else:
            if value in self.symbol_table:
                decimal_value = self.symbol_table[value]
            else:
                decimal_value = self.next_variable_address
                self.symbol_table[value] = decimal_value
                self.next_variable_address += 1
        
        binary = format(decimal_value, '016b')
        return binary

    def parse_c_instruction(self, instruction: str) -> str:
        dest = ''
        comp = instruction
        jump = ''
        
        # Check for destination
        if '=' in instruction:
            dest, comp = instruction.split('=', 1)
        
        # Check for jump
        if ';' in comp:
            comp, jump = comp.split(';', 1)
        
        # Get binary codes for each component
        dest_bits = self.dest_table.get(dest, '000')
        comp_bits = self.comp_table.get(comp, '0000000')
        jump_bits = self.jump_table.get(jump, '000')
        
        # C-instruction format: 1 1 1 a c1 c2 c3 c4 c5 c6 d1 d2 d3 j1 j2 j3
        return f"111{comp_bits}{dest_bits}{jump_bits}"

    def first_pass(self, lines: List[str]) -> List[str]:
        cleaned_lines = []
        rom_address = 0
        
        for line in lines:
            # Clean the line
            clean_line = self.clean_line(line)
            
            # Skip empty lines
            if not clean_line:
                continue
            
            # Check if it's a label declaration (LABEL)
            if clean_line.startswith('(') and clean_line.endswith(')'):
                # Extract label name and add to symbol table
                label = clean_line[1:-1]
                self.symbol_table[label] = rom_address
            else:
                # It's a regular instruction, add to cleaned lines
                cleaned_lines.append(clean_line)
                rom_address += 1
        
        return cleaned_lines

    def second_pass(self, instructions: List[str]) -> List[str]:
        binary_code = []
        
        for instruction in instructions:
            # Check if it's an A-instruction (@xxx)
            if instruction.startswith('@'):
                binary = self.parse_a_instruction(instruction)
            # Otherwise, it's a C-instruction
            else:
                binary = self.parse_c_instruction(instruction)
            
            binary_code.append(binary)
        
        return binary_code

    def assemble(self, input_file: str, output_file: str) -> None:
        try:
            # Read the input file
            with open(input_file, 'r') as f:
                lines = f.readlines()
            
            # First pass: collect label symbols
            instructions = self.first_pass(lines)
            
            # Second pass: translate to binary
            binary_code = self.second_pass(instructions)
            
            # Write binary code to output file
            with open(output_file, 'w') as f:
                for line in binary_code:
                    f.write(line + '\n')
                    
            print(f"Successfully assembled {input_file} to {output_file}")
            print(f"Generated {len(binary_code)} lines of binary code")
            
        except Exception as e:
            print(f"Error assembling file: {e}")
            sys.exit(1)

def main():
    # Check command line arguments
    if len(sys.argv) != 3:
        print("Usage: python compiler.py input.asm output.hack")
        sys.exit(1)
    
    input_file = sys.argv[1]
    output_file = sys.argv[2]
    
    # Create assembler and process the file
    assembler = HackAssembler()
    assembler.assemble(input_file, output_file)

if __name__ == "__main__":
    main()