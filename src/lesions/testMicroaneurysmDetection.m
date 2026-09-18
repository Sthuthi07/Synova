clc;
clear;
close all;

%% Project folder
cd('/MATLAB Drive/DR_Screening');

%% IDRiD image
imagePath = ...
    'data/raw/idrid/1. Original Images/a. Training Set/IDRiD_49.jpg';

I = imread(imagePath);

%% Detect microaneurysms
detectedMask = detectMicroaneurysms(I);

%% Ground truth
maskPath = ...
    'data/raw/idrid/2. All Segmentation Groundtruths/a. Training Set/1. Microaneurysms/IDRiD_49_MA.tif';

groundTruth = imread(maskPath);

%% Display original image
figure;
imshow(I);
title('Original IDRiD Image');

%% Display our detection
figure;
imshow(detectedMask);
title('Detected Microaneurysms');

%% Display ground truth
figure;
imshow(groundTruth);
title('Ground Truth Microaneurysms');