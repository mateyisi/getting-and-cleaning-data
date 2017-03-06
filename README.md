# Tidy data

The submitted tidy data is obtained by averaged the 128 element feature vector for each sample.
Since samples contain repeated meansurements of one subject for the same activity, an effective
value of average accelation and standard deviation is obtain by averaging over the values belonging to 
the same subject for a given activity. This is done for all activity labels.

The dity data columns are as follows:

1. Subjects: 
        -This gives a  uniqure integer identifier for each subjects.

2. WALKING_UNSPECIFIED.mn: 
        - mean accelation in units of gravity for acitivity label WALKING .

3. WALKING_UPSTAIRS.mn     
         - mean accelation in units of gravity for acitivity label WALKING.

4. WALKING_DOWNSTAIRS.mn   
          - mean accelation in units of gravity for acitivity label WALKING.

5. SITTING.mn              
         - mean accelation in units of gravity for acitivity label WALKING.
6. STANDING.mn             
         - mean accelation in units of gravity for acitivity label WALKING.
7. LAYING.mn               
         - mean accelation in units of gravity for acitivity label WALKING.
8. WALKING_UNSPECIFIED.sd  
        - effective standard deviation for acitivity label WALKING in units of gravity.
9. WALKING_UPSTAIRS.sd     
         - effective standard deviation in units of gravity for activity label WALKING_UPSTAIRS.
10. WALKING_DOWNSTAIRS.sd  
         - effective standard deviation in units of gravity for activity label WALKING_DOWNSTAIRS.
14. SITTING.sd             
         - effective standard deviationin units of gravity for activity label SITTING.
15. STANDING.sd            
        - effective standard deviationin units of gravity for activity label STANDING.
16. LAYING.sd              
         - effective standard deviation in units of gravity for activity label LAYING..


