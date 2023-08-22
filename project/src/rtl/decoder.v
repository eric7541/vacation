

module decoder (
    input clk,
    input n_rst,
    input [7:0] data,
    input dout_valid,
    output reg [3:0] data_type,
    output reg [4:0] operator,
    output reg [15:0] src1,
    output reg [15:0] src2,
    output reg parser_done
);
    reg [7:0] command [0:13];
    reg [3:0] format_temp;
    reg [4:0] type_temp;
    reg [15:0] src1_temp;
    reg [15:0] src2_temp;
    reg end_protocol_temp;
    reg [3:0] state;
    reg [3:0] count;
    
    initial begin
        state = 0;
        count = 0;
        parser_done = 0;
    end
    
    always @(posedge txd) begin
        case(state)
            0: begin // Idle state
                command[count] = txd;
                count = count + 1;
                
                if (count == 14) begin
                    format_temp = command[0][3:0];
                    type_temp = command[1][4:0];
                    src1_temp = {command[2], command[3]};
                    src2_temp = {command[4], command[5]};
                    end_protocol_temp = (command[6] == 8'b10111101);
                    
                    format <= format_temp;
                    type <= type_temp;
                    src1 <= src1_temp;
                    src2 <= src2_temp;
                    end_protocol <= end_protocol_temp;
                    
                    count = 0;
                    state = 1;
                    parser_done <= 1;
                end
            end
            
            1: begin // Command processing state
                // Perform necessary calculations based on the command received
                
                parser_done <= 0;
                state = 0; // Return to idle state after processing command
            end
        endcase
    end
endmodule






module decoder(
    input clk,
    input n_rst,
    input [7:0] data,
    input dout_valid,
    output reg [3:0] data_type,
    output reg [4:0] operator,
    output reg parser_done,
    output reg [15:0] src1,
    output reg [15:0] src2
);
    // Internal signals
    reg [7:0] op_code;
    reg [2:0] dt;
    // Default values
    initial begin
        data_type = 0;
        operator = 0;
        parser_done = 0;
        src1 = 0;
        src2 = 0;
    end
    always @(posedge clk or negedge n_rst)begin
        if(!n_rst) begin
            dt <= 0;
        end else begin
            if (dout_valid)begin
                dt <= data[3:1];
                case(dt)
                    case (dt)
                    3'b000: data_type <= 4'b0000; // Type A
                    3'b001: data_type <= 4'b0001; // Type B
                   

                    default: data_type <= 4'b0000;
                endcase
                endcase

            end
        end

    end
    always @(posedge clk or negedge n_rst)begin
        if(!n_rst) begin
            op_code <= 0;
        end else begin
            if (dout_valid)begin
                op_code <= data[7:4];

                case (op_code)
                    4'b0000: operator <= 5'b00000; // Addition
                    4'b0001: operator <= 5'b00001; // Subtraction
                    4'b0010: operator <= 5'b00010; // and
                    4'b0011: operator <= 5'b00011; // 
               

                    default: operator <= 5'b00000;

                endcase
            end
        end

    end

    always@(posedge clk or negedge n_rst)begin
        if(!n_rst)begin
            parser_done <= 0;
        end else begin
            parser_done <= 1;
        end
    end

    always@(posedge clk or negedge n_rst)begin
        if(!n_rst)begin
            src1 <= 0;
        end else begin
            src1 <= data[15:0];
        end
    end

    always@(posedge clk or negedge n_rst)begin
        if(!n_rst)begin
            src2 <= 0;
        end else begin
            src2 <= data[31:16];
        end
    end
endmodule