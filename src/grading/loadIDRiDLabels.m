function labels = loadIDRiDLabels(csvFile, imageFolder)
% loadIDRiDLabels
% Reads IDRiD disease-grading labels and matches
% them with the corresponding retinal images.

%% Read CSV
T = readtable(csvFile, 'VariableNamingRule', 'preserve');

%% Extract important columns
imageNames = string(T.('Image name'));
drGrade = T.('Retinopathy grade');
edemaRisk = T.('Risk of macular edema');

%% Create output table
labels = table();

labels.ImageName = imageNames;
labels.DRGrade = drGrade;
labels.EdemaRisk = edemaRisk;

%% Match each label with its image
imagePaths = strings(height(T), 1);

for i = 1:height(T)

    % Example:
    % IDRiD_001 -> IDRiD_001.jpg

    imageFile = imageNames(i) + ".jpg";

    fullImagePath = fullfile(imageFolder, imageFile);
    

    if isfile(fullImagePath)
        imagePaths(i) = fullImagePath;
    else
        imagePaths(i) = "";
        warning("Image not found: %s", imageFile);
    end

end

labels.ImagePath = imagePaths;

%% Referable DR
% Grade 2 or higher is considered referable DR
% for this project.

labels.ReferableDR = labels.DRGrade >= 2;

end