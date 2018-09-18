library(psych)
library(MASS)
library(reshape2)
library(dplyr)
library(ggplot2)
library(plotly)
library(plyr)

### Read sessions file
#sessionsPath = "C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/FromEC2/SessionsData/August-22-2018-9%3A49.csv"
sessionsPath = "C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/Turk_Sept10/Sessions/September-11-2018-3%3A23.csv"
sessionsData <- read.csv(sessionsPath, sep = ",", header = TRUE)

### Remove autopilot
sessionsData <- sessionsData[!sessionsData$autoPilot == "True",]


### How many seconds on average did each player play?

### Total time spent
sum(sessionsData$sessionLength)/(1000*60) ### 87 minutes total

sessionsData$userID <- as.factor(sessionsData$userID)

length(levels(sessionsData$userID)) ### Total of 79 unique IDs

userSessions <- as.data.frame(summary(sessionsData$userID))

#### Summary of number of levels
summary(userSessions$`summary(sessionsData$userID)`)

#  Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#  1.000   2.000   6.000   5.833   7.250  20.000

colnames(userSessions)[1] <- "TotalLevels"


#### Get info on each level
levelFreq <- sessionsData
levelFreq$currentLevel <- as.factor(levelFreq$currentLevel)

levelSummary <- count(levelFreq, 'currentLevel')

#### Get info on number of victories in each level

keep <- c("currentLevel", "result")
levelVictory <- sessionsData[,keep]

summary(levelVictory$result)

# Defeat Victory 
# 135     188

### take victory and defeat subsets
levelVictory$currentLevel <- as.factor(levelVictory$currentLevel)

levelVictory$isDefeat[levelVictory$result == "Defeat"] <- 1
levelVictory$isDefeat[levelVictory$result == "Victory"] <- 0

levelVictory$isVictory[levelVictory$result == "Defeat"] <- 0
levelVictory$isVictory[levelVictory$result == "Victory"] <- 1

# levelWins <- levelVictory[levelVictory$result == "Victory",]
# levelLoses <- levelVictory[levelVictory$result == "Defeat",]
# 
# levelWins$numericResult <- 1
# levelLoses$numericResult <- 1

levelresults <- aggregate(levelVictory$isVictory, by=list(Category = levelVictory$currentLevel), FUN=sum)
names(levelresults) <- c("Level", "VictoryCount")

levelresults2 <- aggregate(levelVictory$isDefeat, by=list(Category = levelVictory$currentLevel), FUN=sum)
names(levelresults2) <- c("Level", "DefeatCount")

#### Merge data frames

finalLevelResults <- merge(levelresults, levelresults2, by = "Level")

finalLevelResults$LevelNo <- as.numeric(as.character(finalLevelResults$Level))
finalLevelResults <- finalLevelResults[order(finalLevelResults$LevelNo),]
### Amount of time spent on each level



sessionsData$factoredlevels <- as.factor(sessionsData$currentLevel)
keepTime <- c("factoredlevels", "sessionLength")
levelTime <- sessionsData[, keepTime]



# group_by(levelTime, factoredlevels)%>% summarize(sessionTimeAvg = mean(sessionLength)/1000)

levelSessionLength <- aggregate(levelTime$sessionLength, by=list(Category=levelTime$factoredlevels), FUN=mean)
names(levelSessionLength) <- c("Level", "AverageTime")
levelSessionLength$AverageTime <- levelSessionLength$AverageTime/1000

levelSessionLengthMedian <- aggregate(levelTime$sessionLength, by=list(Category=levelTime$factoredlevels), FUN=median)
names(levelSessionLengthMedian) <- c("Level", "MedianTime")
levelSessionLengthMedian$MedianTime <- levelSessionLengthMedian$MedianTime/1000


keepUsers <- c("userID", "currentLevel")
levelUsers <- sessionsData[, keepUsers]

levelUsers$userID <- as.factor(levelUsers$userID)
levelUsers$currentLevel <- as.factor(levelUsers$currentLevel)

uniQueUsersPerLevel <- ddply(levelUsers,~currentLevel,summarise,number_of_distinct_players=length(unique(userID)))
uniQueUsersPerLevel$number_of_distinct_players <- as.numeric(uniQueUsersPerLevel$number_of_distinct_players)

keepUserTime <- c("userID","sessionLength")
userTime <- sessionsData[, keepUserTime]
userTime$userID <- as.factor(userTime$userID)
userTimeData <- aggregate(userTime$sessionLength, by=list(Category=userTime$userID), FUN=sum)
userTimeData$x <- userTimeData$x/1000

fit <- density(userTimeData$x)
timeLengthData <- userTimeData$x


#### Total seconds of data played = 5150 seconds
sum(sessionsData$allSeconds)

#### Total unlabeled sesconds = 1330 seconds
sum(sessionsData$participantSeconds)


keeplabelTime <- c("factoredlevels", "participantSeconds")
levelLabelTime <- sessionsData[, keeplabelTime]

levelLabelLength <- aggregate(levelLabelTime$participantSeconds, by=list(Category=levelLabelTime$factoredlevels), FUN=sum)
names(levelLabelLength) <- c("Level", "LabelTime")
#levelLabelLength$LabelTime <- levelLabelLength$LabelTime/1000

