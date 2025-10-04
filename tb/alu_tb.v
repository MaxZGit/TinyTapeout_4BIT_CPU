`timescale 1ns/1ps


`include "src/half_adder.v"
`include "src/full_adder.v"
`include "src/carry_ripple_adder.v"
`include "src/alu.v"

module alu_tb;
    
    localparam ALU_BIT_WIDTH = 4;
    localparam OPERATION_CODE_WIDTH = 3;

    reg  [ALU_BIT_WIDTH-1:0] a_tb;
    reg  [ALU_BIT_WIDTH-1:0] b_tb;
    reg  [OPERATION_CODE_WIDTH-1:0] oc_tb;
    wire [ALU_BIT_WIDTH-1:0] result_tb;
    wire carry_tb;

    alu #(
        .ALU_BIT_WIDTH(ALU_BIT_WIDTH),
        .OPERATION_CODE_WIDTH(OPERATION_CODE_WIDTH)
    ) dut (
        .a_i(a_tb),
        .b_i(b_tb),
        .oc_i(oc_tb),

        .result_o(result_tb),
        .carry_o(carry_tb)
    );

    initial begin

        $dumpfile("sim/alu_tb.vcd");
		$dumpvars;

        $display("a | b | oc | result | carry");
        $display("---------------------------------------------------");

        // ADD (MEM)
        a_tb = 4'b0001; b_tb = 4'b0010; oc_tb = 3'b100; #10;
        $display("%b | %b |    %b    |  %b  |    %b", a_tb, b_tb, oc_tb, result_tb, carry_tb); #5;

        // ADD (1) !NOTE ADD (1) will still add a_tb + b_tb, the alu does not differentiate between ADD 1 and ADD a + b
        a_tb = 4'b0001; b_tb = 4'b0010; oc_tb = 3'b101; #10;
        $display("%b | %b |    %b    |  %b  |    %b", a_tb, b_tb, oc_tb, result_tb, carry_tb); #5;

        // SUB (MEM)  
        a_tb = 4'b0001; b_tb = 4'b0010; oc_tb = 3'b111; #10;
        $display("%b | %b |    %b    |  %b  |    %b", a_tb, b_tb, oc_tb, result_tb, carry_tb); #5;

        // SUB (1)  SUB (1) !NOTE SUB (1) will still SUB a_tb - b_tb, the alu does not differentiate between SUB 1 and SUB a - b
        a_tb = 4'b0001; b_tb = 4'b0010; oc_tb = 3'b110; #10;
        $display("%b | %b |    %b    |  %b  |    %b", a_tb, b_tb, oc_tb, result_tb, carry_tb); #5;

        // XOR
        a_tb = 4'b0001; b_tb = 4'b0010; oc_tb = 3'b001; #10;
        $display("%b | %b |    %b    |  %b  |    %b", a_tb, b_tb, oc_tb, result_tb, carry_tb); #5;

        // AND
        a_tb = 4'b0001; b_tb = 4'b0010; oc_tb = 3'b010; #10;
        $display("%b | %b |    %b    |  %b  |    %b", a_tb, b_tb, oc_tb, result_tb, carry_tb); #5;

        // OR
        a_tb = 4'b0001; b_tb = 4'b0010; oc_tb = 3'b011; #10;
        $display("%b | %b |    %b    |  %b  |    %b", a_tb, b_tb, oc_tb, result_tb, carry_tb); #5;

    end
endmodule