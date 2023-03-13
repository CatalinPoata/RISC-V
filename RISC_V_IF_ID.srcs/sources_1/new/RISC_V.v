`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/05/2023 09:43:10 PM
// Design Name: 
// Module Name: RISC_V
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


module RISC_V(input clk,
              input reset,
              output [31:0] PC_EX,
              output [31:0] ALU_OUT_EX,
              output [31:0] PC_MEM,
              output PCSrc,
              output [31:0] DATA_MEMORY_MEM,
              output [31:0] ALU_DATA_WB,
              output [1:0] forwardA, forwardB,
              output pipeline_stall
              );
              
 
 // Instruction Fetch (IF)
 wire [31:0] PC_IF;
 wire [31:0] Instruction_IF;
 wire PC_write;
 
 IF instruction_fetch(clk, reset, 
PCSrc, PC_write,
 PC_MEM,
                      PC_IF, Instruction_IF);
 
 // Register IF/ID
 wire IF_ID_write;
 wire [31:0] PC_ID;
 wire [31:0] Instruction_ID;
 
 IF_ID_reg IF_ID_REGISTER(clk, reset, IF_ID_write, PC_IF, Instruction_IF,
                          PC_ID, Instruction_ID);
 
 
 // Instruction Decode (ID)
 wire RegWrite_WB;
 wire [4:0] RD_WB;
 wire [31:0] IMM_ID;
 wire [31:0] REG_DATA1_ID;
 wire [31:0] REG_DATA2_ID;
 wire RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID;
 wire [1:0] ALUop_ID;
 wire ALUSrc_ID;
 wire Branch_ID;
 wire [2:0] FUNCT3_ID;
 wire [6:0] FUNCT7_ID;
 wire [6:0] OPCODE;
 wire [4:0] RD_ID;
 wire [4:0] RS1_ID;
 wire [4:0] RS2_ID;
 
 ID instruction_decode(clk, PC_ID, Instruction_ID, RegWrite_WB, ALU_DATA_WB, RD_WB,
                       IMM_ID, REG_DATA1_ID, REG_DATA2_ID, RegWrite_ID, MemtoReg_ID, MemRead_ID, MemWrite_ID, ALUop_ID, ALUSrc_ID, Branch_ID, FUNCT3_ID, FUNCT7_ID, OPCODE, RD_ID, RS1_ID, RS2_ID);
 
 
 // Hazard Detection Unit
 wire MemRead_EX;
 
 hazard_detection h_d(RD_ID, RS1_ID, RS2_ID, MemRead_EX,
                      PC_write, IF_ID_write, pipeline_stall);
 
 
 // 2:3 MUX
 wire [1:0] outWB_ID;
 wire [2:0] outMEM_ID;
 wire [2:0] outEX_ID;
 
 mux2_3 MUX_23({ALUSrc_ID,MemtoReg_ID,RegWrite_ID,MemRead_ID,MemWrite_ID,Branch_ID,ALUop_ID}, 8'b00000000, pipeline_stall,
               outWB_ID, outMEM_ID, outEX_ID);
 
 
 // Register ID/EX
 wire [1:0] outWB_EX;
 wire [2:0] outMEM_EX;
 wire [1:0] ALUop_EX;
 wire ALUSrc;
 wire [2:0] func3_EX;
 wire [6:0] func7_EX;
 wire [31:0] REG_DATA1_EX;
 wire [31:0] REG_DATA2_EX;
 wire [4:0] RS1_EX;
 wire [4:0] RS2_EX;
 wire [4:0] RD_EX;
 wire [31:0] IMM_EX;
 
 ID_EX ID_EX_REGISTER(outWB_ID, outMEM_ID, outEX_ID, PC_ID, FUNCT3_ID, FUNCT7_ID, REG_DATA1_ID, REG_DATA2_ID, RS1_ID, RS2_ID, RD_ID, 1'b1, clk, reset, IMM_ID,
                      outWB_EX, outMEM_EX, MemRead_EX, ALUop_EX, ALUSrc, PC_EX, func3_EX, func7_EX, REG_DATA1_EX, REG_DATA2_EX, RS1_EX, RS2_EX, RD_EX, IMM_EX);
 
 // Execute (EX)
 wire RegWrite_EX;
 wire MemtoReg_EX;
 wire MemWrite_EX;
 wire Branch_EX;
 wire [31:0] ALU_OUT_MEM;
 wire ZERO_EX;
 wire [31:0]PC_Branch_EX;
 wire [31:0] REG_DATA2_EX_FINAL;
 
 assign RegWrite_EX = outWB_EX[0];
 assign MemtoReg_EX = outWB_EX[1];
 assign MemRead_EX = outMEM_EX[1];
 assign MemWrite_EX = outMEM_EX[0];
 assign Branch_EX = outMEM_EX[2];
  
 
 EX execute(IMM_EX, REG_DATA1_EX, REG_DATA2_EX, PC_EX, func3_EX, func7_EX, RD_EX, RS1_EX, RS2_EX, RegWRite_EX, MemtoReg_EX, MemRead_EX, MemWrite_EX, ALUop_EX, ALUSrc, Branch_EX, forwardA, forwardB, ALU_DATA_WB, ALU_OUT_MEM,
            ZERO_EX, ALU_OUT_EX, PC_Branch_EX, REG_DATA2_EX_FINAL);
 
 
 // Forwarding Unit
 wire [4:0] RD_MEM;
 wire [4:0] RD_WB;
 wire RegWrite_MEM;
 wire RegWrite_WB;
 forwarding forwarding_unit(RS1_EX, RS2_EX, RD_MEM, RD_WB, RegWrite_WB, RegWrite_MEM,
                            forwardA, forwardB);
            
 
 // Register MEM/WB
 wire [1:0] outWB_MEM;
 wire Branch_MEM;
 wire Branch_MEM;
 wire MemRead_MEM;
 wire MemWrite_MEM;
 wire [2:0] func3_MEM;
 wire zero_MEM;
 wire [31:0] REG_DATA2_MEM;
 
 MEM_WB MEM_WB_REGISTER(outWB_EX, outMEM_EX, PC_Branch_EX, func3_EX, ZERO_EX, ALU_OUT_EX, REG_DATA2_EX_FINAL, RD_EX, 1'b1, clk, reset,
                        outWB_MEM, RegWrite_MEM, Branch_MEM, MemRead_MEM, MemWrite_MEM, PC_MEM, func3_MEM, zero_MEM, ALU_OUT_MEM, REG_DATA2_MEM, RD_MEM);
 
 data_memory DATA_MEMORY(clk, MemRead_MEM, MemWrite_MEM, ALU_OUT_MEM, REG_DATA2_MEM, DATA_MEMORY_MEM);
 
 branch_control BRANCH_CONTROL(zero_MEM, ALU_OUT_MEM[0], Branch_MEM, func3_MEM,
                               PCSrc);
 
 wire MemtoReg_WB;
 wire [31:0] DATA_MEMORY_WB;
 wire [31:0] ALU_OUT_WB;
 
 EX_MEM EX_MEM_REGISTER(outWB_MEM, DATA_MEMORY_MEM, ALU_OUT_MEM, RD_MEM, 1'b1, clk, reset, 
                        RegWrite_WB, MemtoReg_WB, DATA_MEMORY_WB, ALU_OUT_WB, RD_WB);
                        
 mux2_1 MUX_WB(ALU_OUT_WB, DATA_MEMORY_WB, MemtoReg_WB, ALU_DATA_WB);                                                           
 
 
endmodule