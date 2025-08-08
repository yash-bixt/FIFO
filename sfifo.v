`timescale 1ns / 1ps

module sfifo#(
parameter DEPTH = 4,
parameter WIDTH = 8,
parameter ADDR = 2
)(
input rst, clk,
input [WIDTH-1:0] din,
input wr_en, r_en,
output reg [WIDTH-1:0] dout,
output reg full, empty
);

reg [WIDTH-1:0] mem [0:DEPTH-1];
reg [ADDR-1:0] wr_ptr;
reg [ADDR-1:0] r_ptr;
reg [ADDR:0] count;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        wr_ptr <= 0;
        r_ptr <= 0;
        dout <= 0;
        full <= 0;
        empty <= 1;
        count <= 0;
    end else begin
        if (wr_en && !full) begin
            mem[wr_ptr] <= din;
            wr_ptr <= (wr_ptr + 1) % DEPTH;
            count <= count + 1;
        end
        if (r_en && !empty) begin
            dout <= mem[r_ptr];
            r_ptr  <= (r_ptr  + 1) % DEPTH;
            count <= count - 1;
        end
        full <= (count == DEPTH);
        empty <= (count == 0);
    end
end

endmodule
