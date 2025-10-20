
module tt_um_four_bit_cpu_top_level(
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    localparam OPERATION_CODE_WIDTH = 3;
    localparam CRA_BIT_NUMB = 4;
    localparam REGISTER_WIDTH = 4;
    localparam MEMORY_ADDRESS_WIDTH = 4;
    localparam MEMORY_REGISTERS = 16;

    assign uo_out[7:4] = 4'b0000;
    assign uio_oe[7:0] = 8'b00000000;
    assign uio_out[7:0] = 8'b00000000;
    
    cpu #(
        .CRA_BIT_NUMB(CRA_BIT_NUMB),
        .OPERATION_CODE_WIDTH(OPERATION_CODE_WIDTH),
        .REGISTER_WIDTH(REGISTER_WIDTH),
        .MEMORY_ADDRESS_WIDTH(MEMORY_ADDRESS_WIDTH),
        .MEMORY_REGISTERS(MEMORY_REGISTERS)
    ) dut (
        .clk_i(clk),
        .reset_i(~rst_n),

        .in_pins_i(ui_in[3:0]),
        .out_pins_o(uo_out[3:0]),

        .p_programm_i(ui_in[2]),
        .rx_i(ui_in[3])
    );
endmodule