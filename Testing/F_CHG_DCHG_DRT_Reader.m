function DRT_out_Table = F_CHG_DCHG_DRT_Reader(DRT_CHG_DCHG_F_Name, DRT_TEMP_F_Name, numPoints)
    DRT_out_Table = table; %defining output as table
    delay =600; %Seconds delay between CHG and DCHG 
    kelvin = 0; %temperature offset by K scale
    F_AVG_points = 10; %Number of points for Floating points average 
    
    error = 0; %shows error debug info 
    make_error = 0; %creates error in file for file inspection in debug mode
    error_set = [0,0,0,0,0,0]; 
        %id1 = error sample rate
        %id2 = Temp

    %CHG_DCHG Data Sets
    for index = 1:length(DRT_CHG_DCHG_F_Name)

        %Extracting table name 
        DRT_name = string( DRT_CHG_DCHG_F_Name(index) ) 
        
        %Finding Dataset output name
        set_name = char(DRT_name);
        set_NX_1 = find(set_name=='T')+3;
        set_NX_2 = find(set_name=='_'); set_NX_2 = set_NX_2(end);
        out_name = string(set_name(set_NX_1:set_NX_2));

        %Reading table
        DRT  = readtable(DRT_name, 'PreserveVariableNames', false) ; %Convertion: Cell -> String -> Table

        %Create CHG Arrays and removing NaN
        t_CHG = table2array(DRT(:,1)); t_CHG(isnan(t_CHG))=[] ;
        V_CHG = table2array(DRT(:,2)); V_CHG(isnan(V_CHG))=[];
        I_CHG = table2array(DRT(:,3)); I_CHG(isnan(I_CHG))=[];
        C_CHG = table2array(DRT(:,4)); C_CHG(isnan(C_CHG))=[];

        %Creating DCHG 1 Arrays and Removing NaN
        t_DCHG_1 = table2array(DRT(:,6)); t_DCHG_1(isnan(t_DCHG_1))=[];
        V_DCHG_1 = table2array(DRT(:,7)); V_DCHG_1(isnan(V_DCHG_1))=[];
        I_DCHG_1 = table2array(DRT(:,8)); I_DCHG_1(isnan(I_DCHG_1))=[];
        C_DCHG_1 = table2array(DRT(:,9)); C_DCHG_1(isnan(C_DCHG_1))=[];

        %Creating DCHG 2 Arrays and removing NaN
        t_DCHG_2 = table2array(DRT(:,11)); t_DCHG_2(isnan(t_DCHG_2))=[];
        V_DCHG_2 = table2array(DRT(:,12)); V_DCHG_2(isnan(V_DCHG_2))=[];
        I_DCHG_2 = table2array(DRT(:,13)); I_DCHG_2(isnan(I_DCHG_2))=[];
        C_DCHG_2 = table2array(DRT(:,14)); C_DCHG_2(isnan(C_DCHG_2))=[];

        %Finding sample rate of DCHG sets
        Hz_DCHG_1 = double(uint16( length(t_DCHG_1)/t_DCHG_1(end) ));
        Hz_DCHG_2 = double(uint16( length(t_DCHG_2)/t_DCHG_2(end) )); 

        %Resizing elements to set sampling rate equal for both sets 
        if Hz_DCHG_1 == Hz_DCHG_2
            error_set(1)=1;
        elseif Hz_DCHG_1 <= Hz_DCHG_2
            error_set(2)=1;
                %New points 
            n_points = Hz_DCHG_2 * length(t_DCHG_1);
            new_points = linspace(1, length(t_DCHG_2), n_points);

                %array set length
            tR_DCHG_1 = interp1(1:length(t_DCHG_1), t_DCHG_1, new_points) ;
            VR_DCHG_1 = interp1(1:length(V_DCHG_1), V_DCHG_1, new_points) ;
            IR_DCHG_1 = interp1(1:length(I_DCHG_1), I_DCHG_1, new_points) ;
            CR_DCHG_1 = interp1(1:length(C_DCHG_1), C_DCHG_1, new_points) ;

                %Renaming other variables
            tR_DCHG_2 = t_DCHG_2;
            VR_DCHG_2 = V_DCHG_2;
            IR_DCHG_2 = I_DCHG_2;
            CR_DCHG_2 = C_DCHG_2;
        else
            error_set(3)=1;

                %New points 
            n_points = Hz_DCHG_1 * length(t_DCHG_2);
            new_points = linspace(1, length(t_DCHG_2), n_points);

                %array set length
            tR_DCHG_2 = interp1(1:length(t_DCHG_2), t_DCHG_2, new_points) ;
            VR_DCHG_2 = interp1(1:length(V_DCHG_2), V_DCHG_2, new_points) ;
            IR_DCHG_2 = interp1(1:length(I_DCHG_2), I_DCHG_2, new_points) ;
            CR_DCHG_2 = interp1(1:length(C_DCHG_2), C_DCHG_2, new_points) ;

                %Renaming other variables
            tR_DCHG_1 = t_DCHG_1(:);
            VR_DCHG_1 = V_DCHG_1(:);
            IR_DCHG_1 = I_DCHG_1(:);
            CR_DCHG_1 = C_DCHG_1(:);

        end

        DCHG = [tR_DCHG_1(:), VR_DCHG_1(:), IR_DCHG_1(:), CR_DCHG_1(:)];
        %DCHG{:,-3+4*index} = t_DCHG_1 .'; 
        %DCHG{:,-2+4*index} = V_DCHG_1 .'; 
        %DCHG{:,-1+4*index} = I_DCHG_1 .'; 
        %DCHG{:,-0+4*index} = C_DCHG_1 .'; 
 
        %Finding index for seconds set
        idx_1 = length(tR_DCHG_1)+1;
        idx_2 = idx_1+ length(tR_DCHG_2)-1; 

        %Adding second DCHG Set to table
        DCHG(idx_1:idx_2 , 1) = tR_DCHG_2' + tR_DCHG_1(end)  ; 
        DCHG(idx_1:idx_2 , 2) = VR_DCHG_2'  ; 
        DCHG(idx_1:idx_2 , 3) = IR_DCHG_2'  ; 
        DCHG(idx_1:idx_2 , 4) = CR_DCHG_2' + CR_DCHG_1(end) ;        
        
        
        %Changing number of elements in each set
            %CHG Sets: 
        f_T_CHG_x_length = linspace(1, length(t_CHG), numPoints);
        f_t_CHG(:,index) = interp1(1:length(t_CHG), t_CHG, f_T_CHG_x_length) ;
        f_V_CHG(:,index) = interp1(1:length(V_CHG), V_CHG, f_T_CHG_x_length) ;
        f_I_CHG(:,index) = interp1(1:length(I_CHG), I_CHG, f_T_CHG_x_length) ;
        f_C_CHG(:,index) = interp1(1:length(C_CHG), C_CHG, f_T_CHG_x_length) ;

            %DCHG sets
        DCHG_set_length = linspace(1, length(DCHG(:,1)), numPoints);
        f_t_DCHG(:,index) = interp1(1:length(DCHG(:,1)), DCHG(:,1), DCHG_set_length) ;
        f_V_DCHG(:,index) = interp1(1:length(DCHG(:,2)), DCHG(:,2), DCHG_set_length) ;
        f_I_DCHG(:,index) = interp1(1:length(DCHG(:,3)), DCHG(:,3), DCHG_set_length) ;
        f_C_DCHG(:,index) = interp1(1:length(DCHG(:,4)), DCHG(:,4), DCHG_set_length) ;
    end

    %Temp sets 
    for index = 1:length(DRT_TEMP_F_Name)
        temp_table = string( DRT_TEMP_F_Name(index) ) 

        %Reading table then convertion: Cell -> String -> Table -> Array
        temp_table = readtable(temp_table, 'PreserveVariableNames', false) ; %Convertion: Cell -> String -> Table
        temp_array = table2array(temp_table); 
        
        %Max Temp Dataset 
        m_temp_array = max(temp_array(:,2:7), [], 2);
        
        %finding TEMP sample rate: 
        Hz_TEMP = length(temp_array(:,1))/temp_array(end,1);
        
        %Min, Max temp
        [MIN, MAX] = bounds( m_temp_array, 'all');

        %Start/end index for CHG/DCHG
            %calculating CHG index
        T_CHG_idx_1 = 1;
        T_CHG_idx_2 = (t_CHG(end)+5)*Hz_TEMP;
            %Calculating DCHG end index 
        T_DCHG_idx_0 = find(m_temp_array == MAX )- 10 ;
        T_DCHG_idx_1 = T_DCHG_idx_0 - t_DCHG_1(end) *Hz_TEMP ;
        T_DCHG_idx_2 = T_DCHG_idx_1 +( t_DCHG_1(end) + t_DCHG_2(end) ) *Hz_TEMP ;

        %Creating CHG Temp Array, by extracting max Temp with Temp_CHG_Index
        CHG_Temp = m_temp_array(T_CHG_idx_1:T_CHG_idx_2) + kelvin ; 
        %CHG_Temp = movmean(CHG_Temp, F_AVG_points);

        
        %Creating CHG Temp Array, by extracting max Temp with Temp_CHG_Index
        if T_DCHG_idx_2 >= length(m_temp_array)
            DCHG_Temp = m_temp_array(T_DCHG_idx_1:T_DCHG_idx_2) + kelvin ; 
            error_set(4)=1;
        else
            DCHG_Temp = m_temp_array(T_DCHG_idx_1:end) + kelvin ;
            error_set(5)=1;
        end

        %Modifying length CHG Set 
        f_T_CHG_x_length = linspace(1, length(CHG_Temp), numPoints);
        f_T_CHG(:,index) = interp1(1:length(CHG_Temp), CHG_Temp, f_T_CHG_x_length) ;
        
        %Modifying length CHG Set 
        f_T_DCHG_x_length = linspace(1, length(DCHG_Temp), numPoints);
        f_T_DCHG(:,index) = interp1(1:length(DCHG_Temp), DCHG_Temp, f_T_DCHG_x_length) ;

    end
    error_set(6)=1;
    %Adding elements to output file 
        %CHG 
    DRT_out_Table{:,1} = mean(f_t_CHG,2); DRT_out_Table = renamevars(DRT_out_Table, 1, out_name + 't_CHG');
    DRT_out_Table{:,2} = mean(f_V_CHG,2); DRT_out_Table = renamevars(DRT_out_Table, 2, out_name + 'V_CHG');
    DRT_out_Table{:,3} = mean(f_I_CHG,2); DRT_out_Table = renamevars(DRT_out_Table, 3, out_name + 'I_CHG');
    DRT_out_Table{:,4} = mean(f_C_CHG,2); DRT_out_Table = renamevars(DRT_out_Table, 4, out_name + 'C_CHG');

        %CHG Temp 
    DRT_out_Table{:,5} = max(f_T_CHG,[],2); DRT_out_Table = renamevars(DRT_out_Table, 5, out_name + 'T_CHG');

        %DCHG
    DRT_out_Table{:,6} = mean(f_t_DCHG,2); DRT_out_Table = renamevars(DRT_out_Table, 6, out_name + 't_DCHG');
    DRT_out_Table{:,7} = mean(f_V_DCHG,2); DRT_out_Table = renamevars(DRT_out_Table, 7, out_name + 'V_DCHG');
    DRT_out_Table{:,8} = mean(f_I_DCHG,2); DRT_out_Table = renamevars(DRT_out_Table, 8, out_name + 'I_DCHG');
    DRT_out_Table{:,9} = mean(f_C_DCHG,2); DRT_out_Table = renamevars(DRT_out_Table, 9, out_name + 'C_DCHG');
        
        %DCHG_Temp
    DRT_out_Table{:,10} = max(f_T_DCHG,[],2); DRT_out_Table = renamevars(DRT_out_Table, 10, out_name + 'T_DCHG');
    
    if error == 1
        [MIN, MAX] = bounds(m_temp_array, 'all');
        
        MIN_idx=find(m_temp_array==MIN);
        MAX_idx=find(m_temp_array==MAX);

        disp('Min: ' + string(MIN) + ' m_temp_array'+ ' idx: '+string(MIN_idx) ) 
        disp('Max: ' + string(MAX) + ' m_temp_array'+ ' idx: '+string(MAX_idx) )
        
        [MIN, MAX] = bounds(f_T_DCHG, 'all');
        disp( 'MIN: ' + string(MIN) + ' | MAX: ' + string(MAX) )
        disp(error_set)
    end
    if make_error == 1
        disp( error_set(1:10) )
    end
end