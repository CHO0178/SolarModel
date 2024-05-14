panelAz = 180;
panelEl = 30;
panelWidth = 0.01;
panelHeight = 0.01;
panelEfficiency = 0.21;
indirectIrradiance = 0.1;

useShadow = 0; % 0 clear sky, 1 calc shadow
a_experiment
clearSky = simulatedRes;

useShadow = 1; % 0 clear sky, 1 calc shadow
a_experiment
cloudy = simulatedRes;

time = (1:len) * 10 - 10;

day = 0;
xStart = 0 + day;
xEnd = 365 + day;


for i=1:(floor(len/144)-1)
   index = (i-1) * 144 + 1;
   indexEnd = index + 144;

   dailyClearSky(i) = sum(clearSky(index:indexEnd));
   dailyCloudy(i) = sum(cloudy(index:indexEnd));
   
end

figure
plot(dailyClearSky);
hold on
grid on
plot(dailyCloudy);
xlim([0 365])


for i=1:(floor(len/144/30)-1)
   index = (i-1) * 144*30 + 1;
   indexEnd = index + 144*30;

   monthClear(i) = sum(clearSky(index:indexEnd));
   monthCloudy(i) = sum(cloudy(index:indexEnd));
   
end

fontsize = 16; 
figuresize = [200 200 700 300];
figure('Position', figuresize);
set(gca,'FontSize',fontsize);
%bar(monthClear(1:12) * panelWidth * panelHeight * panelEfficiency * 600 / 1000 );
%hold on
%bar(monthCloudy(1:12) * panelWidth * panelHeight * panelEfficiency * 600 / 1000 );
bar([monthClear(1:12); monthCloudy(1:12)]' * panelWidth * panelHeight * panelEfficiency * 600 / 1000 );
grid on;
xlabel('month');
ylabel('E (kJ)');
legend('Clear sky','Clouds');

