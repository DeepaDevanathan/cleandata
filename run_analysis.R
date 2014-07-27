# run_analysis.R that does the following:
# Set working directory
setwd("/Users/draghun/Documents/Coursera/Getting and Cleaning Data/data")

# There are 2 directories here "test" & "train" where 'train/X_train.txt' is Training set
# and 'train/y_train.txt' is Training labels. Similarly 'test/X_test.txt' is Test set and
# 'test/y_test.txt' is Test labels. Data consists of the values, test labels and subject id.

# 1. Merge the training and the test sets to create one data set.
# Read training data
training_data<-read.csv("UCI HAR Dataset/train/X_train.txt",sep="", header=FALSE)
# There are 561 columns, now add training data label in the 562nd column
training_data[,562]<-read.csv("UCI HAR Dataset/train/Y_train.txt", sep="", header=FALSE)
# Now add subject id in the 563rd column
training_data[,563]<-read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE)
# Do the same for the test data
test_data<-read.csv("UCI HAR Dataset/test/X_test.txt",sep="", header=FALSE)
test_data[,562]<-read.csv("UCI HAR Dataset/test/Y_test.txt", sep="", header=FALSE)
test_data[,563]<-read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE)

# Read in features
feature_label<-read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)

# Now merge the test and training data using rbind
combined_test_training_data<-rbind(training_data, test_data)
write.csv(combined_test_training_data, "combined_data.csv", sep="\t")

# Part 1 done

# 2. Extract only the measurements on the mean and standard deviation for each measurement
# from the combined merged data
# To get the columns we want use the grep function to get all columns having "mean" or "std"
required_columns<-grep(".*mean.*|.*std.*", feature_label[,2])
# Modify the feature labels to include the relevant columns
feature_label<-feature_label[required_columns,]

# The Column numbers we now want are in required_columns and column number 562 and 563 i.e. 
# data label and subject id
required_columns<-c(required_columns,562,563)
# Using the definition of required_columns, now remove all the columns that are not required from merged data
combined_test_training_data<-combined_test_training_data[,required_columns]


# Part 2 done

# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive variable names. 
# Read in the activity labels
activity_label<-read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE)
colnames(combined_test_training_data) <- c(feature_label$V2,"activity","subject")

# Now write a for loop with a global substitution (gsub) that replaces the activity number with descriptive activity
# in the combined merged dataset

current_activity = 1
for (current_activity_label in activity_label$V2) {
  combined_test_training_data$activity<-gsub(current_activity, current_activity_label, combined_test_training_data$activity)
  current_activity<-current_activity+1
}
# assigning the activity and subjects
combined_test_training_data$activity<-as.factor(combined_test_training_data$activity)
combined_test_training_data$subject<-as.factor(combined_test_training_data$subject)

# Part 3 and Part 4 done

# 5. Create a second, independent tidy data set with the average of each variable for each 
#   activity and each subject.

good_data_set <- aggregate(
  combined_test_training_data, 
  by=list(activity = combined_test_training_data$activity, subject=combined_test_training_data$subject), mean)

# The last 2 columns have average/mean of activity and subjects which is not defined NA, so remove them
# How many columns?
ncol(good_data_set)
good_data_set[,83] = NULL
good_data_set[,82] = NULL
write.csv(good_data_set, "good_data_set.csv", sep="\t")

# Part 5 done