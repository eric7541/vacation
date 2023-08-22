module tx (
    input clk,              // 클럭 입력
    input n_rst,            // 비동기 리셋 입력
    input [7:0] tx_data,    // 송신할 데이터 입력 (8비트)
    output reg txd          // 송신 데이터 출력
);

    reg [1:0] c_state;       // 송신기의 현재 상태
    reg [1:0] n_state;       // 송신기의 다음 상태

    reg [15:0] c_cnt1;       // 현재 카운터 1의 값 (sclk 생성 카운터)
    reg [15:0] n_cnt1;       // 다음 카운터 1의 값

    reg [3:0] c_cnt2;        // 현재 카운터 2의 값 (sclk 카운트 카운터)
    reg [3:0] n_cnt2;        // 다음 카운터 2의 값

    localparam SR0 = 2'h0;   // 상태 0
    localparam SR1 = 2'h1;   // 상태 1
    localparam SR2 = 2'h2;   // 상태 2
    localparam SR3 = 2'h3;   // 상태 3

    localparam FLG1 = 16'h1458; // 플래그 1 값
    localparam FLG2 = 4'ha;     // 플래그 2 값

    // 클럭 엣지 또는 비동기 리셋 엣지에서 상태 및 카운터 업데이트
    always @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            c_state <= SR0;
            c_cnt1 <= 16'h0001;
            c_cnt2 <= 4'h1;
        end
        else begin
            c_state <= n_state;
            c_cnt1 <= n_cnt1;
            c_cnt2 <= n_cnt2;
        end
    end

    reg sclk;                // Sclk 신호

    // 클럭 엣지 또는 비동기 리셋 엣지에서 Sclk 생성 논리
    always @(posedge clk or negedge n_rst) begin
        if (!n_rst)
            sclk <= 1'b1;
        else begin
            if (c_cnt1 < 16'h0A2D)
                sclk <= 1'b1;
            else
                sclk <= 1'b0;
        end
    end

    reg sclk_d;              // 지연된 Sclk 신호
    wire sclk_f;             // Sclk의 하강 에지 감지

    // 클럭 엣지 또는 비동기 리셋 엣지에서 Sclk 지연 논리
    always @(posedge clk or negedge n_rst) begin
        if (!n_rst)
            sclk_d <= 1'b1;
        else
            sclk_d <= sclk;
    end

    assign sclk_f = (sclk == 1'b0) && (sclk_d == 1'b1); // Sclk의 하강 에지 감지

    always @(*) begin
        case (c_state)
            SR0: n_cnt2 = 4'h1;
            default: begin
                if (sclk_f == 1'b0)
                    n_cnt2 = c_cnt2;
                else begin
                    if (c_cnt2 == FLG2)
                        n_cnt2 = 4'h1;
                    else
                        n_cnt2 = c_cnt2 + 4'h1;
                end
            end
        endcase
    end

    always @(posedge clk or negedge n_rst) begin
        if (!n_rst)
            txd <= 1'b1; // 시작 비트
        else begin
            case (c_state)
                SR0: txd <= 1'b1;         // 시작 비트
                SR2: txd <= tx_data[0];   // 데이터 비트 0 전송
                SR3: txd <= 1'b0;         // 정지 비트
                default: txd <= 1'b1;     // 시작 비트
            endcase
        end
    end

endmodule
