%Requires first that you replace relevant file names with the correct xlsx datasheet into matlab
%dVoc/dT PLOTTING IN MATLAB
clc;  %close all 
clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Global Parameters

numPoints = 100; %number of datapoints in output table

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%25C data: 

    %dVoc/dT 

%INR21700 48G
%dVoc_dT_Table_25C{1}= 'dV_oc_dt\INR21700 48G\RS_C2_dVoc_dt_T1_25C_CHG-DCHG.xlsx' ; %replace right side swith the name of the data set
%dVoc_dT_Table_25C{2}= 'dV_oc_dt\INR21700 48G\RS_C2_dVoc_dt_T2_25C_CHG-DCHG.xlsx' ;

%INR21700 50S
dVoc_dT_Table_25C{1}= 'dV_oc_dt\INR21700 50S\AV_C1_dVoc_dt_T1_25C_CHG_DCHG.xlsx' ; %replace right side swith the name of the data set
dVoc_dT_Table_25C{2}= 'dV_oc_dt\INR21700 50S\AV_C2_dVoc_dt_T1_25C_CHG_DCHG.xlsx' ; %replace right side swith the name of the data set
dVoc_dT_Table_25C{3}= 'dV_oc_dt\INR21700 50S\AV_C3_dVoc_dt_T1_25C_CHG_DCHG.xlsx' ; %replace right side swith the name of the data set

    %Temp 

%INR21700 48G
%Temp_Table_25C{1} = 'dV_oc_dt\INR21700 48G\RS_C2_dVoc_dt_T1_25C_TEMP.xlsx' ; %Temperature Sheet
%Temp_Table_25C{2} = 'dV_oc_dt\INR21700 48G\RS_C2_dVoc_dt_T2_25C_TEMP.xlsx' ; %Temperature Sheet


%INR21700 50S
Temp_Table_25C{1} = 'dV_oc_dt\INR21700 50S\AV_C1_dVoc_dt_T1_25C_TEMP.xlsx' ; %Temperature Sheet
Temp_Table_25C{2} = 'dV_oc_dt\INR21700 50S\AV_C2_dVoc_dt_T1_25C_TEMP.xlsx' ; %Temperature sheet
Temp_Table_25C{3} = 'dV_oc_dt\INR21700 50S\AV_C3_dVoc_dt_T1_25C_TEMP.xlsx' ; %Temperature Sheet


dVoc_dT_25C =F_dVoc_dT_AVG(dVoc_dT_Table_25C, Temp_Table_25C, numPoints) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%40C data: 

    %dVoc/dT 

%INR21700 48G
%dVoc_dT_Table_40C{1}= 'dV_oc_dt\INR21700 48G\RS_C1_dVoc_dt_T1_40C_CHG-DCHG.xlsx' ; %replace right side swith the name of the data set
%dVoc_dT_Table_40C{2}= 'dV_oc_dt\INR21700 48G\RS_C2_dVoc_dt_T1_40C_CHG-DCHG.xlsx' ; %replace right side swith the name of the data set

%INR21700 50S
dVoc_dT_Table_40C{1}= 'dV_oc_dt\INR21700 50S\AV_C1_dVoc_dt_T1_40C_CHG_DCHG.xlsx' ; %replace right side swith the name of the data set
dVoc_dT_Table_40C{2}= 'dV_oc_dt\INR21700 50S\AV_C2_dVoc_dt_T1_40C_CHG_DCHG.xlsx' ; %replace right side swith the name of the data set
dVoc_dT_Table_40C{3}= 'dV_oc_dt\INR21700 50S\AV_C3_dVoc_dt_T1_40C_CHG_DCHG.xlsx' ; %replace right side swith the name of the data set

    %Temp 

%INR21700 48G
%Temp_Table_40C{1} = 'dV_oc_dt\INR21700 48G\RS_C1_dVoc_dt_T1_40C_TEMP.xlsx' ; %Temperature Sheet
%Temp_Table_40C{2} = 'dV_oc_dt\INR21700 48G\RS_C2_dVoc_dt_T1_40C_TEMP.xlsx' ; %Temperature Sheet

%INR21700 50S
Temp_Table_40C{1} = 'dV_oc_dt\INR21700 50S\AV_C1_dVoc_dt_T1_40C_TEMP.xlsx' ; %Temperature Sheet
Temp_Table_40C{2} = 'dV_oc_dt\INR21700 50S\AV_C2_dVoc_dt_T1_40C_TEMP.xlsx' ; %Temperature sheet
Temp_Table_40C{3} = 'dV_oc_dt\INR21700 50S\AV_C3_dVoc_dt_T1_40C_TEMP.xlsx' ; %Temperature Sheet

