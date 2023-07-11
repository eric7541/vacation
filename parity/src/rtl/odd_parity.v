module odd_parity(
  input [7:0] data,
  output reg parity
);
integer i;

  always @(*) begin
    parity = 1'b1;
    for (i = 0; i<8;i=i+1)
      parity = parity ^data[i];
  end
    

endmodule
