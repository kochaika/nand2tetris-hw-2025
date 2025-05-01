import sys

predefined = {
    "SP": 0, "LCL": 1, "ARG": 2, "THIS": 3, "THAT": 4,
    "R0": 0, "R1": 1, "R2": 2, "R3": 3, "R4": 4, "R5": 5,
    "R6": 6, "R7": 7, "R8": 8, "R9": 9, "R10": 10, "R11": 11,
    "R12": 12, "R13": 13, "R14": 14, "R15": 15,
    "SCREEN": 16384, "KBD": 24576
}

comp_bits = {
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

dest_bits = {
    "": "000", "M": "001", "D": "010", "MD": "011",
    "A": "100", "AM": "101", "AD": "110", "AMD": "111"
}

jump_bits = {
    "": "000", "JGT": "001", "JEQ": "010", "JGE": "011",
    "JLT": "100", "JNE": "101", "JLE": "110", "JMP": "111"
}

def clean(line):
    return line.split("//")[0].strip()

def to_bin(value):
    return f"{value:016b}"

def run_assembler(lines):
    sym_table = dict(predefined)
    rom = 0
    for line in lines:
        code = clean(line)
        if code.startswith("(") and code.endswith(")"):
            label = code[1:-1]
            sym_table[label] = rom
        elif code:
            rom += 1

    result = []
    next_var = 16

    for line in lines:
        code = clean(line)
        if not code or code.startswith("("):
            continue
        if code.startswith("@"):
            addr = code[1:]
            if addr.isdigit():
                binary = to_bin(int(addr))
            else:
                if addr not in sym_table:
                    sym_table[addr] = next_var
                    next_var += 1
                binary = to_bin(sym_table[addr])
            result.append(binary)
        else:
            dest, comp, jump = "", "", ""
            if "=" in code:
                dest, code = code.split("=")
            if ";" in code:
                comp, jump = code.split(";")
            else:
                comp = code
            result.append("111" + comp_bits[comp] + dest_bits[dest] + jump_bits[jump])

    return result

if __name__ == "__main__":
    filepath = sys.argv[1]
    with open(filepath) as f:
        raw_lines = f.readlines()
    machine_code = run_assembler(raw_lines)
    output_path = filepath.replace(".asm", ".hack")
    with open(output_path, "w") as f:
        f.write("\n".join(machine_code))
