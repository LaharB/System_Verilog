module mux2to1(
	input logic a, b, sel,
  	output logic y
);
  
  always_comb begin //no need of sensi list
    if(sel)
      y = a;
    else 
      y = b;    
  end
  
endmodule

