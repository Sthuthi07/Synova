function auditMessidor()

clc;

fprintf('============================================\n');
fprintf('           MESSIDOR DATASET AUDIT\n');
fprintf('============================================\n\n');

%% Project location
cd('/MATLAB Drive/DR_Screening');

%% Messidor folder
messidorFolder = 'data/raw/Messidor';

%% Check main folder

fprintf('Messidor folder: ');

if isfolder(messidorFolder)
    fprintf('FOUND\n');
else
    fprintf('NOT FOUND\n');
    fprintf('\nAudit stopped.\n');
    return;
end

%% Find all image files recursively

fprintf('\n--- IMAGE FILES ---\n');

jpgFiles = dir(fullfile(messidorFolder, '**', '*.jpg'));
jpegFiles = dir(fullfile(messidorFolder, '**', '*.jpeg'));
pngFiles = dir(fullfile(messidorFolder, '**', '*.png'));
tifFiles = dir(fullfile(messidorFolder, '**', '*.tif'));
tiffFiles = dir(fullfile(messidorFolder, '**', '*.tiff'));

allFiles = [jpgFiles; jpegFiles; pngFiles; tifFiles; tiffFiles];

fprintf('JPG images  : %d\n', length(jpgFiles));
fprintf('JPEG images : %d\n', length(jpegFiles));
fprintf('PNG images  : %d\n', length(pngFiles));
fprintf('TIF images  : %d\n', length(tifFiles));
fprintf('TIFF images : %d\n', length(tiffFiles));

fprintf('\nTotal images found : %d\n', length(allFiles));

%% List top-level folders

fprintf('\n--- TOP-LEVEL FOLDERS ---\n');

folders = dir(messidorFolder);
folders = folders([folders.isdir]);
folders = folders(~ismember({folders.name}, {'.', '..'}));

fprintf('Top-level folders found : %d\n\n', length(folders));

for i = 1:length(folders)
    fprintf('%s\n', folders(i).name);
end

%% Example images

fprintf('\n--- EXAMPLE IMAGES ---\n');

for i = 1:min(10, length(allFiles))

    fullPath = fullfile(allFiles(i).folder, allFiles(i).name);

    fprintf('%s\n', fullPath);

end

%% Inspect image dimensions

fprintf('\n--- IMAGE DIMENSION CHECK ---\n');

if ~isempty(allFiles)

    sampleCount = min(10, length(allFiles));

    for i = 1:sampleCount

        fullPath = fullfile(allFiles(i).folder, allFiles(i).name);

        try

            img = imread(fullPath);

            fprintf('%s : ', allFiles(i).name);

            fprintf('%d x %d', size(img,1), size(img,2));

            if ndims(img) == 3
                fprintf(' x %d', size(img,3));
            end

            fprintf('\n');

        catch ME

            fprintf('%s : ERROR READING IMAGE\n', ...
                allFiles(i).name);

        end

    end

else

    fprintf('No image files found.\n');

end

%% Search for possible metadata/label files

fprintf('\n--- POSSIBLE METADATA / LABEL FILES ---\n');

csvFiles = dir(fullfile(messidorFolder, '**', '*.csv'));
xlsFiles = dir(fullfile(messidorFolder, '**', '*.xls'));
xlsxFiles = dir(fullfile(messidorFolder, '**', '*.xlsx'));
txtFiles = dir(fullfile(messidorFolder, '**', '*.txt'));
xmlFiles = dir(fullfile(messidorFolder, '**', '*.xml'));

metadataFiles = [csvFiles; xlsFiles; xlsxFiles; ...
                 txtFiles; xmlFiles];

fprintf('CSV files  : %d\n', length(csvFiles));
fprintf('XLS files  : %d\n', length(xlsFiles));
fprintf('XLSX files : %d\n', length(xlsxFiles));
fprintf('TXT files  : %d\n', length(txtFiles));
fprintf('XML files  : %d\n', length(xmlFiles));

fprintf('\nMetadata/label files found:\n');

if isempty(metadataFiles)

    fprintf('None found.\n');

else

    for i = 1:length(metadataFiles)

        fprintf('%s\n', ...
            fullfile(metadataFiles(i).folder, ...
                     metadataFiles(i).name));

    end

end

%% Final summary

fprintf('\n============================================\n');
fprintf('          MESSIDOR AUDIT COMPLETE\n');
fprintf('============================================\n');

fprintf('Total images : %d\n', length(allFiles));
fprintf('Top-level folders : %d\n', length(folders));
fprintf('Metadata/label files : %d\n', length(metadataFiles));

fprintf('============================================\n');

end