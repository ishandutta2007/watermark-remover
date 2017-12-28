clear;

initialImagesPath = '../watermark-creator/resources/watermarked-images-small';
initialWatermarkPositionListPath = '../watermark-creator/resources/watermark-position.txt';
watermarkSize = [623 134];

delta_W_lower_m_upper_path = compute_delta_W_lower_m_upper(initialImagesPath, initialWatermarkPositionListPath, watermarkSize);

