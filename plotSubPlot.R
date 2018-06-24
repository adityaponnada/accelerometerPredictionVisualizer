#### Read label matrix for each hour file

### Import libraries
library(psych)
library(ggplot2)
library(plotly)
library(dplyr)
library(MASS)
library(plyr)
library(reshape2)




##############################

#labelCol <- c("white","red1","lightcyan3","orangered3","green2", "navy", "grey41","gold3")

# labelPlot <- plot_ly(combinedLabels, x = ~TIME_STAMP, y = ~RESULTING_PROB, 
#                      name = 'Label', type = 'bar', legendgroup = "GAME", color = ~LABEL_FINAL, 
#                      colors = labelCol)



labelsDensity <- plot_ly(temCombine, x = ~TIME_STAMP, y = ~BlankProp, type = 'bar', name = "Left blank", color = I("black"), legendgroup = "GAME") %>%
  add_trace(y = ~HighsignalProp, name = 'High Signal', color = I("red")) %>%
  add_trace(y = ~LowsignalProp, name = 'Low Signal', color = I("grey")) %>%
  add_trace(y = ~AmbulationProp, name = 'Ambulation', color = I("orangered3")) %>%
  add_trace(y = ~SedentaryProp, name = 'Sedentary', color = I("green2")) %>%
  add_trace(y = ~SleepProp, name = 'Sleep', color = I("skyblue")) %>%
  add_trace(y = ~NonwearProp, name = 'Non-wear', color = I("thistle")) %>%
  add_trace(y = ~OtherProp, name = 'Other', color = I("gold3")) %>%
  layout(yaxis = list(title = '% of labels'), barmode = 'stack')


# testPlot <- plot_ly(newLabelhead, x = ~DATE_TIME, y = ~userID, z = ~labelCode, type = "heatmap", 
#                     colors = c("white", "grey41", "skyblue", "navy", "green2", "gold3", "orangered3", "red"),
#                     legendgroup = "GAME")




subPlotFinal <- subplot(style(accPlot, showlegend = TRUE),
                        style(labelsDensity, showlegend = TRUE),
                        style(playPerSecPlot, showlegend = TRUE),
                        style(featurePlot, showlegend = TRUE),
                        nrows = 4, margin = 0.05, shareX = TRUE)


subPlotFinal

### Save the plot as HTML and skip pandoc execution
saveFinalPlot = "C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/MTURK_unlabeled_Sleep.html"

htmlwidgets::saveWidget(subPlotFinal, saveFinalPlot, selfcontained = FALSE)
