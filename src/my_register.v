module my_register #(
    parameter REGISTER_WIDTH = 4
)(
    input wire clk_i,
    input wire reset_i,
    input wire write_en_i,
    input wire [REGISTER_WIDTH-1:0] in_i,
    output wire [REGISTER_WIDTH-1:0] out_o
);

    reg [REGISTER_WIDTH-1:0] reg_val;

    always @(posedge clk_i or posedge reset_i) begin
        if (reset_i)
            reg_val <= {REGISTER_WIDTH{1'b0}};
        else if (write_en_i)
            reg_val <= in_i;
    end

    assign out_o = reg_val;
endmodule
