clc;
clear;
close all;

cd('/MATLAB Drive/DR_Screening');

%% Read image

imagePath = ...
    'data/raw/idrid/1. Original Images/a. Training Set/IDRiD_49.jpg';

I = imread(imagePath);

%% Create vessel mask

vesselMask = createVesselMask(I);

%% Display original

figure;
imshow(I);
title('Original Fundus Image');

%% Display vessel mask

figure;
imshow(vesselMask);
title('Baseline Vessel Mask');