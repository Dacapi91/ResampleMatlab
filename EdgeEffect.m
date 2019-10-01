%% Edge effect using resample

% This script shows the edge effect due to resampling operation in signals.
% In addition, it presents two alternatives to fix it.

% Author: MSc. David Castro Piñol

clear; close all; clc;
load ecgSignal;
Fs = 250;
newFs = 360;

n = 0:length(ecgSignal)-1;
t1 = n*1/Fs;

%% Problem Edge Effects

signalResampled = resample(ecgSignal,newFs,Fs);
n2 = 0:length(signalResampled)-1;
t2 = n2*1/newFs;

figure; plot(t1,ecgSignal,'b',t2,signalResampled,'r'); ylim([-4.7 -2.5]);
xlabel('Time (s)'); ylabel('Signal'); legend('Original','Resampled', ...
    'Location','NorthWest');

%% First Alternative: mean normalization

ecgSignalMeanOff = ecgSignal - mean(ecgSignal);
signalResampled = resample(ecgSignalMeanOff,newFs,Fs);
n2 = 0:length(signalResampled)-1;
t2 = n2*1/newFs;

figure; plot(t1,ecgSignalMeanOff,'bo-',t2,signalResampled,'r*-'); 
xlabel('Time (s)'); ylabel('Signal'); legend('Zero Mean','Resampled', ...
    'Location','NorthWest');

%% Second Alternative: Flip and shift

L = ceil(length(ecgSignal)*newFs/Fs);
flipedSignal = [flip(ecgSignal);ecgSignal;flip(ecgSignal)];       
signalResampled = resample(flipedSignal,newFs,Fs);

figure; subplot(211);plot(signalResampled,'b'); title('Flip and Shift ECG signal');
hold on; plot(L:2*L-1,signalResampled(L:2*L-1),'r'); 
cutSignal = signalResampled(L:2*L-1);
subplot(212);plot(t2,cutSignal,'r');  title('Cutting signal');





