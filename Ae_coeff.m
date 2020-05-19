function [Cl,Cd,l_d] = Ae_coeff(M,alpha)
if M > 7
    if alpha <= -14
        a = 'Hyp';
    else
        fprintf('ERROR')
    end
else
    a = 'Sup';
end
Cd = LAe(strcat('CD_',a,'.csv'),M,alpha);
Cl = LAe(strcat('CL_',a,'.csv'),M,alpha);
l_d = LAe(strcat('L_D_',a,'.csv'),M,alpha);
end

function [F] = LAe(file,M,alpha)
V = csvread(file,1,1);
n = size(V);
x = csvread(file,1,0,[1,0,(n(1)),0]);
y = csvread(file,0,1,[0,1,0,(n(2))]);
[X,Y] = meshgrid(x,y);
V = transpose(V);
F = interp2(X,Y,V,M,alpha,'spline');
end