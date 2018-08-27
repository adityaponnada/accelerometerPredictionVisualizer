library(psych)
library(MASS)

robotGarageSessions <- read.csv("C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/FromEC2/RobotGarage/August-22-2018-9%3A51.csv", sep = ",", header = TRUE)


robotGarageSessions$userID <- as.factor(robotGarageSessions$userID)


levels(robotGarageSessions$userID)

count(levels(robotGarageSessions$userID)) ##only 27 accessed robot garage

robotGarageSessions$level_factor <- as.factor(robotGarageSessions$level)


levelVisits <- count(levels(robotGarageSessions$level_factor))

robotGarageSessions$count <- 1

keep <- c("level_factor", "count")

levelGarageVisits <- robotGarageSessions[, keep]


totalVisitsFromLevel <- aggregate(levelGarageVisits$count, by=list(Category=levelGarageVisits$level_factor), FUN=sum)
names(totalVisitsFromLevel) <- c("Level", "NoVisits")
#narrativeAvgTime$AverageTime <- narrativeAvgTime$AverageTime


keep2 <- c("userID", "count")
Users <- robotGarageSessions[, keep2]

userVisits <- aggregate(Users$count, by=list(Category=Users$userID), FUN=sum)
names(userVisits) <- c("Level", "NoVisits")

keep3 <- c("userID", "seconds")
UserSeconds <- robotGarageSessions[, keep3]
TimeByUser <- aggregate(UserSeconds$seconds, by=list(Category=UserSeconds$userID), FUN=mean)
TimeByUserMedian <- aggregate(UserSeconds$seconds, by=list(Category=UserSeconds$userID), FUN=median)
names(TimeByUser) <- c("userID", "Seconds")
names(TimeByUserMedian) <- c("userID", "Seconds")

mean(TimeByUser$Seconds)


levels(robotGarageSessions$upgraded)
m <- summary(robotGarageSessions$upgraded)

m <- as.data.frame(m)

m1 <- c(14, 21)
m1<-as.data.frame(m1)

names(m1) <- c("NoUpgrade", "Upgrade")
