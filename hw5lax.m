h=1/200;
syms x
U0=sin(2*pi*x);
u0=vpa(subs(U0,x,(0:h:1)));
plot((0:h:1),u0);
hold on;
u=[];
u0(202)=u0(2)
u(1,:)=u0
t=0;
x=(0:h:1);
%lax
%for lax condition for stability is v<1 so:
timestep=0.0125;
v=0.0125*0.2/h;
for i=1:200
   for j=1:200 
      u(i+1,j+1)=(0.5-(v/2)).*u(i,j+2)+(0.5+(v/2)).*u(i,j);
   end 
   u(i+1,1)=u(i+1,201);
   u(i+1,202)=u(i,2);
   %exact
   t=t+timestep;
   y_e=(sin(2*pi*(x-(0.2*t))));
   
end
plot((0:h:1),u(1,1:201),'b');
hold on;
plot((0:h:1),sin(2*pi*(x-(0.2*2.5))),'r');
hold on;
plot((0:h:1),u(201,1:201),'y');
hold on;
error=abs(max(y_e-u(201,1:201)))
l_str = {'initial','exact','lax'};
legend(l_str);
r = sin(2*pi*(x-(0.2*2.5)));
% Calculate energy
E = sum(abs(r).^2);
fprintf('exact Energy of the wave in time=2.5: %.2f\n', E);
j=sum(abs(u(201,:)).^2);
fprintf('upwind Energy of the wave in time=2.5 : %.2f\n', j);
error2=abs(E-j)