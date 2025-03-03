% Function to compute the samples of parameter par using Weibull
% distribution

function val = Weibull_par2(N,scale,shape)


% Generate a random permutation of N integers
permut = randperm(N);

% Generate uniformly distributed random numbers in the corresponding random
% quantiles

ran_num = unifrnd((permut-1)/N, permut/N);


% Inverse CDF at ran_num for the Weibull distribution with scale and shape
% determined above

val = wblinv(ran_num,scale,shape);











