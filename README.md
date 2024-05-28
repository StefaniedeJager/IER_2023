
# Determening step width and step length from ground reaction force data of different walking trials 
This repository contains the data set
This analyses is an extension on that of K.L. Poggensee and S.H. Collins from their article: "How adaptation, training, and customization contributeto benefits from exoskeleton assistance", the data used here was collected during their research. 

## Dataset
All the data is stored in .mat files, for all different walking trials on two different training days seperately. 
All data is from one participant, containing the ground reaction force (Fx, Fy, Fz) and ground reaction moment data (Mx, My, Mz) in three directions; left, forward, down, which are used for analyses.
Data files also contain (From K.L. Poggensee and S.H. Collins):
- Time (s): time (0 is when the system was first turned on)
- Ankle angles from exoskeleton encoder: posaL, posaR (radians)
- Ankle velocities from exoskeleton encoder: velaL, velaR (rad/sec)
- Exoskeleton torque measured by strain gauges: tauL, tauR (Nm)
- Desired exoskeleton torque: taudesL, taudesR (Nm)
- Metabolics measurements: vo2, vco2 (mL/min)

**Data from the first training day**
Day2QS.mat = contains the data of the quiet standing trial
Walking trials:
Day2NW2.mat = contains the data of the walking trials with normal shoes
Day2ZT2.mat = contains the data of the walking trials with the exoskeleton on zero torque
Day2GA2.mat = contains the data of the walking trials with the exoskeleton subjected to the general assistance pattern

**Data from the last training day**
Day6QS.mat = contains the data of the quiet standing trial
Walking trials:
Day6NW2.mat = contains the data of the walking trials with normal shoes
Day6ZT2.mat = contains the data of the walking trials with the exoskeleton on zero torque
Day6GA2.mat = contains the data of the walking trials with the exoskeleton subjected to the general assistance pattern

Next to that, this repository contains some .xlsx excelfiles which contains all of the data that is collected by running the Matlab scripts.

**Used for R statistical analyses**
R_SWDay2.xlsx = Containing step width data of the first training day
R_SWDay6.xlsx = Containing step width data of the last training day
R_SLDay2.xlsx = Containing step length data of the first training day
R_SLDay6.xlsx = Containing step length data of the last training day
R_SWDay2vsDay6.xlsx = Containing step width data of both training days
R_SLDay2vsDay6.xlsx = Containing step length data of both training days
**Used for Matlab Boxplot**
SWDay2.xlsx = Containing step width data of the first training day
SWDay6.xlsx = Containing step width data of the last training day
SLDay2.xlsx = Containing step length data of the first training day
SLDay6.xlsx = Containing step length data of the last training day

These data files are used in the Boxplot.MATLAB script to obtain boxplots of the data, used for visualization of the data and in R for statistical analyses.

## Installing dependencies
To run all scripts a version of Matlab 2022b is needed. In order to perform the statistical analyses, R-4.4.0 and RStudio is needed.

## Matlab scripts
This repository contains three Matlab scripts:

- **Step_width.m**
  This script loads the .mat data.
    First (in line 5): the data from the quiet standing trial, fill in the rigth data filename for the corresponding training day e.g. 'Day2QS.mat'.
    Second (in line 63): the data from a walking trial, fill in the right filename that corresponds to the walking trial you want to analyze
              e.g. when you want to analyze the general assistance trial on the first training day: 'Day2GA2.mat'
              Make sure the day corresponds to that used in the First, so that is to the quiet standing trial.
  After loading the data, from the quiet standing trial offset is calculated and used in the furter calculations.
  With that and the data from the walking trial, step width is calculated for every step in the last half of the trial (last 3 minutes)
  An excel file containing the data is created, make sure you adjust the name of the file to correspond the data you have analyzed in line 280 (last line).
  Mean and standard deviation are also calculated and shown as variables in Matlab.
  
- **staplengte.m**
  This script loads the .mat data.
    First (in line 5) : the data from the quiet standing trial, fill in the rigth data filename for the corresponding training day e.g. 'Day2QS.mat'.
    Second (in line 64) : the data from a walking trial, fill in the right filename that corresponds to the walking trial you want to analyze
              e.g. when you want to analyze the general assistance trial on the first training day: 'Day2GA2.mat'
              Make sure the day corresponds to that used in the First, so that is to the quiet standing trial.
  After loading the data, from the quiet standing trial offset is calculated and used in the furter calculations.
  With that and the data from the walking trial, step length is calculated for every step in the last half of the trial (last 3 minutes)
  An excel file containing the data is created, make sure you adjust the name of the file to correspond the data you have analyzed in line 282 (last line).
  Mean and standard deviation are also calculated and shown as variables in Matlab.

- **Boxplot.m**
  This script makes the Boxplot that visualises the difference between step width of step length of the different walking trials for the corresponding day.
  It loads the .xlsx file.
  In line 2 fill in the name of the excel file you want to make a boxplot of, for example : 'SWDay6.xlsx'.
  Comment and uncomment the correct lines for the ylabel, when analyzing step width uncomment: ylabel('Step Width'); and for step length uncomment: ylabel('Step Length');. 
  Run the script and a figure containing the boxplot is created.
  
## R scripts for statistical analyses

In order to run the script you need to import the right excel file set in to RStudio (on the right side under environment select import data).

This script runs the seperate paired T-test's between the different conditions. 
In the comments it explains which lines to uncomment for the different excel data sets.
You can run the script by selecting the first line of the code and then select Run at the top rigth side above the code. 
Results are shown in the console section at the left bottom.



