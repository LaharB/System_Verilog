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

typedef enum logic[2:0] {
  IDLE = 3'b000, 
  READ = 3'b001, 
  WRITE = 3'b010,
  ERROR = 3'b111
} state_t; //custom datatype: logic and size: 3-bits 

module state_enum;
  
  state_t current_state;
  
  initial begin
    current_state = READ;
    $display("Current state:%s(%0d)", current_state.name(), current_state);   
  end
  
endmodule

typedef enum logic[1:0] {IDLE, READ, WRITE} state; //state auto_increment 

module state_enum;
  
  always@(posedge clk) begin
    case(state)
      IDLE: state <= READ;
      READ: state <= WRITE;
      WRITE: state <= IDLE;
    endcase
  end
  
endmodule