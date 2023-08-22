module sig_add (
  input  clk,     // 클럭 입력
  input  n_rst,   // 비동기 리셋 입력
  input  [16-1:0] M, // 피승수
  input  [16-1:0] Q, // 승수
  output [2*16-1:0] result // 결과
);
  parameter N = 16; // 피승수와 승수의 비트 수
  
  reg [N-1:0] A; // A 변수
  reg [N-1:0] q; // q 변수
  reg q0; // q0 변수
  reg [N:0] count; // 반복 횟수 변수
  
  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      A <= 0; // A를 0으로 초기화
      q <= Q; // q를 0으로 초기화
      q0 <= 0; // q0를 0으로 초기화*/
      count <= 4; // count를 0으로 초기화
    end else begin
      if (count != 0) begin
        case ({q[0], q0})
          2'b11, 2'b00: A = A; // A 유지
          2'b01: A = A + M; // A에 M을 더함
          2'b10: A = A + (~M+1'b1); // A에 M을 뺌
        endcase
        
        // Right shift 수행
        A <= {A[N-1], A[N-1:1]}; // A에 sign extension 수행
        q <= {A[0], q[N-1:1]}; // q를 오른쪽으로 1비트 시프트
        q0 <= q[0]; // q0에 최하위 비트 할당
        count <= count - 1; // count 1 증가
      end
    end
  end
  
  assign result = {A, q}; // 결과값 할당
  
endmodule
