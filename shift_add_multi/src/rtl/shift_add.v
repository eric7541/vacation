module Shift_Add_Multi (
  input wire [3:0] A,
  input wire [3:0] B,
  output wire [7:0] Product
);

  reg [7:0] partial_product;
  reg [3:0] i;

  always @(A or B) begin
    partial_product = 8'b00000000;

    for (i = 0; i < 4; i = i + 1) begin
      if (B[i] == 1)
        partial_product = partial_product + (A << i);
    end
  end

  assign Product = partial_product;

endmodule
