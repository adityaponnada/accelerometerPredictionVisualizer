#### Read label matrix for each hour file

### Import libraries
library(psych)
library(ggplot2)
library(plotly)
library(dplyr)
library(MASS)
library(plyr)
library(reshape2)


#startdateTime = as.POSIXct("2017-11-16 11:45:00")

startdateTime = accHour$HEADER_TIME_STAMP[1]
endDateTime = accHour$HEADER_TIME_STAMP[nrow(accHour)]

##labelPath = "C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/FromEC2/LeveledLabels/20/August-22-2018-9%3A41/https%3A/s3.us-east-2.amazonaws.com/mdcas-signal/data/SPADES_1/MasterSynced/2017/11/15/18/labels.csv"
labelPath = "C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/Turk_Sept10/Labels/AllLabels/September-10-2018-2%3A24/https%3A/s3.us-east-2.amazonaws.com/mdcas-signal/data/SPADES_1/MasterSynced/2017/11/15/17/labels.csv"

#labelPath = "C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/FromEC2/August-22-2018-9%3A45/https%3A/s3.us-east-2.amazonaws.com/mdcas-signal/data/SPADES_1/MasterSynced/2017/11/15/18/labels.csv"

labelFile <- read.csv(labelPath, sep = ",", header = FALSE, skip = 1)

#labelhead <- head(labelFile, 10)

colnames(labelFile)[1] <- "userID"



#labelFile$userID <- c(1:nrow(labelFile))

levs <- c("0", "blank", "highsignal", "lowsignal", "ambulation", "sedentary", "sleep", "nonwear", "notthese")

labelFreq <- sapply(labelFile, function(x) table(factor(x, levels = levs, ordered = TRUE)))

labelFreq <- as.data.frame(labelFreq)

#labelhead = labelhead[, !names(labelhead)%in%c("V3600")]

#labelhead[ , !c("V3600")]


labelFile <- labelFile[, -2]

names(labelFile)[2:3601] <- c(0:3599)



# labelInPath = ""
# 
# labelMatrix <- read.csv(labelInPath, sep = ",", header = TRUE)
# 
# head(labelMatrix)

#### Let A = Ambulation, B = Sed, C = Sleep, D = Non-wear, E = Not sure

# dat <- data.frame(GameSession=factor(1:5, 
#                                      levels =rev(1:5)), matrix(sample(LETTERS[1:5], 100, prob=c(0.20, 0.20, 0.20, 0.20, 0.20), T), nrow = 5, ncol = 3600))
# 
# names(dat)[-1] <- c(0:3599)

j = 0


for (i in 2:ncol(labelFile)){
  
  tempDateAndTime = startdateTime
  
  tempDateAndTime = tempDateAndTime + i-2
  names(labelFile)[i] = as.character(tempDateAndTime)
  
  print(paste0("i is ", i))
  
}

## Melt the data frame

newLabelhead <- melt(labelFile, id.var = 'userID')

# dat <- data.frame(lapply(dat, function(x) {
#   gsub("C", 2, x)
# }))

#### Let A = Ambulation, B = Sed, C = Sleep, D = Non-wear, E = Not sure

newLabelhead$DATE_TIME <- as.POSIXct(newLabelhead$variable, format = "%Y-%m-%d %H:%M:%S")

## High Signal = 8
## Ambulation = 7
## Other = 6
## Sedentary = 5
## Sleep = 4
## Non-wear = 3
## Low signal = 2
## Blank = 1
## No Label = 0

newLabelhead$value <- as.factor(newLabelhead$value)

# newLabelhead <- data.frame(lapply(newLabelhead, function(x) {
#   gsub("0", 1, x)
# }))

newLabelhead$labelCode[newLabelhead$value == "0"] <- 0
newLabelhead$labelCode[newLabelhead$value == "blank"] <- 1
newLabelhead$labelCode[newLabelhead$value == "lowsignal"] <- 2
newLabelhead$labelCode[newLabelhead$value == "nonwear"] <- 3
newLabelhead$labelCode[newLabelhead$value == "sleep"] <- 4
newLabelhead$labelCode[newLabelhead$value == "sedentary"] <- 5
newLabelhead$labelCode[newLabelhead$value == "other"] <- 6
newLabelhead$labelCode[newLabelhead$value == "ambulation"] <- 7
newLabelhead$labelCode[newLabelhead$value == "highsignal"] <- 8





#newLabelhead$value <- as.numeric(newLabelhead$value)




#p <- plot_ly(z = dat, type = "heatmap")


