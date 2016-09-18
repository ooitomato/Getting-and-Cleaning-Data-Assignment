library(reshape2)

## Download the data
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, destfile = "data.zip", method = "auto")
}

# unzip the data
if (!file.exists("UCI HAR Dataset")) { 
  unzip("data.zip") 
}

# Read activity info (labels & features) and load it to memory
actLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
actLabels[,2] <- as.character(actLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# Extract mean and standard deviation
featureGrep <- grep(".*mean.*|.*std.*", features[,2])
featureGrep.names <- features[featureGrep,2]
featureGrep.names = gsub('-mean', 'Mean', featureGrep.names)
featureGrep.names = gsub('-std', 'Std', featureGrep.names)
featureGrep.names <- gsub('[-()]', '', featureGrep.names)


# read actual data 
training <- read.table("UCI HAR Dataset/train/X_train.txt")[featureGrep]
trainingAct <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainingSub <- read.table("UCI HAR Dataset/train/subject_train.txt")
training <- cbind(trainingSub, trainingAct, training)

# read test data
test <- read.table("UCI HAR Dataset/test/X_test.txt")[featureGrep]
testAct <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSub <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSub, testAct, test)

# merge actual and test with abels
mergeData <- rbind(training, test)
colnames(mergeData) <- c("Subject", "Activity", featureGrep.names)

# turn activities & subjects into factors
mergeData$Activity <- factor(mergeData$Activity, levels = actLabels[,1], labels = actLabels[,2])
mergeData$Subject <- as.factor(mergeData$Subject)

# create a new file with data that is already being tidy up
mergeData.melted <- melt(mergeData, id = c("Subject", "Activity"))
mergeData.mean <- dcast(mergeData.melted, Subject + Activity ~ variable, mean)
write.table(mergeData.mean, "tidyData.txt", row.names = FALSE, quote = FALSE)