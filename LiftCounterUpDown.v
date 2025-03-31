`include "PBCCT.v"
`include "QmuxUD.v"
`include "TFF.v"
`include "DFF.v"

// Code your design here
module LiftCounterUpDown(input CLK, RST, SI, SO, 
					output Q0, Q1, Q2, Q3,
					output Full, Empty);

wire T0, T1, T2, T3;

wire QB0, QB1, QB2, QB3;

wire UP, DN, DNU, UND;

TFF FF0(.T(T0), .RST(RST), .CLK(CLK), .Q(Q0), .QB(QB0));
TFF FF1(.T(T1), .RST(RST), .CLK(CLK), .Q(Q1), .QB(QB1));
TFF FF2(.T(T2), .RST(RST), .CLK(CLK), .Q(Q2), .QB(QB2));
TFF FF3(.T(T3), .RST(RST), .CLK(CLK), .Q(Q3), .QB(QB3));

assign UND = UP & ~DN;
assign DNU = ~UP & DN;
assign T0 = UND | DNU;

QmuxUD QM1(.TC(T0), .Q(Q0), .DNU(DNU), .UND(UND), .T(T1));
QmuxUD QM2(.TC(T1), .Q(Q1), .DNU(DNU), .UND(UND), .T(T2));
QmuxUD QM3(.TC(T2), .Q(Q2), .DNU(DNU), .UND(UND), .T(T3));

assign Full = {Q3, Q2, Q1, Q0} == 4'd9;
assign Empty = {Q3, Q2, Q1, Q0} == 4'd0;

PBCCT PBSI(.Clk(CLK), .PB(SI), .En(~Full), .PS(UP));
PBCCT PBSO(.Clk(CLK), .PB(SO), .En(~Empty), .PS(DN));

endmodule
