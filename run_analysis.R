library(dplyr) 
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "~/13.Data science/Getting and Cleaning Data/Project/DS.zip")
unzip( "~/13.Data science/Getting and Cleaning Data/Project/DS.zip", exdir="~/13.Data science/Getting and Cleaning Data/Project/") 

# Read all data into the directory

activity_labels <- read.table("~/13.Data science/Getting and Cleaning Data/Project/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

features <- read.table("~/13.Data science/Getting and Cleaning Data/Project/UCI HAR Dataset/features.txt", col.names = c("n","signals"))

subject_test <- read.table("~/13.Data science/Getting and Cleaning Data/Project/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
X_test <- read.table("~/13.Data science/Getting and Cleaning Data/Project/UCI HAR Dataset/test/X_test.txt", col.names = features$signals)
y_test <- read.table("~/13.Data science/Getting and Cleaning Data/Project/UCI HAR Dataset/test/y_test.txt", col.names = "labels")

subject_train <- read.table("~/13.Data science/Getting and Cleaning Data/Project/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
X_train <- read.table("~/13.Data science/Getting and Cleaning Data/Project/UCI HAR Dataset/train/X_train.txt", col.names = features$signals)
y_train <- read.table("~/13.Data science/Getting and Cleaning Data/Project/UCI HAR Dataset/train/y_train.txt", col.names = "labels")

str(activity_labels)
str(features)
str(subject_test) 
str(X_test) 
str(y_test) 
str(subject_train)
str(X_train) 
str(y_train)

#Step 1: Merges the training and the test sets to create one data set
test.data <- cbind(X_test, y_test, subject_test)
train.data <- cbind(X_train,y_train, subject_train )
merged_data <- rbind(test.data, train.data)
str(test.data)
str(train.data)
str(merged_data)

#Step 2: Extracts only the measurements on the mean and standard deviation 
#for each measurement

extracted.data <- merged_data %>% select(subject, labels, contains("mean"), contains("std"))
colnames(extracted.data) #check
str(extracted.data)

# Step 3: Uses descriptive activity names to name the activities in the data set

extracted.data$labels <- activity_labels[extracted.data$labels, 2]
View(extracted.data)
str(extracted.data)

# Step 4: Appropriately labels the data set with descriptive variable names
# the information was taken from features_info.txt and readme.txt
unique(colnames(extracted.data))

names(extracted.data)[2] = "activity"
names(extracted.data)<-gsub("^t", "Time", names(extracted.data))
names(extracted.data)<-gsub("^f", "Frequency", names(extracted.data))
names(extracted.data)<-gsub("Acc", "Accelerometer", names(extracted.data))
names(extracted.data)<-gsub("Gyro", "Gyroscope", names(extracted.data))
names(extracted.data)<-gsub("Mag", "Magnitude", names(extracted.data))
names(extracted.data)<-gsub("BodyBody", "Body", names(extracted.data))
names(extracted.data)<-gsub(".mean", "_Mean", names(extracted.data), ignore.case = TRUE)
names(extracted.data)<-gsub(".std", "_StandardDeviation", names(extracted.data), ignore.case = TRUE)
names(extracted.data)<-gsub("-", "_", names(extracted.data), ignore.case = TRUE)
colnames(extracted.data)
str(extracted.datas)

# Step 5: From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject

tidy.data <- extracted.data %>%
  group_by(subject, activity) %>%
  summarise_all(mean)

write.table(tidy.data, "~/13.Data science/Getting and Cleaning Data/Project/tidy.data.txt", row.name=FALSE)

# Check
View(tidy.data)
str(tidy.data)

