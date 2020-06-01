clear all
close all
clc

h = 75*1000; %between 0  and 120
ISP = 3000;
mu_M = 42828*(1e9);
r_M = 3390*1000;
ga_M = 1.29;
R_M = 191.8;
ratm = 120000+r_M;

a0 = 500000 + r_M;
va = sqrt(mu_M/a0);
rp = h + r_M;

dr = a0 - rp;
dva = (dr*mu_M)/(4*(a0^2)*va);
e = (a0-rp)/(a0+rp);
a = (a0+rp)/2;
theta = acos((a*(1-e^2)-ratm)/(ratm*e));
gamma0 = atan((e*sin(theta))/(1+e*cos(theta)));
v0 = sqrt(((2*mu_M)/ratm)-(mu_M/a));

mi = 1500;
mf = mi/exp(dva/ISP);

[t,y] = ode15s(@Mars_mission,[0:0.1:2000], [v0 gamma0 ratm 0 mf]);

h = y(:,3) - r_M;

for i = h
    [T, P, rho] = Mars_atm(i);
end
c = sqrt(R_M*ga_M*T);

figure(1)
subplot(2,2,1);
plot(t,h/1000)
title('altitude in km')

subplot(2,2,2);
plot(t,y(:,1))
title('speed in m/s')

subplot(2,2,3);
plot(t,y(:,2))
title('Flight path angle in rad')

subplot(2,2,4);
plot(t,y(:,1)./c)
title('Mach')

figure(2)

subplot(2,1,1)
plot(h/1000,y(:,1))
title('speed by altitude')

subplot(2,1,2)
plot((r_M*y(:,4))/1000,y(:,1))
title('speed by phi')


heat_flux = HeatFlux(y(:,1), -14, rho);
hf_integrated = (trapz([0:0.1:2000],heat_flux)*0.0002778)

max_qd = max(heat_flux)