`timescale 1ns/100ps
`define T_CLK 10
module testbench;
    reg clk;
    reg n_rst;
    reg T;
    wire Q;

    T uut_T(
        .clk(clk),
        .n_rst(n_rst),
        .T(T),
        .Q(Q)
    );
    initial begin
        clk = 1'b1;
        n_rst = 1'b0;
        T=0;
    end
always #(`T_CLK/2) clk = ~clk;
    initial begin

        #(`T_CLK/2)n_rst = 1;

        #(`T_CLK)T=1;

        #(`T_CLK)T=0;

        #(`T_CLK)T=1;

        #(`T_CLK)T=0;

        $stop;
    end

    
endmodule