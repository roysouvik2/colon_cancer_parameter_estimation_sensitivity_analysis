function theta = optim(samples_index,Td,Nd,Ld,Cd)

[t0,Tf,t,h,m,a,b,c,e,f,j,r1,r2,alpha,beta,a_T,a_N,a_L,a_C,gamm] = parameters();

v_min = 0;

% Patient specific parameters initial guess
d1 = 2;
l = 2;
s = 4e-3;
p = 1e-14;
k = 3e7;
q = 1e-14;

theta(1) = d1;
theta(2) = l;
theta(3) = s;
theta(4) = p;
theta(5) = k;
theta(6) = q;


len = length(theta);

[T,N,L,C] = forward(theta(1),theta(2),theta(3),theta(4),theta(5),theta(6));
[Ta,Na,La,Ca] = adjoint(theta(1),theta(2),theta(3),theta(4),theta(5),theta(6),T,N,L,C,Td,Nd,Ld,Cd,samples_index);

% Evaluating the gradient with the initial guess.
for i = 1:len
    g(i) = gradient(theta(1),theta(2),theta(3),theta(4),theta(5),theta(6),T,N,L,C,Ta,Na,La,Ca,i);
end
g;
d = -g;

fprintf('Initial norm of gradient = %.3e\n\n', norm(g));
fprintf('Starting the NCG\n\n');

k = 1;
k_max = 20;
tol = 10^-8;

while(k < k_max && norm(g) > tol)
    alpha = lin_search(theta,g,d,T,N,L,C,Td,Nd,Ld,Cd,samples_index,len);
    if(alpha < eps)
        fprintf('Line Search terminates\n');
        fprintf('k=%d, alpha= %.4e,grad(J)=%.3e, J(u) = %.2e\n',k,alpha,norm(g), ...
            J(theta(1),theta(2),theta(3),theta(4),theta(5),theta(6),T,N,L,C,Td,Nd,Ld,Cd,samples_index));
        break;
    else
        %fprintf('Line search gives alpha = %.4e\n',alpha);
        theta = theta + alpha*d;
        
        
        %Projection Method
        theta = max(1e-14,theta);
        
        [T,N,L,C] = forward(theta(1),theta(2),theta(3),theta(4),theta(5),theta(6));
        [Ta,Na,La,Ca] = adjoint(theta(1),theta(2),theta(3),theta(4),theta(5),theta(6),T,N,L,C,Td,Nd,Ld,Cd,samples_index);
        
        for i = 1:len
            gn(i) = gradient(theta(1),theta(2),theta(3),theta(4),theta(5),theta(6),T,N,L,C,Ta,Na,La,Ca,i);
        end
        
        % Evaluating beta by Dai-Yuan method.
        beta = norm(gn)^2/inner_g(d,gn-g,len);
        
        % Evaluating beta by Hager-Zhang method
        %nor = inner_g(d1,d2,d1,d2)/inner_g(d1,d2,gn1-g1,gn2-g2);
        %term1 = gn1-g1 - 2*d1*nor;
        %term2 = gn2-g2 - 2*d2*nor;
        
        %beta = inner_g(term1,term2,gn1,gn2)/inner_g(d1,d2,gn1-g1,gn2-g2);
        
        % Descent directions
        d = -gn + beta*d;
        
        
    end
    
    % Evaluating gradient for next iteration
    g = gn;
    fprintf('k=%d, alpha= %.4e,grad(J)=%.3e, J(u) = %.2e\n',k,alpha,norm(g), ...
        J(theta(1),theta(2),theta(3),theta(4),theta(5),theta(6),T,N,L,C,Td,Nd,Ld,Cd,samples_index));
    k = k + 1;
end
