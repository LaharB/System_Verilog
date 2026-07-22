// 1D Array
module array_example;
  
  int array[6] = '{100, 200, 300, 400, 500, 600}; 
  
  initial begin
    foreach(array[i]) begin
      $display("array[%0d] = %0d", i, array[i]);
    end
    
  end
  
endmodule

//2D array
module array_example;
  
  int array[6][2] = '{ '{10, 100}, '{20, 200}, '{30, 300}, '{40, 400}, '{50, 500}, '{60, 600} }; //0th row elements, 1st row elemets and so on 
  initial begin
    foreach(array[i, j]) begin
      $display("array[%0d][%0d] is %0d", i, j, array[i][j]);   
    end
    
  end
  
  
endmodule