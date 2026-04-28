module mux4 #(
    parameter int unsigned  N = 32)
(
    input  logic [N-1:0] in0, in1, in2, in3,
    input  logic   [1:0] sel,

    output logic [N-1:0] out
);

    always_comb begin
        case (sel)
            2'b00:   out = in0;
            2'b01:   out = in1;
            2'b10:   out = in2;
            2'b11:   out = in3;
            default: out = { N {1'bx} };
        endcase
    end

endmodule: mux4
