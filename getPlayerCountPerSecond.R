library(psych)
library(MASS)
library(plyr)
library(dplyr)
library(reshape2)


playersPerSecond <- as.data.frame(colnames(labelFile)[2:ncol(labelFile)])
colnames(playersPerSecond)[1] <- "TIME"

playersPerSecond$COUNT <- NA


for (i in 2:ncol(labelFile)){
  #print(paste0("Column no. " + i))
  
  count = 0
  
  
  for (j in 1:nrow(labelFile)){
    #print(paste0("Row no. " + j + " for col no. " + i))
    
    if (labelFile[j,i] != "0"){
      print("Adding user presence")
      count = count + 1
      playersPerSecond$COUNT[i-1] <- count
      
    }
  }
  
}

playersPerSecond$TIME <- as.POSIXct(playersPerSecond$TIME, format = "%Y-%m-%d %H:%M:%OS")

playersPerSecond <- na.omit(playersPerSecond)
