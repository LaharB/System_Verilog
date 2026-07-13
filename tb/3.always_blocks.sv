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

module dff(
	input logic clk, rst, d,
  	output logic q
);
  
  always_ff@(posedge clk or negedge rst) begin //any BA use will give ERROR
    if(!rst)
      q <= 0;
    else 
      q <= d;    
  end
  
endmodule

module d_latch(
	input logic en, d,
  	output logic q
);
  
  always_latch begin
    if(en)
      q = d;    
  end
  
endmodule