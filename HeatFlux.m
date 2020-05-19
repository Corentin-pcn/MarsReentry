function [HF] = HeatFlux(velocity, alpha, RHO)
%   Inputs required are: 
%   velocity:Numeric array of the capsule velocity in meters per second. 
%   alpha   :Numeric array of the capsule velocity in meters per second.
%   RHO     :Numeric array of M air density in kilograms per meter cubed.
%   
%   Parameters:
%   BC       :Scalar, change according to the freestream flow velocity.
%   BR       :Scalar, change according to the freestream flow velocity.
%   W        :Scalar, freestream flow velocity, have to be calculated
%   according to the velocity and alpha angle.
%   Rn       :Scalar of nose radius of vehicle in meters.
%   RHOsl    :Scalar of atmospheric density at sea level.
%   CHIc     :Scalar, change according to the freestream flow velocity.
%   CHIr     :Scalar, change according to the freestream flow velocity.
%   PSIc     :Scalar, change according to the freestream flow velocity.
%   PSIr     :Scalar, change according to the freestream flow velocity.
%
%   Outputs calculated for the lapse rate atmosphere are: 
%   HF       :Numeric array of the heat flux in Watt per meters second squared. 

w = velocity.*cosd(alpha);
[T, P, RHOsl] = Mars_atm(0);
Rn = 1.125;
if ~isnumeric(velocity)&&isnumeric(alpha)&&isnumeric(RHO)
    error(message('aero:atmoslapse:notNumeric'));
end
HF = [];
for i = length(w): -1 :1
    if ( w(i) <= 7900 )
        BC = 9823.4;
        BR = 1135.7;
        CHIc = 3.15;
        CHIr = 8.5;
        PSIc = 0.5;
        PSIr = 1.6;
        qd_conv = BC*(w(i)/3.048)^CHIc*(RHO(i)/RHOsl)^PSIc*sqrt(0.3048/Rn);
        qd_rad = BR*(w(i)/3.048)^CHIr*(RHO(i)/RHOsl)^PSIr*(0.3048/Rn);
        qd = qd_conv+qd_rad;
        HF = [HF qd];
    end

    if ( w(i) > 7900 )
        BC = 9823.4;
        BR = 85.174;
        CHIc = 3.15;
        CHIr = 12.5;
        PSIc = 0.5;
        PSIr = 1.5;
        qd_conv = BC*(w(i)/3.048)^CHIc*(RHO(i)/RHOsl)^PSIc*sqrt(0.3048/Rn);
        qd_rad = BR*(w(i)/3.048)^CHIr*(RHO(i)/RHOsl)^PSIr*(0.3048/Rn);
        qd = qd_conv+qd_rad;
        HF = [HF qd];
    end
end
end
