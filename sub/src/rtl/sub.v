module sub (
  input [31:0] a,
  input [31:0] b,
  output [31:0] result
);
  wire [31:0] difference;
  wire borrow;

  // 반가산기(Half Adder) 정의
  module HalfAdder(
    input a,
    input b,
    output sum,
    output carry
  );
    assign {carry, sum} = a + b;
  endmodule

  // 전가산기(Full Adder) 정의
  module FullAdder(
    input a,
    input b,
    input carry_in,
    output sum,
    output carry_out
  );
    wire s1, c1, c2;
    HalfAdder HA1(a, b, s1, c1);
    HalfAdder HA2(s1, carry_in, sum, c2);
    assign carry_out = c1 | c2;
  endmodule

  // 32비트 서브트랙션 회로 정의
  wire [31:0] borrow_chain;
  assign borrow_chain[0] = borrow;
  FullAdder FA1(a[0], ~b[0], ~borrow, difference[0], borrow_chain[1]);
  FullAdder FA2(a[1], ~b[1], ~borrow_chain[1], difference[1], borrow_chain[2]);
  FullAdder FA3(a[2], ~b[2], ~borrow_chain[2], difference[2], borrow_chain[3]);
  FullAdder FA4(a[3], ~b[3], ~borrow_chain[3], difference[3], borrow_chain[4]);
  FullAdder FA5(a[4], ~b[4], ~borrow_chain[4], difference[4], borrow_chain[5]);
  FullAdder FA6(a[5], ~b[5], ~borrow_chain[5], difference[5], borrow_chain[6]);
  FullAdder FA7(a[6], ~b[6], ~borrow_chain[6], difference[6], borrow_chain[7]);
  FullAdder FA8(a[7], ~b[7], ~borrow_chain[7], difference[7], borrow_chain[8]);
  FullAdder FA9(a[8], ~b[8], ~borrow_chain[8], difference[8], borrow_chain[9]);
  FullAdder FA10(a[9], ~b[9], ~borrow_chain[9], difference[9], borrow_chain[10]);
  FullAdder FA11(a[10], ~b[10], ~borrow_chain[10], difference[10], borrow_chain[11]);
  FullAdder FA12(a[11], ~b[11], ~borrow_chain[11], difference[11], borrow_chain[12]);
  FullAdder FA13(a[12], ~b[12], ~borrow_chain[12], difference[12], borrow_chain[13]);
  FullAdder FA14(a[13], ~b[13], ~borrow_chain[13], difference[13], borrow_chain[14]);
  FullAdder FA15(a[14], ~b[14], ~borrow_chain[14], difference[14], borrow_chain[15]);
  FullAdder FA16(a[15], ~b[15], ~borrow_chain[15], difference[15], borrow_chain[16]);
  FullAdder FA17(a[16], ~b[16], ~borrow_chain[16], difference[16], borrow_chain[17]);
  FullAdder FA18(a[17], ~b[17], ~borrow_chain[17], difference[17], borrow_chain[18]);
  FullAdder FA19(a[18], ~b[18], ~borrow_chain[18], difference[18], borrow_chain[19]);
  FullAdder FA20(a[19], ~b[19], ~borrow_chain[19], difference[19], borrow_chain[20]);
  FullAdder FA21(a[20], ~b[20], ~borrow_chain[20], difference[20], borrow_chain[21]);
  FullAdder FA22(a[21], ~b[21], ~borrow_chain[21], difference[21], borrow_chain[22]);
  FullAdder FA23(a[22], ~b[22], ~borrow_chain[22], difference[22], borrow_chain[23]);
  FullAdder FA24(a[23], ~b[23], ~borrow_chain[23], difference[23], borrow_chain[24]);
  FullAdder FA25(a[24], ~b[24], ~borrow_chain[24], difference[24], borrow_chain[25]);
  FullAdder FA26(a[25], ~b[25], ~borrow_chain[25], difference[25], borrow_chain[26]);
  FullAdder FA27(a[26], ~b[26], ~borrow_chain[26], difference[26], borrow_chain[27]);
  FullAdder FA28(a[27], ~b[27], ~borrow_chain[27], difference[27], borrow_chain[28]);
  FullAdder FA29(a[28], ~b[28], ~borrow_chain[28], difference[28], borrow_chain[29]);
  FullAdder FA30(a[29], ~b[29], ~borrow_chain[29], difference[29], borrow_chain[30]);
  FullAdder FA31(a[30], ~b[30], ~borrow_chain[30], difference[30], borrow_chain[31]);

  // 결과 및 출력 설정
  assign result = difference;

endmodule
