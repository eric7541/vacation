module decoder (
    input clk,                    // 클럭 신호 입력
    input n_rst,                 // 리셋 신호 입력
    input [7:0] data,            // 8비트 데이터 입력
    input dout_valid,            // 데이터 유효성 신호 입력
    output reg [3:0] data_type,  // 4비트 데이터 타입 출력
    output reg [4:0] operator,   // 5비트 연산자 출력
    output reg [15:0] src1,      // 16비트 소스1 출력
    output reg [15:0] src2,      // 16비트 소스2 출력
    output reg parser_done       // 파서 완료 여부 출력
);
    reg [7:0] command [0:13];    // 8비트 명령어 배열
    reg [3:0] format_temp;        // 4비트 포맷 임시 변수
    reg [4:0] type_temp;          // 5비트 타입 임시 변수
    reg [15:0] src1_temp;        // 16비트 소스1 임시 변수
    reg [15:0] src2_temp;        // 16비트 소스2 임시 변수
    reg end_protocol_temp;       // 종료 프로토콜 임시 변수
    reg [3:0] state;             // 상태 변수
    reg [3:0] count;             // 카운트 변수
    
    initial begin
        state = 0;               // 초기 상태 설정
        count = 0;               // 초기 카운트 설정
        parser_done = 0;         // 파서 완료 신호 초기화
    end
    
    always @(posedge txd) begin
        case(state)
            0: begin // Idle state
                command[count] = txd;               // 명령어 배열에 데이터 저장
                count = count + 1;                  // 카운트 증가
                
                if (count == 14) begin              // 14개의 데이터를 받았을 때
                    format_temp = command[0][3:0];  // 포맷 정보 추출
                    type_temp = command[1][4:0];    // 타입 정보 추출
                    src1_temp = {command[2], command[3]};  // 소스1 정보 추출
                    src2_temp = {command[4], command[5]};  // 소스2 정보 추출
                    end_protocol_temp = (command[6] == 8'b10111101);  // 종료 프로토콜 확인
                    
                    format <= format_temp;           // 포맷 출력 설정
                    type <= type_temp;               // 타입 출력 설정
                    src1 <= src1_temp;               // 소스1 출력 설정
                    src2 <= src2_temp;               // 소스2 출력 설정
                    end_protocol <= end_protocol_temp;  // 종료 프로토콜 출력 설정
                    
                    count = 0;                      // 카운트 초기화
                    state = 1;                      // 상태를 Command processing state로 전환
                    parser_done <= 1;               // 파서 완료 신호 설정
                end
            end
            
            1: begin // Command processing state
                // 명령어를 받아 처리하는 상태입니다. 필요한 계산을 수행합니다.
                
                parser_done <= 0;   // 파서 완료 신호 초기화
                state = 0;          // 명령어 처리 후 Idle state로 돌아감
            end
        endcase
    end
endmodule



module decoder (
    input clk,                    // 클럭 신호 입력
    input n_rst,                 // 리셋 신호 입력
    input [7:0] data,            // 8비트 데이터 입력
    input dout_valid,            // 데이터 유효성 신호 입력
    output reg [3:0] data_type,  // 4비트 데이터 타입 출력
    output reg [4:0] operator,   // 5비트 연산자 출력
    output reg parser_done,      // 파서 완료 여부 출력
    output reg [15:0] src1,      // 16비트 소스1 출력
    output reg [15:0] src2       // 16비트 소스2 출력
);
    reg [7:0] op_code;            // 8비트 연산 코드 레지스터
    reg [2:0] dt;                 // 3비트 데이터 타입 레지스터

    // 초기 값 설정
    initial begin
        data_type = 0;            // 데이터 타입 초기화
        operator = 0;             // 연산자 초기화
        parser_done = 0;          // 파서 완료 초기화
        src1 = 0;                 // 소스1 초기화
        src2 = 0;                 // 소스2 초기화
    end

    // 데이터 타입 추출 논리
    always @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            dt <= 0;              // 리셋 시 데이터 타입 초기화
        end else begin
            if (dout_valid) begin
                dt <= data[3:1];  // 데이터 유효성이 있을 때 데이터 타입 추출
                case (dt)
                    3'b000: data_type <= 4'b0000; // Type A
                    3'b001: data_type <= 4'b0001; // Type B
                    default: data_type <= 4'b0000;
                endcase
            end
        end
    end

    // 연산자 코드 추출 논리
    always @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            op_code <= 0;          // 리셋 시 연산자 코드 초기화
        end else begin
            if (dout_valid) begin
                op_code <= data[7:4]; // 데이터 유효성이 있을 때 연산자 코드 추출
                case (op_code)
                    4'b0000: operator <= 5'b00000; // Addition
                    4'b0001: operator <= 5'b00001; // Subtraction
                    4'b0010: operator <= 5'b00010; // AND
                    4'b0011: operator <= 5'b00011; // (다른 연산자들을 추가할 수 있음)
                    default: operator <= 5'b00000;
                endcase
            end
        end
    end

    // 파서 완료 여부 설정 논리
    always @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            parser_done <= 0;      // 리셋 시 파서 완료 초기화
        end else begin
            parser_done <= 1;      // 파서 완료 신호 설정
        end
    end

    // 소스1 추출 논리
    always @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            src1 <= 0;            // 리셋 시 소스1 초기화
        end else begin
            src1 <= data[15:0];   // 데이터 유효성이 있을 때 소스1 추출
        end
    end

    // 소스2 추출 논리
    always @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            src2 <= 0;            // 리셋 시 소스2 초기화
        end else begin
            src2 <= data[31:16];  // 데이터 유효성이 있을 때 소스2 추출
        end
    end
endmodule
