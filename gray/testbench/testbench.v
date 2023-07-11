`define T_CLK 10
`timescale 1ns/1ps

module testbench();
  reg clk;
  reg n_rst;
  wire [3:0] count;
  wire [2:0] gray;
  reg j;

  gray uut_gray(
    .clk(clk),
    .n_rst(n_rst),
    .count(count),
    .gray(gray)
  );

  always #(`T_CLK/2) clk = ~clk;

  initial begin
    clk = 1'b1;
    n_rst = 1'b0;
    
    // 리셋 전에 카운터 값을 초기화합니다.
    #(`T_CLK) n_rst = 1'b1;
    
    // 카운터 값이 순환하는 동안 기다립니다.
    for (j = 0; j < 10; j = j + 1)
      #(`T_CLK) ;
    
    $stop;
  end
endmodule
