import sys
import re

# Predefined symbols
PREDEFINED_SYMBOLS = {
    'SP': 0, 'LCL': 1, 'ARG': 2, 'THIS': 3, 'THAT': 4,
    'SCREEN': 16384, 'KBD': 24576
}
# Add R0–R15
for i in range(16):
    PREDEFINED_SYMBOLS[f'R{i}'] = i

# comp mnemonics to binary
COMP = {
    '0':'0101010', '1':'0111111', '-1':'0111010', 'D':'0001100', 'A':'0110000', '!D':'0001101', '!A':'0110001',
    '-D':'0001111', '-A':'0110011', 'D+1':'0011111', 'A+1':'0110111', 'D-1':'0001110', 'A-1':'0110010',
    'D+A':'0000010', 'D-A':'0010011', 'A-D':'0000111', 'D&A':'0000000', 'D|A':'0010101',
    'M':'1110000', '!M':'1110001', '-M':'1110011', 'M+1':'1110111', 'M-1':'1110010',
    'D+M':'1000010', 'D-M':'1010011', 'M-D':'1000111', 'D&M':'1000000', 'D|M':'1010101'
}
# dest mnemonics to binary
DEST = {
    '': '000', 'M': '001', 'D': '010', 'MD': '011', 'A': '100', 'AM': '101', 'AD': '110', 'AMD': '111'
}
# jump mnemonics to binary
JUMP = {
    '': '000', 'JGT': '001', 'JEQ': '010', 'JGE': '011', 'JLT': '100', 'JNE': '101', 'JLE': '110', 'JMP': '111'
}


def clean(line: str) -> str:
    """Remove comments/whitespace"""
    line = line.split('//')[0]
    return line.strip()


def first_pass(lines, symbol_table):
    """Register label symbols (Xxx) with ROM addresses"""
    rom_address = 0
    for line in lines:
        line = clean(line)
        if not line:
            continue
        if line.startswith('(') and line.endswith(')'):
            label = line[1:-1]
            symbol_table[label] = rom_address
        else:
            rom_address += 1


def second_pass(lines, symbol_table):
    """Translate A/C instructions, handling variables"""
    ram_address = 16
    output = []
    for line in lines:
        line = clean(line)
        if not line or (line.startswith('(') and line.endswith(')')):
            continue
        # A-instruction
        if line.startswith('@'):
            symbol = line[1:]
            if symbol.isdigit():
                addr = int(symbol)
            else:
                if symbol not in symbol_table:
                    symbol_table[symbol] = ram_address
                    ram_address += 1
                addr = symbol_table[symbol]
            binary = '0' + format(addr, '015b')
        # C-instruction
        else:
            dest_mn, comp_mn, jump_mn = '', '', ''
            if '=' in line:
                dest_mn, line = line.split('=', 1)
            if ';' in line:
                comp_mn, jump_mn = line.split(';', 1)
            else:
                comp_mn = line
            binary = '111' + COMP[comp_mn] + DEST[dest_mn] + JUMP[jump_mn]
        output.append(binary)
    return output


def assemble(input_path, output_path):
    with open(input_path, 'r') as f:
        lines = f.readlines()
    # Initialize symbol table
    symbol_table = dict(PREDEFINED_SYMBOLS)
    # First pass: record labels
    first_pass(lines, symbol_table)
    # Second pass: translate instructions
    machine = second_pass(lines, symbol_table)
    # Write .hack file
    with open(output_path, 'w') as f:
        for code in machine:
            f.write(code + '\n')
    print(f"Assembled {input_path} -> {output_path}")


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Usage: python hack_assembler.py Prog.asm')
        sys.exit(1)
    asm_file = sys.argv[1]
    if not asm_file.endswith('.asm'):
        print('Error: input must be a .asm file')
        sys.exit(1)
    hack_file = asm_file.replace('.asm', '.hack')
    assemble(asm_file, hack_file)
