#include <iostream>
#include <fstream>
#include <string>
#include <map>
#include <vector>
#include <bitset>
#include <algorithm>
#include <regex>

class HackAssembler {
private:
    // Lookup tables for instruction components
    std::map<std::string, std::string> comp_table = {
        {"0", "0101010"}, {"1", "0111111"}, {"-1", "0111010"},
        {"D", "0001100"}, {"A", "0110000"}, {"M", "1110000"},
        {"!D", "0001101"}, {"!A", "0110001"}, {"!M", "1110001"},
        {"-D", "0001111"}, {"-A", "0110011"}, {"-M", "1110011"},
        {"D+1", "0011111"}, {"A+1", "0110111"}, {"M+1", "1110111"},
        {"D-1", "0001110"}, {"A-1", "0110010"}, {"M-1", "1110010"},
        {"D+A", "0000010"}, {"D+M", "1000010"}, {"D-A", "0010011"},
        {"D-M", "1010011"}, {"A-D", "0000111"}, {"M-D", "1000111"},
        {"D&A", "0000000"}, {"D&M", "1000000"}, {"D|A", "0010101"}, {"D|M", "1010101"}
    };

    std::map<std::string, std::string> dest_table = {
        {"", "000"}, {"M", "001"}, {"D", "010"}, {"MD", "011"},
        {"A", "100"}, {"AM", "101"}, {"AD", "110"}, {"AMD", "111"}
    };

    std::map<std::string, std::string> jump_table = {
        {"", "000"}, {"JGT", "001"}, {"JEQ", "010"}, {"JGE", "011"},
        {"JLT", "100"}, {"JNE", "101"}, {"JLE", "110"}, {"JMP", "111"}
    };

    std::map<std::string, int> symbol_table;
    
    // Initialize symbol table with predefined symbols
    void init_symbol_table() {
        symbol_table["SP"] = 0;
        symbol_table["LCL"] = 1;
        symbol_table["ARG"] = 2;
        symbol_table["THIS"] = 3;
        symbol_table["THAT"] = 4;
        symbol_table["SCREEN"] = 16384;
        symbol_table["KBD"] = 24576;
        
        // Initialize R0-R15
        for (int i = 0; i < 16; i++) {
            symbol_table["R" + std::to_string(i)] = i;
        }
    }

public:
    HackAssembler() {
        init_symbol_table();
    }

    // Remove comments and whitespace
    std::string clean_line(const std::string& line) {
        size_t comment_pos = line.find("//");
        std::string cleaned = (comment_pos != std::string::npos) ? 
            line.substr(0, comment_pos) : line;
            
        // Remove leading/trailing whitespace
        cleaned.erase(0, cleaned.find_first_not_of(" \t\r\n"));
        cleaned.erase(cleaned.find_last_not_of(" \t\r\n") + 1);
        return cleaned;
    }

    // Translate A-instruction to binary
    std::string translate_a_instruction(const std::string& instruction) {
        std::string value_str = instruction.substr(1); // Remove '@'
        int value = std::stoi(value_str);
        std::bitset<16> binary(value);
        return binary.to_string();
    }

    // Parse C-instruction into components
    struct CInstruction {
        std::string dest;
        std::string comp;
        std::string jump;
    };

    CInstruction parse_c_instruction(const std::string& instruction) {
        CInstruction parts;
        size_t equals_pos = instruction.find('=');
        size_t semicolon_pos = instruction.find(';');

        if (equals_pos != std::string::npos) {
            parts.dest = instruction.substr(0, equals_pos);
            parts.comp = instruction.substr(equals_pos + 1,
                (semicolon_pos != std::string::npos) ? 
                semicolon_pos - equals_pos - 1 : std::string::npos);
        } else {
            parts.dest = "";
            parts.comp = instruction.substr(0,
                (semicolon_pos != std::string::npos) ? 
                semicolon_pos : std::string::npos);
        }

        if (semicolon_pos != std::string::npos) {
            parts.jump = instruction.substr(semicolon_pos + 1);
        } else {
            parts.jump = "";
        }

        return parts;
    }

    // Translate C-instruction to binary
    std::string translate_c_instruction(const std::string& instruction) {
        CInstruction parts = parse_c_instruction(instruction);
        return "111" + comp_table[parts.comp] + 
               dest_table[parts.dest] + 
               jump_table[parts.jump];
    }

    // First pass to process labels
    void first_pass(const std::vector<std::string>& lines) {
        int line_number = 0;
        for (const auto& line : lines) {
            if (line[0] == '(' && line.back() == ')') {
                std::string label = line.substr(1, line.length() - 2);
                symbol_table[label] = line_number;
            } else {
                line_number++;
            }
        }
    }

    // Second pass to handle variables
    std::vector<std::string> second_pass(const std::vector<std::string>& lines) {
        std::vector<std::string> output_lines;
        int variable_address = 16;

        for (const auto& line : lines) {
            if (line[0] == '(' && line.back() == ')') {
                continue;
            }

            if (line[0] == '@') {
                std::string symbol = line.substr(1);
                if (!std::all_of(symbol.begin(), symbol.end(), ::isdigit)) {
                    if (symbol_table.find(symbol) == symbol_table.end()) {
                        symbol_table[symbol] = variable_address++;
                    }
                    output_lines.push_back("@" + 
                        std::to_string(symbol_table[symbol]));
                } else {
                    output_lines.push_back(line);
                }
            } else {
                output_lines.push_back(line);
            }
        }
        return output_lines;
    }

    // Main assembly function
    void assemble(const std::string& input_file, 
                 const std::string& output_file) {
        std::ifstream infile(input_file);
        std::vector<std::string> lines;
        std::string line;

        // Read and clean lines
        while (std::getline(infile, line)) {
            std::string cleaned = clean_line(line);
            if (!cleaned.empty()) {
                lines.push_back(cleaned);
            }
        }
        infile.close();

        // Process the assembly code
        first_pass(lines);
        std::vector<std::string> processed_lines = second_pass(lines);

        // Write output
        std::ofstream outfile(output_file);
        for (const auto& line : processed_lines) {
            std::string binary_code;
            if (line[0] == '@') {
                binary_code = translate_a_instruction(line);
            } else {
                binary_code = translate_c_instruction(line);
            }
            outfile << binary_code << "\n";
        }
        outfile.close();
    }
};
