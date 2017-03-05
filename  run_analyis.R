
pathToData<-"~/Documents/Projects/getting_and_cleaning_data/data"# give path to the directry where sumsung data is stored 


library(stringr)
library(data.table)
library(tables)
library(dplyr)



getMergedData <-function(path){
  
  "-The function take the path to the working directory: This is with the assumptions that project data 
   is downloaded and stored in a location pointed by this path.
   - reads the subject data onto a table.
   - Reads the feature data tax file line by line, split each line by tab and create a numeric feature vector
     is stored in tables: (TestAverageFeatureVec, TrainAverageFeatureVec, TestSDFeatureVec  TrainSDFeatureVec).
   -The function returens Allmerged data with readable headings and categorial variables.
  
  "
  
    setwd(path)
  
    TestCon1 <- file.path("getdata_projectfiles_UCI\ HAR\ Dataset/UCI\ HAR\ Dataset/test/","subject_test.txt")
    TestCon2 <- file.path("getdata_projectfiles_UCI\ HAR\ Dataset/UCI\ HAR\ Dataset/test/","y_test.txt")


    TrainCon1 <- file.path("getdata_projectfiles_UCI\ HAR\ Dataset/UCI\ HAR\ Dataset/train/","subject_train.txt")
    TrainCon2 <- file.path("getdata_projectfiles_UCI\ HAR\ Dataset/UCI\ HAR\ Dataset/train/","y_train.txt")


    TestSubject <- read.table(file=TestCon1,sep="\t")
    setnames(TestSubject, "V1", "Subject")
    TestActivity <- read.table(file=TestCon2,sep="\t")
    setnames(TestActivity, "V1", "Activity")

    TrainSubject <- read.table(file=TrainCon1,sep="\t")
    setnames(TrainSubject, "V1", "Subject")
    TrainActivity <- read.table(file=TrainCon2,sep="\t")
    setnames(TrainActivity, "V1", "Activity")



    TestDdPath <- file.path("getdata_projectfiles_UCI\ HAR\ Dataset/UCI\ HAR\ Dataset/test/", "X_test.txt")
    TrainDdPath <- file.path("getdata_projectfiles_UCI\ HAR\ Dataset/UCI\ HAR\ Dataset/train/", "X_train.txt")

    TestFeatureVec <- strsplit(readLines(TestDdPath)," ")
    TestFeatureVec <-lapply(lapply(TestFeatureVec,as.numeric),na.exclude)

    TrainFeatureVec <- strsplit(readLines(TrainDdPath)," ")
    TrainFeatureVec <-lapply(lapply(TrainFeatureVec,as.numeric),na.exclude)

    TestAverageFeatureVec <-sapply(TestFeatureVec,mean)
    TrainAverageFeatureVec <-sapply(TrainFeatureVec,mean)

    TestSDFeatureVec <-sapply(TestFeatureVec,sd)
    TrainSDFeatureVec <-sapply(TrainFeatureVec,sd)


    MyTestData <- cbind(TestSubject,activity=TestActivity,DataCategory=rep("Test",length(TestActivity[[1]])),AverageFeatureVec=TestAverageFeatureVec,FeatureStddeviation=TestSDFeatureVec)
    MyTrainData <- cbind(TrainSubject,activity=TrainActivity,DataCategory=rep("Train",length(TrainActivity[[1]])),AverageFeatureVec=TrainAverageFeatureVec,FeatureStddeviation=TrainSDFeatureVec)

    Allmerged<-rbind(MyTestData,MyTrainData)

    
    Allmerged[,2]<- ifelse(Allmerged[,2] == 1, "WALKING_UNSPECIFIED",
                    ifelse(Allmerged[,2] == 2, "WALKING_UPSTAIRS",
                    ifelse(Allmerged[,2] == 3, "WALKING_DOWNSTAIRS",
                    ifelse(Allmerged[,2] == 4, "SITTING",
                    ifelse(Allmerged[,2] == 5, "STANDING","LAYING")))))
    
    return(Allmerged)
    
    }

