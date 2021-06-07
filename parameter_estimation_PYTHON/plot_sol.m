clear all
clc
close all

A = load('forward_sol.txt');

t = A(1,:);
T = A(2,:);
N = A(3,:);
L = A(4,:);
C = A(5,:);

figure(1)
plot(t,T,'r',t,N,'k',t,L,'b',t,C,'c')

B = load('adjoint_sol.txt');

tB = B(1,:);
TB = B(2,:);
NB = B(3,:);
LB = B(4,:);
CB = B(5,:);

figure(2)
plot(tB,TB,'r',tB,NB,'k',tB,LB,'b',tB,CB,'c')

D = load('data.txt');

tD = D(1,:);
TD = D(2,:);
ND = D(3,:);
LD = D(4,:);
CD = D(5,:);

figure(3)
plot(tD,TD,'r',tD,ND,'k',tD,LD,'b',tD,CD,'c')