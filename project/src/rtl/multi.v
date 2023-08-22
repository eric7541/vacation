module multi (
    input clk,                        // 클럭 신호 입력
    input n_rst,                     // 리셋 신호 입력
    input wire [15:0] src1,          // 16비트 소스1 입력
    input wire [15:0] src2,          // 16비트 소스2 입력
    output wire [31:0] calc_res      // 32비트 계산 결과 출력
);

    reg [15:0] src1_reg;              // 소스1 레지스터
    reg [15:0] src2_reg;              // 소스2 레지스터
    reg [31:0] result_reg;            // 결과 레지스터
    reg [4:0] counter;                // 카운터 레지스터

    always @(posedge clk or posedge n_rst) begin
        if (n_rst) begin
            src1_reg <= 16'b0;        // 리셋 시 소스1 초기화
            src2_reg <= 16'b0;        // 리셋 시 소스2 초기화
            result_reg <= 32'b0;      // 리셋 시 결과 초기화
            counter <= 5'b0;          // 리셋 시 카운터 초기화
        end else begin
            src1_reg <= src1;          // 클럭 엣지에서 소스1 업데이트
            src2_reg <= src2;          // 클럭 엣지에서 소스2 업데이트
            
            if (counter < 5'd16) begin
                result_reg <= {16'b0, result_reg[31:1]} + (src1_reg & src2_reg[0]);
                src2_reg <= src2_reg >> 1;
                counter <= counter + 1;
            end
        end
    end

    assign calc_res = result_reg;      // 계산 결과 출력

endmodule
