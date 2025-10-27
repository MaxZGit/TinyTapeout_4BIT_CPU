module input_synchronizer #(
    parameter REGISTER_COUNT = 2
)(
    input wire clk_i,
    input wire reset_i,
    input wire input_i,
    output wire output_o
);

    reg [REGISTER_COUNT-1:0] sync_values;
    reg [REGISTER_COUNT-1:0] next_sync_values;

    assign output_o = sync_values[REGISTER_COUNT-1]; // last one is the output

    // Combinational logic for next state
    always @(*) begin
        next_sync_values = sync_values;
        next_sync_values[0] = input_i;
        // shift to next FF
        for (integer i = 1; i < REGISTER_COUNT; i = i + 1) begin
            next_sync_values[i] = sync_values[i-1];
        end
    end

    // Sequential logic (registers)
    always @(posedge clk_i or posedge reset_i) begin
        if (reset_i) begin
            sync_values <= {REGISTER_COUNT{1'b0}};
        end else begin
            sync_values <= next_sync_values;
        end
    end

endmodule