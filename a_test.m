%X - východ
%Y - sever
%Z - nahoru

% az 0 je sever
% az 90 je východ

% f_AzEl2Vector(az, el)
vector = f_AzEl2Vector(15.7,18.3)

% f_EffectiveArea(solarBeam, width, height, panelAZ, panelEL)
area = f_EffectiveArea(vector,2,5,14.9,3.3)