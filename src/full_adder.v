module full_adder(
    // inputs
    input wire a_i,
    input wire b_i,
    input wire carry_i,
    // outputs

    output wire sum_o,
    output wire carry_o
);

    // internal signals
    wire sum_ab;
    wire carry_ha_0;
    wire carry_ha_1;

    // first half_adder
    half_adder ha0 (
        .a_i(a_i),
        .b_i(b_i),
        .sum_o(sum_ab),
        .carry_o(carry_ha_0)
    );

    // second half_adder
    half_adder ha1 (
        .a_i(sum_ab),
        .b_i(carry_i),
        .sum_o(sum_o),
        .carry_o(carry_ha_1)
    );

    // Carry-Out kombinieren
    assign carry_o = carry_ha_0 | carry_ha_1;

endmodule