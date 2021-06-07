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



def forward_model(X,theta):
    # Y will be the matrix of F(X)
    Y=np.zeros(4)
    #reshaping to make it a column vector
    Y=Y.reshape((4,1))
    
    d = theta[0];
    l = theta[1];
    s = theta[2];
    p = theta[3];
    k = theta[4];
    q = theta[5];
    
    #calculating D from given values to make the following line less bulky
   
    #Individually writing each equation in F(x)
    T = X[0,0]
    N = X[1,0]
    L = X[2,0]
    C = X[3,0]
    
    divL_T = L/T
    #D_mul = (math.pow(divL_T,l))/(math.pow(divL_T,l)+s)
    D_mul = (d * pow(divL_T,l))/(4*s*pow(10,-3)*pow(200,l) + pow(divL_T,l));

    
    
    Y[0,0] = a * T *( 1 - b * T ) - c * N * T - D_mul * T;
    Y[1,0]= e * C - f * N - p * pow(10,-10) * N * T;
    Y[2,0]= m*L + (j * T * L)/(k+T) -  q *pow(10,-8)* L * T + (r1 * N + r2 * C)*T;
    Y[3,0]= alpha - beta * C;
    
    return Y


