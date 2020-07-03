% Code to solve the adjoint ODE for colon cancer based on the model by 
% dePillis et. al. 2014
% Authors: Achyuth Manoj, Susanth Kakarla, Suvra Pal and Souvik Roy

function [Ta,Na,La,Ca] = adjoint(d,l,s,p,k,q,T,N,L,C,Td,Nd,Ld,Cd,samples_index)


[t0,Tf,t,h,m,a,b,c,e,f,j,r1,r2,alpha,beta,a_T,a_N,a_L,a_C,gamm] = parameters();


Ta = zeros(m+1,1);
Na = zeros(m+1,1);
La = zeros(m+1,1);
Ca = zeros(m+1,1);

% Terminal conditions
for i = 1:length(samples_index)
    Ta(m+1,1) = Ta(m+1,1) + a_T/2*(T(samples_index(i))-Td(i))^2;
    Na(m+1,1) = Na(m+1,1) + a_N/2*(N(samples_index(i))-Nd(i))^2;
    La(m+1,1) = La(m+1,1) + a_L/2*(L(samples_index(i))-Ld(i))^2;
    Ca(m+1,1) = Ca(m+1,1) + a_C/2*(C(samples_index(i))-Cd(i))^2;
             
end


% Solving the ODE for subsequent time steps
for i = m:-1:1
    D = d*(L(i+1)/T(i+1))^l/(s+(L(i+1)/T(i+1))^l);
    Ta(i) = Ta(i+1) - h*(a*b*T(i+1)*Ta(i+1)-a*(1-b*T(i+1))*Ta(i+1) + c*N(i+1)*Ta(i+1)) ...
                    - h*(p*N(i+1)*Na(i+1)-j*(((k+T(i+1))*L(i+1)*La(i+1))/(k+T(i+1))^2)) ...
                    - h*(q*L(i+1)*La(i+1)-(r1*N(i+1)+r2*C(i+1))*La(i+1) + D*Ta(i+1));
    Na(i) = Na(i+1) - h*(f*Na(i+1)+p*T(i+1)*Na(i+1) + c*T(i+1)*Ta(i+1) - r1*T(i+1)*La(i+1));
    La(i) = La(i+1) - h*(-j*(T(i+1)*La(i+1))/(k+T(i+1)) + q*T(i+1)*La(i+1));
    Ca(i) = Ca(i+1) - h*(beta*Ca(i+1)-e*Na(i+1)-r2*T(i+1)*La(i+1));
end


