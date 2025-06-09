`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11:27:21 06/09/2025
// Design Name:
// Module Name: IDRegister
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
module IDRegister( input wire [63:0] PC_in, [31:0] ins_in, wire clk, reset,
output reg [63:0] PC_out, reg [31:0] ins_out
 );
always @(posedge reset or posedge clk)
begin
if(reset)
begin
ins_out <= 32'b0;
PC_out <= 64'b0;
end
else
begin
PC_out <= PC_in;
ins_out <= ins_in;
end
end
endmodule