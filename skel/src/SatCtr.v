module SatCtr #(
)(
    input logic clk, reset, enable,

    output logic [3:0] count
);

  parameter int unsigned MAX_COUNT = 4;

  always_ff @(posedge clk) begin: saturating
      if (reset)
          count <= '0;
      else if (enable)
          count <= (count < MAX_COUNT) ? count + 1 : MAX_COUNT;
  end: saturating

endmodule: SatCtr
