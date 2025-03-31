//T-type flip-flop

`timescale 1 ns / 1 ns

module TFF(input T, RST, CLK, output Q, QB);

reg Qi;

always @(posedge CLK or posedge RST) 
begin
	if (RST == 1'b1)
		Qi <= 1'b0;
	else
		Qi <= (T & ~Qi)|(~T & Qi);
end
  	
assign #10 Q = Qi;
assign #10 QB = ~Qi;
  	
endmodule
