module Shift_Register_Counter(
  input clk,
  input n_rst,
  output reg [3:0] count
);
  // 4비트 Shift Register Counter 모듈 정의

  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      count <= 4'b0001;
    end else begin
      count <= {count[2:0], count[3]};
    end
  end
endmodule
