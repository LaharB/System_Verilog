module queue_example;
  int q[$]; //delcaring an int datatype queue
  int a;
  
  initial begin 
    q.push_back(10);
    q.push_back(20);
    q.push_back(30);
    
    $display("Queue after push_back: %p", q);
    
    q.push_front(5);
    $display("Queue after push_front: %p", q);
    
    a = q.pop_front();
    $display("Value of a: %0d", a);
    $display("After pop_front: %p", q);
	
    a = q.pop_back();
    $display("Value of a: %0d", a);
    $display("After pop_back: %p", q);
   
  end 

endmodule

module queue_datatypes_simple;
  
  int int_q[$] = '{10, 20, 30};
  bit[3:0] bit_q[$] = '{5, 0, 7, 11};
  real real_q[$] = '{1.5, 2.75, 3.0};
  string str_q[$] = '{"apple", "banana", "cherry"};
  
  //enum queue
  typedef enum {RED, GREEN, BLUE} color_t;
  color_t color_q[$] = '{RED, GREEN, BLUE};
  
  initial begin
    $display("Interger Queue: %p", int_q);
    $display("Bit Queue: %p", bit_q);
    $display("Real Queue: %p", real_q);
    $display("String Queue: %p", str_q);
    $display("Enum Queue: %p", color_q);
  end

endmodule

// Bounded and Unbounded Queue 

module queue_unbounded_example;
  
  int unbounded_q[$];
  int bounded_q[$:4]; 
  
  initial begin
    for(int i = 1; i <= 6; i++) begin
      unbounded_q.push_back(i);
      if(bounded_q.size() < 4)
        bounded_q.push_back(i);
      else
        $display("Bounded Queue Full! Cannot add %0d", i);
    end
    
    //display both the queues
    $display("Unbounded Queue: %p", unbounded_q);
    $display("Bounded Queue: %p", bounded_q);
  end

endmodule
