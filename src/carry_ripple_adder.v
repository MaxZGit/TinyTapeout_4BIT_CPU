module carry_ripple_adder #(
    parameter CRA_BIT_NUMB = 4
) (
    input  wire [CRA_BIT_NUMB-1:0] a_i,
    input  wire [CRA_BIT_NUMB-1:0] b_i,
    input  wire carry_i,

    output wire [CRA_BIT_NUMB-1:0] sum_o,
    output wire carry_o
);

    // internal signals
    wire [CRA_BIT_NUMB: 0] carry; // carry[0] ... carry_in | carry[1] to carry[CRA_BIT_NUMB] ... carry from first to last Full-Adder (CRA_BIT_NUMB)
    assign carry[0] = carry_i; 
    assign carry_o = carry[CRA_BIT_NUMB];

    genvar i;
    generate
        for (i = 0; i < CRA_BIT_NUMB; i = i + 1) begin : adder_stage
            full_adder fa(
                .a_i(a_i[i]),
                .b_i(b_i[i]),
                .carry_i(carry[i]),
                .sum_o(sum_o[i]),
                .carry_o(carry[i + 1])
            );
        end
    endgenerate
endmodule