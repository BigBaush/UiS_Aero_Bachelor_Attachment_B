%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc; 
clear all;

%Global Variables
T_SR_Hz=2; %Sample Rate Temp
float_AVG_points = 200; %AVG Points For rolling average to smooth out temp Curve
numPoints = 1000; %Number of points to be used in output

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Creating table of file names

    %CHG DCHG Data 
CHG_DCHG_File_Table{1}= 'CHG_DCHG\INR21700 48G\RS_C1_CHG_DCHG_T1_4_8_A_booster.xlsx' ; %replace right side swith the name of the data set
CHG_DCHG_File_Table{2}= 'CHG_DCHG\INR21700 48G\RS_C1_CHG_DCHG_T1_7_2_A_booster.xlsx' ; %replace right side swith the name of the data set
CHG_DCHG_File_Table{3}= 'CHG_DCHG\INR21700 48G\RS_C1_CHG_DCHG_T1_9_6_A_booster.xlsx' ; %replace right side swith the name of the data set


    %Temp Data
Temp_File_Table{1}= 'CHG_DCHG\INR21700 48G\RS_C1_CHG_DCHG_T1_4_8_A_TEMP.xlsx' ; %replace right side swith the name of the data set
Temp_File_Table{2}= 'CHG_DCHG\INR21700 48G\RS_C1_CHG_DCHG_T1_7_2_A_TEMP.xlsx' ; %replace right side swith the name of the data set
Temp_File_Table{3}= 'CHG_DCHG\INR21700 48G\RS_C1_CHG_DCHG_T1_9_6_A_TEMP.xlsx' ; %replace right side swith the name of the data set


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Creating Common table of relevant data 
out_table = table;

for index =1:length(CHG_DCHG_File_Table)

        % Extracting Data from table
    CHG_DCHG_Table = string(CHG_DCHG_File_Table(index))
    CHG_DCHG = readtable(CHG_DCHG_Table, 'PreserveVariableNames', false);

        %Making arrays
    V_DCHG = table2array(CHG_DCHG(:,7)); V_DCHG(isnan(V_DCHG))=[]; %Creates array, and removes NaN
    C_DCHG = table2array(CHG_DCHG(:,9)); C_DCHG(isnan(C_DCHG))=[]; %Creates array, and removes NaN
    t_CHG = table2array(CHG_DCHG(:,1)); t_CHG(isnan(t_CHG))=[]; %Creates array, and removes NaN
    t_DCHG = table2array(CHG_DCHG(:,6)); t_DCHG(isnan(t_DCHG))=[]; %Creates array, and removes NaN
    
        %Finding DCHG Time Index

        %Making Temp table 
    temp = string( Temp_File_Table(index) ) 
    temp  = readtable(temp, 'PreserveVariableNames', false) ; %Convertion: Cell -> String -> Table

        %time, Temp Table 
    t_Temp = table2array(temp(t_CHG(end)+600:end, 1 )); t_Temp(isnan(t_Temp))=[]; %Creates array, and removes NaN

        %Create average array over all probles
    T_Temp = max(table2array(temp(t_CHG(end)+600:end, 2:7)),[], 2) ; T_Temp(isnan(T_Temp))=[]; %Creates array, and removes NaN
    T_Temp = movmean(T_Temp, float_AVG_points);

        %Finding Max/Min points
    [T_Min, T_Max] = bounds(T_Temp, 'all') ; 

    t_i = find(abs(T_Temp-T_Min) <= 1) ; t_i = t_i -T_SR_Hz*300;
    t_f = find(abs(T_Temp-T_Max)<= 1);    

    t_Temp = t_Temp(t_i(end):t_f(end)); T_Temp = T_Temp(t_i(end): t_f(end));
    T_Temp = T_Temp - T_Temp(1)+273.15;
        %Plotting Voltage/Capacity 
    
        %Data Length Changer: 
    x_new = linspace(1, length(V_DCHG), numPoints) ;
    VR_DCHG = interp1(1:length(V_DCHG), V_DCHG, x_new) ;
    CR_DCHG = interp1(1:length(C_DCHG), C_DCHG, x_new) ; 

    x_new = linspace(1, length(t_Temp), numPoints) ;
    tR_Temp = interp1(1:length(t_Temp), t_Temp, x_new) ; 
    TR_Temp = interp1(1:length(T_Temp), T_Temp, x_new) ;

        %Adding elements to output table 
    out_table{:,-3+4*index} = CR_DCHG(:) ;
    out_table{:,-2+4*index} = VR_DCHG(:) ;
    out_table{:,-1+4*index} = tR_Temp(:) ;
    out_table{:,4*index} = TR_Temp(:) ;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Plotting 

figure;
hold on 
title('DCHG Capacity VS Current'); 
xlabel('Capacity [Ah]');
grid on; grid minor; 
color_list = ['k','r', 'b', 'g', 'm'];


for index =1:length(CHG_DCHG_File_Table)

    %arrays Bode Plot 
    DCHG_Capacity = table2array(out_table(:,-3+4*index)); 
    DCHG_Voltage = table2array(out_table(:,-2+4*index));
    DCHG_Temp = table2array(out_table(:,4*index)); 
    
        %Plotting Temperature 
    yyaxis right
    T=plot(-1*DCHG_Capacity, DCHG_Temp-273.15, color_list(index));
    T.LineStyle= "-.";
    ylim([-1, max(DCHG_Temp)-273.15+6] );
    ylabel('Temperature [^oC]');
    
        %Plotting Voltage
    yyaxis left
    C=plot(-1*DCHG_Capacity, DCHG_Voltage, color_list(index));
    C.LineStyle="-";
    ylabel('Cell Voltage [V]');
end

Name_Edit_1 ='CHG_DCHG';
Name_Edit_2 = 'CHG_DCHG_';
Name_Edit_3 = 'booster.xlsx'; 
Name_Edit_4 = '_';
Name_Edit_5 = '\';
Name_Edit_6 = ' ';

name = CHG_DCHG_File_Table;
name = erase(name, Name_Edit_1) ;
name = erase(name, Name_Edit_2) ;
name = erase(name, Name_Edit_3) ;
name = replace(name, Name_Edit_5, Name_Edit_6);
name = replace(name, Name_Edit_4, Name_Edit_6) ;
legend(name)
hold off




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Plotting DCHG 3C
figure; 
tiledlayout(5,4)

hold on

C_array_3C = table2array(C_Table_3C);

    %Top Plot
nexttile([3 4])

%Left axis DCHG Plot
plot(-1*C_array_3C(:,5), C_array_3C(:,3),'k');
yyaxis left 
ylabel('Voltage [V]')

%Right Axis Temp Plot
yyaxis right
plot(-1*C_array_3C(:,5), C_array_3C(:,6),'-.')
ylabel('Temperature Rise [^oC]')

%Title, X-axis , legend
title = '3C DCHG Curve';
xlabel('Capacity')
legend('3C DCHG', 'Max Temp')


nexttile([2 4])
    %Bottom Plot
yyaxis right
plot(-1*C_array_3C(:,5), -1*C_array_3C(:,4),':')
ylabel('Current [A]')
legend('Current')

hold off