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

  function void display();
    $display("Parent display method");    
  endfunction
  
endclass

class child extends parent;
  
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

// Example 3 - Accessing base class data member

class parent; 
  
  bit [31:0] data;
  
  function void display();
    $display("PARENT: data = %0d", data);    
  endfunction
  
endclass

class child extends parent;
  
  bit [31:0] data;
  
  function void display();
     super.data = 3; //parent class data member
     super.display();
    $display("CHILD: data = %0d", data);     
  endfunction 
  
endclass


module tb;
  
  child c;
  
  initial begin    
    c = new();
    c.data = 5;
    c.display();
  end 
  
endmodule

// Example 4 - Immediate Parent classes

class A; 
  
  function void msg();
    $display("Class A");    
  endfunction
  
endclass

class B extends A; 
  
  function void msg();
    $display("Class B");    
  endfunction
  
endclass

class C extends B; 
  
  function void msg();
    $display("Class C"); 
    super.msg(); //calls B's msg(), not A's
  endfunction
  
endclass

module tb;
  
  C obj;
  
  initial begin    
    obj = new();
    obj.msg();
  end 
  
endmodule