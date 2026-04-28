module StoreMask #(
    parameter int unsigned WIDTH = 32)
(
    input logic              mem_write_X_i,
    input logic [1:0]        func3_2lsb_X_i,
    input logic [1:0]        byte_offset_i,
    input logic [WIDTH-1:0]  data_i,

    output logic [3:0]       mem_wea_mask_o,
    output logic [WIDTH-1:0] data_out_o
);

    logic [3:0] mask;

    always_comb begin
        case (func3_2lsb_X_i)
            2'b00: begin
                mask         = 4'b0001 << byte_offset_i;
                data_out_o = data_i << (8 * byte_offset_i);
            end

            2'b01: begin
                mask         = 4'b0011 << byte_offset_i;
                data_out_o = data_i << (8 * byte_offset_i);
            end

            2'b10: begin
                mask         = 4'b1111;
                data_out_o = data_i;
            end

            default: begin
                mask         = 4'b0000;
                data_out_o = data_i;
            end
        endcase
    end

  assign mem_wea_mask_o = mem_write_X_i ? mask : 4'b0000;

endmodule: StoreMask
