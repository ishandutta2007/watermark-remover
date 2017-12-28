function deltaWLowerMUpperPath = compute_delta_W_lower_m_upper(imagesPath, watermarkPosListPath, watermarkSize,isRecomputeGradient,isShow)

% calc all initial image gardient
display('calculating all initial image gardient...')
if exist('isRecomputeGradient','var')
    % load all images name
    imageFiles = dir(imagesPath);
    % the number of training files
    nfiles = length(imageFiles);
    % init the array of image
    count = 1;
    for ii=1:nfiles
        if ~imageFiles(ii).isdir
            currentFilename = imageFiles(ii).name;
            if strcmp(currentFilename, '.DS_Store')
                continue;
            end
            matchingTargetImg = imread(fullfile(imagesPath, currentFilename));
            watermarkEstimatePos = cat(2, [0 0], watermarkSize);
            watermarkEstimateImg = imcrop(matchingTargetImg, watermarkEstimatePos);

            redWMC = edge(watermarkEstimateImg(:,:,1),'Canny', 0.1); % Red channel
            greenWMC = edge(watermarkEstimateImg(:,:,2),'Canny', 0.1); % Green channel
            blueWMC = edge(watermarkEstimateImg(:,:,3),'Canny', 0.1); % Blue channel

            % calc the gradient of the watermark
            [gx, gy] = imgradientxy(redWMC,'prewitt');
            [redGmag, redGdir] = imgradient(gx, gy);
            [gx, gy] = imgradientxy(greenWMC,'prewitt');
            [greenGmag, greenGdir] = imgradient(gx, gy);
            [gx, gy] = imgradientxy(blueWMC,'prewitt');
            [blueGmag, blueGdir] = imgradient(gx, gy);

            imwrite(cat(3, redGmag, greenGmag, blueGmag), strcat('tmp/', strcat(int2str(count), '.png')));

            count = count + 1;
        end
    end
end
    
% comput median
display('calculating delta_W_lower_m_upper (median) from all initial image gardient...')
tmpImgFiles = dir('tmp');
nTmpFiles = length(tmpImgFiles);
tmpImgList = zeros(nTmpFiles, 134, 623, 3);
count = 1;
for jj=1:nTmpFiles
    if ~tmpImgFiles(jj).isdir
        img = imread(fullfile('tmp', tmpImgFiles(jj).name));
        tmpImgList(count,:,:,:) = img;
        count = count + 1;
    end
end

redMedian = median(tmpImgList(:,:,:,1));
greenMedian = median(tmpImgList(:,:,:,2));
blueMedian = median(tmpImgList(:,:,:,3));

W = cat(4, redMedian(1, :, :), greenMedian(1, :, :), blueMedian(1, :, :));
deltaWLowerMUpper = squeeze(W(1,:,:,:));
if exist('isShow','var')
    imshow(deltaWLowerMUpper);
    figure(1);
end
deltaWLowerMUpperPath = 'delta_W_lower_m_upper.png';
imwrite(deltaWLowerMUpper, deltaWLowerMUpperPath);
end