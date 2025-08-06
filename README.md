# 🧠 Branch Predictor (2-bit Saturating Counter) – SystemVerilog

This project implements a **2-bit saturating counter branch predictor** in SystemVerilog. It simulates a simple finite state machine (FSM) that predicts the outcome of a branch (taken or not taken) based on recent history.

---

## 📁 Project Structure
branch_predictor/
├── bp_pkg.sv # Package: defines FSM states
├── bp_ifc.sv # Interface: connects DUT and testbench
├── Branch_Predictor.sv # DUT: branch predictor logic
├── tb_branch_predictor.sv # Testbench with functional coverage
└── README.md # Project documentation

---

## 🚀 Features

- Implements a **2-bit FSM-based branch predictor**
- Covers **all 8 state transitions** via functional coverage
- Uses **SystemVerilog interface** and `modport` abstraction
- Testbench includes:
  - Random branch outcomes
  - Accuracy tracking
  - FSM state validation
  - Functional coverage

---

## 🧪 How to Simulate

### Prerequisites
- A SystemVerilog simulator like:
  - **ModelSim / Questa**
  - **VCS**
  - **XSIM (Vivado)**
  - **Icarus Verilog** *(partial SV support)*

### Simulation Instructions (example with VCS)
