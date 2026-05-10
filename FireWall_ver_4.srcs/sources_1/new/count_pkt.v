module valid_cycle_counter #(
    parameter WIDTH = 32 // Width of the counter
)(
    input wire clk,
    input wire rst_n,       // Active-low asynchronous reset
    input wire new_pkt,     // Pulse to start/restart counting a new packet
    input wire valid,       // High when data is valid (increments counter)
    input wire tlast,       // High on the last valid cycle of the packet
    
    output reg [WIDTH-1:0] total_count, // Holds the total valid count of the last completed packet
    output reg count_valid              // Pulses high for 1 cycle when total_count is updated and ready
);

    reg [WIDTH-1:0] current_count;
    reg counting_active;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            current_count   <= {WIDTH{1'b0}};
            total_count     <= {WIDTH{1'b0}};
            count_valid     <= 1'b0;
            counting_active <= 1'b0;
        end else begin
            // Default: clear the valid pulse every clock cycle unless specifically set
            count_valid <= 1'b0;

            if (new_pkt) begin
                // A new packet is flagged. Reset the counter and start tracking.
                // We evaluate 'valid' and 'tlast' in the same cycle just in case 
                // new_pkt is asserted concurrently with the first data word.
                if (valid) begin
                    if (tlast) begin
                        // Edge case: A packet that is exactly 1 cycle long
                        total_count     <= {{(WIDTH-1){1'b0}}, 1'b1};
                        count_valid     <= 1'b1;
                        counting_active <= 1'b0;
                    end else begin
                        // Count the first valid cycle
                        current_count   <= {{(WIDTH-1){1'b0}}, 1'b1};
                        counting_active <= 1'b1;
                    end
                end else begin
                    // new_pkt arrived, but data isn't valid yet. Just arm the counter.
                    current_count   <= {WIDTH{1'b0}};
                    counting_active <= 1'b1;
                end
                
            end else if (counting_active && valid) begin
                if (tlast) begin
                    // Packet ends: update total_count, flag it as valid, and stop counting
                    total_count     <= current_count + 1'b1;
                    count_valid     <= 1'b1;
                    counting_active <= 1'b0;
                end else begin
                    // Normal valid cycle: increment internal counter
                    current_count   <= current_count + 1'b1;
                end
            end
        end
    end

endmodule