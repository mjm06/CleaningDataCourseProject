###Getting and Cleaning Data Course Project - README

####The script `run_analysis.R` completes the following five steps:

1. Merges the training and test datasets to create one dataset;
2. Extracts only the measurements on the mean and stdev for each measurement;
3. Names the activities in each data set with descriptive names;
4. Labels the dataset with descriptive variable names;
5. Creates a second, independent tidy data set with the average of each variable
   for each activity and each subject.

Details of how the script accomplishes each of the five steps are described below. But first, some background information about the data is provided.

---
####Background Information About the Data<sup>[1]</sup>

The test data and the training data, which are housed in **X_test.txt** and **x_train.txt**, contain measurements of triaxial total acceleration, estimated body acceleration, and trixial angular velocity recorded by accelerometers and gyroscopes in the Samsung Galaxy S smartphone, which are recorded as 561 variables.
Note that all measurements are unitless because they have been normalized (and bounded to [-1, 1]). 

These variables were measured when 30 subjects, wearing the phones in cases attached to their waists, did six different activities (walking, walking up stairs, walking down stairs, sitting, standing, and laying) for multiple replicates. Thirty percent of the data from the 30 subjects was assigned to **X_test**, while 70% of the data was assigned to **x_train**. 

Note that, in **X_test.txt** and **x_train.txt**, the Subject ID, Activity Type performed by each subject, and the names of the 561 measured variables are not included. These are housed separately in the following files:

* Subject IDs - Integers between 1 and 30; located in **subject_test.txt (2947 obs. of 1 variable)** and **subject_train.txt (7362 obs. of 1 variable)**.
* Activity type - Integers between 1 and 6 that correspond to an activity type; these are housed in **y_test (2947 obs. of 1 variable)** and in **y_train (7362 obs. of 1 variable)**. A text string describing each activity type, along with its integer code, is located in **activity_labels.txt (6 obs. of 2 variables)**. These text descriptions of the activity types were: walking, walking_upstairs, walking_downstairs, sitting, standing, and laying.
* Variable names - Names of the 561 measured variables; these are housed in **features.txt (561 rows in length)**.

---
####Five Steps Completed by `run_analysis.R`:
**Step 1: Merges the training and test datasets to create a single dataset.**

* First, the script reads in the test datasets, X_test and y_test, using `read.table()`; these are saved as the dataframes `x.test` and `y.test`. 
* Next, the training datasets, x_train and y_train are read in using `read.table()`, and saved as the dataframes `x.train` and `y.train`. 
* Then, subject_train and subject_test files are read in, which contain the subject IDs; these are housed in the `subject.train` and `subject.test` dataframes, respectively. 
* Then, the features.txt file (containing the names of 561 variables measured by the cell phones' accelerometers and gyroscopes) and the activity_labels.txt file (containing the text string and integer code for each activity type) are read in, as the `features` dataframe and the `activities` dataframe.
* Then, `cbind` is used to merge `subject.test`, `y.test`, and `x.test` into a single dataframe (`all.test`). Therefore, the first two columns of `all.test` contain the Subject ID and the Activity Type.
* Similarly, `cbind` is used to merge `subject.train`, `y.train`, and `x.train` into a single dataframe (`all.train`). Therefore, the first two columns of `all.train` contain the Subject ID and the Activity Type.
* Finally, `all.test` and `all.train` are merged using `rbind`. **The result is a single dataset (called `all.data` in the script) that contains the merged training and test sets**. The `all.data` dataframe has 10299 rows and 563 columns.

---

**Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.**

* Before the columns of `all.data` that contain means or standard deviations can be extracted, descriptive column names are added to `all.data` using `colnames()`. Column 1 in `all.data` is the Subject ID; Column 2 is the Activity Type (an integer code); while Columns 3-563 correspond to the 561 variables measured. Descriptive names of these 561 variables were provided in the second column of the features.txt file of the original dataset. 

* The script then uses `grep` to identify all columns in `all.data` that have "mean" or "std" anywhere in their column names. **The result is a dataframe (`extracted.data`) that contains only measurements of the mean or standard deviation for each measurement.**

---

**Step 3: Uses descriptive activity names to name the activities in the data set.**

* First, column names are assigned to the `activities` dataframe ("Activities", and "ActivityName").
The integer values that comprise `extracted.data$Activity` (which were originally housed in y_test.txt and y_train.txt) correspond to integer values in `activities$Activity`. Text descriptions of the activities are given in `activities$ActivityName`.

* The `activities` and `extracted.data` dataframes are merged, using the "Activity" column in each as the unique key. (Note that `all.y=FALSE`.)
**The result is a new dataframe (`ext.data.active`) that contains all 561 variables measured for each activity and subject, with descriptive activity names used to name the activities.**

---

**Step 4: Appropriately labels the data set (`ext.data.active`) with descriptive variable names.**
Descriptive variable names were added to the dataset as a part of Step 2 above. However, these names -- which were provided in the original data in the second column of features.text -- are improved in this step using gsub:

* "-" is deleted from all colnames where it appears
* "()" is deleted from all colnames where it appears
* "std" and "mean" are replaced with "Std" and "Mean", so that all colnames use CamelCase
* the "BodyBody" typo is replaced with "Body" where it appears.

**The result of this step is that the extracted dataframe `ext.data.active` now has descriptive, easy to read variable names.**

---

**Step 5: Creates a second, independent tidy dataset with the average of each variable, for each activity, for each subject.**
This step was accomplished using the `reshape2` package; specifically, the `melt` and `dcast` functions. 

* First, the `ext.data.active` dataset created in Step 2, and edited with descriptive labels in Steps 3 and 4, is melted to yield a long dataframe (`tidy_melt`). 
* Then, the `tidy_melt` dataframe is cast as a wide dataframe (`tidy_cast`), with the mean calculated for each activity and each subject. 
* Finally, `tidy_cast` was output as a tab-delimited text file "tidy_data.txt" using `write.table`. **Therefore, tidy_data.txt is defined as the "tidy dataset" for the purposes of this Course Project.** 

---

[1] Citation for data source:  Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
