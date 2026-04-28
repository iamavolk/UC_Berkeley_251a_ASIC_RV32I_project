module JALTargetID #(
    parameter int unsigned N = 32
)(
    input logic  [N-1:0] instr_i,
    input logic  [N-1:0] pc_i,

    output logic [N-1:0] jal_target_pc_o
);

  logic [N-1:0] imm;

  assign imm = {{11{instr_i[31]}}, instr_i[31], instr_i[19:12], instr_i[20], instr_i[30:21], 1'b0};

  assign jal_target_pc_o = pc_i + imm;

endmodule: JALTargetID
