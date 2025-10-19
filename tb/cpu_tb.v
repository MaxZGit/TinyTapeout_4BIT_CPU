`timescale 1ns/1ps


`include "src/half_adder.v"
`include "src/full_adder.v"
`include "src/carry_ripple_adder.v"
`include "src/alu.v"
`include "src/my_register.v"
`include "src/reg_memory.v"
`include "src/control_unit.v"
`include "src/cpu.v"

module cpu_tb;
    
    localparam OPERATION_CODE_WIDTH = 3;
    localparam CRA_BIT_NUMB = 4;
    localparam REGISTER_WIDTH = 4;
    localparam MEMORY_ADDRESS_WIDTH = 4;
    localparam MEMORY_REGISTERS = 16;

    integer i;

    reg reset_tb = 1'b1;
    reg clk_tb = 1'b0;
    reg [REGISTER_WIDTH - 1:0] in_pins_tb = 4'b0000;
    wire [REGISTER_WIDTH - 1:0] out_pins_tb;

    reg bl_programm_tb = 0;
    reg [REGISTER_WIDTH - 1:0] bl_data_tb = 4'b0000;
    reg [MEMORY_ADDRESS_WIDTH - 1:0] bl_address_tb = 4'b0000;
    reg bl_write_en_mem_tb = 0;

    cpu #(
        .CRA_BIT_NUMB(CRA_BIT_NUMB),
        .OPERATION_CODE_WIDTH(OPERATION_CODE_WIDTH),
        .REGISTER_WIDTH(REGISTER_WIDTH),
        .MEMORY_ADDRESS_WIDTH(MEMORY_ADDRESS_WIDTH),
        .MEMORY_REGISTERS(MEMORY_REGISTERS)
    ) dut (
        .clk_i(clk_tb),
        .reset_i(reset_tb),

        .in_pins_i(in_pins_tb),
        .out_pins_o(out_pins_tb),

        .bl_programm_i(bl_programm_tb),
        .bl_data_i(bl_data_tb),
        .bl_address_i(bl_address_tb),
        .bl_write_en_mem_i(bl_write_en_mem_tb)
    );

    initial begin
        forever #5 clk_tb = ~clk_tb;    // Toggle clock every 5 time units
    end

    initial begin

        $dumpfile("sim/cpu_tb.vcd");
		$dumpvars;

        for (i = 0; i < MEMORY_REGISTERS; i = i + 1) begin
            $dumpvars(1, dut.memory.reg_vals[i]); // dump each element separately
        end

        reset_tb = 1'b1; // reset
        #45;
        reset_tb = 0; //release reset
        #10;

        #1000;

        $finish;
    end
endmodule