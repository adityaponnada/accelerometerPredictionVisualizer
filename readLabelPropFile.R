library(MASS)
library(dplyr)
library(plyr)

labelPropFile <- read.csv("C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/Turk_Sept10/Labels/LabelsProp.csv", sep = ",", header = TRUE)

### Assign date and time

tempTimeStamp = startdateTime

labelPropFile$DATE_TIME <- NA
labelPropFile$DATE_TIME <- as.POSIXct(labelPropFile$DATE_TIME, format = "%Y-%m-%d %H:%M:%S")

for (i in 1:nrow(labelPropFile)){
  
  #tempTimeStamp = startdateTime
  
  #labelPropFile$DATE_TIME[i] = as.POSIXct(tempTimeStamp, format = "%Y-%m-%d %H:%M:%S")
  labelPropFile$DATE_TIME[i] = tempTimeStamp
  
  tempTimeStamp = tempTimeStamp + 1
  
  print(paste0("i is ", i))
  
}

