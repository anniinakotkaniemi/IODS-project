# Anniina Kotkaniemi, 16.11.2023. Data wrangling exercise of Assignment 3 in Introduction to Open Data Science Course
# the data retreived from http://www.archive.ics.uci.edu/dataset/320/student+performance

# Upload the data
library(tidyverse) # install.packages("tidyverse")
studentmat <- read.csv('~/IODS-project/data/student-mat.csv', sep=";")
view(studentmat)
studentpor <- read.csv('~/IODS-project/data/student-por.csv', sep=";")
view(studentpor)
# Explore dimensions of the data
str(studentmat)
dim(studentmat)
# Studentmat is a dataframe with 395 observations and 33 variables
str(studentpor)
dim(studentpor)
# Studentpor is a dataframe with 649 observations and 33 variables

# Join the two datasets
# Create a vector of the variables to exclude
free_cols <- c("failures","paid","absences","G1","G2","G3")
# Keep only students in both data sets
join_cols <- setdiff(colnames(studentpor), free_cols)
mat_por <- inner_join(studentmat, studentpor, by = join_cols, suffix = c(".math", ".por"))
# Explore the structure
str(mat_por)

# Extract the columns not used for joining
alc <- select(mat_por, all_of(join_cols))
# Delete duplicates with if-loop
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(mat_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}
alc
