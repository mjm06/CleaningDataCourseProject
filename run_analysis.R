#Getting and Cleaning Data Course Project
#This script completes the following steps:
#1. Merges the training and test datasets to create one dataset;
#2. Extracts only the measurements on the mean and stdev for each measurement;
#3. Names the activities in each data set with descriptive names;
#4. Labels the dataset with descriptive variable names;
#5. Creates a second, independent tidy data set with the average of each variable
#   for each activity and each subject.

require(plyr)
require(reshape2)

#Read in the test datasets (X_test and y_test).X_test is the test set;
#y_test contains the test labels.Get the subject names that are in 
x.test<-read.table("./test/X_test.txt", sep="")
y.test<-read.table("./test/y_test.txt", sep="")
subject.test<-read.table("./test/subject_test.txt", sep="")

#Read in the training datasets (X_train and y_train).
x.train<-read.table("./train/X_train.txt", sep="")
y.train<-read.table("./train/y_train.txt", sep="")
subject.train<-read.table("./train/subject_train.txt", sep="")

#Read in the features and features_info txt files.
features<-read.table("./features.txt", sep="")
activities<-read.table("./activity_labels.txt", sep="")

#First, merge the x.test and the y.test dataframes. The x.test contains 2947 observations for
#561 variables, but no labels are given for each observation; y.test contains an integer
#corresponding to the activity type for each row. Also connect the subject.test df, which
#contains ID numbers of the people used for the x.test df. Do the same for the training data.
all.test<-cbind(subject.test, y.test, x.test)
all.train<-cbind(subject.train, y.train, x.train)

#rbind the all.test and all.train data together.
all.data<-rbind(all.test, all.train)

#Use features dataframe to add names for each column of all.data.
#the features dataframe contains the names of all 561 variables measured for each subject,
#for each activity. These names will be cleaned up before creating the second, tidy dataset.
vars<-as.character(features$V2)
colnames(all.data)<-c("Subject", "Activity", vars)

#Extract, from all.data, only the columns that represent mean and stdev for each row.This will
#include columns that have "mean" or "std" anywhere in their colname -- use grep 
#to do this. Then, cbind these 'means only' and 'stdev only' columns to the "Subject"
#and "Activity" cols in the all.data dataframe.The resultant dataframe has 81 variables: the 
#variable "Activity" (an integer), the variable "Subject" (an integer), and 79 measured variables
#that represent a mean or stdev.
#which have 'mean' or 'stdev' somewhere in their names.
means.only<-all.data[, grep("mean", colnames(all.data))] 
stdev.only<-all.data[, grep("std", colnames(all.data))] 
extracted.data<-cbind(all.data[,(1:2)], means.only, stdev.only)

#Use the integer value in extracted.data$Activity to determine the text
#description of the activity. The text descriptions that correspond to each
#integer of the Activity column are in the activities dataframe. Therefore,
#merge the activities and extracted.data dataframes, using the "Activity" column
#in each as the "common key", but set all.y=FALSE. 
colnames(activities)<-c("Activity", "ActivityName")
ext.data.active<-merge(activities, extracted.data, 
                       by.extracted.data=Activity, 
                       by.activities=Activity, 
                       all=TRUE, all.x=TRUE, all.y=FALSE, sort=FALSE)    

#Clean up the names of the measured variables in ext.data.active so that they are more descriptive, 
#and do not include special characters forbidden by R. Specifically, get rid of the character "-" 
#and the character combination "()". In addition, fix the column names with a word inadvertently
#repeated in the original data (e.g. "bodybody").Capitalize 'std' and 'mean' and use CamelCase
#throughout the column names.
colnames(ext.data.active)<-gsub(pattern="-", replacement="", colnames(ext.data.active))
colnames(ext.data.active)<-gsub(pattern="std", replacement="Std", colnames(ext.data.active))
colnames(ext.data.active)<-gsub(pattern="mean", replacement="Mean", colnames(ext.data.active))
colnames(ext.data.active)<-gsub(pattern="\\()", replacement="", colnames(ext.data.active))
colnames(ext.data.active)<-gsub(pattern="BodyBody", replacement="Body", colnames(ext.data.active))



#Create a second, tidy dataset with the average of each variable, for each activity and each subject.Do this
#using the reshape2 package, melt and dcast functions. Create a character vector that contains the colnames
#of the variables measured for each activity and each subject (which are in columns 4 through 82 of 
#ext.data.active), to use when recasting the data.
tidy_melt<-melt(ext.data.active, id=c("Activity", "ActivityName", "Subject"))
var.names<-colnames(ext.data.active[4:82])

tidy_cast<-dcast(tidy_melt, Activity+ActivityName+Subject~var.names, mean)

#Outputs the second, tidy dataset as a tab-delimited.txt file.
write.table(tidy_cast, "./tidy_data.txt", sep="\t", row.names=FALSE)
