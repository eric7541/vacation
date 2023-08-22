module rx (
    clk,
    n_rst,
    rxd,
    rx_data
);
input clk;       // 클럭 입력
input n_rst;     // 비동기 리셋 입력
input rxd;       // 수신 데이터 입력

output [7:0] rx_data;  // 8비트 수신 데이터 출력
reg [7:0] rx_data;     // 8비트 레지스터로 선언

reg [1:0] c_state;     // 수신기의 현재 상태
reg [1:0] n_state;     // 수신기의 다음 상태

reg [15:0] c_cnt1;     // 카운터 1의 현재 값 (sclk 생성 카운터)
reg [15:0] n_cnt1;     // 카운터 1의 다음 값

reg [3:0] c_cnt2;      // 카운터 2의 현재 값 (sclk 카운트 카운터)
reg [3:0] n_cnt2;      // 카운터 2의 다음 값

localparam SR0 = 2'h0;  // 상태 0
localparam SR1 = 2'h1;  // 상태 1
localparam SR2 = 2'h2;  // 상태 2
localparam SR3 = 2'h3;  // 상태 3

localparam FLG1 = 16'h1458; // 플래그 1 값
localparam FLG2 = 4'ha;     // 플래그 2 값

// 양의 클럭 엣지 또는 비동기 리셋 엣지에서 상태 및 카운터 업데이트
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

// rxd 또는 n_cnt2에 따라 상태 업데이트
always @(rxd or n_cnt2) begin
    case (c_state)
        SR0: begin
            if (rxd == 1'b1)
                n_state = SR0;
            else
                n_state = SR1;
        end
        SR1: begin
            if (n_cnt2 == 4'h2)
                n_state = SR2;
            else
                n_state = c_state;
        end
        SR2: begin
            if (n_cnt2 == FLG2)
                n_state = SR3;
            else
                n_state = c_state;
        end
        SR3: begin
            if (n_cnt2 == 4'h1)
                n_state = SR0;
            else
                n_state = c_state;
        end
        default: n_state = SR0;
    endcase
end

// 상태에 따라 카운터 1 업데이트
always @(*) begin
    case (c_state)
        SR0: n_cnt1 = 16'h0001;
        default: begin
            if (c_cnt1 == FLG1)
                n_cnt1 = 16'h0001;
            else
                n_cnt1 = c_cnt1 + 16'h0001;
        end
    endcase
end

reg sclk; // Sclk 신호

// 양의 클럭 엣지 또는 비동기 리셋 엣지에서 Sclk 생성 논리
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

reg sclk_d; // 지연된 Sclk 신호
wire sclk_f; // Sclk의 하강 에지 감지

// 양의 클럭 엣지 또는 비동기 리셋 엣지에서 Sclk 지연 논리
always @(posedge clk or negedge n_rst) begin
    if (!n_rst)
        sclk_d <= 1'b1;
    else
        sclk_d <= sclk;
end

assign sclk_f = (sclk == 1'b0) && (sclk_d == 1'b1); // Sclk의 하강 에지 감지

// 상태에 따라 카운터 2 업데이트
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
        endcase
    end
end

always @(posedge clk or negedge n_rst) begin
    if (!n_rst)
        rx_data <= 8'h00;
    else begin
        if (c_state == SR2) begin
            if (sclk_f == 1'b1)
                rx_data <= {rxd, rx_data[7:1]};
            else
                rx_data <= rx_data;
        end
        else
            rx_data <= rx_data;
    end
end

endmodule
