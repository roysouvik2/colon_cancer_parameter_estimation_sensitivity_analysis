#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Feb 13 12:26:29 2021

@author: susanthkakarla
"""

import numpy as np
import math

def parameters():
    
    a = 0.231;
    b = 0.021;
    c = 3*pow(10,-9);
    e = 0.22;
    f = 0.01;
    j = 1.245*pow(10,-4);
    m = 5*pow(10,-3);
    r1 = 61.6*pow(10,-7)*9;
    r2 = 2.4*pow(10,-7)*9;
    alpha = 1.62;
    beta = 6.3*pow(10,-3);
    
    
    # No. of time interval points
    Nt = 200;
    t = np.linspace(0, 20, num = Nt, endpoint=True)
    step = t[2]-t[1];
    step = (1-math.exp(-50*step))/50

    # Regularization parameter
    nu = 0.001;
    
    return a, b, c, e, f, j, m, r1, r2, alpha, beta, t, Nt, step, nu
