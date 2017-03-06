
The code consists of two main functions:
    
   * getMergedData
   * getAcitvityTidyData
   
 
 The first function takes as input the path to the working directory. 
 
 The function does the following tasks:
 * load the subject_test.txt, subject_train.txt, y_test.txt,y subject.txt into
 data tables. 
 * read the X_test.txt and X_train.tx line by line and each line and converts the data in each line into a numeric feacture vector. An average acceleration and and standard deviation is calculated from the feature vector for each sample and stored in a table.
 * put together the subject, activity and the feature mean and standard deviation into a single file. This is done for both the test data and the train data.
 
 * The data tables the above step are then combined into a sinle clearn data file call 'Allmerged'
 
 The second function take as an input the clearn 'Allmerged' data:
 
 The function does the following processing tasks:
 
 * split the data into activities labels
 * data from the obove step is then split subject and effective value of the mean accelation and standard deviation
   per activity per subject is calculated.
 * The averaged feature values for all activities is store into indepenent matrices.
 * The matrices are then put into a data frame called 'tidyData'
 
 The output data is stored in the working directory as text file.
 
 
 
 
