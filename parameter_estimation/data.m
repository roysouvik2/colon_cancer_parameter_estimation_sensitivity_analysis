% Generating patient specific data

function [samples_index,Td,Nd,Ld,Cd] = data()

[t0,Tf,t,h,m,a,b,c,e,f,j,r1,r2,alpha,beta,a_T,a_N,a_L,a_C,gamm] = parameters();


% Patient specific parameters
d = 1.3 + .5*randn(1,1);
l = 1.1 + .4*randn(1,1);
s = 4e-3 + 1e-3*randn(1,1);
p = 5.16e-14 +1e-14*randn(1,1);
k = 2e7 + 5e6*randn(1,1);
q = 5.16e-10 +2e-10*randn(1,1);

% d = 1.3 + .5;%*randn(1,1);
% l = 1.1 + .4;%*randn(1,1);
% s = 4 + 1;%*randn(1,1);
% p = 5.16 +1;%*randn(1,1);
% k = 2+ .5;%*randn(1,1);
% q = 5.16 +2;%*randn(1,1);

[T,N,L,C] = forward(d,l,s,p,k,q);

% Computing the sample times
samples_index = [(m+1)/4, (m+1)/2, 3*(m+1)/4, (m+1)];

Td = T(samples_index);
Nd = N(samples_index);
Ld = L(samples_index);
Cd = C(samples_index);

