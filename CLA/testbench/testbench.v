module testbench;

  reg [31:0] A;
  reg [31:0] B;
  wire [31:0] Sum;
  wire Cout;

  CLA_32bit DUT (
    .A(A),
    .B(B),
    .Sum(Sum),
    .Cout(Cout)
  );

  initial begin
 
    // Test Case 1: A = 10, B = 20
    #10 A = 10;
    #10 B = 20;

    // Test Case 2: A = 123, B = 456
    #10 A = 123;
    #10 B = 456;

    // Test Case 3: A = 987654321, B = 123456789
    #10 A = 987654321;
    #10 B = 123456789;

    // 종료
    #10 $finish;
  end

endmodule
