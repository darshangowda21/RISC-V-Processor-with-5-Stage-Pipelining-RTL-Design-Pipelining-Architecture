`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11:10:11 06/09/2025
// Design Name:
// Module Name: Data_Memory
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
module Data_Memory(
 input wire [63:0] Mem_Addr,
 input wire [63:0] Write_Data,
 input wire clk,
 input wire MemWrite,
 input wire MemRead,
 input wire [1:0] wordSize,
 output reg [63:0] Read_Data
);
reg [7:0] dataMem [63:0];
integer i;
initial begin
 for (i = 0; i < 64; i = i + 1)
 dataMem[i] = 8'b0;
 // Initializing some values for testing
 dataMem[54] = 8'd11;
 dataMem[55] = 8'd12;
 dataMem[56] = 8'd13;
 dataMem[57] = 8'd14;
end
// Write Logic
always @(posedge clk) begin
 if (MemWrite) begin
 case (wordSize)
 2'b11: begin // 64-bit
dataMem[Mem_Addr[5:0]+7] <= Write_Data[7:0];
 dataMem[Mem_Addr[5:0]+6] <= Write_Data[15:8];
 dataMem[Mem_Addr[5:0]+5] <= Write_Data[23:16];
 dataMem[Mem_Addr[5:0]+4] <= Write_Data[31:24];
 dataMem[Mem_Addr[5:0]+3] <= Write_Data[39:32];
 dataMem[Mem_Addr[5:0]+2] <= Write_Data[47:40];
 dataMem[Mem_Addr[5:0]+1] <= Write_Data[55:48];
 dataMem[Mem_Addr[5:0]+0] <= Write_Data[63:56];
 end
 2'b10: begin // 16-bit
 dataMem[Mem_Addr[5:0]+1] <= Write_Data[7:0];
 dataMem[Mem_Addr[5:0]+0] <= Write_Data[15:8];
 end
 2'b01: begin // 32-bit
 dataMem[Mem_Addr[5:0]+3] <= Write_Data[7:0];
 dataMem[Mem_Addr[5:0]+2] <= Write_Data[15:8];
 dataMem[Mem_Addr[5:0]+1] <= Write_Data[23:16];
 dataMem[Mem_Addr[5:0]+0] <= Write_Data[31:24];
 end
2'b00: begin // 8-bit
 dataMem[Mem_Addr[5:0]] <= Write_Data[7:0];
 end
 endcase
 end
end
// Read Logic
always @(*) begin
 if (MemRead) begin
 case (wordSize)
 2'b11: begin // 64-bit
 Read_Data <= {
 dataMem[Mem_Addr[5:0]+0],
 dataMem[Mem_Addr[5:0]+1],
 dataMem[Mem_Addr[5:0]+2],
 dataMem[Mem_Addr[5:0]+3],
 dataMem[Mem_Addr[5:0]+4],
 dataMem[Mem_Addr[5:0]+5],
 dataMem[Mem_Addr[5:0]+6],
 dataMem[Mem_Addr[5:0]+7]
 };
end
 2'b10: begin // 16-bit
 Read_Data[15:0] <= {
 dataMem[Mem_Addr[5:0]+0],
 dataMem[Mem_Addr[5:0]+1]
 };
 Read_Data[63:16] <= {48{dataMem[Mem_Addr[5:0]+1][7]}}; // Sign extension
 end
 2'b01: begin // 32-bit
Read_Data[31:0] <= {
 dataMem[Mem_Addr[5:0]+0],
 dataMem[Mem_Addr[5:0]+1],
 dataMem[Mem_Addr[5:0]+2],
 dataMem[Mem_Addr[5:0]+3]
 };
Read_Data[63:32] <= {32{dataMem[Mem_Addr[5:0]+3][7]}}; // Sign extension
 end
 2'b00: begin // 8-bit
 Read_Data[7:0] <= dataMem[Mem_Addr[5:0]];
 Read_Data[63:8] <= {56{dataMem[Mem_Addr[5:0]][7]}}; // Sign extension
 end
 endcase
 end else begin
 Read_Data <= 64'b0;
 end
end
endmodule