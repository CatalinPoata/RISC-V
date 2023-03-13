`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2023 08:04:24 PM
// Design Name: 
// Module Name: mux2_3
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


module mux2_3(input [7:0] ina,inb,
              input sel,
              output [1:0] outWB,
              output [2:0] outMEM,
              output [2:0] outEX);
    
    //outWB = MemToReg | RegWrite
    //outMEM = Branch | MemRead | MemWrite
    //outEX = ALUop | ALUSrc
    assign {outWB, outMEM, outEX} = (sel == 0) ? {ina[6], ina[5], ina[2], ina[4], ina[3], ina[1:0], ina[7]} : inb;
endmodule
