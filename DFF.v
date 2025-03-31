module DFF(input D, CLK, output Q, QB);

reg Qi;

always @(posedge CLK) Qi <= D;
  	
assign Q = Qi;
assign QB = ~Qi;
  	
endmodule