Allmerged<-getMergedData(pathToData);

isInPresentActivity <-function(Allmerged,activity="WALKING_UNSPECIFIED"){
  
  "
  The funcion creates a logical vector for a given activity
  "
  
  vec <- grepl(activity, Allmerged$Activity)
  
}

getAcitvityTidyData <- function(AllMerged,activity="WALKING_UNSPECIFIED"){
      "-The function take a data frame consisting of allmerged data and activity name as inputs
       -For a given activity it calculates a effective feature mean and effective standard deviation
       - by averageing over repeated samples for each subject
       -for a specific activity it outputs a table whose columns are feature mean and effective standard deviation
        each row contains the variables per subject"
       
  
     
      lV <- isInPresentActivity(Allmerged,activity)
      
      fMeans<-sapply(split((Allmerged[lV,])$AverageFeatureVec,Allmerged[lV,1]),mean)
      fSD<-sapply(split((Allmerged[lV,])$FeatureStddeviation,Allmerged[lV,1]),mean)
      
      DataTidy <- cbind(Subject=c(1:30),FeatureMean=fMeans,FeatureStddeviation= fSD)
      
    }
    






getTidyData<-function(Allmerged){
  
  "
  -The function takes all merged data
  -put together tidy data of means and standard devition per subject
  -for each variable i.e feature mean or standard deviation it combines all activities data 
   into individual matrices.
  "
  walkingTD <- matrix(0,30, 2)
  walkingUPstairTD<- matrix(0,30, 2)
  walkingDownSairsTD <- matrix(0,30, 2)
  sittingTD <- matrix(0,30, 2)
  standingTD <- matrix(0,30, 2)
  layingTD <- matrix(0,30, 2)
  AllactivityFeaturemeanTD <- matrix(0,30, 6)
  AllactivityFeatureSTDdevTD <- matrix(0,30, 6)
  
  walkingTD <- getAcitvityTidyData(Allmerged,"WALKING_UNSPECIFIED")
  walkingUPstairTD <- getAcitvityTidyData(Allmerged,"WALKING_UPSTAIRS")
  walkingDownSairsTD <- getAcitvityTidyData(Allmerged,"WALKING_DOWNSTAIRS")
  sittingTD <- getAcitvityTidyData(Allmerged,"SITTING")
  standingTD <- getAcitvityTidyData(Allmerged,"STANDING")
  layingTD <- getAcitvityTidyData(Allmerged,"LAYING")
  
  AllactivityFeaturemeanTD <-cbind(Subject=walkingTD[,1],WALKING_UNSPECIFIED=walkingTD[,2],
                                 WALKING_UPSTAIRS=walkingUPstairTD[,2],
                                 WALKING_DOWNSTAIRS=walkingDownSairsTD[,2],
                                 SITTING=sittingTD[,2],
                                 STANDING=standingTD[,2],LAYING=layingTD[,2])
  
  AllactivityFeatureSTDdevTD <-cbind(Subject=walkingTD[,1],WALKING_UNSPECIFIED=walkingTD[,3],
                                   WALKING_UPSTAIRS=walkingUPstairTD[,3],
                                   WALKING_DOWNSTAIRS=walkingDownSairsTD[,3],
                                   SITTING=sittingTD[,3],
                                   STANDING=standingTD[,3],LAYING=layingTD[,3])
 
  
  TD1<-as.data.frame.matrix(AllactivityFeaturemeanTD,ID=AllactivityFeaturemeanTD)
  TD2<-as.data.frame.matrix(AllactivityFeatureSTDdevTD)
  TD <- left_join(TD1,TD2, by = "Subject")
  setnames(TD, names(TD),sub(".x",".mn",names(TD)))
  setnames(TD, names(TD),sub(".y",".sd",names(TD)))
  

}

TidyData<-getTidyData(Allmerged)

#write.table(Allmerged,"submitted_combined_clean_data.txt",sep="\t",row.names=F)
write.table(TidyData,"submitted_tidy_data.txt",sep="\t\t",row.names=F)





