module FireWall_parser #(
    parameter BRAM_ADDR_WIDTH = 8,
    parameter BRAM_DATA_WIDTH = 208,
    parameter ENTRY_WIDTH     = 52,
    parameter IP_WIDTH        = 48,
    parameter COUNT_WIDTH     = 16
)(
    input wire clk,
    input wire rst_n,

    //------------------------------------------------
    // Control
    //------------------------------------------------
    input wire start_search,

    //------------------------------------------------
    // Search IP
    //------------------------------------------------
    input wire [IP_WIDTH-1:0] search_ip,

    //------------------------------------------------
    // BRAM Interface
    //------------------------------------------------
    output reg [BRAM_ADDR_WIDTH-1:0] bram_addr,
    output reg bram_rd_en,

    input wire [BRAM_DATA_WIDTH-1:0] bram_data_out,

    //------------------------------------------------
    // Hold valid output for N cycles
    //------------------------------------------------
    input wire [COUNT_WIDTH-1:0] count,

    //------------------------------------------------
    // Outputs
    //------------------------------------------------
    output reg valid_data,
    output reg valid_fifo,
    output reg searching
);

    //------------------------------------------------
    // FSM STATES
    //------------------------------------------------
    localparam IDLE      = 3'd0;
    localparam READ_BRAM = 3'd1;
    localparam WAIT_BRAM = 3'd2;
    localparam COMPARE   = 3'd3;
    localparam DONE      = 3'd4;
    localparam HOLD      = 3'd5;

    reg [2:0] state;

    //------------------------------------------------
    // Internal
    //------------------------------------------------
    integer i;

    reg match_found;

    reg [ENTRY_WIDTH-1:0] entry;

    reg [COUNT_WIDTH-1:0] hold_counter;

    //------------------------------------------------
    // FSM
    //------------------------------------------------
    always @(posedge clk or negedge rst_n) begin

        if (!rst_n) begin

            state <= IDLE;

            bram_addr <= 0;
            bram_rd_en <= 0;

            valid_data <= 0;
            valid_fifo <= 0;

            hold_counter <= 0;
            searching <= 0;
            match_found <= 0;

        end
        else begin

            case(state)

            //------------------------------------------------
            // IDLE
            //------------------------------------------------
            IDLE: begin

                valid_data <= 0;
                valid_fifo <= 0;

                hold_counter <= 0;

                if (start_search) begin

                    bram_addr <= 0;

                    match_found <= 0;

                    state <= READ_BRAM;
                end
            end

            //------------------------------------------------
            // REQUEST BRAM READ
            //------------------------------------------------
            READ_BRAM: begin

                bram_rd_en <= 1'b1;

                state <= WAIT_BRAM;
            end

            //------------------------------------------------
            // WAIT 1 CLOCK FOR BRAM DATA
            //------------------------------------------------
            WAIT_BRAM: begin

                bram_rd_en <= 1'b0;

                state <= COMPARE;
            end

            //------------------------------------------------
            // COMPARE 4 ENTRIES
            //------------------------------------------------
            COMPARE: begin
                searching <= 1'b1;
                for (i = 0; i < 4; i = i + 1) begin

                    entry = bram_data_out[(i*ENTRY_WIDTH) +: ENTRY_WIDTH];

                    //------------------------------------------------
                    // entry[51] = valid
                    // entry[47:0] = IP
                    //------------------------------------------------
                    if ((entry[51] == 1'b1) &&
                        (entry[47:0] == search_ip)) begin

                        match_found <= 1'b1;
                    end
                end

                //------------------------------------------------
                // FOUND MATCH
                //------------------------------------------------
                if (match_found) begin
                    searching <= 1'b0;
                    valid_data <= 1'b1;
                    valid_fifo <= 1'b1;

                    state <= HOLD;
                end

                //------------------------------------------------
                // CHECK NEXT ADDRESS
                //------------------------------------------------
                else begin

                    //------------------------------------------------
                    // LAST BRAM ADDRESS
                    //------------------------------------------------
                    if (bram_addr == ((1<<BRAM_ADDR_WIDTH)-1)) begin

                        valid_data <= 1'b0;
                        valid_fifo <= 1'b1;

                        state <= HOLD;
                    end
                    else begin

                        bram_addr <= bram_addr + 1'b1;

                        state <= READ_BRAM;
                    end
                end
            end

            //------------------------------------------------
            // HOLD OUTPUTS
            //------------------------------------------------
            HOLD: begin

                if (hold_counter < count-1) begin

                    hold_counter <= hold_counter + 1'b1;
                end
                else begin

                    hold_counter <= 0;

                    valid_data <= 1'b0;
                    valid_fifo <= 1'b0;

                    state <= IDLE;
                end
            end

            default: begin
                state <= IDLE;
            end

            endcase
        end
    end

endmodule