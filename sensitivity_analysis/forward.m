% Code to solve the forward ODE for colon cancer based on the model by 
% dePillis et. al. 2014
% Authors: Achyuth Manoj, Susanth Kakarla, Suvra Pal and Souvik Roy

function [T,N,L,C] = forward(d,l,s,p,k,q)


[t0,Tf,t,h,m,a,b,c,e,f,j,r1,r2,alpha,beta,a_T,a_N,a_L,a_C,gamm] = parameters();

% Scaled initial conditions

T(1) = 4.66;
N(1) = 9;
L(1) = 1.8;
C(1) = 9;

% Solving the ODE for subsequent time steps
for i = 2:m+1
    D = d*(L(i-1)/T(i-1))^l/(s+(L(i-1)/T(i-1))^l);
    T(i) = T(i-1) + h*(a*T(i-1)*(1-b*T(i-1)) -c*N(i-1)*T(i-1) -D*T(i-1));
    N(i) = N(i-1) + h*(e*C(i-1)-f*N(i-1)-p*N(i-1)*T(i-1));
    L(i) = L(i-1) + h*(j*(T(i-1)/(k+T(i-1))) -q*L(i-1)*T(i-1) + (r1*N(i-1)+r2*C(i-1))*T(i-1));
    C(i) = C(i-1) + h*(alpha-beta*C(i-1));
end


