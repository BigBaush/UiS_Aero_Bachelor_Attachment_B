%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Motivation 
- This document outlines how to use the MATLAB scripts and simulations for test data related to the avionics battery pack 2025

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

How to store / access data processing / plotting scripts: 

1. Create a folder on your computer
2. Download all MATLAB files in the "Testing" folder and extract them into the folder you have created on your own system
3. Download the contents of the "Excel Test Data" folder and put its contents with their respective sub folders onto the same folder that you have placed your MATLAB scripts. 
4. To use the data go into the files which start with "M_", which are the main files which all data works around

- If you have problems accessing the datafiles, replace the file paths in the scripts to the file paths corresponding to your system and try again. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

File Names MATLAB Scripts: 
- "M_" : Main 
- "F_" : Function, used to preform function for "M_" scripts
- "P_" : Plotting files, used to plot data, works standalone 
- "R_" : Data Point Reduction function, Used to reduce datapoints to allow them to be used in other scripts
- "S_" : Sim Table data files, used as parameter data for simulations 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

How to Access the simulation Models: 
1. download the "Simulering" folder onto your computer and extract its contents.
2. Go into the folder and run the simulation model you want to run.

- Note that the uploaded models are created using Matlab 2024b, so you need to have that version of matlab to be able to run the models. There is also a 2020a model for the avionics battery pack simulation, but this model is not tested, thus it may deviate from the models created in 2024b. 
