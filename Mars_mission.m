function [dy] = Mars_mission(t,y)

% Parameters declaration
mu_M = 42828*(1e9);% Gravitationnal constant for Mars
ga_M = 1.29;% Gamma for Mars atmosphere
R_M = 191.8;% Gas constant on Mars
alpha = -14;% Angle of attack
r_M = 3390*1000;% Mars radius
A = 19; % Surface of vehicle

w = Fspeed(y(1),y(3));% Speed by substraction of atmosphere speed
h = y(3) - r_M;% altitude
[T, P, rho] = Mars_atm(h);% Get the characteristic of atmosphere at altitude h
c = sqrt(R_M*ga_M*T);% Compute speed of sound
M = y(1)/c;% Compute Mach number

if (M < 2)% At Mach 2 change the angle of attack to 0 and expusle shield of 386.45 kg
    alpha = 0;
    y(5) = 1068.9;
end

[Cl,Cd,l_d] = Ae_coeff(M,alpha);% Get the aerodynamic coefficient at mach M and angle alpha

q = (0.5)*rho*(w^2);
L = q*A*Cl;% calculate the Lift force
D = q*A*Cd;% calculate Drag force
    
% Compute the dy using the differential equation seen in guided work
dy(1) = -D/y(5)+( mu_M/y(3)^2 )*sin(y(2));
dy(2) = -L/(y(5)*y(1))+(mu_M/((y(3)^2)*y(1))-y(1)/y(3))*cos(y(2));
dy(3) = -y(1)*sin(y(2));
dy(4) = (y(1)/y(3))*cos(y(2));
dy(5) = 0;

if (and((M < 2),(M > 0)))% New derivative at Mach 2 considering the parachute
    dy(1) = (-D-23355)/y(5)+( mu_M/y(3)^2 )*sin(y(2));% adding the parachute as a drag force
    dy(2) = -L/(y(5)*y(1))+(mu_M/((y(3)^2)*y(1))-y(1)/y(3))*cos(y(2));
    dy(3) = -y(1)*sin(y(2));
    dy(4) = (y(1)/y(3))*cos(y(2));
    dy(5) = 0;
end

if (y(3) < r_M)% STOP at the Mars radius
    dy(1) = 0;
    dy(2) = 0;
    dy(3) = 0;
    dy(4) = 0;
    dy(5) = 0;
end
dy = dy.';% transpose the dy
end