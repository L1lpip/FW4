module FireWall_Pack #(
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32,

    parameter BRAM_ADDR_WIDTH = 8,
    parameter BRAM_DATA_WIDTH = 200
) (
    input wire clk,
    input wire rst_n,

    input wire [ADDR_WIDTH-1:0] reg_addr,
    input wire                  reg_wr,
    input wire                  reg_rd,
    input wire [DATA_WIDTH-1:0] reg_wdata,

    output wire [DATA_WIDTH-1:0] reg_rdata,

    //-- BRAM Interface --//
    output reg [BRAM_ADDR_WIDTH-1:0] addr,
    output reg wr_en,
    output reg rd_en,
    output reg [BRAM_DATA_WIDTH-1:0] bram_data_in,
    input wire [BRAM_DATA_WIDTH-1:0] bram_data_out
);

            
    localparam USER_ID    = 4'h0;
    localparam USER_IP_LO = 4'h4;
    localparam USER_IP_HI = 4'h8;

    wire user_id_wr_en    = (reg_addr == USER_ID)    && reg_wr;
    wire user_ip_lo_wr_en = (reg_addr == USER_IP_LO) && reg_wr;
    wire user_ip_hi_wr_en = (reg_addr == USER_IP_HI) && reg_wr;

    reg [7:0]  user_id;
    reg [31:0] user_ip_lo;
    reg [16:0] user_ip_hi;

    reg [1:0]  pos;
    reg [7:0]  bram_address;

    reg [200:0] bram_q;   // read data
    reg [200:0] bram_d;   // modified data

    reg [48:0] new_entry;

    //flags

    reg lo_valid;
    reg hi_valid;

    // FSM
    reg [2:0] state, next_state;
    localparam IDLE  = 3'd0;
    localparam READ  = 3'd1;
    localparam WAIT  = 3'd2;
    localparam WRITE = 3'd3;

    
    
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE:  if (lo_valid && hi_valid) next_state = READ;
            READ:  next_state = WAIT;
            WAIT:  next_state = WRITE;
            WRITE: next_state = IDLE;
        endcase
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            user_id     <= 0;
            user_ip_lo  <= 0;
            user_ip_hi  <= 0;
            addr        <= 0;
            rd_en       <= 0;
            wr_en       <= 0;
            bram_data_in<= 0;
            bram_q      <= 0;
            lo_valid     <= 0;
            hi_valid     <= 0;
        end else begin
            if (user_id_wr_en)    user_id    <= reg_wdata[7:0];
            if (user_ip_lo_wr_en) begin 
                 user_ip_lo <= reg_wdata;
                 lo_valid   <= 1'b1;
            end
            if (user_ip_hi_wr_en) begin 
                user_ip_hi <= reg_wdata[16:0];
                hi_valid   <= 1'b1;
            end
            
            if (state == IDLE && lo_valid && hi_valid) begin
                new_entry <= {user_ip_hi, user_ip_lo};
            end


            case (state)
                READ: begin
                    pos          <= user_id[1:0];
                    bram_address <= user_id >> 2;
                    addr  <= user_id >> 2;
                    rd_en <= 1'b1;
                    wr_en <= 1'b0;
                end
                WAIT: begin
                    rd_en  <= 1'b0;
                    bram_q <= bram_data_out;
                end
                WRITE: begin
                    case (pos)
                        2'd0: bram_data_in <= {bram_q[200:56], new_entry};
                        2'd1: bram_data_in <= {bram_q[200:112], new_entry , bram_q[55:0]};
                        2'd2: bram_data_in <= {bram_q[200:144], new_entry  , bram_q[111:0]};
                        2'd3: bram_data_in <= {new_entry, bram_q[143:0]};
                    endcase
                    lo_valid     <= 1'b0;
                    hi_valid     <= 1'b0;
                    addr         <= bram_address;
                    wr_en        <= 1'b1;
                    rd_en        <= 1'b0;
                end
                default: begin
                    wr_en <= 0;
                    rd_en <= 0;
                end
            endcase
        end
    end

    assign reg_rdata = 32'b0;

endmodule