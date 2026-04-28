`include "Opcode.vh"

module ImmGen #(
    parameter int unsigned N = 32
)(
    input  logic [N-1:0]    instr_i,
    input  logic   [1:0]    imm_sel_i,

    output logic [N-1:0] imm_o
);

    logic [2:0] func3    = instr_i[14:12];
    logic opcode_s_l     = instr_i[4];

    logic [N-1:0] s_type  = {{20{instr_i[31]}}, instr_i[31:25], instr_i[11:7]};
    logic [N-1:0] u_type  = {instr_i[31:12], {12{1'b0}}};
    logic [N-1:0] b_type  = {{19{instr_i[31]}}, instr_i[31], instr_i[7], instr_i[30:25], instr_i[11:8], 1'b0};

    logic  [11:0] i_imm       = instr_i[31:20];
    logic   [4:0] i_star_imm  = instr_i[24:20];
    logic [N-1:0] i_type      = ((func3 == `FNC_SLTU) && opcode_s_l) ? {{20{instr_i[31]}}, i_imm}
                            : ((func3 == `FNC_SLL || func3 == `FNC_SRL_SRA) && opcode_s_l ? {{27{1'b0}}, i_star_imm}
                            : {{20{instr_i[31]}}, i_imm});

    mux4 ImmGenMux (
        .in0 ( i_type  ),
        .in1 ( is_type ),
        .in2 ( ib_type ),
        .in3 ( iu_type ),
        .sel ( iimm_sel_i ),
        .out ( iimm_o  )
    );

endmodule: ImmGen
