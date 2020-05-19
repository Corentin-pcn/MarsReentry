clear all
close all
clc

h = 75*1000; %between 0  and 120
ISP = 3000;
mu_M = 42828*(1e9);
r_M = 3390*1000;
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

figure(1)
plot(t,y(:,1))

figure(2)
plot(t,y(:,2))

figure(3)
plot(y(:,4),(y(:,3)-r_M)/1000)