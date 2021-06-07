#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Feb  4 22:47:19 2021

@author: susanthkakarla
"""

import numpy as np


from forward_model import forward_model
from parameters import parameters


a, b, c, e, f, j, m, r1, r2, alpha, beta, t, Nt, step, nu = parameters()


def forward_solver(theta):

		#-----------------------------------Zeros_vector----------------------------
		# Values of T,N,L,C at t = 0

	T_0= 1.0
	N_0= 1.0
	L_0= 1.0
	C_0= 1.0

	
	X = np.array([T_0,N_0,L_0,C_0])
	X = X.reshape(4,1) # Transforming X to a column vector

	sol = np.zeros(4)
	sol = sol.reshape((4,1))
	sol = np.hstack((sol,X))
	sol = np.delete(sol,0,axis=1)

	


	#------------------------------Explicit Euler-----------------------------
	for i in range(1,Nt):
	    X = X + np.multiply(step , forward_model(X,theta))
	    sol = np.hstack((sol,X))
	

	total = np.vstack((t,sol))
	f = open("forward_sol.txt","w")
	np.savetxt(f,total,delimiter=' ')
	f.close()

	return sol
   

#data = np.delete(data,0,axis=1)

#print(data)
    

# # #-----------------------------------Plotting-----------------------------
# plt.plot(t,sol[0])
# plt.plot(t,sol[1])
# plt.plot(t,sol[2])
# plt.plot(t,sol[3])


# total = np.vstack((t,sol))
# f = open("explicit_sol.txt","w")
# np.savetxt(f,total,delimiter=' ')
# f.close()


# plt.xlabel('t')
# plt.ylabel('sol')
# plt.title("Solution using explicit Eulers method")

