module alu (
    input [3:0] dtype,             // 데이터 타입 (4비트)
    input [4:0] operator,          // ALU 연산자 (5비트)
    input [15:0] src1,             // 첫 번째 소스 데이터 (16비트)
    input [15:0] src2,             // 두 번째 소스 데이터 (16비트)
    input parser_done,             // 파서 작업 완료 여부 신호
    output reg [31:0] calc_res,    // ALU 결과 값 (32비트)
    output reg alu_done            // ALU 연산 완료 여부 신호
);

    // ALU 연산 종류 정의
    parameter ADD = 5'b00000;      // 덧셈 연산
    parameter SUB = 5'b00001;      // 뺄셈 연산
    parameter AND = 5'b00010;      // 논리 AND 연산
    parameter OR  = 5'b00011;      // 논리 OR 연산
    parameter XOR = 5'b00100;      // 논리 XOR 연산
    // 필요한 연산 종류를 추가할 수 있음
    
    // 데이터 타입 정의
    parameter UNSIGNED = 4'b0000;  // 부호 없는 데이터 타입
    parameter SIGNED   = 4'b0001;  // 부호 있는 데이터 타입
    // 필요한 데이터 타입을 추가할 수 있음
    
    // 내부 신호 정의
    reg [31:0] result;              // ALU 연산 결과를 저장하는 레지스터
    
    // ALU 연산 수행
    always @ (*) begin
        case (operator)
            ADD:
                result = src1 + src2;
            SUB:
                result = src1 - src2;
            AND:
                result = src1 & src2;
            OR:
                result = src1 | src2;
            XOR:
                result = src1 ^ src2;
            // 필요한 연산을 추가할 수 있음
            default:
                result = 0;
        endcase
    end
    
    // 데이터 타입 변환
    always @ (*) begin
        case (dtype)
            UNSIGNED:
                calc_res = result;
            SIGNED:
                calc_res = $signed(result);
            // 필요한 데이터 타입 변환을 추가할 수 있음
            default:
                calc_res = 0;
        endcase
    end
    
    // ALU 제어
    always @ (*) begin
        if (parser_done)
            alu_done = 1;             // 파서 작업이 완료되면 ALU 완료 신호 활성화
        else
            alu_done = 0;             // 그렇지 않으면 비활성화
    end
    
endmodule
