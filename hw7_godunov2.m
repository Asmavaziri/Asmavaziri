% Parameters
L = 1;          % Length of the domain
T = 0.2;          % Total simulation time
Nx = 200;       % Number of spatial grid points
Nt = 100;       % Number of time steps
dx = L/Nx;      % Spatial step size
dt = T/Nt;      % Time step size


% Initial condition
x = linspace(0, L, Nx);
u0=zeros(size(1,201));
u0(1,1:70)=0;
u0(1,71:131)=1;
u0(1,131:201)=0;
u0=u0(1:end-1);

% Initialize solution matrix
u = zeros(Nx, Nt);

% Set initial condition
u(:, 1) = u0';

% Set godunov flux
%function [f]=f_godunov2 (ui,uinext)
%  if ui < uinext
%     f=min(ui^2/(ui^2+(1-ui)^2),uinext^2/(uinext^2+(1-uinext)^2));
%  elseif ui > uinext
%     f=max(ui^2/(ui^2+(1-ui)^2),uinext^2/(uinext^2+(1-uinext)^2));
%  else
%     f=ui^2/(ui^2+(1-ui)^2)
%  end
%end

% Finite volume method - godunov scheme
for n = 1:Nt-1
    for i = 2:Nx-1
        u(i, n+1) = u(i, n) - dt/dx * (f_godunov2(u(i, n),u(i+1, n)) - f_godunov2(u(i-1, n),u(i, n)));
    end
    % Boundary condition (periodic)
    u(1, n+1) = u(Nx, n+1);
end

% Plotting
figure;
y=linspace(0,0.2,100);
[X, T] = meshgrid(x,y);
surf(X, T, u');
xlabel('Space');
ylabel('Time');
zlabel('u(x,t)');
title('Solution of Equation with godunov scheme');

% Animation (optional)
 for n = 1:Nt
     plot(x, u(:, n),'r');
     xlabel('Space');
     ylabel('u(x,t)');
     title(['Time: ', num2str(n*dt)]);
     pause(0.1);
 end
      hold on
 plot(x,u0,'b');
 hold on
 l_str = {'Godunov @0.2','initial'};
 legend(l_str);
