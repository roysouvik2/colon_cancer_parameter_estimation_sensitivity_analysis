% Code to estimate parameters of a QSP model for colon cancer based on the model by 
% dePillis et. al. 2014
% Authors: Achyuth Manoj, Susanth Kakarla, Suvra Pal and Souvik Roy

clear all

% Generating data
[samples_index,Td,Nd,Ld,Cd] = data();

% Solving for the parameters
theta = ncg(samples_index,Td,Nd,Ld,Cd);


theta