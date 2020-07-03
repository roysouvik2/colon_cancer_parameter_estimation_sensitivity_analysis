% Code to estimate parameters of a QSP model and sensitivity analysis for colon cancer based on the model by 
% dePillis et. al. 2014
% Authors: Achyuth Manoj, Susanth Kakarla, Suvra Pal and Souvik Roy

clear all
clc

[t0,Tf,t,h,m,a,b,c,e,f,j,r1,r2,alpha,beta,a_T,a_N,a_L,a_C,gamm] = parameters();

% Generating data
[dt,lt,st,pt,kt,qt,samples_index,Td,Nd,Ld,Cd] = data();

% Solving for the parameters
theta = optim(samples_index,Td,Nd,Ld,Cd);

fprintf('\n\nThe true value of d is %.6e\n',dt);
fprintf('The true value of l is %.6e\n',lt);
fprintf('The true value of s is %.6e\n',st);
fprintf('The true value of p is %.6e\n',pt);
fprintf('The true value of k is %.6e\n',kt);
fprintf('The true value of q is %.6e\n',qt);

fprintf('\n\nThe value of d is %.6e\n',theta(1));
fprintf('The value of l is %.6e\n',theta(2));
fprintf('The value of s is %.6e\n',theta(3));
fprintf('The value of p is %.6e\n',theta(4));
fprintf('The value of k is %.6e\n',theta(5));
fprintf('The value of q is %.6e\n',theta(6));

% Computing the Latin hypercube samples using Weibull distribution
% for the sensitivity analysis of the estimated parameters

% num- number of simulations (samples size) for each parameter
num = 20;
samp = LHS(theta,num); % Each row of samp corresponds to num values of a parameter

% Printing the LHS matrix
format longeng
fprintf('\n\nThe LHS matrix is: \n\n')
disp(samp)

format short
% Computing the partial rank correlation coefficients
par_cor(samp,num);

