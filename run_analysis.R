     
## Step1 Merge the two datasets in one

dirTest<-"dataset/test/"
dirTrain<-"dataset/train/"
     
X_test<-read.table(paste(dirTest,"X_test.txt",sep = ""), header=TRUE)
X_train<-read.table(paste(dirTrain,"X_train.txt",sep = ""), header=TRUE)
colnames(X_test)=colnames(X_train)
X<-rbind(X_test,X_train)
     
y_test<-read.table(paste(dirTest,"y_test.txt",sep = ""), header=TRUE)
y_train<-read.table(paste(dirTrain,"y_train.txt",sep = ""), header=TRUE)
colnames(y_test)=colnames(y_train)
y<-rbind(y_test,y_train)
     
subject_test<-read.table(paste(dirTest,"subject_test.txt",sep = ""), header=TRUE)
subject_train<-read.table(paste(dirTrain,"subject_train.txt",sep = ""), header=TRUE)
colnames(subject_test)=colnames(subject_train)
subject<-rbind(subject_test, subject_train)
    
   
dataset<-cbind(subject,y,X) ## Final dataset

## Step2 Extracts only the measurements on the mean 
## and standard deviation for each measurement


features<-read.table("dataset/features.txt") 
selcolumns<-grep("mean|std",features$V2)    ##select the  columns with means and std

    
dataset<-cbind(subject,y,X[,selcolumns])

## step3 Uses descriptive activity names to name the activities in the data set

actVector<-c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")

for(i in 1:nrow(dataset)){
    dataset[i,2]<-actVector[as.numeric(dataset[i,2])]
    
}



## step4 Appropriately labels the data set with descriptive variable names. 

colnames(dataset)[1]<-"subjectID"
colnames(dataset)[2]<-"Activity"
for(i in 3:ncol(dataset))
{
    colnames(dataset)[i] <-  as.character(features$V2[selcolumns[i-2]])
}

for(i in 3:ncol(dataset))
{
    names(dataset)[i]<-  sub("()-",".", names(dataset)[i], fixed = TRUE)
    names(dataset)[i]<-  sub("-",".", names(dataset)[i], fixed = TRUE)
}


## step5 From the data set in step 4, creates a second, independent tidy data set with the average 
## of each variable for each activity and each subject.

library(reshape2)

tidyDataset <- dcast(dataset, subjectID + Activity ~ variable.names(dataset[,3:ncol(dataset)]), mean)

