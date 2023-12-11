# Data Wrangling, Exercise 6
# Read the data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = '\t', header = T)

# Write the data to IODS data folder
write_csv(BPRS, file="~/IODS-project/data/BPRS.csv")
write_csv(RATS, file="~/IODS-project/data/RATS.csv")
# Let's see how the data looks like
glimpse(BPRS)
glimpse(RATS)
summary(BPRS)
summary(RATS)
# BPRS takes 40 observations with 11 values, RATS takes 16 observations with 13 values. 
# In both datasets, all values are integers. The first two values are treatment or control group and the subject, rest are observations from different data observation points.

# The 'treatment' and 'subject' in BPRS and 'Group' and 'ID' in RATS are categorical; Convert the categorical variables of both datasets to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$Group <- factor(RATS$Group)
RATS$ID <- factor(RATS$ID)

# Convert the data sets to long form
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
                       names_to = "weeks", values_to = "bprs") %>% arrange(weeks)
RATSL <- pivot_longer(RATS, cols = -c(ID, Group),
                      names_to = "WD", values_to = "rats") %>% arrange(WD)

# Add week variable to BPRS and Time variable to RATS
BPRSL <- BPRSL %>% mutate(week = as.integer(substr(weeks, 5,5)))
RATSL <- RATSL%>% mutate(Time = as.integer(substr(WD, 3, 4))) 

# Check the variable names, view the data contents and structures, and create some brief summaries of the variables
colnames(BPRSL)
colnames(RATSL)
glimpse(BPRSL) 
# Takes 360 observations with  5 values
glimpse(RATSL) 
# Takes 176 observations with 5 values
summary(BPRSL$bprs)
# bprs takes values between 18 and 95, with 35 as median and 37.66 as mean
summary(RATSL$rats)
# rats takes values between 225 and 628, with 344.5 as median and 384.5 as mean

# In the long form data, all the rows are different observations: in BPRSL it is the bprs, and in RATSL it is the rats variable. 
# In the wide version, the rows represented individual participants or data subject.
# The different data points, the "week" or "Time" were, instead, categories of values that the data subjects took.
# In the new long form data, the same ID or subject is present multiple times, each observation on its own row
# And, in the long form, the "week" or "Time" and the data subjects "ID" or "subject" also are values that the measured observations take

# Save the long data
write.csv(RATSL, "~/IODS-project/data/RATS_long.csv")
write.csv(BPRSL, "~/IODS-project/data/BPRS_long.csv")
