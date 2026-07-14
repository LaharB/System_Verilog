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