`timescale 1ns/100ps
`define T_CLK 10
module testbench;
    reg clk;
    reg n_rst;
    reg S;
    reg R;
    wire Q;
    wire Q_bar;


    sr uut_sr(
        .clk(clk),
        .n_rst(n_rst),
        .S(S),
        .R(R),
        .Q(Q),
        .Q_bar(Q_bar)
    );
    initial begin
        clk = 1'b1;
        n_rst = 1'b0;
        S=0;
        R=1;
    end
    always #(`T_CLK/2) clk = ~clk;
    initial begin
        #(`T_CLK/2)n_rst = 1'b1;
        #(`T_CLK)S=1;
        R=1;

        #(`T_CLK)S=1;
        R=0;

        #(`T_CLK)S=0;
        R=1;

        #(`T_CLK)S=1;
        R=1;


        $stop;
    end

    
endmodule