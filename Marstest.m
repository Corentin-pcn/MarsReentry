clear all
close all
clc

h = 75*1000; %altitude of periapsis of reentry ellipse between 0  and 120
ISP = 3000;% ISP of impulse system for reentry burn in m/s
mu_M = 42828*(1e9);% mu of Mars
r_M = 3390*1000;% radius of Mars
ga_M = 1.29;% gamma of Mars
R_M = 191.8;% gas constant for Mars
ratm = 120000+r_M;% Radius where atmosphere start to get importance

a0 = 500000 + r_M;% Radius of starting orbit
va = sqrt(mu_M/a0);% speed at starting orbit
rp = h + r_M;% radius of periapsis for reentry ellipse

dr = a0 - rp;% difference of radius between starting orbit and reentry ellipse
dva = (dr*mu_M)/(4*(a0^2)*va);% difference of speed for the previous difference of radius
e = (a0-rp)/(a0+rp);% compute eccentricity of reentry ellipse
a = (a0+rp)/2;% compute semi-major axis of reentry ellipse
theta = acos((a*(1-e^2)-ratm)/(ratm*e));%Get the true anomaly at atmosphere start radius
gamma0 = atan((e*sin(theta))/(1+e*cos(theta)));% Compute flight path angle at rentry point
v0 = sqrt(((2*mu_M)/ratm)-(mu_M/a));% Compute speed at reentry point

mi = 1500;% Mass at start
mf = mi/exp(dva/ISP);% Mass after reentry burn

[t,y] = ode15s(@Mars_mission,[0:0.1:1785], [v0 gamma0 ratm 0 mf]);%Integration of the trajectory taken from Mars_mission file

h = y(:,3) - r_M;% altitude during trajectory

for i = h%Get characteristic in the entire atmosphere
    [T, P, rho] = Mars_atm(i);
end
c = sqrt(R_M*ga_M*T);%Speed of sound in the entire atmosphere

figure(1)
plot(t,y(:,1))
title('Speed')
xlabel('time t (s)')
ylabel('speed v (m/s)')
%Figure of speed of vehicle

figure(2)
plot(t,y(:,1)./c)
title('Mach number')
xlabel('time t (s)')
ylabel('Mach M')
%Figure of Mach number

figure(3)
plot(t,h/1000)
title('Altitude')
xlabel('time t (s)')
ylabel('altitude h (km)')
ylim([0 120])
%Figure of altitude

figure(4)
plot(t,(y(:,4)*(r_M/1000)))
title('Distance')
xlabel('time t (s)')
ylabel('distance d (km)')
% figure of distance over ground

a = diff(y(:,1))./diff(t);% calculate acceleration with differences

figure(5)
plot(t(1:length(t)-1),a)
title('Acceleration')
xlabel('time t (s)')
ylabel('acceleration a (m/s2)')
%Figure of acceleration

mass = zeros([1,length(t)]);

for i=1:length(t)
    mass(i) = mf;
    if y(i,1)/c(i) < 2
        mass(i) = mf-386.45;
    end
end
%create a mass vector over time

figure(6)
plot(t,mass)
title('Vehicle mass')
xlabel('time t (s)')
ylabel('mass m (kg)')
%Figure of mass

heat_flux = HeatFlux(y(:,1), -14, rho);
%compute the heatflux
hf_integrated = (trapz([0:0.1:1785],heat_flux)*0.0002778)
%integrate qdot over time of the trajectory
max_qd = max(heat_flux)
%Get the qdot max