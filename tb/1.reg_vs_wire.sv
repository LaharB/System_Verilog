module example_verilog_bad(
  input a,
  input b,
  output wire out
);
  
  reg my_signal; //reg type 
  
  assign my_signal = a & b; //cannot assign wire to a reg - ERROR
  
  assign out = my_signal; //can assign both reg and wire to a net datatype 
  
endmodule

module example_sv_good(
  input a,
  input b,
  output logic out
);
  
 //can use logic type in both PA and CA
  always_comb begin
    out = a & b;
  end
  
endmodule

