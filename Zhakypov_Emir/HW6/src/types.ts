export type CommandType = 'A_COMMAND' | 'C_COMMAND' | 'L_COMMAND';
export type DestMnemonic = 'M' | 'D' | 'MD' | 'A' | 'AM' | 'AD' | 'AMD' | null;
export type CompMnemonic = '0' | '1' | '-1' | 'D' | 'A' | '!D' | '!A' | '-D' | '-A' | 
                    'D+1' | 'A+1' | 'D-1' | 'A-1' | 'D+A' | 'D-A' | 'A-D' | 
                    'D&A' | 'D|A' | 'M' | '!M' | '-M' | 'M+1' | 'M-1' | 
                    'D+M' | 'D-M' | 'M-D' | 'D&M' | 'D|M';
export type JumpMnemonic = 'JGT' | 'JEQ' | 'JGE' | 'JLT' | 'JNE' | 'JLE' | 'JMP' | null;

export interface ParsedCommand {
    type: CommandType;
    symbol?: string;
    dest?: DestMnemonic;
    comp?: CompMnemonic;
    jump?: JumpMnemonic;
}