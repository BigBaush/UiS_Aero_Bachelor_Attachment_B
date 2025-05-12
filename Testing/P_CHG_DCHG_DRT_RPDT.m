%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear all;
%Options

%%%% DRT Options %%%%
    %Read DRT dataset, 0 = No, 1= yes
read_DRT = 1; 

    %Plotting DRT dataset, 0 = No, 1= yes
plot_DRT = 1;

%%%% PRDT Options %%%%
    %Plotting RPDT dataset, 0 = No, 1= yes
read_RPDT = 1;

    %Plotting RPDT dataset, 0 = No, 1= yes
plot_RPDT = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Global Variables 
numPoints = 10000;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Reading Data file names

    %DRT: Design Requirement Test Data set 
for d = 4
    if read_DRT == 0 
        disp('read_DRT==0')
        continue
    end
        %CHG/DCHG
    %INR21700 50S
    DRT_CHG_DCHG_F_Names{1} = 'CHG_DCHG\INR21700 50S\AV_C2_CHG_DCHG_T1_DRT_booster.xlsx';
    DRT_CHG_DCHG_F_Names{2} = 'CHG_DCHG\INR21700 50S\AV_C3_CHG_DCHG_T1_DRT_booster.xlsx';

        %TEMP 
    %INR21700 50S
    DRT_TEMP_F_Names{1} = 'CHG_DCHG\INR21700 50S\AV_C2_CHG_DCHG_T1_DRT_TEMP.xlsx';
    DRT_TEMP_F_Names{2} = 'CHG_DCHG\INR21700 50S\AV_C3_CHG_DCHG_T1_DRT_TEMP.xlsx';

    %Using Function
    DRT_Data = F_CHG_DCHG_DRT_Reader(DRT_CHG_DCHG_F_Names, DRT_TEMP_F_Names, numPoints);
end

    %RPDT: Rated Power Draw Test Data set
for d=5
    if read_RPDT == 0 
        disp('read_RPDT==0')
        continue
    end
        %CHG/DCHG
    %INR21700 50S
    RPDT_CHG_DCHG_F_Names{1} = 'CHG_DCHG\INR21700 50S\AV_C2_CHG_DCHG_T1_RPDT_booster.xlsx';
    RPDT_CHG_DCHG_F_Names{2} = 'CHG_DCHG\INR21700 50S\AV_C3_CHG_DCHG_T1_RPDT_booster.xlsx';

        %TEMP 
    %INR21700 50S
    RPDT_TEMP_F_Names{1} = 'CHG_DCHG\INR21700 50S\AV_C2_CHG_DCHG_T1_RPDT_TEMP.xlsx';
    RPDT_TEMP_F_Names{2} = 'CHG_DCHG\INR21700 50S\AV_C3_CHG_DCHG_T1_RPDT_TEMP.xlsx';

    %Using Function
    RPDT_Data = F_CHG_DCHG_DRT_Reader(RPDT_CHG_DCHG_F_Names, RPDT_TEMP_F_Names, numPoints);

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for p = 1
    if read_DRT == 0 
        disp("read_DRT == 0")
        continue 
    elseif plot_DRT == 0
        disp("plot_DRT == 0")
        continue 
    end
    
    %Creting data: 
    DRT_Array = table2array(DRT_Data);

    C_DCHG = -1*DRT_Array(:,9);
    V_DCHG = DRT_Array(:,7);
    I_DCHG = -1*DRT_Array(:,8);
    T_DCHG = DRT_Array(:,10); 

    %Creating Plot
    figure; 
    tiledlayout(5,4)
    hold on
    
        %Top Plot
    nexttile([3 4])

    %Left axis DCHG Plot
    plot(C_DCHG, V_DCHG,'k');
    yyaxis left 
    ylabel('Voltage [V]')

    %Right Axis Temp Plot
    yyaxis right
    plot(C_DCHG, T_DCHG,'-.')
    ylabel('Temperature [^oC]')

    % X-axis , legend
    legend('DRT', 'Max Temp')

    nexttile([2 4])
        %Bottom Plot
    %Plotting Power
    yyaxis left 
    plot(C_DCHG,I_DCHG .* V_DCHG,'b')
    ylim([0,I_DCHG(1) * V_DCHG(1)+10]);
    ylabel('Power [W]')
    %Plotting Current
    yyaxis right
    plot(C_DCHG,I_DCHG,'r')
    ylim([0,max(I_DCHG)+3]);
    ylabel('Current [A]')
    
    legend('Power', 'Current')
    xlabel('Capacity')
    title = 'DRT DCHG Curve';

    hold off

end

for p = 2
    if read_RPDT == 0 
        disp("read_DRT == 0")
        continue 
    elseif plot_RPDT == 0
        disp("plot_DRT == 0")
        continue 
    end
    
    %Creting data: 
    DRT_Array = table2array(RPDT_Data);

    C_DCHG = -1*DRT_Array(:,9);
    V_DCHG = DRT_Array(:,7);
    I_DCHG = -1*DRT_Array(:,8);
    T_DCHG = DRT_Array(:,10); 

    %Creating Plot
    figure; 
    tiledlayout(5,4)
    hold on
    
        %Top Plot
    nexttile([3 4])

    %Left axis DCHG Plot
    plot(C_DCHG, V_DCHG,'k');
    title = 'RPDT DCHG Curve';

    yyaxis left 
    ylabel('Voltage [V]')

    %Right Axis Temp Plot
    yyaxis right
    plot(C_DCHG, T_DCHG,'-.')
    ylabel('Temperature [^oC]')

    %Title, X-axis , legend
    legend('RPDT', 'Max Temp')


    nexttile([2 4])
        %Bottom Plot
    %Plotting Power
    yyaxis left 
    plot(C_DCHG,I_DCHG .* V_DCHG,'b')
    ylim([0,max(I_DCHG .* V_DCHG)+10]);
    ylabel('Power [W]')
    %Plotting Current
    yyaxis right
    plot(C_DCHG,I_DCHG,'r')
    ylim([0,max(I_DCHG)+3]);
    ylabel('Current [A]')
    
    legend('Power', 'Current')
    xlabel('Capacity')
    
    hold off
end