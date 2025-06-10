# RISC-V-Processor-with-5-Stage-Pipelining-RTL-Design-and-Pipelining-Architecture
RISC-V is an open-source, modular instruction set architecture (ISA) based on Reduced Instruction Set Computing (RISC) principles. Developed at the University of California, Berkeley, it is freely available and widely adopted in academia, research, and industry. Unlike proprietary ISAs like x86 or ARM, RISC-V allows customization and scalability, enabling designs ranging from simple microcontrollers to high-performance CPUs.

A standard RISC-V processor includes five pipeline stages: Instruction Fetch (IF), Instruction Decode (ID), Execute (EX), Memory Access (MEM), and Write Back (WB). It supports 32-bit, 64-bit, and 128-bit variants, with optional extensions like integer (I), multiplication/division (M), atomic (A), floating-point (F/D), and compressed instructions (C), allowing flexible architecture tailoring.

This project focuses on the design and verification of a 64-bit 5-stage pipelined RISC-V processor using Verilog HDL. It includes modular components such as the ALU, control unit, register file, instruction and data memory, forwarding and hazard detection units. The processor is simulated and verified using Xilinx ISE/ISim to generate waveform outputs and validate correct instruction flow.

By modeling the processor in Verilog, we gain low-level control, enabling hardware realization via FPGA synthesis, efficient debugging, and deep understanding of pipeline behavior, instruction execution, and performance bottlenecks.








