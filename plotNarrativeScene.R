library(plotly)



narrativeTimeRange <- plot_ly(narrativeTime, x=~msgIndex, y=~seconds, type = "box")%>%
  layout(xaxis = list(title = "Message no."), yaxis = list(title = "Time spent in seconds"),title = "Distribution of time spent in each message")



narrativeTimeSpent <- plot_ly(narrativeAvgTime, x=~Level,y=~AverageTime, name = "Time spent on message", type = "scatter", mode = 'lines')%>% layout(xaxis = list(title = "Message no."), yaxis = list(title = "Seconds spent"),
                                                                                                                                                 title = "Average seconds spent per message")

narrativeTimeSpentMedian <- plot_ly(narrativeAvgTimeMedian, x=~Level,y=~MedianTime, name = "Time spent on message", type = "scatter", mode = 'lines')%>% layout(xaxis = list(title = "Message no."), yaxis = list(title = "Seconds spent"),
                                                                                                                                                     title = "Average seconds spent per message (median)")
