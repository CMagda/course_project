How the script works:

Code is splitted in five steps.

In 1st step are loaded data (training and test sets) which are merged to one data set.
The subject id is also added.


2nd step covers filtering of columns.
Only columns contain the measurements on the mean and standard deviation are extracted


Name of activity is added on step 3. Data are merged with codebook.


4th step: The column names and data are modified to be in accordance with rules of tidy data.


Independent tidy data set with the average of each variable for each activity and each subject 
is created in last, 5th step.
