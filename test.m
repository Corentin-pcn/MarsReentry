M = 7;
disp(M)
for alpha = 0:-2:-24
    disp(alpha)
    [Cl, Cd, l_d] = Ae_coeff(M,alpha)
end

