`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/01/2023 01:13:24 AM
// Design Name: 
// Module Name: EX
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


module EX(input [31:0] IMM_EX,
          input [31:0] REG_DATA1_EX,
          input [31:0] REG_DATA2_EX,
          input [31:0] PC_EX,
          input [2:0] FUNCT3_EX,
          input [6:0] FUNCT7_EX,
          input [4:0] RD_EX,
          input [4:0] RS1_EX,
          input [4:0] RS2_EX,
          input RegWrite_EX,
          input MemtoReg_EX,
          input MemRead_EX,
          input MemWrite_EX,
          input [1:0]ALUop_EX,
          input ALUSrc_EX,
          input Branch_EX,
          input [1:0] forwardA,forwardB,
          
          input [31:0] ALU_DATA_WB,
          input [31:0] ALU_OUT_MEM,
          
          output ZERO_EX,
          output [31:0] ALU_OUT_EX,
          output [31:0] PC_Branch_EX,
          output [31:0] REG_DATA2_EX_FINAL
          );
          
          wire [31:0] ALU_Source1,ALU_Source2;
          wire [31:0] MUX_B_temp;
          wire [3:0] ALU_Control;
          
          always@(*) begin
            //$display("RS1_EX = %b", RS1_EX);
            //$display("FUNCT3_EX = %b\nFUNCT7_EX = %b", FUNCT3_EX, FUNCT7_EX);
            
          end
          
          adder ADDER_IMM_PC_EX(IMM_EX, PC_EX, PC_Branch_EX);
          
          mux3_1 MUX_REG_DATA_1(REG_DATA1_EX, ALU_DATA_WB, ALU_OUT_MEM, forwardA, ALU_Source1);
          mux3_1 MUX_REG_DATA_2(REG_DATA2_EX, ALU_DATA_WB, ALU_OUT_MEM, forwardB, MUX_B_temp);
          
          mux2_1 MUX_ALU_SOURCE_2(MUX_B_temp, IMM_EX, ALUSrc_EX, ALU_Source2);
          
          ALUcontrol alu_control(ALUop_EX, FUNCT7_EX, FUNCT3_EX, ALU_Control);
          
          ALU alu(ALU_Control, ALU_Source1, ALU_Source2, ZERO_EX, ALU_OUT_EX);
          
          assign REG_DATA2_EX_FINAL = MUX_B_temp;
          
          
endmodule
