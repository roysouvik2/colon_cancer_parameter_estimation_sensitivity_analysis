#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Jan 31 17:15:46 2021

@author: susanthkakarla
"""
import numpy as np


def State_equation( theta, T, N, L, C): 
    
    # Y will be the matrix of F(X)

    Y=np.zeros(4)                                   
    #reshaping to make it a column vector
    Y=Y.reshape((4,1))   
    
    dT = a * T *( 1 - b * T ) - c * N * T - D * T;
    
    dN = e * C - f * N - p * pow(10,-5) * N * T;
    
    dL = m*L + (j * T)/(k+T) -  q *pow(10,-8)* L * T + (r1 * N + r2 * C)*T;
    
    dC = alpha - beta * C;
    
d = theta[0];
l = theta[1];
s = theta[2];
p = theta[3];
k = theta[4];
q = theta[5];

      
  
a = 0.231;
b = 0.045;
c = 3*pow(10,-9);
e = 0.22;
f = 0.01;
j = 1.245*pow(10,-4);
m = 5*pow(10,-3);
r1 = 61.6;
r2 = 2.4;
alpha = 1.62;
beta = 6.3*pow(10,-3);
D = (d * pow((L/T),l))/(pow(200.0,l)*4*pow(10,-3)*s + pow((L/T),l));

T0 = 0.1;
N0 = 0.1;
L0 = 0.1;
C0 = 0.1;

T = [];
N=[];
L = [];
C = [];

T[0] = T0
N[0] = N0
L[0] = L0
C[0] = C0
