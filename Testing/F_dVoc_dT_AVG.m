function AVG_dVoc_Table = F_dVoc_dT_AVG(dVoc_dT_Table, Temp_Table, numPoints)
    AVG_dVoc_Table = table; %defining output as table
    
    %Loop Parameters 
    float_AVG_points = 10; %Floating average Temperature lists
    start_index = 1; %start index


    %Indexes for DCHG Table
    dVoc_var_list = [1,7,9];
    
    for variable = dVoc_var_list
        T_DCHG = table; 
        for index = 1:length(dVoc_dT_Table)
            dVoc_dT = string( dVoc_dT_Table(index) )  
            name1 = char(dVoc_dT);
            name3 = name1(end-16:end-14);

            dVoc_dT  = readtable(dVoc_dT, 'PreserveVariableNames', false) ; %Convertion: Cell -> String -> Table

            %Extracting row name
            name2 = string( dVoc_dT.Properties.VariableNames{variable} );
            name = name2+name3  ;          

            %Create array, and removes NaN
            DCHG = table2array(dVoc_dT(:,variable)); DCHG(isnan(DCHG))=[] ;
            
            %Modifying length 
            x_new = linspace(1, length(DCHG), numPoints);
            VR_DCHG = interp1(1:length(DCHG), DCHG, x_new) ;
            
            %Adding to table
            T_DCHG{:,index} = VR_DCHG.'; 
        end
        
        AVG_dVoc_Table{:,start_index} = table2array(mean(T_DCHG,2));

                %Extracting Variable Names
        AVG_dVoc_Table.Properties.VariableNames(start_index) = name;

        start_index = start_index + 1;

    end
    %Creating average
    %Creating Temperature Table

    T_Temp = table; 
    AVG_CHG_Time = uint32(table2array(AVG_dVoc_Table(end,1))) ;
    %AVG_CHG_Time

    for index = 1:length(Temp_Table)
        temp = string( Temp_Table(index) ) 
        name4 = char(string(Temp_Table(index)));

        temp  = readtable(temp, 'PreserveVariableNames', false) ; %Convertion: Cell -> String -> Table

        %temp(AVG_CHG_Time:end , 2:7)

        %Finding extremal points: 
        [T_Min, T_Max] = bounds(temp(AVG_CHG_Time:end , 2:7), 'all') ;

        %Create average array over all probles
        Avg_Temp = mean(table2array(temp(AVG_CHG_Time:end , 2:7)), 2) + 273.15;         
        Avg_Temp = movmean(Avg_Temp, float_AVG_points);
        
        %Name
        name5 = name4(end-12:end-10);
        name6 = string('temp');
        name = name6+ name5  ; 

        %Avg_Temp
    
        %Modifying length 
        x_new = linspace(1, length(Avg_Temp), numPoints);
        R_AVG_Temp = interp1(1:length(Avg_Temp), Avg_Temp, x_new) ;
        
        %Adding to table
        T_Temp{:,index} = R_AVG_Temp.'; 
    end
    AVG_dVoc_Table{:,start_index} = table2array(mean(T_Temp,2));
    AVG_dVoc_Table.Properties.VariableNames(start_index) = name;

end