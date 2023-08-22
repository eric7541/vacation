
module rx (
    clk,
    n_rst,
    rxd,
    rx_data
);
input clk;
input n_rst;
input rxd;

output [7:0] rx_data;
reg [7:0] rx_data;


    reg [1:0] c_state; // Current state of the receiver
    reg [1:0] n_state; // Next state of the receiver

    reg [15:0] c_cnt1; // Current value of counter 1 (sclk generation counter)
    reg [15:0] n_cnt1; // Next value of counter 1

    reg [3:0] c_cnt2; // Current value of counter 2 (sclk counting counter)
    reg [3:0] n_cnt2; // Next value of counter 2

    localparam SR0 = 2'h0; // State 0
    localparam SR1 = 2'h1; // State 1
    localparam SR2 = 2'h2; // State 2
    localparam SR3 = 2'h3; // State 3

    localparam FLG1 = 16'h1458; // Flag 1 value
    localparam FLG2 = 4'ha;     // Flag 2 value

    // State and counter updates on positive clock edge or negative reset edge
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

    reg sclk; // Sclk signal

    // Sclk generation logic on positive clock edge or negative reset edge
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

    reg sclk_d; // Delayed sclk signal
    wire sclk_f; // Falling edge detection of sclk

    // Sclk delay logic on positive clock edge or negative reset edge
    always @(posedge clk or negedge n_rst) begin
        if (!n_rst)
            sclk_d <= 1'b1;
        else
            sclk_d <= sclk;
    end

    assign sclk_f = (sclk == 1'b0) && (sclk_d == 1'b1); // Detect falling edge of sclk

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
