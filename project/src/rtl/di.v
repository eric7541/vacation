module di (//나눗셈
    input clk,                        // 클럭 신호 입력
    input n_rst,                     // 리셋 신호 입력
    input wire [15:0] src1,          // 16비트 소스1 입력
    input wire [15:0] src2,          // 16비트 소스2 입력
    output wire [31:0] calc_res      // 32비트 계산 결과 출력
);
    reg [15:0] dividend_reg;          // 16비트 나누는 수 레지스터
    reg [15:0] divisor_reg;           // 16비트 나누는 수 레지스터
    reg [31:0] quotient_reg;          // 32비트 몫 레지스터
    reg [15:0] remainder_reg;         // 16비트 나머지 레지스터
    reg [4:0] count;                  // 5비트 카운터 레지스터
    reg is_dividing;                  // 나눗셈 진행 여부 신호
    
    // 소스1과 소스2를 레지스터에 할당하는 논리
    always @(*) begin
        dividend_reg <= src1;         // 소스1을 dividend_reg에 할당
        divisor_reg <= src2;          // 소스2를 divisor_reg에 할당
    end
    
    // 나눗셈 연산을 수행하는 논리
    always @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            quotient_reg <= 32'b0;    // 리셋 시 몫 초기화
            remainder_reg <= 16'b0;   // 리셋 시 나머지 초기화
            count <= 5'b0;            // 리셋 시 카운터 초기화
            is_dividing <= 1'b0;      // 리셋 시 나눗셈 진행 여부 초기화
        end else begin
            if (is_dividing) begin
                if (dividend_reg >= divisor_reg) begin
                    dividend_reg <= dividend_reg - divisor_reg;
                    quotient_reg <= quotient_reg + 1'b1;
                end
            end
        end
    end
    
    // 나눗셈 진행 여부와 나머지 계산 논리
    always @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            is_dividing <= 1'b0;        // 리셋 시 나눗셈 진행 여부 초기화
        end else begin
            if (count < 5'b10000) begin
                is_dividing <= 1'b1;     // 나눗셈 진행 중
                remainder_reg <= {remainder_reg[14:0], dividend_reg[15]};
                count <= count + 1'b1;   // 카운터 증가
            end else begin
                is_dividing <= 1'b0;     // 나눗셈 종료
            end
        end
    end
    
    assign calc_res = {quotient_reg, remainder_reg};  // 결과 계산 및 출력
    
endmodule
