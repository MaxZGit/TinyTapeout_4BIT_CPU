`default_nettype none

module half_adder
  (input  a_i,
   input  b_i,
   output sum_o,
   output carry_o);
  wire n635;
  wire n636;
  assign sum_o = n635; //(module output)
  assign carry_o = n636; //(module output)
  /* ../../vhdl/rtl/half_adder_ea.vhd:26:18  */
  assign n635 = a_i ^ b_i;
  /* ../../vhdl/rtl/half_adder_ea.vhd:29:20  */
  assign n636 = a_i & b_i;
endmodule

module full_adder
  (input  a_i,
   input  b_i,
   input  carry_i,
   output sum_o,
   output carry_o);
  wire sum_ab;
  wire carry_ha_0;
  wire carry_ha_1;
  wire \half_adder_1.sum_o ;
  wire n632;
  assign sum_o = \half_adder_1.sum_o ; //(module output)
  assign carry_o = n632; //(module output)
  /* ../../vhdl/rtl/full_adder_ea.vhd:25:5  */
  half_adder half_adder_0 (
    .a_i(a_i),
    .b_i(b_i),
    .sum_o(sum_ab),
    .carry_o(carry_ha_0));
  /* ../../vhdl/rtl/full_adder_ea.vhd:35:5  */
  half_adder half_adder_1 (
    .a_i(sum_ab),
    .b_i(carry_i),
    .sum_o(\half_adder_1.sum_o ),
    .carry_o(carry_ha_1));
  /* ../../vhdl/rtl/full_adder_ea.vhd:45:27  */
  assign n632 = carry_ha_0 | carry_ha_1;
endmodule

module carry_ripple_adder_4
  (input  [3:0] a_i,
   input  [3:0] b_i,
   input  carry_i,
   output [3:0] sum_o,
   output carry_o);
  wire carry_0;
  wire carry_1;
  wire carry_2;
  wire \full_adder0.sum_o ;
  wire n609;
  wire n610;
  wire \full_adder1.sum_o ;
  wire n613;
  wire n614;
  wire \full_adder2.sum_o ;
  wire n617;
  wire n618;
  wire \full_adder3.sum_o ;
  wire \full_adder3.carry_o ;
  wire n621;
  wire n622;
  wire [3:0] n625;
  assign sum_o = n625; //(module output)
  assign carry_o = \full_adder3.carry_o ; //(module output)
  /* ../../vhdl/rtl/carry_ripple_adder_ea.vhd:28:5  */
  full_adder full_adder0 (
    .a_i(n609),
    .b_i(n610),
    .carry_i(carry_i),
    .sum_o(\full_adder0.sum_o ),
    .carry_o(carry_0));
  /* ../../vhdl/rtl/carry_ripple_adder_ea.vhd:31:19  */
  assign n609 = a_i[0]; // extract
  /* ../../vhdl/rtl/carry_ripple_adder_ea.vhd:32:19  */
  assign n610 = b_i[0]; // extract
  /* ../../vhdl/rtl/carry_ripple_adder_ea.vhd:39:5  */
  full_adder full_adder1 (
    .a_i(n613),
    .b_i(n614),
    .carry_i(carry_0),
    .sum_o(\full_adder1.sum_o ),
    .carry_o(carry_1));
  /* ../../vhdl/rtl/carry_ripple_adder_ea.vhd:42:19  */
  assign n613 = a_i[1]; // extract
  /* ../../vhdl/rtl/carry_ripple_adder_ea.vhd:43:19  */
  assign n614 = b_i[1]; // extract
  /* ../../vhdl/rtl/carry_ripple_adder_ea.vhd:50:5  */
  full_adder full_adder2 (
    .a_i(n617),
    .b_i(n618),
    .carry_i(carry_1),
    .sum_o(\full_adder2.sum_o ),
    .carry_o(carry_2));
  /* ../../vhdl/rtl/carry_ripple_adder_ea.vhd:53:19  */
  assign n617 = a_i[2]; // extract
  /* ../../vhdl/rtl/carry_ripple_adder_ea.vhd:54:19  */
  assign n618 = b_i[2]; // extract
  /* ../../vhdl/rtl/carry_ripple_adder_ea.vhd:61:5  */
  full_adder full_adder3 (
    .a_i(n621),
    .b_i(n622),
    .carry_i(carry_2),
    .sum_o(\full_adder3.sum_o ),
    .carry_o(\full_adder3.carry_o ));
  /* ../../vhdl/rtl/carry_ripple_adder_ea.vhd:64:19  */
  assign n621 = a_i[3]; // extract
  /* ../../vhdl/rtl/carry_ripple_adder_ea.vhd:65:19  */
  assign n622 = b_i[3]; // extract
  assign n625 = {\full_adder3.sum_o , \full_adder2.sum_o , \full_adder1.sum_o , \full_adder0.sum_o };
endmodule

module control_unit_4_3_4_8_4
  (input  clk_i,
   input  reset_i,
   input  [3:0] read_data_mem_i,
   input  [3:0] data_ir_i,
   input  [3:0] data_a_i,
   input  [3:0] data_opnd_i,
   input  [3:0] data_in_i,
   input  [3:0] result_alu_i,
   input  carry_alu_i,
   input  bl_programm_i,
   input  [3:0] bl_data_i,
   input  [3:0] bl_address_i,
   input  bl_write_en_mem_i,
   output read_en_mem_o,
   output write_en_mem_o,
   output [3:0] addr_mem_o,
   output [3:0] write_data_mem_o,
   output write_en_ir_o,
   output [3:0] write_data_ir_o,
   output write_en_a_o,
   output [3:0] write_data_a_o,
   output write_en_opnd_o,
   output [3:0] write_data_opnd_o,
   output write_en_in_o,
   output write_en_out_o,
   output [3:0] write_data_out_o,
   output [2:0] oc_o,
   output [3:0] a_o,
   output [3:0] b_o);
  wire [2:0] cu_state;
  wire [2:0] next_cu_state;
  wire [3:0] programm_counter;
  wire [3:0] next_programm_counter;
  wire [2:0] opcode;
  wire z_flag;
  wire next_z_flag;
  wire c_flag;
  wire next_c_flag;
  wire nop_instr;
  wire operand_instr;
  wire alu_instr;
  wire inc_dec_instr;
  wire jmp_instr;
  wire jz_instr;
  wire jc_instr;
  wire ld_instr;
  wire st_instr;
  wire in_instr;
  wire out_instr;
  wire ldi_instr;
  wire [2:0] n208;
  wire [2:0] n210;
  wire n212;
  wire [2:0] n213;
  wire n215;
  wire n216;
  wire n217;
  wire n220;
  wire n222;
  wire n223;
  wire [2:0] n224;
  wire n226;
  wire [2:0] n227;
  wire [2:0] n228;
  wire n230;
  wire [2:0] n231;
  wire n233;
  wire n234;
  wire n237;
  wire [2:0] n239;
  wire n242;
  wire n245;
  wire n247;
  wire n249;
  wire n251;
  wire n253;
  wire n255;
  wire n257;
  wire n259;
  wire n261;
  wire n263;
  wire [7:0] n264;
  reg n268;
  reg n272;
  reg n276;
  reg n280;
  reg n284;
  reg n288;
  reg n292;
  reg n296;
  wire [2:0] n298;
  wire n301;
  wire n304;
  wire n307;
  wire n310;
  wire n313;
  wire n316;
  wire n319;
  wire n322;
  wire n325;
  wire n328;
  wire n331;
  wire [2:0] n337;
  wire n339;
  wire [2:0] n341;
  wire n343;
  wire n345;
  wire [2:0] n348;
  wire [2:0] n350;
  wire [2:0] n352;
  wire n354;
  wire [2:0] n357;
  wire n359;
  wire [2:0] n362;
  wire n364;
  wire [2:0] n367;
  wire n369;
  wire [6:0] n370;
  reg [2:0] n373;
  wire n378;
  wire n380;
  wire n381;
  wire [3:0] n383;
  wire [3:0] n384;
  wire n386;
  wire n388;
  wire n390;
  wire n393;
  wire [3:0] n395;
  wire [3:0] n397;
  wire n399;
  wire [3:0] n400;
  wire [3:0] n401;
  wire n404;
  wire [3:0] n406;
  wire n408;
  wire [3:0] n410;
  wire n413;
  wire [3:0] n415;
  wire n417;
  wire [3:0] n418;
  wire n420;
  wire [3:0] n422;
  wire n425;
  wire [3:0] n427;
  wire [3:0] n429;
  wire n431;
  wire [3:0] n433;
  wire n435;
  wire [3:0] n437;
  wire n440;
  wire n442;
  wire [3:0] n443;
  wire [3:0] n445;
  wire n447;
  wire [3:0] n448;
  wire n450;
  wire [3:0] n452;
  wire n454;
  wire n456;
  wire [3:0] n458;
  wire [3:0] n460;
  wire n462;
  wire [3:0] n464;
  wire n466;
  wire [3:0] n468;
  wire n469;
  wire n471;
  wire n473;
  wire [3:0] n475;
  wire [3:0] n477;
  wire n479;
  wire [3:0] n481;
  wire n483;
  wire [3:0] n485;
  wire [3:0] n486;
  wire n488;
  wire n490;
  wire [3:0] n492;
  wire [3:0] n494;
  wire n496;
  wire [3:0] n498;
  wire n500;
  wire [3:0] n502;
  wire [3:0] n503;
  wire n505;
  wire [4:0] n506;
  reg n511;
  reg n515;
  reg [3:0] n518;
  reg [3:0] n522;
  reg n527;
  reg [3:0] n531;
  reg n536;
  reg [3:0] n540;
  reg n545;
  reg [3:0] n549;
  reg n553;
  reg n557;
  reg [3:0] n561;
  reg [3:0] n565;
  reg [3:0] n569;
  reg [3:0] n571;
  wire n575;
  wire n576;
  wire n580;
  wire n582;
  wire n585;
  wire n586;
  reg [2:0] n603;
  reg [3:0] n604;
  reg n605;
  reg n606;
  assign read_en_mem_o = n511; //(module output)
  assign write_en_mem_o = n515; //(module output)
  assign addr_mem_o = n518; //(module output)
  assign write_data_mem_o = n522; //(module output)
  assign write_en_ir_o = n527; //(module output)
  assign write_data_ir_o = n531; //(module output)
  assign write_en_a_o = n536; //(module output)
  assign write_data_a_o = n540; //(module output)
  assign write_en_opnd_o = n545; //(module output)
  assign write_data_opnd_o = n549; //(module output)
  assign write_en_in_o = n553; //(module output)
  assign write_en_out_o = n557; //(module output)
  assign write_data_out_o = n561; //(module output)
  assign oc_o = n298; //(module output)
  assign a_o = n565; //(module output)
  assign b_o = n569; //(module output)
  /* ../../vhdl/rtl/control_unit_ea.vhd:68:12  */
  assign cu_state = n603; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:69:12  */
  assign next_cu_state = n373; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:71:12  */
  assign programm_counter = n604; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:72:12  */
  assign next_programm_counter = n571; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:75:12  */
  assign opcode = n208; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:78:12  */
  assign z_flag = n605; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:79:12  */
  assign next_z_flag = n586; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:81:12  */
  assign c_flag = n606; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:82:12  */
  assign next_c_flag = n576; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:85:12  */
  assign nop_instr = n301; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:86:12  */
  assign operand_instr = n220; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:87:12  */
  assign alu_instr = n304; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:88:12  */
  assign inc_dec_instr = n307; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:90:12  */
  assign jmp_instr = n310; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:91:12  */
  assign jz_instr = n313; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:92:12  */
  assign jc_instr = n316; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:93:12  */
  assign ld_instr = n319; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:94:12  */
  assign st_instr = n322; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:95:12  */
  assign in_instr = n325; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:96:12  */
  assign out_instr = n328; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:97:12  */
  assign ldi_instr = n331; // (signal)
  /* ../../vhdl/rtl/control_unit_ea.vhd:101:24  */
  assign n208 = data_ir_i[2:0]; // extract
  /* ../../vhdl/rtl/control_unit_ea.vhd:121:26  */
  assign n210 = data_ir_i[2:0]; // extract
  /* ../../vhdl/rtl/control_unit_ea.vhd:121:39  */
  assign n212 = n210 == 3'b101;
  /* ../../vhdl/rtl/control_unit_ea.vhd:121:59  */
  assign n213 = data_ir_i[2:0]; // extract
  /* ../../vhdl/rtl/control_unit_ea.vhd:121:72  */
  assign n215 = n213 == 3'b110;
  /* ../../vhdl/rtl/control_unit_ea.vhd:121:47  */
  assign n216 = n212 | n215;
  /* ../../vhdl/rtl/control_unit_ea.vhd:121:12  */
  assign n217 = ~n216;
  /* ../../vhdl/rtl/control_unit_ea.vhd:121:9  */
  assign n220 = n217 ? 1'b1 : 1'b0;
  /* ../../vhdl/rtl/control_unit_ea.vhd:125:21  */
  assign n222 = data_ir_i[3]; // extract
  /* ../../vhdl/rtl/control_unit_ea.vhd:125:25  */
  assign n223 = ~n222;
  /* ../../vhdl/rtl/control_unit_ea.vhd:126:25  */
  assign n224 = data_ir_i[2:0]; // extract
  /* ../../vhdl/rtl/control_unit_ea.vhd:126:38  */
  assign n226 = n224 == 3'b000;
  /* ../../vhdl/rtl/control_unit_ea.vhd:130:34  */
  assign n227 = data_ir_i[2:0]; // extract
  /* ../../vhdl/rtl/control_unit_ea.vhd:131:29  */
  assign n228 = data_ir_i[2:0]; // extract
  /* ../../vhdl/rtl/control_unit_ea.vhd:131:42  */
  assign n230 = n228 == 3'b110;
  /* ../../vhdl/rtl/control_unit_ea.vhd:131:62  */
  assign n231 = data_ir_i[2:0]; // extract
  /* ../../vhdl/rtl/control_unit_ea.vhd:131:75  */
  assign n233 = n231 == 3'b101;
  /* ../../vhdl/rtl/control_unit_ea.vhd:131:50  */
  assign n234 = n230 | n233;
  /* ../../vhdl/rtl/control_unit_ea.vhd:131:17  */
  assign n237 = n234 ? 1'b1 : 1'b0;
  /* ../../vhdl/rtl/control_unit_ea.vhd:126:13  */
  assign n239 = n226 ? 3'b000 : n227;
  /* ../../vhdl/rtl/control_unit_ea.vhd:126:13  */
  assign n242 = n226 ? 1'b1 : 1'b0;
  /* ../../vhdl/rtl/control_unit_ea.vhd:126:13  */
  assign n245 = n226 ? 1'b0 : 1'b1;
  /* ../../vhdl/rtl/control_unit_ea.vhd:126:13  */
  assign n247 = n226 ? 1'b0 : n237;
  /* ../../vhdl/rtl/control_unit_ea.vhd:137:17  */
  assign n249 = opcode == 3'b000;
  /* ../../vhdl/rtl/control_unit_ea.vhd:139:17  */
  assign n251 = opcode == 3'b001;
  /* ../../vhdl/rtl/control_unit_ea.vhd:141:17  */
  assign n253 = opcode == 3'b010;
  /* ../../vhdl/rtl/control_unit_ea.vhd:143:17  */
  assign n255 = opcode == 3'b011;
  /* ../../vhdl/rtl/control_unit_ea.vhd:145:17  */
  assign n257 = opcode == 3'b100;
  /* ../../vhdl/rtl/control_unit_ea.vhd:147:17  */
  assign n259 = opcode == 3'b101;
  /* ../../vhdl/rtl/control_unit_ea.vhd:149:17  */
  assign n261 = opcode == 3'b110;
  /* ../../vhdl/rtl/control_unit_ea.vhd:151:17  */
  assign n263 = opcode == 3'b111;
  assign n264 = {n263, n261, n259, n257, n255, n253, n251, n249};
  /* ../../vhdl/rtl/control_unit_ea.vhd:136:13  */
  always @*
    case (n264)
      8'b10000000: n268 = 1'b0;
      8'b01000000: n268 = 1'b0;
      8'b00100000: n268 = 1'b0;
      8'b00010000: n268 = 1'b0;
      8'b00001000: n268 = 1'b0;
      8'b00000100: n268 = 1'b0;
      8'b00000010: n268 = 1'b0;
      8'b00000001: n268 = 1'b1;
      default: n268 = 1'b0;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:136:13  */
  always @*
    case (n264)
      8'b10000000: n272 = 1'b0;
      8'b01000000: n272 = 1'b0;
      8'b00100000: n272 = 1'b0;
      8'b00010000: n272 = 1'b0;
      8'b00001000: n272 = 1'b0;
      8'b00000100: n272 = 1'b0;
      8'b00000010: n272 = 1'b1;
      8'b00000001: n272 = 1'b0;
      default: n272 = 1'b0;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:136:13  */
  always @*
    case (n264)
      8'b10000000: n276 = 1'b0;
      8'b01000000: n276 = 1'b0;
      8'b00100000: n276 = 1'b0;
      8'b00010000: n276 = 1'b0;
      8'b00001000: n276 = 1'b0;
      8'b00000100: n276 = 1'b1;
      8'b00000010: n276 = 1'b0;
      8'b00000001: n276 = 1'b0;
      default: n276 = 1'b0;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:136:13  */
  always @*
    case (n264)
      8'b10000000: n280 = 1'b0;
      8'b01000000: n280 = 1'b0;
      8'b00100000: n280 = 1'b0;
      8'b00010000: n280 = 1'b0;
      8'b00001000: n280 = 1'b1;
      8'b00000100: n280 = 1'b0;
      8'b00000010: n280 = 1'b0;
      8'b00000001: n280 = 1'b0;
      default: n280 = 1'b0;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:136:13  */
  always @*
    case (n264)
      8'b10000000: n284 = 1'b0;
      8'b01000000: n284 = 1'b0;
      8'b00100000: n284 = 1'b0;
      8'b00010000: n284 = 1'b1;
      8'b00001000: n284 = 1'b0;
      8'b00000100: n284 = 1'b0;
      8'b00000010: n284 = 1'b0;
      8'b00000001: n284 = 1'b0;
      default: n284 = 1'b0;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:136:13  */
  always @*
    case (n264)
      8'b10000000: n288 = 1'b0;
      8'b01000000: n288 = 1'b0;
      8'b00100000: n288 = 1'b1;
      8'b00010000: n288 = 1'b0;
      8'b00001000: n288 = 1'b0;
      8'b00000100: n288 = 1'b0;
      8'b00000010: n288 = 1'b0;
      8'b00000001: n288 = 1'b0;
      default: n288 = 1'b0;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:136:13  */
  always @*
    case (n264)
      8'b10000000: n292 = 1'b0;
      8'b01000000: n292 = 1'b1;
      8'b00100000: n292 = 1'b0;
      8'b00010000: n292 = 1'b0;
      8'b00001000: n292 = 1'b0;
      8'b00000100: n292 = 1'b0;
      8'b00000010: n292 = 1'b0;
      8'b00000001: n292 = 1'b0;
      default: n292 = 1'b0;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:136:13  */
  always @*
    case (n264)
      8'b10000000: n296 = 1'b1;
      8'b01000000: n296 = 1'b0;
      8'b00100000: n296 = 1'b0;
      8'b00010000: n296 = 1'b0;
      8'b00001000: n296 = 1'b0;
      8'b00000100: n296 = 1'b0;
      8'b00000010: n296 = 1'b0;
      8'b00000001: n296 = 1'b0;
      default: n296 = 1'b0;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:125:9  */
  assign n298 = n223 ? n239 : 3'b000;
  /* ../../vhdl/rtl/control_unit_ea.vhd:125:9  */
  assign n301 = n223 ? n242 : 1'b0;
  /* ../../vhdl/rtl/control_unit_ea.vhd:125:9  */
  assign n304 = n223 ? n245 : 1'b0;
  /* ../../vhdl/rtl/control_unit_ea.vhd:125:9  */
  assign n307 = n223 ? n247 : 1'b0;
  /* ../../vhdl/rtl/control_unit_ea.vhd:125:9  */
  assign n310 = n223 ? 1'b0 : n268;
  /* ../../vhdl/rtl/control_unit_ea.vhd:125:9  */
  assign n313 = n223 ? 1'b0 : n272;
  /* ../../vhdl/rtl/control_unit_ea.vhd:125:9  */
  assign n316 = n223 ? 1'b0 : n276;
  /* ../../vhdl/rtl/control_unit_ea.vhd:125:9  */
  assign n319 = n223 ? 1'b0 : n280;
  /* ../../vhdl/rtl/control_unit_ea.vhd:125:9  */
  assign n322 = n223 ? 1'b0 : n284;
  /* ../../vhdl/rtl/control_unit_ea.vhd:125:9  */
  assign n325 = n223 ? 1'b0 : n288;
  /* ../../vhdl/rtl/control_unit_ea.vhd:125:9  */
  assign n328 = n223 ? 1'b0 : n292;
  /* ../../vhdl/rtl/control_unit_ea.vhd:125:9  */
  assign n331 = n223 ? 1'b0 : n296;
  /* ../../vhdl/rtl/control_unit_ea.vhd:173:17  */
  assign n337 = bl_programm_i ? 3'b001 : 3'b010;
  /* ../../vhdl/rtl/control_unit_ea.vhd:172:13  */
  assign n339 = cu_state == 3'b000;
  /* ../../vhdl/rtl/control_unit_ea.vhd:180:17  */
  assign n341 = bl_programm_i ? cu_state : 3'b010;
  /* ../../vhdl/rtl/control_unit_ea.vhd:179:13  */
  assign n343 = cu_state == 3'b001;
  /* ../../vhdl/rtl/control_unit_ea.vhd:186:13  */
  assign n345 = cu_state == 3'b010;
  /* ../../vhdl/rtl/control_unit_ea.vhd:197:17  */
  assign n348 = alu_instr ? 3'b101 : 3'b110;
  /* ../../vhdl/rtl/control_unit_ea.vhd:194:17  */
  assign n350 = operand_instr ? 3'b100 : n348;
  /* ../../vhdl/rtl/control_unit_ea.vhd:191:17  */
  assign n352 = nop_instr ? 3'b010 : n350;
  /* ../../vhdl/rtl/control_unit_ea.vhd:190:13  */
  assign n354 = cu_state == 3'b011;
  /* ../../vhdl/rtl/control_unit_ea.vhd:206:17  */
  assign n357 = alu_instr ? 3'b101 : 3'b110;
  /* ../../vhdl/rtl/control_unit_ea.vhd:205:13  */
  assign n359 = cu_state == 3'b100;
  /* ../../vhdl/rtl/control_unit_ea.vhd:215:17  */
  assign n362 = bl_programm_i ? 3'b001 : 3'b010;
  /* ../../vhdl/rtl/control_unit_ea.vhd:214:13  */
  assign n364 = cu_state == 3'b101;
  /* ../../vhdl/rtl/control_unit_ea.vhd:224:17  */
  assign n367 = bl_programm_i ? 3'b001 : 3'b010;
  /* ../../vhdl/rtl/control_unit_ea.vhd:223:13  */
  assign n369 = cu_state == 3'b110;
  assign n370 = {n369, n364, n359, n354, n345, n343, n339};
  /* ../../vhdl/rtl/control_unit_ea.vhd:171:9  */
  always @*
    case (n370)
      7'b1000000: n373 = n367;
      7'b0100000: n373 = n362;
      7'b0010000: n373 = n357;
      7'b0001000: n373 = n352;
      7'b0000100: n373 = 3'b011;
      7'b0000010: n373 = n341;
      7'b0000001: n373 = n337;
      default: n373 = 3'bX;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:260:21  */
  assign n378 = cu_state == 3'b010;
  /* ../../vhdl/rtl/control_unit_ea.vhd:260:45  */
  assign n380 = cu_state == 3'b100;
  /* ../../vhdl/rtl/control_unit_ea.vhd:260:33  */
  assign n381 = n378 | n380;
  /* ../../vhdl/rtl/control_unit_ea.vhd:261:83  */
  assign n383 = programm_counter + 4'b0001;
  /* ../../vhdl/rtl/control_unit_ea.vhd:260:9  */
  assign n384 = n381 ? n383 : programm_counter;
  /* ../../vhdl/rtl/control_unit_ea.vhd:268:13  */
  assign n386 = cu_state == 3'b001;
  /* ../../vhdl/rtl/control_unit_ea.vhd:274:13  */
  assign n388 = cu_state == 3'b010;
  /* ../../vhdl/rtl/control_unit_ea.vhd:284:13  */
  assign n390 = cu_state == 3'b100;
  /* ../../vhdl/rtl/control_unit_ea.vhd:297:17  */
  assign n393 = inc_dec_instr ? 1'b0 : 1'b1;
  /* ../../vhdl/rtl/control_unit_ea.vhd:297:17  */
  assign n395 = inc_dec_instr ? 4'b0000 : data_opnd_i;
  /* ../../vhdl/rtl/control_unit_ea.vhd:297:17  */
  assign n397 = inc_dec_instr ? 4'b0001 : read_data_mem_i;
  /* ../../vhdl/rtl/control_unit_ea.vhd:294:13  */
  assign n399 = cu_state == 3'b101;
  /* ../../vhdl/rtl/control_unit_ea.vhd:318:21  */
  assign n400 = z_flag ? data_opnd_i : n384;
  /* ../../vhdl/rtl/control_unit_ea.vhd:322:17  */
  assign n401 = n469 ? data_opnd_i : n384;
  /* ../../vhdl/rtl/control_unit_ea.vhd:357:17  */
  assign n404 = ldi_instr ? 1'b1 : 1'b0;
  /* ../../vhdl/rtl/control_unit_ea.vhd:357:17  */
  assign n406 = ldi_instr ? data_opnd_i : 4'b0000;
  /* ../../vhdl/rtl/control_unit_ea.vhd:351:17  */
  assign n408 = out_instr ? 1'b0 : n404;
  /* ../../vhdl/rtl/control_unit_ea.vhd:351:17  */
  assign n410 = out_instr ? 4'b0000 : n406;
  /* ../../vhdl/rtl/control_unit_ea.vhd:351:17  */
  assign n413 = out_instr ? 1'b1 : 1'b0;
  /* ../../vhdl/rtl/control_unit_ea.vhd:351:17  */
  assign n415 = out_instr ? data_a_i : 4'b0000;
  /* ../../vhdl/rtl/control_unit_ea.vhd:345:17  */
  assign n417 = in_instr ? 1'b1 : n408;
  /* ../../vhdl/rtl/control_unit_ea.vhd:345:17  */
  assign n418 = in_instr ? data_in_i : n410;
  /* ../../vhdl/rtl/control_unit_ea.vhd:345:17  */
  assign n420 = in_instr ? 1'b0 : n413;
  /* ../../vhdl/rtl/control_unit_ea.vhd:345:17  */
  assign n422 = in_instr ? 4'b0000 : n415;
  /* ../../vhdl/rtl/control_unit_ea.vhd:337:17  */
  assign n425 = st_instr ? 1'b1 : 1'b0;
  /* ../../vhdl/rtl/control_unit_ea.vhd:337:17  */
  assign n427 = st_instr ? data_opnd_i : 4'b0000;
  /* ../../vhdl/rtl/control_unit_ea.vhd:337:17  */
  assign n429 = st_instr ? data_a_i : 4'b0000;
  /* ../../vhdl/rtl/control_unit_ea.vhd:337:17  */
  assign n431 = st_instr ? 1'b0 : n417;
  /* ../../vhdl/rtl/control_unit_ea.vhd:337:17  */
  assign n433 = st_instr ? 4'b0000 : n418;
  /* ../../vhdl/rtl/control_unit_ea.vhd:337:17  */
  assign n435 = st_instr ? 1'b0 : n420;
  /* ../../vhdl/rtl/control_unit_ea.vhd:337:17  */
  assign n437 = st_instr ? 4'b0000 : n422;
  /* ../../vhdl/rtl/control_unit_ea.vhd:327:17  */
  assign n440 = ld_instr ? 1'b1 : 1'b0;
  /* ../../vhdl/rtl/control_unit_ea.vhd:327:17  */
  assign n442 = ld_instr ? 1'b0 : n425;
  /* ../../vhdl/rtl/control_unit_ea.vhd:327:17  */
  assign n443 = ld_instr ? data_opnd_i : n427;
  /* ../../vhdl/rtl/control_unit_ea.vhd:327:17  */
  assign n445 = ld_instr ? 4'b0000 : n429;
  /* ../../vhdl/rtl/control_unit_ea.vhd:327:17  */
  assign n447 = ld_instr ? 1'b1 : n431;
  /* ../../vhdl/rtl/control_unit_ea.vhd:327:17  */
  assign n448 = ld_instr ? read_data_mem_i : n433;
  /* ../../vhdl/rtl/control_unit_ea.vhd:327:17  */
  assign n450 = ld_instr ? 1'b0 : n435;
  /* ../../vhdl/rtl/control_unit_ea.vhd:327:17  */
  assign n452 = ld_instr ? 4'b0000 : n437;
  /* ../../vhdl/rtl/control_unit_ea.vhd:322:17  */
  assign n454 = jc_instr ? 1'b0 : n440;
  /* ../../vhdl/rtl/control_unit_ea.vhd:322:17  */
  assign n456 = jc_instr ? 1'b0 : n442;
  /* ../../vhdl/rtl/control_unit_ea.vhd:322:17  */
  assign n458 = jc_instr ? 4'b0000 : n443;
  /* ../../vhdl/rtl/control_unit_ea.vhd:322:17  */
  assign n460 = jc_instr ? 4'b0000 : n445;
  /* ../../vhdl/rtl/control_unit_ea.vhd:322:17  */
  assign n462 = jc_instr ? 1'b0 : n447;
  /* ../../vhdl/rtl/control_unit_ea.vhd:322:17  */
  assign n464 = jc_instr ? 4'b0000 : n448;
  /* ../../vhdl/rtl/control_unit_ea.vhd:322:17  */
  assign n466 = jc_instr ? 1'b0 : n450;
  /* ../../vhdl/rtl/control_unit_ea.vhd:322:17  */
  assign n468 = jc_instr ? 4'b0000 : n452;
  /* ../../vhdl/rtl/control_unit_ea.vhd:322:17  */
  assign n469 = c_flag & jc_instr;
  /* ../../vhdl/rtl/control_unit_ea.vhd:317:17  */
  assign n471 = jz_instr ? 1'b0 : n454;
  /* ../../vhdl/rtl/control_unit_ea.vhd:317:17  */
  assign n473 = jz_instr ? 1'b0 : n456;
  /* ../../vhdl/rtl/control_unit_ea.vhd:317:17  */
  assign n475 = jz_instr ? 4'b0000 : n458;
  /* ../../vhdl/rtl/control_unit_ea.vhd:317:17  */
  assign n477 = jz_instr ? 4'b0000 : n460;
  /* ../../vhdl/rtl/control_unit_ea.vhd:317:17  */
  assign n479 = jz_instr ? 1'b0 : n462;
  /* ../../vhdl/rtl/control_unit_ea.vhd:317:17  */
  assign n481 = jz_instr ? 4'b0000 : n464;
  /* ../../vhdl/rtl/control_unit_ea.vhd:317:17  */
  assign n483 = jz_instr ? 1'b0 : n466;
  /* ../../vhdl/rtl/control_unit_ea.vhd:317:17  */
  assign n485 = jz_instr ? 4'b0000 : n468;
  /* ../../vhdl/rtl/control_unit_ea.vhd:317:17  */
  assign n486 = jz_instr ? n400 : n401;
  /* ../../vhdl/rtl/control_unit_ea.vhd:314:17  */
  assign n488 = jmp_instr ? 1'b0 : n471;
  /* ../../vhdl/rtl/control_unit_ea.vhd:314:17  */
  assign n490 = jmp_instr ? 1'b0 : n473;
  /* ../../vhdl/rtl/control_unit_ea.vhd:314:17  */
  assign n492 = jmp_instr ? 4'b0000 : n475;
  /* ../../vhdl/rtl/control_unit_ea.vhd:314:17  */
  assign n494 = jmp_instr ? 4'b0000 : n477;
  /* ../../vhdl/rtl/control_unit_ea.vhd:314:17  */
  assign n496 = jmp_instr ? 1'b0 : n479;
  /* ../../vhdl/rtl/control_unit_ea.vhd:314:17  */
  assign n498 = jmp_instr ? 4'b0000 : n481;
  /* ../../vhdl/rtl/control_unit_ea.vhd:314:17  */
  assign n500 = jmp_instr ? 1'b0 : n483;
  /* ../../vhdl/rtl/control_unit_ea.vhd:314:17  */
  assign n502 = jmp_instr ? 4'b0000 : n485;
  /* ../../vhdl/rtl/control_unit_ea.vhd:314:17  */
  assign n503 = jmp_instr ? data_opnd_i : n486;
  /* ../../vhdl/rtl/control_unit_ea.vhd:313:13  */
  assign n505 = cu_state == 3'b110;
  assign n506 = {n505, n399, n390, n388, n386};
  /* ../../vhdl/rtl/control_unit_ea.vhd:267:9  */
  always @*
    case (n506)
      5'b10000: n511 = n488;
      5'b01000: n511 = n393;
      5'b00100: n511 = 1'b1;
      5'b00010: n511 = 1'b1;
      5'b00001: n511 = 1'b0;
      default: n511 = 1'b0;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:267:9  */
  always @*
    case (n506)
      5'b10000: n515 = n490;
      5'b01000: n515 = 1'b0;
      5'b00100: n515 = 1'b0;
      5'b00010: n515 = 1'b0;
      5'b00001: n515 = bl_write_en_mem_i;
      default: n515 = 1'b0;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:267:9  */
  always @*
    case (n506)
      5'b10000: n518 = n492;
      5'b01000: n518 = n395;
      5'b00100: n518 = programm_counter;
      5'b00010: n518 = programm_counter;
      5'b00001: n518 = bl_address_i;
      default: n518 = 4'b0000;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:267:9  */
  always @*
    case (n506)
      5'b10000: n522 = n494;
      5'b01000: n522 = 4'b0000;
      5'b00100: n522 = 4'b0000;
      5'b00010: n522 = 4'b0000;
      5'b00001: n522 = bl_data_i;
      default: n522 = 4'b0000;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:267:9  */
  always @*
    case (n506)
      5'b10000: n527 = 1'b0;
      5'b01000: n527 = 1'b0;
      5'b00100: n527 = 1'b0;
      5'b00010: n527 = 1'b1;
      5'b00001: n527 = 1'b0;
      default: n527 = 1'b0;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:267:9  */
  always @*
    case (n506)
      5'b10000: n531 = 4'b0000;
      5'b01000: n531 = 4'b0000;
      5'b00100: n531 = 4'b0000;
      5'b00010: n531 = read_data_mem_i;
      5'b00001: n531 = 4'b0000;
      default: n531 = 4'b0000;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:267:9  */
  always @*
    case (n506)
      5'b10000: n536 = n496;
      5'b01000: n536 = 1'b1;
      5'b00100: n536 = 1'b0;
      5'b00010: n536 = 1'b0;
      5'b00001: n536 = 1'b0;
      default: n536 = 1'b0;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:267:9  */
  always @*
    case (n506)
      5'b10000: n540 = n498;
      5'b01000: n540 = result_alu_i;
      5'b00100: n540 = 4'b0000;
      5'b00010: n540 = 4'b0000;
      5'b00001: n540 = 4'b0000;
      default: n540 = 4'b0000;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:267:9  */
  always @*
    case (n506)
      5'b10000: n545 = 1'b0;
      5'b01000: n545 = 1'b0;
      5'b00100: n545 = 1'b1;
      5'b00010: n545 = 1'b0;
      5'b00001: n545 = 1'b0;
      default: n545 = 1'b0;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:267:9  */
  always @*
    case (n506)
      5'b10000: n549 = 4'b0000;
      5'b01000: n549 = 4'b0000;
      5'b00100: n549 = read_data_mem_i;
      5'b00010: n549 = 4'b0000;
      5'b00001: n549 = 4'b0000;
      default: n549 = 4'b0000;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:267:9  */
  always @*
    case (n506)
      5'b10000: n553 = 1'b1;
      5'b01000: n553 = 1'b1;
      5'b00100: n553 = 1'b1;
      5'b00010: n553 = 1'b1;
      5'b00001: n553 = 1'b1;
      default: n553 = 1'b1;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:267:9  */
  always @*
    case (n506)
      5'b10000: n557 = n500;
      5'b01000: n557 = 1'b0;
      5'b00100: n557 = 1'b0;
      5'b00010: n557 = 1'b0;
      5'b00001: n557 = 1'b0;
      default: n557 = 1'b0;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:267:9  */
  always @*
    case (n506)
      5'b10000: n561 = n502;
      5'b01000: n561 = 4'b0000;
      5'b00100: n561 = 4'b0000;
      5'b00010: n561 = 4'b0000;
      5'b00001: n561 = 4'b0000;
      default: n561 = 4'b0000;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:267:9  */
  always @*
    case (n506)
      5'b10000: n565 = 4'b0000;
      5'b01000: n565 = data_a_i;
      5'b00100: n565 = 4'b0000;
      5'b00010: n565 = 4'b0000;
      5'b00001: n565 = 4'b0000;
      default: n565 = 4'b0000;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:267:9  */
  always @*
    case (n506)
      5'b10000: n569 = 4'b0000;
      5'b01000: n569 = n397;
      5'b00100: n569 = 4'b0000;
      5'b00010: n569 = 4'b0000;
      5'b00001: n569 = 4'b0000;
      default: n569 = 4'b0000;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:267:9  */
  always @*
    case (n506)
      5'b10000: n571 = n503;
      5'b01000: n571 = n384;
      5'b00100: n571 = n384;
      5'b00010: n571 = n384;
      5'b00001: n571 = n384;
      default: n571 = n384;
    endcase
  /* ../../vhdl/rtl/control_unit_ea.vhd:394:21  */
  assign n575 = cu_state == 3'b101;
  /* ../../vhdl/rtl/control_unit_ea.vhd:394:9  */
  assign n576 = n575 ? carry_alu_i : c_flag;
  /* ../../vhdl/rtl/control_unit_ea.vhd:404:21  */
  assign n580 = cu_state == 3'b101;
  /* ../../vhdl/rtl/control_unit_ea.vhd:405:29  */
  assign n582 = result_alu_i == 4'b0000;
  /* ../../vhdl/rtl/control_unit_ea.vhd:405:13  */
  assign n585 = n582 ? 1'b1 : 1'b0;
  /* ../../vhdl/rtl/control_unit_ea.vhd:404:9  */
  assign n586 = n580 ? n585 : z_flag;
  /* ../../vhdl/rtl/control_unit_ea.vhd:420:9  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n603 <= 3'b000;
    else
      n603 <= next_cu_state;
  /* ../../vhdl/rtl/control_unit_ea.vhd:420:9  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n604 <= 4'b0000;
    else
      n604 <= next_programm_counter;
  /* ../../vhdl/rtl/control_unit_ea.vhd:420:9  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n605 <= 1'b0;
    else
      n605 <= next_z_flag;
  /* ../../vhdl/rtl/control_unit_ea.vhd:420:9  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n606 <= 1'b0;
    else
      n606 <= next_c_flag;
endmodule

module alu_4_3
  (input  [3:0] a_i,
   input  [3:0] b_i,
   input  [2:0] oc_i,
   output [3:0] result_o,
   output carry_o);
  wire [3:0] b_as;
  wire as;
  wire [3:0] sum;
  wire [3:0] xor_result;
  wire [3:0] and_result;
  wire [3:0] or_result;
  wire n165;
  wire n166;
  wire [3:0] n167;
  wire [3:0] n168;
  wire [3:0] n169;
  wire [3:0] n170;
  wire [3:0] n171;
  wire \cra.carry_o ;
  wire n175;
  wire [1:0] n176;
  wire n178;
  wire [3:0] n180;
  wire [1:0] n181;
  wire n183;
  wire [3:0] n184;
  wire [1:0] n185;
  wire n187;
  wire [3:0] n188;
  wire [3:0] n189;
  assign result_o = n189; //(module output)
  assign carry_o = \cra.carry_o ; //(module output)
  /* ../../vhdl/rtl/alu_ea.vhd:24:12  */
  assign b_as = n167; // (signal)
  /* ../../vhdl/rtl/alu_ea.vhd:25:12  */
  assign as = n165; // (signal)
  /* ../../vhdl/rtl/alu_ea.vhd:28:12  */
  assign xor_result = n169; // (signal)
  /* ../../vhdl/rtl/alu_ea.vhd:29:12  */
  assign and_result = n170; // (signal)
  /* ../../vhdl/rtl/alu_ea.vhd:30:12  */
  assign or_result = n171; // (signal)
  /* ../../vhdl/rtl/alu_ea.vhd:35:15  */
  assign n165 = oc_i[1]; // extract
  /* ../../vhdl/rtl/alu_ea.vhd:36:25  */
  assign n166 = ~as;
  /* ../../vhdl/rtl/alu_ea.vhd:36:17  */
  assign n167 = n166 ? b_i : n168;
  /* ../../vhdl/rtl/alu_ea.vhd:36:36  */
  assign n168 = ~b_i;
  /* ../../vhdl/rtl/alu_ea.vhd:40:23  */
  assign n169 = a_i ^ b_i;
  /* ../../vhdl/rtl/alu_ea.vhd:42:23  */
  assign n170 = a_i & b_i;
  /* ../../vhdl/rtl/alu_ea.vhd:44:22  */
  assign n171 = a_i | b_i;
  /* ../../vhdl/rtl/alu_ea.vhd:47:5  */
  carry_ripple_adder_4 cra (
    .a_i(a_i),
    .b_i(b_as),
    .carry_i(as),
    .sum_o(sum),
    .carry_o(\cra.carry_o ));
  /* ../../vhdl/rtl/alu_ea.vhd:67:16  */
  assign n175 = oc_i[2]; // extract
  /* ../../vhdl/rtl/alu_ea.vhd:70:20  */
  assign n176 = oc_i[1:0]; // extract
  /* ../../vhdl/rtl/alu_ea.vhd:70:33  */
  assign n178 = n176 == 2'b01;
  /* ../../vhdl/rtl/alu_ea.vhd:70:13  */
  assign n180 = n178 ? xor_result : 4'bZ;
  /* ../../vhdl/rtl/alu_ea.vhd:73:20  */
  assign n181 = oc_i[1:0]; // extract
  /* ../../vhdl/rtl/alu_ea.vhd:73:33  */
  assign n183 = n181 == 2'b10;
  /* ../../vhdl/rtl/alu_ea.vhd:73:13  */
  assign n184 = n183 ? and_result : n180;
  /* ../../vhdl/rtl/alu_ea.vhd:76:20  */
  assign n185 = oc_i[1:0]; // extract
  /* ../../vhdl/rtl/alu_ea.vhd:76:33  */
  assign n187 = n185 == 2'b11;
  /* ../../vhdl/rtl/alu_ea.vhd:76:13  */
  assign n188 = n187 ? or_result : n184;
  /* ../../vhdl/rtl/alu_ea.vhd:67:9  */
  assign n189 = n175 ? sum : n188;
endmodule

module reg_memory_16_4_4
  (input  clk_i,
   input  reset_i,
   input  read_en_i,
   input  write_en_i,
   input  [3:0] addr_i,
   input  [3:0] data_i,
   output [3:0] data_o);
  wire [63:0] reg_vals;
  wire [63:0] next_reg_vals;
  wire [3:0] n42;
  wire [63:0] n45;
  wire [3:0] n50;
  wire [3:0] n70;
  wire [3:0] n71;
  wire [3:0] n72;
  wire [3:0] n73;
  wire [3:0] n74;
  wire [3:0] n75;
  wire [3:0] n76;
  wire [3:0] n77;
  wire [3:0] n78;
  wire [3:0] n79;
  wire [3:0] n80;
  wire [3:0] n81;
  wire [3:0] n82;
  wire [3:0] n83;
  wire [3:0] n84;
  wire [3:0] n85;
  wire [63:0] n86;
  wire [63:0] n88;
  reg [63:0] n91;
  wire [3:0] n92;
  wire n93;
  wire n94;
  wire n95;
  wire n96;
  wire n97;
  wire n98;
  wire n99;
  wire n100;
  wire n101;
  wire n102;
  wire n103;
  wire n104;
  wire n105;
  wire n106;
  wire n107;
  wire n108;
  wire n109;
  wire n110;
  wire n111;
  wire n112;
  wire n113;
  wire n114;
  wire n115;
  wire n116;
  wire n117;
  wire n118;
  wire n119;
  wire n120;
  wire n121;
  wire n122;
  wire n123;
  wire n124;
  wire n125;
  wire n126;
  wire n127;
  wire n128;
  wire [3:0] n129;
  wire [3:0] n130;
  wire [3:0] n131;
  wire [3:0] n132;
  wire [3:0] n133;
  wire [3:0] n134;
  wire [3:0] n135;
  wire [3:0] n136;
  wire [3:0] n137;
  wire [3:0] n138;
  wire [3:0] n139;
  wire [3:0] n140;
  wire [3:0] n141;
  wire [3:0] n142;
  wire [3:0] n143;
  wire [3:0] n144;
  wire [3:0] n145;
  wire [3:0] n146;
  wire [3:0] n147;
  wire [3:0] n148;
  wire [3:0] n149;
  wire [3:0] n150;
  wire [3:0] n151;
  wire [3:0] n152;
  wire [3:0] n153;
  wire [3:0] n154;
  wire [3:0] n155;
  wire [3:0] n156;
  wire [3:0] n157;
  wire [3:0] n158;
  wire [3:0] n159;
  wire [3:0] n160;
  wire [63:0] n161;
  wire [3:0] n162;
  assign data_o = n92; //(module output)
  /* ../../vhdl/rtl/reg_memory_ea.vhd:46:12  */
  assign reg_vals = n91; // (signal)
  /* ../../vhdl/rtl/reg_memory_ea.vhd:47:12  */
  assign next_reg_vals = n45; // (signal)
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:27  */
  assign n42 = 4'b1111 - addr_i;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:59:9  */
  assign n45 = write_en_i ? n161 : reg_vals;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:68:32  */
  assign n50 = 4'b1111 - addr_i;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:99:45  */
  assign n70 = next_reg_vals[63:60]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:99:45  */
  assign n71 = next_reg_vals[59:56]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:99:45  */
  assign n72 = next_reg_vals[55:52]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:99:45  */
  assign n73 = next_reg_vals[51:48]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:99:45  */
  assign n74 = next_reg_vals[47:44]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:99:45  */
  assign n75 = next_reg_vals[43:40]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:99:45  */
  assign n76 = next_reg_vals[39:36]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:99:45  */
  assign n77 = next_reg_vals[35:32]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:99:45  */
  assign n78 = next_reg_vals[31:28]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:99:45  */
  assign n79 = next_reg_vals[27:24]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:99:45  */
  assign n80 = next_reg_vals[23:20]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:99:45  */
  assign n81 = next_reg_vals[19:16]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:99:45  */
  assign n82 = next_reg_vals[15:12]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:99:45  */
  assign n83 = next_reg_vals[11:8]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:99:45  */
  assign n84 = next_reg_vals[7:4]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:99:45  */
  assign n85 = next_reg_vals[3:0]; // extract
  assign n86 = {n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85};
  assign n88 = {4'b1110, 4'b0101, 4'b1010, 4'b0111, 4'b1000, 4'b0000, 4'b1110, 4'b0110, 4'b1001, 4'b0000, 4'b1000, 4'b0110, 4'b0000, 4'b0000, 4'b0000, 4'b0000};
  /* ../../vhdl/rtl/reg_memory_ea.vhd:97:9  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n91 <= n88;
    else
      n91 <= n86;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:67:9  */
  assign n92 = read_en_i ? n162 : 4'bz;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n93 = n42[3]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n94 = ~n93;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n95 = n42[2]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n96 = ~n95;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n97 = n94 & n96;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n98 = n94 & n95;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n99 = n93 & n96;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n100 = n93 & n95;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n101 = n42[1]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n102 = ~n101;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n103 = n97 & n102;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n104 = n97 & n101;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n105 = n98 & n102;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n106 = n98 & n101;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n107 = n99 & n102;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n108 = n99 & n101;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n109 = n100 & n102;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n110 = n100 & n101;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n111 = n42[0]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n112 = ~n111;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n113 = n103 & n112;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n114 = n103 & n111;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n115 = n104 & n112;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n116 = n104 & n111;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n117 = n105 & n112;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n118 = n105 & n111;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n119 = n106 & n112;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n120 = n106 & n111;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n121 = n107 & n112;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n122 = n107 & n111;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n123 = n108 & n112;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n124 = n108 & n111;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n125 = n109 & n112;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n126 = n109 & n111;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n127 = n110 & n112;
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n128 = n110 & n111;
  assign n129 = reg_vals[3:0]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n130 = n113 ? data_i : n129;
  assign n131 = reg_vals[7:4]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n132 = n114 ? data_i : n131;
  assign n133 = reg_vals[11:8]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n134 = n115 ? data_i : n133;
  assign n135 = reg_vals[15:12]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n136 = n116 ? data_i : n135;
  assign n137 = reg_vals[19:16]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n138 = n117 ? data_i : n137;
  assign n139 = reg_vals[23:20]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n140 = n118 ? data_i : n139;
  assign n141 = reg_vals[27:24]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n142 = n119 ? data_i : n141;
  assign n143 = reg_vals[31:28]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n144 = n120 ? data_i : n143;
  assign n145 = reg_vals[35:32]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n146 = n121 ? data_i : n145;
  assign n147 = reg_vals[39:36]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n148 = n122 ? data_i : n147;
  assign n149 = reg_vals[43:40]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n150 = n123 ? data_i : n149;
  assign n151 = reg_vals[47:44]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n152 = n124 ? data_i : n151;
  assign n153 = reg_vals[51:48]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n154 = n125 ? data_i : n153;
  assign n155 = reg_vals[55:52]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n156 = n126 ? data_i : n155;
  assign n157 = reg_vals[59:56]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n158 = n127 ? data_i : n157;
  assign n159 = reg_vals[63:60]; // extract
  /* ../../vhdl/rtl/reg_memory_ea.vhd:60:13  */
  assign n160 = n128 ? data_i : n159;
  assign n161 = {n160, n158, n156, n154, n152, n150, n148, n146, n144, n142, n140, n138, n136, n134, n132, n130};
  /* ../../vhdl/rtl/reg_memory_ea.vhd:68:32  */
  assign n162 = reg_vals[n50 * 4 +: 4]; //(Bmux)
endmodule

module my_register_4
  (input  clk_i,
   input  reset_i,
   input  write_en_i,
   input  [3:0] in_i,
   output [3:0] out_o);
  wire [3:0] reg_val;
  wire [3:0] next_reg_val;
  wire [3:0] n29;
  reg [3:0] n37;
  assign out_o = reg_val; //(module output)
  /* ../../vhdl/rtl/my_register_ea.vhd:22:12  */
  assign reg_val = n37; // (signal)
  /* ../../vhdl/rtl/my_register_ea.vhd:23:12  */
  assign next_reg_val = n29; // (signal)
  /* ../../vhdl/rtl/my_register_ea.vhd:35:9  */
  assign n29 = write_en_i ? in_i : reg_val;
  /* ../../vhdl/rtl/my_register_ea.vhd:47:9  */
  always @(posedge clk_i or posedge reset_i)
    if (reset_i)
      n37 <= 4'b0000;
    else
      n37 <= next_reg_val;
endmodule

module cpu_4_3_4_8_4_16
  (input  clk_i,
   input  reset_i,
   input  [3:0] in_pins_i,
   input  bl_programm_i,
   input  [3:0] bl_data_i,
   input  [3:0] bl_address_i,
   input  bl_write_en_mem_i,
   output [3:0] out_pins_o);
  wire write_en_a_cpu;
  wire [3:0] write_data_a_cpu;
  wire [3:0] data_a_cpu;
  wire write_en_ir_cpu;
  wire [3:0] write_data_ir_cpu;
  wire [3:0] data_ir_cpu;
  wire write_en_opnd_cpu;
  wire [3:0] write_data_opnd_cpu;
  wire [3:0] data_opnd_cpu;
  wire write_en_in_cpu;
  wire [3:0] write_data_in_cpu;
  wire [3:0] data_in_cpu;
  wire write_en_out_cpu;
  wire [3:0] write_data_out_cpu;
  wire [3:0] data_out_cpu;
  wire read_en_mem_cpu;
  wire write_en_mem_cpu;
  wire [3:0] addr_mem_cpu;
  wire [3:0] write_data_mem_cpu;
  wire [3:0] read_data_mem_cpu;
  wire [2:0] oc_alu_cpu;
  wire [3:0] a_alu_cpu;
  wire [3:0] b_alu_cpu;
  wire [3:0] result_alu_cpu;
  wire carry_alu_cpu;
  assign out_pins_o = data_out_cpu; //(module output)
  /* ../../vhdl/rtl/cpu_ea.vhd:57:12  */
  assign write_data_in_cpu = in_pins_i; // (signal)
  /* ../../vhdl/rtl/cpu_ea.vhd:95:5  */
  my_register_4 a_reg (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .write_en_i(write_en_a_cpu),
    .in_i(write_data_a_cpu),
    .out_o(data_a_cpu));
  /* ../../vhdl/rtl/cpu_ea.vhd:110:5  */
  my_register_4 ir_reg (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .write_en_i(write_en_ir_cpu),
    .in_i(write_data_ir_cpu),
    .out_o(data_ir_cpu));
  /* ../../vhdl/rtl/cpu_ea.vhd:125:5  */
  my_register_4 opnd_reg (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .write_en_i(write_en_opnd_cpu),
    .in_i(write_data_opnd_cpu),
    .out_o(data_opnd_cpu));
  /* ../../vhdl/rtl/cpu_ea.vhd:140:5  */
  my_register_4 out_reg (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .write_en_i(write_en_out_cpu),
    .in_i(write_data_out_cpu),
    .out_o(data_out_cpu));
  /* ../../vhdl/rtl/cpu_ea.vhd:155:5  */
  my_register_4 in_reg (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .write_en_i(write_en_in_cpu),
    .in_i(write_data_in_cpu),
    .out_o(data_in_cpu));
  /* ../../vhdl/rtl/cpu_ea.vhd:174:5  */
  reg_memory_16_4_4 memory (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .read_en_i(read_en_mem_cpu),
    .write_en_i(write_en_mem_cpu),
    .addr_i(addr_mem_cpu),
    .data_i(write_data_mem_cpu),
    .data_o(read_data_mem_cpu));
  /* ../../vhdl/rtl/cpu_ea.vhd:195:5  */
  alu_4_3 alu (
    .a_i(a_alu_cpu),
    .b_i(b_alu_cpu),
    .oc_i(oc_alu_cpu),
    .result_o(result_alu_cpu),
    .carry_o(carry_alu_cpu));
  /* ../../vhdl/rtl/cpu_ea.vhd:214:5  */
  control_unit_4_3_4_8_4 cu (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .read_data_mem_i(read_data_mem_cpu),
    .data_ir_i(data_ir_cpu),
    .data_a_i(data_a_cpu),
    .data_opnd_i(data_opnd_cpu),
    .data_in_i(data_in_cpu),
    .result_alu_i(result_alu_cpu),
    .carry_alu_i(carry_alu_cpu),
    .bl_programm_i(bl_programm_i),
    .bl_data_i(bl_data_i),
    .bl_address_i(bl_address_i),
    .bl_write_en_mem_i(bl_write_en_mem_i),
    .read_en_mem_o(read_en_mem_cpu),
    .write_en_mem_o(write_en_mem_cpu),
    .addr_mem_o(addr_mem_cpu),
    .write_data_mem_o(write_data_mem_cpu),
    .write_en_ir_o(write_en_ir_cpu),
    .write_data_ir_o(write_data_ir_cpu),
    .write_en_a_o(write_en_a_cpu),
    .write_data_a_o(write_data_a_cpu),
    .write_en_opnd_o(write_en_opnd_cpu),
    .write_data_opnd_o(write_data_opnd_cpu),
    .write_en_in_o(write_en_in_cpu),
    .write_en_out_o(write_en_out_cpu),
    .write_data_out_o(write_data_out_cpu),
    .oc_o(oc_alu_cpu),
    .a_o(a_alu_cpu),
    .b_o(b_alu_cpu));
endmodule

module four_bit_cpu_board
  (input  clk_i,
   input  reset_i,
   input  [3:0] in_pins_i,
   input  bl_programm_i,
   input  [3:0] bl_data_i,
   input  [3:0] bl_address_i,
   input  bl_write_en_mem_i,
   output [3:0] out_pins_o);
  wire [3:0] \cpu.out_pins_o ;
  assign out_pins_o = \cpu.out_pins_o ; //(module output)
  /* ../../vhdl/rtl/four_bit_cpu_board.vhd:67:5  */
  cpu_4_3_4_8_4_16 cpu (
    .clk_i(clk_i),
    .reset_i(reset_i),
    .in_pins_i(in_pins_i),
    .bl_programm_i(bl_programm_i),
    .bl_data_i(bl_data_i),
    .bl_address_i(bl_address_i),
    .bl_write_en_mem_i(bl_write_en_mem_i),
    .out_pins_o(\cpu.out_pins_o ));
endmodule

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

  // Map TinyTapeout ports to your design ports
  wire [3:0] in_pins   = ui_in[3:0];   // use lower 4 bits of ui_in
  wire       bl_programm = ui_in[4];   // example mapping
  wire [3:0] bl_data     = uio_in[3:0];
  wire [3:0] bl_address  = uio_in[7:4];
  wire       bl_we       = ui_in[5];   // write enable from ui_in[5]

  wire [3:0] cpu_out_pins;

    // Drive outputs back into TT signals
  assign uo_out[3:0] = cpu_out_pins; // map CPU outputs to lower 4 bits
  assign uo_out[7:4] = 4'b0000;      // unused

  assign uio_out = 8'b0;             // unused
  assign uio_oe  = 8'b00000000;      // all IOs are inputs unless needed
endmodule

