module ALU #(
    parameter int unsigned N = 32
)(
    input  logic [N-1:0]    a_i, b_i,
    input  logic   [3:0]    alu_sel_i,

    output logic [N-1:0]    alu_res_o
);

    always_comb begin: alu
        case (alu_sel_i)
            4'b0000: alu_res_o = a_i + b_i;
            4'b0001: alu_res_o = a_i << b_i[4:0];
            4'b0010: alu_res_o = $signed(a_i) < $signed(b_i);
            4'b0011: alu_res_o = a_i < b_i;
            4'b0100: alu_res_o = a_i ^ b_i;
            4'b0101: alu_res_o = a_i >> b_i[4:0];
            4'b0110: alu_res_o = a_i | b_i;
            4'b0111: alu_res_o = a_i & b_i;
            4'b1100: alu_res_o = a_i - b_i;
            4'b1101: alu_res_o = $signed(a_i) >>> b_i[4:0];
            4'b1111: alu_res_o = b_i;

            default: alu_res_o = '0;
        endcase
    end: alu

endmodule: ALU
