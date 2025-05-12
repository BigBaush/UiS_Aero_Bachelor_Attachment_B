%Requires first that you replace relevant file names with the correct xlsx datasheet into matlab
%dVoc/dT PLOTTING IN MATLAB

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Getting data
    %dVoc/dt
dVoc_dT_25C= readtable( 'dV_oc_dt\INR21700 48G\RS_C2_dVoc_dt_T2_25C_CHG-DCHG.xlsx' ) ; %replace right side swith the name of the data set
dVoc_dT_40C= readtable( 'dV_oc_dt\INR21700 48G\RS_C2_dVoc_dt_T1_40C_CHG-DCHG.xlsx' ) ; %replace right side swith the name of the data set
dVoc_dT_55C= readtable( 'dV_oc_dt\INR21700 48G\RS_C2_dVoc_dt_T2_55C_CHG-DCHG.xlsx' ) ; %replace right side swith the name of the data set

    %Temp 
Temp_25C = readtable( 'dV_oc_dt\INR21700 48G\RS_C2_dVoc_dt_T2_25C_TEMP.xlsx' ) ; %Temperature Sheet
Temp_40C = readtable( 'dV_oc_dt\INR21700 48G\RS_C2_dVoc_dt_T1_40C_TEMP.xlsx' ) ; %Temperature sheet
Temp_55C = readtable( 'dV_oc_dt\INR21700 48G\RS_C2_dVoc_dt_T2_55C_TEMP.xlsx' ) ; %Temperature Sheet

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Making CHG Time plots
T_DCHG_25C = table2array(dVoc_dT_25C(:,1)); T_DCHG_25C(isnan(T_DCHG_25C))=[]; %Creates array, and removes NaN
T_DCHG_40C = table2array(dVoc_dT_40C(:,1)); T_DCHG_40C(isnan(T_DCHG_40C))=[]; %Creates array, and removes NaN
T_DCHG_55C = table2array(dVoc_dT_55C(:,1)); T_DCHG_55C(isnan(T_DCHG_55C))=[]; %Creates array, and removes NaN

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%making DCHG arrays
    %25C
V_DCHG_25C = table2array(dVoc_dT_25C(:,7)); V_DCHG_25C(isnan(V_DCHG_25C))=[]; %Creates array, and removes NaN
C_DCHG_25C = table2array(dVoc_dT_25C(:,9)); C_DCHG_25C(isnan(C_DCHG_25C))=[]; %Creates array, and removes NaN
C_DCHG_25C_SOC = C_DCHG_25C ./ C_DCHG_25C(end); %SOC  

    %40C
V_DCHG_40C = table2array(dVoc_dT_40C(:,7)); V_DCHG_40C(isnan(V_DCHG_40C))=[]; %Creates array, and removes NaN
C_DCHG_40C = table2array(dVoc_dT_40C(:,9)); C_DCHG_40C(isnan(C_DCHG_40C))=[]; %Creates array, and removes NaN
C_DCHG_40C_SOC = C_DCHG_40C ./ C_DCHG_40C(end); %SOC 

    %55C
V_DCHG_55C = table2array(dVoc_dT_55C(:,7)); V_DCHG_55C(isnan(V_DCHG_55C))=[]; %Creates array, and removes NaN
C_DCHG_55C = table2array(dVoc_dT_55C(:,9)); C_DCHG_55C(isnan(C_DCHG_55C))=[]; %Creates array, and removes NaN
C_DCHG_55C_SOC = C_DCHG_55C ./ C_DCHG_55C(end); %SOC

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Temperature Averaging 
float_points = 10;

    %25C
Avg_Temp_25C = mean(table2array(Temp_25C(length(T_DCHG_25C):end , 2:7)), 2) + 273.15; 
Avg_Temp_25C = movmean(Avg_Temp_25C, float_points);
[T_Min_25C, T_Max_25C] = bounds(Temp_25C(length(T_DCHG_25C):end , 2:7), 'all') ;

    %40C
Avg_Temp_40C = bounds(table2array(Temp_40C(length(T_DCHG_40C):end , 2:7)), 2) + 273.15; 
Avg_Temp_40C = movmean(Avg_Temp_40C, float_points);
[T_Min_40C, T_Max_40C] = bounds(Temp_40C(length(T_DCHG_40C):end , 2:7), 'all');

    %55C
Avg_Temp_55C = mean(table2array(Temp_55C(length(T_DCHG_25C):end , 2:7)), 2) + 273.15;
Avg_Temp_55C = movmean(Avg_Temp_55C, float_points);
[T_Min_55C, T_Max_55C] = bounds(Temp_55C(length(T_DCHG_55C):end , 2:7), 'all') ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Reducing vectors 
numPoints = 1000;

    %25 degree 
x_new = linspace(1, length(C_DCHG_25C_SOC), numPoints);
CR_DCHG_25C_SOC = interp1(1:length(C_DCHG_25C_SOC), C_DCHG_25C_SOC, x_new) ;
VR_DCHG_25C = interp1(1:length(V_DCHG_25C), V_DCHG_25C, x_new) ;
TR_DCHG_25C = interp1(1:length(Avg_Temp_25C), Avg_Temp_25C, x_new) ;

    %40 degree
x_new = linspace(1, length(C_DCHG_40C_SOC), numPoints);
CR_DCHG_40C_SOC = interp1(1:length(C_DCHG_40C_SOC), C_DCHG_40C_SOC, x_new) ;
VR_DCHG_40C = interp1(1:length(V_DCHG_40C), V_DCHG_40C, x_new) ;
TR_DCHG_40C = interp1(1:length(Avg_Temp_40C), Avg_Temp_40C, x_new) ;

    %55 degree 
x_new = linspace(1, length(C_DCHG_55C_SOC), numPoints);
CR_DCHG_55C_SOC = interp1(1:length(C_DCHG_55C_SOC), C_DCHG_55C_SOC, x_new) ;
VR_DCHG_55C = interp1(1:length(V_DCHG_55C), V_DCHG_55C, x_new) ;
TR_DCHG_55C = interp1(1:length(Avg_Temp_55C), Avg_Temp_55C, x_new) ;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plotting dVoc/dT
figure; 
hold on

for T_list = [273.15 293.15, 313.15]
    %Finding Derivative 
    %T = linspace(T_list, T_list+40, numPoints);
    T = T_list
    dVoc_25C = VR_DCHG_25C() .* (2.*T - TR_DCHG_40C - TR_DCHG_55C) ./ ( (TR_DCHG_25C - TR_DCHG_40C) .* (TR_DCHG_25C - TR_DCHG_55C) ); 
    dVoc_40C = VR_DCHG_40C .* (2.*T - TR_DCHG_25C - TR_DCHG_55C) ./ ( (TR_DCHG_40C - TR_DCHG_25C) .* (TR_DCHG_40C - TR_DCHG_55C) ); 
    dVoc_55C = VR_DCHG_55C .* (2.*T - TR_DCHG_25C - TR_DCHG_40C) ./ ( (TR_DCHG_55C - TR_DCHG_25C) .* (TR_DCHG_55C - TR_DCHG_25C) ); 
    derivative = dVoc_25C + dVoc_40C + dVoc_55C; 

    plot(CR_DCHG_55C_SOC, derivative) 
end
legend('273.15', '293.15', '313.15')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%plotting arrays + Plot parameters: 
figure;
plot(CR_DCHG_55C_SOC,VR_DCHG_55C, CR_DCHG_40C_SOC, VR_DCHG_40C, CR_DCHG_25C_SOC, VR_DCHG_25C) 
legend('55C', '40C', '25C')
