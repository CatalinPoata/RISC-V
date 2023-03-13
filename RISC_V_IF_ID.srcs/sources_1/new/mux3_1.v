`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2023 08:38:01 PM
// Design Name: 
// Module Name: mux_3_1
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux3_1(input [31:0] ina,inb,inc,
               input [1:0] sel,
               output [31:0] out);
               
    assign out = (sel == 2'b00) ? ina : ((sel == 2'b01) ? inb : inc);
endmodule
