# Aim of the "run_analysis.R" script:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive activity names.
# 5. Creates a second, independent tidy data set "tidy_data_set.txt" with the average of each variable for each activity and each subject.

# Test the required packages
if (!require("data.table"))
{
    install.packages("data.table")
}

if (!require("reshape2"))
{
    install.packages("reshape2")
}

# Load the required packages
require("data.table")
require("reshape2")

# Read the activity labels
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# Read the features
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Extract the mean and standard deviation features
extractFeatures <- grepl("mean|std", features)

# Read the "X" & "y" and "subject" test data sets
xTest <- read.table("./UCI HAR Dataset/test/x_test.txt")
yTest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjectTest <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# Stores the names of the features
names(xTest) <- features

# Extract only the measurements on the mean and standard deviation for each measurement of the test data set
xTest <- xTest[,extractFeatures]

# Read the activity labels
yTest[,2] <- activityLabels[yTest[,1]]

# Create the column names for the test data
names(yTest) <- c("Activity_ID", "Activity_Label")
names(subjectTest) <- "subject"

# Bind the test data
testDataSet <- cbind(as.data.table(subjectTest), yTest, xTest)

# Read the "X" & "y" and "subject" train data sets
xTrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
yTrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjectTrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")

# Stores the names of the features
names(xTrain) <- features

# Extract only the measurements on the mean and standard deviation for each measurement of the train data set
xTrain <- xTrain[,extractFeatures]

# Read the activity labels
yTrain[,2] <- activityLabels[yTrain[,1]]

# Create the column names for the train data
names(yTrain) <- c("Activity_ID", "Activity_Label")
names(subjectTrain) <- "subject"

# Bind the train data
trainDataSet <- cbind(as.data.table(subjectTrain), yTrain, xTrain)

# Merge the test and train data sets
mergedDataSet = rbind(testDataSet, trainDataSet)

# Configure the variables for the melt
# id_columns : "subject", "Activity_ID" and "Activity_Label"
# dataLabels: the other columns
idLabels <- c("subject", "Activity_ID", "Activity_Label")
dataLabels <- setdiff(colnames(mergedDataSet), idLabels)

# Melt the data set
meltDataSet <- melt(mergedDataSet, id = idLabels, measure.vars = dataLabels)

# Apply the "mean" function to dataset using "dcast" function
# Calculates the average of each variable for each activity and each subject.
tidyDataSet <- dcast(meltDataSet, subject + Activity_Label ~ variable, mean)

# Finaly create the "tidy_data_set.txt" file with tabulation separator
write.table(tidyDataSet, file = "./tidy_data_set.txt", sep="\t")
