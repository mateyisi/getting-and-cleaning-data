
The code consists of two main functions:
    
   * getMergedData
   * getAcitvityTidyData
   
 
 The first function takes as input the path to the working directory. 
 
 The function does the following tasks:

 * take the path to the working director where the downloaded data is saved as an input
  It then loads data from the text files for  acitivit_labels, feature as well as y_train, Y_test and X_train
  data.class
  
  * row combines subject, activity and further column combines restult with the repecti x_trainand and y_train data. 
  
  * The features corresponding to mean or standard deviation are selected and their indices are used to select 
     columns for needed the combined subject, activity and train and test data.
 
 The second function take as an input the clearn 'Allmerged' data and perform the following processing tasks:
 
  * Turn subject and activities into factors
  * use the subjec and activity factors to melt the data
  * calculate the tidy data of means and standard devition per subject and actity by averaging per subject
   for a given activity label of the melt data.
 
 The output tidy data is derived by calling the two functions and the output is store in a text file.
 
 
 
 
