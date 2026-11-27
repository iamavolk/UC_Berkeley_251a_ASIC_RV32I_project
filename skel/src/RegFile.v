module RegFile #(
    parameter int unsigned N = 32
)(
    input logic [N-1:0] data_i,
    input logic   [4:0] raddra_i, raddrb_i, waddr_i,
    input logic         wen_i,
    input logic         clk_i,
    input logic         rst_i,

    output logic [N-1:0] douta_o, doutb_o
);

    //------------------------------------------
    //      RegFile
    //------------------------------------------
    logic [N-1:0] regs [N];

    //------------------------------------------
    //      Sync write
    //------------------------------------------
    always_ff @(posedge clk_i) begin: sync_write
      if (rst_i)
          foreach (regs[i]) regs[i] <= '0;

      else if (waddr_i != '0 && wen_i)
          regs[waddr_i] <= data_i;

    end: sync_write

    //------------------------------------------
    //      Async read
    //------------------------------------------
    assign douta_o = ( raddra_i == '0 ) ? '0 : regs[raddra_i];
    assign doutb_o = ( raddrb_i == '0 ) ? '0 : regs[raddrb_i];

endmodule: RegFile
