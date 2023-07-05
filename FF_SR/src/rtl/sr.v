module sr(
  input S,
  input R, 
  input clk, 
  input n_rst,
  output reg Q, 
  output reg Q_bar);

    always @(posedge clk or negedge n_rst) begin
        if (S && !R)    // S=1, R=0
            Q <= 1;
        else if (!S && R)   // S=0, R=1
            Q <= 0;
        else if (S && R)    // S=1, R=1 (invalid state)
            Q <= Q;        // Retain previous state
    end

    always @(Q) begin
        Q_bar <= ~Q;
    end

endmodule
