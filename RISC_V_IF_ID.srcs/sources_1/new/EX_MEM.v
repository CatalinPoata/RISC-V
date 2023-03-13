`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2023 09:32:50 PM
// Design Name: 
// Module Name: EX_MEM
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


module EX_MEM(input [1:0] inWB,
             
             input [31:0] data_in,
             
             input [31:0] alu_in,
             
             input [4:0] rd_in,
             
             input write,
             input clk,
             input res,
                          
             output reg RegWrite_WB,
             output reg MemtoReg_WB,
             
             output reg [31:0] data_out,
             
             output reg [31:0] alu_out,
             
             output reg [4:0] rd_out
             );

always@(posedge clk) begin
    if(res) begin
       RegWrite_WB <= 1'b0;
       MemtoReg_WB <= 1'b0;
       data_out <= 32'b0;
       alu_out <= 32'b0;
       rd_out <= 5'b0;
    end
    
    else begin
        RegWrite_WB <= inWB[0];
        MemtoReg_WB <= inWB[1];
        data_out <= data_in;
        alu_out <= alu_in;
        rd_out <= rd_in;
    end
end
    
endmodule
