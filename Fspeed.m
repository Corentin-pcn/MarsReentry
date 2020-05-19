function [w] = Fspeed(V,r)
P = 2*pi*r;
Trot = 24.622962*3600;
w = V - (P/Trot);
end