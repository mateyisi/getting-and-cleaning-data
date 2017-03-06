
pathToData<-"~/Documents/Projects/getting_and_cleaning_data/data"# give path to the directry where sumsung data is stored 

library(stringr)
library(data.table)
library(tables)
library(dplyr)

getMergedData <-function(path){
  
  "
  The function take the path to the working director where the downloaded data is saved as an input
  It then loads data from the text files for  acitivit_labels, feature as well as y_train, Y_test and X_train
  data.class
  
  It for the test and train data it combines subject, activity which then combined with the respecti x_train
  and y_train data. 
  
  The features corresponding to mean or standard deviation are selected and their indices are used to select 

  columns for needed train and test data.
  "
  
   setwd(path)
  
    # Load activity labels + features
    activityLabels <- read.table("UCI\ HAR\ Dataset/activity_labels.txt")
    activityLabels[,2] <- as.character(activityLabels[,2])
    features <- read.table("UCI\ HAR\ Dataset/features.txt")
    features[,2] <- as.character(features[,2])
    
    # get only features on mean and standard deviation
    featuresNeeded <- grep(".*mean.*|.*std.*", features[,2])
    
    featuresNeeded.names <- features[featuresNeeded,2]
    
    featuresNeeded.names = gsub('-mean', 'Mean', featuresNeeded.names)
    featuresNeeded.names = gsub('-std', 'Std', featuresNeeded.names)
    featuresNeeded.names <-gsub('[-()]', '', featuresNeeded.names)
    
  
    # Load train the datasets
    train <- read.table("UCI\ HAR\ Dataset/train/X_train.txt")
    trainActivities <- read.table("UCI\ HAR\ Dataset/train/y_train.txt")
    trainSubjects <- read.table("UCI\ HAR\ Dataset/train/subject_train.txt")
    train <- cbind(trainSubjects, trainActivities, train)
    
    # Load test the datasets
    test <- read.table("UCI\ HAR\ Dataset/test/X_test.txt")
    testActivities <- read.table("UCI\ HAR\ Dataset/test/y_test.txt")
    testSubjects <- read.table("UCI\ HAR\ Dataset/test/subject_test.txt")
    test <- cbind(testSubjects, testActivities, test)
    
    # merge datasets and add labels
    allData <- rbind(train, test)[c(1,2,featuresNeeded)]
    colnames(allData) <- c("subject", "activity", featuresNeeded.names)
    
    return(allData)
  
    }


getTidyData<-function(Allmerged){
  
  "
  -The function takes all merged data
  -Turn subject and activities into factors
  -The factor are used to melt the data
  -The tidy data of means and standard devition per subject and actity is calculated by averaging per subject
   for a given activity label.
  "
  # turn activimeanties & subjects into factors
  Allmerged$activity <- factor(Allmerged$activity, levels = activityLabels[,1], labels = activityLabels[,2])
  
  Allmerged$subject <- as.factor(Allmerged$subject)
  
  Allmerged.melted <- melt(Allmerged, id = c("subject", "activity"))
  
  Allmerged.mean <- dcast(Allmerged.melted, subject + activity ~ variable, mean)
  
  
}

Allmerged<-getMergedData(pathToData)

TidyData<-getTidyData(Allmerged)

write.table(TidyData,"submitted_tidy_data.txt",sep=" ",row.names=F)





