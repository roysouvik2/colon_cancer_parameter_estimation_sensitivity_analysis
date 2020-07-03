% Code to estimate parameters of a QSP model for colon cancer based on the model by 
% dePillis et. al. 2014
% Authors: Achyuth Manoj, Susanth Kakarla, Suvra Pal and Souvik Roy

clear all
clc

% Generating data
[samples_index,Td,Nd,Ld,Cd] = data();

% Solving for the parameters
theta = ncg(samples_index,Td,Nd,Ld,Cd);


fprintf('\n\nThe value of d is %.6e\n',theta(1));
fprintf('The value of l is %.6e\n',theta(2));
fprintf('The value of s is %.6e\n',theta(3));
fprintf('The value of p is %.6e\n',theta(4));
fprintf('The value of k is %.6e\n',theta(5));
fprintf('The value of q is %.6e\n',theta(6));