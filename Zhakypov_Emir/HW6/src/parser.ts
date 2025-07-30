import { CommandType, ParsedCommand, DestMnemonic, CompMnemonic, JumpMnemonic } from './types';

export class Parser {
    private lines: string[];
    private currentLine: number;
    private currentCommand: ParsedCommand | null;


    constructor(assemblyCode: string) {
        this.lines = assemblyCode
            .split('\n')
            .map(line => {
                // Remove comments and trim
                const clean = line.split('//')[0].trim();
                return clean;
            })
            .filter(line => line.length > 0); // Remove empty lines
        
        this.currentLine = -1;
        this.currentCommand = null;
    }

    hasMoreCommands(): boolean {
        return this.currentLine < this.lines.length - 1;
    }

    advance(): void {
        this.currentLine++;
        const line = this.lines[this.currentLine];
        this.currentCommand = this.parseCommand(line);
    }

    commandType(): CommandType {
        if (!this.currentCommand) throw new Error('No command loaded');
        return this.currentCommand.type;
    }

    symbol(): string {
        if (!this.currentCommand || !this.currentCommand.symbol) {
            throw new Error('No symbol in current command');
        }
        return this.currentCommand.symbol;
    }

    dest(): DestMnemonic {
        if (!this.currentCommand) throw new Error('No command loaded');
        return this.currentCommand.dest || null;
    }

    comp(): CompMnemonic {
        if (!this.currentCommand || !this.currentCommand.comp) {
            throw new Error('No comp in current command');
        }
        return this.currentCommand.comp;
    }

    jump(): JumpMnemonic {
        if (!this.currentCommand) throw new Error('No command loaded');
        return this.currentCommand.jump || null;
    }

    private parseCommand(line: string): ParsedCommand {
        // Remove inline comments first
    const cleanLine = line.split('//')[0].trim();
    
    // Skip empty lines after comment removal
        if (cleanLine === '') {
            throw new Error('Empty line after comment removal');
        }   
        if (line === '') {
            throw new Error('Empty line');
        }
        // A-command: @value
        if (line.startsWith('@')) {
            return {
                type: 'A_COMMAND',
                symbol: line.substring(1)
            };
        }
        
        // L-command: (LABEL)
        if (line.startsWith('(') && line.endsWith(')')) {
            return {
                type: 'L_COMMAND',
                symbol: line.substring(1, line.length - 1)
            };
        }
        
        // C-command: dest=comp;jump
        let dest: DestMnemonic = null;
        let comp: string;
        let jump: JumpMnemonic = null;
        
        const hasDest = line.includes('=');
        const hasJump = line.includes(';');
        
        if (hasDest && hasJump) {
            const [destPart, rest] = line.split('=');
            const [compPart, jumpPart] = rest.split(';');
            dest = destPart as DestMnemonic;
            comp = compPart;
            jump = jumpPart as JumpMnemonic;
        } else if (hasDest) {
            const [destPart, compPart] = line.split('=');
            dest = destPart as DestMnemonic;
            comp = compPart;
        } else if (hasJump) {
            const [compPart, jumpPart] = line.split(';');
            comp = compPart;
            jump = jumpPart as JumpMnemonic;
        } else {
            comp = line;
        }
        
        return {
            type: 'C_COMMAND',
            dest,
            comp: comp as CompMnemonic,
            jump
        };
    }
}