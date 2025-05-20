import java.io.*;
import java.util.*;

class HackAssembler {
    private static final Map<String, String> compTable = new HashMap<>();
    private static final Map<String, String> destTable = new HashMap<>();
    private static final Map<String, String> jumpTable = new HashMap<>();
    private static Map<String, Integer> symbolTable;
    private static int nextVariableAddress = 16;
    static {
        compTable.put("0",   "0101010");
        compTable.put("1",   "0111111");
        compTable.put("-1",  "0111010");
        compTable.put("D",   "0001100");
        compTable.put("A",   "0110000");
        compTable.put("!D",  "0001101");
        compTable.put("!A",  "0110001");
        compTable.put("-D",  "0001111");
        compTable.put("-A",  "0110011");
        compTable.put("D+1", "0011111");
        compTable.put("A+1", "0110111");
        compTable.put("D-1", "0001110");
        compTable.put("A-1", "0110010");
        compTable.put("D+A", "0000010");
        compTable.put("D-A", "0010011");
        compTable.put("A-D", "0000111");
        compTable.put("D&A", "0000000");
        compTable.put("D|A", "0010101");
        compTable.put("M",   "1110000");
        compTable.put("!M",  "1110001");
        compTable.put("-M",  "1110011");
        compTable.put("M+1", "1110111");
        compTable.put("M-1", "1110010");
        compTable.put("D+M", "1000010");
        compTable.put("D-M", "1010011");
        compTable.put("M-D", "1000111");
        compTable.put("D&M", "1000000");
        compTable.put("D|M", "1010101");

        destTable.put(null,  "000");
        destTable.put("M",   "001");
        destTable.put("D",   "010");
        destTable.put("MD",  "011");
        destTable.put("A",   "100");
        destTable.put("AM",  "101");
        destTable.put("AD",  "110");
        destTable.put("AMD", "111");

        jumpTable.put(null,  "000");
        jumpTable.put("JGT", "001");
        jumpTable.put("JEQ", "010");
        jumpTable.put("JGE", "011");
        jumpTable.put("JLT", "100");
        jumpTable.put("JNE", "101");
        jumpTable.put("JLE", "110");
        jumpTable.put("JMP", "111");
    }

    public static void main(String[] args) {
        if (args.length != 1) {
            System.err.println("Usage: java HackAssembler <input.asm>");
            System.exit(1);
        }
        String inputFile = args[0];
        String outputFile = inputFile.replace(".asm", ".hack");
        try {
            symbolTable = buildSymbolTable(inputFile);            
            List<String> binaryInstructions = translateAssembly(inputFile);            
            writeOutput(outputFile, binaryInstructions);
        } catch (IOException e) {
            System.err.println("Error processing file: " + e.getMessage());
            System.exit(1);
        }
    }

    private static Map<String, Integer> buildSymbolTable(String filename) throws IOException {
        Map<String, Integer> table = new HashMap<>();        
        table.put("SP", 0);
        table.put("LCL", 1);
        table.put("ARG", 2);
        table.put("THIS", 3);
        table.put("THAT", 4);
        table.put("R0", 0);
        table.put("R1", 1);
        table.put("R2", 2);
        table.put("R3", 3);
        table.put("R4", 4);
        table.put("R5", 5);
        table.put("R6", 6);
        table.put("R7", 7);
        table.put("R8", 8);
        table.put("R9", 9);
        table.put("R10", 10);
        table.put("R11", 11);
        table.put("R12", 12);
        table.put("R13", 13);
        table.put("R14", 14);
        table.put("R15", 15);
        table.put("SCREEN", 16384);
        table.put("KBD", 24576);

        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            String line;
            int romAddress = 0;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                int commentIndex = line.indexOf("//");
                if (commentIndex != -1) {
                    line = line.substring(0, commentIndex).trim();
                }                
                if (line.isEmpty()) continue;
                if (line.startsWith("(") && line.endsWith(")")) {
                    String label = line.substring(1, line.length() - 1);
                    table.put(label, romAddress);
                } else {
                    romAddress++;
                }
            }
        }
        return table;
    }

    private static List<String> translateAssembly(String filename) throws IOException {
        List<String> binaryInstructions = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(filename))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                int commentIndex = line.indexOf("//");
                if (commentIndex != -1) {
                    line = line.substring(0, commentIndex).trim();
                }                
                if (line.isEmpty() || line.startsWith("(")) continue;
                if (line.startsWith("@")) {
                    String value = line.substring(1);
                    binaryInstructions.add(translateAInstruction(value));
                } else {
                    binaryInstructions.add(translateCInstruction(line));
                }
            }
        }
        return binaryInstructions;
    }

    private static String translateAInstruction(String value) {
        int address;
        if (value.matches("\\d+")) {
            address = Integer.parseInt(value);
        } else {
            if (!symbolTable.containsKey(value)) {
                symbolTable.put(value, nextVariableAddress++);
            }
            address = symbolTable.get(value);
        }        
        String binary = Integer.toBinaryString(address);
        return "0" + String.format("%15s", binary).replace(' ', '0');
    }

    private static String translateCInstruction(String instruction) {
        String dest = null;
        String comp;
        String jump = null;        
        if (instruction.contains("=")) {
            String[] parts = instruction.split("=");
            dest = parts[0];
            instruction = parts[1];
        }
        if (instruction.contains(";")) {
            String[] parts = instruction.split(";");
            comp = parts[0];
            jump = parts[1];
        } else {
            comp = instruction;
        }        
        return "111" + 
               compTable.get(comp) +
               destTable.get(dest) +
               jumpTable.get(jump);
    }

    private static void writeOutput(String filename, List<String> instructions) throws IOException {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filename))) {
            for (String instruction : instructions) {
                writer.write(instruction);
                writer.newLine();
            }
        }
    }
}