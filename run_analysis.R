####Script to make teh tidy data set


##REad in the FEature labesl
feature_names <- read.table("features.txt")
col_names <- feature_names[,2]


## Make properly labelled test data

activity_tst <- read.table("Y_test.txt")   # read in activity type for each observation
colnames(activity_tst)<- "Activity_Type"   # Give column name to the single column activity table

tst <- read.table("X_test.txt")            # read in testdata
colnames(tst)<- col_names                  # Give column name to the test data using feature names

subject_tst <- read.table("subject_test.txt") # read in Id for person (subject) for each observation
colnames(subject_tst)<- "Subject_Id"          # Give column name to the single column subject Id table

total_testdata <- cbind(subject_tst,activity_tst,tst) # column bind (Subject Id, activity type and observation value for each feature) to single table of test data




## Make properly labelled training data

activity_trn <- read.table("Y_train.txt") # read in activity type for each observation
colnames(activity_trn)<- "Activity_Type"  # Give column name to the single column activity table

trn <- read.table("X_train.txt")          # read in training data
colnames(trn)<- col_names                 # Give column name to the training data using feature names

subject_trn<- read.table("subject_train.txt") # read in Id for person (subject) for each observation
colnames(subject_trn)<- "Subject_Id"          # Give column name to the single column subject Id table

total_traindata <- cbind(subject_trn,activity_trn,trn) # column bind (Subject Id, activity type and observation value for each feature) to single table of training data


## Merge test and train data sets
tsttrn <- rbind(total_traindata,total_testdata)


##Replace ACtivity Type Code with Activity Label (for the complete set)

activities <- read.table("activity_labels.txt") # read in labels for each activity type
activity_names <- activities[,2] 

for(i in 1:6){   # Replace code with Activity Label
 itype <- tsttrn$Activity_Type == i
 tsttrn[itype,"Activity_Type"] <- as.character(activity_names[i]) 
}
  
##Extract MEand and Standard DEviation columns

 all_names<- names(tsttrn)
 mean_cols <- grep("mean",all_names) # Mean columns
 std_cols <- grep("std",all_names) # Standard Deviaiton Columns
 
mean_std <- cbind(tsttrn[,1:2],tsttrn[,mean_cols],tsttrn[,std_cols]) # Subjects, Activity, Means, Std Deviations


tidy_data <- mean_std %>% group_by(Activity_Type,Subject_Id) %>% summarise_each(funs(mean)) # Calculating mean for each subject for each acitivty

write.table(tidy_data,"td_set.txt",row.names=FALSE) # Writing output file

## End of Script


 
