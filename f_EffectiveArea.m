% width šíøka panelu
% height výška
% el naklonìní ve sttupních
% az odchylka ve stupních od severu (90 je východ)
function ret = f_EffectiveArea (solarBeam, panelAZ, panelEL)
    panelAZ = panelAZ / 180 * pi;
    panelEL = -panelEL / 180 * pi;

    widthVector = [cos(panelAZ) sin(panelAZ) 0];
    
    heightVector = [sin(0.5*pi-panelEL)*cos(0.5*pi+panelAZ), ...
        sin(0.5*pi-panelEL)*sin(0.5*pi+panelAZ), ...
        cos(0.5*pi-panelEL)];
    
    normal = cross(widthVector,heightVector);
    EffectiveArea = dot(normal,transpose(solarBeam));
    if EffectiveArea < 0
        EffectiveArea = 0;
    end
    ret = EffectiveArea;
end