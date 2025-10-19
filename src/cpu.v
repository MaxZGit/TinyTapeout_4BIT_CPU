module cpu #(
    parameter CRA_BIT_NUMB = 4,
    parameter OPERATION_CODE_WIDTH = 3,
    parameter REGISTER_WIDTH = 4,
    parameter MEMORY_ADDRESS_WIDTH = 4,
    parameter MEMORY_REGISTERS = 16
) (
    input wire clk_i,
    input wire reset_i,

    // IN
    input wire [REGISTER_WIDTH - 1 : 0] in_pins_i,

    // OUT
    output wire [REGISTER_WIDTH - 1 : 0] out_pins_o,

    // Boot Loader
    input wire bl_programm_i,
    input wire [REGISTER_WIDTH - 1 : 0] bl_data_i,
    input wire [MEMORY_ADDRESS_WIDTH - 1 : 0] bl_address_i,
    input wire bl_write_en_mem_i
);

    // ###############################################
    //             CONNECTING SIGNALS
    // ###############################################
    
    // Accumulation Reg.
    wire write_en_a_cpu;
    wire [REGISTER_WIDTH-1:0] write_data_a_cpu;
    wire [REGISTER_WIDTH-1:0] data_a_cpu;

    // Instruction Reg.
    wire write_en_ir_cpu;
    wire [REGISTER_WIDTH-1:0] write_data_ir_cpu;
    wire [REGISTER_WIDTH-1:0] data_ir_cpu;

    // Operand Reg.
    wire write_en_opnd_cpu;
    wire [REGISTER_WIDTH-1:0] write_data_opnd_cpu;
    wire [REGISTER_WIDTH-1:0] data_opnd_cpu;

    // MDR Reg.
    wire write_en_mdr_cpu;
    wire [REGISTER_WIDTH-1:0] write_data_mdr_cpu;
    wire [REGISTER_WIDTH-1:0] data_mdr_cpu;

    // IN Reg.
    wire write_en_in_cpu;
    wire [REGISTER_WIDTH-1:0] write_data_in_cpu;
    wire [REGISTER_WIDTH-1:0] data_in_cpu;

    // OUT Reg.
    wire write_en_out_cpu;
    wire [REGISTER_WIDTH-1:0] write_data_out_cpu;
    wire [REGISTER_WIDTH-1:0] data_out_cpu;

    // Memory
    wire read_en_mem_cpu;
    wire write_en_mem_cpu;
    wire [MEMORY_ADDRESS_WIDTH-1:0] addr_mem_cpu;
    wire [REGISTER_WIDTH-1:0] write_data_mem_cpu;
    wire [REGISTER_WIDTH-1:0] read_data_mem_cpu;

    // ALU
    wire [OPERATION_CODE_WIDTH-1:0] oc_alu_cpu;
    wire [CRA_BIT_NUMB-1:0] a_alu_cpu;
    wire [CRA_BIT_NUMB-1:0] b_alu_cpu;
    wire [CRA_BIT_NUMB-1:0] result_alu_cpu;
    wire carry_alu_cpu;


    // ###############################################
    //                  SIGNAL ROUTING
    // ###############################################

    assign out_pins_o = data_out_cpu;
    assign write_data_in_cpu = in_pins_i;

    // ###############################################
    //                   COMPONENTS
    // ###############################################

    // -----------------------------------------------
    // REGISTERS
    // -----------------------------------------------

    // Accumulator Register (A)
    my_register #(
        .REGISTER_WIDTH(REGISTER_WIDTH)
    ) a_reg (
        // inputs
        .clk_i(clk_i),
        .reset_i(reset_i),
        .write_en_i(write_en_a_cpu),
        .in_i(write_data_a_cpu),

        // outputs
        .out_o(data_a_cpu)
    );

    // Instruction Reg.
    my_register #(
        .REGISTER_WIDTH(REGISTER_WIDTH)
    ) ir_reg (
        // inputs
        .clk_i(clk_i),
        .reset_i(reset_i),
        .write_en_i(write_en_ir_cpu),
        .in_i(write_data_ir_cpu),

        // outputs
        .out_o(data_ir_cpu)
    );

    // MDR Reg.
    my_register #(
        .REGISTER_WIDTH(REGISTER_WIDTH)
    ) mdr_reg (
        // inputs
        .clk_i(clk_i),
        .reset_i(reset_i),
        .write_en_i(write_en_mdr_cpu),
        .in_i(write_data_mdr_cpu),

        // outputs
        .out_o(data_mdr_cpu)
    );

    // Operand Reg.
    my_register #(
        .REGISTER_WIDTH(REGISTER_WIDTH)
    ) opnd_reg (
        // inputs
        .clk_i(clk_i),
        .reset_i(reset_i),
        .write_en_i(write_en_opnd_cpu),
        .in_i(write_data_opnd_cpu),

        // outputs
        .out_o(data_opnd_cpu)
    );

    // OUT Reg.
    my_register #(
        .REGISTER_WIDTH(REGISTER_WIDTH)
    ) out_reg (
        // inputs
        .clk_i(clk_i),
        .reset_i(reset_i),
        .write_en_i(write_en_out_cpu),
        .in_i(write_data_out_cpu),
        
        // outputs
        .out_o(data_out_cpu)
    );

    // IN Reg.
    my_register #(
        .REGISTER_WIDTH(REGISTER_WIDTH)
    ) in_reg (
        // inputs
        .clk_i(clk_i),
        .reset_i(reset_i),
        .write_en_i(write_en_in_cpu),
        .in_i(write_data_in_cpu),
        
        // outputs
        .out_o(data_in_cpu)
    );

    // -----------------------------------------------
    // MEMORY
    // -----------------------------------------------

    reg_memory #(
        .MEMORY_REGISTERS(MEMORY_REGISTERS),
        .REGISTER_WIDTH(REGISTER_WIDTH),
        .MEMORY_ADDRESS_WIDTH(MEMORY_ADDRESS_WIDTH)
    ) memory (
        // inputs
        .clk_i(clk_i),
        .reset_i(reset_i),
        .write_en_i(write_en_mem_cpu),//write_en_mem_cpu
        .read_en_i(read_en_mem_cpu),//read_en_mem_cpu
        .addr_i(addr_mem_cpu),
        .data_i(write_data_mem_cpu),

        // outputs
        .data_o(read_data_mem_cpu)
    );

    // -----------------------------------------------
    // ALU
    // -----------------------------------------------

    alu #(
        .ALU_BIT_WIDTH(CRA_BIT_NUMB),
        .OPERATION_CODE_WIDTH(OPERATION_CODE_WIDTH)
    ) alu (
        // inputs
        .a_i(a_alu_cpu),
        .b_i(b_alu_cpu),
        .oc_i(oc_alu_cpu),

        // outputs
        .result_o(result_alu_cpu),
        .carry_o(carry_alu_cpu)
    );

    // -----------------------------------------------
    // Control Unit
    // -----------------------------------------------

    control_unit #(
        .CRA_BIT_NUMB(CRA_BIT_NUMB),
        .OPERATION_CODE_WIDTH(OPERATION_CODE_WIDTH),
        .REGISTER_WIDTH(REGISTER_WIDTH),
        .MEMORY_ADDRESS_WIDTH(MEMORY_ADDRESS_WIDTH)
    ) cu (
        .clk_i(clk_i),
        .reset_i(reset_i),

        //memory
        .read_en_mem_o(read_en_mem_cpu),
        .write_en_mem_o(write_en_mem_cpu),
        .addr_mem_o(addr_mem_cpu),
        .write_data_mem_o(write_data_mem_cpu),
        .read_data_mem_i(read_data_mem_cpu),

        // Instruction Reg.
        .write_en_ir_o(write_en_ir_cpu),
        .write_data_ir_o(write_data_ir_cpu),
        .data_ir_i(data_ir_cpu),

        // accumulator REG.
        .write_en_a_o(write_en_a_cpu),
        .write_data_a_o(write_data_a_cpu),
        .data_a_i(data_a_cpu),

        // operand REG.
        .write_en_opnd_o(write_en_opnd_cpu),
        .write_data_opnd_o(write_data_opnd_cpu),
        .data_opnd_i(data_opnd_cpu),

        // mdr REG.
        .write_en_mdr_o(write_en_mdr_cpu),
        .write_data_mdr_o(write_data_mdr_cpu),
        .data_mdr_i(data_mdr_cpu),

        // IN REG.
        .write_en_in_o(write_en_in_cpu),
        .data_in_i(data_in_cpu),

        // OUT REG.
        .write_en_out_o(write_en_out_cpu),
        .write_data_out_o(write_data_out_cpu),

        // ALU
        .oc_o(oc_alu_cpu),
        .a_o(a_alu_cpu),
        .b_o(b_alu_cpu),
        .result_alu_i(result_alu_cpu),
        .carry_alu_i(carry_alu_cpu),

        // Boot Loader
        .bl_programm_i(bl_programm_i),
        .bl_data_i(bl_data_i),
        .bl_address_i(bl_address_i),
        .bl_write_en_mem_i(bl_write_en_mem_i)
    );
endmodule