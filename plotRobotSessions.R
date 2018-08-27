library(plotly)

robotVisits <- plot_ly(totalVisitsFromLevel, x=~Level,y=~NoVisits, name = "No of visits", type = "scatter", mode = 'lines')%>% layout(xaxis = list(title = "From level"), yaxis = list(title = "No. of visits"),
                                                                                                                                                     title = "No. of visits from each level")


visitsFromUsers <- plot_ly(userVisits, x=~Level,y=~NoVisits, name = "No of visits", type = "scatter", mode = 'lines')%>% layout(xaxis = list(title = "From user"), yaxis = list(title = "No. of visits"),
                                                                                                                                      title = "No. of visits from each user")

timeSpentByUsers <- plot_ly(TimeByUser, x=~userID,y=~Seconds, name = "Time spent", type = "scatter", mode = 'lines')%>% layout(xaxis = list(title = "User"), yaxis = list(title = "Time spent"),
                                                                                                                                title = "Time spent in robot garage")


timeSpentByUsersMedian <- plot_ly(TimeByUserMedian, x=~userID,y=~Seconds, name = "Time spent", type = "scatter", mode = 'lines')%>% layout(xaxis = list(title = "User"), yaxis = list(title = "Time spent"),
                                                                                                                               title = "Time spent in robot garage (median)")


