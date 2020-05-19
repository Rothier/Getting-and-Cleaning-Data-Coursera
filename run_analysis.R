library(dplyr)

# Reads all necessary .txt files
intensity1 <- read.table("C:/Users/alexa/Desktop/Assignment Getting and Cleaning Data/UCI HAR Dataset/test/y_test.txt")
subject1 <- read.table("C:/Users/alexa/Desktop/Assignment Getting and Cleaning Data/UCI HAR Dataset/test/subject_test.txt")
intensity_factors <- read.table("C:/Users/alexa/Desktop/Assignment Getting and Cleaning Data/UCI HAR Dataset/activity_labels.txt")
column_names <- read.table("C:/Users/alexa/Desktop/Assignment Getting and Cleaning Data/UCI HAR Dataset/features.txt")
data1 <- read.table("C:/Users/alexa/Desktop/Assignment Getting and Cleaning Data/UCI HAR Dataset/test/X_test.txt")
intensity2 <- read.table("C:/Users/alexa/Desktop/Assignment Getting and Cleaning Data/UCI HAR Dataset/train/y_train.txt")
subject2 <- read.table("C:/Users/alexa/Desktop/Assignment Getting and Cleaning Data/UCI HAR Dataset/train/subject_train.txt")
data2 <- read.table("C:/Users/alexa/Desktop/Assignment Getting and Cleaning Data/UCI HAR Dataset/train/X_train.txt")

# Creates factor column for exercise intensity
intensity1$V1 <- factor(intensity1$V1, levels = c(1, 2, 3, 4, 5, 6), labels = intensity_factors$V2)

# Renames factor column to be more readable
levels(intensity1$V1) <- c("WALKING"="Walking", "WALKING_UPSTAIRS"="Walking upstairs", "WALKING_DOWNSTAIRS"="Walking downstairs", "SITTING"="Sitting", 
                          "STANDING"="Standing", "LAYING"="Laying")
# Get names for all 561 columns (excluding subject and intenisty which we are going to use as the first and second columns)
colnames(data1) <- column_names[,2]

# Binds tests dataset using "data1" with the measurements and "intensity1" which is a dataset with the exercise intensities for each row
tests <- cbind(subject1, intensity1, data1)

# Creates a column to distinguish test from training later on
tests$type <- "test"

# Renames factor column like above, but for training observations
intensity2$V1 <- factor(intensity2$V1, levels = c(1, 2, 3, 4, 5, 6), labels = intensity_factors$V2)

# Renames factor column for readability again
levels(intensity2$V1) <- c("WALKING"="Walking", "WALKING_UPSTAIRS"="Walking upstairs", "WALKING_DOWNSTAIRS"="Walking downstairs", "SITTING"="Sitting", 
                           "STANDING"="Standing", "LAYING"="Laying")
# Get names for all 561 columns again
colnames(data2) <- column_names[,2]

# Binds train dataset using "data2" with the measurements and "intensity2" which identifies exercise intensity for each row
train <- cbind(subject2, intensity2, data2)

# Create another column to distinguish test from training
train$type <- "training"

# Bind both tests and train dataset by row
df1 <- rbind(tests, train)

# Get positions of all columns that measure a mean
mean <- grep("mean+", names(df1))
mean <- data.frame(df1[, mean])

# Get positions of all columns that measure standard deviation
std <- grep("std+", names(df1))
std <- data.frame(df1[, std])

# First get the first two columns (Subject and Intensity) from df1 for the second dataframe, then bind it with all columns with means or standard deviation measurements
df2 <- df1[, 1:2]
df2 <- cbind(df2, mean, std)

# Replace column names for readability
names(df2)[1] <- "Subject"
names(df2)[2] <- "Intensity"
names(df2)<-gsub("std()", "SD ", names(df2))
names(df2)<-gsub("mean()", "MEAN ", names(df2))
names(df2)<-gsub("^t", "Time ", names(df2))
names(df2)<-gsub("^f", "Frequency ", names(df2))
names(df2)<-gsub("Acc", "Accelerometer ", names(df2))
names(df2)<-gsub("Gyro", "Gyroscope ", names(df2))
names(df2)<-gsub("Mag", "Magnitude ", names(df2))
names(df2)<-gsub("Body Body", "Body", names(df2))
names(df2)<-gsub("Body", "Body ", names(df2))
names(df2)<-gsub("BodyBody", "Body ", names(df2))
names(df2)<-gsub("Jerk", "Jerk ", names(df2))
names(df2)<-gsub("Freqx", "X", names(df2))
names(df2)<-gsub("Freqy", "Y", names(df2))
names(df2)<-gsub("Freqz", "Z", names(df2))
names(df2)<-gsub("\\.", "", names(df2))

# Create the final dataframe
finaldf <- df2

# Aggregate by subject and intensity and get the mean for each measurement column for each subject for each exercise intensity
finaldf <- aggregate(finaldf[,3:81],
                by = list(Subject = finaldf$Subject, Intensity = finaldf$Intensity),
                FUN = mean)
# Create a txt file with the tidy dataset
write.table(finaldf,"tidyDataset.txt",sep="\t",row.names=FALSE)