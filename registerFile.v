`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11:19:08 06/09/2025
// Design Name:
// Module Name: registerFile
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
module registerFile(
input wire [4:0] rs1,
 input wire [4:0] rs2,
 input wire [4:0] rd,
 input wire clk,
 input wire reset,
 input wire regWrite,
 input wire [63:0] writeData,
 output wire [63:0] ReadData1,
 output wire [63:0] ReadData2);
 // Register array
 reg [63:0] registerArr[31:0];
 // Index variable for reset loop
 integer i; // Moved here (not inside procedural block)
 // Combinational reads
 assign ReadData1 = registerArr[rs1];
 assign ReadData2 = registerArr[rs2];
// Sequential writes and reset
 always @(posedge clk or posedge reset) begin
 if (reset) begin
 for (i = 0; i < 32; i = i + 1)
 registerArr[i] <= 64'b0;
 end else if (regWrite && (rd != 0)) begin
 registerArr[rd] <= writeData;
 end
 end
///endmodule
endmodule