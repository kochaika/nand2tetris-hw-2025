import { Parser } from './parser';
import { Code } from './main';
import { SymbolTable } from './symbolTable';
import * as fs from 'fs';
import * as path from 'path';

export class HackAssembler {
    private parser: Parser;
    private symbolTable: SymbolTable;

    constructor(private assemblyCode: string) {
        this.symbolTable = new SymbolTable();
        this.parser = new Parser(assemblyCode);
    }

    assemble(): string {
        this.firstPass();
        return this.secondPass();
    }

    private firstPass(): void {
        const tempParser = new Parser(this.assemblyCode);
        let romAddress = 0;

        while (tempParser.hasMoreCommands()) {
            tempParser.advance();
            const type = tempParser.commandType();

            if (type === 'L_COMMAND') {
                const symbol = tempParser.symbol();
                this.symbolTable.addEntry(symbol, romAddress);
            } else if (type === 'A_COMMAND' || type === 'C_COMMAND') {
                romAddress++;
            }
        }
    }

    private secondPass(): string {
        const output: string[] = [];
        this.parser = new Parser(this.assemblyCode);

        while (this.parser.hasMoreCommands()) {
            this.parser.advance();
            const type = this.parser.commandType();

            if (type === 'A_COMMAND') {
                const symbol = this.parser.symbol();
                let address: number;

                if (/^\d+$/.test(symbol)) {
                    address = parseInt(symbol, 10);
                } else {
                    if (!this.symbolTable.contains(symbol)) {
                        address = this.symbolTable.addVariable(symbol);
                    } else {
                        address = this.symbolTable.getAddress(symbol);
                    }
                }

                const binary = '0' + address.toString(2).padStart(15, '0');
                output.push(binary);
            } else if (type === 'C_COMMAND') {
                const comp = Code.comp(this.parser.comp());
                const dest = Code.dest(this.parser.dest());
                const jump = Code.jump(this.parser.jump());
                const binary = '111' + comp + dest + jump;
                output.push(binary);
            }
        }

        return output.join('\n');
    }
}

// Command-line interface
if (require.main === module) {
    const args = process.argv.slice(2);
    if (args.length !== 1) {
        console.error('Usage: ts-node assembler.ts <input.asm>');
        process.exit(1);
    }

    const inputFile = args[0];
    const outputFile = path.join('bin', path.basename(inputFile).replace('.asm', '.hack'));

    // Create bin directory if it doesn't exist
    if (!fs.existsSync('bin')) {
        fs.mkdirSync('bin');
    }

    try {
        const asmCode = fs.readFileSync(inputFile, 'utf-8');
        const assembler = new HackAssembler(asmCode);
        const machineCode = assembler.assemble();
        
        if (machineCode.trim() === '') {
            throw new Error('Generated empty machine code - check input file');
        }
        
        fs.writeFileSync(outputFile, machineCode);
        console.log(`Successfully assembled ${inputFile} to ${outputFile}`);
    } catch (error:any) {
        console.error(`Error: ${error.message}`);
        process.exit(1);
    }
}