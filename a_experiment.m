%panelAz = 180;
%panelEl = 80;
%panelWidth = 1;
%panelHeight = 1;
%panelEfficiency = 0.21;
%indirectIrradiance = 0.1;

%useShadow = 1; % 0 clear sky, 1 calc shadow

data = load('data/mosnov_RGLB10.csv');
solar = data(:,6);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%data = load('data/Fairview5min08-12_consistent.csv');
%solar = data(:,4);
%len = size(solar,1);
% % Vypoèítáme prùmìr každých dvou po sobì jdoucích prvkù
%solar10 = (solar(1:2:len-1) + solar(2:2:len)) / 2;
% % Pokud je poèet prvkù v pùvodním vektoru lichý, poslední prvek se nezprùmìruje
%if mod(length(data), 2) == 1
%    solar10 = [solar10; solar(len)];
%end
%solar = solar10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


len = size(solar,1);

simulatedRes = zeros(len,1);


for i = 1:len
    t = (i-1) * 10;
    historical = solar(i);
    
    if useShadow == 0
        shadow = 0;
    end 
    if useShadow == 1       
        tDay = t / 1440;
       
        [intensity, areaCoef] = e_Model(t, 0, 0);
        
        % Calc global irradiance
        simulated = intensity * areaCoef + indirectIrradiance * intensity;
        shadow = f_Shadow(historical, simulated);   
    end
    
    [intensity, areaCoef] = e_Model(t,panelAz, panelEl);
    
    % Calc global irradiance
    simulated =(intensity * areaCoef + indirectIrradiance * intensity) * (1-shadow);    
    simulatedRes(i) = simulated;
end