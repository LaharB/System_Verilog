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

// 3D array
module array_example;
  
  //R0,C0 for L0, L1 and L2 resp and so on
  int array[3][3][3] = '{ '{'{1, 10, 100}, '{2, 20, 200}, '{3, 30, 300}}, //R0,C0
                         '{'{4, 40, 400}, '{5, 50, 500}, '{6, 60, 600}}, //R1,C1
                         '{'{7, 70, 700}, '{8, 80, 800}, '{9, 90, 900}} //R2,C2 
                        };
  initial begin
    foreach(array[i, j, k]) begin
      $display("array[%0d][%0d][%0d] is %0d", i, j, k, array[i][j][k]);   
    end   
  end

endmodule

//Packed Array
module tb;
  
  bit [7:0] my_data; 
  
  initial begin
    my_data = 8'hA2;
    for(int i = 0; i < $size(my_data); i++) begin
      $display("my_data[%0d]: %0d", i, my_data[i]);
    end
    
  end 
  
endmodule