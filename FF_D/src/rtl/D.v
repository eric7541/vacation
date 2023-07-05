module D(
  input clk,
  input n_rst,
  input D,
  output reg Q
);

  always @(posedge clk or negedge n_rst) begin
    if (!n_rst)
      Q <= 1'b0; // 리셋 시 Q를 0으로 설정합니다.
    else
      Q <= D; // D 입력을 Q에 복사합니다.
  end
  
endmodule
