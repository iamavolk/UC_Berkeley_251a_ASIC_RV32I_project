module mux2 #(
    parameter int unsigned N = 32
)(
    input  logic [N-1:0] in0, in1,
    input  logic         sel,

    output logic [N-1:0] out
);

    assign out = sel ? in1 : in0;

endmodule: mux2
