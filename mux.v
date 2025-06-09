`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11:16:51 06/09/2025
// Design Name:
// Module Name: mux
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
module mux(
input wire [63:0] in1, wire [63:0] in2, wire sel,
output reg [63:0] out
);
always @(in1 or in2 or sel)
begin
if (sel)
out <= in2;
else
out <= in1;
end
endmodule