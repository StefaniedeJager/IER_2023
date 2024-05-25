clear all; close all;

%% quiet standing trial
% Load data ~ Quiet standing
load('/Users/stefaniedejager/Downloads/Day6/QS.mat');

%% Define parameters
g = 9.81; % Acceleration due to gravity (m/s^2)
m = 57; % Mass of the participant (kg)
% t = 6*60; % 6 min validation (article) in seconds
N = length(time); %number of samples
N2 = N/2;
Fs = 500; % N/t; % sample frequency

Fc = 10;
n = 6;

[b, a] = butter(n, Fc/(Fs/2), 'low');
fLFz = filtfilt(b, a, LFz);  
fLMz = filtfilt(b, a, LMz);
fLFy = filtfilt(b, a, LFy);  
fLMy = filtfilt(b, a, LMy);
fLFx = filtfilt(b, a, LFx);  
fLMx = filtfilt(b, a, LMx);

fRFz = filtfilt(b, a, RFz);  
fRMz = filtfilt(b, a, RMz);
fRFy = filtfilt(b, a, RFy);  
fRMy = filtfilt(b, a, RMy);
fRFx = filtfilt(b, a, RFx);  
fRMx = filtfilt(b, a, RMx);

%% CoP offset in x- and y-direction

fLFz_av = mean(fLFz);
fLMx_av = mean(fLMx);
fLMy_av = mean(fLMy);
fRFz_av = mean(fRFz);
fRMx_av = mean(fRMx);
fRMy_av = mean(fRMy);

Ldx = fLMy_av./fLFz_av;
Ldy = fLMx_av./fLFz_av;

Rdx = fRMy_av./fRFz_av;
Rdy = fRMx_av./fRFz_av;

%% calculate force offset (in z direction)

GRF = m*g; % calculated ground reaction force
GRF_1foot = GRF/2; % per foot, since GRF is measured on a split belt treadmill

% Measured GRF per side
LGRF = sqrt((mean(fLFx)^2)+(mean(fLFy)^2)+(mean(fLFz)^2)); 
RGRF = sqrt((mean(fRFx)^2)+(mean(fRFy)^2)+(mean(fRFz)^2));

% Offset = difference between calculated and measured GRF
LZ_Offset = (LGRF-GRF_1foot);
RZ_Offset = (RGRF-GRF_1foot);


%% Walking trial
% Load data ~ Trial
load('/Users/stefaniedejager/Downloads/Day6/GA2.mat');

%% Define parameters
g = 9.81; % Acceleration due to gravity (m/s^2)
m = 57; % Mass of the participant (kg)
% t = 6*60; % 6 min validation (article) in seconds
N = length(time); %number of samples
N2 = N/2;
Fs = 500;% N/t; % sample frequency

Fc = 10;
n = 6;

[b, a] = butter(n, Fc/(Fs/2), 'low');
fLFz = filtfilt(b, a, LFz);  
fLMz = filtfilt(b, a, LMz);
fLFy = filtfilt(b, a, LFy);  
fLMy = filtfilt(b, a, LMy);
fLFx = filtfilt(b, a, LFx);  
fLMx = filtfilt(b, a, LMx);

fRFz = filtfilt(b, a, RFz);  
fRMz = filtfilt(b, a, RMz);
fRFy = filtfilt(b, a, RFy);  
fRMy = filtfilt(b, a, RMy);
fRFx = filtfilt(b, a, RFx);  
fRMx = filtfilt(b, a, RMx);

% sfLFz = smoothdata(fLFz); 
% sfLFy = smoothdata(fLFy); 
% sfLFx = smoothdata(fLFx); 
% sfLMz = smoothdata(fLMz); 
% sfLMy = smoothdata(fLMy); 
% sfLMx = smoothdata(fLMx); 
% 
% sfRFz = smoothdata(fRFz); 
% sfRFy = smoothdata(fRFy); 
% sfRFx = smoothdata(fRFx); 
% sfRMz = smoothdata(fRMz); 
% sfRMy = smoothdata(fRMy); 
% sfRMx = smoothdata(fRMx);
% 

%% Calculate heel strikes and toe offs
% remove offset
fLFz = fLFz - LZ_Offset;
fRFz = fRFz - RZ_Offset;

T_Ltoe_offs = [];
T_Lheel_strikes = [];

threshold = 20; % Threshold for detecting foot contact
min_N_between = 400; % Minimum samples between heel strikes and toe offs to avoid multiple detections for one event


for i = 1:length(fLFz)
    if i == length(fLFz)
        break
    end

    if fLFz(i) < threshold && fLFz(i+1) > threshold
        if isempty(T_Lheel_strikes) || (i - T_Lheel_strikes(end)) > min_N_between
        T_Lheel_strikes(end+1) = i+1;
        end
    end

    if fLFz(i) > threshold && fLFz(i+1) < threshold
        if isempty(T_Ltoe_offs) || (i - T_Ltoe_offs(end)) > min_N_between
        T_Ltoe_offs(end+1) = i;
        end
    end
end

T_Rtoe_offs = [];
T_Rheel_strikes = [];

threshold = 20; 
min_N_between = 400;

