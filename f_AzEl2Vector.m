function ret = f_AzEl2Vector (az, el)
    az = - (az - 90) / 180 * pi;
    el = pi/2 - el / 180 * pi;
    ret = [sin(el)*cos(az), sin(el)*sin(az), cos(el)];
end