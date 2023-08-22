module tx (
    input clk,
    input n_rst,
    input [7:0] tx_data,
    output reg txd
);

    reg [1:0] c_state; // Current state of the transmitter
    reg [1:0] n_state; // Next state of the transmitter

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
            txd <= 1'b1; // Start bit
        else begin
            case (c_state)
                SR0: txd <= 1'b1; // Start bit
                SR2: txd <= tx_data[0]; // Transmit data bit 0
                SR3: txd <= 1'b0; // Stop bit
                default: txd <= 1'b1; // Start bit
            endcase
        end
    end

endmodule
