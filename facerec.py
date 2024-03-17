import cv2
import os


# Load the pre-trained face detection model
face_cascade = cv2.CascadeClassifier(r'C:\Users\Admin\Desktop\AI PROJECT\Editing opencv_data_haarcascades_haarcascade_frontalface_default.xml at master · opencv_opencv_files')

# Initialize the webcam
cap = cv2.VideoCapture(0)
while True:
    # Read the frame from the webcam
    ret, frame = cap.read()
    # Convert the frame to grayscale
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

    # Detect faces in the frame
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))
    # Draw rectangles around the detected faces
    for (x, y, w, h) in faces:
        cv2.rectangle(frame, (x, y), (x+w, y+h), (0, 255, 0), 2)

    # Display the frame
    cv2.imshow('Face Recognition', frame)

    # Exit the loop if 'q' is pressed
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

# Release the webcam and close the window
cap.release()
cv2.destroyAllWindows()