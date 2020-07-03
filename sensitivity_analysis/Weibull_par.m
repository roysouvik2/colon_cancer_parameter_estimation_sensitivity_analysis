% Function to compute the samples of parameter par using Weibull
% distribution

function val = Weibull_par(par,N)

% Desired parameter interval from where we will choose values
int_samples = [par*0.2, par*1.8];

% Division of the interval into N non-overlapping subintervals
h = (int_samples(2)-int_samples(1))/N;

% Loop over subintervals
for i = 1:N
    % Computing the scale and shape paramters of the Weibull distribution
    % in the subinterval
    
    % Mean value
    m = int_samples(1) + i*h/2;
    
    % Standard deviation
    stdev = 0.3;
    
    [scale,shape] = Newton(m,stdev);
    
    % Generating a random number 
    val(i) = wblrnd(scale,shape);
end



