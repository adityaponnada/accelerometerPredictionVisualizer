##### Use this script to read the feature computation file

####$ import libraries
library(psych)
library(ggplot2)
library(plotly)
library(dplyr)
library(MASS)
options(digits.secs =3)

##inPathForfeature = "C:/Users/Dharam/Downloads/MDCAS Files/GroundTruthFiles/MDCAS_Ground/RAW_UNLABELED_SPADES_2DAY/SPADES_2/MasterSynced/2015/10/06/12/predictionFile.csv"
inPathForfeature = "C:/Users/Dharam/Downloads/MDCAS Files/GroundTruthFiles/MDCAS_Ground/ADITYA_SED_2/MasterSynced/2017/11/16/11/predictionFile.csv"



featureHour <- read.csv(inPathForfeature, sep = ",", header = TRUE)

head(featureHour)
tail(featureHour)

featureHour$START_TIME <- as.POSIXct(featureHour$START_TIME, format = "%Y-%m-%d %H:%M:%OS")
class(featureHour$START_TIME)