module reg_memory #(
    parameter MEMORY_REGISTERS = 16,
    parameter REGISTER_WIDTH = 4,
    parameter MEMORY_ADDRESS_WIDTH = 4
) (
    // input
    input wire clk_i,
    input wire reset_i,
    input wire write_en_i,
    input wire read_en_i,
    input wire [MEMORY_ADDRESS_WIDTH-1:0] addr_i,
    input wire [REGISTER_WIDTH-1:0] data_i,
    
    // output
    output reg [REGISTER_WIDTH-1:0] data_o
);

    // Instruction constants
    localparam NOP_INSTR = 4'b0000;
    localparam XOR_INSTR = 4'b0001;
    localparam AND_INSTR = 4'b0010;
    localparam OR_INSTR = 4'b0011;
    localparam ADD_INSTR = 4'b0100;
    localparam INC_INSTR = 4'b0101;
    localparam DEC_INSTR = 4'b0110;
    localparam SUB_INSTR = 4'b0111;
    localparam JMP_INSTR = 4'b1000;
    localparam JZ_INSTR = 4'b1001;
    localparam JC_INSTR = 4'b1010;
    localparam LD_INSTR = 4'b1011;
    localparam ST_INSTR = 4'b1100;
    localparam IN_INSTR = 4'b1101;
    localparam OUT_INSTR = 4'b1110;
    localparam LDI_INSTR = 4'b1111;

    //integer i;

    reg [REGISTER_WIDTH-1:0] reg_vals [0:MEMORY_REGISTERS-1];
    //reg [REGISTER_WIDTH-1:0] next_reg_vals [0:MEMORY_REGISTERS-1];

    // ----------------------------
    // Combinational next-state logic
    // ----------------------------

    always @(posedge clk_i or posedge reset_i) begin
        if (reset_i) begin
            reg_vals[0]  <= OUT_INSTR; 
            reg_vals[1]  <= INC_INSTR;
            reg_vals[2]  <= JMP_INSTR; 
            reg_vals[3]  <= 4'b0000;
            reg_vals[4]  <= NOP_INSTR; 
            reg_vals[5]  <= NOP_INSTR; 
            reg_vals[6]  <= NOP_INSTR; 
            reg_vals[7]  <= NOP_INSTR;
            reg_vals[8]  <= NOP_INSTR; 
            reg_vals[9]  <= NOP_INSTR; 
            reg_vals[10] <= NOP_INSTR; 
            reg_vals[11] <= NOP_INSTR; 
            reg_vals[12] <= NOP_INSTR; 
            reg_vals[13] <= NOP_INSTR; 
            reg_vals[14] <= NOP_INSTR; 
            reg_vals[15] <= NOP_INSTR;           
        end else if (write_en_i) begin
            reg_vals[addr_i] <= data_i;
        end
    end

    always @(*) begin
        if (read_en_i)
            data_o = reg_vals[addr_i];
        else
            data_o = 0;
    end
    

    /*  
    always @(*) begin
        // default: hold previous values
        for (i = 0; i < MEMORY_REGISTERS; i = i + 1) begin
            next_reg_vals[i] = reg_vals[i];
        end

        // default output
        data_o = {REGISTER_WIDTH{1'b0}};

        // write path
        if (write_en_i)
            next_reg_vals[addr_i] = data_i;

        // read path (synchronous read emulation)
        if (read_en_i)
            data_o = reg_vals[addr_i];
    end

    always @(posedge clk_i or posedge reset_i) begin
        if (reset_i) begin
            reg_vals[0]  <= OUT_INSTR; 
            reg_vals[1]  <= INC_INSTR;
            reg_vals[2]  <= JMP_INSTR; 
            reg_vals[3]  <= 4'b0000;
            reg_vals[4]  <= NOP_INSTR; 
            reg_vals[5]  <= NOP_INSTR; 
            reg_vals[6]  <= NOP_INSTR; 
            reg_vals[7]  <= NOP_INSTR;
            reg_vals[8]  <= NOP_INSTR; 
            reg_vals[9]  <= NOP_INSTR; 
            reg_vals[10] <= NOP_INSTR; 
            reg_vals[11] <= NOP_INSTR; 
            reg_vals[12] <= NOP_INSTR; 
            reg_vals[13] <= NOP_INSTR; 
            reg_vals[14] <= NOP_INSTR; 
            reg_vals[15] <= NOP_INSTR;           
        end else begin 
            for (i = 0; i < MEMORY_REGISTERS; i = i + 1) begin
                reg_vals[i] <= next_reg_vals[i];
            end
        end
    end
    */
endmodule