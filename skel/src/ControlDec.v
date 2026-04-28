`include "Opcode.vh"

module ControlDec #(
    // params
)(
    input  logic [6:0]  opcode_i,
    input  logic [2:0]  func3_i,
    input  logic        func2_i,

    output logic [15:0] ctrl_o
);

    always_comb begin: opcode
        case (opcode_i)
            `OPC_ARI_RTYPE: begin: r_type
                case (func3_i)
                    `FNC_ADD_SUB: ctrl_o = func2_i ? 16'b0001_0110_0000_0001 : 16'b0001_0000_0000_0001;
                    `FNC_SLL:     ctrl_o = 16'b0001_0000_1000_0001;
                    `FNC_SLT:     ctrl_o = 16'b0001_0001_0000_0001;
                    `FNC_SLTU:    ctrl_o = 16'b0001_0001_1000_0001;
                    `FNC_XOR:     ctrl_o = 16'b0001_0010_0000_0001;
                    `FNC_SRL_SRA: ctrl_o = func2_i ? 16'b0001_0110_1000_0001 : 16'b0001_0010_1000_0001;
                    `FNC_OR:      ctrl_o = 16'b0001_0011_0000_0001;
                    `FNC_AND:     ctrl_o = 16'b0001_0011_1000_0001;
                    default:      ctrl_o = 16'hxxxx;
                endcase
            end: r_type

            `OPC_ARI_ITYPE: begin: i_type
                case (func3_i)
                    `FNC_ADD_SUB: ctrl_o = 16'b0001_0000_0100_0001;
                    `FNC_SLL:     ctrl_o = 16'b0001_0000_1100_0001;
                    `FNC_SLT:     ctrl_o = 16'b0001_0001_0100_0001;
                    `FNC_SLTU:    ctrl_o = 16'b0001_0001_1100_0001;
                    `FNC_XOR:     ctrl_o = 16'b0001_0010_0100_0001;
                    `FNC_SRL_SRA: ctrl_o = func2_i ? 16'b0001_0110_1100_0001 : 16'b0001_0010_1100_0001;
                    `FNC_OR:      ctrl_o = 16'b0001_0011_0100_0001;
                    `FNC_AND:     ctrl_o = 16'b0001_0011_1100_0001;
                    default:      ctrl_o = 16'hxxxx;
                endcase
            end: i_type

            `OPC_BRANCH:          ctrl_o = func3_i[1] ? 16'b0000_0000_0111_0100 : 16'b0000_0000_0110_0100;
            `OPC_LOAD:            ctrl_o = func3_i[2] ? 16'b0000_0000_0101_0001 : 16'b0000_0000_0100_0001;
            `OPC_STORE:           ctrl_o = 16'b0000_1000_0100_0010;
            `OPC_AUIPC:           ctrl_o = 16'b0001_0000_0110_0111;
            `OPC_LUI:             ctrl_o = 16'b0001_0111_1110_0111;
            `OPC_JAL:             ctrl_o = 16'b0010_0000_0110_1001;
            `OPC_JALR:            ctrl_o = 16'b0010_0000_0100_0001;

            default:              ctrl_o = '0;
        endcase
    end: opcode

endmodule: ControlDec
