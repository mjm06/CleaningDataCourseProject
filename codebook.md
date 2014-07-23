###Codebook for tidy_data.txt
####This markdown file describes the structure and variables of the file tidy_data.txt.

**File Structure**
The file `tidy_data.txt` contains 82 columns and 180 rows. The columns represent 82 variables. 
Columns 1-3 contain the "Activity", "ActivityName", and "Subject" variables, respectively.
Columns 4-82 are the 79 variables measured by the accelerometer and gyroscope in Samsung smartphones, when 30 test subjects each completed six activities for multiple replicates. Tidy_data.txt contains the mean value of each variable, by activity and subject, calculated for these replicates.
(Therefore, there are *180 rows* in the dataset:  30 subjects x 6 activities = 180.)

---
**Variables**

"Activity" - an integer from 1 to 6 that corresponds to the text description of each activity type in the study (described below in "ActivityName").

"ActivityName" - a character string (e.g. WALKING) describing the activity type, which corresponds to the integer code used for the Activity column:

Activity|ActivityName	
1|WALKING			
2|WALKING_UPSTAIRS	
3|WALKING_DOWNSTAIRS	
4|SITTING		
5|STANDING		
6|LAYING		

"Subject" - an integer between 1 and 30 that corresponds to the study subject's ID.

The following 79 variables are unitless, because they represent the mean value of each variable, by activity and subject, and the measurements of these variables were normalized to [-1,1] before the means were calculated.
A brief description of what each variable represents is provided below:

"fBodyAccJerkMagMean"
"fBodyAccJerkMagMeanFreq"
"fBodyAccJerkMagStd"
"fBodyAccJerkMeanFreqX"
"fBodyAccJerkMeanFreqY"
"fBodyAccJerkMeanFreqZ"
"fBodyAccJerkMeanX"
"fBodyAccJerkMeanY"
"fBodyAccJerkMeanZ"
"fBodyAccJerkStdX"
"fBodyAccJerkStdY"
"fBodyAccJerkStdZ"
"fBodyAccMagMean"
"fBodyAccMagMeanFreq"
"fBodyAccMagStd"
"fBodyAccMeanFreqX"
"fBodyAccMeanFreqY"
"fBodyAccMeanFreqZ"
"fBodyAccMeanX"
"fBodyAccMeanY"
"fBodyAccMeanZ"
"fBodyAccStdX"
"fBodyAccStdY"
"fBodyAccStdZ"
"fBodyGyroJerkMagMean"
"fBodyGyroJerkMagMeanFreq"
"fBodyGyroJerkMagStd"
"fBodyGyroMagMean"
"fBodyGyroMagMeanFreq"
"fBodyGyroMagStd"
"fBodyGyroMeanFreqX"
"fBodyGyroMeanFreqY"
"fBodyGyroMeanFreqZ"
"fBodyGyroMeanX"
"fBodyGyroMeanY"
"fBodyGyroMeanZ"
"fBodyGyroStdX"
"fBodyGyroStdY"
"fBodyGyroStdZ"
"tBodyAccJerkMagMean"
"tBodyAccJerkMagStd"
"tBodyAccJerkMeanX"
"tBodyAccJerkMeanY"
"tBodyAccJerkMeanZ"
"tBodyAccJerkStdX"
"tBodyAccJerkStdY"
"tBodyAccJerkStdZ"
"tBodyAccMagMean"
"tBodyAccMagStd"
"tBodyAccMeanX"
"tBodyAccMeanY"
"tBodyAccMeanZ"
"tBodyAccStdX"
"tBodyAccStdY"
"tBodyAccStdZ"
"tBodyGyroJerkMagMean"
"tBodyGyroJerkMagStd"
"tBodyGyroJerkMeanX"
"tBodyGyroJerkMeanY"
"tBodyGyroJerkMeanZ"
"tBodyGyroJerkStdX"
"tBodyGyroJerkStdY"
"tBodyGyroJerkStdZ"
"tBodyGyroMagMean"
"tBodyGyroMagStd"
"tBodyGyroMeanX"
"tBodyGyroMeanY"
"tBodyGyroMeanZ"
"tBodyGyroStdX"
"tBodyGyroStdY"
"tBodyGyroStdZ"
"tGravityAccMagMean"
"tGravityAccMagStd"
"tGravityAccMeanX"
"tGravityAccMeanY"
"tGravityAccMeanZ"
"tGravityAccStdX"
"tGravityAccStdY"
"tGravityAccStdZ"
