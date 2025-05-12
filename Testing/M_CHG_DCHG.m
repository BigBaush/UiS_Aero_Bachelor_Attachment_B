%Requires first that you replace relevant file names with the correct xlsx datasheet into matlab
%CHG / DCHG PLOTTING IN MATLAB
clc;  %close all 
clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Options 

%%%% CC DCHG Data Options %%%%

Read_CHG_DCHG_Data = 1; %Read CC - CHG/DCHG Data, 0 = No, 1= yes

    %Plotting each CC-DCHG Set individually, 0 = No, 1= yes 
ind_DCHG_Plot = 0; 
    
    %Plotting Single CC-DCHG Set with all datasets, 0 = No, 1= yes 
com_DCHG_Plot = 1; 

%%%% OVP DCHG Data Options %%%%

    %Create OVP Dataset file, 0 = No, 1= yes
OVP_Data_Set = 1; 

    %Plotting Overpotentials, 0 = No, 1= yes 
OVP_DCHG_Plot = 1;

    %Plot OVP expression, 0 = No, 1= yes
e_OVP_plot =1;

    %Use SOC when plotting OVP, 0 = No, 1= yes
use_SOC = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Global Parameters

    %Number  of elements of dataset output 
numPoints = 1000; %number of datapoints in output table

    %Plot Element Colours, 
colour = ['k','r', 'b', 'g', 'm'];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %0.1C DCHG Dataset 

for d = 0.1 
    if Read_CHG_DCHG_Data == 0
        disp('Read_CHG_DCHG_Data ==0')
        continue
    end

        %CHG / DCHG 
    %INR21700 48G 
    %DCHG_0_1C_F_Names{1}= 'CHG_DCHG\INR21700 48G\RS_C2_CHG_DCHG_T2_0_48_A_booster.xlsx' ; %replace right side swith the name of the data set
    
    %INR21700 50S
    DCHG_0_1C_F_Names{1}= 'CHG_DCHG\INR21700 50S\AV_C2_CHG_DCHG_T2_0_5_A_booster.xlsx' ; %replace right side swith the name of the data set
    DCHG_0_1C_F_Names{2}= 'CHG_DCHG\INR21700 50S\AV_C3_CHG_DCHG_T1_0_5_A_booster.xlsx' ; %replace right side swith the name of the data set
    
        %Temp 
    
    %INR21700 48G
    %Temp_0_1C_F_Names{1} = 'CHG_DCHG\INR21700 48G\RS_C2_CHG_DCHG_T2_0_48_A_TEMP.xlsx' ; %Temperature Sheet
    
    
    %INR21700 50S
    Temp_0_1C_F_Names{1} = 'CHG_DCHG\INR21700 50S\AV_C2_CHG_DCHG_T2_0_5_A_TEMP.xlsx' ; %Temperature Sheet
    Temp_0_1C_F_Names{2} = 'CHG_DCHG\INR21700 50S\AV_C3_CHG_DCHG_T1_0_5_A_TEMP.xlsx' ; %Temperature Sheet
    
    
    C_Table_0_1C =F_CHG_DCHG_Data_Reader(DCHG_0_1C_F_Names, Temp_0_1C_F_Names, numPoints, 1) ;
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %1C DCHG Dataset 

for d = 1
    if Read_CHG_DCHG_Data == 0 
        continue 
    end

        %CHG/DCHG Data 
    
    %INR21700 48G
    %DCHG_1C_F_Names{1}= 'CHG_DCHG\INR21700 48G\RS_C1_CHG_DCHG_T1_4_8_A_booster.xlsx' ; %replace right side swith the name of the data set
    
    %INR21700 50S
    DCHG_1C_F_Names{1}= 'CHG_DCHG\INR21700 50S\AV_C2_CHG_DCHG_T1_5_A_booster.xlsx' ; %replace right side swith the name of the data set
    DCHG_1C_F_Names{2}= 'CHG_DCHG\INR21700 50S\AV_C3_CHG_DCHG_T1_5_A_booster.xlsx' ; %replace right side swith the name of the data set
    
        %Temp 
    
    %INR21700 48G
    %Temp_1C_F_Names{1} = 'CHG_DCHG\INR21700 48G\RS_C1_CHG_DCHG_T1_4_8_A_booster.xlsx' ; %Temperature Sheet
    
    %INR21700 50S
    Temp_1C_F_Names{1} = 'CHG_DCHG\INR21700 50S\AV_C2_CHG_DCHG_T1_5_A_TEMP.xlsx' ; %Temperature Sheet
    Temp_1C_F_Names{2} = 'CHG_DCHG\INR21700 50S\AV_C3_CHG_DCHG_T1_5_A_TEMP.xlsx' ; %Temperature sheet
    
    C_Table_1C =F_CHG_DCHG_Data_Reader(DCHG_1C_F_Names, Temp_1C_F_Names, numPoints,2);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %2C DCHG Dataset 

