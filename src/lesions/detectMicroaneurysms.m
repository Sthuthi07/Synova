function detectedMask = detectMicroaneurysms(I)
% detectMicroaneurysms
% Baseline microaneurysm candidate detector.

%% 1. Green channel

if size(I,3) == 3
    greenChannel = I(:,:,2);
else
    greenChannel = I;
end

greenChannel = im2double(greenChannel);

%% 2. Contrast enhancement

enhancedImage = adapthisteq(greenChannel);

%% 3. Retinal region

retinaMask = enhancedImage > 0.05;

retinaMask = imfill(retinaMask, 'holes');

retinaMask = bwareafilt(retinaMask, 1);

%% 4. Detect small dark features

se = strel('disk', 4);

darkFeatures = imbothat(enhancedImage, se);

darkFeatures = mat2gray(darkFeatures);

%% 5. Adaptive threshold

retinalPixels = darkFeatures(retinaMask);

threshold = prctile(retinalPixels, 98.5);

candidateMask = darkFeatures > threshold;

%% 6. Keep only retina

candidateMask = candidateMask & retinaMask;

%% 7. Create vessel mask

vesselMask = createVesselMask(I);

%% 8. Remove vessel regions

candidateMask(vesselMask) = false;

%% 9. Remove tiny noise

candidateMask = bwareaopen(candidateMask, 2);

%% 10. Connected components

CC = bwconncomp(candidateMask);

stats = regionprops(CC, ...
    'Area', ...
    'Eccentricity', ...
    'Solidity');

%% 11. Shape filtering

cleanMask = false(size(candidateMask));

for k = 1:length(stats)

    area = stats(k).Area;
    eccentricity = stats(k).Eccentricity;
    solidity = stats(k).Solidity;

    if area >= 2 && ...
       area <= 50 && ...
       eccentricity < 0.90 && ...
       solidity > 0.45

        cleanMask(CC.PixelIdxList{k}) = true;

    end

end

%% Final result

detectedMask = cleanMask;

end