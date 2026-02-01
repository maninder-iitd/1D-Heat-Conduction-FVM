# 1D-Heat-Conduction-FVM
MATLAB implementation of 1D steady heat conduction with internal heat generation using the Finite Volume Method.
# 1D Heat Conduction using Finite Volume Method (FVM)

This repository contains a MATLAB implementation of the Finite Volume Method (FVM) for solving the one-dimensional steady-state heat conduction equation with internal heat generation.

## Governing Equation
\[
\nabla \cdot (k \nabla T) + q_0 + q_1 T = 0
\]

## Features
- 1D steady heat conduction
- Finite Volume Method with equidistant control volumes
- User-defined number of control volumes (N)
- User-defined source terms (q0, q1)
- Central differencing in interior cells
- One-sided differencing at boundaries
- Exact solution comparison for q1 = 0
- RMS error computation
- Publication-quality plots

## How to Run
1. Open MATLAB
2. Navigate to the `src` folder
3. Run:
   ```matlab
   fvm_1d_heat_conduction
