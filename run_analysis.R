# Load packages
library(dplyr)      

# Download and unzip data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destfile <- "UCI_HAR_Dataset.zip"

if(!file.exists(destfile)) {
  download.file(url, destfile)
}

if(!file.exists("UCI HAR Dataset")) {
  unzip(destfile)
}

# Read training and test data
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Read feature names and activity labels
features <- read.table("UCI HAR Dataset/features.txt")
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activity_labels) <- c("activityId", "activityName")

# Merge the datasets
X <- rbind(X_train, X_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)

# Name columns
colnames(X) <- features$V2
colnames(y) <- "activityId"
colnames(subject) <- "subjectId"

# Combine all into one dataset
data <- cbind(subject, y, X)

# Extract Mean and SD
mean_std_cols <- grepl("mean\\(\\)|std\\(\\)", features$V2)
data_subset <- data[, c(TRUE, TRUE, mean_std_cols)] 

# Merge with descriptive activity names
data_subset <- merge(data_subset, activity_labels, by = "activityId", all.x = TRUE)

# Clean variable names
names(data_subset) <- gsub("^t", "Time", names(data_subset))  
names(data_subset) <- gsub("^f", "Frequency", names(data_subset))    
names(data_subset) <- gsub("Acc", "Accelerometer", names(data_subset))
names(data_subset) <- gsub("Gyro", "Gyroscope", names(data_subset))
names(data_subset) <- gsub("Mag", "Magnitude", names(data_subset))
names(data_subset) <- gsub("BodyBody", "Body", names(data_subset))

# Create tidy data with mean
tidy_data <- data_subset %>%
  group_by(subjectId, activityName) %>%
  summarise(across(everything(), mean))

# Remove numeric activityId (we already have descriptive activityName)
tidy_data <- tidy_data %>%
  select(-activityId)

# Clean column names
names(tidy_data) <- names(tidy_data) %>%
  gsub("\\(\\)", "", .) %>%   
  gsub("-", "_", .)            

# Write tidy dataset to file
write.table(tidy_data, "tidy_dataset.txt", row.names = FALSE)