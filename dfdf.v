`timescale 1ns / 1ps
////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11:23:50 06/09/2025
// Design Name: RISC_V_Processor
// Module Name: /home/ise/verilog codes/project/dfdf.v
// Project Name: project
// Target Device:
// Tool versions:
// Description:
//
// Verilog Test Fixture created by ISE for module: RISC_V_Processor
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
////////////////////////////////////////////////////////////////////////////////
// Add stimulus here
module dfdf;
// Inputs
 reg clk;
 reg reset;

 // Outputs
 wire [63:0] debug_pc;
 wire [31:0] debug_instruction;
 wire [63:0] debug_alu_result;
 // Instantiate the RISC-V Processor
 RISC_V_Processor uut (
 .clk(clk),
 .reset(reset),
 .debug_pc(debug_pc),
 .debug_instruction(debug_instruction),
 .debug_alu_result(debug_alu_result)
 );
 // Clock generation
 initial begin
 clk = 0;
 forever #5 clk = ~clk; // 10ns clock
 end
 // Reset sequence
 initial begin
 reset = 1;
 #15 reset = 0;
 end
 // Simulation duration
 initial begin
 #1000; // run for 1000ns
 $finish;
 end
 // Optional: Dump VCD/Value Change Dump file for waveform viewing
 initial begin
 $dumpfile("riscv_waveform.vcd");
 $dumpvars(0, dfdf);
 end
// Monitor debug and key output
 initial begin
 $display("Time\tPC\t\tInstruction\t\tALU_Result");
 $monitor("%0t\t%h\t%h\t%h", $time, debug_pc, debug_instruction, debug_alu_result);
 end
endmodule