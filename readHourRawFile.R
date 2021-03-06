#### Use this script to read the raw 1 hour accelerometer file

####$ import libraries
library(psych)
library(ggplot2)
library(plotly)
library(dplyr)
library(MASS)
options(digits.secs =3)

#### Read the raw filehead

##inPath = "C:/Users/Dharam/Downloads/MDCAS Files/GroundTruthFiles/MDCAS_Ground/RAW_UNLABELED_SPADES_2DAY/SPADES_2/MasterSynced/2015/10/06/12/ActigraphGT9X-AccelerationCalibrated-NA.TAS1E23150075-AccelerationCalibrated.2015-10-06-12-00-00-000-M0400.sensor.csv"
#inPath = "C:/Users/Dharam/Downloads/MDCAS Files/GroundTruthFiles/MDCAS_Ground/ADITYA_SLEEP_4/MasterSynced/2018/01/25/03/ActigraphGT9X-AccelerationCalibrated-NA.TAS1E23150058-AccelerationCalibrated.2018-01-25-03-00-00-000-M0500.sensor.csv"

inPath = "C:/Users/Dharam/Downloads/MDCAS Files/SIMULATED_DATA/Jumbled/Version1/AMB_SLEEP_NONWEAR.csv"

accHour <- read.csv(inPath, sep = ",", header = TRUE)

head(accHour)
tail(accHour)

###@# Convert time to date time object
accHour$HEADER_TIME_STAMP <- as.POSIXct(accHour$HEADER_TIME_STAMP, format = "%Y-%m-%d %H:%M:%OS")
class(accHour$HEADER_TIME_STAMP)

