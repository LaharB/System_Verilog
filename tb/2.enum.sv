module enum_example;
  
  enum {RED, GREEN, YELLOW} color;
  
  initial begin
    color = GREEN;
    $display("Color value:%0d", color);
    $display("Color name:%0s", color.name());
    
  end
  
endmodule

