# Cleaning Data Codebook

The following are descriptions of each variable in the tidy dataset. These data are tidy because each column is a variable, each row is an observation.

## Variable list and descriptions

Variable         | Variable Description
-----------------|-------------------------------------------------
subject          | ID the subject who performed the activity (range from 1-30)
activity         | Activity name (laying, walking, sitting, standing, walking downstairs, and walking upstairs)
timefreq         | Time domain signal or frequency domain signal (t or f)
measurement      | The type of measurement made
statistic        | Type of statistic - Mean or Standard Deviation
axis             | X, Y and Z directions
average          | Average of each variable for each activity and subject

## Tidy Dataset Structure

```r
str(data.frame(tidy.data))
```
```
'data.frame':	11880 obs. of  7 variables:
$ subject    : int  1 1 1 1 1 1 2 2 2 2 ...
$ activity   : Factor w/ 6 levels "LAYING","SITTING",..: 1 2 3 4 5 6 1 2 3 4 ...
$ timefreq   : Factor w/ 2 levels "f","t": 2 2 2 2 2 2 2 2 2 2 ...
$ measurement: Factor w/ 13 levels "BodyAcc","BodyAccJerk",..: 1 1 1 1 1 1 1 1 1 1 ...
$ statistic  : Factor w/ 2 levels "mean","std": 1 1 1 1 1 1 1 1 1 1 ...
$ axis       : Factor w/ 4 levels "","X","Y","Z": 2 2 2 2 2 2 2 2 2 2 ...
$ average    : num  0.222 0.261 0.279 0.277 0.289 ...
```