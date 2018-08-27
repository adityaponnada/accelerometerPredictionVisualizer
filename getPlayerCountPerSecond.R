library(psych)
library(MASS)
library(plyr)
library(dplyr)
library(reshape2)


playersPerSecond <- as.data.frame(colnames(labelFile)[2:ncol(labelFile)])
colnames(playersPerSecond)[1] <- "TIME"

playersPerSecond$COUNT <- NA

#labelFile$userID <- as.factor(labe)


# for (i in 2:ncol(labelFile)){
#   #print(paste0("Column no. " + i))
#   
#   count = 0
#   
#   
#   for (j in 1:nrow(labelFile)){
#     #print(paste0("Row no. " + j + " for col no. " + i))
#     
#     if (labelFile[j,i] != "0"){
#       print("Adding user presence")
#       
#       count = count + 1
#       playersPerSecond$COUNT[i-1] <- count
#       
#     }
#   }
#   
# }


#j =1

# userPool <- data.frame()
# #nonZero <- data.frame()
# #nonZero$USER <- NA
# userPool$USER <- NA

for (i in 2:ncol(labelFile)){
  
  print(paste0("At i :",i))
  
  tempKeep <- c("userID", i)
  
  nonZero <- labelFile
  nonZero <- subset(nonZero, nonZero[,i] != 0)
  
  nonZero$userID <- as.factor(nonZero$userID)
  
  playersPerSecond$COUNT[i - 1] <- nlevels(nonZero$userID)
 
  # counter = 0
  # 
  # for (j in 1:nrow(labelFile)){
  #   
  #   if (labelFile[j,i] != "0"){
  #     
  #     nonZero <- rbind(nonZero, labelFile[j,])
  #     
  #     nonZero$userID <- as.factor(nonZero$userID)
  #     
  #     playersPerSecond$COUNT[i - 1] <- nlevels(nonZero$userID)
  #     print("Added")
  #   }
  # }
}


playersPerSecond$TIME <- as.POSIXct(playersPerSecond$TIME, format = "%Y-%m-%d %H:%M:%OS")

playersPerSecond <- na.omit(playersPerSecond)

playersPerSecond <- subset(playersPerSecond, playersPerSecond$TIME<endDateTime)

