`define T_CLK 10
`timescale 1ns/1ps
module testbench();
  reg clk;
  reg n_rst;
  wire [3:0] count;
  reg [3:0] j;

    Shift_Register_Counter uut_Shift_Register_Counter(
        .clk(clk),
        .n_rst(n_rst),
        .count(count)
    );
    always #(`T_CLK/2) clk = ~clk;
    initial begin
      clk = 1'b1;
      n_rst = 1'b0;
        for (j=0;j<4;j=j+1)
        #(`T_CLK)n_rst = 1'b1;
        
      $stop;

    end


    
endmodule