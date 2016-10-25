
# objective of the R code is
###Merges the training and the test sets to create one data set %.
###Extracts only the measurements on the mean and standard deviation for each measurement.
###Uses descriptive activity names to name the activities in the data set
###Appropriately labels the data set with descriptive variable names.
##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

#steps followed 
###Download the file and put the file in the data folder
### Unzip the file
###unzipped files are in the folderUCI HAR Dataset. Get the list of the files
##  [1] "activity_labels.txt"                         
##  [2] "features_info.txt"                           
##  [3] "features.txt"                                
##  [4] "README.txt"                                  
##  [5] "test/Inertial Signals/body_acc_x_test.txt"   
##  [6] "test/Inertial Signals/body_acc_y_test.txt"   
##  [7] "test/Inertial Signals/body_acc_z_test.txt"   
##  [8] "test/Inertial Signals/body_gyro_x_test.txt"  
##  [9] "test/Inertial Signals/body_gyro_y_test.txt"  
## [10] "test/Inertial Signals/body_gyro_z_test.txt"  
## [11] "test/Inertial Signals/total_acc_x_test.txt"  
## [12] "test/Inertial Signals/total_acc_y_test.txt"  
## [13] "test/Inertial Signals/total_acc_z_test.txt"  
## [14] "test/subject_test.txt"                       
## [15] "test/X_test.txt"                             
## [16] "test/y_test.txt"                             
## [17] "train/Inertial Signals/body_acc_x_train.txt" 
## [18] "train/Inertial Signals/body_acc_y_train.txt" 
## [19] "train/Inertial Signals/body_acc_z_train.txt" 
## [20] "train/Inertial Signals/body_gyro_x_train.txt"
## [21] "train/Inertial Signals/body_gyro_y_train.txt"
## [22] "train/Inertial Signals/body_gyro_z_train.txt"
## [23] "train/Inertial Signals/total_acc_x_train.txt"
## [24] "train/Inertial Signals/total_acc_y_train.txt"
## [25] "train/Inertial Signals/total_acc_z_train.txt"
## [26] "train/subject_train.txt"                     
## [27] "train/X_train.txt"                           
## [28] "train/y_train.txt"
###See the README.txt file for the detailed information on the dataset. For the purposes of this project, the files in the Inertial
###Signals folders are not used. The files that will be used to load data are listed as follows:

test/subject_test.txt
test/X_test.txt
test/y_test.txt
train/subject_train.txt
train/X_train.txt
train/y_train.txt

Values of Varible Activity consist of data from “Y_train.txt” and “Y_test.txt”
values of Varible Subject consist of data from “subject_train.txt” and subject_test.txt"
Values of Varibles Features consist of data from “X_train.txt” and “X_test.txt”
Names of Varibles Features come from “features.txt”
levels of Varible Activity come from “activity_labels.txt”


#key varialbe names
##  [1] "timeBodyAccelerometer-mean()-X"                
##  [2] "timeBodyAccelerometer-mean()-Y"                
##  [3] "timeBodyAccelerometer-mean()-Z"                
##  [4] "timeBodyAccelerometer-std()-X"                 
##  [5] "timeBodyAccelerometer-std()-Y"                 
##  [6] "timeBodyAccelerometer-std()-Z"                 
##  [7] "timeGravityAccelerometer-mean()-X"             
##  [8] "timeGravityAccelerometer-mean()-Y"             
##  [9] "timeGravityAccelerometer-mean()-Z"             
## [10] "timeGravityAccelerometer-std()-X"              
## [11] "timeGravityAccelerometer-std()-Y"              
## [12] "timeGravityAccelerometer-std()-Z"              
## [13] "timeBodyAccelerometerJerk-mean()-X"            
## [14] "timeBodyAccelerometerJerk-mean()-Y"            
## [15] "timeBodyAccelerometerJerk-mean()-Z"            
## [16] "timeBodyAccelerometerJerk-std()-X"             
## [17] "timeBodyAccelerometerJerk-std()-Y"             
## [18] "timeBodyAccelerometerJerk-std()-Z"             
## [19] "timeBodyGyroscope-mean()-X"                    
## [20] "timeBodyGyroscope-mean()-Y"                    
## [21] "timeBodyGyroscope-mean()-Z"                    
## [22] "timeBodyGyroscope-std()-X"                     
## [23] "timeBodyGyroscope-std()-Y"                     
## [24] "timeBodyGyroscope-std()-Z"                     
## [25] "timeBodyGyroscopeJerk-mean()-X"                
## [26] "timeBodyGyroscopeJerk-mean()-Y"                
## [27] "timeBodyGyroscopeJerk-mean()-Z"                
## [28] "timeBodyGyroscopeJerk-std()-X"                 
## [29] "timeBodyGyroscopeJerk-std()-Y"                 
## [30] "timeBodyGyroscopeJerk-std()-Z"                 
## [31] "timeBodyAccelerometerMagnitude-mean()"         
## [32] "timeBodyAccelerometerMagnitude-std()"          
## [33] "timeGravityAccelerometerMagnitude-mean()"      
## [34] "timeGravityAccelerometerMagnitude-std()"       
## [35] "timeBodyAccelerometerJerkMagnitude-mean()"     
## [36] "timeBodyAccelerometerJerkMagnitude-std()"      
## [37] "timeBodyGyroscopeMagnitude-mean()"             
## [38] "timeBodyGyroscopeMagnitude-std()"              
## [39] "timeBodyGyroscopeJerkMagnitude-mean()"         
## [40] "timeBodyGyroscopeJerkMagnitude-std()"          
## [41] "frequencyBodyAccelerometer-mean()-X"           
## [42] "frequencyBodyAccelerometer-mean()-Y"           
## [43] "frequencyBodyAccelerometer-mean()-Z"           
## [44] "frequencyBodyAccelerometer-std()-X"            
## [45] "frequencyBodyAccelerometer-std()-Y"            
## [46] "frequencyBodyAccelerometer-std()-Z"            
## [47] "frequencyBodyAccelerometerJerk-mean()-X"       
## [48] "frequencyBodyAccelerometerJerk-mean()-Y"       
## [49] "frequencyBodyAccelerometerJerk-mean()-Z"       
## [50] "frequencyBodyAccelerometerJerk-std()-X"        
## [51] "frequencyBodyAccelerometerJerk-std()-Y"        
## [52] "frequencyBodyAccelerometerJerk-std()-Z"        
## [53] "frequencyBodyGyroscope-mean()-X"               
## [54] "frequencyBodyGyroscope-mean()-Y"               
## [55] "frequencyBodyGyroscope-mean()-Z"               
## [56] "frequencyBodyGyroscope-std()-X"                
## [57] "frequencyBodyGyroscope-std()-Y"                
## [58] "frequencyBodyGyroscope-std()-Z"                
## [59] "frequencyBodyAccelerometerMagnitude-mean()"    
## [60] "frequencyBodyAccelerometerMagnitude-std()"     
## [61] "frequencyBodyAccelerometerJerkMagnitude-mean()"
## [62] "frequencyBodyAccelerometerJerkMagnitude-std()" 
## [63] "frequencyBodyGyroscopeMagnitude-mean()"        
## [64] "frequencyBodyGyroscopeMagnitude-std()"         
## [65] "frequencyBodyGyroscopeJerkMagnitude-mean()"    
## [66] "frequencyBodyGyroscopeJerkMagnitude-std()"     
## [67] "subject"                                       
## [68] "activity"
