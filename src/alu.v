module alu #(
    parameter ALU_BIT_WIDTH = 4,
    parameter OPERATION_CODE_WIDTH = 3
) (
    input wire [ALU_BIT_WIDTH-1:0] a_i,
    input wire [ALU_BIT_WIDTH-1:0] b_i,
    input wire [OPERATION_CODE_WIDTH-1:0] oc_i,

    output reg [ALU_BIT_WIDTH-1:0] result_o,
    output wire carry_o
);

    // ITNERNAL SIGNALS
    wire [ALU_BIT_WIDTH-1:0] sum, xor_result, and_result, or_result, b_add_sub;
    wire add_sub;

    assign add_sub = oc_i[1]; // middle bit of operation code indicates if subtraction or addition is done (0...addition, 1...substraction) 
    assign b_add_sub = (add_sub == 1'b0)?b_i : ~b_i; //in the case of substraction, invert b

    // CALCULATIONS
    assign xor_result = a_i ^ b_i;
    assign and_result = a_i & b_i;
    assign or_result = a_i | b_i;

    // OPERATION CODE MUS
    always @(sum, xor_result, and_result, or_result, oc_i) begin
        // standard assignment
        result_o = {ALU_BIT_WIDTH{1'b0}};

        if (oc_i[2] == 1'b1) begin
            // Add or Substract
            result_o = sum;
        end else begin
            // Choose operation based on lower bits
            case (oc_i[1:0])
                2'b01: result_o = xor_result; // XOR
                2'b10: result_o = and_result; // AND
                2'b11: result_o = or_result; // OR
                default: result_o = {ALU_BIT_WIDTH{1'b0}}; // optional
            endcase
        end
    end

    // CARRY RIPPLE ADDER
    carry_ripple_adder #(
        .CRA_BIT_NUMB(ALU_BIT_WIDTH)
    ) cra (
        .a_i(a_i),
        .b_i(b_add_sub),
        .carry_i(add_sub),
        .sum_o(sum),
        .carry_o(carry_o)
    );
endmodule