
panelWidth = 0.01;
panelHeight = 0.01;
panelEfficiency = 0.21;
indirectIrradiance = 0.1;

useShadow = 1; % 0 clear sky, 1 calc shadow


PanelAzimuths = [0, 0, 0, 45, 45, 45, 90, 90, 90, 135, 135, 135, 180, 180, 180, 225, 225, 225, 270, 270, 270, 315, 315, 315];
PanelElevations = [30, 60, 90, 30, 60, 90, 30, 60, 90, 30, 60, 90, 30, 60, 90, 30, 60, 90, 30, 60, 90, 30, 60, 90];

bSize = size(PanelAzimuths,2);
Results = zeros(4,bSize);

for b = 1:bSize
    panelAz = PanelAzimuths(b);
    panelEl = PanelElevations(b);
    a_experiment
           
    Results(1,b) = sum(simulatedRes(2*30*144:3*30*144)); % Bøezen
    Results(2,b) = sum(simulatedRes(5*30*144:6*30*144)); % Èerven
    Results(3,b) = sum(simulatedRes(8*30*144:9*30*144)); % Záøí
    Results(4,b) = sum(simulatedRes(11*30*144:12*30*144)); % Prosinec
end

% / 1000 je kJ
Energy = Results * panelWidth * panelHeight * panelEfficiency * 600 / 1000;