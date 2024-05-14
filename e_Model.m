% t je v minutach
function [intensity, area]  = e_Model(t, panelAz, panelEl)
    
    tDay = t / 1440;
    [az, el] = f_SolarBeam(tDay);
    
    if el < 0
        area = 0;
        intensity = 0;
        return;
    end
    
    solarBeamVector = f_AzEl2Vector(az, el);    
    
    intensity = f_Intensity(el); % in Wats
    area = f_EffectiveArea(solarBeamVector, panelAz, panelEl);    
            
end