for d = 2
    if Read_CHG_DCHG_Data == 0 
        continue 
    end

        %CHG/DCHG 
            
    %INR21700 48G
    %Temp_2C_F_Names{1}= 'CHG_DCHG\INR21700 48G\RS_C1_CHG_DCHG_T1_7_2_A_booster' ; %replace right side swith the name of the data set
    
    %INR21700 50S
    DCHG_2C_F_Names{1}= 'CHG_DCHG\INR21700 50S\AV_C2_CHG_DCHG_T1_10_A_booster.xlsx' ; %replace right side swith the name of the data set
    DCHG_2C_F_Names{2}= 'CHG_DCHG\INR21700 50S\AV_C3_CHG_DCHG_T1_10_A_booster.xlsx' ; %replace right side swith the name of the data set
    
        %Temp 
    
    %INR21700 48G
    %Temp_2C_F_Names{1} = 'CHG_DCHG\INR21700 48G\RS_C1_CHG_DCHG_T1_7_2_A_TEMP' ; %Temperature Sheet
    
    %INR21700 50S
    Temp_2C_F_Names{1} = 'CHG_DCHG\INR21700 50S\AV_C2_CHG_DCHG_T1_10_A_TEMP.xlsx' ; %Temperature Sheet
    Temp_2C_F_Names{2} = 'CHG_DCHG\INR21700 50S\AV_C3_CHG_DCHG_T1_10_A_TEMP.xlsx' ; %Temperature Sheet
    
    C_Table_2C = F_CHG_DCHG_Data_Reader(DCHG_2C_F_Names, Temp_2C_F_Names, numPoints, 2) ;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %3C DCHG Dataset 

for d = 3
    if Read_CHG_DCHG_Data == 0 
        continue
    end

        %CHG/DCHG 
    
    %INR21700 48G
    %Temp_3C_F_Names{1}= 'CHG_DCHG\INR21700 48G\RS_C1_CHG_DCHG_T1_9_6_A_booster' ; %replace right side swith the name of the data set
    %Temp_3C_F_Names{1}= 'CHG_DCHG\INR21700 48G\RS_C2_CHG_DCHG_T1_9_6_A_booster' ; %replace right side swith the name of the data set
    
    %INR21700 50S
    DCHG_3C_F_Names{1}= 'CHG_DCHG\INR21700 50S\AV_C2_CHG_DCHG_T1_15_A_booster.xlsx' ; %replace right side swith the name of the data set
    DCHG_3C_F_Names{2}= 'CHG_DCHG\INR21700 50S\AV_C3_CHG_DCHG_T1_15_A_booster.xlsx' ; %replace right side swith the name of the data set
    
        %Temp 
    
    %INR21700 48G
    %Temp_3C_F_Names{1} = 'CHG_DCHG\INR21700 48G\RS_C1_CHG_DCHG_T1_9_6_A_TEMP' ; %Temperature Sheet
    %Temp_3C_F_Names{1} = 'CHG_DCHG\INR21700 48G\RS_C2_CHG_DCHG_T1_9_6_A_TEMP' ; %Temperature Sheet
    
    %INR21700 50S
    Temp_3C_F_Names{1} = 'CHG_DCHG\INR21700 50S\AV_C2_CHG_DCHG_T1_15_A_TEMP.xlsx' ; %Temperature Sheet
    Temp_3C_F_Names{2} = 'CHG_DCHG\INR21700 50S\AV_C3_CHG_DCHG_T1_15_A_TEMP.xlsx' ; %Temperature Sheet
    
    C_Table_3C = F_CHG_DCHG_Data_Reader(DCHG_3C_F_Names, Temp_3C_F_Names, numPoints, 2) ;
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Finding Overpotential 

for f = 1
    if Read_CHG_DCHG_Data == 0 
        continue 
    elseif OVP_Data_Set == 0 
        disp('OVP_Data_Set==0')
        continue 
    else

        %Creating Input table 
        Input_Over_Potential = table;

        %adding elements to table 
        Over_Potential_Counter = uint8(1);
        for tables =[ C_Table_0_1C(:,3:5), C_Table_1C(:,3:5), C_Table_2C(:,3:5), C_Table_3C(:,3:5) ]
            for rows = 1:width(tables)
                table = tables(:,rows);
                name = table.Properties.VariableNames;
                Input_Over_Potential{:,name}=table2array(table);
            end
        end
        
        %Finding Rt
        Rthermal = F_CHG_DCHG_Overpotential(Input_Over_Potential, numPoints);
        
        filename = 'S_CHG_DCHG_Overpotential_Data_Table.xlsx';
        writetable(Rthermal,filename,'Sheet','CHG_DCHG_Table','WriteRowNames',true);
    end
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Expression For Rthermal , w. plot 

