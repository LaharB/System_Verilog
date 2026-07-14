//Example 1 - Calling Parent Constructor

class parent;
  int a;
  
  //parent custom constructor
  function new();
    a = 10;
    $display("Parent Constructor called, a =%0d", a);    
  endfunction
  
endclass

class child extends parent;
  
  int b;
  
  //child custom constructor
  function new();
    super.new(); //calling parent constructor 
    b = 10;
    $display("Child Constructor called, b =%0d", b);    
  endfunction   
  
endclass


module tb;
  
  child c;
  
  initial begin    
    c = new();
  end 
  
endmodule

// Example 2 - Calling Parent method from Child

class parent;  
  //parent custom constructor
  function void display();
    $display("Parent display method");    
  endfunction
  
endclass

class child extends parent;
  
  //child custom constructor
  function void display();
    $display("Child display method - before calling PARENT");  
    super.display();
    $display("Child display method - after calling PARENT"); 
  endfunction 
  
endclass


module tb;
  
  child c;
  
  initial begin    
    c = new();
    c.display();
  end 
  
endmodule 
