module WrapCtr #(
    // params
)(
    input logic clk, reset, enable,

    output logic [4:0] count
);

    parameter int unsigned MAX_COUNT = 15;

    always_ff @(posedge clk) begin: wraparound_counter
        if (reset)
            count <= 0;
        else if (enable)
            count <= (count == MAX_COUNT) ? 0 : count + 1;
    end: wraparound_counter

endmodule: WrapCtr
