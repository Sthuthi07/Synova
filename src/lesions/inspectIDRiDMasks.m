function inspectIDRiDMasks()

clc;
close all;

%% Project folder
cd('/MATLAB Drive/DR_Screening');

%% Image to inspect
imageName = 'IDRiD_49';

%% =========================================================
% ORIGINAL IMAGE
% ==========================================================

imageFolder = ...
    'data/raw/idrid/1. Original Images/a. Training Set';

imagePath = fullfile(imageFolder, [imageName '.jpg']);

fprintf('Original image: %s\n', imagePath);

if ~isfile(imagePath)
    error('Original image not found: %s', imagePath);
end

I = imread(imagePath);

%% =========================================================
% PREPROCESSED IMAGE
% ==========================================================

processedPath = fullfile( ...
    'data/processed/idrid/images', ...
    [imageName '.png']);

fprintf('Processed image: %s\n', processedPath);

if ~isfile(processedPath)
    error('Preprocessed image not found: %s', processedPath);
end

P = imread(processedPath);

%% =========================================================
% GROUND-TRUTH MASK FOLDERS
% ==========================================================

baseFolder = ...
    'data/raw/idrid/2. All Segmentation Groundtruths/a. Training Set';

maFolder = fullfile(baseFolder, '1. Microaneurysms');
heFolder = fullfile(baseFolder, '2. Haemorrhages');
exFolder = fullfile(baseFolder, '3. Hard Exudates');
seFolder = fullfile(baseFolder, '4. Soft Exudates');
odFolder = fullfile(baseFolder, '5. Optic Disc');

%% =========================================================
% FIND MASKS
% ==========================================================

maPath = fullfile(maFolder, [imageName '_MA.tif']);
hePath = fullfile(heFolder, [imageName '_HE.tif']);
exPath = fullfile(exFolder, [imageName '_EX.tif']);
sePath = fullfile(seFolder, [imageName '_SE.tif']);
odPath = fullfile(odFolder, [imageName '_OD.tif']);

%% Check every mask

if ~isfile(maPath)
    error('Microaneurysm mask not found.');
end

if ~isfile(hePath)
    error('Haemorrhage mask not found.');
end

if ~isfile(exPath)
    error('Hard Exudate mask not found.');
end

if ~isfile(sePath)
    error('Soft Exudate mask not found.');
end

if ~isfile(odPath)
    error('Optic Disc mask not found.');
end

%% =========================================================
% READ MASKS
% ==========================================================

MA = imread(maPath);
HE = imread(hePath);
EX = imread(exPath);
SE = imread(sePath);
OD = imread(odPath);

%% =========================================================
% DISPLAY
% ==========================================================

figure;
imshow(I);
title('Original IDRiD Image - IDRiD 49');

figure;
imshow(P);
title('Preprocessed Image');

figure;
imshow(MA);
title('Microaneurysm Ground Truth');

figure;
imshow(HE);
title('Haemorrhage Ground Truth');

figure;
imshow(EX);
title('Hard Exudate Ground Truth');

figure;
imshow(SE);
title('Soft Exudate Ground Truth');

figure;
imshow(OD);
title('Optic Disc Ground Truth');

end