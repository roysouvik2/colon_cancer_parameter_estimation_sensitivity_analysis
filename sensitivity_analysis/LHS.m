% Function to determine the Latin hypercube sample of the uncertain
% parameters theta
% N: represents the sample size

% Authors: Achyuth Manoj, Susanth Kakarla, Juan Villegas, Suvra Pal and Souvik Roy

function samp = LHS(theta,num)


len = length(theta); % Length of the parameter vector

for i = 1:len
    
    % Generating the Weibull distribution scale and shape parameters
    
    % Mean value
    m = theta(i);
    
    % Standard deviation
    stdev = 0.2;
    
    % Scale and shape of the Weibull distribution
    [scale,shape] = Newton(m,stdev);
    
    samp(i,:) = Weibull_par2(num,scale,shape);
end



