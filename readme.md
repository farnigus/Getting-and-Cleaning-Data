#Getting and Cleaning Data
This is the github repository for the Getting and Cleaning Data course.

## Files
**run_analysis.r**    The R script that performs the data cleaning
**tidy.txt**          Output text file
**readme.md**         This file
**codebook.md**       Codebook describing variables

## Details on run_analysis
1. Initialize everything. Set working directory, load dplyr library, and read data.
2. Combine test and training data with rbind
3. Assign variable names.This is performed out of order compared to the instructions on the assignment. Definition of "mean" isn't really too clear when it comes to the variable names.
4. use Select from dplyr to keep only variables of interest
5. Add subject and activity to the dataset. Use merge() to change activity from a number to a descriptive string. Merge() will re-order the data, so do that **after** subject and activity have been added.
6. Group the data by activty and subject, then calculate mean of all other variables.
7. Output data