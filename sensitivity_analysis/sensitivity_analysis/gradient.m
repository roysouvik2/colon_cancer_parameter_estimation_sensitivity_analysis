function val = gradient(d,l,s,p,k,q,T,N,L,C,Ta,Na,La,Ca,type)

[t0,Tf,t,h,m,a,b,c,e,f,j,r1,r2,alpha,beta,a_T,a_N,a_L,a_C,gamm] = parameters();


if(type==1)
    val = 0.0;
    for i = 1:m+1
        val = val + (L(i)/T(i))^l/(s+(L(i)/T(i))^l) * T(i)*Ta(i);
    end
    val = val*h + gamm*d;
    
elseif(type==2)
    val = 0.0;
    for i = 1:m+1
        val = val + d*s/(s+(L(i)/T(i))^l)^2 * Ta(i)* (L(i)/T(i))^l*log(L(i)/T(i));
    end
    val = val*h + gamm*l;
    
elseif(type==3)
    val = 0.0;
    for i = 1:m+1
        val = val + -d*(L(i)/T(i))^l/(s+(L(i)/T(i))^l)^2 * T(i)* Ta(i);
    end
    val = val*h + gamm*s;
    
elseif(type==4)
    val = 0.0;
    for i = 1:m+1
        val = val +N(i)*T(i)*Na(i);
    end
    val = val*h + gamm*p;
    
elseif(type==5)
    val = 0.0;
    for i = 1:m+1
        val = val + j*T(i)*L(i)*La(i)/(k+T(i))^2;
    end
    val = val*h + gamm*k;
    
else
    val = 0.0;
    for i = 1:m+1
        val = val + L(i)*T(i)*La(i);
    end
    val = val*h + gamm*q;
    
end