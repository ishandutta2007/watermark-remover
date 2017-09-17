# -*- coding: utf-8 -*-


if '__main__' == __name__:
    # Input: A collection of watermarked images {J_k}.
    J = {}
    # Output: Watermarked W, alpha matte {alpha}, watermark free collection {I_k}
    result = {'W': None, 'alpha': None, 'watermark_free_collection': []}

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
