function [T,P,rho] = Mars_atm(h)
M_Temp = csvread('MarsATM_Temp.csv');
[Xe_Temp, i2] = unique(M_Temp(:,1));
Ye_Temp = M_Temp(i2,2);

M_rho = csvread('MarsATM_rho.csv');
[Xe_rho, i2] = unique(M_rho(:,1));
Ye_rho = M_rho(i2,2);

M_P = csvread('MarsATM_P.csv');
[Xe_P, i2] = unique(M_P(:,1));
Ye_P = M_P(i2,2);


T = interp1(Xe_Temp,Ye_Temp,h,'pchip');
rho = interp1(Xe_rho,Ye_rho,h,'pchip');
P = interp1(Xe_P,Ye_P,h,'pchip');
end

