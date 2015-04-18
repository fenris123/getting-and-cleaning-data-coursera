##### COURSERA GETTING DATA PROYECT.
##### run_analysis.R



##MERGING THE DATA


#### on firts place we will create tree diferent columns, (subject_***, Y_***, and X_***)
#### the y_test, and the subject will be recoded to diferenciate the test of the train. (see the CODE BOOK)

yrecoded <- read.csv (".\\UCI HAR Dataset\\test\\y_test.txt", header = FALSE) +6

subjectrecoded <- read.csv (".\\UCI HAR Dataset\\test\\subject_test.txt", header = FALSE) +30



     
## merging x_***, Y_*** and subject_***, using rbind in tree columns (training up, test down). 
## later we merge the tree columns into an array.

traininglabels <- rbind ((read.csv (".\\UCI HAR Dataset\\train\\y_train.txt",header =FALSE)),yrecoded)
subject <- rbind ((read.csv (".\\UCI HAR Dataset\\train\\subject_train.txt", header = FALSE)),(subjectrecoded))
variables <- rbind ((read.table (".\\UCI HAR Dataset\\train\\X_train.txt")),(read.table (".\\UCI HAR Dataset\\test\\X_test.txt")))

totaldata <- as.data.frame(cbind(subject,traininglabels,variables))




## RENAMING THE DATASET.


## Renaming the activity labels.


activitylabels <- c("WALKING       ", "WALK_UPSTAIRS","WALK_DOWNSTAIRS","SITTING       ","STANDING     " ,"LAYING        ","TEST WALKING", "TEST WALK_UPSTAIRS","TEST WALK_DOWNSTAIRS","TEST SITTING     ","TEST STANDING     ","TEST LAYING     ")

for (i in 1:12){
     for (h in 1:10299){
     if (totaldata[h,2] == i){
     totaldata[h,2] <- activitylabels[i]
          }
     } 
}



## Renaming the variables

variablelist <- read.table(".\\UCI HAR Dataset\\features.txt", header = FALSE)
variablevector <- as.vector(variablelist[,2])
vectornames <- c("subject","activity",(variablevector))

names (totaldata) <- (vectornames)



## extracting the columns of  mean and standar deviation.

extractingdata <- totaldata[,c(1,2,grep("mean()",names(totaldata),fixed = TRUE),grep("std()",names(totaldata),fixed = TRUE))]



#calculate the average of each variable for each activity and each subject

tidydirty = aggregate(extractingdata, by=list(activity = extractingdata$activity, subject=extractingdata$subject), mean)

tidy = cbind (tidydirty[,1:2],tidydirty[,5:70])


tidy