dVoc_dT_40C =F_dVoc_dT_AVG(dVoc_dT_Table_40C, Temp_Table_40C, numPoints) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%55C data: 

    %dVoc/dT 
        
%INR21700 48G
%dVoc_dT_Table_55C{1}= 'dV_oc_dt\INR21700 48G\RS_C1_dVoc_dt_T1_55C_CHG-DCHG.xlsx' ; %replace right side swith the name of the data set
%dVoc_dT_Table_55C{2}= 'dV_oc_dt\INR21700 48G\RS_C2_dVoc_dt_T2_55C_CHG-DCHG.xlsx' ; %replace right side swith the name of the data set

%INR21700 50S
dVoc_dT_Table_55C{1}= 'dV_oc_dt\INR21700 50S\AV_C2_dVoc_dt_T1_55C_CHG_DCHG.xlsx' ; %replace right side swith the name of the data set
dVoc_dT_Table_55C{2}= 'dV_oc_dt\INR21700 50S\AV_C3_dVoc_dt_T1_55C_CHG_DCHG.xlsx' ; %replace right side swith the name of the data set

    %Temp 

%INR21700 48G
%Temp_Table_55C{1} = 'dV_oc_dt\INR21700 48G\RS_C1_dVoc_dt_T1_55C_TEMP.xlsx' ; %Temperature Sheet
%Temp_Table_55C{2} = 'dV_oc_dt\INR21700 48G\RS_C2_dVoc_dt_T2_55C_TEMP.xlsx' ; %Temperature Sheet

%INR21700 50S
Temp_Table_55C{1} = 'dV_oc_dt\INR21700 50S\AV_C2_dVoc_dt_T1_55C_TEMP.xlsx' ; %Temperature Sheet
Temp_Table_55C{2} = 'dV_oc_dt\INR21700 50S\AV_C3_dVoc_dt_T1_55C_TEMP.xlsx' ; %Temperature Sheet

dVoc_dT_55C = F_dVoc_dT_AVG(dVoc_dT_Table_55C, Temp_Table_55C, numPoints) ;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Writing to table
common_table = table;
for tables =[ dVoc_dT_25C, dVoc_dT_40C, dVoc_dT_55C ]
    for rows = 1:width(tables)
        table = tables(:,rows);
        name = table.Properties.VariableNames;
        common_table{:,name}=table2array(table);
    end
end
%Renaming table variable names

filename = 'S_dVoc_dT_Table.xlsx';
writetable(common_table,filename,'Sheet','dVoc_dT_Common','WriteRowNames',true);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Plotting dVoc/dT
figure; 
hold on
dVoc_dT_25C = table2array(dVoc_dT_25C); 
dVoc_dT_40C = table2array(dVoc_dT_40C); 
dVoc_dT_55C = table2array(dVoc_dT_55C); 

for T_list = [273.15,273.15+10, 273.15+20, 273.15+30, 273.15+40, 273.15+50 ]
    %Finding Derivative 
    %T = linspace(T_list, T_list+40, numPoints);
    T = T_list;
    dVoc_25C = dVoc_dT_25C(:,2) .* (2.*T - dVoc_dT_40C(:,4) - dVoc_dT_55C(:,4) ) ./ ( (dVoc_dT_25C(:,4) - dVoc_dT_40C(:,4) ) .* (dVoc_dT_25C(:,4) - dVoc_dT_55C(:,4) ) ); 
    dVoc_40C = dVoc_dT_40C(:,2) .* (2.*T - dVoc_dT_25C(:,4) - dVoc_dT_55C(:,4) ) ./ ( (dVoc_dT_40C(:,4) - dVoc_dT_25C(:,4) ) .* (dVoc_dT_40C(:,4) - dVoc_dT_55C(:,4) ) ); 
    dVoc_55C = dVoc_dT_55C(:,2) .* (2.*T - dVoc_dT_25C(:,4) - dVoc_dT_40C(:,4) ) ./ ( (dVoc_dT_55C(:,4) - dVoc_dT_25C(:,4) ) .* (dVoc_dT_55C(:,4) - dVoc_dT_40C(:,4) ) ); 
    derivative = dVoc_25C + dVoc_40C + dVoc_55C; 

    plot(dVoc_dT_55C(:,3), derivative) 
end
legend()
ylim = [-0.02, 0.02];
hold off
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%plotting arrays + Plot parameters: 
figure;
plot(dVoc_dT_55C(:,3),dVoc_dT_55C(:,2), dVoc_dT_40C(:,3), dVoc_dT_40C(:,2), dVoc_dT_25C(:,3), dVoc_dT_25C(:,2)) 
legend('55C', '40C', '25C')
