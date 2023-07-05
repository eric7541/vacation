`define T_CLK 10
`timescale 1ns/1ps
module testbench();
  reg [3:0] select; 
  reg [4:0] j=0;
  wire [15:0] out;

    decoder uut_Decoder_4to16(
        .select(select),
        .out(out)
    );

    initial begin
    select = 4'b0000;
    end


    initial begin
        if (select == 4'b0000)begin
            for (j=0; j<16; j=j+1)
            #10
            select = select + 1'b1;
        
        end

  end


    
endmodule