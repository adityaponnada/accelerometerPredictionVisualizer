library(plotly)

#featuretest$MDCAS_PREDICTION  <- factor(featuretest$MDCAS_PREDICTION , levels =c("Nonwear","sleep", "sedentary", "notthese", "ambulation"))

labelPropFile$MDCAS_LABEL  <- factor(labelPropFile$MostProbableLabel , levels =c("Ambulation","NonWear", "Sedentary", "NotThese", "Sleep"))

#featureCol <- c("thistle", "skyblue", "navy", "green2", "gold3", "orangered3")

labelCol <- c("orangered3", "thistle", "green2", "gold3", "skyblue")

#labelCol <- c("thistle", "skyblue", "navy", "green2", "gold3", "orangered3")


#labelPropFile$FinalLabelProp <- as.numeric(labelPropFile$FinalLabelProp)

labelPropPlot <- plot_ly(labelPropFile, x = ~DATE_TIME, y = ~MaxProp, 
                       name = 'estimated', type = 'bar', legendgroup = "Playerlabels", color = ~MDCAS_LABEL, 
                       colors = labelCol)

