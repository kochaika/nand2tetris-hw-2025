package org.example

import java.io.File

open class Instruction() {

}

data class AInstruction(val address: Int) : Instruction() {
    override fun toString(): String {
        return Integer.toBinaryString(address).padStart(16, '0')
    }
}

data class CInstruction(
    val a: Int,
    val c: Int,
    val d: Int,
    val j: Int
) : Instruction() {
    override fun toString(): String {
        return "111" + a.toString() + Integer.toBinaryString(c).padStart(6, '0') + Integer.toBinaryString(d)
            .padStart(3, '0') + Integer.toBinaryString(j).padStart(3, '0')
    }
}

class Assembler {
    var runningAddress = 0

    val symbol = mutableMapOf<String, Int>(
        "R0" to 0,
        "R1" to 1,
        "R2" to 2,
        "R3" to 3,
        "R4" to 4,
        "R5" to 5,
        "R6" to 6,
        "R7" to 7,
        "R8" to 8,
        "R9" to 9,
        "R10" to 10,
        "R11" to 11,
        "R12" to 12,
        "R13" to 13,
        "R14" to 14,
        "R15" to 15,
        "SCREEN" to 16384,
        "KBD" to 24576,
        "SP" to 0,
        "LCL" to 1,
        "ARG" to 2,
        "THIS" to 3,
        "THAT" to 4
    )

    val destCodeOf = mapOf<String?, Int>(
        null to 0,
        "M" to 1,
        "D" to 2,
        "DM" to 3,
        "MD" to 3,
        "A" to 4,
        "AM" to 5,
        "AD" to 6,
        "ADM" to 7
    )

    val compCodeOf = listOf(
        "0" to "0101010",
        "1" to "0111111",
        "-1" to "0111010",
        "D" to "0001100",
        "A" to "0110000",
        "!D" to "0001101",
        "!A" to "0110001",
        "-D" to "0001111",
        "-A" to "0110011",
        "D+1" to "0011111",
        "A+1" to "0110111",
        "D-1" to "0001110",
        "A-1" to "0110010",
        "D+A" to "0000010",
        "D-A" to "0010011",
        "A-D" to "0000111",
        "D&A" to "0000000",
        "D|A" to "0010101",
        "M" to "1110000",
        "!M" to "1110001",
        "M+1" to "1110111",
        "M-1" to "1110010",
        "D+M" to "1000010",
        "D-M" to "1010011",
        "M-D" to "1000111",
        "D&M" to "1000000",
        "D|M" to "1010101"
    ).associate { it.first to it.second.toInt(radix = 2) }

    val jumpCodeOf = mapOf<String?, Int>(
        null to 0,
        "JGT" to 1,
        "JEQ" to 2,
        "JGE" to 3,
        "JLT" to 4,
        "JNE" to 5,
        "JLE" to 6,
        "JMP" to 7
    )


    fun removedCommentsAndWhitespace(lines: List<String>): List<String> {
        return lines.map {
            if (!it.contains("//")) {
                it
            } else {
                it.substring(0, it.indexOf("//"))
            }
        }.map { it.dropWhile { it.isWhitespace() }.dropLastWhile { it.isWhitespace() }}.filter { !it.isBlank() }
    }

    fun parseCInstruction(line: String): CInstruction {
        val dest = if (line.contains("=")) line.takeWhile { it != '=' } else null
        val comp = if (line.contains("=")) line.removePrefix(dest!!).drop(1).takeWhile { it != ';' } else line.takeWhile { it != ';' }
        val jump = if (line.contains(";")) line.takeLastWhile { it != ';' } else null

        val destCode = destCodeOf.getOrElse(dest) { throw IllegalArgumentException("Can't parse dest=$dest in C-Instruction") }
        val compCode = compCodeOf.getOrElse(comp) { throw IllegalArgumentException("Can't parse comp=$comp in C-Instruction")}
        val jumpCode = jumpCodeOf.getOrElse(jump) { throw IllegalArgumentException("Can't parse jump=$jump in C-Instruction")}

        return CInstruction(compCode / 64, compCode % 64, destCode, jumpCode)
    }

    fun parseAInstruction(line: String): AInstruction {
        val line = line.drop(1)
        val x = line.toIntOrNull() ?: symbol.getOrElse(line) {
            symbol.put(line, runningAddress++)
            runningAddress - 1
        }
        return AInstruction(x)
    }

    fun parseInstruction(line: String): Instruction {
        if (line.startsWith("@")) {
            return parseAInstruction(line)
        } else {
            return parseCInstruction(line)
        }
    }

    fun run(text: String): String {
        var lines = text.split("\n")
        lines = removedCommentsAndWhitespace(lines)

        var cntInstruction = 0
        for (line in lines) {
            if (line.first() == '(') {
                check(line.last() == ')')
                symbol.put(line.drop(1).dropLast(1), cntInstruction)
            } else {
                cntInstruction++
            }
        }

        runningAddress = 16
        val instructions = mutableListOf<Instruction>()
        for (line in lines) {
            if (line.first() != '(') {
                instructions.add(parseInstruction(line))
            }
        }

        return instructions.joinToString("\n")
    }
}

fun main(args: Array<String>) {
    val input = File(args[0])
    val text = input.readText()

    val output = File(args[0].dropLastWhile { it != '.' } + "hack")

    val result = Assembler().run(text)

    output.writeText(result)
}