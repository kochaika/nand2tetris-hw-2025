#include <iostream>
#include <filesystem>
#include <string>
#include "hack_assembler.hpp"  // Include the header for HackAssembler

namespace fs = std::filesystem;

void batch_assemble() {
    HackAssembler assembler;
    
    // Iterate through all .asm files in current directory
    for (const auto& entry : fs::directory_iterator(".")) {
        std::string path = entry.path().string();
        if (path.ends_with(".asm")) {
            std::string output_path = path.substr(0, path.length() - 4) + ".hack";
            assembler.assemble(path, output_path);
            std::cout << "Compiled " << path << " to " << output_path << std::endl;
        }
    }
}

int main() {
    try {
        batch_assemble();
    } catch (const std::exception& e) {
        std::cerr << "Error: " << e.what() << std::endl;
        return 1;
    }
    return 0;
}
