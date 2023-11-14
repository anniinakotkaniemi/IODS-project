# Anniina Kotkaniemi, 13.11.2023
# Data for Assignment 2 in the IODS course 
library(tidyverse)
# Read the data from the URL into R using read_tsv
library(readr)
learning2014_full <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=T)
# Explore the structure and dimensions of the data
str(learning2014_full)
dim(learning2014_full)
# The examination shows that it is a datadrame object with 183 observations that take 60 variables


# Combine variables and calculate mean
analysis_dataset <- data.frame(
  gender = learning2014$gender,
  age = learning2014$age,
  attitude = rowMeans(select(learning2014, starts_with("attitude"))),
  deep = rowMeans(select(learning2014, starts_with("deep"))),
  stra = rowMeans(select(learning2014, starts_with("stra"))),
  surf = rowMeans(select(learning2014, starts_with("surf"))),
 # points = learning2014$points
)

# Display the dimensions of the new dataset
dim(analysis_dataset)
<<<<<<< HEAD

=======
>>>>>>> f5ae47d3c8e6b5d64b4890ccd2ce0368f6be4766