for i = 1:length(fRFz)
    if i == length(fRFz)
        break
    end

    if fRFz(i) < threshold && fRFz(i+1) > threshold
        if isempty(T_Rheel_strikes) || (i - T_Rheel_strikes(end)) > min_N_between
        T_Rheel_strikes(end+1) = i+1;
        end
    end

    if fRFz(i) > threshold && fRFz(i+1) < threshold
        if isempty(T_Rtoe_offs) || (i - T_Rtoe_offs(end)) > min_N_between
        T_Rtoe_offs(end+1) = i;
        end
    end
end

% in the article of ... they mention that data for the last three minutes
% of trials was used for analysis, that is the last half of each trial
% since one trial is six minuten

Lheel_strikes = T_Lheel_strikes(T_Lheel_strikes > N2);
Rheel_strikes = T_Rheel_strikes(T_Rheel_strikes > N2);

Ltoe_offs = T_Ltoe_offs(T_Ltoe_offs > N2);
Rtoe_offs = T_Rtoe_offs(T_Rtoe_offs > N2);

%% Calculating the center of pressure 

LX_nul = -Ldx;
LY_nul = -Ldy;
RX_nul = Rdx;
RY_nul = -Rdy;
Z_nul = 0;

L_CoPx = (fLMy + (fLFx.*Z_nul))./fLFz + LX_nul;
L_CoPy = (fLMx + (fLFy.*Z_nul))./fLFz + LY_nul;

R_CoPx = (fRMy + (fRFx.*Z_nul))./fRFz + RX_nul;
R_CoPy = (fRMx + (fRFy.*Z_nul))./fRFz + RY_nul;

%% filter outliers
fL_CoPy = filloutliers(L_CoPy, 'nearest');
fR_CoPy = filloutliers(R_CoPy, 'nearest');

%% CoP left foot

% make toe off and heel strike events of equal length
if length(Lheel_strikes)>length(Ltoe_offs)
    Lheel_strikes = Lheel_strikes(1:end-1);
    Ltoe_offs = Ltoe_offs;
elseif length(Ltoe_offs)>length(Lheel_strikes)
    Ltoe_offs = Ltoe_offs(1:end-1);
    Lheel_strikes = Lheel_strikes;
else
    Ltoe_offs = Ltoe_offs;
    Lheel_strikes = Lheel_strikes;
end

% make sure it starts with a heel strike
if Lheel_strikes(1)>Ltoe_offs(1)
    Lheel_strikes1 = Lheel_strikes(1:end-1);
    Ltoe_offs1 = Ltoe_offs(2:end);
else
    Lheel_strikes1 = Lheel_strikes;
    Ltoe_offs1 = Ltoe_offs;
end

Lsupport_time = [];
peak_LCoPy = [];
hs_LCoPy = [];

%calculate the center of pressure at heel strike
for k = 1:length(Lheel_strikes1)
    Lsupport_time(end+1) = (Ltoe_offs1(k) - Lheel_strikes1(k))/Fs;
    hs_LCoPy(k) = fL_CoPy(Lheel_strikes1(k));
end

%% CoP right foot

% make toe off and heel strike events of equal length
if length(Rheel_strikes)>length(Rtoe_offs)
    Rheel_strikes = Rheel_strikes(1:end-1);
    Rtoe_offs = Rtoe_offs;
elseif length(Rtoe_offs)>length(Rheel_strikes)
    Rtoe_offs = Rtoe_offs(1:end-1);
    Rheel_strikes = Rheel_strikes;
else
    Rtoe_offs = Rtoe_offs;
    Rheel_strikes = Rheel_strikes;
end

% make sure it starts with a heel strike
if Rheel_strikes(1)>Rtoe_offs(1)
    Rheel_strikes1 = Rheel_strikes(1:end-1);
    Rtoe_offs1 = Rtoe_offs(2:end);
else
    Rheel_strikes1 = Rheel_strikes;
    Rtoe_offs1 = Rtoe_offs;
end


Rsupport_time = [];
peak_RCoPy = [];
hs_RCoPy = [];

%calculate the center of pressure at heel strike
for k2 = 1:length(Rheel_strikes1)
    Rsupport_time(end+1) = (Rtoe_offs1(k2) - Rheel_strikes1(k2))/Fs;
    hs_RCoPy(k2) = fR_CoPy(Rheel_strikes1(k2));
end

%% Make sure both left and right are of equal length to do furter calculations

if length(hs_LCoPy)>length(hs_RCoPy)
    hs_LCoPy = hs_LCoPy(1:end-1);
else 
    hs_LCoPy = hs_LCoPy;
    hs_RCoPy = hs_RCoPy;
end

if length(hs_RCoPy)>length(hs_LCoPy)
    hs_RCoPy = hs_RCoPy(1:end-1);
else 
    hs_LCoPy = hs_LCoPy;
    hs_RCoPy = hs_RCoPy;
end

%% calculating step length 
% step length = distance between left and right CoPy at heel strike
step_length = hs_LCoPy + hs_RCoPy;
mean_step_length = mean(step_length)
step_length_variability = std(step_length)

all_step_length = [step_length];

SL_Table = array2table(all_step_length');
% Export to Excel
writetable(SL_Table,'SL_Day6_GA2.xls')
 