library(plotly)


#### Total levels played by each player

levelsPlayed <- plot_ly(x=~userSessions$TotalLevels, name = "Players levels", type = "bar")%>% layout(xaxis = list(title = "Total levels played"), yaxis = list(title = "Player"),
                                                                             title = "Total levels played by each user")



levelFreqPlot <- plot_ly(levelSummary, x=~currentLevel,y=~freq, name = "Level frequency", type = "scatter", mode = 'lines')%>% layout(xaxis = list(title = "Level no."), yaxis = list(title = "Count"),
                                                                              title = "Total times played")

levelTimeSpent <- plot_ly(levelSessionLength, x=~Level,y=~AverageTime, name = "Time spent on level", type = "scatter", mode = 'lines')%>% layout(xaxis = list(title = "Level no."), yaxis = list(title = "Seconds played"),
                                                                                                            title = "Average seconds played per level")

levelTimeSpentMedian <- plot_ly(levelSessionLengthMedian, x=~Level,y=~MedianTime, name = "Time spent on level", type = "scatter", mode = 'lines')%>% layout(xaxis = list(title = "Level no."), yaxis = list(title = "Seconds played"),
                                                                                                                                                 title = "Median seconds played per level")


levelGameResult <- plot_ly(finalLevelResults, y=~VictoryCount, x = ~Level, name = "Results in level", type = "scatter", mode = "lines", name = "Won")%>% 
  add_trace(y=~DefeatCount, name = "Lost", mode = "lines")%>% 
  layout(xaxis = list(title = "Level no."), yaxis = list(title = "Total wins"),title = "Win/loss in each level")


levelUserPlot <- plot_ly(uniQueUsersPerLevel,y=~number_of_distinct_players, x=~currentLevel, name = "Total players in levels", type = "scatter", mode="lines")%>% 
  layout(xaxis = list(title = "Level no."), yaxis = list(title = "Total players"),title = "Total players per level")


userTimePlot <- plot_ly(x = userTimeData$x, type = "histogram", name = "Players time") %>% 
  add_trace(x = fit$x, y = fit$y, type = "scatter", mode = "lines", fill = "tozeroy", yaxis = "y2", name = "Density") %>% 
  layout(yaxis2 = list(overlaying = "y", side = "right"), xaxis = list(title = "Seconds played"), 
         yaxis = list(title = "No. of players"), title = "Time spent by players")

levelTimeRange <- plot_ly(levelTime, x=~factoredlevels, y=~sessionLength/1000, type = "box")%>%
  layout(xaxis = list(title = "Level no."), yaxis = list(title = "Time spent in seconds"),title = "Distribution of time spent in each level")


levelLabelRange <- plot_ly(levelLabelTime, x=~factoredlevels, y=~participantSeconds, type = "box")%>%
  layout(xaxis = list(title = "Level no."), yaxis = list(title = "Seconds labeled in a level"),title = "Distribution of seconds labeled per level")

levelLabelContribution <- plot_ly(levelLabelLength, x=~Level,y=~LabelTime, name = "Seconds contributed per level", type = "scatter", mode = 'lines')%>% layout(xaxis = list(title = "Level no."), yaxis = list(title = "Seconds contributed"),
                                                                                                                                                         title = "Seconds contributed per level")

# subplot(style(AnkleCountsAllPlot, showlegend = TRUE), style(WristCoountsAllPlot, showlegend = TRUE),
#         style(uEMAAllPlot, showlegend = TRUE), nrows = 3, margin = 0.05)

# subplot(style(levelsPlayed, titleY = T, titleX= T), style(levelFreqPlot, showlegend = FALSE),style(levelTimeSpent, showlegend = FALSE),style(levelGameResult, showlegend = FALSE),
#         style(levelUserPlot, showlegend = FALSE),style(userTimePlot, showlegend = FALSE), nrows = 3, margin = 0.05)
