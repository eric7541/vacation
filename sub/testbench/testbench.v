module testbench();
  reg [31:0] a;
  reg [31:0] b;
  wire [31:0] result;

  sub uut_sub(
    .a(a),
    .b(b),
    .result(result)
  );

  initial begin
    a = 32'b11101010101010101010101010101010;
    b = 32'b01010101010101010101010101010101; 
    


  end
endmodule
