module subtract (
  input  clk,       // 클럭 입력
  input  n_rst,     // 비동기 리셋 입력
  input  [15:0] M,  // 피승수
  input  [15:0] Q,  // 승수
  output [31:0] result // 결과
);

reg [15:0] B_neg; // Q의 2의 보수 표현
reg [31:0] A_ext; // M을 16비트에서 32비트로 확장
wire [31:0] temp_result; // 중간 결과

// B_neg 계산 (Q의 2의 보수)
always @(*) begin
    B_neg = ~Q + 1;
end

// A_ext 계산 (M을 16비트에서 32비트로 확장)
always @(*) begin
    A_ext = {16'b0, M};
end

// 결과 계산
always @(posedge clk or posedge n_rst) begin
    if (n_rst) begin
        temp_result <= 32'b0;
    end else begin
        temp_result <= A_ext + B_neg;
    end
end

assign result = temp_result;

endmodule
