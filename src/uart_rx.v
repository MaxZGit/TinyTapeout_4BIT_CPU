module uart_rx #(
    parameter UART_BAUD_RATE = 19200,
    parameter UART_DATA_LENGTH = 8,
    parameter CLK_FREQ = 10000000, //10 MHz
    parameter RX_COUNTER_BITWIDTH = 3,
    parameter BAUD_COUNTS_PER_BIT = 521,
    parameter BAUD_RATE_COUNTER_BITWIDTH = 10
) (
    input wire clk_i,
    input wire reset_i,

    // IN
    input wire rx_i,

    // OUT
    output wire [UART_DATA_LENGTH-1:0] data_o,
    output wire data_valid_strb
);

    // ###########################################################
    //                SIGNAL DEFINITION
    // ###########################################################

    // Constant definition
    localparam integer BAUD_COUNTS_PER_BIT_HALF = BAUD_COUNTS_PER_BIT / 2;

    // State encoding
    localparam stIDLE       = 2'b00;
    localparam stSTARTBIT   = 2'b01;
    localparam stRECEIVING  = 2'b10;
    localparam stSTOPBIT    = 2'b11;

    // Internal Signals
    // register for fsm
    reg[1:0] rx_state;
    reg[1:0] next_rx_state;

    // register to store the number of incoming bits
    reg [RX_COUNTER_BITWIDTH-1:0] rx_counter_val;
    reg [RX_COUNTER_BITWIDTH-1:0] next_rx_counter_val;

    // counting baudrate
    reg [BAUD_RATE_COUNTER_BITWIDTH-1:0] baud_counter_val;
    reg [BAUD_RATE_COUNTER_BITWIDTH-1:0] next_baud_counter_val;

    // data
    reg [UART_DATA_LENGTH-1:0] rx_data;
    reg [UART_DATA_LENGTH-1:0] next_rx_data;
    
    // ###########################################################
    //                COMBINATORIAL LOGIC (REGISTER)
    // ###########################################################

    // next rx_state logic
    always @(rx_state, baud_counter_val, rx_counter_val, rx_i) begin
        //default assignment
        next_rx_state = rx_state;

        case (rx_state)
            stIDLE: begin
                // wait for start bit
                if (rx_i == 0)
                    next_rx_state = stSTARTBIT;
            end

            stSTARTBIT: begin
                // wait for baud counter to count 1 bit
                if (baud_counter_val == BAUD_COUNTS_PER_BIT)
                    next_rx_state = stRECEIVING;
            end

            stRECEIVING: begin
                // store data at half baud counter val
                if (rx_counter_val == UART_DATA_LENGTH - 1)
                    next_rx_state = stSTOPBIT;
            end

            stSTOPBIT: begin
                // wait for 1 bit
                if (baud_counter_val == BAUD_COUNTS_PER_BIT)
                    next_rx_state = stIDLE;
            end
        endcase
    end

    // baud counter value logic
    always @(baud_counter_val, rx_state) begin
        // default assignment
        next_baud_counter_val = baud_counter_val;
        
        if (rx_state == stIDLE || baud_counter_val >= BAUD_COUNTS_PER_BIT)
            next_baud_counter_val = {BAUD_RATE_COUNTER_BITWIDTH{1'b0}};
        else  // if counter is smaller (and not in idle state), add one
            next_baud_counter_val = baud_counter_val + 1; 
    end

    // rx_counter_val logic
    always @(rx_counter_val, rx_state, baud_counter_val) begin
        // default assignment
        next_rx_counter_val = rx_counter_val;
        
        if (rx_state == stRECEIVING) begin
            if (baud_counter_val == BAUD_COUNTS_PER_BIT) // count up after a full bit
                next_rx_counter_val = rx_counter_val + 1;
        end else begin // reset if not in receiving state
            next_baud_counter_val = {BAUD_RATE_COUNTER_BITWIDTH{1'b0}};
        end 
    end

    // receiving data logic
    always @(rx_state, baud_counter_val, rx_i, rx_data) begin
        // default assignment
        next_rx_data = rx_data;

        if (rx_state == stRECEIVING) begin
            if (baud_counter_val == BAUD_COUNTS_PER_BIT_HALF)
                next_rx_data = {rx_i, rx_data[UART_DATA_LENGTH - 1:1]};
        end
    end

    // TODO MAYBE MAKE STROBE EVERY 4 BIT TO STORE IN MEMORY
    // data valid strobe logic
    always @(rx_state, next_rx_state) begin
        if (rx_state == stSTOPBIT && next_rx_state == stIDLE)
            data_valid_strb = 1;
        else
            data_valid_strb = 0;
    end

    assign data_o = rx_data;

    // ###########################################################
    //                SEQUENTIAL LOGIC (REGISTER)
    // ###########################################################

    always @(posedge clk_i or posedge reset_i) begin
        if (reset_i) begin
            rx_counter_val <= {RX_COUNTER_BITWIDTH{1'b0}};
            baud_counter_val <= {BAUD_RATE_COUNTER_BITWIDTH{1'b0}};
            rx_state <= stIDLE
            rx_data <= {UART_DATA_LENGTH{1'b0}};
        end else begin
            rx_counter_val <= next_rx_counter_val;
            baud_counter_val <= next_baud_counter_val;
            rx_state <= next_rx_state;
            rx_data <= next_rx_data;
        end
    end
endmodule