`timescale 1ns/100ps
`define T_CLK 10
module testbench;
    reg clk;
    reg n_rst;
    reg [15:0] M;
    reg [15:0] Q;
    wire [31:0] result;

    di udd_di(
        .clk(clk),
        .n_rst(n_rst),
        .src1(M),
        .src2(Q),
        .calc_res(result)
    );
    initial begin
        clk = 1'b1;
        n_rst = 1'b0;
        M=16'b1001100110011001;
        Q=16'b0110011001100110;
    end
    always #(`T_CLK/2) clk = ~clk;
    initial begin
        #(`T_CLK/2)n_rst = 1'b1;


        #(`T_CLK*6)

        $stop;
    end

    
endmodule