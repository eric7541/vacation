module un_add (
  input clk,              // 클럭 입력
  input n_rst,            // 비동기 리셋 입력
  input wire [15:0] M,    // 피연산자 M (16비트)
  input wire [15:0] Q,    // 피연산자 Q (16비트)
  output wire [31:0] product // 결과 출력 (32비트)
);

  reg [3:0] A;             // 덧셈기의 레지스터 A (4비트)
  reg [3:0] q;             // 레지스터 q (4비트)
  reg c;                   // 캐리 비트
  reg [3:0] count;         // 카운터

  always @(*) begin
    A = 4'b0000;           // A 초기화
    q = Q;                 // q 초기화
    c = 0;                 // 캐리 비트 초기화
    count = 4;             // 카운터 초기화
  end

  always @(posedge clk or negedge n_rst) begin
    if (!n_rst)
      count <= 4;          // 리셋 시 카운터 초기화
    else if (count != 0) begin
      if (q[0] == 1) begin
        A <= A + M;         // M과 A를 더하고 결과를 A에 저장
        c <= A[3];          // 더하기 연산에서 발생한 캐리 비트 저장
        {A, q, c} <= {c, A[3:1], q[3:1], q[0]}; // 레지스터 값을 업데이트
        count <= count - 1; // 카운터를 감소시킴
      end
      else begin
        {A, q, c} <= {c, A[3:1], q[3:1], q[0]}; // 레지스터 값을 업데이트
        count <= count - 1; // 카운터를 감소시킴
      end
    end
  end

  assign product = {A, q}; // 결과 출력에 A와 q를 연결

endmodule
