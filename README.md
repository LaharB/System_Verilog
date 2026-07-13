<details>
<summary>Verilog vs. SystemVerilog: Data Types</summary>

# Verilog vs. SystemVerilog: Data Types

* **The Verilog Limitation (`reg` vs. `wire`):** In legacy Verilog, a `reg` data type can strictly only be driven from within procedural blocks (`always`, `initial`). Attempting to drive a `reg` with a continuous assignment (`assign`) results in a compilation error. 
* **The SystemVerilog Solution (`logic`):** SystemVerilog introduces the `logic` data type to eliminate the strict boundaries between variables and nets for most standard RTL design use cases.
* **Universal Assignment:** The `logic` type is highly versatile and can be driven by either method:
  * **Procedural Assignments (PA):** Driven inside blocks like `always_comb`, `always_ff`, or `always_latch`.
  * **Continuous Assignments (CA):** Driven directly using `assign` statements.
* **Design Rule of Thumb:** Default to using `logic` for internal signals and ports. You only need to revert to a net type (like `wire`) when a signal requires multiple drivers, such as an inout bidirectional bus. 

</details>

-------

<details>
<summary>SystemVerilog Enumerations (Enums)</summary>

# SystemVerilog Enumerations (Enums)

* **Basic Enums:** Allow you to define a set of named values (e.g., `RED, GREEN, YELLOW`). This significantly improves code readability for state machines and control logic compared to using raw macros or parameters.
* **Reusable Types (`typedef`):** Using `typedef enum` creates a custom data type (like `color_t` or `state_t`). This is essential for declaring multiple variables of the same enum type, avoiding repetitive code, and passing enums through module ports.
* **Base Types and Sizing:** By default, an enum's underlying type is a 32-bit `int`. For RTL design, especially Finite State Machines (FSMs), you should explicitly specify the hardware type and width (e.g., `enum logic [2:0]`) to ensure accurate synthesis.
* **Value Assignment:**
  * **Auto-Increment:** If no values are specified (e.g., `{IDLE, READ, WRITE}`), the compiler automatically assigns values starting from `0` and incrementing by 1.
  * **Explicit Assignment:** You can explicitly define the bit pattern for each state (e.g., `IDLE = 3'b000`, `ERROR = 3'b111`). This is highly recommended for robust FSM encoding (like one-hot or gray code).
* **Simulation & Debugging:** SystemVerilog provides built-in methods for enums. The `.name()` method returns the string representation of the enum's current value (e.g., printing `"READ"` instead of `1`). This makes `$display` statements and testbench debugging much easier to trace.

</details>

-------

<details>
<summary>SystemVerilog Procedural Blocks</summary>

# SystemVerilog Procedural Blocks (`always` enhancements)

* **Design Intent Execution:** SystemVerilog introduces specialized `always` blocks (`always_comb`, `always_ff`, `always_latch`) to explicitly state your hardware intent to EDA synthesis and simulation tools, reducing ambiguity compared to the generic Verilog `always` block.
* **`always_comb` (Combinational Logic):** 
  * **Auto-Sensitivity:** Automatically infers the sensitivity list based on the signals read inside the block. This eliminates the classic Verilog bug of simulation-synthesis mismatches caused by missing signals in the `@(...)` list.
  * **Rule Enforcement:** Strictly meant for combinational logic; it evaluates immediately at time zero and prohibits timing controls (like `#` delays or `@` events) inside the block.
* **`always_ff` (Sequential Logic):** 
  * **Edge-Triggered:** Used explicitly for modeling flip-flops and registers. It still requires an explicit sensitivity list defining the clock and/or asynchronous reset edges (e.g., `posedge clk or negedge rst`).
  * **Assignment Checks:** Synthesis and linting tools will aggressively flag errors if blocking assignments (`=`) are used within this block, enforcing the standard RTL practice of using non-blocking assignments (`<=`) for sequential elements.
* **`always_latch` (Level-Sensitive Logic):** 
  * **Intentional Latches:** Specifically used when you *want* to design a latch. This allows tools to verify that latch behavior is actually being modeled, and helps differentiate intentional latches from accidental latches (which typically occur due to incomplete `if-else` or `case` statements in `always_comb` blocks).

</details>

-------

<details>
<summary>SystemVerilog Data States: 2-State vs. 4-State Casting</summary>

# SystemVerilog Data States: 2-State vs. 4-State Casting

* **State Definitions:**
  * **4-State Logic (`logic`, `reg`, `wire`):** Can hold four distinct values: `0`, `1`, `X` (unknown/unknown conflict), and `Z` (high impedance/floating). SystemVerilog defaults to initializing 4-state variables to `X`.
  * **2-State Logic (`bit`, `int`, `byte`):** Can only hold `0` or `1`. This type is highly efficient for testbenches because it uses less simulation memory. SystemVerilog defaults to initializing 2-state variables to `0`.
* **Cross-State Assignment Rule:** When a 4-state value containing `X` or `Z` bits is assigned directly to a 2-state variable, SystemVerilog automatically converts all `X` and `Z` bits into `0`.
* **Example Coercion:** Assigning `4'b01xz` (4-state) to a `bit [3:0]` variable results in `4'b0100`. The valid binary states (`0` and `1`) are preserved, while the non-binary states (`x` and `z`) are pushed to `0`.
* **Design Precaution:** While 2-state types speed up simulation performance, using them prematurely in hardware design can mask critical runtime issues, such as uninitialized registers or unDriven buses that would otherwise show up as `X` or `Z`.

</details>

-------

<details>
<summary>SystemVerilog Parallel Threads: fork-join Variants</summary>

# SystemVerilog Parallel Threads: fork-join Variants

* **Parallel Execution:** Unlike `begin...end` blocks which execute sequentially, statements inside a `fork` block execute concurrently (in parallel) as separate spawned threads.
* **`fork...join` (Wait for All):** The parent process blocks and waits until **all** spawned child threads have completely finished. 
  * *Execution:* The main thread resumes at the time of the longest-running child thread (e.g., `t=20`).
* **`fork...join_any` (Wait for First):** The parent process blocks only until **any one** of the child threads finishes. Once the fastest thread completes, the parent process resumes, while the remaining child threads continue executing in the background.
  * *Execution:* The main thread resumes at the time of the shortest-running child thread (e.g., `t=5`).
* **`fork...join_none` (Do Not Wait):** The parent process does not block at all. It schedules the child threads to run in the background and immediately moves on to the next statement outside the block.
  * *Execution:* The main thread continues at the exact same simulation time it entered the block (e.g., `t=0`).
          
</details>