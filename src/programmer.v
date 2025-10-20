module programmer #(
    parameter UART_DATA_LENGTH = 8,
    parameter REGISTER_WIDTH = 4,
    parameter MEMORY_ADDRESS_WIDTH = 4
) (
    input wire clk_i,
    input wire reset_i,

    // IN
    input wire active_i,
    input wire [UART_DATA_LENGTH-1:0] uart_data_i,
    input wire data_valid_strb_i,

    // OUT
    output reg [REGISTER_WIDTH-1:0] data_o,
    output reg [MEMORY_ADDRESS_WIDTH-1:0] addr_o,
    output reg enable_write_memory_o
);

    // ###########################################################
    //                SIGNAL DEFINITION
    // ###########################################################

    // input register
    reg [UART_DATA_LENGTH-1:0] rx_input;
    reg [UART_DATA_LENGTH-1:0] next_rx_input;

    // State encoding
    localparam stIDLE    = 2'b00;
    localparam stFIRST   = 2'b01;
    localparam stSECOND  = 2'b10;

    // state register
    reg [1:0] state;
    reg [1:0] next_state;

    // address register
    reg [MEMORY_ADDRESS_WIDTH-1:0] addr;
    reg [MEMORY_ADDRESS_WIDTH-1:0] next_addr;

    // ###########################################################
    //                COMBINATORIAL LOGIC (REGISTER)
    // ###########################################################

    // load data into input register at valid strobe
    always @(data_valid_strb_i, rx_input, uart_data_i) begin
        //default assignment
        next_rx_input = rx_input;

        if (data_valid_strb_i)
            next_rx_input = uart_data_i;
    end

    // next state logic
    always @(state, data_valid_strb_i, active_i, addr) begin
        //default assignments
        next_state = state;
        data_o = {MEMORY_ADDRESS_WIDTH{1'b0}};
        addr_o = {MEMORY_ADDRESS_WIDTH{1'b0}};
        enable_write_memory_o = 0;

        case(state)
            stIDLE: begin
                if (data_valid_strb_i && active_i)
                    next_state = stFIRST;
            end

            stFIRST: begin
                data_o = uart_data_i[7:4];
                addr_o = addr;
                enable_write_memory_o = 1;

                next_state = stSECOND;
            end

            
            stSECOND: begin
                data_o = uart_data_i[3:0];
                addr_o = addr;
                enable_write_memory_o = 1;

                next_state = stIDLE;
            end
        endcase
    end

    // inc addr logic
    always @(addr, state) begin
        //default assignment
        next_addr = addr;

        if (active_i == 0) begin
            next_addr = 0;
        end else if (state == stFIRST || state == stSECOND) begin
            next_addr = addr + 1;
        end
    end

    // ###########################################################
    //                SEQUENTIAL LOGIC (REGISTER)
    // ###########################################################
    always @(posedge clk_i or posedge reset_i) begin
        if (reset_i) begin
            rx_input <= {UART_DATA_LENGTH{1'b0}};
            addr <= {MEMORY_ADDRESS_WIDTH{1'b0}};
            state <= stIDLE;
        end else begin
            rx_input <= next_rx_input;
            addr <= next_addr;
            state <= next_state;
        end
    end
endmodule