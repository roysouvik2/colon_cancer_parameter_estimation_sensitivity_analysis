
import numpy as np
import math
from numpy import linalg

from parameters import parameters
from forward_solver import forward_solver
from adj_solver import adj_solver


a, b, c, e, f, j, m, r1, r2, alpha, beta, t, Nt, step, nu = parameters()

def gradient(f_sol,a_sol,theta):

    d = theta[0];
    l = theta[1];
    s = theta[2];
    p = theta[3];
    k = theta[4];
    q = theta[5];

    # grad(J) matrix
    grad = np.zeros([6])

    for i in range(0,Nt):
        
        # Forward solution at t[i]
        T = f_sol[0,i]
        N = f_sol[1,i]
        L = f_sol[2,i]
        C = f_sol[3,i]
        
        # Adjoint solution at t[i]
        T_a = a_sol[0,i]
        N_a = a_sol[1,i]
        L_a = a_sol[2,i]
        C_a = a_sol[3,i]
        
        
        LT_div = L/T
        
        LT_div_exp = LT_div**l
        
        #partial derviative J/d
        grad[0] = grad[0] + (LT_div_exp * T * T_a) / (4*s*pow(10,-3)*pow(200,l) + LT_div_exp) + nu*d
        grad[0] = grad[0] * step 

        #partial derviative J/l
        grad[1] = grad[1] + (d * s * T_a * (LT_div_exp * math.log(LT_div) + 4*s*pow(10,-3)*pow(200,l) * math.log(200)))/ (4*s*pow(10,-3)*pow(200,l) + LT_div_exp ) **2 + nu*l
        grad[1] = grad[1] * step 

        #partial derviative J/s
        grad[2] = grad[2] -(d * LT_div_exp * T * T_a * 4*pow(10,-3)*pow(200,l))/ (4*s*pow(10,-3)*pow(200,l) + LT_div_exp)**2 + nu*s
        grad[2] = grad[2] * step 

        #partial derviative J/p
        grad[3] = grad[3] + pow(10,-10)*N * N_a * T + nu*p
        grad[3] = grad[3] * step

        #partial derivative J/k
        grad[4] = grad[4] + (j * L * L_a * T)/ (k + T)**2 + nu*k
        grad[4] = grad[4] * step 

        #partial derivative J/q
        grad[5] = grad[5] + pow(10,-8)*L * L_a * T + nu*q
        grad[5] = grad[5] * step 

    return grad
    


# Functional
def J(f_sol,f_data,theta):

    d = theta[0];
    l = theta[1];
    s = theta[2];
    p = theta[3];
    k = theta[4];
    q = theta[5];

    result = 0.0
    
    for k in range(0,Nt):
        result = result + (f_sol[0,k] - f_data[0,k])**2 + (f_sol[1,k] - f_data[1,k])**2 + (f_sol[2,k] - f_data[2,k])**2 + (f_sol[3,k] - f_data[3,k])**2

    regularization_term = nu*(d**2 + l**2 + s**2 + p**2 + k**2 + q**2)
    result = 0.5*(result*step + regularization_term)

    return result

def armijo_line_search(theta,grad,des,f_sol,f_data):
    
    #index
    j = 0
    
    #max
    j_max = 10

    alpha = 0.5
    c = 0.25
    
    while j < j_max:
        theta_new = theta + alpha*des
        f_new = forward_solver(theta_new)

        d1 = J(f_new,f_data,theta_new)
        d2 = J(f_sol,f_data,theta) + c * alpha * np.inner(grad,des)
        
        if d1 <= d2:
            return alpha        
            quit()
        else:
            alpha = alpha/2.0
            j = j+1
        
    if j == j_max:
        alpha = 0.0
        return alpha



def Fletcher_Reeves(grad_old,grad):

    vec = grad_old
    vec2 = grad
    
    #numerator = np.dot(vec,vec2)
    numerator = linalg.norm(vec2)**2
    
    #denominator = np.dot(vec2,vec2)
    denominator = linalg.norm(vec)**2
    result = numerator/denominator
    
    return result

def Dai_Yuan(grad_old,grad,des):

    vec = grad_old
    vec2 = grad
    
    #numerator = np.dot(vec,vec2)
    numerator = linalg.norm(grad)**2
    
    #denominator = np.dot(vec2,vec2)
    denominator = np.inner(des,grad-grad_old)
    result = numerator/denominator
    
    return result
    


# Starting the NCG algorithm            
    
def NCG(theta,f_data):

    #index
    k = 0

    #max
    k_max = 50

    #tolerance
    tol = 10**(-5)

    f_sol = forward_solver(theta)
    a_sol = adj_solver(f_sol,f_data,theta)
    des = np.zeros([6])

    # Computing the gradient
    grad = gradient(f_sol,a_sol,theta)
    grad_norm = linalg.norm(grad)
    des0 = -grad

    des = des0



    while k < k_max:

        # Obtaining alpha through the line search algorithm
        alpha = armijo_line_search(theta,grad,des,f_sol,f_data)
        if (alpha == 0):
            print ('Line search fails')
            break

        # Updating the parameter
        theta_old = theta
        
        theta = theta_old + alpha * des
        

        # Projection Step
        theta[0] = min(2,max(theta[0],0))
        theta[1] = min(2,max(theta[0],0))
        theta[2] = min(3,max(theta[0],0))
        theta[3] = min(1.5,max(theta[0],0))
        theta[4] = min(0.5,max(theta[0],0))
        theta[5] = min(1.5,max(theta[0],0))


        # Old gradient
        grad_old = grad

        # New updates

        f_sol = forward_solver(theta)
        a_sol = adj_solver(f_sol,f_data,theta)

        # Computing the new gradient
        grad = gradient(f_sol,a_sol,theta)

        

        # Updating the conjugate directions
        #beta = Fletcher_Reeves(grad_old,grad)
        beta = Dai_Yuan(grad_old,grad,des)

        

        des_old = des;
        des = -grad + np.multiply(beta,des_old)

        grad_norm = linalg.norm(grad)

        print('k = ', k, ', Alpha = ', alpha, ', Iterate value  = ', theta, ', Gradient Norm = ',grad_norm, 'J = ', J(f_sol,f_data,theta))

        

        if (linalg.norm(grad) < tol or k == k_max):
            exit()

        k += 1

    
    return theta
    
    
    
    
    
    
    
    
