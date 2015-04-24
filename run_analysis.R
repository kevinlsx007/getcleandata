# Create a folder to store the R script and the data sets
setwd("C:/Users/Public")
if(!file.exists("./getcleandata")){dir.create("./getcleandata")}

# Change the working directory
setwd("./getcleandata")

# Download file and unzip the data sets
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="Dataset.zip")
library(utils)
unzip("Dataset.zip")

# Read data sets
features <- read.table("C:/Users/Public/getcleandata/UCI HAR Dataset/features.txt")
actlabels <- read.table("C:/Users/Public/getcleandata/UCI HAR Dataset/activity_labels.txt")

subtrain <- read.table("C:/Users/Public/getcleandata/UCI HAR Dataset/train/subject_train.txt")
acttrain <- read.table("C:/Users/Public/getcleandata/UCI HAR Dataset/train/y_train.txt")
datatrain <- read.table("C:/Users/Public/getcleandata/UCI HAR Dataset/train/X_train.txt")

subtest <- read.table("C:/Users/Public/getcleandata/UCI HAR Dataset/test/subject_test.txt")
acttest <- read.table("C:/Users/Public/getcleandata/UCI HAR Dataset/test/y_test.txt")
datatest <- read.table("C:/Users/Public/getcleandata/UCI HAR Dataset/test/X_test.txt")

# Merge the subject and activity data sets & set the column names
subject <- rbind(subtrain,subtest)
colnames(subject) <- "subject"

activity <- rbind(acttrain,acttest)
# Merge activity data with activity labels so that activities are labeled by
# characters instead of numbers 1:6. Then convert activity labels to factors
activity <- merge(activity,actlabels,by="V1",sort=FALSE)
activity <- data.frame(activity[,2])
activity[,1] <- tolower(gsub("_"," ",activity[,1]))
activity[,1] <- factor(activity[,1], levels=c("walking","walking upstairs",
                "walking downstairs","sitting","standing","laying"))
colnames(activity) <- "activity"

# Merge measurements from training and test data sets
measure <- rbind(datatrain,datatest)

# Set the column names of measurements using features file
colnames(measure) <- features[,2]

# Subtract only the measurements on the mean and standard deviation
meanstd <- measure[,grepl("mean|std",colnames(measure))]

# Combine subject, activity, and meanstd to form the final tidy data set
df <- cbind(subject,activity,meanstd)
# Convert subject column to factor
df$subject <- factor(df$subject)

# Creates a second, independent tidy data set with the average of each variable 
# for each activity and each subject
library(plyr)
dfaverage <- ddply(df,.(subject,activity),numcolwise(mean))

# Save the dfaverage data as a .txt file
write.table(dfaverage,file="average.txt",row.names=FALSE)
