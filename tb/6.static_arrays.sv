// 1D Array
module array_example;
  
  int array[6] = '{100, 200, 300, 400, 500, 600}; 
  
  initial begin
    foreach(array[i]) begin
      $display("array[%0d] = %0d", i, array[i]);
    end
    
  end
  
endmodule