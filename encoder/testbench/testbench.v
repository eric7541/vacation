`define T_CLK 10
`timescale 1ns/1ps
module testbench();
  reg [1:0] select; 
  reg [4:0] j=0;
  wire [3:0] out;

    encoder uut_encoder_2to4(
        .select(select),
        .out(out)
    );

    initial begin
    select = 2'b00;
    end


    initial begin
        if (select == 2'b00)begin
            for (j=0; j<4; j=j+1)
            #10
            select = select + 1'b1;
        
        end

  end


    
endmodule