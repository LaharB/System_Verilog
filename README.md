# Verilog vs. SystemVerilog: Data Types

* **The Verilog Limitation (`reg` vs. `wire`):** In legacy Verilog, a `reg` data type can strictly only be driven from within procedural blocks (`always`, `initial`). Attempting to drive a `reg` with a continuous assignment (`assign`) results in a compilation error. 
* **The SystemVerilog Solution (`logic`):** SystemVerilog introduces the `logic` data type to eliminate the strict boundaries between variables and nets for most standard RTL design use cases.
* **Universal Assignment:** The `logic` type is highly versatile and can be driven by either method:
  * **Procedural Assignments (PA):** Driven inside blocks like `always_comb`, `always_ff`, or `always_latch`.
  * **Continuous Assignments (CA):** Driven directly using `assign` statements.
* **Design Rule of Thumb:** Default to using `logic` for internal signals and ports. You only need to revert to a net type (like `wire`) when a signal requires multiple drivers, such as an inout bidirectional bus.

# SystemVerilog Enumerations (Enums)

* **Basic Enums:** Allow you to define a set of named values (e.g., `RED, GREEN, YELLOW`). This significantly improves code readability for state machines and control logic compared to using raw macros or parameters.
* **Reusable Types (`typedef`):** Using `typedef enum` creates a custom data type (like `color_t` or `state_t`). This is essential for declaring multiple variables of the same enum type, avoiding repetitive code, and passing enums through module ports.
* **Base Types and Sizing:** By default, an enum's underlying type is a 32-bit `int`. For RTL design, especially Finite State Machines (FSMs), you should explicitly specify the hardware type and width (e.g., `enum logic [2:0]`) to ensure accurate synthesis.
* **Value Assignment:**
  * **Auto-Increment:** If no values are specified (e.g., `{IDLE, READ, WRITE}`), the compiler automatically assigns values starting from `0` and incrementing by 1.
  * **Explicit Assignment:** You can explicitly define the bit pattern for each state (e.g., `IDLE = 3'b000`, `ERROR = 3'b111`). This is highly recommended for robust FSM encoding (like one-hot or gray code).
* **Simulation & Debugging:** SystemVerilog provides built-in methods for enums. The `.name()` method returns the string representation of the enum's current value (e.g., printing `"READ"` instead of `1`). This makes `$display` statements and testbench debugging much easier to trace.

## 📝 SystemVerilog Procedural Blocks (`always` enhancements)

* **Design Intent Execution:** SystemVerilog introduces specialized `always` blocks (`always_comb`, `always_ff`, `always_latch`) to explicitly state your hardware intent to EDA synthesis and simulation tools, reducing ambiguity compared to the generic Verilog `always` block.
* **`always_comb` (Combinational Logic):** 
  * **Auto-Sensitivity:** Automatically infers the sensitivity list based on the signals read inside the block. This eliminates the classic Verilog bug of simulation-synthesis mismatches caused by missing signals in the `@(...)` list.
  * **Rule Enforcement:** Strictly meant for combinational logic; it evaluates immediately at time zero and prohibits timing controls (like `#` delays or `@` events) inside the block.
* **`always_ff` (Sequential Logic):** 
  * **Edge-Triggered:** Used explicitly for modeling flip-flops and registers. It still requires an explicit sensitivity list defining the clock and/or asynchronous reset edges (e.g., `posedge clk or negedge rst`).
  * **Assignment Checks:** Synthesis and linting tools will aggressively flag errors if blocking assignments (`=`) are used within this block, enforcing the standard RTL practice of using non-blocking assignments (`<=`) for sequential elements.
* **`always_latch` (Level-Sensitive Logic):** 
  * **Intentional Latches:** Specifically used when you *want* to design a latch. This allows tools to verify that latch behavior is actually being modeled, and helps differentiate intentional latches from accidental latches (which typically occur due to incomplete `if-else` or `case` statements in `always_comb` blocks).