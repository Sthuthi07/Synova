function auditAPTOS()

clc;

%% Project folder
cd('/MATLAB Drive/DR_Screening');

%% APTOS folder
baseFolder = 'data/raw/aptos_data';

fprintf('\n');
fprintf('============================================\n');
fprintf('           APTOS DATASET AUDIT\n');
fprintf('============================================\n');

%% Check main folder

if ~isfolder(baseFolder)
    error('APTOS folder not found: %s', baseFolder);
end

fprintf('\nAPTOS folder: FOUND\n');

%% Check expected files/folders

trainImageFolder = fullfile(baseFolder, 'train_images');
testImageFolder  = fullfile(baseFolder, 'test_images');

trainCSV = fullfile(baseFolder, 'train.csv');
testCSV  = fullfile(baseFolder, 'test.csv');

%% ---------------------------------------------------------
% 1. Training images
% ----------------------------------------------------------

fprintf('\n--- TRAINING IMAGES ---\n');

if isfolder(trainImageFolder)

    trainFiles = [
        dir(fullfile(trainImageFolder, '*.png'));
        dir(fullfile(trainImageFolder, '*.jpg'));
        dir(fullfile(trainImageFolder, '*.jpeg'));
    ];

    fprintf('Training images found : %d\n', length(trainFiles));

else

    fprintf('Training image folder NOT FOUND\n');
    trainFiles = [];

end

%% ---------------------------------------------------------
% 2. Testing images
% ----------------------------------------------------------

fprintf('\n--- TESTING IMAGES ---\n');

if isfolder(testImageFolder)

    testFiles = [
        dir(fullfile(testImageFolder, '*.png'));
        dir(fullfile(testImageFolder, '*.jpg'));
        dir(fullfile(testImageFolder, '*.jpeg'));
    ];

    fprintf('Testing images found : %d\n', length(testFiles));

else

    fprintf('Testing image folder NOT FOUND\n');
    testFiles = [];

end

%% ---------------------------------------------------------
% 3. Training CSV
% ----------------------------------------------------------

fprintf('\n--- TRAINING LABEL FILE ---\n');

if isfile(trainCSV)

    fprintf('train.csv : FOUND\n');

    trainTable = readtable( ...
        trainCSV, ...
        'VariableNamingRule', 'preserve');
    %% Check training CSV IDs against actual image files

    trainIDs = string(trainTable.id_code);

    imageFiles = dir(fullfile(trainImageFolder, "*.png"));
    imageNames = string({imageFiles.name})';

    % Remove .png extension
    imageIDs = erase(imageNames, ".png");

    % IDs present in CSV but missing as image files
    missingImages = setdiff(trainIDs, imageIDs);

    % Image files present but missing from CSV
    missingLabels = setdiff(imageIDs, trainIDs);

    fprintf('\n--- TRAINING IMAGE/LABEL CONSISTENCY ---\n');

    fprintf('CSV IDs missing image : %d\n', length(missingImages));
    fprintf('Images missing label  : %d\n', length(missingLabels));

    if ~isempty(missingImages)
        fprintf('\nCSV ID(s) with no corresponding image:\n');
        disp(missingImages);
    end

    if ~isempty(missingLabels)
        fprintf('\nImage ID(s) with no corresponding CSV label:\n');
        disp(missingLabels);
    end

    fprintf('Rows      : %d\n', height(trainTable));
    fprintf('Columns   : %d\n', width(trainTable));

    fprintf('\nColumn names:\n');

    for i = 1:width(trainTable)
        fprintf('  %s\n', trainTable.Properties.VariableNames{i});
    end

else

    fprintf('train.csv : NOT FOUND\n');
    trainTable = table();

end

%% ---------------------------------------------------------
% 4. Testing CSV
% ----------------------------------------------------------

fprintf('\n--- TESTING LABEL FILE ---\n');

if isfile(testCSV)

    fprintf('test.csv : FOUND\n');

    testTable = readtable( ...
        testCSV, ...
        'VariableNamingRule', 'preserve');

    fprintf('Rows      : %d\n', height(testTable));
    fprintf('Columns   : %d\n', width(testTable));

    fprintf('\nColumn names:\n');

    for i = 1:width(testTable)
        fprintf('  %s\n', testTable.Properties.VariableNames{i});
    end

else

    fprintf('test.csv : NOT FOUND\n');
    testTable = table();

end

%% ---------------------------------------------------------
% 5. Inspect training labels
% ----------------------------------------------------------

if ~isempty(trainTable)

    fprintf('\n--- TRAINING LABEL DISTRIBUTION ---\n');

    disp(groupcounts(trainTable, 'diagnosis'));

end

%% ---------------------------------------------------------
% 6. Basic consistency check
% ----------------------------------------------------------

fprintf('\n--- BASIC CONSISTENCY CHECK ---\n');

if ~isempty(trainTable)

    if height(trainTable) == length(trainFiles)

        fprintf('[OK] Training label count matches image count.\n');

    else

        fprintf('[WARNING] Training labels and image counts differ.\n');
        fprintf('Labels : %d\n', height(trainTable));
        fprintf('Images : %d\n', length(trainFiles));

    end

end

%% ---------------------------------------------------------
% 7. Display example files
% ----------------------------------------------------------

fprintf('\n--- EXAMPLE TRAINING IMAGES ---\n');

for i = 1:min(5, length(trainFiles))
    fprintf('%s\n', trainFiles(i).name);
end

fprintf('\n--- EXAMPLE TESTING IMAGES ---\n');

for i = 1:min(5, length(testFiles))
    fprintf('%s\n', testFiles(i).name);
end

%% ---------------------------------------------------------
% 8. Summary
% ----------------------------------------------------------

fprintf('\n============================================\n');
fprintf('              APTOS AUDIT COMPLETE\n');
fprintf('============================================\n');

fprintf('Training images : %d\n', length(trainFiles));
fprintf('Testing images  : %d\n', length(testFiles));

if ~isempty(trainTable)
    fprintf('Training labels : %d\n', height(trainTable));
end

if ~isempty(testTable)
    fprintf('Testing labels  : %d\n', height(testTable));
end

fprintf('============================================\n');

end