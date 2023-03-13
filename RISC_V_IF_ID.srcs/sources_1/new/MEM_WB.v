`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2023 09:20:35 PM
// Design Name: 
// Module Name: MEM_WB
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


module MEM_WB(input [1:0] inWB,
             
             input [2:0] inMEM,
             
             input [31:0] pc_in,
            
             input [2:0] func3_in,
             
             input zero_in,
             
             input [31:0] ALU_in,
             
             input [31:0] reg2_data_in,
             
             input [4:0] rd_in,
             
             input write,
             input clk,
             input res,
                          
             output reg [1:0] outWB,
             output reg RegWrite_MEM,
             
             output reg Branch_MEM,
             output reg MemRead_MEM,
             output reg MemWrite_MEM,
             
             output reg [31:0] pc_out,
             
             output reg [2:0] func3_out,
             
             output reg zero_out,
             
             output reg [31:0] alu_out,
             
             output reg [31:0] reg2_data_out,
             
             output reg [4:0] rd_out
             );

always@(posedge clk) begin
    if(res) begin
        outWB <= 2'b0;
        RegWrite_MEM <= 1'b0;
        Branch_MEM <= 1'b0;
        MemRead_MEM <= 1'b0;
        MemWrite_MEM <= 1'b0;
        pc_out <= 32'b0;
        func3_out <= 3'b0;
        zero_out <= 1'b0;
        alu_out <= 32'b0;
        reg2_data_out <= 32'b0;
        rd_out <= 5'b0;
    end
    
    else begin
        outWB <= inWB;
        RegWrite_MEM <= inWB[0];
        Branch_MEM <= inMEM[2];
        MemRead_MEM <= inMEM[1];
        MemWrite_MEM <= inMEM[0];
        pc_out <= pc_in;
        func3_out <= func3_in;
        zero_out <= zero_in;
        alu_out <= ALU_in;
        reg2_data_out <= reg2_data_in;
        rd_out <= rd_in;
    end
end
    
endmodule