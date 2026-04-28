module BranchComp #(
    parameter int unsigned N = 32
)(
    input  logic [N-1:0] br_data0_i, br_data1_i,
    input  logic         br_un_i,

    output logic         br_eq_o, br_lt_o
);

    logic b0_msb = br_data0_i[N-1];
    logic b1_msb = br_data1_i[N-1];

    assign br_eq_o = (br_data0_i == br_data1_i);

    assign br_lt_o = (br_un_i || (b0_msb & b1_msb) || (~b0_msb & ~b1_msb)) ? (br_data0_i < br_data1_i)
    : (b0_msb & ~b1_msb) ? 1'b1 : 1'b0;

endmodule: BranchComp
