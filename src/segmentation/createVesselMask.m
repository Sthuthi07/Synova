function vesselMask = createVesselMask(I)
% createVesselMask
% Creates a baseline retinal blood-vessel mask.

%% 1. Use green channel

if size(I,3) == 3
    greenChannel = I(:,:,2);
else
    greenChannel = I;
end

greenChannel = im2double(greenChannel);

%% 2. Create retinal field mask

grayImage = rgb2gray(I);
grayImage = im2double(grayImage);

retinaMask = grayImage > 0.05;

retinaMask = imfill(retinaMask, 'holes');

retinaMask = bwareafilt(retinaMask, 1);

%% 3. Enhance local contrast

greenEnhanced = adapthisteq(greenChannel);

%% 4. Detect dark line structures

% Blood vessels are dark compared with nearby retinal tissue.

se = strel('disk', 8);

darkVesselFeatures = imbothat(greenEnhanced, se);

darkVesselFeatures = mat2gray(darkVesselFeatures);

%% 5. Adaptive threshold

retinalPixels = darkVesselFeatures(retinaMask);

threshold = prctile(retinalPixels, 97);

vesselMask = darkVesselFeatures > threshold;

%% 6. Keep only retina

vesselMask = vesselMask & retinaMask;

%% 7. Remove very small noise

vesselMask = bwareaopen(vesselMask, 10);

%% 8. Slightly connect broken vessel regions

vesselMask = imclose(vesselMask, strel('disk', 1));

end