module BranchComp #(
    parameter int unsigned N = 32
)(
    input  logic [N-1:0] br_data0_i, br_data1_i,
    input  logic         br_un_i,

    output logic         br_eq_o, br_lt_o
);

    always_comb begin: branch_equal
        br_eq_o = (br_data0_i == br_data1_i);
    end: branch_equal

    always_comb begin: branch_less_than
        if (br_un_i)
            br_lt_o = (br_data0_i < br_data1_i);
        else
            br_lt_o = ($signed(br_data0_i) < $signed(br_data1_i));
    end: branch_less_than

endmodule: BranchComp
