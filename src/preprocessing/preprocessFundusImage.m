function enhancedImage = preprocessFundusImage(I)
% preprocessFundusImage
% Prepares a retinal fundus image for further analysis.

%% 1. Resize image
targetSize = [512 512];
I = imresize(I, targetSize);

%% 2. Convert to grayscale
if size(I,3) == 3
    grayImage = rgb2gray(I);
else
    grayImage = I;
end

%% 3. Improve local contrast
enhancedImage = adapthisteq(grayImage);

%% 4. Reduce small noise
enhancedImage = medfilt2(enhancedImage, [3 3]);

end