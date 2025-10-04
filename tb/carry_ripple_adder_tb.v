`timescale 1ns/1ps

module carry_ripple_adder_tb;
    
    localparam CRA_BIT_NUMB = 4;

    reg  [CRA_BIT_NUMB-1:0] a_tb;
    reg  [CRA_BIT_NUMB-1:0] b_tb;
    reg  carry_in_tb;
    wire [CRA_BIT_NUMB-1:0] sum_tb;
    wire carry_tb;

    carry_ripple_adder #(
        .CRA_BIT_NUMB(CRA_BIT_NUMB)
    ) dut (
        .a_i(a_tb),
        .b_i(b_tb),
        .carry_i(carry_in_tb),
        .sum_o(sum_tb),
        .carry_o(carry_tb)
    );

    initial begin

		$dumpfile("counter_tb.vcd");
		$dumpvars;
        
        $display("a | b | carry_in | sum | carry");
        $display("---------------------------------------------------");
        // Test vector 1
        a_tb = 4'b0001; b_tb = 4'b0010; carry_in_tb = 1'b0; #10;
        $display("%b | %b |    %b    |  %b  |    %b", a_tb, b_tb, carry_in_tb, sum_tb, carry_tb); #5

        // Test vector 2
        a_tb = 4'b1111; b_tb = 4'b0001; carry_in_tb = 1'b0; #10;
        $display("%b | %b |    %b    |  %b  |    %b", a_tb, b_tb, carry_in_tb, sum_tb, carry_tb); #5

        // Test vector 3
        a_tb = 4'b0101; b_tb = 4'b1010; carry_in_tb = 1'b1; #10;
        $display("%b | %b |    %b    |  %b  |    %b", a_tb, b_tb, carry_in_tb, sum_tb, carry_tb); #5

        // Test vector 4
        a_tb = 4'b1111; b_tb = 4'b1111; carry_in_tb = 1'b1; #10;
        $display("%b | %b |    %b    |  %b  |    %b", a_tb, b_tb, carry_in_tb, sum_tb, carry_tb); #5

        repeat (5) begin
            a_tb = $random;
            b_tb = $random;
            carry_in_tb = $random;
            #10;
            $display("%b | %b |    %b    |  %b  |    %b", a_tb, b_tb, carry_in_tb, sum_tb, carry_tb);
        end
    end
endmodule