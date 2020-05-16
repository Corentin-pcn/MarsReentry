function [w] = Fspeed(V,r)
r = r + (3390*1000);
P = 2*pi*r;
Trot = 24.622962*3600;
w = V - (P/Trot);
end