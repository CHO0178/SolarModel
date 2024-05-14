%% Vypoète intenzitu paprsku po prùchodu atmosférou na metr kolmý nikoli vodorovný
% elevation in degree
function ret = f_Intensity(solarBeamElevation) 
    phi = deg2rad(90-solarBeamElevation);
    if solarBeamElevation < 0
        phi = 90;
    end
    atmosphericMass = 1/cos(phi)+0.50572*((96.07995-phi)^-1.6364);
    if atmosphericMass < 0
        solarIntensity = 0;
    else
        solarIntensity = 1.135*(0.7^(atmosphericMass^0.678));
    end
    ret = solarIntensity * 1372.5;
    
    
    %ret = ret * sin(solarBeamElevation / 180 * pi);
    %https://www.pveducation.org/pvcdrom/properties-of-sunlight/air-mass
end