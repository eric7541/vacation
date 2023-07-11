module gray(
  input  clk,
  input  n_rst,
  output reg [3:0] count,
  output reg [2:0] gray
);

  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      count <= 4'b0000;
      gray <= 3'b000;
    end else begin
      count <= count + 1'b1;
      gray <= count ^ (count >> 1);
    end
  end

endmodule
