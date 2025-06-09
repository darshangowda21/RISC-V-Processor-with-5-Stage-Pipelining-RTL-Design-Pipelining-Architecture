`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11:21:42 06/09/2025
// Design Name:
// Module Name: EXRegister
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
module EXRegister(
input wire clk,
 input wire reset,
 // Inputs
 input wire [63:0] PC_in,
 input wire [63:0] data1_in,
 input wire [63:0] data2_in,
 input wire [63:0] immData_in,
 input wire [4:0] rs1_in,
 input wire [4:0] rs2_in,
 input wire [4:0] rd_in,
 input wire [3:0] Funct_in,
 input wire Branch_in,
 input wire MemRead_in,
 input wire MemtoReg_in,
 input wire MemWrite_in,
 input wire ALUSrc_in,
 input wire RegWrite_in,
 input wire [1:0] ALUOp_in,
// Outputs
 output reg [63:0] PC_out,
 output reg [63:0] data1_out,
 output reg [63:0] data2_out,
 output reg [63:0] immData_out,
 output reg [4:0] rs1_out,
 output reg [4:0] rs2_out,
 output reg [4:0] rd_out,
 output reg [3:0] Funct_out,
 output reg Branch_out,
 output reg MemRead_out,
 output reg MemtoReg_out,
 output reg MemWrite_out,
 output reg ALUSrc_out,
 output reg RegWrite_out,
 output reg [1:0] ALUOp_out
);
always @(posedge clk or posedge reset) begin
 if (reset) begin
PC_out <= 64'b0;
 data1_out <= 64'b0;
 data2_out <= 64'b0;
 immData_out <= 64'b0;
 rs1_out <= 5'b0;
 rs2_out <= 5'b0;
 rd_out <= 5'b0;
 Funct_out <= 4'b0;
 Branch_out <= 1'b0;
 MemRead_out <= 1'b0;
 MemtoReg_out <= 1'b0;
 MemWrite_out <= 1'b0;
 ALUSrc_out <= 1'b0;
 RegWrite_out <= 1'b0;
 ALUOp_out <= 2'b0;
 end else begin
PC_out <= PC_in;
 data1_out <= data1_in;
 data2_out <= data2_in;
 immData_out <= immData_in;
 rs1_out <= rs1_in;
 rs2_out <= rs2_in;
 rd_out <= rd_in;
 Funct_out <= Funct_in;
 Branch_out <= Branch_in;
 MemRead_out <= MemRead_in;
 MemtoReg_out <= MemtoReg_in;
 MemWrite_out <= MemWrite_in;
 ALUSrc_out <= ALUSrc_in;
 RegWrite_out <= RegWrite_in;
 ALUOp_out <= ALUOp_in;
end
end
endmodule