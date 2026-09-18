function result = assessImageQuality(I)
% assessImageQuality
% Checks whether a retinal fundus image is suitable for processing.
%
% Output:
% result.status   -> "Good", "Borderline", or "Reject"
% result.score    -> overall quality score
% result.focus    -> focus score
% result.brightness -> average brightness
% result.fov      -> field-of-view estimate

%% Convert image to grayscale

if size(I,3) == 3
    grayImage = rgb2gray(I);
else
    grayImage = I;
end

grayImage = im2double(grayImage);

%% 1. Focus assessment

% Laplacian-based sharpness measurement
laplacianKernel = [0 -1 0; -1 4 -1; 0 -1 0];

laplacianImage = imfilter(grayImage, laplacianKernel, ...
    "replicate");

focusScore = var(laplacianImage(:));

%% 2. Brightness assessment

brightnessScore = mean(grayImage(:));

%% 3. Field-of-view assessment

% Detect non-dark region
brightRegion = grayImage > 0.05;

fovRatio = sum(brightRegion(:)) / numel(brightRegion);

%% Normalize individual scores

% Focus score
focusNormalized = min(focusScore / 0.01, 1);

% Brightness score
if brightnessScore >= 0.25 && brightnessScore <= 0.75
    brightnessNormalized = 1;
else
    brightnessNormalized = 0.5;
end

% FOV score
if fovRatio >= 0.50
    fovNormalized = 1;
elseif fovRatio >= 0.30
    fovNormalized = 0.5;
else
    fovNormalized = 0;
end

%% Overall quality score

qualityScore = ...
    0.4 * focusNormalized + ...
    0.3 * brightnessNormalized + ...
    0.3 * fovNormalized;

%% Decide image quality

if qualityScore >= 0.70

    status = "Good";

elseif qualityScore >= 0.45

    status = "Borderline";

else

    status = "Reject";

end

%% Store results

result.status = status;
result.score = qualityScore;
result.focus = focusScore;
result.brightness = brightnessScore;
result.fov = fovRatio;

end