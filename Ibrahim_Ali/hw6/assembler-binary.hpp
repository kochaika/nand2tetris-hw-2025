#ifndef HACK_ASSEMBLER_HPP
#define HACK_ASSEMBLER_HPP

#include <string>
#include <map>
#include <vector>

class HackAssembler {
private:
    // Lookup tables
    std::map<std::string, std::string> comp_table;
    std::map<std::string, std::string> dest_table;
    std::map<std::string, std::string> jump_table;
    std::map<std::string, int> symbol_table;

    // Helper struct for C-instruction components
    struct CInstruction {
        std::string dest;
        std::string comp;
        std::string jump;
    };

    // Private helper methods
    void init_symbol_table();
    std::string clean_line(const std::string& line);
    std::string translate_a_instruction(const std::string& instruction);
    CInstruction parse_c_instruction(const std::string& instruction);
    std::string translate_c_instruction(const std::string& instruction);
    void first_pass(const std::vector<std::string>& lines);
    std::vector<std::string> second_pass(const std::vector<std::string>& lines);

public:
    // Constructor
    HackAssembler();
    
    // Main assembly method
    void assemble(const std::string& input_file, const std::string& output_file);
};

#endif // HACK_ASSEMBLER_HPP
