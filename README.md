# Digital_Systems_Project
VerySimpleCPU
CSE224 Project
Instruction Set Architecture (ISA) - v1
Each VerySimpleCPU instruction word has a fixed length of 32-bit.

Instruction Word				
bit position	[31:29]	[28]	[27:14]	[13:0]
field name	opcode	immediate	operand A	operand B
bit width	3-bit	1-bit	14-bit	14-bit
==================================================================

REGISTERS
IW: Instruction Word (32-bit)
PC: Program Counter (14-bit)
R1: General-Purpose Register (32-bit)
R2: General-Purpose Register (32-bit) - optional
==================================================================

INSTRUCTION SET
ARITHMETIC & LOGIC INSTRUCTIONS
ADD

unsigned add
opcode = 3'b000, im = 1'b0
microoperations
   R1              <- mem[IW[27:14]]
   R2              <- mem[IW[13:0]]
   mem[IW[27:14]]  <- (R1 + R2)
   PC              <- PC + 1
ADDi

unsigned add, immediate
opcode = 3'b000, im = 1'b1
microoperations
   R1              <- mem[IW[27:14]]
   R2              <- IW[13:0]
   mem[IW[27:14]]  <- (R1 + R2)
   PC              <- PC + 1
NAND

bitwise NAND
opcode = 3'b001, im = 1'b0
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- mem[IW[13:0]]
   mem[IW[27:14]] <- ~(R1 & R2)
   PC             <- PC + 1
NANDi

bitwise NAND, immediate
opcode = 3'b001, im = 1'b1
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- IW[13:0]
   mem[IW[27:14]] <- ~(R1 & R2)
   PC             <- PC + 1
SRL

shift right/left
opcode = 3'b010, im = 1'b0
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- mem[IW[13:0]]
   mem[IW[27:14]] <- (R2 < 32) ? (R1 >> R2) : (R1 << (R2-32))
   PC             <- PC + 1
SRLi

shift right/left, immediate
opcode = 3'b010, im = 1'b1
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- IW[13:0]
   mem[IW[27:14]] <- (R2 < 32) ? (R1 >> R2) : (R1 << (R2-32))
   PC             <- PC + 1
LT

compare and set
opcode = 3'b011, im = 1'b0
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- mem[IW[13:0]]
   mem[IW[27:14]] <- (R1 < R2) ? 1 : 0
   PC             <- PC + 1
LTi

compare and set, immediate
opcode = 3'b011, im = 1'b1
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- IW[13:0]
   mem[IW[27:14]] <- (R1 < R2) ? 1 : 0
   PC             <- PC + 1
MUL

unsigned multiply
opcode = 3'b111, im = 1'b0
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- mem[IW[13:0]]
   mem[IW[27:14]] <- (R1 * R2)
   PC             <- PC + 1
MULi

unsigned multiply, immediate
opcode = 3'b111, im = 1'b1
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- IW[13:0]
   mem[IW[27:14]] <- (R1 * R2)
   PC             <- PC + 1
DATA TRANSFER INSTRUCTIONS
CP

copy data
opcode = 3'b100, im = 1'b0
microoperations
   R2             <- mem[IW[13:0]]
   mem[IW[27:14]] <- R2
   PC             <- PC + 1
CPi

copy data, immediate
opcode = 3'b100, im = 1'b1
microoperations
   R2             <- IW[13:0]
   mem[IW[27:14]] <- R2
   PC             <- PC + 1
CPI

copy data indirect
opcode = 3'b101, im = 1'b0
microoperations
   R1             <- mem[IW[13:0]]
   R2             <- mem[R1]
   mem[IW[27:14]] <- R2
   PC             <- PC + 1
CPIi

copy data indirect, immediate
opcode = 3'b101, im = 1'b1
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- mem[IW[13:0]]
   mem[R1]        <- R2
   PC             <- PC + 1
PROGRAM CONTROL INSTRUCTIONS
BZJ

branch on zero
opcode = 3'b110, im = 1'b0
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- mem[IW[13:0]]
   PC             <- (R2 == 0) ? R1 : (PC + 1)
BZJi

unconditional branch
opcode = 3'b110, im = 1'b1
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- IW[13:0]
   PC             <- (R1 + R2)
