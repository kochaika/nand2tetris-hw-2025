#include <iostream>
#include <fstream>
#include <sstream>
#include <unordered_map>
#include <bitset>
#include <string>

using namespace std;

class HackAssembler {
public:
    HackAssembler(const string& inputFile, const string& outputFile) {
        this->inputFile=inputFile;
        this->outputFile=outputFile;
        initSymbolTable();
    }

    void assemble() {
        firstPass();
        secondPass();
    }

private:
    string inputFile;
    string outputFile;
    unordered_map<string,int> symbolTable;
    int nextVarAddr=16;

    void initSymbolTable() {
        symbolTable={
            {"SP",0},{"LCL",1},{"ARG",2},{"THIS",3},{"THAT",4},
            {"SCREEN",16384},{"KBD",24576}
        };
        for(int i=0;i<=15;++i){
            symbolTable["R"+to_string(i)]=i;
        }
    }

    void firstPass() {
        ifstream file(inputFile);
        string line;
        int addr=0;

        while(getline(file,line)){
            line=clean(line);
            if(line.empty()) continue;

            if(line.front()=='(' && line.back()==')'){
                string label=line.substr(1,line.size()-2);
                symbolTable[label]=addr;
            }else{
                addr++;
            }
        }

        file.close();
    }

    void secondPass() {
        ifstream file(inputFile);
        ofstream outFile(outputFile);
        string line;

        while(getline(file,line)){
            line=clean(line);
            if(line.empty() || (line.front()=='(' && line.back()==')')) continue;

            string bin=(line[0]=='@')?parseA(line):parseC(line);
            outFile<<bin<<endl;
        }

        file.close();
        outFile.close();
    }

    string clean(string line) {
        size_t comment=line.find("//");
        if(comment!=string::npos){
            line=line.substr(0,comment);
        }
        line.erase(remove_if(line.begin(),line.end(),::isspace),line.end());
        return line;
    }

    string parseA(const string& line) {
        string sym=line.substr(1);
        int addr;

        if(isdigit(sym[0])){
            addr=stoi(sym);
        }else{
            if(symbolTable.find(sym)==symbolTable.end()){
                symbolTable[sym]=nextVarAddr++;
            }
            addr=symbolTable[sym];
        }

        return bitset<16>(addr).to_string();
    }

    string parseC(const string& line) {
        string dest,comp,jump;
        size_t eq=line.find('=');
        size_t semi=line.find(';');

        if(eq!=string::npos){
            dest=line.substr(0,eq);
            comp=(semi!=string::npos)?line.substr(eq+1,semi-eq-1):line.substr(eq+1);
        }else{
            comp=(semi!=string::npos)?line.substr(0,semi):line;
        }

        if(semi!=string::npos){
            jump=line.substr(semi+1);
        }

        return "111"+compBits(comp)+destBits(dest)+jumpBits(jump);
    }

    string destBits(const string& d) {
        return string({(char)('1'*(d.find('A')!=string::npos)),
                       (char)('1'*(d.find('D')!=string::npos)),
                       (char)('1'*(d.find('M')!=string::npos))});
    }

    string compBits(const string& c) {
        static unordered_map<string,string> compTable={
            {"0","0101010"},{"1","0111111"},{"-1","0111010"},{"D","0001100"},{"A","0110000"},{"M","1110000"},
            {"!D","0001101"},{"!A","0110001"},{"!M","1110001"},{"-D","0001111"},{"-A","0110011"},{"-M","1110011"},
            {"D+1","0011111"},{"A+1","0110111"},{"M+1","1110111"},{"D-1","0001110"},{"A-1","0110010"},
            {"M-1","1110010"},{"D+A","0000010"},{"D+M","1000010"},{"D-A","0010011"},{"D-M","1010011"},
            {"A-D","0000111"},{"M-D","1000111"},{"D&A","0000000"},{"D&M","1000000"},{"D|A","0010101"},
            {"D|M","1010101"}
        };
        return compTable[c];
    }

    string jumpBits(const string& j) {
        static unordered_map<string,string> jumpTable={
            {"","000"},{"JGT","001"},{"JEQ","010"},{"JGE","011"},{"JLT","100"},
            {"JNE","101"},{"JLE","110"},{"JMP","111"}
        };
        return jumpTable[j];
    }
};

int main(int argc,char* argv[]) {
    if(argc!=3){
        cout<<"usage: ./HackAssembler input.asm output.hack"<<endl;
        return 1;
    }

    HackAssembler h(argv[1],argv[2]);
    h.assemble();
    cout<<"complied"<<endl;
    return 0;
}
