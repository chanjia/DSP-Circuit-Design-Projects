# DSP-Circuit-Design-Projects

This repository contains hardware and simulation projects for digital signal processing circuits, including multipliers and low-pass filters. The projects demonstrate both floating-point and fixed-point implementations as well as Verilog-based hardware designs.

---

## 1. Baugh-Wooley Multiplier

- **Description:** Implementation of a signed array multiplier using Baugh-Wooley architecture in Verilog.
- **Files:** `verilog_code/HW5_1/`
- **Skills Demonstrated:** Digital arithmetic, Verilog HDL, hardware multiplier design.

---

## 2. Low-Pass Filter Design

### a. Floating-Point Simulation
- **Description:** Design and simulation of low-pass FIR filter using floating-point arithmetic in MATLAB.
- **File:** `matlab_code/filter_design.m`
- **Skills:** MATLAB, filter design, signal processing.

### b. Fixed-Point Simulation
- **Description:** Fixed-point simulation of the FIR filter to evaluate quantization effects.
- **File:** `matlab_code/fixed-point.m`
- **Skills:** Fixed-point arithmetic, DSP optimization.

### c. Verilog Code Simulation
- **Description:** Hardware implementation of FIR filter in Verilog and simulation with testbench.
- **Files:** `verilog_code/HW5_2/`
- **Skills:** Verilog HDL, FIR hardware design, simulation.

### d. Verification
- **Description:** Verification script to compare fixed-point MATLAB simulation and Verilog simulation results.
- **File:** `verilog_code/HW5_2/do_fir/check.m`
- **Skills:** Simulation validation, MATLAB analysis, hardware/software correlation.

---

## How to Run

1. MATLAB simulations:
```matlab
% Run floating-point simulation
run('matlab_code/filter_design.m');

% Run fixed-point simulation
run('matlab_code/fixed-point.m');
