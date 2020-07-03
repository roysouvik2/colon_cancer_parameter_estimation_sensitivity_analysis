function val = inner_g(g1,g2,len)

% Evaluating inner product of a vector function.
[t0,Tf,t,h,m,a,b,c,e,f,j,r1,r2,alpha,beta,a_T,a_N,a_L,a_C,gamm] = parameters();

val = 0.0;
for k = 1:len
    val = val + g1(k)*g2(k);
end

