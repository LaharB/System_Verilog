//Example 1 

class parent;
  bit [31:0] data;
  int id;
  
  virtual function void display();
    $display("BASE: Value of data:%0d, id:%0d", data, id);
  endfunction  
  
endclass

class child extends parent;
  bit [31:0] data;
  int id;
  
  function void display();
    $display("CHILD: Value of data:%0d, id:%0d", data, id);
  endfunction  
  
endclass
  
module tb;
  
  parent p;
  child c;
  
  initial begin
    p = new();
    c = new();
    
    p.data = 10;
    p.id = 2;
    
    p.display();
    
    c.data = 5;
    c.id = 2;
    
    p = c; //class assignment 
    
    p.display(); //will call Child's Function
    
  end
  
endmodule

// Example 2

