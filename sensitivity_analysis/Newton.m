% Newton's method for finding the approximate shape and scale parameter for Weibull's
% distribution.

function [scale,shape] = Newton(par,stdev)

[t0,Tf,t,h,Nx,m,a,b,c,e,f,j,r1,r2,alpha,beta,a_T,a_N,a_L,a_C,gamm] = parameters();


% Initial guess for x in the Newton's method
x0 = 0.5;

f = @(x) gamma(2*x + 1)/(gamma(x + 1)^2)-(stdev^2/par^2+1);
f(x0);

x = fzero(f,x0);

shape = 1/x;
scale = par/gamma(1+x);


