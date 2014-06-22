# Read Me  #

## Human Activity Recognition Analysis Script ##

The goal of this script is to prepare tidy data data that can be used for later analysis. The script do collecting cleaning, reshaping and summarizing the data.

## Original Data ##

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones )

Here you can download the data

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip ](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  )

## This Repository includes the following files: ##

**run_analysis.R** : This file contains the analysis script.

**Readme.md** : The Readme file

**CodeBook** : Provide variable definitions of the output data set

## Package Dependency ##

 You have to install The library "reshape2" by running the following command 
    
    Install.Packages("reshape2")
This library will help us to do data grouping using `melt` and `dcast` function.

## Running the script ##
Make sure before runinng the script to have the original data folder in the same root of the script with name data. The code read file like this:  
 `read.table("./data/test/X_test.txt")`  

## How this script works ##

1. **Reading The data**  
   First part of the code is about reading the files 
	- Features.txt 
	- activity_labels.txt
	- X_test.txt
	- Y_test.txt
	- subject_test.txt
	- X_train.txt
	- Y_train.txt
	- subject_train.txt  
2. **Labeling The data set**  
   Get the labels from features.txt and manually assign label for Activity and subject Id columns.  
3. **Combine the test data and train data**
 	After labeling each dataset, i combine both Train dataset and Test dataset in one dataset.     
4. **Extract mean and std measurements**  
   Using regular expression i filtered out 66 columns that has mean() or std() in column name.  
     `  ext_df <- all_df[, grep(regex,colnames(all_df))] `  
5. **Update Activity column with descriptive name**  
   Instead of doing merge, i see this way is much easier  
    `ext_df$Activity <- act_labels[match(ext_df$Activity,act_labels$V1),2]`  
6. **Create Tidy Dataset**  
   Using reshape library i melted the dataset then group by Id and Activity columns to calculate mean of all columns.  
7. **Write the output file**
   Write the summarized data into a txt file (output_tidyData.txt)