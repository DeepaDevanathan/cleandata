The assignment is about only one script run_analysis.R

run_analysis.R starts with setting the working directory. Ensure that you
source this file inside the folder "UCI HAR Dataset" containing the test and 
train data sets.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

In the end, it gives as an output 2 csv files.
Combined_data.csv --> combines test and training data
good_data_set.csv --> selectively takes the mean and standard deviations of each sample

The data was acquired from the study conducted and published as follows:

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
 
