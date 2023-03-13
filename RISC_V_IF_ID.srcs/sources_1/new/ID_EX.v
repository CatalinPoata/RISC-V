`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2023 07:50:51 PM
// Design Name: 
// Module Name: ID_EX
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


module ID_EX(input [1:0] inWB,
             
             input [2:0] inMEM,
             
             input [2:0] inEX,
             
             input [31:0] PC_in,
            
             input [2:0] func3_in,
             input [6:0] func7_in,
             
             input [31:0] ALU_A_in,
             input [31:0] ALU_B_in,
             
             input [4:0] RS1_in,
             input [4:0] RS2_in,
             input [4:0] RD_in,
             
             input write,
             input clk,
             input res,
             
             input [31:0] IMM_in,
             
             output reg [1:0] outWB,
             
             output reg [2:0] outMEM,
             output reg MemRead_EX,
             
             output reg [1:0] ALUop_EX,
             output reg ALUSrc,
             
             output reg [31:0] PC_out,
             
             output reg [2:0] func3_out,
             output reg [6:0] func7_out,
             
             output reg [31:0] ALU_A_out,
             output reg [31:0] ALU_B_out,
             
             output reg [4:0] RS1_out,
             output reg [4:0] RS2_out,
             output reg [4:0] RD_out,
             
             output reg [31:0] IMM_out
             );

always@(posedge clk) begin
    if(res) begin
        outWB <= 2'b0;
        outMEM <= 3'b0;
        MemRead_EX <= 1'b0;
        ALUop_EX <= 2'b0;
        ALUSrc <= 1'b0;
        PC_out <= 32'b0;
        func3_out <= 3'b0;
        func7_out <= 7'b0;
        ALU_A_out <= 32'b0;
        ALU_B_out <= 32'b0;
        RS1_out <= 5'b0;
        RS2_out <= 5'b0;
        RD_out <= 5'b0;
        IMM_out <= 32'b0;
    end
    
    else begin
        outWB <= inWB;
        outMEM <= inMEM;
        MemRead_EX <= inMEM[1];
        ALUop_EX <= inEX[2:1];
        ALUSrc <= inEX[0];
        PC_out <= PC_in;
        func3_out <= func3_in;
        func7_out <= func7_in;
        ALU_A_out <= ALU_A_in;
        ALU_B_out <= ALU_B_in;
        RS1_out <= RS1_in;
        RS2_out <= RS2_in;
        RD_out <= RD_in;
        IMM_out <= IMM_in;
        
         //$display("func3_in = %b\nfunc7_in = %b\nfunc3_out = %b\nfunc7_out = %b\n", func3_in, func7_in, func3_out, func7_out);
    end
end
    
endmodule
