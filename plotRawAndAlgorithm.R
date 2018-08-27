#### Use this script to plot features and prediction combines

####$ import libraries
library(psych)
library(ggplot2)
library(plotly)
library(dplyr)
library(MASS)

#### Interactive plot for acceleration 1 hour file

accPlot <- plot_ly(accHour, x = ~HEADER_TIME_STAMP, y = ~X_ACCELERATION_METERS_PER_SECOND_SQUARED, 
                   name = 'X_acc', type = 'scatter', legendgroup = "RAW", mode = 'lines') %>%
  add_trace(y = ~Y_ACCELERATION_METERS_PER_SECOND_SQUARED, name = 'Y_acc', mode = 'lines') %>%
  add_trace(y = ~Z_ACCELERATION_METERS_PER_SECOND_SQUARED, name = 'Z_acc', mode = 'lines')

#accPlot

# c("white", "grey", "cyan", "blue", "green", "yellow", "orange", "red")

## High Signal = 8
## Ambulation = 7
## Other = 6
## Sedentary = 5
## Sleep = 4
## Non-wear = 3
## Low signal = 2
## No label = 1

featuretest <- featureHour

featuretest$MDCAS_PREDICTION  <- factor(featuretest$MDCAS_PREDICTION , levels =c("Nonwear","sleep", "sedentary", "notthese", "ambulation"))

featureCol <- c("thistle", "skyblue", "navy", "green2", "gold3", "orangered3")

featurePlot <- plot_ly(featuretest, x = ~START_TIME, y = ~MDCAS_PREDICTION_PROB, 
                   name = 'Prediction', type = 'bar', legendgroup = "ALGO", color = ~MDCAS_PREDICTION, 
                   colors = featureCol) ##%>%
 ## add_trace(y = ~Y_ACCELERATION_METERS_PER_SECOND_SQUARED, name = 'Y_acc', mode = 'lines') %>%
  ##add_trace(y = ~Z_ACCELERATION_METERS_PER_SECOND_SQUARED, name = 'Z_acc', mode = 'lines')

#featurePlot

#saveHTMLPath = "C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/SEDENTARY_GROUND_TRUTH.html"

subP <- subplot(style(accPlot, showlegend = TRUE), style(featurePlot, showlegend = TRUE), nrows = 2, margin = 0.05, shareX = TRUE)

### Save the plot as HTML and skip pandoc execution

# htmlwidgets::saveWidget(subP, saveHTMLPath, selfcontained = FALSE)
# transforms = list(
#   list(
#     type = 'groupby',
#     groups = featureHour$cyl,
#     styles = list(
#       list(target = 4, value = list(marker =list(color = 'blue'))),
#       list(target = 6, value = list(marker =list(color = 'red'))),
#       list(target = 8, value = list(marker =list(color = 'black')))
#     )))


saveCombo = "C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/AMB_SLEEP_NONWEAR_2/AMB_SLEEP_NONWEAR_2.html"

htmlwidgets::saveWidget(subP, saveCombo, selfcontained = FALSE)
