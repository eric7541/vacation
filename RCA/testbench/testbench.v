module testbench();
  reg [31:0] a, b;
  reg Cin;
  wire [31:0] Sum;
  wire Cout;

  rca_32bit dut(
    .a(a),
    .b(b),
    .Cin(Cin),
    .Sum(Sum),
    .Cout(Cout)
  );

  initial begin
    // 입력값 설정
    a = 32'b11101010101010101010101010101010;
    b = 32'b01010101010101010101010101010101;
    Cin = 1'b0;

  end

endmodule
