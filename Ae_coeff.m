function [Cl,Cd,l_d] = Ae_coeff(M,alpha)
if M > 7%Tell if hypersonic of supersonic
    if alpha <= -14%Hypersonic regime not before -14 of angle of attack
        a = 'Hyp';
    else
        fprintf('ERROR')
    end
else
    a = 'Sup';
end
Cd = LAe(strcat('CD_',a,'.csv'),M,alpha);%Get drag coefficient
Cl = LAe(strcat('CL_',a,'.csv'),M,alpha);%Get lift coefficient
l_d = LAe(strcat('L_D_',a,'.csv'),M,alpha);%Get lift to drag ratio
end

function [F] = LAe(file,M,alpha)%Use the csv data to interpolate
V = csvread(file,1,1);%take values
n = size(V);
x = csvread(file,1,0,[1,0,(n(1)),0]);%Take the mach used for value
y = csvread(file,0,1,[0,1,0,(n(2))]);%Take the angle of attack used
[X,Y] = meshgrid(x,y);%Create a meshgrid of mach number and angle of attack
V = transpose(V);
F = interp2(X,Y,V,M,alpha,'spline');%Interpolate and the find the value for mach M and angle of attack alpha
end