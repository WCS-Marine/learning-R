# This script is to load in a MERMAID csv file and start working with the data

# getwd() gets the 'working directory' of where you currently are
getwd()

# setwd() will set the working directory with your MERMAID csv file
setwd("<location of your dataset>") 

# read.csv will load the data
data <- read.csv("/Users/emilydarling/desktop/beltfish-Vatu-i-Ra-20181210.csv",
                 header = TRUE, stringsAsFactors = TRUE)

#now start looking at your data
head(data)
names(data)
str(data)

#for columns that are factors with unique levels, you can look at the different types of levels
unique(data$Management.rules)
table(data$Management.rules)

unique(data$Site)
table(data$Site)


