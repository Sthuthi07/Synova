function auditIDRiD()

clc;

fprintf('============================================\n');
fprintf('             IDRiD DATASET AUDIT\n');
fprintf('============================================\n\n');

%% Project location
cd('/MATLAB Drive/DR_Screening');

%% IDRiD disease grading paths

trainImageFolder = ...
    'data/raw/idrid/B. Disease Grading/1. Original Images/a. Training Set';

testImageFolder = ...
    'data/raw/idrid/B. Disease Grading/1. Original Images/b. Testing Set';

trainCSV = ...
    'data/raw/idrid/B. Disease Grading/2. Groundtruths/a. IDRiD_Disease Grading_Training Labels.csv';

testCSV = ...
    'data/raw/idrid/B. Disease Grading/2. Groundtruths/b. IDRiD_Disease Grading_Testing Labels.csv';

%% Check folders

fprintf('--- IDRiD FOLDERS ---\n');

if isfolder(trainImageFolder)
    fprintf('Training image folder : FOUND\n');
else
    fprintf('Training image folder : NOT FOUND\n');
end

if isfolder(testImageFolder)
    fprintf('Testing image folder  : FOUND\n');
else
    fprintf('Testing image folder  : NOT FOUND\n');
end

%% Training images

fprintf('\n--- TRAINING IMAGES ---\n');

trainFiles = dir(fullfile(trainImageFolder, '*.jpg'));

fprintf('Training images found : %d\n', length(trainFiles));

%% Testing images

fprintf('\n--- TESTING IMAGES ---\n');

testFiles = dir(fullfile(testImageFolder, '*.jpg'));

fprintf('Testing images found : %d\n', length(testFiles));

%% Training labels

fprintf('\n--- TRAINING LABEL FILE ---\n');

if isfile(trainCSV)

    fprintf('Training CSV : FOUND\n');

    trainTable = readtable(trainCSV, ...
        'VariableNamingRule', 'preserve');

    fprintf('Rows      : %d\n', height(trainTable));
    fprintf('Columns   : %d\n', width(trainTable));

    fprintf('\nColumn names:\n');

    disp(trainTable.Properties.VariableNames');

else

    fprintf('Training CSV : NOT FOUND\n');

end

%% Testing labels

fprintf('\n--- TESTING LABEL FILE ---\n');

if isfile(testCSV)

    fprintf('Testing CSV : FOUND\n');

    testTable = readtable(testCSV, ...
        'VariableNamingRule', 'preserve');

    fprintf('Rows      : %d\n', height(testTable));
    fprintf('Columns   : %d\n', width(testTable));

    fprintf('\nColumn names:\n');

    disp(testTable.Properties.VariableNames');

else

    fprintf('Testing CSV : NOT FOUND\n');

end

%% Training label distribution

fprintf('\n--- TRAINING DR GRADE DISTRIBUTION ---\n');

if isfile(trainCSV)

    trainGrades = trainTable.('Retinopathy grade');

    disp(groupcounts(trainTable, 'Retinopathy grade'));

end

%% Testing label distribution

fprintf('\n--- TESTING DR GRADE DISTRIBUTION ---\n');

if isfile(testCSV)

    testGrades = testTable.('Retinopathy grade');

    disp(groupcounts(testTable, 'Retinopathy grade'));

end

%% Training image/label consistency

fprintf('\n--- TRAINING IMAGE/LABEL CONSISTENCY ---\n');

if isfile(trainCSV)

    trainIDs = string(trainTable.('Image name'));

    trainImageNames = string({trainFiles.name})';

    trainImageIDs = erase(trainImageNames, '.jpg');

    missingTrainImages = setdiff(trainIDs, trainImageIDs);
    missingTrainLabels = setdiff(trainImageIDs, trainIDs);

    fprintf('CSV IDs missing image : %d\n', ...
        length(missingTrainImages));

    fprintf('Images missing label  : %d\n', ...
        length(missingTrainLabels));

    if ~isempty(missingTrainImages)

        fprintf('\nCSV IDs with no corresponding image:\n');
        disp(missingTrainImages);

    end

    if ~isempty(missingTrainLabels)

        fprintf('\nImage IDs with no corresponding label:\n');
        disp(missingTrainLabels);

    end

end

%% Testing image/label consistency

fprintf('\n--- TESTING IMAGE/LABEL CONSISTENCY ---\n');

if isfile(testCSV)

    testIDs = string(testTable.('Image name'));

    testImageNames = string({testFiles.name})';

    testImageIDs = erase(testImageNames, '.jpg');

    missingTestImages = setdiff(testIDs, testImageIDs);
    missingTestLabels = setdiff(testImageIDs, testIDs);

    fprintf('CSV IDs missing image : %d\n', ...
        length(missingTestImages));

    fprintf('Images missing label  : %d\n', ...
        length(missingTestLabels));

    if ~isempty(missingTestImages)

        fprintf('\nCSV IDs with no corresponding image:\n');
        disp(missingTestImages);

    end

    if ~isempty(missingTestLabels)

        fprintf('\nImage IDs with no corresponding label:\n');
        disp(missingTestLabels);

    end

end

%% Example images

fprintf('\n--- EXAMPLE TRAINING IMAGES ---\n');

for i = 1:min(5, length(trainFiles))
    fprintf('%s\n', trainFiles(i).name);
end

fprintf('\n--- EXAMPLE TESTING IMAGES ---\n');

for i = 1:min(5, length(testFiles))
    fprintf('%s\n', testFiles(i).name);
end

%% Final summary

fprintf('\n============================================\n');
fprintf('             IDRiD AUDIT COMPLETE\n');
fprintf('============================================\n');

fprintf('Training images : %d\n', length(trainFiles));
fprintf('Testing images  : %d\n', length(testFiles));

if isfile(trainCSV)
    fprintf('Training labels : %d\n', height(trainTable));
end

if isfile(testCSV)
    fprintf('Testing labels  : %d\n', height(testTable));
end

fprintf('============================================\n');

end