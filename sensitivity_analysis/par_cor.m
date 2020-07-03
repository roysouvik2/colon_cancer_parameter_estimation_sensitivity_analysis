% Computing the PRCC of the observed tumor cell count data and 
% the sensitive parameters

function [] = par_cor(samp,num)

[t0,Tf,t,h,m,a,b,c,e,f,j,r1,r2,alpha,beta,a_T,a_N,a_L,a_C,gamm] = parameters();

% Computing the observation vector of the scaled tumor cell count at the final
% time.
for i = 1:num
    [T,~,~,~] = forward(samp(1,i),samp(2,i),samp(3,i),samp(4,i),samp(5,i),samp(6,i));
    tum_cell(i) = T(m+1);
end

% Computing the PRCC coefficients

samp = samp';
tum_cell = tum_cell';

mat = [samp tum_cell];

[rho,pval] = partialcorr(mat);

s = size(samp);

tum = array2table(pval(1:s(2),s(2)+1), ...
    'VariableNames',{'T'},...
    'RowNames',{'d','l','s','p','k','q'});
fprintf('\n\n')
disp('p-values:')
fprintf('\n')
disp(tum)