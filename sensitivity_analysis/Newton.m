% Newton's method for finding the approximate shape and scale parameter for Weibull's
% distribution.

function [scale,shape] = Newton(par,stdev)

[t0,Tf,t,h,m,a,b,c,e,f,j,r1,r2,alpha,beta,a_T,a_N,a_L,a_C,gamm] = parameters();

% Initial guess for x in the Newton's method
x0 = 0.5;

f = @(x)gamma(2*x + 1)/(gamma(x + 1)^2)-(stdev+1);

df = @(x) (2*gamma(2*x + 1)*psi(2*x + 1))/gamma(x + 1)^2 - (2*psi(x + 1)*gamma(2*x + 1))/gamma(x + 1)^2;

% Function value and derivative
val = f(x0);
der = df(x0);


% Starting the Newton's method
iter = 1;
maxiter = 20;
tol = 10^-5;

err = 1;

while (iter < maxiter && err > tol)
    x_new = x0 - val/der;
    err = abs(x0-x_new);
    
    % Storing the newly computed value in x0;
    x0 = x_new;
    
    % Recomputing the function value and its derivative
    val = f(x0);
    der = df(x0);
    
    iter = iter+1;
end

shape = 1/x0;
scale = par/gamma(1+x0);


