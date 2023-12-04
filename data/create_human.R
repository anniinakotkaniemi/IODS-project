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
colnames(hd) <- c("HDI_rank", "Country", "HDI", "Life.Exp", "Edu.Exp", "mean_educ",
                  "GNI", "GNI_HDI")
colnames(gii) <- c("GII_rank", "Country", "GII", "Mat.Mor", "Ado.Birth", "Parli.F",
                   "Edu2.F", "Edu2.M", "Labo.F", "Labo.M")

# Creating two new variables in to the 'gii' data
gii <- mutate(gii, Edu2.FM = Edu2.F / Edu2.M)
gii <- mutate(gii, Labo.FM = Labo.F / Labo.M)
gii
# Looks like it worked!

# Joining the data sets with 'country' and keeping only the countries which are shared between both data sets
human <- inner_join(hd, gii, by = "Country")

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

# Exclude unneeded variables: keep only the columns matching the following variable names (described in the meta file above): "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"
human <- human[, c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")]

# Remove all rows with missing values 
human <- na.omit(human)

# Remove the observations which relate to regions instead of countries
human <- head(human, n = nrow(human) - 7)

# The data has 155 observations and 9 variables as it should - wohoo!
# Save the human data in the data folder
write.csv(human, "~/IODS-project/data/human.csv")

# Data Wrangling done!
