module binary(
  input clk,
  input n_rst,
  output reg [3:0] count
);
  // 4비트 Binary Counter 모듈 정의

  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      count <= 4'b0000;
    end else begin
      count <= count + 1;
    end
  end
endmodule
