function prepareIDRiDImages()

clc;

%% Project folder
cd('/MATLAB Drive/DR_Screening');

%% Load prepared IDRiD data
dataFile = ...
    'data/processed/idrid/IDRiD_Training_Data.mat';

load(dataFile, 'dataTable');

%% Output folder
outputFolder = ...
    'data/processed/idrid/images';

if ~isfolder(outputFolder)
    mkdir(outputFolder);
end

%% Process each image
totalImages = height(dataTable);

fprintf('\n====================================\n');
fprintf('   IDRiD IMAGE PREPROCESSING\n');
fprintf('====================================\n');

for i = 1:totalImages

    %% Read original image
    I = imread(dataTable.ImagePath(i));

    %% Preprocess image
    enhancedImage = preprocessFundusImage(I);

    %% Output filename
    outputName = dataTable.ImageName(i) + ".png";

    outputPath = fullfile(outputFolder, outputName);

    %% Save processed image
    imwrite(enhancedImage, outputPath);

    %% Progress
    fprintf('Processed %d / %d : %s\n', ...
        i, totalImages, dataTable.ImageName(i));

end

fprintf('\n====================================\n');
fprintf('Preprocessing completed successfully!\n');
fprintf('Total images processed: %d\n', totalImages);
fprintf('====================================\n');

end