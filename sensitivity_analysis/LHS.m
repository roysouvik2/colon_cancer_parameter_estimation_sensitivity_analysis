% Function to determine the Latin hypercube sample of the uncertain
% parameters theta
% N: represents the sample size

% Authors: Achyuth Manoj, Susanth Kakarla, Suvra Pal and Souvik Roy

function samp = LHS(theta,N)


len = length(theta); % Length of the parameter vector

for i = 1:len
    samp(i,:) = Weibull_par(theta(i),N);
end


    
