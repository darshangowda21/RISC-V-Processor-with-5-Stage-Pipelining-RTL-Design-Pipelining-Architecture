`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11:18:24 06/09/2025
// Design Name:
// Module Name: Program_Counter
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
module Program_Counter(input clk, reset, [63:0] PC_In,
output reg [63:0] PC_Out
 );
always @(posedge reset or posedge clk)
begin
if(reset)
PC_Out <= 64'd0;
else
PC_Out <= PC_In;
end
endmodule