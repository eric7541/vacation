
module un_add (
  input clk,
  input n_rst,
  input wire [15:0] M,
  input wire [15:0] Q,
  output wire [31:0] product
);

  reg [3:0] A;
  reg [3:0] q;
  reg c;
  reg [3:0] count;

  always @(*) begin
    A = 4'b0000;
    q = Q;
    c = 0;
    count = 4;
  end

  always @(posedge clk or negedge n_rst) begin
    if (!n_rst)
      count <= 4;
    else if (count != 0) begin
      if (q[0] == 1) begin
        A <= A + M;
        c <= A[3];
        {A, q, c} <= {c, A[3:1], q[3:1], q[0]};
        count <= count - 1;
      end
      else begin
      {A, q, c} <= {c, A[3:1], q[3:1], q[0]};
      count <= count - 1;
      end
    end
  end

  assign product = {A, q};

endmodule
