`timescale 1ns / 1ps

module tb_sfifo;

   
    parameter DEPTH = 4;
    parameter WIDTH = 8;
    parameter ADDR  = 2;

    
    reg                  clk;
    reg                  rst;
    reg  [WIDTH-1:0]     din;
    reg                  wr_en;
    reg                  r_en;
    wire [WIDTH-1:0]     dout;
    wire                 full;
    wire                 empty;

    
    sfifo #(
        .DEPTH(DEPTH),
        .WIDTH(WIDTH),
        .ADDR(ADDR)
    ) uut (
        .rst(rst),
        .clk(clk),
        .din(din),
        .wr_en(wr_en),
        .r_en(r_en),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    
    always #5 clk = ~clk; 

    
    task write_fifo(input [WIDTH-1:0] data);
    begin
        @(negedge clk);
        wr_en = 1;
        din   = data;
        @(negedge clk);
        wr_en = 0;
        din   = 0;
    end
    endtask

    
    task read_fifo;
    begin
        @(negedge clk);
        r_en = 1;
        @(negedge clk);
        r_en = 0;
    end
    endtask

    
    initial begin
        
        clk   = 0;
        rst   = 1;
        din   = 0;
        wr_en = 0;
        r_en  = 0;

        
        #20;
        rst = 0;

        
        write_fifo(8'hA1);
        write_fifo(8'hB2);
        write_fifo(8'hC3);
        write_fifo(8'hD4);

        
        write_fifo(8'hE5);

        
        read_fifo();
        read_fifo();

        
        @(negedge clk);
        wr_en = 1;
        din   = 8'hF6;
        r_en  = 1;
        @(negedge clk);
        wr_en = 0;
        r_en  = 0;

        
        read_fifo();
        read_fifo();
        read_fifo();

        
        read_fifo();

        
        #20;
        $finish;
    end

    
    initial begin
        $monitor("T=%0t | rst=%b wr_en=%b r_en=%b din=%h dout=%h full=%b empty=%b wr_ptr=%0d r_ptr=%0d count=%0d",
                  $time, rst, wr_en, r_en, din, dout, full, empty,
                  uut.wr_ptr, uut.r_ptr, uut.count);
    end

endmodule
