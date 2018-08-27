library(plotly)

playPerSecPlot <- plot_ly(playersPerSecond, x = ~TIME, y = ~COUNT, 
                   name = 'Total-players', type = 'scatter', legendgroup = "PlayerNo", mode = 'lines', color = I('black'))

