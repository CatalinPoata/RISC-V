`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2022 11:06:53 PM
// Design Name: 
// Module Name: ALU
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


module ALU(input [3:0] ALUop,
           input [31:0] ina,inb,
           output zero,
           output reg [31:0] out);
    always@(*) begin
        case(ALUop)
            4'b0000 : out <= ina & inb; //and
            4'b0001 : out <= ina | inb; //or
            4'b0010 : out <= ina + inb; //add, ld, sd
            4'b0011 : out <= ina ^ inb; //xor
            4'b0100 : out <= ina << inb[4:0]; //sll
            4'b0101 : out <= ina >> inb[4:0]; //srl
            4'b0110 : out <= ina - inb; //sub, bne, beq
            4'b0111 : out <= (ina < inb) ? 32'b1 : 32'b0; //sltu, bgeu, bltu
            4'b1000 : begin
                        if(ina[31] == inb[31]) begin
                            out <= (ina[30:0] < inb[30:0]) ? 32'b1 : 32'b0;
                        end
                        else begin
                            out <= (ina[31] == 1'b0) ? 32'b0 : 32'b1;
                        end  
                      end
            4'b1001 : out <= ina >>> inb[4:0];
            default: out <= 32'b0;
        endcase
    end
    
    assign zero = (out == 32'b0) ? 1 : 0;
endmodule
