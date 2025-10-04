`timescale 1ns/1ps

module half_adder_tb;
    reg a_tb;
    reg b_tb;
    wire sum_tb;
    wire carry_tb;

    // DUT instanzieren
    half_adder dut (
        .a_i(a_tb),
        .b_i(b_tb),
        .sum_o(sum_tb),
        .carry_o(carry_tb)
    );

    initial begin
        // Stimuli
        a_tb = 0; b_tb = 0; #10; //#10 -> wait for 10 units
        a_tb = 0; b_tb = 1; #10;
        a_tb = 1; b_tb = 0; #10;
        a_tb = 1; b_tb = 1; #10;
    end
endmodule
