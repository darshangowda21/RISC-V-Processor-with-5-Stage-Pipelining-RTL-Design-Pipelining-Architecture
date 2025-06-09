`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11:07:41 06/09/2025
// Design Name:
// Module Name: alu_64bitd
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
module alu_64bitd(
 input wire [63:0] a, // Operand A
 input wire [63:0] b, // Operand B
 input [3:0] alu_ctrl, // ALU control signal
 output reg [63:0] result, // Result of the operation
 output reg zero // Zero flag
);
 // ALU control signal encoding
 localparam ADD = 4'b0000; // Addition
 localparam SUB = 4'b0001; // Subtraction
 localparam AND_OP = 4'b0010; // Logical AND
 localparam OR_OP = 4'b0011; // Logical OR
 localparam XOR_OP = 4'b0100; // Logical XOR
 localparam SLL = 4'b0101; // Logical left shift
 localparam SRL = 4'b0110; // Logical right shift
 localparam SRA = 4'b0111; // Arithmetic right shift
 always @(*) begin
 case (alu_ctrl)
 ADD: result = a + b;
 SUB: result = a - b;
 AND_OP: result = a & b;
 OR_OP: result = a | b;
 XOR_OP: result = a ^ b;
 SLL: result = a << b[5:0]; // shift amount limited to 0-63
 SRL: result = a >> b[5:0];
 SRA: result = $signed(a) >>> b[5:0];
 default: begin
 result = 64'b0;
 end
 endcase
 // Zero flag: Asserted if the result is zero
 zero = (result == 64'b0);
 end
endmodule
 