import sys

built_in_symbols = {
    "SP": 0, "LCL": 1, "ARG": 2, "THIS": 3, "THAT": 4,
    "R0": 0, "R1": 1, "R2": 2, "R3": 3, "R4": 4, "R5": 5,
    "R6": 6, "R7": 7, "R8": 8, "R9": 9, "R10": 10, "R11": 11,
    "R12": 12, "R13": 13, "R14": 14, "R15": 15,
    "SCREEN": 16384, "KBD": 24576
}

comp_table = {
    "0": "0101010", "1": "0111111", "-1": "0111010",
    "D": "0001100", "A": "0110000", "!D": "0001101",
    "!A": "0110001", "-D": "0001111", "-A": "0110011",
    "D+1": "0011111", "A+1": "0110111", "D-1": "0001110",
    "A-1": "0110010", "D+A": "0000010", "D-A": "0010011",
    "A-D": "0000111", "D&A": "0000000", "D|A": "0010101",
    "M": "1110000", "!M": "1110001", "-M": "1110011",
    "M+1": "1110111", "M-1": "1110010", "D+M": "1000010",
    "D-M": "1010011", "M-D": "1000111", "D&M": "1000000",
    "D|M": "1010101"
}

dest_table = {
    "": "000", "M": "001", "D": "010", "MD": "011",
    "A": "100", "AM": "101", "AD": "110", "AMD": "111"
}

jump_table = {
    "": "000", "JGT": "001", "JEQ": "010", "JGE": "011",
    "JLT": "100", "JNE": "101", "JLE": "110", "JMP": "111"
}

def strip_line(line):
    return line.split("//")[0].strip()

def binary16(value):
    return f"{value:016b}"

def handle_a_instruction(addr, symbols, var_addr):
    if addr.isdigit():
        return binary16(int(addr)), var_addr
    if addr not in symbols:
        symbols[addr] = var_addr
        var_addr += 1
    return binary16(symbols[addr]), var_addr

def assemble(lines):
    symbols = dict(built_in_symbols)
    instruction_addr = 0
    for line in lines:
        inst = strip_line(line)
        if inst.startswith("(") and inst.endswith(")"):
            label = inst[1:-1]
            symbols[label] = instruction_addr
        elif inst:
            instruction_addr += 1

    binary_lines = []
    var_addr = 16

    for line in lines:
        inst = strip_line(line)
        if not inst or inst.startswith("("):
            continue
        if inst.startswith("@"):
            addr = inst[1:]
            binary, var_addr = handle_a_instruction(addr, symbols, var_addr)
            binary_lines.append(binary)
        else:
            dest, comp, jump = "", "", ""
            if "=" in inst:
                dest, inst = inst.split("=")
            if ";" in inst:
                comp, jump = inst.split(";")
            else:
                comp = inst
            binary_lines.append("111" + comp_table[comp] + dest_table[dest] + jump_table[jump])

    return binary_lines

if __name__ == "__main__":
    filepath = sys.argv[1]
    with open(filepath) as f:
        raw_lines = f.readlines()
    machine_code = assemble(raw_lines)
    output_path = filepath.replace(".asm", ".hack")
    with open(output_path, "w") as f:
        f.write("\n".join(machine_code))