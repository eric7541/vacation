module encoder(
input [1:0] select, 
output [3:0] out);
  // 2개의 입력 비트를 가진 4비트 인코더 모듈 정의

  assign out[0] = (select == 2'b00) ? 1'b1 : 1'b0;
  assign out[1] = (select == 2'b01) ? 1'b1 : 1'b0;
  assign out[2] = (select == 2'b10) ? 1'b1 : 1'b0;
  assign out[3] = (select == 2'b11) ? 1'b1 : 1'b0;
endmodule
