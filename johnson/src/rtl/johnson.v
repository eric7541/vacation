module johnson(
  input wire clk,
  input wire n_rst,
  output reg [3:0] count
);


  always @(posedge clk or negedge n_rst) begin
    if (!n_rst) begin
      count <= 4'b0000;
    end else begin
      count <= {count[2:0], ~count[3]};
    end
  end

endmodule
