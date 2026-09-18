function evaluateMicroaneurysms()

clc;
close all;

%% Project folder
cd('/MATLAB Drive/DR_Screening');

%% Image
imagePath = ...
    'data/raw/idrid/1. Original Images/a. Training Set/IDRiD_49.jpg';

I = imread(imagePath);

%% Detect microaneurysms
detectedMask = detectMicroaneurysms(I);

%% Ground-truth mask
groundTruthPath = ...
    'data/raw/idrid/2. All Segmentation Groundtruths/a. Training Set/1. Microaneurysms/IDRiD_49_MA.tif';

groundTruth = imread(groundTruthPath);

%% Convert ground truth to binary
groundTruth = groundTruth > 0;

%% Resize ground truth to detector size
groundTruth = imresize( ...
    groundTruth, ...
    size(detectedMask), ...
    'nearest');

%% Make sure detection is logical
detectedMask = logical(detectedMask);

%% =========================================================
% Pixel-wise comparison
% ==========================================================

truePositive = detectedMask & groundTruth;
falsePositive = detectedMask & ~groundTruth;
falseNegative = ~detectedMask & groundTruth;

TP = sum(truePositive(:));
FP = sum(falsePositive(:));
FN = sum(falseNegative(:));

%% Precision

if (TP + FP) == 0
    precision = 0;
else
    precision = TP / (TP + FP);
end

%% Recall

if (TP + FN) == 0
    recall = 0;
else
    recall = TP / (TP + FN);
end

%% F1 score

if (precision + recall) == 0
    f1 = 0;
else
    f1 = 2 * precision * recall / ...
        (precision + recall);
end

%% Dice score

dice = 2 * TP / ...
    (2 * TP + FP + FN);

%% =========================================================
% Display results
% ==========================================================

fprintf('\n====================================\n');
fprintf(' MICROANEURYSM DETECTION EVALUATION\n');
fprintf('====================================\n');

fprintf('True Positives  : %d\n', TP);
fprintf('False Positives : %d\n', FP);
fprintf('False Negatives : %d\n', FN);

fprintf('\nPrecision       : %.4f\n', precision);
fprintf('Recall          : %.4f\n', recall);
fprintf('F1 Score        : %.4f\n', f1);
fprintf('Dice Score      : %.4f\n', dice);

fprintf('====================================\n');

%% =========================================================
% Display comparison
% ==========================================================

figure;
imshow(detectedMask);
title('Detected Microaneurysms');

figure;
imshow(groundTruth);
title('Ground Truth');

figure;
imshow(I);
title('Original Fundus Image');

end