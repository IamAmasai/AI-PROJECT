import cv2
import numpy as np

# Create a black image
image = np.zeros((500,500,3), np.uint8)

# Display the image in a window named 'test'
cv2.imshow('test', image)

# Wait for any key to be pressed and then close all windows
cv2.waitKey(0)
cv2.destroyAllWindows()
