`include "Opcode.vh"

module PCSelect #(
    // params
)(
    input logic        ctrl_kill_X_i,
    input logic [6:0]  opcode_X_i,
    input logic [2:0]  func3_X_i,
    input logic [1:0]  pc_sel_ID_i,
    input logic        br_eq_i, br_lt_i,

    output logic [1:0] pc_sel_X_o,
    output logic [1:0] pc_select_o
);

    logic JAL_ID         = pc_sel_ID_i == 2'b01;
    logic opcode_branch  = opcode_X_i  == `OPC_BRANCH;
    logic opcode_jalr    = opcode_X_i  == `OPC_JALR;
    logic func3_beq      = func3_X_i   == `FNC_BEQ;
    logic func3_bne      = func3_X_i   == `FNC_BNE;
    logic func3_bl       = func3_X_i   == `FNC_BLTU | func3_X_i == `FNC_BLT;
    logic func3_bg       = func3_X_i   == `FNC_BGEU | func3_X_i == `FNC_BGE;

    logic Btaken_or_JALR = ~ctrl_kill_X_i &
      (opcode_jalr |
      (opcode_branch & func3_beq & br_eq_i) |
      (opcode_branch & func3_bne & ~br_eq_i) |
      (opcode_branch & func3_bl & br_lt_i) |
      (opcode_branch & func3_bg & ~br_lt_i));

    assign pc_sel_X_o  = Btaken_or_JALR ? 2'b10 : 2'b00;
    assign pc_select_o = Btaken_or_JALR ? 2'b10 : JAL_ID ? 2'b01 : 2'b00;

endmodule: PCSelect
