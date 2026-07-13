//assigning a 4 state datatype to 2 state datatype
module tb;
	bit [3:0] var_b; //2 state 
	logic [3:0] x_val; //4 state
  
	initial begin
      x_val = 4'b01xz;
      
      var_b = x_val;
      $display("x_val:%b, var_b:%b", x_val, var_b);
      
    end 
  
endmodule