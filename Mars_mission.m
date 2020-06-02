function [dy] = Mars_mission(t,y)

mu_M = 42828*(1e9);
ga_M = 1.29;
R_M = 191.8;
alpha = -14;
r_M = 3390*1000;
A = 19;

w = Fspeed(y(1),y(3));
h = y(3) - r_M;
[T, P, rho] = Mars_atm(h);
c = sqrt(R_M*ga_M*T);
M = y(1)/c;

% if (M < 18)
%     alpha = -14
% end

if (M < 5)
    alpha = -4;
end

if (M < 2)
    alpha = 0;
    y(5) = 1068.55;
end

[Cl,Cd,l_d] = Ae_coeff(M,alpha);

q = (0.5)*rho*(w^2);
L = q*A*Cl;
D = q*A*Cd;
    

dy(1) = -D/y(5)+( mu_M/y(3)^2 )*sin(y(2));
dy(2) = -L/(y(5)*y(1))+(mu_M/((y(3)^2)*y(1))-y(1)/y(3))*cos(y(2));
dy(3) = -y(1)*sin(y(2));
dy(4) = (y(1)/y(3))*cos(y(2));
dy(5) = 0;

if (and((M < 2),(M > 0)))
    dy(1) = (-D-23355)/y(5)+( mu_M/y(3)^2 )*sin(y(2));
    dy(2) = -L/(y(5)*y(1))+(mu_M/((y(3)^2)*y(1))-y(1)/y(3))*cos(y(2));
    dy(3) = -y(1)*sin(y(2));
    dy(4) = (y(1)/y(3))*cos(y(2));
    dy(5) = 0;
end

if (y(3) < r_M)
    dy(1) = 0;
    dy(2) = 0;
    dy(3) = 0;
    dy(4) = 0;
    dy(5) = 0;
end
dy = dy.';
end