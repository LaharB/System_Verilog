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

////////////////////////////////////////////////////////////////////

// Example 3

class parent;
  
  virtual task display();
    $display("PARENT: display task");
  endtask 
    
  task common_task(); //virtual not used so parent handle will call this task
    $display("PARENT: common task" );   
  endtask
  
endclass

class child extends parent;
  
  task display();
    $display("CHILD: display task");
  endtask 
  
  task child_only_task();
    $display("CHILD: special task");    
  endtask
  
endclass
  
module tb;
  
  parent p;
  child c;
  
  initial begin
    c = new();
    
    p = c; //class assignment 
    
    /*
    c = p;
    This will result in a compilation error. A child handle cannot point to a parent object.

Even if you try to force it dynamically using $cast(c, p);, the cast will fail at runtime. SystemVerilog strictly prevents a child handle from pointing to a base parent object because the parent object lacks the properties and methods (like child_only_task()) that the child handle expects to be able to access.
	*/
    
    p.display(); //will call Child's Function
    
    p.common_task(); //calls Parent's common task not child's common task
    
    c.child_only_task(); //cant call this using p handle 
    
  end
  
endmodule

