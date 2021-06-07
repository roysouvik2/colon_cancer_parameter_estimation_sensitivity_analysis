#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Feb 13 12:42:40 2021

@author: susanthkakarla
"""

import numpy as np
import math

from parameters import parameters


a, b, c, e, f, j, m, r1, r2, alpha, beta, t, Nt, step, nu = parameters()



def adjoint_model(X,i,f_sol,f_data,theta):
   # Y will be the matrix of F(X)

    d = theta[0];
    l = theta[1];
    s = theta[2];
    p = theta[3];
    k = theta[4];
    q = theta[5];

    Y = np.zeros(4)                                   
    Y = Y.reshape((4,1))   
                          
    T_a = X[0,0]
    N_a = X[1,0]
    L_a = X[2,0]
    C_a = X[3,0]

    # Forward solution at the time point t[i]
    
    T = f_sol[0,i]
    N = f_sol[1,i]
    L = f_sol[2,i]
    C = f_sol[3,i]

    # Data at the time point t[i]
    T_d = f_data[0,i]
    N_d = f_data[1,i]
    L_d = f_data[2,i]
    C_d = f_data[3,i]
    
    t_div0 = (d*s*l*(L**l)*(T**l)*T_a)/((s*(T**l)+(L**l))**2)
    t_div1 = -(d*L**l)/(4*s*pow(10,-3)*pow(200,l) * T**l + L**l)
    
    t_div2 = (k*L*L_a)/(k+T)**2
    
    dT_a = -a*b*T*T_a + a*(1-b*T)*T_a - c*N*T_a + t_div0+ t_div1 - p* pow(10,-10) * N *N_a + j*t_div2 - q*pow(10,-8)*L*L_a + (r1*N + r2*C)*L_a   
    #np.negative(dT_a)
    Y[0,0] = dT_a - (T-T_d)
    
    dN_a = -f*N_a  - p*T*N_a -  c*T*T_a + r1*T*L_a
    #np.negative(dN_a)
    Y[1,0] = dN_a - (N-N_d)
    
    
    
    
    L_div = (l*(L**(1-l)) * (s*(T**l)))/((s*(T**l) + L**l)**2)
    
    dL_a = m*L_a + j*((T*L_a)/(k+T)) - q*T*L_a + d*T*T_a*L_div
    #np.negative(dL_a)
    Y[2,0] = dL_a - (L-L_d)
    
    
    
    dC_a = -beta*C_a + e*N_a + r2*T*L_a
    #np.negative(dC_a)
    Y[3,0] = dC_a - (C-C_d)
   
    
    return Y

 
