#Access and download the dataset and put all files in a dircroty called "data"
if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")

#unzip the file put it in the data directory 

unzip(zipfile="./data/Dataset.zip",exdir="./data")

#Get the list of files from the unzipped folder called UCI HAR Dataset 
getwd()
path_rf <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path_rf, recursive=TRUE)
files
# Read data from the files into the variables
## readactivity files
dataActivityTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ),header = FALSE)
dataActivityTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"),header = FALSE)
## read the subject files
dataSubjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"),header = FALSE)
dataSubjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"),header = FALSE)

## read feature files
dataFeaturesTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ),header = FALSE)
dataFeaturesTrain <- read.table(file.path(path_rf, "train", "X_train.txt"),header = FALSE)

#Merges the training and the test sets to create one data set
## first we concatenate the data tables by rows

dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
dataActivity<- rbind(dataActivityTrain, dataActivityTest)
dataFeatures<- rbind(dataFeaturesTrain, dataFeaturesTest)

#set names of variables
names(dataSubject)<-c("subject")
names(dataActivity)<- c("activity")
dataFeaturesNames <- read.table(file.path(path_rf, "features.txt"),head=FALSE)
names(dataFeatures)<- dataFeaturesNames$V2

# Merge colomuns to get the data from  df for all files
dtmerge <- cbind(dataSubject, dataActivity)
df <- cbind(dataFeatures, dtmerge)

#Extract only the measurments on the mean and standard deviation for each measurment
## subset names of features by measurments on the mean and stdv
subdataFeaturesNames<-dataFeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", dataFeaturesNames$V2)]
## Subset the data frame Data by seleted names of Features
selectedNames<-c(as.character(subdataFeaturesNames), "subject", "activity" )
df<-subset(df,select=selectedNames)
#Uses descriptive activity names to name the activities in the data set
### read desciptive names from 'activity_labels.ext'
activityLabels <- read.table(file.path(path_rf, "activity_labels.txt"),header = FALSE)

# Appropriately labels the data set with descriptive variable names
names(df)<-gsub("^t", "time", names(df))
names(df)<-gsub("^f", "frequency", names(df))
names(df)<-gsub("Acc", "Accelerometer", names(df))
names(df)<-gsub("Gyro", "Gyroscope", names(df))
names(df)<-gsub("Mag", "Magnitude", names(df))
names(df)<-gsub("BodyBody", "Body", names(df))

#Creates a second,independent tidy data set and ouput it
install.packages('plyr')
library(plyr)
df2<-aggregate(. ~subject + activity, df, mean)
df2<-df2[order(df2$subject,df2$activity),]
write.table(df2, file = "tidydata.txt",row.name=FALSE)



