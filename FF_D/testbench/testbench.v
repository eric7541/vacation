`timescale 1ns/100ps
`define T_CLK 10
module testbench;
    reg clk;
    reg n_rst;
    reg D;
    wire Q;

    D uut_D(
        .clk(clk),
        .n_rst(n_rst),
        .D(D),
        .Q(Q)
    );
    initial begin
        clk = 1'b1;
        n_rst = 1'b0;
        D=0;
    end
always #(`T_CLK/2) clk = ~clk;
    initial begin
        #(`T_CLK/2)n_rst = 1'b1;    
        #(`T_CLK)D=1;

       
        #(`T_CLK)D=0;

 
   
        #(`T_CLK)D=1;


        #(`T_CLK)D=0;

        $stop;
    end

    
endmodule