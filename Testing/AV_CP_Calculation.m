% Read the data from the Excel file
CP_CELL = readtable("AV_CP_C2_K4_T2.xlsx") ;
CP_KAL = readtable("CP_K4_13032025.xlsx");
% Extract time values from the first column
time = table2array(mean(CP_CELL(:, 1),2)) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Extract temperature values (Celsius) and convert to Kelvin
k1 = table2array(CP_CELL(:, 2)) ; k1 = k1 + 273.15; %Probe 1 
k4 = table2array(CP_CELL(:, 3)) ; k4 = k4 + 273.15; %Probe 4 
k5 = table2array(CP_CELL(:, 4)) ; k5 = k5 + 273.15; %Probe 5

% Extract temperature values from calibration run
k4_cal = table2array(CP_KAL(:, 2)); k4_cal = k4_cal + 273.15;

%Masses 
mc = 0.363; %Mass chamber
mw = table2array(CP_CELL(1, 5)); %Mass Water
mw_f = table2array(CP_CELL(1, 6)); %Mass Water after testing
mb = table2array(CP_CELL(1, 7)); %Mass battery

% Known specific heat capacity 
cw = 4.18; % kJ/kg*K % Cp water 
cc = 0.5 ; % kJ/kg*K  % Cp Chamber

% Set index limits for datasets
% Start temperature measurements of T_loss at 10 seconds
% due to noisy measurements before 10 s
% multiplied by 50 because of the sample rate of 50 Hz
t_initial = 1*50; 
t_final = 1800*50;
T_w_initial = 10*50;

% Find the average value for the battery surface
T_b = mean([k1 k5], 2);

%Temperatures
T_amb = T_b(t_initial); %initial Temperature battery

T_i = k4(t_initial); %Initial Temperature Water 
T_f = k4(t_final); %Final Temperature System

T_abs_loss = (k4_cal(T_w_initial)-k4_cal(t_final)); %Temperature Loss

%Q loss 
Q_loss = ((T_abs_loss)*(cw*mw+cc*mc));

%Specific heat capacity Battery 
cb = ((T_i-T_f)*(mw_f*cw + mc*cc) - Q_loss)/(mb*(T_f-T_amb)); 

T_water = k4; % T_water data
T_loss = k4_cal; % Calibration data (T_loss)

% Time vector
t = time;
t_min = 1;
t_max = 1800;
t_w = 10;

% Extract the indices corresponding to time 
indices = (t >= t_min) & (t <= t_max);
T_loss_indices = (t >= t_w) & (t <= t_max);

% Plot
figure;
plot(t(indices), T_b(indices), 'r', 'LineWidth', 3); % T_b in red
hold on;
plot(t(indices), T_water(indices), 'b', 'LineWidth', 3); % T_water in blue
plot(t(T_loss_indices), T_loss(T_loss_indices), 'g', 'LineWidth', 1.5); % T_loss in green
hold off;

% Labels and title
xlabel('Time (s)');
ylabel('Temperature (°K)');
title('Temperature Evolution Over Time');
legend({'T_{b}', 'T_{water}', 'T_{loss} (Calibration)'});
grid on;
xlim([0,1800]);
ylim([273+25 340]);
