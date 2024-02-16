


n=33;
stepsize=[];
eh=sym(zeros(size(1,6)))
u0=0
z=1
for i=1:6
    h=1/(n-1)
    A=sym(zeros(size(n,n)));
    for i=2:n-1
       for j=1:n
           if  j==i-1 | j==i+1
              A(i,j)=1;
           elseif i==j
              A(i,j)=-2;
           else
              A(i,j)=0;
           end
       end
    end
    A(1,1)=1; %first boundray condition 
    for i=1:n %second boundray condition 
        if i==n
            A(n,i)=(1+(0.1*h));
        elseif i==n-1
            A(n,i)=-1;
        else 
            A(n,i)=0;
        end
    end
    A=sparse(double( A));
    b=sym(zeros(size(n,1)));
    b(1,1)=1; %from first boundray condition
    for i=2:n
        if i<n
           b(i,1)=vpa(h^2*5/(2*pi)^0.5* exp(-12.5*(((i-1)*h)-0.5)^2));
        else
           b(n,1)=0;
        end
    end
    anss=A\b
    v=n-(2)^(z-1);
    u0=abs((anss(v,1))-u0);
       if n>5
          stepsize(1,z)=h;
          eh(1,z)=vpa(u0);
          u0=anss(v,1);
          z=z+1
       end
    n=(n-1)*2+1;
end
disp(eh)
subplot(2,2,1);
plot((0:h:1),anss); 
subplot(2,2,2);
plot(log(stepsize),log(eh))
polyfit(log(stepsize),log(eh),1)
    