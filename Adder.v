`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11:06:37 06/09/2025
// Design Name:
// Module Name: Adder
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
module Adder(
input [63:0] a, [63:0] b,
output [63:0] out
);
assign out = a + b;
endmodule
