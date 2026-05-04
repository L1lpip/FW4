
`timescale 1ns / 1ps
import axi_vip_pkg::*;
import design_1_axi_vip_0_0_pkg::*;


    module fire_wall_tb;

    bit                        [ 31:0] write_data;
    xil_axi_ulong                      mtestADDR;
    xil_axi_prot_t                     mtestProtectionType = 3'b000;
    xil_axi_resp_t                     mtestBresp;
    xil_axi_ulong                      read_addr;
    xil_axi_ulong                      status_reg;
    xil_axi_resp_t             [255:0] mtestRresp;


    design_1_axi_vip_0_0_mst_t         mst_agent;

    bit                                tb_s_valid;
    bit                                tb_s_last;
    bit                        [  7:0] tb_s_data;
    bit                        [  7:0] tb_s_user_id;


    bit                                tb_m_valid;
    bit                                tb_m_last;
    bit                        [  7:0] tb_m_data;
    bit                        [  7:0] tb_m_user_id;
	bit [47:0] read_data;
    bit                                clk;
    bit                                resetn;

    initial begin
        clk    = 1'b0;
        resetn = 1'b0;
        #200;
        resetn = 1'b1;
    end

    always #5 clk <= ~clk;

    design_1_wrapper UUT (
        .aclk_0   (clk),
        .aresetn_0(resetn)
            //    .in_valid_0  (tb_s_valid),
            //    .in_last_0   (tb_s_last),
            //    .in_data_0   (tb_s_data),
            //    .out_user_id_0(tb_s_user_id),
            //    .out_valid_0  (tb_m_valid),
            //    .out_last_0   (tb_m_last),
            //    .out_data_0   (tb_m_data)
    );

    initial begin

        mst_agent = new("master vip agent", fire_wall_tb.UUT.design_1_i.axi_vip_0.inst.IF);
        mst_agent.set_agent_tag("Master VIP");
        mst_agent.start_master();

        wait (resetn == 1'b0);
        repeat (300) @(posedge clk);
 

    //USER_ID: 0x00;
		// MAC_LO: 0x04;
		// MAC_HI: 0x08;

        mst_agent.AXI4LITE_WRITE_BURST(8'h00, mtestProtectionType, 32'h00000001, mtestRresp);  //USER_ID
        mst_agent.AXI4LITE_WRITE_BURST(8'h04, mtestProtectionType, 32'hFFFFFFFF, mtestRresp);  //MAC_LO
        mst_agent.AXI4LITE_WRITE_BURST(8'h08, mtestProtectionType, 17'h1EEEE, mtestRresp);  //MAC_HI

		mst_agent.AXI4LITE_WRITE_BURST(8'h00, mtestProtectionType, 32'h00000004, mtestRresp);  //USER_ID
        mst_agent.AXI4LITE_WRITE_BURST(8'h04, mtestProtectionType, 32'h11223344, mtestRresp);  //MAC_LO
        mst_agent.AXI4LITE_WRITE_BURST(8'h08, mtestProtectionType, 17'h15566, mtestRresp);  //MAC_HI

		mst_agent.AXI4LITE_WRITE_BURST(8'h00, mtestProtectionType, 32'h00000003, mtestRresp);  //USER_ID
        mst_agent.AXI4LITE_WRITE_BURST(8'h04, mtestProtectionType, 32'h99AABBCC, mtestRresp);  //MAC_LO
        mst_agent.AXI4LITE_WRITE_BURST(8'h08, mtestProtectionType, 17'h07788, mtestRresp);  //MAC_HI

		mst_agent.AXI4LITE_WRITE_BURST(8'h00, mtestProtectionType, 32'h00000005, mtestRresp);  //USER_ID
        mst_agent.AXI4LITE_WRITE_BURST(8'h04, mtestProtectionType, 32'hAABBCCDD, mtestRresp);  //MAC_LO
        mst_agent.AXI4LITE_WRITE_BURST(8'h08, mtestProtectionType, 17'h1EEFF, mtestRresp);  //MAC_HI

        mst_agent.stop_master();
    end

    // task send_frame(input [7:0] frame[]);
    //     tb_s_user_id <= frame[0];
    //     for (int k = 0; k < frame.size(); k++) begin
    //         @(posedge clk);
    //         tb_s_valid <= 1'b1;
    //         tb_s_data  <= frame[k];
    //         tb_s_last  <= (k == frame.size() - 1);
    //     end
    //     @(posedge clk);
    //     tb_s_valid <= 1'b0;
    //     tb_s_last  <= 1'b0;
    //     tb_s_data  <= 8'h00;
    // endtask

    // // -------------------------------------------------------------------------
    // // Build and send: [dst_mac 6B][src_mac 6B][etype 2B][payload][CRC32 4B]
    // // -------------------------------------------------------------------------
    // task automatic send_eth_packet(
    //     input [47:0] dst_mac_in,
    //     input [47:0] src_mac_in,
    //     input [15:0] ether_type_in,
    //     input [7:0]  payload[],
    //     input int    payload_len
    // );
    //     bit [7:0]  frame_buf[];
    //     reg [31:0] crc;
    //     int        idx;
    //     int        frame_len;

    //     frame_len = 6 + 6 + 2 + payload_len;
    //     frame_buf = new[frame_len];
    //     idx = 0;

    //     // Destination MAC (MSB first, wire order)
    //     frame_buf[idx++] = dst_mac_in[47:40];
    //     frame_buf[idx++] = dst_mac_in[39:32];
    //     frame_buf[idx++] = dst_mac_in[31:24];
    //     frame_buf[idx++] = dst_mac_in[23:16];
    //     frame_buf[idx++] = dst_mac_in[15: 8];
    //     frame_buf[idx++] = dst_mac_in[ 7: 0];

    //     // Source MAC (MSB first)
    //     frame_buf[idx++] = src_mac_in[47:40];
    //     frame_buf[idx++] = src_mac_in[39:32];
    //     frame_buf[idx++] = src_mac_in[31:24];
    //     frame_buf[idx++] = src_mac_in[23:16];
    //     frame_buf[idx++] = src_mac_in[15: 8];
    //     frame_buf[idx++] = src_mac_in[ 7: 0];

    //     // EtherType (MSB first)
    //     frame_buf[idx++] = ether_type_in[15:8];
    //     frame_buf[idx++] = ether_type_in[ 7:0];

    //     // Payload
    //     for (int j = 0; j < payload_len; j++)
    //         frame_buf[idx++] = payload[j];


    //     send_frame(frame_buf);
    // endtask

    // // -------------------------------------------------------------------------
    // // Test: send one matching frame and one non-matching frame
    // // -------------------------------------------------------------------------
    // // DEST_ADDR from eth_packet_read parameter: 48'h3210_2003_0000
    // localparam [47:0] MY_MAC     = 48'h3210_2003_0000;  // must match DEST_ADDR
    // localparam [47:0] SENDER_MAC = 48'hAABB_CCDD_EEFF;
    // localparam [47:0] SENDER_MAC_1 = 48'hEEEE_EEEE_EEEE;
    // localparam [47:0] SENDER_MAC_2 = 48'hCCCC_CCCC_CCCC;
    // localparam [15:0] ETYPE_IPV4 = 16'h0800;

    // initial begin
    //     bit [7:0] pkt_payload[];
    //     bit [7:0] pkt_payload_1[];
	// 	bit [7:0] pkt_payload_2[];
	// 	integer pkt_len = 1500;
    //     // Wait for reset to be released
    //     wait (resetn == 1'b1);
	// 	#10000;
    //     repeat (10) @(posedge clk);

    //     // --- Frame 1: dst MAC matches → should pass through firewall ---
    //     pkt_payload = new[pkt_len];
    //     pkt_payload_1 = new[pkt_len];
    //     pkt_payload_2 = new[pkt_len];
    //     foreach (pkt_payload[i]) pkt_payload[i] = 8'hA0 + i;  // dummy payload bytes
    //     foreach (pkt_payload[i]) pkt_payload_1[i] = 8'hB0 + i; 
    //     foreach (pkt_payload[i]) pkt_payload_2[i] = 8'hC0 + i; 

    //     send_eth_packet(48'hDEAD_BEEF_0000, SENDER_MAC, ETYPE_IPV4, pkt_payload, pkt_len);
    //     repeat (5) @(posedge clk);

    //     send_eth_packet(MY_MAC, SENDER_MAC, ETYPE_IPV4, pkt_payload, pkt_len);
    //     repeat (5) @(posedge clk);
        

    //     send_eth_packet(MY_MAC, SENDER_MAC_1, ETYPE_IPV4, pkt_payload_1, pkt_len);
    //     repeat (5) @(posedge clk);


    //     send_eth_packet(MY_MAC, SENDER_MAC_2, ETYPE_IPV4, pkt_payload_2, pkt_len);
    //     repeat (5) @(posedge clk);

    //     // --- Frame 2: dst MAC wrong → should be dropped ---
 
    //     send_eth_packet(48'hDEAD_BEEF_0000, SENDER_MAC, ETYPE_IPV4, pkt_payload, pkt_len);
    //     repeat (5) @(posedge clk);

    //     $display("[TB] Packet send test done.");
    // end

endmodule