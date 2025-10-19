// half_adder.v
module half_adder (
    //input
    input  wire a_i,
    input  wire b_i,
    //output
    output wire sum_o,
    output wire carry_o
);

    // sum logic
    assign sum_o = a_i ^ b_i;

    // carry logic
    assign carry_o = a_i & b_i;

endmodule
