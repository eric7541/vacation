`define T_CLK 10
`timescale 1ns/1ps
module testbench();
  reg  sel; 
  reg [3:0] j;
  wire out;

    mux uut_mux_1to2(
        .sel(sel),
        .out(out)
    );

    initial begin
    sel = 1'b0;
    end


    initial begin
        if (sel == 1'b0)begin
            for (j=0; j<2; j=j+1)
            #10
            sel = sel + 1'b1;
        
        end

  end


    
endmodule