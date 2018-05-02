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


featurePlot <- plot_ly(featureHour, x = ~START_TIME, y = ~MDCAS_PREDICTION_PROB, 
                   name = 'Prediction', type = 'bar', legendgroup = "ALGO", color = ~MDCAS_PREDICTION) ##%>%
 ## add_trace(y = ~Y_ACCELERATION_METERS_PER_SECOND_SQUARED, name = 'Y_acc', mode = 'lines') %>%
  ##add_trace(y = ~Z_ACCELERATION_METERS_PER_SECOND_SQUARED, name = 'Z_acc', mode = 'lines')

#featurePlot

saveHTMLPath = "C:/Users/Dharam/Downloads/MDCAS Files/MDCAS_ALGO_RAW_VIZ/Oct_7_2015_02HRS.html"

subP <- subplot(style(accPlot, showlegend = TRUE), style(featurePlot, showlegend = TRUE), nrows = 2, margin = 0.05, shareX = TRUE)

### Save the plot as HTML and skip pandoc execution

htmlwidgets::saveWidget(subP, saveHTMLPath, selfcontained = FALSE)
