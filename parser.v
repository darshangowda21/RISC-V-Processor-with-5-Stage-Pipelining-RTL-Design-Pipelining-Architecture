`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11:17:29 06/09/2025
// Design Name:
// Module Name: parser
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
module parser(
input wire [31:0] ins,
output wire [6:0] opcode,
wire [4:0] rd,
wire [2:0] funct3,
wire [4:0] rs1,
wire [4:0] rs2,
wire [6:0] funct7
);
assign opcode = ins[6:0];
assign rd = ins[11:7];
assign funct3 = ins[14:12];
assign rs1 = ins[19:15];
assign rs2 = ins[24:20];
assign funct7 = ins[31:25];
endmodule