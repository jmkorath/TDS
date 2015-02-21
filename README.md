# TDS
run_analysis.R is the script
I lablled thefeature variables in test and train sets separately using feature.txt
Then added Subject Id and Activity code to both data sets (using cbind)
Then combined the data sets using rbind
Then replaced activcity code with real labels - "walking" etc 
Then extracted subject id, activity, all columns having "mean" and "std" words
Used dplyr group_by method to find average of mean and std for each subject and each activity.

I treat feature info as codebook. 
17 variables out of which 8 are 3D. So total variables are 17 + 8 X remaining 2 diemnsions = 17 + 8 X2 = 33
17 features are calculated for these 33 items.
So total number of features = 33X 17 = 561 (which is given in feature.txt)
