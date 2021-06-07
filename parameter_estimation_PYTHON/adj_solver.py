#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Feb  4 23:39:00 2021

@author: susanthkakarla
"""
import numpy as np

from adjoint_model import adjoint_model
from parameters import parameters


a, b, c, e, f, j, m, r1, r2, alpha, beta, t, Nt, step, nu = parameters()

def adj_solver(f_sol,f_data,theta):

	# Terminal condition
	T_aN = -(f_sol[0,Nt-1]-f_data[0,Nt-1])
	N_aN = -(f_sol[1,Nt-1]-f_data[1,Nt-1])
	L_aN = -(f_sol[2,Nt-1]-f_data[2,Nt-1])
	C_aN = -(f_sol[3,Nt-1]-f_data[3,Nt-1])



	X = np.array([T_aN, N_aN,L_aN,C_aN])
	X = X.reshape((4,1))

	result = np.zeros(4)
	result = result.reshape((4,1))

	result = np.hstack((result,X))



	for i in range(Nt-1,0,-1):
	    X = X + np.multiply(step, adjoint_model(X,i-1,f_sol,f_data,theta))
	    result = np.hstack((result,X))
	   
	result = np.delete(result,0,axis=1)

	total = np.vstack((t,result))
	f = open("adjoint_sol.txt","w")
	np.savetxt(f,total,delimiter=' ')
	f.close()
	return result
	               
	# print(result)



	# total = np.vstack((t,result))
	# #print("total:",total)