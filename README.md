# Synchronous FIFO in Verilog

This repository contains the Verilog implementation of a **parameterized synchronous FIFO (First-In-First-Out)** buffer along with a **testbench** for functional verification.

## 📌 Features
- **Parameterized Design**: Configurable depth, width, and address size  
- **Control Signals**: `wr_en` (write enable), `r_en` (read enable)  
- **Status Flags**: `full` and `empty`  
- **Pointer Wrapping**: Proper handling of circular buffer indexing  
- **Edge Case Handling**: Prevents overflow and underflow  
- **Testbench Included**: Verifies write, read, and simultaneous operations  

## 🛠️ How It Works
The FIFO stores incoming data words in a memory array and outputs them in the same order they were written.  
It uses:
- **Write pointer** (`wr_ptr`) to track the next write location
- **Read pointer** (`r_ptr`) to track the next read location
- **Counter** (`count`) to track the number of elements in the FIFO

Status flags:
- `full` → asserted when FIFO is full  
- `empty` → asserted when FIFO is empty  

## ▶️ Simulation
1. Open the project in **Vivado** or **ModelSim**.
2. Compile both `sfifo.v` and `tb_sfifo.v`.
3. Run the simulation to observe:
   - FIFO filling and emptying
   - Overflow and underflow prevention
   - Simultaneous read/write operations

