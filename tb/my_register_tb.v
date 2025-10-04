`timescale 1ns/1ps


`include "src/my_register.v"

module my_register_tb;
    
    localparam REGISTER_WIDTH = 4;
    
    reg reset_tb = 1'b1;
    reg clk_tb = 1'b0; 
    reg write_en_tb = 1'b0;
    reg [REGISTER_WIDTH - 1:0] in_tb = 4'b0000;
    wire [REGISTER_WIDTH - 1:0] out_tb;

    my_register #(
        .REGISTER_WIDTH(REGISTER_WIDTH)
    ) dut (
        .clk_i(clk_tb),
        .reset_i(reset_tb),

        .write_en_i(write_en_tb),
        .in_i(in_tb),
        .out_o(out_tb)
    );

    initial begin
        forever #5 clk_tb = ~clk_tb;    // Toggle clock every 5 time units
    end

    initial begin

        $dumpfile("sim/my_register_tb.vcd");
		$dumpvars;

        reset_tb = 1'b1; // reset
        #45;
        reset_tb = 0; //release reset
        #10;
        write_en_tb = 1'b1;
        in_tb = 4'b1010;
        #10;

        write_en_tb = 1'b0;
        #10;

        write_en_tb = 1'b1;
        in_tb = 4'b1110;
        #10;

        write_en_tb = 1'b0;
        in_tb = 4'b1111;
        #10;

        write_en_tb = 1'b1;
        #10;

        write_en_tb = 1'b0;
        #10;

        $finish;
    end
endmodule