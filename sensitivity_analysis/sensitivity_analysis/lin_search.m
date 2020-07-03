function alpha = lin_search(theta,g,d,T,N,L,C,Td,Nd,Ld,Cd,samples_index,len)

% Performing the linear search algorithm.
[t0,Tf,t,h,m,a,b,c,e,f,j,r1,r2,alpha,beta,a_T,a_N,a_L,a_C,gamm] = parameters();


% Starting value of alpha.
alpha = 0.5;

delta = 0.3 ;

s = 1;
s_max = 10;

while( s < s_max)
    theta_n = theta + alpha*d;
    [T_n,N_n,L_n,C_n] = forward(theta_n(1),theta_n(2),theta_n(3),theta_n(4),theta_n(5),theta_n(6));
    
    c1 = J(theta_n(1),theta_n(2),theta_n(3),theta_n(4),theta_n(5),theta_n(6),T_n,N_n,L_n,C_n,Td,Nd,Ld,Cd,samples_index);
    c2 = J(theta(1),theta(2),theta(3),theta(4),theta(5),theta(6),T,N,L,C,Td,Nd,Ld,Cd,samples_index) + delta*alpha*inner_g(g,d,len);
    
    % Checking for Armijo criterion.
    if(c1 <= c2 )
        return; 
    else
        alpha=alpha/2;
    end
    s = s + 1;
end
if(s == s_max)
    alpha = 0;
end
