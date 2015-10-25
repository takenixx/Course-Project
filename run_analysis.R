## Course Project
## 25 Ocotber 2015 by Yusuke Takeuchi

getwd()
setwd("/Users/bamboomeat/Documents/R/Coursera/Getting and Cleaning Data/Course Project")

# if(!file.exists("./data")){
#     dir.create("./data")
# }

# fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
# download.file(fileUrl, destfile = "./data/pjdataset.zip",method = "curl")

# unzip(zipfile = "./data/pjdataset.zip", exdir = "./data")

#-------------------------------------------------------------------------------
#
# start of this code
#
#-------------------------------------------------------------------------------

pjfile_path <- file.path("./data", "UCI HAR Dataset")
files <- list.files(pjfile_path, recursive = TRUE) 

# read activity files
dataActivityTest <- read.table(file.path(pjfile_path,"test","Y_test.txt"), header = FALSE)
dataActivityTrain <- read.table(file.path(pjfile_path, "train", "Y_train.txt"), header = FALSE)

# read subject files
dataSubjectTest <- read.table(file.path(pjfile_path,"test","subject_test.txt"), header = FALSE)
dataSubjectTrain <- read.table(file.path(pjfile_path, "train", "subject_train.txt"), header = FALSE)

# read feature files
dataFeatureTest <- read.table(file.path(pjfile_path, "test", "X_test.txt"), header = FALSE)
dataFeatureTrain <- read.table(file.path(pjfile_path, "train", "X_train.txt"), header = FALSE)

# str(dataActivityTest)
# str(dataActivityTrain)
# str(dataSubjectTest)
# str(dataSubjectTrain)
# str(dataFeatureTest)
# str(dataFeatureTrain)

# merge files
dataActivity <- rbind(dataActivityTest, dataActivityTrain)
dataSubject <- rbind(dataSubjectTest, dataSubjectTrain)
dataFeature <- rbind(dataFeatureTest,dataFeatureTrain)

# name vectors

names(dataActivity) <- c("Activity")
names(dataSubject) <- c("Subject")
names_feature <- read.table(file.path(pjfile_path,"features.txt"), header = FALSE)
names(dataFeature) <- names_feature$V2

data1 <- cbind(dataActivity,dataSubject)
dataAll <- cbind(data1, dataFeature)


criteria1 <- names_feature$V2[grep("mean()|std()",names_feature$V2)]
# setdiff(criteria1, grep("meanFreq()", criteria1))
criteria1 <- criteria1[-c(grep("meanFreq()", criteria1))]

# as.character(criteria1)
criteria2 <- c("Activity","Subject",as.character(criteria1))
dataNew <- subset(dataAll, select = criteria2) 

# str(dataNew)
labelActivity <- read.table(file.path(pjfile_path,"activity_labels.txt"))

# replance number with activity label
dataNew$Activity <- gsub(1,"WALKING",dataNew$Activity)
dataNew$Activity <- gsub(2,"WALKING_UPSTAIRS",dataNew$Activity)
dataNew$Activity <- gsub(3,"WALKING_DOWNSTAIRS",dataNew$Activity)
dataNew$Activity <- gsub(4,"SITTING",dataNew$Activity)
dataNew$Activity <- gsub(5,"STANDING",dataNew$Activity)
dataNew$Activity <- gsub(6,"LAYING",dataNew$Activity)

# modify header 
names(dataNew) <- gsub("^t", "time", names(dataNew))
names(dataNew) <- gsub("^f", "frequnecy", names(dataNew))
names(dataNew) <- gsub("Acc", "Accelerometer", names(dataNew))
names(dataNew) <- gsub("Gyro", "Gyroscope", names(dataNew))
names(dataNew) <- gsub("Mag","Magnitude",names(dataNew))
names(dataNew) <- gsub("BodyBody", "Body", names(dataNew))

# str(dataNew)
# names(dataNew)

library(plyr)

## S3 method for class 'formula'
## aggregate(formula, data, FUN, ..., subset, na.action = na.omit)

dataNew <- aggregate(.~Subject + Activity, dataNew, mean)
dataNew <- dataNew[order(dataNew$Subject,dataNew$Activity),]
write.table (dataNew, file = "tidydata.txt", row.names = FALSE)

#-------------------------------------------------------------------------------
#
# end of this code
#
#-------------------------------------------------------------------------------
