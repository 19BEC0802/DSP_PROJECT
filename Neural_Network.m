clc;
clear all;
close all;

%Training and Validation using Alexnet
DatasetPath='/MATLAB Drive/DSP-1';

%Reading Images from Image Database Folder
images = imageDatastore(DatasetPath,'IncludeSubfolders', true,'Labelsource', 'foldernames');

%Distributing Images in the set of Training and Testing
numTrainFiles = 250;
[TrainImages, TestImages] = splitEachLabel(images, numTrainFiles, 'randomize');
net = alexnet; %importing pretrained Alexnet (Requires support package)
layersTransfer = net.Layers (1:end-3);% "Preserving all layers except last three
numClasses =3; %Number of output classes: ARR, CHF, NSR

%Defining layers of Alexnet
layers=[
    layersTransfer
    fullyConnectedLayer(numClasses,'WeightLearnRateFactor',20, 'BiasLearnRateFactor',20)
    softmaxLayer
    classificationLayer];

options = trainingOptions('sgdm','MiniBatchSize',20,'MaxEpochs',8,'InitialLearnRate',1e-4,'Shuffle','every-epoch','ValidationData',TestImages,'ValidationFrequency', 10, 'verbose',false,'plots','training-progress');

%Training the AlexNet
netTransfer = trainNetwork(TrainImages, layers, options);

%Classifying Images
YPred = classify(netTransfer,TestImages);
YValidation = TestImages.Labels;
accuracy = sum(YPred == YValidation)/numel (YValidation);

%Plotting Contuation Matrix
plotconfusion (YValidation, YPred)
