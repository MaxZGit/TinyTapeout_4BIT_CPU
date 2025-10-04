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

    integer i;

    reg [REGISTER_WIDTH-1:0] reg_vals [0:MEMORY_REGISTERS-1];
    reg [REGISTER_WIDTH-1:0] next_reg_vals [0:MEMORY_REGISTERS-1];

    // write logic (combinatorial)
    always @(*) begin
        // standard assignment
        for (i = 0; i < MEMORY_REGISTERS; i = i + 1) begin
            next_reg_vals[i] = reg_vals[i];
        end 

        if (write_en_i) begin
            next_reg_vals[addr_i] = data_i;    
        end
    end

    // read logic (combinatorial)
    always @(*) begin
        // standard assignment
        data_o = {REGISTER_WIDTH{1'b0}};

        if (read_en_i) begin
            data_o = reg_vals[addr_i];    
        end
    end

    always @(posedge clk_i, reset_i) begin
        if (reset_i) begin
            reg_vals[0]  <= OUT_INSTR; 
            reg_vals[1]  <= INC_INSTR;
            reg_vals[2]  <= JC_INSTR; 
            reg_vals[3]  <= SUB_INSTR;
            reg_vals[4]  <= JMP_INSTR; 
            reg_vals[5]  <= NOP_INSTR; 
            reg_vals[6]  <= OUT_INSTR; 
            reg_vals[7]  <= DEC_INSTR;
            reg_vals[8]  <= JZ_INSTR; 
            reg_vals[9]  <= NOP_INSTR; 
            reg_vals[10] <= JMP_INSTR; 
            reg_vals[11] <= DEC_INSTR; 
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
endmodule