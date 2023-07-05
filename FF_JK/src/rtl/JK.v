module JK(
  input wire clk,
  input wire n_rst,
  input wire J,
  input wire K,
  output reg Q
);

  always @(posedge clk or negedge n_rst) begin
    if (!n_rst)
      Q <= 1'b0; // 리셋 시 Q를 0으로 설정합니다.
    else begin
      if (J && ~K)
        Q <= 1'b1; // J가 1이고 K가 0인 경우 Q를 1로 설정합니다.
      else if (~J && K)
        Q <= 1'b0; // J가 0이고 K가 1인 경우 Q를 0으로 설정합니다.
      else if (J && K)
        Q <= ~Q; // J와 K가 모두 1인 경우 Q를 반전시킵니다.
    end
  end
  
endmodule

