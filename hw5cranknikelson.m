n=201;
h=1/200;
syms x
U0=sin(2*pi*x);
u0=vpa(subs(U0,x,(0:h:1)));
u0(202)=u0(2);
s = sym('u%d%d', [200 201]);
u=[];
u(1,:)=u0;
t=0;
x=(0:h:1);
timestep=0.0125;
v=0.0125*0.2/h;
z=1;
m=1;
for i=1:200
    for p=2:200;
       eval(['eq' num2str(z) '=-v/4*s(i,p-1)+s(i,p)+v/4*s(i,p+1)==v/4*u(i,p-1)+u(i,p)-v/4*u(i,p+1);']);
       z=z+1;
    end
    eval(['eq' num2str(z) '=-v/4*s(i,200)+s(i,201)+v/4*s(i,2)==v/4*u(i,200)+u(i,201)-v/4*u(i,202);']);
    eval(['eq' num2str(z+1) '=s(i,1)==s(i,201);']);
    eqs=sym(zeros(size(1,201)));
    for p=1:z+1
        eval(['eqs(1,p)= eq' num2str(p) ';']);
    end
    anss=solve(eqs,s(i,:));
    for p=1:201
        eval(['a' '=anss.u' num2str(i) num2str(p) ';']);
        u(i+1,p)=vpa(a);
    end
    z=1;
   %exact
   t=t+timestep;
   y_e=(sin(2*pi*(x-(0.2*t))));
   m=m+1
end
p1= plot((0:h:1),u(1,1:201));
hold on;
p2=plot((0:h:1),sin(2*pi*(x-(0.2*2.5))),'.');
hold on;
p3=plot((0:h:1),u(201,1:201));
hold on;
error=abs(max(y_e-u(201,1:201)))
 l_str = {'initial','exact','Crank-Nicolson'};
 legend([p1,p2,p3],l_str);
r = sin(2*pi*(x-(0.2*2.5)));
% Calculate energy
E = sum(abs(r).^2);
fprintf('exact Energy of the wave in time=2.5: %.2f\n', E);
j=sum(abs(u(201,:)).^2);
fprintf('Crank-Nicolson Energy of the wave in time=2.5 : %.2f\n', j);
error2=abs(E-j)*100/E
fprintf('percentage error : %.2f\n', error2);
