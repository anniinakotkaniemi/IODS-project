# create_human R script for Data Wrangling exercise in Assignment 4
# Read the data
library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Exploring the dimensions and summarizing the data
str(hd)
dim(hd)
str(gii)
dim(gii)
summary(hd)
summary(gii)

# Changing the column names according to the shorter names in the metadata
colnames(hd) <- c("HDI_rank", "country", "HDI", "exp_life", "exp_educ", "mean_educ",
                  "GNI", "GNI_HDI")
colnames(gii) <- c("GII_rank", "country", "GII", "mort_ratio", "ABR", "PRP",
                   "edu2f", "edu2m", "lab_f", "lab_m")

# Creating two new variables in to the 'gii' data
gii <- mutate(gii, edu2fm = edu2f / edu2m)
gii <- mutate(gii, lab_fm = lab_f / lab_m)
gii
# Looks like it worked!

# Joining the data sets with 'country' and keeping only the countries which are shared between both data sets
human <- inner_join(hd, gii, by = "country")

# The data takes 19 variables and 195 observations, as it should!

# Saving as a csv file
write.csv(human, "human.csv")
