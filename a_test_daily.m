panelAz = 180;
panelEl = 0;
panelWidth = 1;
panelHeight = 1;
panelEfficiency = 0.21;
indirectIrradiance = 0.1;
useShadow = 1; % 0 clear sky, 1 calc shadow

a_experiment



time = (1:len) * 10 - 10;

day = 0;
xStart = 0 + day;
xEnd = 365 + day;

figure;
plot(time/ 1440,simulatedRes)
hold on;
plot(time/ 1440,solar);
grid on;
xlim([xStart xEnd]);

for i=1:(floor(len/144)-1)
   index = (i-1) * 144 + 1;
   indexEnd = index + 144;

   dailySimulated(i) = sum(simulatedRes(index:indexEnd));
   dailySolar(i) = sum(solar(index:indexEnd));
   
end

figure
plot(dailySimulated);
hold on
grid on
plot(dailySolar);
xlim([0 365])

figure
for i=1:(floor(len/144/30)-1)
   index = (i-1) * 144*30 + 1;
   indexEnd = index + 144*30;

   monthSimulated(i) = sum(simulatedRes(index:indexEnd));
   monthSolar(i) = sum(solar(index:indexEnd));
   
end
bar(monthSimulated(1:12) * 2 * 1 * 10 * 0.2037 * 600 / 3600 / 1000 );
% 10 panelù 2 x 1 m, úèinnost 20,37%, data jsou za 10 minut tedy x600 Ws
% /3600 /1000 kWh
