numPoints = 58800;
DCHG = readtable('C:\Users\danie\Documents\Programing\Matlab_Scripts\ENEBAC_1\dV_oc_dt\INR21700 50S\AV_C3_dVoc_dT_T1_55C_TEMP.xlsx');

DCHG = table2array(DCHG); 

x_new = linspace(1, length(DCHG(:,1)), numPoints);

time = DCHG(:,1);
time = interp1(1:length(time), time, x_new) ;

K1 = DCHG(:,2);
K1 = interp1(1:length(K1), K1, x_new) ;

K2 = DCHG(:,3);
K2 = interp1(1:length(K2), K2, x_new) ;

K3 = DCHG(:,4);
K3 = interp1(1:length(K3), K3, x_new) ;

K4 = DCHG(:,5);
K4 = interp1(1:length(K4), K4, x_new) ;

K5 = DCHG(:,6);
K5 = interp1(1:length(K5), K5, x_new) ;

K6 = DCHG(:,7);
K6 = interp1(1:length(K6), K6, x_new) ;

out = table(time', K1', K2', K3', K4', K5', K6');

filename = 'dchg_test.xlsx';
writetable(out,filename,'Sheet','MyNewSheet','WriteVariableNames',true);
