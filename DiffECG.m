clc;
close all;
clear all;
load('ECGData.mat');
data=ECGData.Data;
labels = ECGData.Labels;

ARR=data(1:30,:);
CHF=data(97:126,:);
NSR=data(127:156,:);
signallenght=500;

fb=cwtfilterbank('SignalLength',signallenght,'wavelet','amor','VoicesPerOctave',12);

mkdir('ecgdataset');
mkdir('ecgdataset/arr');
mkdir('ecgdataset/chf');
mkdir('ecgdataset/nsr');

ecgtype={'ARR', 'CHF', 'NSR'};

code2(ARR,fb,ecgtype{1});
code2(CHF,fb,ecgtype{2});
code2(NSR,fb,ecgtype{3});
