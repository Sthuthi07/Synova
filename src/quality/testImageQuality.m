clc;
clear;
close all;

%% Select a fundus image

[file, path] = uigetfile( ...
    {'*.jpg;*.jpeg;*.png;*.tif;*.tiff', ...
    'Fundus Images'}, ...
    'Select a Fundus Image');

if isequal(file, 0)
    fprintf("No image selected.\n");
    return;
end

%% Read image

imagePath = fullfile(path, file);

I = imread(imagePath);

%% Display original image

figure;
imshow(I);
title("Original Fundus Image");

%% Assess image quality

result = assessImageQuality(I);

%% Display results

fprintf("\n====================================\n");
fprintf("       IMAGE QUALITY RESULT\n");
fprintf("====================================\n");

fprintf("Status       : %s\n", result.status);
fprintf("Quality Score: %.3f\n", result.score);
fprintf("Focus Score  : %.6f\n", result.focus);
fprintf("Brightness   : %.3f\n", result.brightness);
fprintf("FOV Ratio    : %.3f\n", result.fov);

fprintf("====================================\n");