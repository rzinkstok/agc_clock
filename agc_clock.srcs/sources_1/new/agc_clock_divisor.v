`timescale 1ns / 1ps

module agc_clock_divisor(
    input wire prop_clk,
    input wire prop_clk_locked,
    input wire rst_n,
    output wire agc_clk
    );
    
    reg [5:0] counter;

    assign agc_clk = counter >= 6'd12;

    always @(posedge prop_clk or negedge rst_n) begin
        if (~rst_n) begin
            counter <= 6'b0;
        end else begin
            if (~prop_clk_locked | (counter >= 6'd24)) begin
                counter <= 6'b0;
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
