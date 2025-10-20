module control_unit #(
    parameter CRA_BIT_NUMB = 4,
    parameter OPERATION_CODE_WIDTH = 3,
    parameter REGISTER_WIDTH = 4,
    parameter MEMORY_ADDRESS_WIDTH = 4
) (
    input wire clk_i,
    input wire reset_i,
    
    // MEMORY
    output reg read_en_mem_o,
    output reg write_en_mem_o,
    output reg [MEMORY_ADDRESS_WIDTH-1:0] addr_mem_o,
    output reg [REGISTER_WIDTH-1:0] write_data_mem_o,
    input wire [REGISTER_WIDTH-1:0] read_data_mem_i,

    // INSTRUCTION REG.
    output reg write_en_ir_o,
    output reg [REGISTER_WIDTH-1:0] write_data_ir_o,
    input wire [REGISTER_WIDTH-1:0] data_ir_i,

    // ACCUMULATOR REG.
    output reg write_en_a_o,
    output reg [REGISTER_WIDTH-1:0] write_data_a_o,
    input wire [REGISTER_WIDTH-1:0] data_a_i,

    // MDR REG.
    output reg write_en_mdr_o,
    output reg [REGISTER_WIDTH-1:0] write_data_mdr_o,
    input wire [REGISTER_WIDTH-1:0] data_mdr_i,

    // OPERAND REG.
    output reg write_en_opnd_o,
    output reg [REGISTER_WIDTH-1:0] write_data_opnd_o,
    input wire [REGISTER_WIDTH-1:0] data_opnd_i,

    // IN REG.
    output reg write_en_in_o,
    input wire [REGISTER_WIDTH-1:0] data_in_i,

    // OUT REG.
    output reg write_en_out_o,
    output reg [REGISTER_WIDTH-1:0] write_data_out_o,

    // ALU
    output reg [OPERATION_CODE_WIDTH-1:0] oc_o,
    output reg [CRA_BIT_NUMB-1:0] a_o,
    output reg [CRA_BIT_NUMB-1:0] b_o,
    input wire [CRA_BIT_NUMB-1:0] result_alu_i,
    input wire carry_alu_i,

    // Boot Loader
    input wire p_programm_i,
    input wire [REGISTER_WIDTH-1:0] p_data_i,
    input wire [MEMORY_ADDRESS_WIDTH-1:0] p_address_i,
    input wire p_write_en_mem_i,
    output wire p_active_o
);

    // ###########################################################
    //                    INTERNAL SIGNALS
    // ###########################################################

    // State Machine
    localparam stRESET     = 3'd0;
    localparam stPROGRAMM  = 3'd1;
    localparam stFETCH_I   = 3'd2;
    localparam stDECODE    = 3'd3;
    localparam stFETCH_O   = 3'd4;
    localparam stFETCH_MDR = 3'd5;
    localparam stEXEC_ALU  = 3'd6;
    localparam stEXEC      = 3'd7;

    reg [2:0] cu_state;
    reg [2:0] next_cu_state;

    // Programm Counter
    reg [MEMORY_ADDRESS_WIDTH - 1:0] programm_counter;
    reg [MEMORY_ADDRESS_WIDTH - 1:0] next_programm_counter;

    // operation code
    wire [2:0] opcode;
    assign opcode = data_ir_i[2:0];

    // flags
    reg z_flag;
    reg next_z_flag;

    reg c_flag;
    reg next_c_flag;

    // instruction signals
    wire mdr_instr; // signals that this instruction uses the MDR and therefore the extra Fetch_MDR step is needed
    reg nop_instr;
    reg operand_instr;
    reg alu_instr;
    reg inc_dec_instr;
    reg jmp_instr;
    reg jz_instr;
    reg jc_instr;
    reg ld_instr;
    reg st_instr;
    reg in_instr;
    reg out_instr;
    reg ldi_instr;

    // ###########################################################
    //                    Instruction Decode Logic
    // ###########################################################

    assign mdr_instr = ld_instr || alu_instr; // alu and ld instruction use the MDR Register, therefore assign mdr_instr

    always @(*) begin

        // standard assignment
        oc_o = {OPERATION_CODE_WIDTH{1'b0}};
        nop_instr = 0;
        operand_instr = 0;
        alu_instr = 0;
        inc_dec_instr = 0;
        jmp_instr = 0;
        jz_instr = 0;
        jc_instr = 0;
        ld_instr = 0;
        st_instr = 0;
        in_instr = 0;
        out_instr = 0;
        ldi_instr = 0;

        // operand_instr
        if (!(data_ir_i[2:0] == 3'b101 || data_ir_i[2:0] == 3'b110)) begin
            operand_instr = 1; // instruction with operand
        end

        if (data_ir_i[3] == 1'b0) begin
            if (data_ir_i[2:0] == 3'b000) begin
                nop_instr = 1;              // NOP
            end else begin
                alu_instr = 1;              // ALU_INSTR
                oc_o = data_ir_i[2:0];
                if (data_ir_i[2:0] == 3'b110 || data_ir_i[2:0] == 3'b101) begin
                    inc_dec_instr = 1;      // INC or DEC INSTR
                end
            end
        end else begin
            case (opcode)
                3'b000: jmp_instr = 1;      // JMP_INSTR
                3'b001: jz_instr = 1;       // JZ_INSTR
                3'b010: jc_instr = 1;       // JC_INSTR
                3'b011: ld_instr = 1;       // LD_INSTR
                3'b100: st_instr = 1;       // ST_INSTR
                3'b101: in_instr = 1;       // IN_INSTR
                3'b110: out_instr = 1;      // OUT_INSTR
                3'b111: ldi_instr = 1;      // LDI_INSTR
                default: ;
            endcase
        end
    end

    // ###########################################################
    //                   NEXT STATE LOGIC
    // ###########################################################

    always @(*) begin
        // standard assignment
        next_cu_state = stRESET;

        case (cu_state)
            stRESET: begin
                if (p_programm_i)
                    next_cu_state = stPROGRAMM;
                else
                    next_cu_state = stFETCH_I;
            end

            stPROGRAMM: begin
                if (p_programm_i)
                    next_cu_state = stPROGRAMM;
                else
                    next_cu_state = stFETCH_I;
            end

            stFETCH_I: begin
                next_cu_state = stDECODE;
            end

            stDECODE: begin
                if (nop_instr)
                    next_cu_state = stFETCH_I;
                else if (operand_instr)
                    next_cu_state = stFETCH_O;
                else if (mdr_instr)
                    next_cu_state = stFETCH_MDR;
                else
                    next_cu_state = stEXEC;
            end

            stFETCH_O: begin
                if (mdr_instr)
                    next_cu_state = stFETCH_MDR;
                else
                    next_cu_state = stEXEC;
            end

            stFETCH_MDR: begin
                if (alu_instr)
                    next_cu_state = stEXEC_ALU;
                else 
                    next_cu_state = stEXEC;
            end

            stEXEC_ALU: begin
                if (p_programm_i)
                    next_cu_state = stPROGRAMM;
                else
                    next_cu_state = stFETCH_I;
            end

            stEXEC: begin
                if (p_programm_i)
                    next_cu_state = stPROGRAMM;
                else
                    next_cu_state = stFETCH_I;
            end 

            default: begin
                next_cu_state = stRESET;
            end
        endcase
    end

    assign p_active_o = cu_state == stPROGRAMM;

    // ###########################################################
    //               SET CONTROL SINGALS LOGIC
    // ###########################################################

    always @(*) begin
        // default assignments
        next_programm_counter = programm_counter;

        read_en_mem_o = 0;
        write_en_mem_o = 0;
        addr_mem_o = {MEMORY_ADDRESS_WIDTH{1'b0}};
        write_data_mem_o = {REGISTER_WIDTH{1'b0}};

        write_en_in_o = 1;
        write_en_out_o = 0;
        write_data_out_o = {REGISTER_WIDTH{1'b0}};

        write_en_opnd_o = 0;
        write_data_opnd_o = {REGISTER_WIDTH{1'b0}};

        write_en_mdr_o = 0;
        write_data_mdr_o = {REGISTER_WIDTH{1'b0}};

        write_en_ir_o = 0;
        write_data_ir_o = {REGISTER_WIDTH{1'b0}};

        write_en_a_o = 0;
        write_data_a_o = {REGISTER_WIDTH{1'b0}};

        a_o = {CRA_BIT_NUMB{1'b0}};
        b_o = {CRA_BIT_NUMB{1'b0}};

        // program counter logic
        if (cu_state == stFETCH_I || cu_state == stFETCH_O)
            next_programm_counter = programm_counter + 1;

        // FSM behavior
        case (cu_state)
            stPROGRAMM: begin
                // connect boot loader to memory
                write_en_mem_o = p_write_en_mem_i;
                addr_mem_o = p_address_i;
                write_data_mem_o = p_data_i;

                //reset state
                next_programm_counter = {MEMORY_ADDRESS_WIDTH{1'b0}};
                write_en_a_o = 1;
                write_data_a_o = {REGISTER_WIDTH{1'b0}};
            end

            stFETCH_I: begin
                // enable read from memory
                read_en_mem_o = 1;
                // enable write for IR
                write_en_ir_o = 1;
                // set address
                addr_mem_o = programm_counter;
                // connect signals
                write_data_ir_o = read_data_mem_i;
            end

            stFETCH_O: begin
                // enable read from memory
                read_en_mem_o = 1;
                // enable write for OPND
                write_en_opnd_o = 1;
                // set address
                addr_mem_o = programm_counter;
                // connect signals
                write_data_opnd_o = read_data_mem_i;
            end

            stFETCH_MDR: begin
                
                // enable write to MDR Reg.
                write_en_mdr_o = 1;

                if (inc_dec_instr) begin                // if it is a inc or dec instr, write 1 to MDR reg
                    // write 1 to MDR
                    write_data_mdr_o = {{(CRA_BIT_NUMB-1){1'b0}}, 1'b1};
                end else begin                          // if it is another mdr instr just write the memory data at the address stored in the opnd in the mdr
                    // enable read from memroy
                    read_en_mem_o = 1;
                    // set address to OPND
                    addr_mem_o = data_opnd_i;
                    // set output of memory to MDR 
                    write_data_mdr_o = read_data_mem_i;
                end
            end

            stEXEC_ALU: begin
                // asssign data from A to ALU a input
                a_o = data_a_i;
                
                // assign MDR to ALU b input
                b_o = data_mdr_i;
                
                // assign result of ALU to A
                write_data_a_o = result_alu_i;
                write_en_a_o = 1;
            end

            stEXEC: begin
                if (jmp_instr)
                    next_programm_counter = data_opnd_i;
                else if (jz_instr && z_flag)
                    next_programm_counter = data_opnd_i;
                else if (jc_instr && c_flag)
                    next_programm_counter = data_opnd_i;
                else if (ld_instr) begin
                    // enable write on a reg
                    write_en_a_o = 1;
                    // write MDR to a reg
                    write_data_a_o = data_mdr_i;
                end
                else if (st_instr) begin
                    // enable write to A register
                    write_en_mem_o = 1;
                    // set operand as address
                    addr_mem_o = data_opnd_i;
                    // write data from A to memory
                    write_data_mem_o = data_a_i;
                end
                else if (in_instr) begin
                    // enable write to A Register
                    write_en_a_o = 1;
                    // write to A Register
                    write_data_a_o = data_in_i;
                end
                else if (out_instr) begin
                    // enable write to OUT Register
                    write_en_out_o = 1;
                    // write from A Register to OUT Register
                    write_data_out_o = data_a_i;
                end
                else if (ldi_instr) begin
                    // enable write to A Register
                    write_en_a_o = 1;
                    // write operand to A Register
                    write_data_a_o = data_opnd_i;
                end
            end

            default: ;
        endcase
    end

    // ###########################################################
    //                   FLAGS LOGIC
    // ###########################################################
    always @(*) begin
        // standard assignmentd
        next_c_flag = c_flag;
        if (cu_state == stEXEC_ALU)
            next_c_flag = carry_alu_i;
    end

    always @(*) begin
        // standard assignment
        next_z_flag = z_flag;
        if (cu_state == stEXEC_ALU) begin
            if (result_alu_i == 4'b0000)
                next_z_flag = 1;
            else
                next_z_flag = 0;
        end
    end

    // ###########################################################
    //                SEQUENTIAL LOGIC (REGISTER)
    // ###########################################################
    always @(posedge clk_i or posedge reset_i) begin
        if (reset_i) begin
            c_flag <= 0;
            z_flag <= 0;
            programm_counter <= {MEMORY_ADDRESS_WIDTH{1'b0}};
            cu_state <= stRESET;
        end else begin
            c_flag <= next_c_flag;
            z_flag <= next_z_flag;
            programm_counter <= next_programm_counter;
            cu_state <= next_cu_state;
        end
    end
endmodule