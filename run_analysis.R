# Library Loading

library(reshape2)

# Read Fetures File for column names

features <- read.table("./data/Features.txt")
# convert the column contains the names to vector, so we can changes column names easily later
features <- as.vector(features[,2])

# Read Activity label 
#--------------------#

act_labels <- read.table("./data/activity_labels.txt")

# Read Test Data Set #
#--------------------#

# Read X_test Data set
x_test <- read.table("./data/test/X_test.txt")

# Read Activity Dataset (y_test)
y_test <- read.table("./data/test/Y_test.txt")

#Read Indentification Dataset
subject_test <- read.table("./data/test/subject_test.txt")




# Add column names to datasets from features file and manually as well
# *** This Solve Task No 4
colnames(x_test) <- features
colnames(y_test) <- c("Activity")
colnames(subject_test) <- c("Id")

# Bind x_test with columns from both Activity  and identification dataset
test_df <- cbind(x_test,y_test,subject_test)


# Read Train Data Set #
#--------------------#

# Read X_train Data set
x_train <- read.table("./data/train/X_train.txt")

# Read Activity Dataset (y_train)
y_train <- read.table("./data/train/Y_train.txt")

#Read Indentification Dataset
subject_train <- read.table("./data/train/subject_train.txt")


# Add column names to datasets from features file and manually as well
# *** This Solve Task No 4
colnames(x_train) <- features
colnames(y_train) <- c("Activity")
colnames(subject_train) <- c("Id")

# Bind x_train with columns from both Activity  and identification dataset
train_df <- cbind(x_train,y_train,subject_train)


# Task 1 :- Merging Test Data with Train Data
#--------------------------------------------#
all_df <- rbind(test_df , train_df)


# Task 2 :- Extracts only the measurements on the mean and standard deviation for each measurement. 
#--------------------------------------------------------------------------------------------------

# Regular Expression template to match the mean and standard diviation text in column name.
# It should match "mean()" or "std()" in any position in column name
regex <- "(?:mean\\(\\)|std\\(\\))"

# Move the 79 columns of mean and std to new data frame
ext_df <- all_df[, grep(regex,colnames(all_df))]

# Add the Activity and Id Columns from All_df in addition to 79 columsn
ext_df <- cbind(ext_df, Activity = all_df$Activity, Id = all_df$Id)


# Task 3:- Uses descriptive activity names to name the activities in the data set
#--------------------------------------------------------------------------------#

# Update Activity Column with matched value from activity data set where activity id matched
ext_df$Activity <- act_labels[match(ext_df$Activity,act_labels$V1),2]

# Task 4:- Appropriately labels the data set with descriptive variable names.
# *** ALREADY DONE EARLiER


# Task 5:- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
# --------------------------------------------------------------------------------------------------------------------------

# Melt the data set grouping by Ad and Activity
melted <- melt(ext_df, id.vars= c("Id","Activity"))

# Calculate mean for all variables grouped by id and Activity
tidy <- dcast(melted, Id + Activity ~ variable, fun = mean)

# write the output file 
write.table(tidy, "./data/output_tidyData.txt", row.names = FALSE)



