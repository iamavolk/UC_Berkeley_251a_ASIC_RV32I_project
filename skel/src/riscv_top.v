`include "const.vh"

module riscv_top #(
    parameter int unsigned N = 32
)(
    input logic clk,
    input logic reset,

    output logic                           mem_req_valid,
    input  logic                           mem_req_ready,
    output logic                           mem_req_rw,
    output logic [`MEM_ADDR_BITS-1:0]      mem_req_addr,
    output logic [`MEM_TAG_BITS-1:0]       mem_req_tag,

    output logic                           mem_req_data_valid,
    input  logic                           mem_req_data_ready,
    output logic [`MEM_DATA_BITS-1:0]      mem_req_data_bits,
    output logic [(`MEM_DATA_BITS/8)-1:0]  mem_req_data_mask,

    input  logic                           mem_resp_valid,
    input  logic [`MEM_TAG_BITS-1:0]       mem_resp_tag,
    input  logic [`MEM_DATA_BITS-1:0]      mem_resp_data,
    output logic [N-1:0]                   csr
);

    logic [N-1:0]  dcache_addr; // From cpu of Riscv151.v
    logic [N-1:0]  dcache_din;  // From cpu of Riscv151.v
    logic [N-1:0]  dcache_dout; // From mem of Memory151.v
    logic          dcache_re;   // From cpu of Riscv151.v
    logic   [3:0]  dcache_we;   // From cpu of Riscv151.v
    logic [N-1:0]  icache_addr; // From cpu of Riscv151.v
    logic [N-1:0]  icache_dout; // From mem of Memory151.v
    logic          icache_re;   // From cpu of Riscv151.v
    logic          stall;       // From mem of Memory151.v

    Memory151 mem(
        // Outputs
        .dcache_dout        ( dcache_dout[N-1:0] ),
        .icache_dout        ( icache_dout[N-1:0] ),
        .stall              ( stall ),
        .mem_req_valid      ( mem_req_valid ),
        .mem_req_rw         ( mem_req_rw ),
        .mem_req_addr       ( mem_req_addr[`MEM_ADDR_BITS-1:0] ),
        .mem_req_tag        ( mem_req_tag[`MEM_TAG_BITS-1:0] ),
        .mem_req_data_valid ( mem_req_data_valid ),
        .mem_req_data_bits  ( mem_req_data_bits[`MEM_DATA_BITS-1:0] ),
        .mem_req_data_mask  ( mem_req_data_mask[(`MEM_DATA_BITS/8)-1:0] ),

        // Inputs
        .clk                ( clk ),
        .reset              ( reset ),
        .dcache_addr        ( dcache_addr [N-1:0] ),
        .icache_addr        ( icache_addr [N-1:0]),
        .dcache_we          ( dcache_we [3:0] ),
        .dcache_re          ( dcache_re ),
        .icache_re          ( icache_re ),
        .dcache_din         ( dcache_din [N-1:0] ),
        .mem_req_ready      ( mem_req_ready ),
        .mem_req_data_ready ( mem_req_data_ready ),
        .mem_resp_valid     ( mem_resp_valid ),
        .mem_resp_data      ( mem_resp_data [`MEM_DATA_BITS-1:0] ),
        .mem_resp_tag       ( mem_resp_tag [`MEM_TAG_BITS-1:0] )
    );

    Riscv151 cpu(
        // Outputs
        .dcache_addr          ( dcache_addr [N-1:0] ),
        .icache_addr          ( icache_addr [N-1:0] ),
        .dcache_we            ( dcache_we [3:0] ),
        .dcache_re            ( dcache_re ),
        .icache_re            ( icache_re ),
        .dcache_din           ( dcache_din [N-1:0] ),

        // Inputs
        .clk                  ( clk ),
        .reset                ( reset ),
        .dcache_dout          ( dcache_dout [31:0] ),
        .icache_dout          ( icache_dout [31:0] ),
        .csr                  ( csr ),
        .stall                ( stall )
    );

endmodule: riscv_top
