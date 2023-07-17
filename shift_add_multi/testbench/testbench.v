module testbench;

  reg [3:0] A;
  reg [3:0] B;
  wire [7:0] Product;

  Shift_Add_Multi DUT (
    .A(A),
    .B(B),
    .Product(Product)
  );

  initial begin

    // Test Case 1: A = 5, B = 3
    #10 A = 4'b0101;
    #10 B = 4'b0011;

    // Test Case 2: A = 7, B = 2
    #10 A = 4'b0111;
    #10 B = 4'b0010;

    // Test Case 3: A = 10, B = 15
    #10 A = 4'b1010;
    #10 B = 4'b1111;

    // 종료
    #10 $finish;
  end

endmodule
