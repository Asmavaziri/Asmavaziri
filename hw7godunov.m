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

% Godunov scheme without diffusion term
for n = 1:Nt-1
    for i = 1:Nx-1
        % Compute flux at cell interface using Godunov scheme
        flux = 0.5 * (u(i, n)^2 + u(i+1, n)^2) - 0.5 * abs(u(i+1, n) + u(i, n)) * (u(i+1, n) - u(i, n));
        
        % Update solution using flux
        u(i, n+1) = u(i, n) - dt/dx * (flux - u(i, n)^2);
    end
    % Boundary condition (periodic)
    flux_boundary = 0.5 * (u(Nx, n)^2 + u(1, n)^2) - 0.5 * abs(u(1, n) + u(Nx, n)) * (u(1, n) - u(Nx, n));
    u(Nx, n+1) = u(Nx, n) - dt/dx * (flux_boundary - u(Nx, n)^2);
end

% Plotting
figure;
[X, T] = meshgrid(x, linspace(0, T, Nt));
surf(X, T, u');
xlabel('Space');
ylabel('Time');
zlabel('u(x,t)');
title('Solution of 1D Burger''s Equation without Diffusion Term using Godunov Scheme');

% Animation (optional)
 for n = 1:Nt
     plot(x, u(:, n));
     xlabel('Space');
     ylabel('u(x,t)');
     title(['Time: ', num2str(n*dt)]);
     pause(0.1);
 end
