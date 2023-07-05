`timescale 1ns/100ps
`define T_CLK 10
module testbench;
  reg clk;
  reg n_rst;
  reg [31:0] a;
  reg [31:0] b;
  reg operator;
  reg data_type;
  reg parser_done;
  wire [31:0] result;
  wire alu_done;
  wire [31:0] alu_out;

  // 모듈 인스턴스 생성
  sub dut (
    .clk(clk),
    .n_rst(n_rst),
    .a(a),
    .b(b),
    .operator(operator),
    .data_type(data_type),
    .parser_done(parser_done),
    .result(result),
    .alu_done(alu_done),
    .alu_out(alu_out)
  );
    initial begin
    clk = 1;
    n_rst = 0;
    a = 0;
    b = 0;
    operator = 0;
    data_type = 0;
    parser_done = 0;
    end
  // 입력값 설정
  initial begin
    #(`T_CLK/2)n_rst = 1'b1;
    a = 123;
    b = 456;
    operator = 1;
    data_type = 1;
    parser_done = 1;
    #10;

    // $stop을 통해 시뮬레이션 종료
    $stop;
  end
endmodule
