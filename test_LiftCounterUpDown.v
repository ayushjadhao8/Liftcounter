// Code your testbench here
// or browse Examples
`timescale 1 ns/1 ns

module test_LiftCounterUpDown;

    reg CLK;
    reg RST;
	
    reg SI, SO;
	
	 wire Full,Empty;
	
	 //counter outputs		
    wire Q0, Q1, Q2, Q3;	
    wire [3:0] count;

    initial    // Clock process for CLK
    begin
        CLK = 1'b0;
        forever
            #50 CLK = ~CLK;
    end
				
	LiftCounterUpDown uut(.CLK(CLK), .RST(RST), .SI(SI), .SO(SO), 
						.Q0(Q0), .Q1(Q1), .Q2(Q2), .Q3(Q3),
						.Full(Full), .Empty(Empty));				

	assign count = {Q3, Q2, Q1, Q0};

	initial begin
      $dumpfile("dump.vcd"); $dumpvars;   //store all waveforms
		SI = 1'b0;
		SO = 1'b0;
		RST = 1'b1;
		
		repeat (2) @(negedge CLK);
		RST = 1'b0;    				//release reset
		repeat (5) @(negedge CLK);
		
		//lift fills up
		repeat (12) begin
			SI = 1'b1;
			repeat (5) @(negedge CLK);
			SI = 1'b0;
			repeat (5) @(negedge CLK);
		end 
		repeat (10) @(negedge CLK);
		
		//lift empties
		repeat (9) begin
			SO = 1'b1;
			repeat (5) @(negedge CLK);
			SO = 1'b0;
			repeat (5) @(negedge CLK);
		end 
		repeat (10) @(negedge CLK);
		
		//lift get half full
		repeat (4) begin
			SI = 1'b1;
			repeat (5) @(negedge CLK);
			SI = 1'b0;
			repeat (5) @(negedge CLK);
		end 
		repeat (10) @(negedge CLK);
		
		//1 person enters/exits lift at same time
		SI = 1'b1;
		SO = 1'b1;
		repeat (5) @(negedge CLK);
		SI = 1'b0;
		SO = 1'b0;		
		repeat (5) @(negedge CLK);
		
		//lift empties
		repeat (7) begin
			SO = 1'b1;
			repeat (5) @(negedge CLK);
			SO = 1'b0;
			repeat (5) @(negedge CLK);
		end 
		repeat (10) @(negedge CLK);
		
		//lift fills up
		repeat (12) begin
			SI = 1'b1;
			repeat (5) @(negedge CLK);
			SI = 1'b0;
			repeat (5) @(negedge CLK);
		end 
		repeat (10) @(negedge CLK);
		
		$stop;
  	end

endmodule

