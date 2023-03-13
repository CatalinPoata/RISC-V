`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/31/2022 11:51:44 PM
// Design Name: 
// Module Name: test_intermediar
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


module test_intermediar();

reg [3:0] ALUOp;
reg [31:0] ina, inb, in1,in2,in3;
reg [1:0] sel;
reg sel23;
reg [7:0] ina23, inb23;
wire zero;
wire [31:0] out,out_mux;
wire [1:0] out_wb;
wire [2:0] out_mem;
wire [2:0] out_ex;

reg [1:0] ALUopC;
reg [6:0] funct7;
reg [2:0] funct3;

wire [3:0] resultALUControl;


ALU alu(ALUOp, ina, inb, zero, out);
mux3_1 mux(in1, in2, in3, sel, out_mux); 
mux2_3 mux23(ina23, inb23, sel23, out_wb, out_mem, out_ex);
ALUcontrol alucontrol(ALUopC, funct7, funct3, resultALUControl);

initial begin
    #0 ALUOp = 4'b1000; ina = 32'd1; inb = 32'd0; 
    #20 $display("ina = %h inb = %h", ina, inb);
    #20 $display("out = %h zero = %d\n", out, zero);
    #20 ALUOp = 4'b1000; ina = 32'd0; inb = 32'd1;
    #20 $display("ina = %h inb = %h", ina, inb);   
    #20 $display("out = %h zero = %d\n", out, zero);
    #20 ALUOp = 4'b1000; ina = -32'd1; inb = -32'd2;
    #20 $display("ina = %h inb = %h", ina, inb);
    #20 $display("out = %h zero = %d\n", out, zero);
    #20 ALUOp = 4'b1000; ina = -32'd2; inb = -32'd1;
    #20 $display("ina = %h inb = %h", ina, inb);
    #20 $display("out = %h zero = %d\n", out, zero);
    #20 ALUOp = 4'b1000; ina = 32'd1; inb = -32'd1;
    #20 $display("ina = %h inb = %h", ina, inb);
    #20 $display("out = %h zero = %d\n", out, zero);
    #20 ALUOp = 4'b1000; ina = -32'd1; inb = 32'd1;
    #20 $display("ina = %h inb = %h", ina, inb);
    #20 $display("out = %h zero = %d\n", out, zero);
    
    #20 in1 = 32'd1; in2 = 32'd2; in3 = 32'd3; sel = 2'b00;
    #20 $display("out_mux = %h\n", out_mux);
    #20 in1 = 32'd1; in2 = 32'd2; in3 = 32'd3; sel = 2'b01;
    #20 $display("out_mux = %h\n", out_mux);
    #20 in1 = 32'd1; in2 = 32'd2; in3 = 32'd3; sel = 2'b10;
    #20 $display("out_mux = %h\n", out_mux);
    
    #20 ina23 = 8'b11110000; inb23 = 8'b00000000; sel23 = 1'b0;
    #20 $display("out_wb = %b, out_mem = %b, out_ex = %b\n", out_wb, out_mem, out_ex);
    
    #20 ALUopC = 2'b11; funct3 = 3'b110; funct7 = 7'b0000000;
    #20 $display("ALU Control result = %b\n", resultALUControl);
end

endmodule
