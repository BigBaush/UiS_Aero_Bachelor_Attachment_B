% Define constants
L = 0.070;
r = 0.021;
A = 2*pi*r*L;
m = 0.072;
C = 0.85;

% Read the data from the Excel file
CHCT_CELL = readtable("AV_C3_CHTC_T1_TEMP_60.xlsx") ;
% Extract time values from the first column
time = table2array(mean(CHCT_CELL(:, 1),2)) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Extract temperature values in Celsius and convert to Kelvin
k1 = table2array(CHCT_CELL(:, 2)) ; k1 = k1 + 273.15; %Probe 1 
k2 = table2array(CHCT_CELL(:, 3)) ; k2 = k2 + 273.15; %Probe 2 
k3 = table2array(CHCT_CELL(:, 4)) ; k3 = k3 + 273.15; %Probe 3
k4 = table2array(CHCT_CELL(:, 5)) ; k4 = k4 + 273.15; %Probe 4
k5 = table2array(CHCT_CELL(:, 6)) ; k5 = k5 + 273.15; %Probe 5
k6 = table2array(CHCT_CELL(:, 7)); k6 = k6 + 273.15; %Probe 6

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Compute average temperature of K1, K4, K5
avgTemp = mean([k1, k4, k5],2);
movmean(avgTemp, 50);

% Assume ambient temperature is K6
ambientTemp = mean([k2, k3, k6], 2);
movmean(ambientTemp, 50);

% Finding temperature difference between cell and ambient 
deltaT = ambientTemp - avgTemp;

% Compute dT/dt in K/s)
dt = diff(time); % Time step differences
dT = diff(avgTemp);
dT_dt = dT ./ dt; % Compute dT/dt for each temperature variable

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Moving average
points = 2000;
Moving_Mean_DeltaT = movmean(deltaT, points);
Moving_Mean_dT_dt = movmean(dT_dt, points);

% Find reasonable axis limits
a=15000;
b=89999;

% Compute linear fit
mdl = fitlm(Moving_Mean_DeltaT(a:b), Moving_Mean_dT_dt(a:b));

% Extract slope and intercept
slope = mdl.Coefficients.Estimate(2);
intercept = mdl.Coefficients.Estimate(1);

% Calculate surface heat transfer coefficient
h_avg = (m*C*slope)/A;

% Generate fitted line
x_fit = linspace(min(Moving_Mean_DeltaT(a:b)), max(Moving_Mean_DeltaT(a:b)), 100);
y_fit = slope * x_fit + intercept;

% First plot, Ambient Temp - Avg Temp of K1, K4, K5 vs. dT/dt
figure;
plot(Moving_Mean_DeltaT(a:b), Moving_Mean_dT_dt(a:b), 'b-', 'LineWidth', 1.5, 'DisplayName', 'Data');
hold on;
plot(x_fit, y_fit, 'r-', 'LineWidth', 3, 'DisplayName', sprintf('Linear Fit: y = %.4fx + %.4f', slope, intercept));
hold off;

xlim([0 16]);
ylim([0 0.03]);
xlabel('T_{\infty} - T_{B}');
ylabel('dT_{B}/dt) (K/s)');
title('dT/dt vs. Temperature Difference (Ambient - Avg)');
legend('Location', 'Best');
grid on;


% Second plot, Time vs. Temperature
figure;
plot(time(a:b), ambientTemp(a:b), 'b', 'LineWidth', 1.5); hold on;
plot(time(a:b), avgTemp(a:b), 'r', 'LineWidth', 1.5);
xlabel('Time (s)');
ylabel('Temperature (K)');
title('Ambient Temperature vs. Surface Temperature (K1, K4, K5)');
legend('Ambient Temp (K6)', 'Avg Surface Temp (K1, K4, K5)', 'Location', 'Best');
grid on;
