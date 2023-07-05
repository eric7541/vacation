module mux(
  input sel, 
  output out);
  // 2:1 MUX 모듈 정의

  assign out = (sel == 1'b0) ? 1'b0 : 1'b1;
endmodule
