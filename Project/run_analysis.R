## This R scipt:
## 1 Merges the training and the test sets to create one data set.
## 2 Extracts only the measurements on the mean and standard deviation for each measurement.
## 3 Uses descriptive activity names to name the activities in the data set
## 4 Appropriately labels the data set with descriptive variable names.
## 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

## This function performs the steps proviede above
analysisRun <- function(){
        ## Get data, create, and place in data folder with the use of correct files
        if(!file.exists("./data")){
                dir.create("./data")
        }
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl,destfile="./data/Dataset.zip")
        unzip(zipfile="./data/Dataset.zip",exdir="./data")
        dataSetDirectory <- file.path("./data" , "UCI HAR Dataset")
        files<-list.files(dataSetDirectory)
        
        ## Get the info from the x and y train and test sets to be read
        datasetActivityTrain <- read.table(file.path(dataSetDirectory, "train", "Y_train.txt"))
        datasetSubjectTrain <- read.table(file.path(dataSetDirectory, "train", "subject_train.txt"))
        datasetFeaturesTrain <- read.table(file.path(dataSetDirectory, "train", "X_train.txt"))
        datasetActivityTest  <- read.table(file.path(dataSetDirectory, "test" , "Y_test.txt" ))
        datasetSubjectTest  <- read.table(file.path(dataSetDirectory, "test" , "subject_test.txt"))
        datasetFeaturesTest  <- read.table(file.path(dataSetDirectory, "test" , "X_test.txt" ))
        
        
        ## Merge the training and testing set
        dSubject <- rbind(datasetSubjectTrain, datasetSubjectTest)
        dActivity<- rbind(datasetActivityTrain, datasetActivityTest)
        dFeatures<- rbind(datasetFeaturesTrain, datasetFeaturesTest)
        names(dSubject)<-c("subject")
        names(dActivity)<- c("activity")
        datasetFeaturesNames <- read.table(file.path(dataSetDirectory, "features.txt"))
        names(dFeatures)<- datasetFeaturesNames$V2
        mainData <- cbind(dFeatures, cbind(dSubject, dActivity))
        
        ## Extracts only the measurements on the mean and standard deviation for each measurement
        subdatasetFeaturesNames<-datasetFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", datasetFeaturesNames$V2)]
        meanStdNames<-c(as.character(subdatasetFeaturesNames), "subject", "activity" )
        mainData<-subset(mainData,select=meanStdNames)
        
        ## Uses descriptive activity names to name the activities in the data set
        activityLabels <- read.table(file.path(dataSetDirectory, "activity_labels.txt"))
        head(mainData$activity,30)
        
        ## Appropriately labels the data set with descriptive variable names
        names(mainData)<-gsub("^t", "time", names(mainData))
        names(mainData)<-gsub("^f", "frequency", names(mainData))
        names(mainData)<-gsub("Acc", "Accelerometer", names(mainData))
        names(mainData)<-gsub("Gyro", "Gyroscope", names(mainData))
        names(mainData)<-gsub("Mag", "Magnitude", names(mainData))
        names(mainData)<-gsub("BodyBody", "Body", names(mainData))
        
        ## From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
        independentDataSet<-aggregate(. ~subject + activity, mainData, mean)
        independentDataSet<-independentDataSet[order(independentDataSet$subject,independentDataSet$activity),]
        write.table(independentDataSet, file = "tidy.txt",row.name=FALSE)
}