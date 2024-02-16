h=1/200;
syms x
U0=sin(2*pi*x);
u0=vpa(subs(U0,x,(0:h:1)));
up=[];
up(1,:)=u0;
u=[];
u(1,:)=u0;
t=0;
x=(0:h:1);
%MacCormack
%for %MacCormack condition for stability is v<1 so:
timestep=0.0125;
v=0.0125*0.2/h;
for i=1:200
   for j=1:200 
     up(i+1,j)=(1+v)*u(i,j)-v*u(i,j+1);%predict step
   end
   up(i+1,201)=up(i+1,1);
   for j=2:201
     u(i+1,j)=0.5*(u(i,j)+up(i+1,j))-v/2*(up(i+1,j)-up(i+1,j-1));%corrector step
   end
   u(i+1,1)=u(i+1,201);
   up(i+1,:)=u(i+1,:);
       %exact
   t=t+timestep;
   y_e=(sin(2*pi*(x-(0.2*t))));
end
p1= plot((0:h:1),u(1,:));
hold on;
p2=plot((0:h:1),sin(2*pi*(x-(0.2*2.5))),'.');
hold on;
p3=plot((0:h:1),u(201,:));
hold on;
error=abs(max(y_e-u(201,:)))
 l_str = {'initial','exact','MacCormack'};
 legend([p1,p2,p3],l_str);
r = sin(2*pi*(x-(0.2*2.5)));
% Calculate energy
E = sum(abs(r).^2);
fprintf('exact Energy of the wave in time=2.5: %.2f\n', E);
j=sum(abs(u(201,:)).^2);
fprintf('MacCormack  Energy of the wave in time=2.5 : %.2f\n', j);
error2=abs(E-j)