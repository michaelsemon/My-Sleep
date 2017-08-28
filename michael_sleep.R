library(ggplot2)
library(ggthemes)
library(Amelia)
library(corrplot)
library(dplyr)
library(tidyr)
library(lubridate)
library(MASS)
library(caTools)

## data clean / prep ##

sleep <- read.csv('sleepdata.csv',sep = ';')
sleep[,3:5] <- sapply(sleep[,3:5],as.numeric)

sleep <- as.data.frame(sleep) %>% subset(sleep$Sleep.quality > 5)

sleep$Start <- as.POSIXct(sleep$Start,format= '%Y-%m-%d %H:%M:%S') #2014-07-30 23:12:48
sleep$End <- as.POSIXct(sleep$End,format= '%Y-%m-%d %H:%M:%S')
sleep$Sleep.time <- ((sleep$End - sleep$Start)/60) %>% as.numeric # csv error, could not get time.in.bed
sleep$hour <- hour(sleep$Start) #create hour column

## explore / visualizations ##

sleep.numeric <- sapply(sleep,is.numeric) %>% as.matrix
sleep.numeric <- sleep[,sleep.numeric]
sleep.cor <- cor(sleep.numeric)
#print(corrplot(sleep.cor,method='circle'))

pl1 <- ggplot(sleep,aes(Start,Sleep.quality)) + geom_point(aes(color=Sleep.time)) 
pl1 <- pl1 + stat_smooth() + theme_classic() + scale_color_gradient(low='blue',high='green')
print(pl1)





