`define T_CLK 10
`timescale 1ns/1ps

module testbench();
  wire [7:0] data;
  wire parity;

  odd_parity uut_parity(
    .data(data),
    .parity(parity)
  );
  assign data = 8'b01110000;

endmodule
