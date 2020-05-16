clear all
close all
clc

m = 1500;
r0 = 3510*1000;
gamma0 = deg2rad(2.196);
v0 = 3570;

[t,y] = ode15s(@Mars_mission,[0 100], [v0 gamma0 r0 0 m]);