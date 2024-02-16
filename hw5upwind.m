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
%upwind 
%for a>0  we use backward finte difference in space 
%for FTBS condition for stability is v<1 so:
timestep=0.0125;
v=0.0125*0.2/h;
for i=1:200
   for j=1:200 
      u(i+1,j+1)=(1-v)*u(i,j+1)+v*u(i,j);
   end 
   u(i+1,1)=u(i+1,201);
    %exact
   t=t+timestep;
   y_e=(sin(2*pi*(x-(0.2*t))));
    plot(x,y_e)
    hold on
    plot(x,u,'bo-','MarkerFaceColor','r')
    hold off
    title(sprintf('time=%1.3f',t))
    shg
    pause(0.0125)
end
plot((0:h:1),u(1,:));
hold on;
plot((0:h:1),sin(2*pi*(x-(0.2*2.5))));
hold on;
plot((0:h:1),u(201,:));
hold on;
error=abs(max(y_e-u(201,:)))
 l_str = {'initial','exact','upwind'};
 legend(l_str);
r = sin(2*pi*(x-(0.2*2.5)));
% Calculate energy
E = sum(abs(r).^2);
fprintf('exact Energy of the wave in time=2.5: %.2f\n', E);
j=sum(abs(u(201,:)).^2);
fprintf('upwind Energy of the wave in time=2.5 : %.2f\n', j);
error2=abs(E-j)

