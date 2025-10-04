`timescale 1ns/1ps

module full_adder_tb;
    reg a_tb;
    reg b_tb;
    reg carry_in_tb;
    wire sum_tb;
    wire carry_out_tb;

    full_adder dut(
        .a_i(a_tb),
        .b_i(b_tb),
        .carry_i(carry_in_tb),
        .sum_o(sum_tb),
        .carry_o(carry_out_tb)
    );

    initial begin
        // Stimuli
        // without carry_in
        carry_in_tb = 0;
        a_tb = 0; b_tb = 0; #10; 
        a_tb = 0; b_tb = 1; #10;
        a_tb = 1; b_tb = 0; #10;
        a_tb = 1; b_tb = 1; #10;

        #10;

        // with carry_in
        carry_in_tb = 1;
        a_tb = 0; b_tb = 0; #10; 
        a_tb = 0; b_tb = 1; #10;
        a_tb = 1; b_tb = 0; #10;
        a_tb = 1; b_tb = 1; #10;
    end
endmodule