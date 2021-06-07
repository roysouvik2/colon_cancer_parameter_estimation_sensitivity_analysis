# Code to solve for the patient parameters using the NCG scheme.

import numpy as np
from parameters import parameters
from forward_solver import forward_solver
from adj_solver import adj_solver
from col_data import col_data
from ncg_optimality import NCG

a, b, c, e, f, j, m, r1, r2, alpha, beta, t, Nt, step, nu = parameters()

# Generating the data
theta_true = [1.4,1,0.5,1.0,0.1,1.0]
f_data = col_data(theta_true)

# Initial guess for theta

theta = [0.5,0.5,1,0.5,0.5,1.5]

theta = NCG(theta,f_data)

print(theta)
