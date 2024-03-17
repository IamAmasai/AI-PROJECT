import os

# Check if the Haar Cascade file exists
if os.path.exists('haarcascade_frontalface_default(1).xml'):
    print("Haar Cascade file exists.")
else:
    print("Haar Cascade file does not exist.")
    