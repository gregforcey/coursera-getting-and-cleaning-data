### Cleaning Dataset Coursera Assignment

The goal of this project was to take a dataset provided in multiple different files and combine it into one [tidy dataset](http://vita.had.co.nz/papers/tidy-data.pdf). This document provides a description of the files used to process the data including:

File      |  Description
----------|-----------------------------------------------------
Readme.md | A description of all the files in the repo (this file)
run_analysis.r | An R script used to process the data from multiple files into one tidy dataset. The file is commented to explain all the steps taken to process the data.
CodeBook.md | A codebook explaining the meaning of each variable in the tidy dataset and the steps taken to obtain the tidy data.
tidy.txt | The tidy dataset itself provided as a txt file exported using `write.table`. The tidy data can be read back into R using the command below.

```{r}
tidy_data <- read.table("https://github.com/gregforcey/getting_and_cleaning_data/course_project/tidy.txt", header=TRUE)
```
Be sure to change the path of the working directory in the run_analysis file if you are trying to run the script locally. 