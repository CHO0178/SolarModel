
panelWidth = 0.01;
panelHeight = 0.01;
panelEfficiency = 0.21;
indirectIrradiance = 0.1;

useShadow = 1; % 0 clear sky, 1 calc shadow


%PanelAzimuths = [0, 0, 0, 45, 45, 45, 90, 90, 90, 135, 135, 135, 180, 180, 180, 225, 225, 225, 270, 270, 270, 315, 315, 315];
%PanelElevations = [30, 60, 90, 30, 60, 90, 30, 60, 90, 30, 60, 90, 30, 60, 90, 30, 60, 90, 30, 60, 90, 30, 60, 90];

PanelAzimuths = [0 45 90 135 180 225 270 315];
PanelElevations = [30 30 30 30 30 30 30 30];

bSize = size(PanelAzimuths,2);
graphs = zeros(bSize,144);

for b = 1:bSize
    panelAz = PanelAzimuths(b);
    panelEl = PanelElevations(b);
    a_experiment
    
    
    %startIndex = 7*30*144 + 21*30*144; % Letni den s mraky
    %startIndex = 12*30*144 + 23*30*144; % Zimni den s mraky
    %startIndex = 3*30*144 + 24*30*144; % Aprilovy jarni den
    startIndex = 4*30*144 + 15*30*144; % Zamraceno jarni den   
    
    
    
    graphs(b,:) = simulatedRes(startIndex:startIndex+144-1);

end

%plot((0:143)/144,graphs')


% Vytvo�en� nov�ho obr�zku
fontsize = 16; 
figuresize = [200 200 700 320];
figure('Position', figuresize);
set(gca,'FontSize',fontsize);

% Nastaven� barev, tlou��ek a styl� �ar
%colors = ['r', 'g', 'b', 'k', 'r', 'g', 'b', 'k']; % pole barev
colors = [...
            0.85 0.00 0.85; ...
            0.85 0.00 0.85; ...
            0.00 0.00 1.00; ...
            0.00 0.00 1.00; ...
            0.00 0.75 0.00; ...
            0.00 0.75 0.00; ...
            1.00 0.00 0.00; ...
            1.00 0.00 0.00; ...
            ];

         
stileOfGroup1 = '--';
stileOfGroup2 = '-';

%lineStyles = {'-', '--', ':', '-.', '-', '--', ':', '-.'}; % pole styl� �ar
lineStyles = {stileOfGroup1, stileOfGroup2, stileOfGroup1, stileOfGroup2, stileOfGroup1, stileOfGroup2, stileOfGroup1, stileOfGroup2,}; % pole styl� �ar
lineWidths = [2, 1, 2, 1, 2, 1, 2, 1]; % pole tlou��ek �ar

% Vykreslen� k�ivek s nastaven�m
hold on; % Povolit p�ekr�v�n� graf�
for i = 1:8
    plot((0:143)/144*24, graphs(i, :), 'Color', colors(i,:), 'LineStyle', lineStyles{i}, 'LineWidth', lineWidths(i));
end
hold off;

% P�id�n� legendy a popisk�
legend('0�', '45�', '90�', '135�', '180�', '225�', '270�', '315�');
xlabel('time (hours)');
ylabel('Solar radiance (W/m^2)');
%title('K�ivky s r�zn�mi barvami, tlou��kami a styly �ar');
grid on;