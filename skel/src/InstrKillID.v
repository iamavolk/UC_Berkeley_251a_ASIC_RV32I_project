module InstrKillID #(
    // params
)(
    input logic [1:0] pc_sel_JAL_X_i,
    input logic [1:0] pc_sel_JALR_B_WB_i,

    output logic instr_kill_res_o
);

    assign instr_kill_res_o = (pc_sel_JAL_X_i == 2'b01) || (pc_sel_JALR_B_WB_i == 2'b10);

endmodule: InstrKillID
