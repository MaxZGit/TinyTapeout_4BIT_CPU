`timescale 10ns/1ps


`include "src/half_adder.v"
`include "src/full_adder.v"
`include "src/carry_ripple_adder.v"
`include "src/alu.v"
`include "src/my_register.v"
`include "src/reg_memory.v"
`include "src/control_unit.v"
`include "src/cpu.v"
`include "src/uart_rx.v"
`include "src/programmer.v"


module cpu_tb;
    
    
    // Instruction constants
    localparam NOP_INSTR = 4'b0000;
    localparam XOR_INSTR = 4'b0001;
    localparam AND_INSTR = 4'b0010;
    localparam OR_INSTR = 4'b0011;
    localparam ADD_INSTR = 4'b0100;
    localparam INC_INSTR = 4'b0101;
    localparam DEC_INSTR = 4'b0110;
    localparam SUB_INSTR = 4'b0111;
    localparam JMP_INSTR = 4'b1000;
    localparam JZ_INSTR = 4'b1001;
    localparam JC_INSTR = 4'b1010;
    localparam LD_INSTR = 4'b1011;
    localparam ST_INSTR = 4'b1100;
    localparam IN_INSTR = 4'b1101;
    localparam OUT_INSTR = 4'b1110;
    localparam LDI_INSTR = 4'b1111;

    localparam OPERATION_CODE_WIDTH = 3;
    localparam CRA_BIT_NUMB = 4;
    localparam REGISTER_WIDTH = 4;
    localparam MEMORY_ADDRESS_WIDTH = 4;
    localparam MEMORY_REGISTERS = 16;

    localparam clk_pulse = 10;
    localparam wait_one_bit = 10*521;
    integer i;
    integer j;

    reg reset_tb = 1'b1;
    reg clk_tb = 1'b1;
    reg [REGISTER_WIDTH - 1:0] in_pins_tb = 4'b0000;
    wire [REGISTER_WIDTH - 1:0] out_pins_tb;

    reg p_programm_tb = 0;
    reg rx_tb = 1;

    reg [63:0] data_array;  // holds 8 bytes (8 × 8 bits)
    reg [7:0] current_byte;

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

        .p_programm_i(p_programm_tb),
        .rx_i(rx_tb)
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

        data_array = {
            OUT_INSTR,
            DEC_INSTR,
            JMP_INSTR,
            4'b0000,
            4'b0000,
            4'b0000,
            4'b0000,
            4'b0000,
            4'b0000,
            4'b0000,
            4'b0000,
            4'b0000,
            4'b0000,
            4'b0000,
            4'b0000,
            4'b0000
        };

        reset_tb = 1'b1; // reset
        #(10*clk_pulse);
        reset_tb = 0; //release reset
        #(10*clk_pulse);

        #(1000*clk_pulse);

        p_programm_tb = 1;
        for (i = 7; i > 0; i = i - 1) begin
            current_byte = data_array[i*8+: 8];
            //start bit
            rx_tb = 0;
            #wait_one_bit;

            for (j = 0; j < 8; j = j+1) begin
                rx_tb = current_byte[j];
                #wait_one_bit;
            end

            // stop bot
            rx_tb = 1;
            #wait_one_bit;
        end
        rx_tb = 1;
        #(5*clk_pulse);
        p_programm_tb = 0;

        #(1000*clk_pulse);

        $finish;
    end
endmodule