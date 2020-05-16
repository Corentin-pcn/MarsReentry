function [dy] = Mars_mission(t,y)

mu_M = 42828;
ga_M = 1.29;
R_M = 191.8;
alpha = -16;
r_M = 3390*1000;
A = 19;

w = Fspeed(y(1),y(3));
[T, P, rho] = Mars_atm(y(3))
c = sqrt(R_M*ga_M*T);
M = y(1)/c;


[Cl,Cd,l_d] = Ae_coeff(M,alpha);

L = (0.5)*rho*(w^2)*A*Cl;
D = (0.5)*rho*(w^2)*A*Cd;

dy(1) = (-D/y(5))+((mu_M/(y(3)^2))*sin(y(2)));
dy(2) = (L/y(5))+(mu_M/((y(3)^2)*y(1))-y(1)/y(3))*cos(y(2));
dy(3) = -y(1)*sin(y(2));
dy(4) = (y(1)/y(3))*cos(y(2));
dy(5) = 0;
dy = dy.';
end