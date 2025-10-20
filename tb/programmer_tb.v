`timescale 10ns/1ps


`include "src/programmer.v"

module programmer_tb;
    
    localparam UART_DATA_LENGTH = 8;
    localparam REGISTER_WIDTH = 4;
    localparam MEMORY_ADDRESS_WIDTH = 4;

    localparam clk_pulse = 10;
    integer i;

    reg reset_tb = 1'b1;
    reg clk_tb = 1'b1;

    reg active_tb = 0;
    reg [UART_DATA_LENGTH-1:0] data_tb = 8'b00000000;
    reg data_valid_strb_tb = 0;

    wire [REGISTER_WIDTH-1:0] mem_data_tb;
    wire [MEMORY_ADDRESS_WIDTH-1:0] mem_addr_tb;
    wire mem_enable_write_tb;
 

    programmer #(
        .UART_DATA_LENGTH(UART_DATA_LENGTH),
        .REGISTER_WIDTH(REGISTER_WIDTH),
        .MEMORY_ADDRESS_WIDTH(MEMORY_ADDRESS_WIDTH)
    ) dut (
        .clk_i(clk_tb),
        .reset_i(reset_tb),
        
        .active_i(active_tb),
        .uart_data_i(data_tb),
        .data_valid_strb_i(data_valid_strb_tb),

        .data_o(mem_data_tb),
        .addr_o(mem_addr_tb),
        .enable_write_memory_o(mem_enable_write_tb)
    );

    initial begin
        forever #5 clk_tb = ~clk_tb;    // Toggle clock every time units
    end

    initial begin

        $dumpfile("sim/programmer_tb.vcd");
		$dumpvars;


        reset_tb = 1'b1; // reset
        #(10*clk_pulse);
        reset_tb = 0; //release reset
        #(10*clk_pulse);
        active_tb = 1;
        data_tb = 8'b11010010;
        #(5*clk_pulse);

        for (i = 0; i < 12; i = i + 1) begin
            data_valid_strb_tb = 1;
            #clk_pulse;
            data_valid_strb_tb = 0;
            #(20*clk_pulse);
        end

        #(200*clk_pulse);

        $finish;
    end
endmodule