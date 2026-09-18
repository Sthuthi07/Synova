clc;
clear;

cd('/MATLAB Drive/DR_Screening');

%% IDRiD training label file
csvFile = ...
    'data/raw/idrid/B. Disease Grading/2. Groundtruths/a. IDRiD_Disease Grading_Training Labels.csv';

%% IDRiD training image folder
imageFolder = ...
    'data/raw/idrid/B. Disease Grading/1. Original Images/a. Training Set';

%% Load labels and match images
labels = loadIDRiDLabels(csvFile, imageFolder);

%% Display first 10 rows
disp(labels(1:10,:));

%% Check missing images
missing = sum(labels.ImagePath == "");

%% Display summary
fprintf('\n===============================\n');
fprintf('IDRiD TRAINING DATA CHECK\n');
fprintf('===============================\n');

fprintf('Total labels   : %d\n', height(labels));
fprintf('Missing images : %d\n', missing);
fprintf('Referable DR   : %d\n', sum(labels.ReferableDR));

fprintf('===============================\n');