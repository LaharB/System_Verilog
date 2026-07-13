## Verilog vs. SystemVerilog: Data Types

* **The Verilog Limitation (`reg` vs. `wire`):** In legacy Verilog, a `reg` data type can strictly only be driven from within procedural blocks (`always`, `initial`). Attempting to drive a `reg` with a continuous assignment (`assign`) results in a compilation error. 
* **The SystemVerilog Solution (`logic`):** SystemVerilog introduces the `logic` data type to eliminate the strict boundaries between variables and nets for most standard RTL design use cases.
* **Universal Assignment:** The `logic` type is highly versatile and can be driven by either method:
  * **Procedural Assignments (PA):** Driven inside blocks like `always_comb`, `always_ff`, or `always_latch`.
  * **Continuous Assignments (CA):** Driven directly using `assign` statements.
* **Design Rule of Thumb:** Default to using `logic` for internal signals and ports. You only need to revert to a net type (like `wire`) when a signal requires multiple drivers, such as an inout bidirectional bus.