for e = 1
    if e_OVP_plot == 0 
        disp('e_OVP_plot==0')
        continue
    end

    %Reading table 

    Rt_Sim_Data = readtable(['S_CHG_DCHG_Overpotential_Data_table.xlsx'],'PreserveVariableNames', false)

    Rt_DCHG_0_1C = table2array(Rt_Sim_Data(:,1:4));
    Rt_DCHG_1C = table2array(Rt_Sim_Data(:,5:8)); 
    Rt_DCHG_2C = table2array(Rt_Sim_Data(:,9:12)); 
    Rt_DCHG_3C = table2array(Rt_Sim_Data(:,13:16));
    
    %Use state of charge instead of capacity: 
    if use_SOC == 0 
        disp('use_SOC == 0')
    end

    Rt_DCHG_0_1C(:,3)= abs((Rt_DCHG_0_1C(:,3)-Rt_DCHG_0_1C(end,3))/Rt_DCHG_0_1C(end,3));
    Rt_DCHG_1C(:,3)= abs((Rt_DCHG_1C(:,3)-Rt_DCHG_1C(end,3))/Rt_DCHG_1C(end,3));
    Rt_DCHG_2C(:,3)= abs((Rt_DCHG_2C(:,3)-Rt_DCHG_2C(end,3))/Rt_DCHG_2C(end,3));
    Rt_DCHG_3C(:,3)= abs((Rt_DCHG_3C(:,3)-Rt_DCHG_3C(end,3))/Rt_DCHG_3C(end,3));

    figure;
    hold on

    for I_list = [0.5,5, 10, 15]
        %Finding Derivative 
        %I = linspace(I_list, I_list+40, numPoints);
        I = I_list;
    
        SOC = linspace(1,0,1000);
    
    
        %Creating X-Variables 
        a = -1*(Rt_DCHG_0_1C(:,2)) ;
        b = -1*(Rt_DCHG_1C(:,2));
        c = -1*(Rt_DCHG_2C(:,2));
        d = -1*(Rt_DCHG_3C(:,2));
    
        %Expression R-thermal per I, SOC
        Rt_0_1C = Rt_DCHG_0_1C(:,4) .* (I-b) .*(I-c) .* (I-d) ./ ((a-b) .* (a-c) .* (a-d) );
        Rt_1C = Rt_DCHG_1C(:,4) .* (I-a) .* (I-c) .* (I-d) ./ ((b-a) .* (b-c) .* (b-d) ); 
        Rt_2C = Rt_DCHG_2C(:,4) .* (I-a) .* (I-b) .* (I-d) ./ ((c-a) .* (c-b) .* (c-d) );
        Rt_3C = Rt_DCHG_3C(:,4) .* (I-a) .* (I-b) .* (I-c) ./ ((d-a) .* (d-b) .* (d-c) );
    
        Rt = Rt_0_1C + Rt_1C + Rt_2C + Rt_3C; 
    
        %Making Spline dependent on SOC
        sim = linspace(0,1,100);
        Rt_Parameter = spline(SOC,Rt, sim);
        plot(sim, Rt_Parameter,'*')
        
        plot( SOC, Rt,'-.') 
    end

    hold off
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Plotting individual dataset plots 

