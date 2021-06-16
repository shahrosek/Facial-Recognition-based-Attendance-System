How to run:
1. Simply run solution.m:
 It uses folders: STUDENT1, STUDENT2, STUDENT3 as the dataset. Make sure all these folders are in the same directory as the code.
2. Webcam will open and it will take the picture of the test subject in front of it. If the user is in either of the datasets, it will classify him as present.
3. Dependency: I have used MATLAB as the development environment to achieve this task. The system running this code must have MATLAB installed.
6. Training Set:
Includes 3 types of classes which are 15 images of student 1. 15 images of student 2. 15 images of student 3.
7. Test Case:
I have used “extractHOGFeatures()”, to detect the current state, of the test object, against the trained set. The camera would take the picture of the whole face. Match the features against the images in the dataset STUDENT1, STUDENT2, STUDENT3 using the algorithm for Support Vector Machines. If the features match, the student (test object) will be marked present.
9. extractHOGFeatures:
I have used this functions as (features = extractHOGFeatures(img)) which would return extracted Histogram of Gradient features from a grayscale input image, img. The features are returned in a 1-by-N vector, where N is the HOG feature length. The returned features encode local shape information from regions within an image. I have used this information for classification.
