`timescale 10ns/1ps


`include "src/uart_rx.v"

module uart_rx_tb;
    
    localparam UART_BAUD_RATE = 19200;
    localparam UART_DATA_LENGTH = 8;
    localparam CLK_FREQ = 10000000; //10 MHz
    localparam RX_COUNTER_BITWIDTH = 3;
    localparam BAUD_COUNTS_PER_BIT = 521;
    localparam BAUD_RATE_COUNTER_BITWIDTH = 10;

    localparam clk_pulse = 10;
    localparam wait_one_bit = 10*521;
    integer i;
    integer j;

    localparam [UART_DATA_LENGTH-1:0] data = 8'b11001100;
    reg reset_tb = 1'b1;
    reg clk_tb = 1'b0;
    reg rx_tb = 1;
    wire [UART_DATA_LENGTH - 1:0] rx_data_tb;
    reg data_valid_strb;

    uart_rx #(
        .UART_BAUD_RATE(UART_BAUD_RATE),
        .UART_DATA_LENGTH(UART_DATA_LENGTH),
        .CLK_FREQ(CLK_FREQ),
        .RX_COUNTER_BITWIDTH(RX_COUNTER_BITWIDTH),
        .BAUD_COUNTS_PER_BIT(BAUD_COUNTS_PER_BIT),
        .BAUD_RATE_COUNTER_BITWIDTH(BAUD_RATE_COUNTER_BITWIDTH)
    ) dut (
        .clk_i(clk_tb),
        .reset_i(reset_tb),

        .rx_i(rx_tb),

        .data_o(rx_data_tb),
        .data_valid_strb_o(data_valid_strb_tb)
    );

    initial begin
        forever #5 clk_tb = ~clk_tb;    // Toggle clock every time units
    end

    initial begin

        $dumpfile("sim/uart_rx_tb.vcd");
		$dumpvars;


        reset_tb = 1'b1; // reset
        #(10*clk_pulse);
        reset_tb = 0; //release reset
        #(10*clk_pulse);

        for (i = 0; i < 16; i = i + 1) begin
            //start bit
            rx_tb = 0;
            #wait_one_bit;

            for (j = 0; j < 8; j = j+1) begin
                rx_tb = data[j];
                #wait_one_bit;
            end

            // stop bot
            rx_tb = 1;
            #wait_one_bit;
        end

        #(200*clk_pulse);

        $finish;
    end
endmodule