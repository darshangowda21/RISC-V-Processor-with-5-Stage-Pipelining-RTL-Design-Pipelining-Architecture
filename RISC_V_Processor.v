`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11:19:54 06/09/2025
// Design Name:
// Module Name: RISC_V_Processor
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module RISC_V_Processor(
 input clk,
 input reset,
 output [63:0] debug_pc,
 output [31:0] debug_instruction,
 output [63:0] debug_alu_result
);
// Wire declarations
wire [63:0] PC_In, PC_Out, NextPC_In, BranchPC_In;
wire [63:0] imm_data, ReadData1, ReadData2, writeData, ReadData3;
wire [63:0] ALUResult, MemRead_Data, updatedData1, updatedData2;
wire [31:0] Instruction;
wire [6:0] opcode, funct7;
wire [4:0] rd, rs1, rs2;
wire [3:0] Operation;
wire [2:0] funct3;
wire [1:0] ALUOp, ForwardA, ForwardB;
wire Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite, zero;
wire shouldBranch;
// IF/ID
wire [63:0] pcID;
wire [31:0] insID;
// ID/EX
wire [63:0] data1EX, data2EX, immDataEX, pcEX;
wire [4:0] rdEX, rs1EX, rs2EX;
wire [3:0] functEX;
wire BranchEX, MemReadEX, MemtoRegEX, MemWriteEX, ALUSrcEX, RegWriteEX;
wire [1:0] ALUOpEX;
// EX/MEM
wire [63:0] aluResultMEM, data2MEM, pcMEM;
wire [4:0] rdMEM;
wire BranchMEM, MemReadMEM, MemtoRegMEM, MemWriteMEM, RegWriteMEM, zeroMEM;
// MEM/WB
wire [63:0] aluResultWB, MemRead_DataWB;
wire [4:0] rdWB;
wire MemtoRegWB, RegWriteWB;
// Instruction Fetch
Program_Counter pc(
 .clk(clk), .reset(reset), .PC_In(PC_In), .PC_Out(PC_Out)
);
Adder adder(
 .a(PC_Out), .b(64'd4), .out(NextPC_In)
);
Instruction_Memory insMem(
 .Inst_Address(PC_Out), .Instruction(Instruction)
);
mux newPCMux(
 .in1(NextPC_In), .in2(pcMEM), .out(PC_In), .sel(shouldBranch)
);
IDRegister idReg(
 .clk(clk), .reset(reset),
 .PC_in(PC_Out), .ins_in(Instruction),
 .PC_out(pcID), .ins_out(insID)
);
// Instruction Decode
parser insPar(
 .ins(insID), .opcode(opcode), .rd(rd), .funct3(funct3),
 .rs1(rs1), .rs2(rs2), .funct7(funct7)
);
Control_Unit ct(
 .Opcode(opcode), .Branch(Branch), .MemRead(MemRead), .
 MemtoReg(MemtoReg), .MemWrite(MemWrite), .ALUSrc(ALUSrc),
 .RegWrite(RegWrite), .ALUOp(ALUOp)
);
extractor e(
 .ins(insID), .imm_data(imm_data)
);
registerFile rf(
 .rs1(rs1), .rs2(rs2), .rd(rdWB), .clk(clk), .reset(reset),
 .regWrite(RegWriteWB), .writeData(writeData),
 .ReadData1(ReadData1), .ReadData2(ReadData2)
);
// Execute
ALU_Control aluCt(
 .ALUOp(ALUOpEX), .Funct(functEX), .Operation(Operation)
);
Adder adder1(
 .a(pcEX), .b(immDataEX << 1), .out(BranchPC_In)
);
mux2 data1ForwardingMux(
 .in1(data1EX), .in2(writeData), .in3(aluResultMEM),
 .sel(ForwardA), .out(updatedData1)
);
mux2 data2ForwardingMux(
 .in1(data2EX), .in2(writeData), .in3(aluResultMEM),
 .sel(ForwardB), .out(updatedData2)
);
ForwardingUnit fwd(
 .rdMem(rdMEM), .regWriteMem(RegWriteMEM), .rdWb(rdWB),
 .regWriteWb(RegWriteWB), .rs1(rs1EX), .rs2(rs2EX),
 .ForwardA(ForwardA), .ForwardB(ForwardB)
);
mux aluSrcMux(
 .in1(updatedData2), .in2(immDataEX), .out(ReadData3),
 .sel(ALUSrcEX)
);
alu_64bitd alu( .a(updatedData1), .b(ReadData3), .alu_ctrl(Operation),
 .result(ALUResult), .zero(zero)
);
MEMRegister memReg(
 .clk(clk), .reset(reset), .PC_in(BranchPC_In),
 .aluResult_in(ALUResult), .data2_in(updatedData2), .rd_in(rdEX),
 .Branch_in(BranchEX), .MemRead_in(MemReadEX), .MemtoReg_in(MemtoRegEX),
 .MemWrite_in(MemWriteEX), .RegWrite_in(RegWriteEX), .zero_in(zero),
 .aluResult_out(aluResultMEM), .data2_out(data2MEM), .rd_out(rdMEM),
 .Branch_out(BranchMEM), .MemRead_out(MemReadMEM),
 .MemtoReg_out(MemtoRegMEM), .MemWrite_out(MemWriteMEM),
 .RegWrite_out(RegWriteMEM), .PC_out(pcMEM), .zero_out(zeroMEM));
assign shouldBranch = BranchMEM & zeroMEM;
Data_Memory uut(
 .Mem_Addr(aluResultMEM), .Write_Data(updatedData2), .clk(clk),
 .MemWrite(MemWriteMEM), .MemRead(MemReadMEM), .wordSize(2'b11),
 .Read_Data(MemRead_Data)
);
WBRegister wbReg(
 .clk(clk), .reset(reset),
 .aluResult_in(aluResultMEM), .memData_in(MemRead_Data), .rd_in(rdMEM),
 .MemtoReg_in(MemtoRegMEM), .RegWrite_in(RegWriteMEM),
 .aluResult_out(aluResultWB), .memData_out(MemRead_DataWB),
 .rd_out(rdWB), .MemtoReg_out(MemtoRegWB), .RegWrite_out(RegWriteWB)
);
mux memRegMux(
 .in1(aluResultWB), .in2(MemRead_DataWB), .out(writeData),
 .sel(MemtoRegWB)
);
assign debug_pc = PC_Out;
assign debug_instruction = Instruction;
assign debug_alu_result = ALUResult;
endmodule