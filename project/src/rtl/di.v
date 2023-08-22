module di (
    input clk,
    input n_rst,
    input wire [15:0] src1,
    input wire [15:0] src2,
    output wire [31:0] calc_res
);
    reg [15:0] dividend_reg;
    reg [15:0] divisor_reg;
    reg [31:0] quotient_reg;
    reg [15:0] remainder_reg;
    reg [4:0] count;
    reg is_dividing;
    
    always @(*) begin
        dividend_reg <= src1;
        divisor_reg <= src2;
    end
    
    always @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            quotient_reg <= 32'b0;
            remainder_reg <= 16'b0;
            count <= 5'b0;
            is_dividing <= 1'b0;
        end else begin
            if (is_dividing) begin
                if (dividend_reg >= divisor_reg) begin
                    dividend_reg <= dividend_reg - divisor_reg;
                    quotient_reg <= quotient_reg + 1'b1;
                end
            end
        end
    end
    
    always @(posedge clk or negedge n_rst) begin
        if (!n_rst) begin
            is_dividing <= 1'b0;
        end else begin
            if (count < 5'b10000) begin
                is_dividing <= 1'b1;
                remainder_reg <= {remainder_reg[14:0], dividend_reg[15]};
                count <= count + 1'b1;
            end else begin
                is_dividing <= 1'b0;
            end
        end
    end
    
    assign calc_res = {quotient_reg, remainder_reg};
    
endmodule
