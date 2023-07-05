module T(
  input wire clk,
  input wire n_rst,
  input wire T,
  output reg Q
);

  always @(posedge clk or posedge n_rst) begin
    if (!n_rst)
      Q <= 1'b0; // 리셋 시 Q를 0으로 설정합니다.
    else begin
      if (T)
        Q <= ~Q; // T가 1인 경우 Q를 반전시킵니다.
    end
  end
  
endmodule
