# -*- coding: utf-8 -*-
import utils
import cv2
import numpy as np
import matplotlib.pyplot as plt

if '__main__' == __name__:
    IS_WATERMARK_FIXED = False
    img_end_index = 0

    # Input: A collection of watermarked images {J_k}.
    J = utils.load_images("./watermark-cvpr17.github.io/supplemental/123RF/image")
    img_end_index = len(J)
    # Output: Watermarked W, alpha matte {alpha}, watermark free collection {I_k}
    result = {'W': None, 'alpha': None, 'watermark_free_collection': []}

    gradient_R_x, gradient_G_x, gradient_B_x = [], [], []
    gradient_R_y, gradient_G_y, gradient_B_y = [], [], []
    gradient_R_xy, gradient_G_xy, gradient_B_xy = [], [], []

    for index in range(img_end_index):
        gradient_R_x.append(cv2.convertScaleAbs(cv2.Sobel(J[index][:, :, 0], cv2.CV_64F, 1, 0, ksize=3)))
        gradient_R_y.append(cv2.convertScaleAbs(cv2.Sobel(J[index][:, :, 0], cv2.CV_64F, 0, 1, ksize=3)))
        gradient_G_x.append(cv2.convertScaleAbs(cv2.Sobel(J[index][:, :, 1], cv2.CV_64F, 1, 0, ksize=3)))
        gradient_G_y.append(cv2.convertScaleAbs(cv2.Sobel(J[index][:, :, 1], cv2.CV_64F, 0, 1, ksize=3)))
        gradient_B_x.append(cv2.convertScaleAbs(cv2.Sobel(J[index][:, :, 2], cv2.CV_64F, 1, 0, ksize=3)))
        gradient_B_y.append(cv2.convertScaleAbs(cv2.Sobel(J[index][:, :, 2], cv2.CV_64F, 0, 1, ksize=3)))

        gradient_R_xy.append(cv2.convertScaleAbs(cv2.Sobel(J[index][:, :, 0], cv2.CV_64F, 1, 1, ksize=3)))
        gradient_G_xy.append(cv2.convertScaleAbs(cv2.Sobel(J[index][:, :, 1], cv2.CV_64F, 1, 1, ksize=3)))
        gradient_B_xy.append(cv2.convertScaleAbs(cv2.Sobel(J[index][:, :, 2], cv2.CV_64F, 1, 1, ksize=3)))

        # gradient_R_xy.append(cv2.Laplacian(J[index][:, :, 0], cv2.CV_64F))
        # gradient_G_xy.append(cv2.Laplacian(J[index][:, :, 1], cv2.CV_64F))
        # gradient_B_xy.append(cv2.Laplacian(J[index][:, :, 2], cv2.CV_64F))

    median_R = np.median(gradient_R_xy, axis=0)
    median_G = np.median(gradient_G_xy, axis=0)
    median_B = np.median(gradient_B_xy, axis=0)

    result = np.empty((median_R.shape[0], median_R.shape[1], 3))
    result[:, :, 0] = median_R
    result[:, :, 1] = median_G
    result[:, :, 2] = median_B
    print np.array(result).shape
    plt.imshow(result)
    plt.show()

    # Compute initial matted watermark & detect all watermarks (Sec 3.1)


    # initialize alpha using single-image matting
    alpha = None

    # Estimate global (average) blend factor c
    c = None

    # Times for iteration
    T = 3
    # for t = 1 to T do
    for t in range(T):
        K = len(J)
        # for k = 1 to K do
        for k in range(K):
            # I. Image-Watermark Decomposition:
            # Solve for {I_k} and {W_k}, keeping alpha and fixed
            # II. Opacity Estimation (Optional):
            # Solve for small per-image variation in opacity {c_k}
            # III. Flow Estimation (Optional):
            # Solve for small per-image watermark perturbation {w_k}
            pass
        # IV. Watermark Update:
        # Solve for W keeping {{I_k}, {W_k}, {c_k}, {w_k}}, and alpha fixed.
        # IIV. Matte Update:
        # Solve for alpha keeping {{I_k}, {W_k}, {c_k}, {w_k}}, and W fixed.
