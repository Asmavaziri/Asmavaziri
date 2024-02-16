h=1/200;
syms x
U0=sin(2*pi*x);
u0=vpa(subs(U0,x,(0:h:1)));
plot((0:h:1),u0);
hold on;
u=[];
u(1,:)=u0;
t=0;
x=(0:h:1);
%leapfrog
%for leapfrog condition for stability is v<1 so:
timestep=0.0125;
v=0.0125*0.2/h;
for i=1:200 
      u(2,i+1)=(1-v)*u(1,i+1)+v*u(1,i);
end 
u(2,1)=u(2,201);
for i=2:200
   for j=1:199 
      u(i+1,j+1)=u(i-1,j+1)-v*(u(i,j+2)-u(i,j));
   end 
   u(i+1,201)=(1-v)*u(i,201)+v*u(i,200);
   u(i+1,1)=u(i+1,201);
       %exact
   t=t+timestep;
   y_e=(sin(2*pi*(x-(0.2*t))));
 
end
p1= plot((0:h:1),u(1,:));
hold on;
p2=plot((0:h:1),sin(2*pi*(x-(0.2*2.5))));
hold on;
p3=plot((0:h:1),u(201,:));
hold on;
error=abs(max(y_e-u(201,:)))
 l_str = {'initial','exact','upwind'};
 legend([p1,p2,p3],l_str);
r = sin(2*pi*(x-(0.2*2.5)));
% Calculate energy
E = sum(abs(r).^2);
fprintf('exact Energy of the wave in time=2.5: %.2f\n', E);
j=sum(abs(u(201,:)).^2);
fprintf('upwind Energy of the wave in time=2.5 : %.2f\n', j);
error2=abs(E-j)
