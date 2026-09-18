function checkDatasets()

clc;

%% Project location
projectFolder = '/MATLAB Drive/DR_Screening';

fprintf('============================================\n');
fprintf('       DR SCREENING DATASET CHECK\n');
fprintf('============================================\n\n');

%% Dataset paths
aptosPath = fullfile(projectFolder, 'data', 'raw', 'aptos_data');
idridPath = fullfile(projectFolder, 'data', 'raw', 'idrid');
messidorPath = fullfile(projectFolder, 'data', 'raw', 'Messidor');

%% Check APTOS
fprintf('APTOS DATASET\n');
fprintf('-------------\n');

if isfolder(aptosPath)
    fprintf('Status: FOUND\n');

    trainFolder = fullfile(aptosPath, 'train_images');
    testFolder  = fullfile(aptosPath, 'test_images');
    trainCSV    = fullfile(aptosPath, 'train.csv');
    testCSV     = fullfile(aptosPath, 'test.csv');

    if isfolder(trainFolder)
        fprintf('Train images: FOUND\n');
    else
        fprintf('Train images: NOT FOUND\n');
    end

    if isfolder(testFolder)
        fprintf('Test images : FOUND\n');
    else
        fprintf('Test images : NOT FOUND\n');
    end

    if isfile(trainCSV)
        fprintf('train.csv   : FOUND\n');
    else
        fprintf('train.csv   : NOT FOUND\n');
    end

    if isfile(testCSV)
        fprintf('test.csv    : FOUND\n');
    else
        fprintf('test.csv    : NOT FOUND\n');
    end
else
    fprintf('Status: NOT FOUND\n');
end

fprintf('\n');

%% Check IDRiD
fprintf('IDRiD DATASET\n');
fprintf('-------------\n');

if isfolder(idridPath)
    fprintf('Status: FOUND\n');

    files = dir(idridPath);

    for i = 1:length(files)
        if ~strcmp(files(i).name, '.') && ...
           ~strcmp(files(i).name, '..')

            if files(i).isdir
                fprintf('[FOLDER] %s\n', files(i).name);
            else
                fprintf('[FILE]   %s\n', files(i).name);
            end
        end
    end
else
    fprintf('Status: NOT FOUND\n');
end

fprintf('\n');

%% Check Messidor
fprintf('MESSIDOR DATASET\n');
fprintf('----------------\n');

if isfolder(messidorPath)
    fprintf('Status: FOUND\n');

    files = dir(messidorPath);

    for i = 1:length(files)
        if ~strcmp(files(i).name, '.') && ...
           ~strcmp(files(i).name, '..')

            if files(i).isdir
                fprintf('[FOLDER] %s\n', files(i).name);
            else
                fprintf('[FILE]   %s\n', files(i).name);
            end
        end
    end
else
    fprintf('Status: NOT FOUND\n');
end

fprintf('\n============================================\n');
fprintf('             CHECK COMPLETE\n');
fprintf('============================================\n');

end