#m2 <-  matrix(sample(1:5, 3600, prob=c(0.20, 0.20, 0.20, 0.20, 0.20), T), nrow = 5, ncol = 3600)

# labelPlot <- plot_ly(
#   x = colnames(dat)[-1], y = dat$GameSession,
#   z = m2, type = "heatmap"
# )%>% config(displayModeBar = T) %>% layout(xaxis=list(tick0 = 1, title = "Time in seconds", fixedrange=FALSE)) %>% layout(title = "Hour file labeled", yaxis=list(autotick = FALSE, title = "Play sessions", fixedrange=TRUE)) ##%>%
# ##layout(xaxis = "Time in seconds", yaxis = "Game play session")

#labelPlot <- plot_ly(z=m2, type = "heatmap")

# labelPlot <- ggplot(data = dat3, aes(DATE_TIME, GameSession)) + geom_tile(aes(fill = value))
# 
# labelPlot <- ggplotly(labelPlot)
# 
# labelPlot

## High Signal = 8
## Ambulation = 7
## Other = 6
## Sedentary = 5
## Sleep = 4
## Non-wear = 3
## Low signal = 2
## No label = 1




# p <- volcano %>%
#   melt() %>% 
#   ggplot(aes(Var1, Var2, fill = value)) + geom_tile()
# 
# p <- ggplotly(p)
# 
# 
# saveHTMLPath = "C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/SEDENTARY_GROUND_TRUTH.html"
# 
# htmlwidgets::saveWidget(subPlotFinal, saveHTMLPath, selfcontained = FALSE)

class(labelFreq)

combinedLabels <- as.data.frame(t(labelFreq))

class(combinedLabels)

head(combinedLabels)

combinedLabels$TIME_STAMP <- NA
combinedLabels <- combinedLabels[-1,]
head(combinedLabels)

tempLabelFile <- labelFile
tempLabelFile <- tempLabelFile[,-1]

combinedLabels <- combinedLabels[-1,]
head(combinedLabels)

combinedLabels$TIME_STAMP <- names(tempLabelFile)
head(combinedLabels)

# colnames(combinedLabels)[1] <- "TIME_STAMP"
# 
#colnames(combinedLabels)[1] <- "None"

### Convert to date time object
combinedLabels$TIME_STAMP <- as.POSIXct(combinedLabels$TIME_STAMP, format = "%Y-%m-%d %H:%M:%S")

class(combinedLabels$TIME_STAMP)


# combinedLabels$RESULTING_LABEL <- NA
# combinedLabels$RESULTING_PROB <- NA

combinedLabels$TOTAL_LABELS <-  combinedLabels$highsignal + 
  combinedLabels$lowsignal + combinedLabels$ambulation +
  combinedLabels$sedentary + combinedLabels$sleep +
  combinedLabels$nonwear + combinedLabels$notthese + combinedLabels$blank

head(combinedLabels)
#combinedLabels <- combinedLabels[-nrow(combinedLabels),]

noneCount = 0
highSignalCount = 0
lowSignalCount = 0
ambulationCount = 0
sedentaryCount = 0
sleepCount = 0
nonwearCount = 0
otherCount = 0

head(combinedLabels)


#combinedLabels$NoneProp <- combinedLabels$None/combinedLabels$TOTAL_LABELS
combinedLabels$BlankProp <- combinedLabels$blank/combinedLabels$TOTAL_LABELS
combinedLabels$HighsignalProp <- combinedLabels$highsignal/combinedLabels$TOTAL_LABELS
combinedLabels$LowsignalProp <- combinedLabels$lowsignal/combinedLabels$TOTAL_LABELS
combinedLabels$AmbulationProp <- combinedLabels$ambulation/combinedLabels$TOTAL_LABELS
combinedLabels$SedentaryProp <- combinedLabels$sedentary/combinedLabels$TOTAL_LABELS
combinedLabels$SleepProp <- combinedLabels$sleep/combinedLabels$TOTAL_LABELS
combinedLabels$NonwearProp <- combinedLabels$nonwear/combinedLabels$TOTAL_LABELS
combinedLabels$NotTheseProp <- combinedLabels$notthese/combinedLabels$TOTAL_LABELS

head(combinedLabels)
tail(combinedLabels)

## for ground truth only

temCombine <- na.omit(combinedLabels)

temCombine <- subset(temCombine, temCombine$TIME_STAMP < endDateTime)

## for participant data only
#combinedLabels <- na.omit(combinedLabels)

##combinedLabels$LABEL_FINAL <- factor(combinedLabels$RESULTING_LABEL, levels =c("none","highsignal","lowsignal","ambulation","sedentary","sleep","nonwear","other"))

