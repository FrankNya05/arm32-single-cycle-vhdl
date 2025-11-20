# ARMv4-Style 32-bit Processor (VHDL)

A modular, synthesizable ARM CPU implemented in VHDL as part of academic projects and extended with new features (CMP and Barrel Shifter).

This repository contains:

- A complete **ARM datapath (Registers, ALU, Shifter, Data Memory)**
- A structured **Control Unit** (Main Decoder + ALU Decoder + Condition Logic)
- A functional **Instruction Memory with PC update**
- Full integration + **testbenches with automated checking**

This project serves as a strong foundation for hardware design skills (RTL, architecture, simulation).

---

## Features Implemented

### Base Datapath
- 32-bit ALU with ADD, SUB, AND, OR operations  
- ALU flags: **N, Z, C, V**  
- Register File (16 registers, R15 = PC)  
- Data Memory (load/store instructions)  
- Immediate extension unit  
- SrcA/SrcB operand multiplexing  

---

### Control Unit
- Main Decoder (opcode + funct field)  
- ALU Decoder (instruction-specific ALU control)  
- Conditional Execution (ARM-style `cond` field)  
- Flag Write control (FlagW)  
- RegSrc, MemToReg, ALUSrc, RegW, MemWrite, ImmSrc  

---

### Instruction Memory + PC Logic
- 32×32-bit instruction ROM preloaded with lab instructions  
- PC register with reset and +4 increment  
- PC+4 and PC+8 computed (branch logic reserved for future work)  

---

## 🟢 Mini-Project Extensions

### CMP Instruction
- Internal subtraction (A – B)  
- Updates N/Z/C/V flags  
- **No writeback to Register File**  
- Integrated into ALU Decoder + Control Unit  

### Barrel Shifter
- Logical shift left (LSL)  
- Logical shift right (LSR)  
- Arithmetic shift right (ASR) *(optional)*  
- Positioned before the ALU as in ARM architecture  
- Control logic updated to route shifted operands  

---

## 🧪 Testing & Verification

All modules were validated using **Vivado simulation**:

- ALU operations + flag behavior  
- Register File read/write  
- Memory load/store  
- Immediate extension paths  
- CMP flag-only update behavior  
- Shifter outputs across multiple shift amounts  
- Full CPU testbench running 20+ test instructions  

✔️ **All tests passed successfully.**

Waveform examples can be found in the `/docs/waveforms/` directory (if added).

---

## 🚀 Running the Simulation

1. Open Vivado  
2. Create a new project → “RTL Project”  
3. Add all `.vhd` files inside `/src/`  
4. Add the testbenches under `/sim/`  
5. Set `ARM_tb.vhd` as the top simulation source  
6. Run the behavioral simulation

---

## 📚 Future Improvements

Planned upgrades:

- Implement full barrel shifter behavioral modes  
- Add branch instructions (BEQ, BNE, etc.)  
- Add more ALU ops (XOR, MOV, MVN, RSB…)  
- Pipeline stages (Fetch, Decode, Execute…)  
- Hazard detection and forwarding  
 
---
