clc;
clear;
close all;

%% Project folder
cd('/MATLAB Drive/DR_Screening');

%% Select one IDRiD image
imagePath = ...
    'data/raw/idrid/B. Disease Grading/1. Original Images/a. Training Set/IDRiD_001.jpg';

%% Read image
I = imread(imagePath);

%% Preprocess image
enhancedImage = preprocessFundusImage(I);

%% Display original image
figure;
imshow(I);
title('Original IDRiD Image');

%% Display preprocessed image
figure;
imshow(enhancedImage);
title('Preprocessed IDRiD Image');