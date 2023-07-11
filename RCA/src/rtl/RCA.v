module rca_32bit(a, b, Cin, Sum, Cout);
	input [31:0] a, b;
	input Cin;
	output [31:0] Sum;
	output Cout;
	wire [2:0] Carry;
	
	rca_8bit rca_8bit01(.a(a[7:0]), .b(b[7:0]), .Cin(Cin), .Sum(Sum[7:0]), .Cout(Carry[0]));
	rca_8bit rca_8bit02(.a(a[15:8]), .b(b[15:8]), .Cin(Carry[0]), .Sum(Sum[15:8]), .Cout(Carry[1]));
	rca_8bit rca_8bit03(.a(a[23:16]), .b(b[23:16]), .Cin(Carry[1]), .Sum(Sum[23:16]), .Cout(Carry[2]));
	rca_8bit rca_8bit04(.a(a[31:24]), .b(b[31:24]), .Cin(Carry[2]), .Sum(Sum[31:24]), .Cout(Cout));
endmodule

module HalfAdder(a, b, Sum, Cout);
   input a, b;
   output Sum, Cout;
   
   assign Sum = a ^ b;
   assign Cout = a & b;
endmodule

module FullAdder(a, b, Cin, Sum, Cout);
	input a, b, Cin;
	output Sum, Cout;
	wire Sum01, Carry01, Carry02;
	
	HalfAdder HA01(.a(a), .b(b), .Sum(Sum01), .Cout(Carry01));
	HalfAdder HA02(.a(Sum01), .b(Cin), .Sum(Sum), .Cout(Carry02));
	
	assign Cout = Carry01 | Carry02;
endmodule

module rca_4bit(a, b, Cin, Sum, Cout);
	input [3:0] a, b;
	input Cin;
	output [3:0] Sum;
	output Cout;
	wire [2:0] Carry;
	
	FullAdder FA01(.a(a[0]), .b(b[0]), .Cin(Cin), .Sum(Sum[0]), .Cout(Carry[0]));
	FullAdder FA02(.a(a[1]), .b(b[1]), .Cin(Carry[0]), .Sum(Sum[1]), .Cout(Carry[1]));
	FullAdder FA03(.a(a[2]), .b(b[2]), .Cin(Carry[1]), .Sum(Sum[2]), .Cout(Carry[2]));
	FullAdder FA04(.a(a[3]), .b(b[3]), .Cin(Carry[2]), .Sum(Sum[3]), .Cout(Cout));
endmodule

module rca_8bit(a, b, Cin, Sum, Cout);
	input [7:0] a, b;
	input Cin;
	output [7:0] Sum;
	output Cout;
	wire Carry;
	
	rca_4bit rca_4bit01(.a(a[3:0]), .b(b[3:0]), .Cin(Cin), .Sum(Sum[3:0]), .Cout(Carry));
	rca_4bit rca_4bit02(.a(a[7:4]), .b(b[7:4]), .Cin(Carry), .Sum(Sum[7:4]), .Cout(Cout));
endmodule