for p = 1
    if ind_DCHG_Plot == 0 
        disp('ind_DCHG_Plot == 0')
    else
        %Plotting DCHG 0.1C
        for p_f = 0.1
            %Plotting DCHG 0.1C
            figure; 
            title = '0.1C DCHG Curve';
            xlabel('Capacity')
            hold on
            
            C_array_0_1C = table2array(C_Table_0_1C);
            %Left axis DCHG Plot
            plot(-1*C_array_0_1C(:,5), C_array_0_1C(:,3),'k');
            yyaxis left 
            ylabel('Voltage [V]')
            
            %Right Axis Temp Plot
            yyaxis right
            plot(-1*C_array_0_1C(:,5), C_array_0_1C(:,6),'-.')
            ylabel('Temperature Rise [^oC]')
            
            %legend
            legend('0.1C DCHG', 'Max Temp')
            hold off
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %Plotting DCHG 1C
        for p_f = 1
            figure; 
            title = '1C DCHG Curve';
            xlabel('Capacity')
            hold on
            
            C_array_1C = table2array(C_Table_1C);
            %Left axis DCHG Plot
            plot(-1*C_array_1C(:,5), C_array_1C(:,3),'k');
            yyaxis left 
            ylabel('Voltage [V]')
            
            %Right Axis Temp Plot
            yyaxis right
            plot(-1*C_array_1C(:,5), C_array_1C(:,6),'-.')
            ylabel('Temperature Rise [^oC]')
            
            %legend
            legend('1C DCHG', 'Max Temp')
            hold off
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %Plotting DCHG 2C
        for p_f = 2
            figure; 
            title = '2C DCHG Curve';
            xlabel('Capacity')
            hold on
            
            C_array_2C = table2array(C_Table_2C);
            %Left axis DCHG Plot
            plot(-1*C_array_2C(:,5), C_array_2C(:,3),'k');
            yyaxis left 
            ylabel('Voltage [V]')
            
            %Right Axis Temp Plot
            yyaxis right
            plot(-1*C_array_2C(:,5), C_array_2C(:,6),'-.')
            ylabel('Temperature Rise [^oC]')
            
            %legend
            legend('2C DCHG', 'Max Temp')
            hold off
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %Plotting DCHG 
        for p_f = 3
            figure; 
            title = '3C DCHG Curve';
            xlabel('Capacity')
            hold on
            
            C_array_3C = table2array(C_Table_3C);
            %Left axis DCHG Plot
            plot(-1*C_array_3C(:,5), C_array_3C(:,3),'k');
            yyaxis left 
            ylabel('Voltage [V]')
            
            %Right Axis Temp Plot
            yyaxis right
            plot(-1*C_array_3C(:,5), C_array_3C(:,6),'-.')
            ylabel('Temperature Rise [^oC]')
            
            %legend
            legend('3C DCHG', 'Max Temp')
            hold off
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Plotting Common figure with all datasets

for p = 1
    if com_DCHG_Plot ==0 
        disp('com_DCHG_Plot == 0')
    else
        %making arrays: 
        C_array_0_1C = table2array(C_Table_0_1C);
        C_array_1C = table2array(C_Table_1C);
        C_array_2C = table2array(C_Table_2C);
        C_array_3C = table2array(C_Table_3C);

        figure;
        hold on
        title = 'Constant Current Discharge';
        xlabel('Capacity [Ah]')

        %Left Y-Axis
        yyaxis left; 
        ylabel('Cell Voltage[V]') ; 

        LP_0_1C=plot(-1*C_array_0_1C(:,5), C_array_0_1C(:,3),colour(1)); LP_0_1C.LineStyle= "-";
        LP_1C=plot(-1*C_array_1C(:,5), C_array_1C(:,3),colour(2)); LP_1C.LineStyle= "-";
        LP_2C=plot(-1*C_array_2C(:,5), C_array_2C(:,3),colour(3)); LP_2C.LineStyle= "-";
        LP_3C=plot(-1*C_array_3C(:,5), C_array_3C(:,3),colour(4)); LP_3C.LineStyle= "-";

        %axis colour modifiers
        set(gca, 'YColor', 'k'); 
        %set(gca,'color','k');


        %Right Y-Axis
        yyaxis right;
        ylabel('Delta T [C]'); 

        RP_0_1C=plot(-1*C_array_0_1C(:,5), C_array_0_1C(:,6),colour(1)); RP_0_1C.LineStyle= "-."; 
        RP_1C=plot(-1*C_array_1C(:,5), C_array_1C(:,6),colour(2)); RP_1C.LineStyle= "-.";
        RP_2C=plot(-1*C_array_2C(:,5), C_array_2C(:,6),colour(3)); RP_2C.LineStyle= "-.";
        RP_3C=plot(-1*C_array_3C(:,5), C_array_3C(:,6),colour(4)); RP_3C.LineStyle= "-.";

        legend('0.1C', '1C', '2C', '3C')
        hold off 
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Plotting Common Figure with overpotential 

for p = 1 
    if Read_CHG_DCHG_Data == 0 
        continue 
    elseif OVP_Data_Set == 0
        continue
    elseif OVP_DCHG_Plot == 0
        disp('OVP_DCHG_Plot == 0')
    else
        %Extracting array from table
        OVP_array = table2array(Rthermal);

        SOC_OVP = abs( (OVP_array(:,3)-OVP_array(end,3))./OVP_array(end,3) );
        
        %Plotting function 
        figure; 
        hold on 
        title = 'Overpotential VS SOC';
        xlabel('SOC')

        OVP_1 = plot(SOC_OVP, OVP_array(:,8), colour(2) );
        OVP_2 = plot(SOC_OVP, OVP_array(:,12), colour(3) );
        OVP_3 = plot(SOC_OVP, OVP_array(:,16), colour(4) );
        ylabel('Overpotential [V]')
        legend('Rt 1C', 'Rt 2C', 'Rt 3C')

        hold off 
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Creating expression for OVP

