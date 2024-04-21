import cv2
import numpy as np


image_height = 128
image_width = 128

# Load the image
image = cv2.imread('../Images/1.png')

padded_image = np.zeros((image_height + 2, image_width + 2))

# Padding the image
for i in range(image_height):
    for j in range(image_width):
        padded_image[i + 1][j + 1] = image[i][j]

#applying image smoothing
for i in range(image_height):
    for j in range(image_width):
        image[i][j] = np.mean(image[i][j])