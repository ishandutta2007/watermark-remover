clear;

watermarkSize = [623 134];
display('Watermark size is: ', watermarkSize);

display('Importing relative project path...');
display('Importing fast-directional-chamfer-matching')
addpath(genpath('fast-directional-chamfer-matching'));

initialImagesPath = '../watermark-creator/resources/watermarked-images-small';
initialWatermarkPositionListPath = '../watermark-creator/resources/watermark-position.txt';


delta_W_lower_m_upper_path = compute_delta_W_lower_m_upper(initialImagesPath, initialWatermarkPositionListPath, watermarkSize);

fullImagesPath = '../watermark-creator/resources/watermarked-images';

test_image = fullfile(fullImagesPath, 'tumblr_luvmtr0zVS1r3rsfmo1_1280.jpg');


wins = FDCMChamferDetect(delta_W_lower_m_upper_path, test_image, 'test_result.png');
display(wins);
