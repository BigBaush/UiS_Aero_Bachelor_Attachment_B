%Plotting dVoc/dT
use_SOC=1;
common_table = readtable(['S_dVoc_dT_Table.xlsx'],'PreserveVariableNames', false)

figure; 
hold on
dVoc_dT_25C = table2array(common_table(:,1:4));
dVoc_dT_40C = table2array(common_table(:,5:8)); 
dVoc_dT_55C = table2array(common_table(:,9:12)); 

%Use state of charge instead of capacity: 
if use_SOC == 0 
    disp('use_SOC == 0')
else
    dVoc_dT_25C(:,3)= -1*(dVoc_dT_25C(:,3)-dVoc_dT_25C(end,3))/dVoc_dT_25C(end,3);
    dVoc_dT_40C(:,3)= -1*(dVoc_dT_40C(:,3)-dVoc_dT_40C(end,3))/dVoc_dT_40C(end,3);
    dVoc_dT_55C(:,3)= -1*(dVoc_dT_55C(:,3)-dVoc_dT_55C(end,3))/dVoc_dT_55C(end,3);
end

for T_list = [273.15,273.15+10, 273.15+20, 273.15+30, 273.15+40, 273.15+50 ]
    %Finding Derivative 
    %T = linspace(T_list, T_list+40, numPoints);
    T = T_list;
    dVoc_25C = dVoc_dT_25C(:,2) .* (2.*T - dVoc_dT_40C(:,4) - dVoc_dT_55C(:,4) ) ./ ( (dVoc_dT_25C(:,4) - dVoc_dT_40C(:,4) ) .* (dVoc_dT_25C(:,4) - dVoc_dT_55C(:,4) ) ); 
    dVoc_40C = dVoc_dT_40C(:,2) .* (2.*T - dVoc_dT_25C(:,4) - dVoc_dT_55C(:,4) ) ./ ( (dVoc_dT_40C(:,4) - dVoc_dT_25C(:,4) ) .* (dVoc_dT_40C(:,4) - dVoc_dT_55C(:,4) ) ); 
    dVoc_55C = dVoc_dT_55C(:,2) .* (2.*T - dVoc_dT_25C(:,4) - dVoc_dT_40C(:,4) ) ./ ( (dVoc_dT_55C(:,4) - dVoc_dT_25C(:,4) ) .* (dVoc_dT_55C(:,4) - dVoc_dT_40C(:,4) ) ); 
    dVoc_dT = dVoc_25C + dVoc_40C + dVoc_55C; 
    
    SOC = linspace(0,1,1000);
    expression = spline(dVoc_dT_25C(:,3),dVoc_dT, SOC);
    plot(SOC, expression, 'o')

    plot( dVoc_dT_25C(:,3), dVoc_dT,'-.') 
end
legend()
%ylim = [-0.02, 0.02];
hold off