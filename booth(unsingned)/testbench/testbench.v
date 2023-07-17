`timescale 1ns/100ps
`define T_CLK 10
module testbench;
    reg clk;
    reg n_rst;
    reg [3:0] M;
    reg [3:0] Q;
    wire [7:0] product;


    Unsigned_Booth_Algorithm uut_Unsigned_Booth_Algorithm(
        .clk(clk),
        .n_rst(n_rst),
        .M(M),
        .Q(Q),
        .product(product)
    );
    initial begin
        clk = 1'b1;
        n_rst = 1'b0;
        M=4'b1100;
        Q=4'b0110;
    end
    always #(`T_CLK/2) clk = ~clk;
    initial begin
        #(`T_CLK/2)n_rst = 1'b1;


        #(`T_CLK*6)

        $stop;
    end

    
endmodule