module eth_packet_read #(
    parameter DEST_ADDR = 48'h3210_2003_0000
) (
    input wire clk,
    input wire rst_n,

    input wire       in_valid,
    input wire       in_last,
    input wire [7:0] in_data,

    output reg        out_valid,
    output reg        out_last,
    output reg [ 7:0] out_data,
    output reg        src_ready,
    output reg [47:0] dst_mac,
    output reg [47:0] src_mac,
    output reg [15:0] ether_type,
    output reg        header_valid
);

    localparam S_DST_MAC = 3'd0, S_SRC_MAC = 3'd1, S_ETYPE = 3'd2, S_PAYLOAD = 3'd3, S_IDLE = 3'd4;

    reg [ 2:0] state;
    reg [ 3:0] byte_cnt;

    reg [47:0] dst_mac_r;
    reg [47:0] src_mac_r;
    reg [15:0] etype_r;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state        <= S_IDLE;
            byte_cnt     <= 0;
            out_valid    <= 0;
            out_last     <= 0;
            out_data     <= 0;
            dst_mac      <= 0;
            src_mac      <= 0;
            ether_type   <= 0;
            header_valid <= 0;
            dst_mac_r    <= 0;
            src_mac_r    <= 0;
            etype_r      <= 0;
            src_ready    <= 0;
        end else begin
            out_valid    <= 0;
            out_last     <= 0;
            header_valid <= 0;

            if (in_valid) begin
                case (state)
                    S_IDLE: begin
                        dst_mac_r <= {in_data, 40'd0};
                        byte_cnt  <= 1;
                        if (dst_mac_r[7:0] == DEST_ADDR[7:0]) begin
                            state <= S_DST_MAC;
                        end else begin
                            state <= S_IDLE;
                        end
                    end

                    S_DST_MAC: begin
                        dst_mac_r[(47-byte_cnt*8)-:8] <= in_data;
                        byte_cnt                      <= byte_cnt + 1;
                        if (byte_cnt == 5) begin
                            byte_cnt <= 0;
                            if ({dst_mac_r[47:8], in_data} == DEST_ADDR) begin
                                dst_mac <= {dst_mac_r[47:8], in_data};
                                state   <= S_SRC_MAC;
                            end else begin
                                state <= S_IDLE;
                            end
                        end
                    end

                    S_SRC_MAC: begin
                        src_mac_r[(47-byte_cnt*8)-:8] <= in_data;
                        byte_cnt                      <= byte_cnt + 1;
                        if (byte_cnt == 5) begin
                            src_mac   <= {src_mac_r[47:8], in_data};
                            src_ready <= 1;
                            byte_cnt  <= 0;
                            state     <= S_ETYPE;
                        end else src_ready <= 0;

                    end

                    S_ETYPE: begin
                        etype_r[(15-byte_cnt*8)-:8] <= in_data;
                        byte_cnt                    <= byte_cnt + 1;
                        if (byte_cnt == 1) begin
                            ether_type   <= {etype_r[15:8], in_data};
                            header_valid <= 1;
                            byte_cnt     <= 0;
                            state        <= S_PAYLOAD;
                        end
                    end

                    S_PAYLOAD: begin
                        out_valid <= 1;
                        out_data  <= in_data;
                        out_last  <= in_last;
                        if (in_last) begin
                            state <= S_IDLE;
                        end
                    end
                    default: state <= S_IDLE;
                endcase
                if (in_last && state != S_PAYLOAD) begin
                    state <= S_IDLE;
                end
            end
        end
    end
endmodule