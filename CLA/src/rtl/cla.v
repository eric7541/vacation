module CLA_32bit (
  input [31:0] A,
  input [31:0] B,
  output [31:0] Sum,
  output Cout
);

  wire [31:0] G;
  wire [31:0] P;
  wire [31:0] C;

  // Generate 연산
  assign G = A & B;

  // Propagate 연산
  assign P = A | B;

  // Carry Lookahead 계산
  assign C[0] = A[0] & B[0];  // 입력 비트 0에서의 Generate 연산
  assign C[1] = G[0] | (A[1] & B[1]);  // 입력 비트 1에서의 Generate 연산

  generate
    genvar i;
    for (i = 2; i < 32; i = i + 1) begin : GEN_C
      assign C[i] = G[i-1] | (P[i-1] & C[i-1]);
    end
  endgenerate

  // Carry Lookahead 연산 결과를 사용하여 Sum 계산
  assign Sum = A + B;

  // Carry Lookahead 연산 결과를 사용하여 Cout 계산
  assign Cout = C[31];

endmodule
