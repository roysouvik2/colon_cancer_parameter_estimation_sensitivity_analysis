function [t0,Tf,t,h,m,a,b,c,e,f,j,r1,r2,alpha,beta,a_T,a_N,a_L,a_C,gamm] = parameters()

% Initial and final times
t0 = 0;
Tf = 30;

% Grid parameters
m = 99;
t = linspace(t0,Tf,m+1);
h = t(2)-t(1);

% Known parameter values
a = 2.31e-1;
b = 2.146e-10;
c = 5.156e-14;
f = 1e-2;
e = 1/9*f;
j = 1.245e-4;
r1 = 5.156e-12;
r2 = 1e-15;
beta = 6.3e-3;
alpha = 3e9*beta;

% Functional parameter values
a_T = 1;
a_N = 1;
a_L = 1;
a_C = 1;

% Regularization parameter values
gamm = 0.00000000001;