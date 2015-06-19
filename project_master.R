
# set the working directory
setwd("C:/_Rs/Coursera/GettingAndCleaningData/UCI HAR Dataset")
setwd("C:/_Rs/Coursera/GettingAndCleaningData")

source("C:/_Rs/Coursera/GettingAndCleaningData/project.R")

# CODEBOOK
newNames <- names(dfTidy)
originalNames <- c("","", as.character(varNames[,2])[varNameIndexSelected])
dfCodebook <- data.frame(newNames = newNames, originalNames = originalNames)
write.csv2(x = dfCodebook, file = "codebook.csv")

# export final data
write.table(x = dfTidy,file = "tidyData.txt", row.names = F)
