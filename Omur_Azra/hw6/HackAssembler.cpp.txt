/* Omur_Azra_hw6 */

#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <unordered_map>
#include <bitset>

using namespace std;

string trim(const string& s) {
    size_t start = s.find_first_not_of(" \t\r\n");
    size_t end = s.find_last_not_of(" \t\r\n");
    return (start == string::npos) ? "" : s.substr(start, end - start + 1);
}

string to_binary(int value) {
    return bitset<16>(value).to_string();
}

string comp_to_bin(const string& comp) {
    static unordered_map<string, string> comp_table = {
        {"0",   "0101010"}, {"1",   "0111111"}, {"-1",  "0111010"},
        {"D",   "0001100"}, {"A",   "0110000"}, {"!D",  "0001101"},
        {"!A",  "0110001"}, {"-D",  "0001111"}, {"-A",  "0110011"},
        {"D+1", "0011111"}, {"A+1", "0110111"}, {"D-1", "0001110"},
        {"A-1", "0110010"}, {"D+A", "0000010"}, {"D-A", "0010011"},
        {"A-D", "0000111"}, {"D&A", "0000000"}, {"D|A", "0010101"},
        {"M",   "1110000"}, {"!M",  "1110001"}, {"-M",  "1110011"},
        {"M+1", "1110111"}, {"M-1", "1110010"}, {"D+M", "1000010"},
        {"D-M", "1010011"}, {"M-D", "1000111"}, {"D&M", "1000000"},
        {"D|M", "1010101"}
    };
    return comp_table[comp];
}

string dest_to_bin(const string& dest) {
    static unordered_map<string, string> dest_table = {
        {"",    "000"}, {"M",   "001"}, {"D",   "010"}, {"MD",  "011"},
        {"A",   "100"}, {"AM",  "101"}, {"AD",  "110"}, {"AMD", "111"}
    };
    return dest_table[dest];
}

string jump_to_bin(const string& jump) {
    static unordered_map<string, string> jump_table = {
        {"",    "000"}, {"JGT", "001"}, {"JEQ", "010"}, {"JGE", "011"},
        {"JLT", "100"}, {"JNE", "101"}, {"JLE", "110"}, {"JMP", "111"}
    };
    return jump_table[jump];
}

bool is_a_instruction(const string& line) {
    return line[0] == '@';
}

string translate_c_instruction(const string& line) {
    string dest, comp, jump;
    string part = line;
    size_t eq = part.find('=');
    if (eq != string::npos) {
        dest = part.substr(0, eq);
        part = part.substr(eq + 1);
    }
    size_t sc = part.find(';');
    if (sc != string::npos) {
        comp = part.substr(0, sc);
        jump = part.substr(sc + 1);
    } else {
        comp = part;
    }
    return "111" + comp_to_bin(trim(comp)) + dest_to_bin(trim(dest)) + jump_to_bin(trim(jump));
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        cout << "Usage: ./HackAssembler Prog.asm\n";
        return 1;
    }

    string asm_file = argv[1];
    string hack_file = asm_file.substr(0, asm_file.find_last_of('.')) + ".hack";

    ifstream in(asm_file);
    ofstream out(hack_file);
    string line;

    while (getline(in, line)) {
        line = trim(line);
        if (line.empty() || line[0] == '/') continue;  

        size_t comment_pos = line.find("//");
        if (comment_pos != string::npos)
            line = trim(line.substr(0, comment_pos));

        if (line.empty()) continue;

        if (is_a_instruction(line)) {
            int value = stoi(line.substr(1));
            out << to_binary(value) << endl;
        } else {
            out << translate_c_instruction(line) << endl;
        }
    }

    in.close();
    out.close();

    cout << "Translated it to: " << hack_file << endl;
    return 0;
}