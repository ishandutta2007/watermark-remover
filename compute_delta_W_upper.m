function delta_W_upper = compute_delta_W_upper(imagePath)
delta_W_upper = 1;

% load all images name
imageFiles = dir(imagePath);

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
        display(currentFilename);
        matchingTargetImg = imread(fullfile(imagePath, currentFilename));
        watermark_estimate_pos = [0 0 623 134];
        watermark_estimate_img = imcrop(matchingTargetImg, watermark_estimate_pos);
        
        redWMC = edge(watermark_estimate_img(:,:,1),'Canny', 0.1); % Red channel
        greenWMC = edge(watermark_estimate_img(:,:,2),'Canny', 0.1); % Green channel
        blueWMC = edge(watermark_estimate_img(:,:,3),'Canny', 0.1); % Blue channel
        
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


% comput median
% for i=1:5
%     tmpImgFiles = dir('tmp');
%     nTmpFiles = length(tmpImgFiles);
%     tmpImgList = zeros(nTmpFiles, 433, 650, 3);
%     count = 1;
%     for jj=1:nTmpFiles
%         if ~tmpImgFiles(jj).isdir
%             img = imread(fullfile('tmp', tmpImgFiles(jj).name));
%             tmpImgList(count,:,:,:) = img;
%             count = count + 1;
%         end
%     end
% 
%     redMedian = median(tmpImgList(:,:,:,1));
%     greenMedian = median(tmpImgList(:,:,:,2));
%     blueMedian = median(tmpImgList(:,:,:,3));
% 
%     disp(size(redMedian(1, :, :, :)));
%     disp(size(cat(4, redMedian(1, :, :), greenMedian(1, :, :), blueMedian(1, :, :))));
%     figure(1);
%     W = cat(4, redMedian(1, :, :), greenMedian(1, :, :), blueMedian(1, :, :));
%     imshow(squeeze(W(1,:,:,:)));
% end
%figure(1);
%imshow(cat(3, redMedian(1), greenMedian(1), blueMedian(1)));

end