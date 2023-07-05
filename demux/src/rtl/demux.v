module DEMux_1to4(
  input in, 
  input [1:0] sel, 
  output reg [3:0]out
);
  // 1:4 DEMUX 모듈 정의

  always@(*)begin
    out[sel]=in;
  end

endmodule
