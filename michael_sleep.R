library(ggplot2)
library(ggthemes)
library(Amelia)
library(corrplot)
library(dplyr)
library(tidyr)
library(lubridate)
library(MASS)
library(caTools)
library(neuralnet)
library(scales)


# data clean / prep
sleep <- read.csv('sleepdata.csv',sep = ';')
sleep[,3:5] <- sapply(sleep[,3:5],as.numeric)

sleep <- as.data.frame(sleep) %>% subset(sleep$Sleep.quality > 5)

sleep$Start <- as.POSIXct(sleep$Start,format= '%Y-%m-%d %H:%M:%S') #2014-07-30 23:12:48
sleep$End <- as.POSIXct(sleep$End,format= '%Y-%m-%d %H:%M:%S')
sleep$Sleep.time <- (sleep$End - sleep$Start)/60 # csv error, could not get time.in.bed
sleep$hour <- hour(sleep$Start) #create hour column

# explore 


pl1 <- ggplot(sleep,aes(Start,Sleep.quality)) + geom_point(aes(color=Sleep.time)) + scale_color_gradient(low='blue',high='green')
print(pl1)