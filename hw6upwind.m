n=201;
x=linspace(0,1,n)
U0=zeros(size(1,201));
u0(1,1:70)=0;
u0(1,71:131)=1;
u0(1,131:201)=0;
u=u0(1:end-1);
plot([x(1:end-1);x(2:end)],[u;u]);
hold on
f=u.^2./2;
DF=u;
DFF=(f(1:end-1)+f(2:end))./2;
speed=(f(1:end-1)-f(2:end))./(u(1:end-1)-u(2:end));
special=abs(u(1:end-1)-u(2:end)) < 1E-8;
speed(special)=DF(special);
fl=f(1:end-1);
fr=f(2:end);
f_h=fl.*(speed > 0)+fr.*(speed < 0);
f_half=[0,f_h,0];
r=[];
r=u;
for i=2:11
   for j=1:200
       r(i,j)=r(i-1,j)-0.02/0.005*(f_half(1,j+1)-f_half(1,j));
   end
f=1/2.*(r(i,:)).^2;
DF=r(i,:);
DFF=(f(1:end-1)+f(2:end))./2;
speed=(f(1:end-1)-f(2:end))./(r(i,1:end-1)-r(i,2:end));
special=abs(r(i,1:end-1)-r(i,2:end)) < 1E-8;
speed(special)=DF(special);
fl=f(1:end-1);
fr=f(2:end);
j=1;
for range=speed
    if speed > 0
        f_h(1,j)=f(1,j);
    elseif speed < 0
        f_h(1,j)=f(1,j+1);
    else
        f_h(1,j)=(f(1,j)+f(1,j+1))./2;
    end
    j=j+1;
end
   f_half=[0,f_h,0];
end
%plot([x(1:end-1);x(2:end)],[r(101,:);r(101,:)])