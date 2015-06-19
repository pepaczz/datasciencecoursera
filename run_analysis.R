run_analysis <- function(){
  # check for existence of 'UCI HAR Dataset' direcotry
  if("UCI HAR Dataset" %in% list.files()){
    print("Folder 'UCI HAR Dataset' successfuly found. Working, please wait." )
  }else{
    stop("Folder 'UCI HAR Dataset' was not found in your working directory. 
         Please move the 'UCI HAR Dataset' folder or navigate the working directory.")
  }
  
  #### MERGING DATASETS (TASK 1) ####
  
  ## TRAINING DATA
  # load the training dataset tables
  X_train <- read.table(file = "UCI HAR Dataset/train/X_train.txt")
  y_train <- read.table(file = "UCI HAR Dataset/train/y_train.txt")
  subject_train <- read.table(file = "UCI HAR Dataset/train/subject_train.txt")
  
  # merge the training dataset tables into a single table
  train <- cbind(subject_train,y_train,X_train)
  
  ## TESTING DATA DATA
  # load the testing dataset tables
  X_test <- read.table(file = "UCI HAR Dataset/test/X_test.txt")
  y_test <- read.table(file = "UCI HAR Dataset/test/y_test.txt")
  subject_test <- read.table(file = "UCI HAR Dataset/test/subject_test.txt")
  
  # merge the testing dataset tables into a single table
  test <- cbind(subject_test,y_test,X_test)
  
  ## MERGE TWO DATASETS
  df <- rbind(train,test)
  
  #### MEAN AND STD (TASK 2) ####
  
  # load variable names
  varNames <- read.table(file = "UCI HAR Dataset/features.txt")
  
  # get indices of variables with mean and std in label
  varNameIndexMean <- grep(pattern = "mean",x = as.character(varNames[,2]),ignore.case=T)
  varNameIndexStd <- grep(pattern = "std",x = as.character(varNames[,2]),ignore.case=T)
  varNameIndexSelected <- sort(unique(c(varNameIndexMean,varNameIndexStd)))
  
  # drop redundant columns 
  df <- df[,c(1,2,(2+varNameIndexSelected))]
  
  #### DESCRIPTIVE ACTIVITY NAMES (TASK 3) ####
  activityNames <- read.table(file = "UCI HAR Dataset/activity_labels.txt",stringsAsFactors=FALSE)
  df["activityNames"] <- activityNames[df[,2],2]
  
  # reorder columns: 1-subject number, 2-activityNames, 3-- variables
  df <- df[,c(1,ncol(df),3:(ncol(df)-1))]
  
  #### VARIABLE NAMES (TASK 4) ####
  # get varible labels and edit their names replacing invalid symbols
  varNameSelected_tmp0 <- as.character(varNames[,2])[varNameIndexSelected]
  varNameSelected_tmp1 <- gsub(pattern = "\\(\\)", replacement = "", x = varNameSelected_tmp0)
  varNameSelected_tmp2 <- gsub(pattern = "\\-", replacement = ".", x = varNameSelected_tmp1)
  varNameSelected_tmp3 <- gsub(pattern = "\\(", replacement = ".", x = varNameSelected_tmp2)
  varNameSelected_tmp4 <- gsub(pattern = "\\)", replacement = "", x = varNameSelected_tmp3)
  varNameSelected_tmp5 <- gsub(pattern = ",", replacement = ".", x = varNameSelected_tmp4)
  
  # create and assign final vector of variable labels
  varNamesFinal <- c("subject","activity",varNameSelected_tmp5)
  names(df) <- varNamesFinal
  
  #### CREATE RESULTING TIDY DATA SET (TASK 5) ####
  dfTidy <- aggregate(data = df, . ~ subject + activity,FUN = mean)
  return(dfTidy)
}
dfTidy <- run_analysis()
