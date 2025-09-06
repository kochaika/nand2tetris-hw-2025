import re

comp_table = {
    '0':   '0101010', '1':   '0111111', '-1':  '0111010',
    'D':   '0001100', 'A':   '0110000', '!D':  '0001101',
    '!A':  '0110001', '-D':  '0001111', '-A':  '0110011',
    'D+1': '0011111', 'A+1': '0110111', 'D-1': '0001110',
    'A-1': '0110010', 'D+A': '0000010', 'D-A': '0010011',
    'A-D': '0000111', 'D&A': '0000000', 'D|A': '0010101',
    'M':   '1110000', '!M':  '1110001', '-M':  '1110011',
    'M+1': '1110111', 'M-1': '1110010', 'D+M': '1000010',
    'D-M': '1010011', 'M-D': '1000111', 'D&M': '1000000', 'D|M': '1010101'
}

dest_table = {
    None:  '000', 'M':   '001', 'D':   '010', 'MD':  '011',
    'A':   '100', 'AM':  '101', 'AD':  '110', 'AMD': '111'
}

jump_table = {
    None:  '000', 'JGT': '001', 'JEQ': '010', 'JGE': '011',
    'JLT': '100', 'JNE': '101', 'JLE': '110', 'JMP': '111'
}

symbols = {
    'SP': 0, 'LCL': 1, 'ARG': 2, 'THIS': 3, 'THAT': 4,
    'R0': 0, 'R1': 1, 'R2': 2, 'R3': 3, 'R4': 4,
    'R5': 5, 'R6': 6, 'R7': 7, 'R8': 8, 'R9': 9,
    'R10': 10, 'R11': 11, 'R12': 12, 'R13': 13, 'R14': 14, 'R15': 15,
    'SCREEN': 16384, 'KBD': 24576
}

def parse_line(line):
    line = line.split('//')[0].strip()
    return line if line else None

def first_pass(lines):
    rom_addr = 0
    for line in lines:
        if line.startswith('(') and line.endswith(')'):
            label = line[1:-1]
            symbols[label] = rom_addr
        else:
            rom_addr += 1

def to_binary(value):
    return format(value, '016b')

def parse_c_instruction(instruction):
    if '=' in instruction:
        dest, rest = instruction.split('=')
    else:
        dest, rest = None, instruction

    if ';' in rest:
        comp, jump = rest.split(';')
    else:
        comp, jump = rest, None

    return '111' + comp_table[comp] + dest_table[dest] + jump_table[jump]

def second_pass(lines):
    output = []
    next_var_addr = 16
    for line in lines:
        if line.startswith('('):
            continue
        if line.startswith('@'):
            symbol = line[1:]
            if symbol.isdigit():
                address = int(symbol)
            else:
                if symbol not in symbols:
                    symbols[symbol] = next_var_addr
                    next_var_addr += 1
                address = symbols[symbol]
            output.append(to_binary(address))
        else:
            output.append(parse_c_instruction(line))
    return output

def assemble(filename):
    with open(filename, 'r') as f:
        lines = [parse_line(line) for line in f if parse_line(line)]

    first_pass(lines)
    binary = second_pass(lines)
    outname = filename.replace('.asm', '.hack')
    with open(outname, 'w') as f:
        f.write('\n'.join(binary))
    print(f"Assembled to {outname}")

if __name__ == "__main__":
    assemble("Add.asm")
    assemble("Max.asm")
    assemble("Rect.asm")
    assemble("Pong.asm")