Instruction Set Architecture (ISA) - v2
Each VerySimpleCPU instruction word has a fixed length of 32-bit.

Instruction Word			
bit position	[31:28]	[27:14]	[13:0]
field name	opcode	operand A	operand B
bit width	4-bit	14-bit	14-bit
==================================================================

REGISTERS
IW: Instruction Word (32-bit)
PC: Program Counter (14-bit)
R1: General-Purpose Register (32-bit)
R2: General-Purpose Register (32-bit) - optional
==================================================================

INSTRUCTION SET
CAUTION: (signed()/float() implies that operands inside them keep the data in signed/float format.)

ARITHMETIC & LOGIC INSTRUCTIONS
NAND

bitwise NAND
opcode = 4'b0000
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- mem[IW[13:0]]
   mem[IW[27:14]] <- ~(R1 & R2)
   PC             <- PC + 1
ADD

signed add
opcode = 4'b0001
microoperations
   R1              <- mem[IW[27:14]]
   R2              <- mem[IW[13:0]]
   mem[IW[27:14]]  <- (signed(R1) + signed(R2))
   PC              <- PC + 1
ADDF

floating-point add
opcode = 4'b0010
microoperations
   R1              <- mem[IW[27:14]]
   R2              <- mem[IW[13:0]]
   mem[IW[27:14]]  <- (float(R1) + float(R2))
   PC              <- PC + 1
ADDi

signed add, immediate
opcode = 4'b0011
microoperations
   R1              <- mem[IW[27:14]]
   R2              <- IW[13:0]
   mem[IW[27:14]]  <- (signed(R1) + signed(R2))
   PC              <- PC + 1
LT

signed compare and set
opcode = 4'b0100
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- mem[IW[13:0]]
   mem[IW[27:14]] <- (signed(R1) < signed(R2)) ? 1 : 0
   PC             <- PC + 1
LTF

floating-point compare and set
opcode = 4'b0101
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- mem[IW[13:0]]
   mem[IW[27:14]] <- (float(R1) < float(R2)) ? 1 : 0
   PC             <- PC + 1
SRL

signed (arithmetic) shift right/left
opcode = 4'b0110
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- mem[IW[13:0]]
   mem[IW[27:14]] <- (signed(R2) < 32) ? (signed(R1) >>> signed(R2)) : (signed(R1) <<< (signed(R2)-32))
   PC             <- PC + 1
SRLi

signed (arithmetic) shift right/left, immediate
opcode = 4'b0111
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- IW[13:0]
   mem[IW[27:14]] <- (signed(R2) < 32) ? (signed(R1) >>> signed(R2)) : (signed(R1) <<< (signed(R2)-32))
   PC             <- PC + 1
MUL

signed multiply
opcode = 4'b1000
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- mem[IW[13:0]]
   mem[IW[27:14]] <- (signed(R1) * signed(R2))
   PC             <- PC + 1
MULF

floating-point multiply
opcode = 4'b1001
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- mem[IW[13:0]]
   mem[IW[27:14]] <- (float(R1) * float(R2))
   PC             <- PC + 1
DATA TRANSFER INSTRUCTIONS
CP

copy data
opcode = 4'b1010
microoperations
   R2             <- mem[IW[13:0]]
   mem[IW[27:14]] <- R2
   PC             <- PC + 1
CPi

copy data, immediate
opcode = 4'b1011
microoperations
   R2             <- IW[13:0]
   mem[IW[27:14]] <- R2
   PC             <- PC + 1
CPI

copy data indirect, regular
opcode = 4'b1100
microoperations
   R1             <- mem[IW[13:0]]
   R2             <- mem[R1]
   mem[IW[27:14]] <- R2
   PC             <- PC + 1
CPIr

copy data indirect, reverse
opcode = 4'b1101
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- mem[IW[13:0]]
   mem[R1]        <- R2
   PC             <- PC + 1
PROGRAM CONTROL INSTRUCTIONS
BZ

branch on zero
opcode = 4'b1110
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- mem[IW[13:0]]
   PC             <- (R2 == 0) ? R1 : (PC + 1)
JMP

unconditional branch
opcode = 4'b1111
microoperations
   R1             <- mem[IW[27:14]]
   R2             <- IW[13:0]
   PC             <- (signed(R1) + signed(R2))

