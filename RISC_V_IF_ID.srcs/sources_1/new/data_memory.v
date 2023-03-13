`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/04/2023 09:13:41 PM
// Design Name: 
// Module Name: data_memory
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


module data_memory(input clk,
                   input mem_read,
                   input mem_write,
                   input [31:0] address,
                   input [31:0] write_data,
                   output reg [31:0] read_data
                   );
                   
    reg [31:0] memory [0:1023];
    integer i;
    
    initial begin
        for(i = 0; i < 1024; i = i + 1)
            memory[i] = 32'b0;
    end
    
    always@(*) begin
        if(mem_read)
            read_data = memory[address >> 2];
    end
    
    always@(posedge clk) begin
        if(mem_write)
            memory[address >> 2] = write_data;
    end
                   
endmodule
