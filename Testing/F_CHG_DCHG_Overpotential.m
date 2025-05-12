function overpotential_table = F_CHG_DCHG_Overpotential(Common_Table, numPoints)

    %Options 

    %Set OCV Current to zero
    use_i_ocv = 1; % if 1 I_OCV = 0


    %Creating overpotential table
    overpotential_table = table;
    
    V_OCV = 0;
    I_OCV = 0; 
    C_OCV = 0;

    vars = 3;
    for index = 1: (width(Common_Table)/vars)

        %Extracting Voltage array
        V_DCHG = table2array(Common_Table(:,-2+vars*index)) ; V_DCHG(isnan(V_DCHG))=[]; %Creates array, and removes NaN
        I_DCHG = table2array(Common_Table(:,-1+vars*index)) ; I_DCHG(isnan(I_DCHG))=[]; %Creates array, and removes NaN
        C_DCHG = table2array(Common_Table(:,-0+vars*index)) ; C_DCHG(isnan(C_DCHG))=[]; %Creates array, and removes NaN
        
       
        if index == 1
            V_OCV = V_DCHG;
            I_OCV = I_DCHG;
            C_OCV = C_DCHG;

            if use_i_ocv == 1
                I_DCHG = zeros(length(I_DCHG),1);
                Rt = zeros(length(V_DCHG),1);
            end

        else 
            Rt = abs( (V_OCV-V_DCHG) ./ I_DCHG) ;
        end

        %Finding Overpotential 

        %Reducing number of points 
        x_new = linspace(1, length(Rt), numPoints);
        Rt = interp1(1:length(Rt), Rt, x_new) ;
        x_new = linspace(1, length(V_DCHG), numPoints);
        V_DCHG = interp1(1:length(V_DCHG), V_DCHG, x_new) ;
        x_new = linspace(1, length(I_DCHG), numPoints);
        I_DCHG = interp1(1:length(I_DCHG), I_DCHG, x_new) ;
        x_new = linspace(1, length(C_DCHG), numPoints);
        C_DCHG = interp1(1:length(C_DCHG), C_DCHG, x_new) ;


        %Setting Column Name
        name_delta = 'R_T_' + string( Common_Table.Properties.VariableNames(-2+vars*index) ); %Creating name
        name_delta = erase(name_delta, 'DCHGVoltage');
        name_delta = erase(name_delta, '_');

        name_Voltage = 'Voltage' + string( Common_Table.Properties.VariableNames(-2+vars*index) ); %Creating name
        name_Voltage = erase(name_Voltage, 'DCHGVoltage');
        name_Voltage = erase(name_Voltage, '_');

        name_Current = 'Current_' + string( Common_Table.Properties.VariableNames(-1+vars*index) ); %Creating name
        name_Current = erase(name_Current, 'DCHGCurrent');
        name_Current = erase(name_Current, '_');

        name_Capacity = 'Capacity' + string( Common_Table.Properties.VariableNames(-0+vars*index) ); %Creating name
        name_Capacity = erase(name_Capacity, 'DCHGCapacity');
        name_Capacity = erase(name_Capacity, '_');


        %Adding arrays to tables 
        disp(class(V_DCHG))
        overpotential_table{:,-vars+(vars+1)*index} = V_DCHG(:);
        overpotential_table = renamevars(overpotential_table, -3+(vars+1)*index, name_Voltage);

        overpotential_table{:,-2+(vars+1)*index} = I_DCHG(:);
        overpotential_table = renamevars(overpotential_table, -2+(vars+1)*index, name_Current);

        overpotential_table{:,-1+(vars+1)*index} = C_DCHG(:);
        overpotential_table = renamevars(overpotential_table, -1+(vars+1)*index, name_Capacity);

        overpotential_table{:,(vars+1)*index} = Rt(:);
        overpotential_table = renamevars(overpotential_table, (vars+1)*index, name_delta);
    end

end