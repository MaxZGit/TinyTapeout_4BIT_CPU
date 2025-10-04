`timescale 1ns/1ps


`include "src/reg_memory.v"

module reg_memory_tb;
    
    localparam MEMORY_REGISTERS = 16;
    localparam REGISTER_WIDTH = 4;
    localparam MEMORY_ADDRESS_WIDTH = 4;
    
    integer i;

    reg reset_tb = 1'b1;
    reg clk_tb = 1'b0; 
    reg write_en_tb = 1'b0;
    reg read_en_tb = 1'b0;
    reg [MEMORY_ADDRESS_WIDTH - 1:0] addr_tb = 4'b0000;
    reg [REGISTER_WIDTH - 1:0] data_in_tb;
    wire [REGISTER_WIDTH - 1:0] data_out_tb;

    reg_memory #(
        .MEMORY_REGISTERS(MEMORY_REGISTERS),
        .REGISTER_WIDTH(REGISTER_WIDTH),
        .MEMORY_ADDRESS_WIDTH(MEMORY_ADDRESS_WIDTH)
    ) dut (
        .clk_i(clk_tb),
        .reset_i(reset_tb),
        .write_en_i(write_en_tb),
        .read_en_i(read_en_tb),
        .addr_i(addr_tb),
        .data_i(data_in_tb),
        .data_o(data_out_tb)
    );

    initial begin
        forever #5 clk_tb = ~clk_tb;    // Toggle clock every 5 time units
    end

    initial begin

        $dumpfile("sim/reg_memory_tb.vcd");
		$dumpvars;

        for (i = 0; i < MEMORY_REGISTERS; i = i + 1) begin
            $dumpvars(1, dut.reg_vals[i]); // dump each element separately
        end

        reset_tb = 1'b1; // reset
        #45;
        reset_tb = 0; //release reset
        #10;

        
        // Write to all registers
        for (i = 0; i < MEMORY_REGISTERS; i = i + 1) begin
            data_in_tb = i;
            addr_tb = i;
            write_en_tb = 1'b1;
            #10;
            write_en_tb = 1'b0;
            #10;
        end

        #50;

        // Read from all registers
        for (i = 0; i < MEMORY_REGISTERS; i = i + 1) begin
            addr_tb = i;
            read_en_tb = 1'b1;
            #10;
            read_en_tb = 1'b0;
            #10;
        end

        $finish;
    end
endmodule