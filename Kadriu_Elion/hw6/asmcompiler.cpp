#include <iostream>
#include <fstream>
#include <sstream>
#include <unordered_map>
#include <vector>
#include <bitset>
#include <regex>

using namespace std;

unordered_map<string, string> compTable = {
    {"0", "0101010"},  {"1", "0111111"},  {"-1", "0111010"}, {"D", "0001100"},
    {"A", "0110000"},  {"!D", "0001101"}, {"!A", "0110001"}, {"-D", "0001111"},
    {"-A", "0110011"}, {"D+1", "0011111"},{"A+1", "0110111"},{"D-1", "0001110"},
    {"A-1", "0110010"},{"D+A", "0000010"},{"D-A", "0010011"},{"A-D", "0000111"},
    {"D&A", "0000000"},{"D|A", "0010101"},{"M", "1110000"},  {"!M", "1110001"},
    {"-M", "1110011"}, {"M+1", "1110111"},{"M-1", "1110010"},{"D+M", "1000010"},
    {"D-M", "1010011"},{"M-D", "1000111"},{"D&M", "1000000"},{"D|M", "1010101"}
};

unordered_map<string, string> destTable = {
    {"",   "000"}, {"M",  "001"}, {"D",  "010"}, {"MD", "011"},
    {"A",  "100"}, {"AM", "101"}, {"AD", "110"}, {"AMD","111"}
};

unordered_map<string, string> jumpTable = {
    {"",   "000"}, {"JGT","001"}, {"JEQ","010"}, {"JGE","011"},
    {"JLT","100"}, {"JNE","101"}, {"JLE","110"}, {"JMP","111"}
};

unordered_map<string, int> symbolTable = {
    {"SP", 0},     {"LCL", 1},   {"ARG", 2},   {"THIS", 3},  {"THAT", 4},
    {"R0", 0},     {"R1", 1},    {"R2", 2},    {"R3", 3},    {"R4", 4},
    {"R5", 5},     {"R6", 6},    {"R7", 7},    {"R8", 8},    {"R9", 9},
    {"R10", 10},   {"R11", 11},  {"R12", 12},  {"R13", 13},  {"R14", 14},
    {"R15", 15},   {"SCREEN", 16384}, {"KBD", 24576}
};

string trim(const string &str) {
    size_t start = str.find_first_not_of(" \t\r\n");
    if (start == string::npos) return "";
    size_t end = str.find_last_not_of(" \t\r\n");
    return str.substr(start, end - start + 1);
}

string toBinary(int num) {
    return bitset<16>(num).to_string();
}

bool isNumber(const string &s) {
    return regex_match(s, regex("\\d+"));
}

void firstPass(const vector<string>& lines, unordered_map<string, int>& table) {
    int romAddr = 0;
    for (const string &line : lines) {
        string cleaned = trim(line);
        if (cleaned.empty() || cleaned[0] == '/') continue;
        if (cleaned.find('(') == 0 && cleaned.back() == ')') {
            string label = cleaned.substr(1, cleaned.size() - 2);
            table[label] = romAddr;
        } else {
            romAddr++;
        }
    }
}

vector<string> loadCleanLines(const string& filename) {
    ifstream file(filename);
    string line;
    vector<string> lines;
    while (getline(file, line)) {
        // Remove comments
        auto pos = line.find("//");
        if (pos != string::npos) line = line.substr(0, pos);
        lines.push_back(trim(line));
    }
    return lines;
}

string parseCInstruction(const string& line) {
    string dest, comp, jump;
    size_t eq = line.find('=');
    size_t sc = line.find(';');

    if (eq != string::npos) {
        dest = line.substr(0, eq);
        if (sc != string::npos)
            comp = line.substr(eq + 1, sc - eq - 1);
        else
            comp = line.substr(eq + 1);
    } else {
        dest = "";
        if (sc != string::npos)
            comp = line.substr(0, sc);
        else
            comp = line;
    }

    if (sc != string::npos)
        jump = line.substr(sc + 1);
    else
        jump = "";

    return "111" + compTable[trim(comp)] + destTable[trim(dest)] + jumpTable[trim(jump)];
}

void assemble(const string &inputFile, const string &outputFile) {
    vector<string> lines = loadCleanLines(inputFile);
    firstPass(lines, symbolTable);

    ofstream output(outputFile);
    int ramAddr = 16;

    for (const string &lineRaw : lines) {
        string line = trim(lineRaw);
        if (line.empty() || line[0] == '/' || (line.front() == '(' && line.back() == ')')) continue;

        if (line[0] == '@') {
            string symbol = line.substr(1);
            int addr;

            if (isNumber(symbol)) {
                addr = stoi(symbol);
            } else {
                if (symbolTable.find(symbol) == symbolTable.end()) {
                    symbolTable[symbol] = ramAddr++;
                }
                addr = symbolTable[symbol];
            }
            output << toBinary(addr) << '\n';
        } else {
            output << parseCInstruction(line) << '\n';
        }
    }

    output.close();
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        cerr << "Usage: " << argv[0] << " input.asm output.hack\n";
        return 1;
    }
    assemble(argv[1], argv[2]);
    cout << "Assembly complete. Output written to " << argv[2] << "\n";
    return 0;
}

