module enum_example;
  
  enum {RED, GREEN, YELLOW} color;
  
  initial begin
    color = GREEN;
    $display("Color value:%0d", color);
    $display("Color name:%s", color.name());
    
  end
  
endmodule

typedef enum {RED, GREEN, BLUE} color_t;

module enum_typedef_example;
  
  color_t led_color; //alias for color_t
  
  initial begin
    led_color = RED;
    $display("LED Color value:%0d", led_color);
    $display("LED Color name:%s", led_color.name());
    
  end
  
endmodule