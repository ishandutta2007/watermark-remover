# -*- coding: utf-8 -*-

import cv2
import os


def load_images(imgs_path):
    assert os.path.exists(imgs_path), "Image path is not exists"
    imgs_path = os.path.abspath(imgs_path)
    imgs = [cv2.imread(os.path.join(imgs_path, img_path)) for img_path in os.listdir(imgs_path)]
    return imgs
