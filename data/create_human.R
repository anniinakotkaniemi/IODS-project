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


# Continuing with the data wrangling for Assignment 5
# Read the file
human <- read_csv("~/human.csv")

# Explore the dimensions and the structure of the data
dim(human)
str(human) 
# The dataset includes 195 observations and 19 variables. The data includes information such as average life expectancy from 195 countries. 
# More information about the data can be found at https://hdr.undp.org/data-center/human-development-index#/indicies/HDI

# Exclude unneeded variables: keep only the columns matching the following variable names (described in the meta file above): "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F

# Remove all rows with missing values 

# Remove the observations which relate to regions instead of countries. (1 point)

# The data should now have 155 observations and 9 variables (including the "Country" variable). 
# Save the human data in your data folder. You can overwrite your old ‘human’ data. 