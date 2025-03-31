module QmuxUD(input TC, Q, DNU, UND, output T);

assign T = (~Q & TC & DNU) | (Q & TC & UND);

endmodule
