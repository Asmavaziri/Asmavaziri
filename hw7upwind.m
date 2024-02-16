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

% Finite volume method - upwind scheme
for n = 1:Nt-1
    for i = 2:Nx
        u(i, n+1) = u(i, n) - dt/(2.*dx) * (u(i, n)^2 - u(i-1, n)^2);
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
title('Solution of 1D Burger''s Equation');

% Animation (optional)
 for n = 1:Nt
     plot(x, u(:, n));
     xlabel('Space');
     ylabel('u(x,t)');
     title(['Time: ', num2str(n*dt)]);
     pause(0.1);
 end
