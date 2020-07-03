function val = J(d,l,s,p,k,q,T,N,L,C,Td,Nd,Ld,Cd,samples_index)

[t0,Tf,t,h,m,a,b,c,e,f,j,r1,r2,alpha,beta,a_T,a_N,a_L,a_C,gamm] = parameters();

val = 0.0;

len = length(samples_index);

for i = 1:len
    val = val + a_T/2*(T(samples_index(i))-Td(i))^2 ...
              + a_N/2*(N(samples_index(i))-Nd(i))^2 ...
              + a_L/2*(L(samples_index(i))-Ld(i))^2 ...
              + a_C/2*(C(samples_index(i))-Cd(i))^2 ...
              + gamm/2*((d)^2+(l)^2+(s)^2+(p)^2+(k)^2+(q)^2);
end