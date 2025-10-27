`timescale 1ns/1ps

`include "src/input_synchronizer.v"

module input_synchronizer_tb;

    parameter REGISTER_COUNT = 3;

    reg clk_tb;
    reg reset_tb;
    reg input_tb;
    wire output_tb;

    input_synchronizer #(
        .REGISTER_COUNT(REGISTER_COUNT)
    ) dut (
        .clk_i(clk_tb),
        .reset_i(reset_tb),
        .input_i(input_tb),
        .output_o(output_tb)
    );

    initial begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb;
    end

    initial begin

        $dumpfile("sim/input_synchronizer_tb.vcd");
		$dumpvars;

        // Initialize signals
        input_tb = 0;
        reset_tb = 1;

        // Apply reset for a few cycles
        #20;
        reset_tb = 0;

        // Wait a bit, then toggle input
        #20 input_tb = 1;
        #40 input_tb = 0;
        #30 input_tb = 1;
        #25 input_tb = 0;

        #100;
        $finish;
    end
endmodule
