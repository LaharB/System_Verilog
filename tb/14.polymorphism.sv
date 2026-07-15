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

class parent;
  
  virtual function void display();
    $display("Inside PARENT CLASS");
  endfunction  
  
endclass

class child_1 extends parent;
  
  function void display();
    $display("Inside CHILD_1 CLASS");
  endfunction  
  
endclass

class child_2 extends parent;
  
  function void display();
    $display("Inside CHILD_2 CLASS");
  endfunction  
  
endclass
  
module tb;
  
  parent p[2]; //array of handles 
  child_1 c1;
  child_2 c2;
  
  initial begin
    //p[2] = new();
    c1 = new();
    c2 = new();
    
    //class assignment 
    p[0] = c1;
    p[1] = c2;
    
    p[0].display();
    p[1].display();
    
  end
  
endmodule



