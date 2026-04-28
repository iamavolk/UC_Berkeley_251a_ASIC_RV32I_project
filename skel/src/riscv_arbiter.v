`include "const.vh"

module riscv_arbiter #(
    // params
)(
    input logic clk,
    input logic reset,

    input  logic                      ic_mem_req_valid,
    output logic                      ic_mem_req_ready,
    input  logic [`MEM_ADDR_BITS-1:0] ic_mem_req_addr,
    output logic                      ic_mem_resp_valid,

    input  logic                      dc_mem_req_valid,
    output logic                      dc_mem_req_ready,
    input  logic                      dc_mem_req_rw,
    input  logic [`MEM_ADDR_BITS-1:0] dc_mem_req_addr,
    output logic                      dc_mem_resp_valid,

    output logic                      mem_req_valid,
    input  logic                      mem_req_ready,
    output logic                      mem_req_rw,
    output logic [`MEM_ADDR_BITS-1:0] mem_req_addr,
    output logic  [`MEM_TAG_BITS-1:0] mem_req_tag,
    input  logic                      mem_resp_valid,
    input  logic  [`MEM_TAG_BITS-1:0] mem_resp_tag
);

    assign ic_mem_req_ready = mem_req_ready;
    assign dc_mem_req_ready = mem_req_ready & ~ic_mem_req_valid;

    assign mem_req_valid    = ic_mem_req_valid | dc_mem_req_valid;
    assign mem_req_rw       = ic_mem_req_valid ? 1'b0 : dc_mem_req_rw;
    assign mem_req_addr     = ic_mem_req_valid ? ic_mem_req_addr : dc_mem_req_addr;
    assign mem_req_tag      = ic_mem_req_valid ? 4'd0 : 4'd1;

    assign ic_mem_resp_valid = mem_resp_valid && (mem_resp_tag == 4'd0);
    assign dc_mem_resp_valid = mem_resp_valid && (mem_resp_tag == 4'd1);

endmodule: riscv_arbiter
