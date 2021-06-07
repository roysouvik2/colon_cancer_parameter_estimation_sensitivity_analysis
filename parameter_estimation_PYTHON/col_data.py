# Code to generate the data

import numpy as np

from parameters import parameters
from forward_solver import forward_solver
from scipy import interpolate

a, b, c, e, f, j, m, r1, r2, alpha, beta, t, Nt, step, nu = parameters()

def col_data(theta_true):

	f_sol = forward_solver(theta_true)

	# Initial conditions
	T_in = 1.0
	N_in = 1.0
	L_in = 1.0
	C_in = 1.0

	# Selecting the time points for the data
	T_data = np.array((T_in))
	N_data = np.array((N_in))
	L_data = np.array((L_in))
	C_data = np.array((C_in))

	tim_data = np.array((0.0))

	for i in range(1,Nt):
		if((i+1) % 20 == 0):
			T_data = np.hstack((T_data,f_sol[0,i]))
			N_data = np.hstack((N_data,f_sol[1,i]))
			L_data = np.hstack((L_data,f_sol[2,i]))
			C_data = np.hstack((C_data,f_sol[3,i]))

			tim_data = np.hstack((tim_data,t[i]))

	
	# interpolating the data for all times
	fT_int = interpolate.interp1d(tim_data, T_data, kind = "quadratic")
	fN_int = interpolate.interp1d(tim_data, N_data, kind = "quadratic")
	fL_int = interpolate.interp1d(tim_data, L_data, kind = "quadratic")
	fC_int = interpolate.interp1d(tim_data, C_data, kind = "quadratic")


	f_data = np.array([T_in,N_in,L_in,C_in])
	f_data = f_data.reshape((4,1))

	for i in range(1,Nt):
		T_new = fT_int(t[i])
		N_new = fN_int(t[i])
		L_new = fL_int(t[i])
		C_new = fC_int(t[i])
		X = np.array([T_new,N_new,L_new,C_new])
		X = X.reshape((4,1))
		f_data = np.hstack((f_data,X))

	#print(f_data)

	total = np.vstack((t,f_data))
	f = open("data.txt","w")
	np.savetxt(f,total,delimiter=' ')
	f.close()

	return f_data







