module decoder(
  input [3:0] select, 
  output [15:0] out);
  // 16개의 출력 비트를 가진 4비트 디코더 모듈 정의

  assign out[0]  = (select == 4'b0000) ? 1'b1 : 1'b0;
  assign out[1]  = (select == 4'b0001) ? 1'b1 : 1'b0;
  assign out[2]  = (select == 4'b0010) ? 1'b1 : 1'b0;
  assign out[3]  = (select == 4'b0011) ? 1'b1 : 1'b0;
  assign out[4]  = (select == 4'b0100) ? 1'b1 : 1'b0;
  assign out[5]  = (select == 4'b0101) ? 1'b1 : 1'b0;
  assign out[6]  = (select == 4'b0110) ? 1'b1 : 1'b0;
  assign out[7]  = (select == 4'b0111) ? 1'b1 : 1'b0;
  assign out[8]  = (select == 4'b1000) ? 1'b1 : 1'b0;
  assign out[9]  = (select == 4'b1001) ? 1'b1 : 1'b0;
  assign out[10] = (select == 4'b1010) ? 1'b1 : 1'b0;
  assign out[11] = (select == 4'b1011) ? 1'b1 : 1'b0;
  assign out[12] = (select == 4'b1100) ? 1'b1 : 1'b0;
  assign out[13] = (select == 4'b1101) ? 1'b1 : 1'b0;
  assign out[14] = (select == 4'b1110) ? 1'b1 : 1'b0;
  assign out[15] = (select == 4'b1111) ? 1'b1 : 1'b0;
endmodule
