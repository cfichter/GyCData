#setwd("~/Varios Cristian/Coursera/R/3-Getting and cleaning data")

# Step1. Merges the training and the test sets to create one data set.
#read train files
trainData <- read.table("./data/train/X_train.txt")
trainLabel <- read.table("./data/train/y_train.txt")
trainSubject <- read.table("./data/train/subject_train.txt")

#read test files
testData <- read.table("./data/test/X_test.txt")
testLabel <- read.table("./data/test/y_test.txt")
testSubject <- read.table("./data/test/subject_test.txt")

#bind data, label and subject files
joinData <- rbind(trainData, testData)
joinLabel <- rbind(trainLabel, testLabel)
joinSubject <- rbind(trainSubject, testSubject)

# Step2. Extracts only the measurements on the mean and standard
# deviation for each measurement.
#read features names
features <- read.table("./data/features.txt")
#collect indices for features of interest 
indices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
#preserve only the measurements for these indices
joinData <- joinData[, indices]
#redefine variables names
names(joinData) <- gsub("\\(\\)", "", features[indices, 2]) # remove '()'
names(joinData) <- gsub("mean", "Mean", names(joinData)) # replace m by M in 'mean'
names(joinData) <- gsub("std", "Std", names(joinData)) # replace s by S in 'std'
names(joinData) <- gsub("-", "", names(joinData)) # remove '-' in columns names

# Step3. Uses descriptive activity names to name the activities in
# the data set
#read activities
activity <- read.table("./data/activity_labels.txt")
#redefine variables names, removing underscores and capitalizing compound activities  
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinLabel[, 1], 2]
joinLabel[, 1] <- activityLabel
names(joinLabel) <- "activity"

# Step4. Appropriately labels the data set with descriptive variable names. 
names(joinSubject) <- "subject"
cleanedData <- cbind(joinSubject, joinLabel, joinData)
#save clean full data
fileName <- file.path(getwd(), "merged_data_full.txt")
write.table(cleanedData, fileName, row.names=FALSE)

# Step5. From the data set in step 4, creates a second,
#independent tidy data set with the average of each variable
#for each activity and each subject.
library(dplyr) #for filtering

subjectLen <- length(table(joinSubject))
activityLen <- dim(activity)[1]
columnLen <- dim(cleanedData)[2]
tidyData <- matrix(NA, nrow=subjectLen*activityLen, ncol=columnLen)
tidyData <- as.data.frame(tidyData)
colnames(tidyData) <- colnames(cleanedData)
currentRow <- 1

for(i in 1:subjectLen) {
  for(j in 1:activityLen) {
    currentSubject <- i
    currentActivity <- activity[j,2]  
    subjectActivitySet <- filter(cleanedData,
                                 (subject == currentSubject) &
                                   (activity == currentActivity))
    tidyData[currentRow,1] <- currentSubject
    tidyData[currentRow,2] <- currentActivity
    tidyData[currentRow,3:columnLen] <- colMeans(subjectActivitySet[ ,3:columnLen])
    currentRow <- currentRow + 1
    
  }
}
#save data
fileName <- file.path(getwd(), "tidy_data_means.txt")
write.table(tidyData, fileName, row.names=FALSE)
