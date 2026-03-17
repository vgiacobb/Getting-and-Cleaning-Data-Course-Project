# CodeBook for Getting and Cleaning Data Course Project

## Data Source
The original data comes from the [UCI Human Activity Recognition Using Smartphones Dataset](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  
It contains data collected from Samsung Galaxy S smartphones using an accelerometer and gyroscope worn by 30 subjects 
(within an age bracket of 19-48 years) performing six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, 
STANDING, LAYING).

## Data Overview
The final tidy dataset contains:
- 68 variables (columns)
- Observations summarized by subject and activity

## Variables

- **subjectId**: Identifier for each subject (1–30)
- **activityName**: Activity performed (e.g., WALKING, SITTING)

### Feature Variables (66 total)
These are the mean and standard deviation measurements for various signals:

- Variables are named like `TimeBodyAccelerometer_mean_X` meaning:
  - `Time` prefix: time domain signals
  - `BodyAccelerometer`: measurement source
  - `mean` or `std`: mean or standard deviation
  - `X`, `Y`, `Z`: axis of measurement

## Cleaning and Transformation Steps
1. Merged training and test datasets into one  
2. Extracted only the mean and standard deviation variables  
3. Used descriptive activity names instead of numeric codes  
4. Labeled variables with descriptive, cleaned names  
5. Created a new tidy dataset with the average of each variable for each activity and subject
