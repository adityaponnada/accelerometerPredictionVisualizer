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

labelPath = "C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/FromEC2/May-7-2018-9%3A07/https%3A/s3.us-east-2.amazonaws.com/mdcas-signal/data/SPADES_2/MasterSynced/2015/10/06/12/labels.csv"

labelFile <- read.csv(labelPath, sep = ",", header = FALSE, skip = 1)

labelhead <- head(labelFile, 10)

labelhead$userID <- c(1:nrow(labelhead))

levs <- c("0", "highsignal", "lowsignal", "ambulation", "sedentary", "sleep", "nonwear", "other")

labelFreq <- sapply(labelhead, function(x) table(factor(x, levels = levs, ordered = TRUE)))

labelFreq <- as.data.frame(labelFreq)

#labelhead = labelhead[, !names(labelhead)%in%c("V3600")]

#labelhead[ , !c("V3600")]

names(labelhead)[1:3600] <- c(0:3599)



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


for (i in 1:ncol(labelhead)-1){
  
  tempDateAndTime = startdateTime
  
  tempDateAndTime = tempDateAndTime + i-1
  names(labelhead)[i] = as.character(tempDateAndTime)
  
  print(paste0("i is ", i))
  
}

newLabelhead <- melt(labelhead, id.var = 'userID')

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
## No label = 1

newLabelhead$value <- as.factor(newLabelhead$value)

# newLabelhead <- data.frame(lapply(newLabelhead, function(x) {
#   gsub("0", 1, x)
# }))

newLabelhead$labelCode[newLabelhead$value == "0"] <- 0
newLabelhead$labelCode[newLabelhead$value == "ambulation"] <- 7
newLabelhead$labelCode[newLabelhead$value == "lowsignal"] <- 2
newLabelhead$labelCode[newLabelhead$value == "other"] <- 6





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
combinedLabels$TIME_STAMP <- names(labelhead)

# colnames(combinedLabels)[1] <- "TIME_STAMP"
# 
 colnames(combinedLabels)[1] <- "None"

### Convert to date time object
combinedLabels$TIME_STAMP <- as.POSIXct(combinedLabels$TIME_STAMP, format = "%Y-%m-%d %H:%M:%S")

class(combinedLabels$TIME_STAMP)


combinedLabels$RESULTING_LABEL <- NA
combinedLabels$RESULTING_PROB <- NA

combinedLabels$TOTAL_LABELS <- combinedLabels$None + combinedLabels$highsignal + 
  combinedLabels$lowsignal + combinedLabels$ambulation +
  combinedLabels$sedentary + combinedLabels$sleep +
  combinedLabels$nonwear + combinedLabels$other


combinedLabels <- combinedLabels[-nrow(combinedLabels),]

noneCount = 0
highSignalCount = 0
lowSignalCount = 0
ambulationCount = 0
sedentaryCount = 0
sleepCount = 0
nonwearCount = 0
otherCount = 0

for (i in 1:nrow(combinedLabels)){
  print(paste0("Inside row number: ", i))
  
  
  storeVals <- c(combinedLabels$None[i], combinedLabels$highsignal[i], combinedLabels$lowsignal[i], combinedLabels$ambulation[i],
                 combinedLabels$sedentary[i], combinedLabels$sleep[i], combinedLabels$nonwear[i], combinedLabels$other[i])
  
  combinedLabels$RESULTING_PROB[i] <- max(storeVals)/combinedLabels$TOTAL_LABELS[i]
  print(paste0("Highest is: ", combinedLabels$RESULTING_PROB[i]))
  
  if (which(storeVals == max(storeVals)) == 1){
    
    combinedLabels$RESULTING_LABEL[i] <- "none"
    print(paste0("Label is: ", combinedLabels$RESULTING_LABEL[i]))
    
  } else if (which(storeVals == max(storeVals)) == 2) {
    combinedLabels$RESULTING_LABEL[i] <- "highsignal"
    print(paste0("Label is: ", combinedLabels$RESULTING_LABEL[i]))
    
  } else if (which(storeVals == max(storeVals)) == 3) {
    combinedLabels$RESULTING_LABEL[i] <- "lowsignal"
    print(paste0("Label is: ", combinedLabels$RESULTING_LABEL[i]))
    
  } else if (which(storeVals == max(storeVals)) == 4) {
    combinedLabels$RESULTING_LABEL[i] <- "ambulation"
    print(paste0("Label is: ", combinedLabels$RESULTING_LABEL[i]))
    
  } else if (which(storeVals == max(storeVals)) == 5){
    combinedLabels$RESULTING_LABEL[i] <- "sedentary"
    print(paste0("Label is: ", combinedLabels$RESULTING_LABEL[i]))
    
  } else if (which(storeVals == max(storeVals)) == 6) {
    combinedLabels$RESULTING_LABEL[i] <- "sleep"
    print(paste0("Label is: ", combinedLabels$RESULTING_LABEL[i]))
    
  } else if (which(storeVals == max(storeVals)) == 7) {
    combinedLabels$RESULTING_LABEL[i] <- "nonwear"
    print(paste0("Label is: ", combinedLabels$RESULTING_LABEL[i]))
    
  } else if (which(storeVals == max(storeVals)) == 8) {
    combinedLabels$RESULTING_LABEL[i] <- "other"
    print(paste0("Label is: ", combinedLabels$RESULTING_LABEL[i]))
    
  }
  
  
}

head(combinedLabels)


combinedLabels$LABEL_FINAL <- factor(combinedLabels$RESULTING_LABEL, levels =c("none","highsignal","lowsignal","ambulation","sedentary","sleep","nonwear","other"))

##############################

labelCol <- c("white","red1","lightcyan3","orangered3","green2", "navy", "grey41","gold3")

labelPlot <- plot_ly(combinedLabels, x = ~TIME_STAMP, y = ~RESULTING_PROB, 
                       name = 'Prediction', type = 'bar', legendgroup = "ALGO", color = ~LABEL_FINAL, 
                       colors = labelCol)



testPlot <- plot_ly(newLabelhead, x = ~DATE_TIME, y = ~userID, z = ~labelCode, type = "heatmap", 
                    colors = c("white", "grey41", "skyblue", "navy", "green2", "gold3", "orangered3", "red"),
                    legendgroup = "GAME")




subPlotFinal <- subplot(style(testPlot, showlegend = TRUE),style(accPlot, showlegend = TRUE), style(featurePlot, showlegend = TRUE),  
                        nrows = 3, margin = 0.05, shareX = TRUE)


subPlotFinal

### Save the plot as HTML and skip pandoc execution
saveFinalPlot = "C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/sampleHourCombined.html"

htmlwidgets::saveWidget(subPlotFinal, saveFinalPlot, selfcontained = FALSE)
