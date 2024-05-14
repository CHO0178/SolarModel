
%% Vypoète úhel podle pozice a èasu
% lat úhel ve stupních
% lon úhel ve stupních
% poèet dnù od roku 1.1.2016

function [az, el] =  f_SolarBeam(t) %(lat, lon, t)
 
% https://www.esrl.noaa.gov/gmd/grad/solcalc/
% Mosnov
LatitudeDeg  = 49.823454;
LongitudeDeg = 18.2785034;

%FairView
%LatitudeDeg = 56.07734677859089;
%LongitudeDeg = -118.44169834427086;

TimeZone = +1;

Date = 42370 + t; % 1.1.1900 is 1, 1.1.2016 is 42370
Time = t - floor(t);  %6/24; % 6 is hour
DateTime = Date + Time;

Latitude = LatitudeDeg / 180 * pi;

JulianDay = DateTime+2415018.5-TimeZone/24;
JulianCentury = (JulianDay - 2451545)/36525;
GeomMeanLongSunDeg = mod(280.46646 + JulianCentury * (36000.76983 + JulianCentury * 0.0003032),360);
GeomMeanLongSun = GeomMeanLongSunDeg / 180 * pi;
GeomMeanAmonSunDeg = 357.52911 + JulianCentury * (35999.05029 - 0.0001537 * JulianCentury);
GeomMeanAmonSun = GeomMeanAmonSunDeg / 180 * pi;
EccentEarthOrbit = 0.016708634 - JulianCentury * (0.000042037 + 0.0000001267 * JulianCentury);
SunEqOfCtr = sin(GeomMeanAmonSun) * (1.914602 - JulianCentury * (0.004817 + 0.000014 * JulianCentury))+ sin(2 * GeomMeanAmonSun) * (0.019993 - 0.000101 * JulianCentury) + sin(3 * GeomMeanAmonSun) * 0.000289;
SunTrueLonDeg = GeomMeanLongSunDeg + SunEqOfCtr;
SunTrueAmonDeg = GeomMeanAmonSunDeg + SunEqOfCtr;
SunTrueAmon = SunTrueAmonDeg / 180 * pi;
SunRadVectorAUs = (1.000001018 * (1 - EccentEarthOrbit * EccentEarthOrbit))/(1 + EccentEarthOrbit * cos(SunTrueAmon));
SunAppLongDeg = SunTrueLonDeg - 0.00569 - 0.00478 * sin((125.04 - 1934.136 * JulianCentury) / 180 * pi);
SunAppLong = SunAppLongDeg / 180 * pi;
MeanObliqElipticDeg = 23 + (26 + ((21.448 - JulianCentury * (46.815 + JulianCentury * (0.00059 - JulianCentury * 0.001813))))/60)/60;
ObliqCorrDeg = MeanObliqElipticDeg + 0.00256 * cos((125.04 - 1934.136 * JulianCentury) / 180 * pi);
ObliqCorr = ObliqCorrDeg / 180 * pi;
SunRtAscenDeg = (pi / 2 - atan2(cos(SunAppLong), cos(ObliqCorr) * sin(SunAppLong))) * 180 / pi;
SunDeclinDeg = (asin(sin(ObliqCorr) * sin(SunAppLong))) / pi * 180; % TOTO
SunDeclin = SunDeclinDeg / 180 * pi;
VarY = tan(ObliqCorr / 2) * tan(ObliqCorr / 2);
EqOfTimeMinutes = 4 * (VarY * sin(2 * GeomMeanLongSun)- 2 * EccentEarthOrbit * sin(GeomMeanAmonSun) + 4 * EccentEarthOrbit * VarY * sin(GeomMeanAmonSun) * cos(2 * GeomMeanLongSun) - 0.5 * VarY * VarY * sin(4 * GeomMeanLongSun) - 1.25 * EccentEarthOrbit * EccentEarthOrbit * sin(2 * GeomMeanAmonSun)) * 180 / pi;
HASunriseDeg = (acos(cos(90.833 / 180 * pi) / (cos(Latitude) * cos(SunDeclin)) - tan(Latitude) * tan(SunDeclin))) * 180 / pi;
SolarNoonLST = (720 -4 * LongitudeDeg - EqOfTimeMinutes + TimeZone * 60) / 1440;
SunriseTimeLST = SolarNoonLST - HASunriseDeg * 4 / 1440;
SunsetTimeLST = SolarNoonLST + HASunriseDeg * 4/1440;
SunlightDurationMinutes = 8 * HASunriseDeg;
TrueSolarTimeMin =mod(Time * 1440 + EqOfTimeMinutes + 4 * LongitudeDeg - 60 * TimeZone, 1440);
if TrueSolarTimeMin / 4 < 0
   HourAngleDeg = TrueSolarTimeMin / 4 + 180;   
else
    HourAngleDeg = TrueSolarTimeMin / 4 - 180;
end;
HourAngle = HourAngleDeg / 180 * pi;
SolarZenithAngleDeg = (acos(sin(Latitude) * sin(SunDeclin) + cos(Latitude) * cos(SunDeclin) * cos(HourAngle))) * 180 / pi;
SolarZenithAngle = SolarZenithAngleDeg / 180 * pi;
SolarElevationAngleDeg = 90 - SolarZenithAngleDeg;
SolarElevationAngle = SolarElevationAngleDeg / 180 * pi;


if SolarElevationAngleDeg > -0.575
    PomB = 1735 + SolarElevationAngleDeg * (-518.2 + SolarElevationAngleDeg * (103.4 + SolarElevationAngleDeg * (-12.79 + SolarElevationAngleDeg * 0.711)));
else
    PomB = -20.772 / tan(SolarElevationAngle);
end;
if SolarElevationAngleDeg>5
    PomA = 58.1 / tan(SolarElevationAngle) - 0.07 / tan(SolarElevationAngle) ^ 3 + 0.000086 / tan(SolarElevationAngle) ^ 5;
else
    PomA = PomB;
end;
if SolarElevationAngleDeg > 85
    ApproxAtmosphericRefractionDeg = 0;
else
    ApproxAtmosphericRefractionDeg = PomA / 3600;
end;

SolarElevationCorrectedForAtmRefractionDeg = SolarElevationAngleDeg + ApproxAtmosphericRefractionDeg;
if HourAngleDeg > 0
    SolarAzimuthAngleDeg = mod(180 / pi *(acos(((sin(Latitude) * cos(SolarZenithAngle)) - sin(SunDeclin))/(cos(Latitude) * sin(SolarZenithAngle)))) + 180, 360);
else
    SolarAzimuthAngleDeg = mod(540 - 180 / pi * (acos(((sin(Latitude) * cos(SolarZenithAngle)) - sin(SunDeclin))/(cos(Latitude) * sin(SolarZenithAngle)))), 360);
end





az = SolarAzimuthAngleDeg;
el = SolarElevationAngleDeg;
end