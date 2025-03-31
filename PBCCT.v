
module PBCCT(
    input Clk,
    input PB,
    input En,
    output PS
    );
	 
wire q0, q1b;

DFF FF0(.D(PB), .CLK(Clk), .Q(q0), .QB());
DFF FF1(.D(q0), .CLK(Clk), .Q(), .QB(q1b));

and A1(PS, q0, q1b, En);

endmodule
