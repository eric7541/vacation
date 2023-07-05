`timescale 1ns/100ps
`define T_CLK 10
module testbench;
    reg clk;
    reg n_rst;
    reg J;
    reg K;
    wire Q;
    JK uut_JK(
        .clk(clk),
        .n_rst(n_rst),
        .J(J),
        .K(K),
        .Q(Q)
    );
    initial begin
        clk = 1'b1;
        n_rst = 1'b0;
        K=0;
        J=0;
    end
always #(`T_CLK/2) clk = ~clk;
    initial begin
        #(`T_CLK/2)n_rst = 1'b1;
        #(`T_CLK)K=0;
        J=1;

        #(`T_CLK)K=0;
        J=0;

        #(`T_CLK)K=1;
        J=0;

        #(`T_CLK)K=0;
        J=1;

        #(`T_CLK)K=1;
        J=1;
        $stop;
    end

    
endmodule