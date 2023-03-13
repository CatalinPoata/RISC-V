`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2022 10:07:21 PM
// Design Name: 
// Module Name: ALUcontrol
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


module ALUcontrol(input [1:0] ALUop,
                  input [6:0] funct7,
                  input [2:0] funct3,
                  output reg [3:0] ALUinput);
    
    always @(ALUop, funct7, funct3)
    begin
        //$display("ALUop este %b\nfunct7 este %b\nfunct3 este %b", ALUop, funct7, funct3);
        //$display("combinatia este: %b", {ALUop, funct7, funct3});
        casex({ALUop, funct7, funct3})
            12'b00_xxxxxxx_xxx : ALUinput = 4'b0010; //ld, sd, lw, sw
            12'b01_xxxxxxx_000 : ALUinput = 4'b0110; //beq
            12'b01_xxxxxxx_001 : ALUinput = 4'b0110; //bne
            12'b01_xxxxxxx_100 : ALUinput = 4'b1000; //blt
            12'b01_xxxxxxx_101 : ALUinput = 4'b1000; //bge
            12'b01_xxxxxxx_110 : ALUinput = 4'b0111; //bltu
            12'b01_xxxxxxx_111 : ALUinput = 4'b0111; //bgeu
            12'b10_0000000_000 : ALUinput = 4'b0010; //add
            12'b11_xxxxxxx_000 : ALUinput = 4'b0010; //addi, subi
            12'b10_0100000_000 : ALUinput = 4'b0110; //sub
            12'b10_0000000_111 : ALUinput = 4'b0000; //and
            12'b11_xxxxxxx_111 : ALUinput = 4'b0000; //andi
            12'b10_0000000_110 : ALUinput = 4'b0001; //or
            12'b11_xxxxxxx_110 : ALUinput = 4'b0001; //ori
            12'b10_0000000_100 : ALUinput = 4'b0011; //xor
            12'b11_xxxxxxx_100 : ALUinput = 4'b0011; //xori
            12'b10_0000000_101 : ALUinput = 4'b0101; //srl
            12'b11_0000000_101 : ALUinput = 4'b0101; //srli
            12'b10_0000000_001 : ALUinput = 4'b0100; //sll
            12'b11_0000000_001 : ALUinput = 4'b0100; //slli
            12'b10_0100000_101 : ALUinput = 4'b1001; //sra
            12'b11_0100000_101 : ALUinput = 4'b1001; //srai
            12'b10_0000000_011 : ALUinput = 4'b0111; //sltu
            12'b10_0000000_010 : ALUinput = 4'b1000; //slt
        endcase
    end
endmodule
