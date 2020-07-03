% Generating patient specific data

function [dt,lt,st,pt,kt,qt,samples_index,Td,Nd,Ld,Cd] = data()

[t0,Tf,t,h,m,a,b,c,e,f,j,r1,r2,alpha,beta,a_T,a_N,a_L,a_C,gamm] = parameters();


% Patient specific parameters
d = 1.01;
l = 1.16;
s = 2.3e-3;
p = 4.4e-14;
k = 1.59e7;
q = 6.2e-14;

% Patient specific true parameters
dt = 1.3;
lt = 1.1;
st = 3e-3;
pt = 5.16e-14;
kt = 2e7;
qt = 5.2e-14;


[T,N,L,C] = forward(d,l,s,p,k,q);

% Computing the sample times
samples_index = [(m+1)/4, (m+1)/2, 3*(m+1)/4, (m+1)];

Td = T(samples_index);
Nd = N(samples_index);
Ld = L(samples_index);
Cd = C(samples_index);

