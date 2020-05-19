function [w] = Fspeed(V,r)
P = 2*pi*r;
Trot = 24.622962*3600;
Vp = (P/Trot);
w = V - Vp;
end