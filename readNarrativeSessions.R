library(psych)
library(MASS)


narrativeSession <- read.csv("C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/FromEC2/Narrative/August-23-2018-2%3A35.csv", sep = ",", header = TRUE)

sum(narrativeSession$seconds)/60

mean(narrativeSession$seconds)

keep <- c("msgIndex", "seconds")

narrativeTime <- narrativeSession[, keep]
narrativeTime$msgIndex <- as.factor(narrativeTime$msgIndex)

narrativeAvgTime <- aggregate(narrativeTime$seconds, by=list(Category=narrativeTime$msgIndex), FUN=mean)
names(narrativeAvgTime) <- c("Level", "AverageTime")
narrativeAvgTime$AverageTime <- narrativeAvgTime$AverageTime


narrativeAvgTimeMedian <- aggregate(narrativeTime$seconds, by=list(Category=narrativeTime$msgIndex), FUN=median)
names(narrativeAvgTimeMedian) <- c("Level", "MedianTime")
#narrativeAvgTime$AverageTime <- narrativeAvgTime$AverageTime

