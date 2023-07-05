`define T_CLK 10
`timescale 1ns/1ps

module testbench();
  reg in;
  reg [1:0] sel;
  wire [3:0] out;

  DEMux_1to4 uut_demux(
    .in(in),
    .sel(sel),
    .out(out)

  );

  initial begin
    // 초기화
    in = 1'b0;
    sel = 2'b00;
    
    // 시뮬레이션 시간 진행
    #`T_CLK
    
    // 입력 데이터 변경 및 선택 비트 변경에 따른 출력 확인
    in = 1'b1;
    sel = 2'b01;
    #`T_CLK
    
    in = 1'b0;
    sel = 2'b10;
    #`T_CLK
    
    in = 1'b1;
    sel = 2'b11;
    #`T_CLK

    // 시뮬레이션 종료
    $finish;
  end

endmodule
