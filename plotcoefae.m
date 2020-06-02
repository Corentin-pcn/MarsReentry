AoA = -14;
M = 0:0.1:27;

aCL = [];
aCD = [];
aL_D = [];

CL = [];
CD = [];
L_D = [];
for a = -14:-2:-24
for m = 0:0.1:27
    [Cl, Cd, l_d] = Ae_coeff(m,a);
    CL = [CL Cl];
    CD = [CD Cd];
    L_D = [L_D l_d];
end
aCL = [aCL CL];
aCD = [aCD CD];
aL_D = [aL_D L_D];
end

figure(1)
hold on
for i = 1:1:length(aCL)
plot(M,CL(i))
end
hold off
figure(2)
hold on
for i = 1:1:length(aCL)
plot(M,CD(i))
end
hold off
figure(3)
hold on
for i = 1:1:length(aCL)
plot(M,L_D(i))
end
hold off