
function AVG_CHG_DCHG_Data = F_CHG_DCHG_Data_Reader(CHG_DCHG_File_Name_Table, Temp_File_Name_Table, numPoints, T_SR_Hz)
    AVG_CHG_DCHG_Data = table;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %Global Variables 
    float_AVG_points = 100; %Floating average Temperature lists
    start_index = 1; %start index

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    CHG_DCHG_VAR = [1,6,7,8,9]; %Variables to be extracted 

    for variable = CHG_DCHG_VAR
        T_DCHG = table; 
        for index = 1:length(CHG_DCHG_File_Name_Table)
            %Reading table name
            DHG_DCHG = string( CHG_DCHG_File_Name_Table(index) )
        
            %Extracting file name
            name1 = char(DHG_DCHG);
            name_index = find(name1=='T')+2;
            name1 = name1(name_index:name_index+5); name1 = erase(name1, 'b');
            
            %Reading table 
            DHG_DCHG  = readtable(DHG_DCHG, 'PreserveVariableNames', false) ; %Convertion: Cell -> String -> Table

            %Extracting row name
            name2 = string( DHG_DCHG.Properties.VariableNames{variable} ); 
            name = name2+name1  ;          

            %Create array, and removes NaN
            DCHG = table2array(DHG_DCHG(:,variable)); DCHG(isnan(DCHG))=[] ;
            
            %Modifying length 
            x_new = linspace(1, length(DCHG), numPoints);
            R_DCHG = interp1(1:length(DCHG), DCHG, x_new) ;
            
            %Adding to table
            T_DCHG{:,index} = R_DCHG.'; 
        end

        %Adding set to output table 
        AVG_CHG_DCHG_Data{:,start_index} = table2array(mean(T_DCHG,2));
        AVG_CHG_DCHG_Data.Properties.VariableNames(start_index) = name;

        %Counter +1
        start_index = start_index + 1;

    end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Creating Temperature Dataset 
    Temp_Table = table; 
    AVG_CHG_Time = uint32(table2array(AVG_CHG_DCHG_Data(end,1)))*T_SR_Hz ;

    %Reading data 

    for index = 1:length(Temp_File_Name_Table)

        %Extracting names
        temp_table = string( Temp_File_Name_Table(index) ); 
        name3 = char(string(Temp_File_Name_Table(index)));

        %Reading table
        temp_table  = readtable(temp_table, 'PreserveVariableNames', false) ; %Convertion: Cell -> String -> Table

        %Finding extremal points: 

        %Create max temp array over all probles
        Temp = table2array(temp_table(AVG_CHG_Time:end, 2:7)) ; Temp(isnan(Temp))=[]; %Creates array, and removes NaN
        Temp = max(Temp, [], 2);
        [T_Min, T_Max] = bounds(Temp, 'all') ;

        %Finding temp index
        t_f = find(abs(Temp-T_Max)<= 5e-1);  
        t_i = find(abs(Temp-T_Min) <= 5e-1) ; 

        %Converting temp to T_Rise
        if max(t_f) <= max(t_i)
            T_Temp = Temp(max(t_f):max(t_i)); 

            T_Temp_1 = T_Temp(end);
            T_Rise = T_Temp - T_Temp_1;
        else 
            T_Temp = Temp(max(t_i):max(t_f));

            T_Temp_1 = T_Temp(1);
            T_Rise = T_Temp - T_Temp_1;
        end
        
        %Extracting Variable Name 
        name_index = find(name3=='T')+2;
        name3 = name3(name_index:name_index+5); name3 = erase(name3, 'T');
        name5 = string('Temp') ;
        name = name5+ name3 ; 
    
        %Modifying length 
        x_new = linspace(1, length(T_Rise), numPoints);
        R_T_Rise = interp1(1:length(T_Rise), T_Rise, x_new);
        
        %Adding to table AVG Table
        Temp_Table{:,index} = R_T_Rise.'; 
    end

    %Adding AVG Data to output
    AVG_CHG_DCHG_Data{:,start_index} = table2array(max(Temp_Table,[],2));
    AVG_CHG_DCHG_Data.Properties.VariableNames(start_index) = name;

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

