library(tidyverse)
library(lubridate)
#loads necessary libraries
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip',
              destfile='exdata_data_household_power_consumption.zip')
unzip("exdata_data_household_power_consumption.zip")
#unzips downloaded zip folder
power <- read.table('household_power_consumption.txt',header=TRUE,sep=';')
#reads text file into table
power$Date<-strptime(power$Date,'%d/%m/%Y')
#converts date column to POSIXlt format
power$Date <- unclass(as.Date(power$Date))
#unclasses date column into numeric string
unclass(as.Date('2007-02-01'))
unclass(as.Date('2007-02-02'))
#outputs numerics for those two dates
febpower<-power %>% filter(Date == 13545 | Date == 13546)
#creates new variable to include only february 1-2,2007
febpower$Date <- as.Date(febpower$Date,origin='1970-01-01')
#converts the POSIXct format back to POSIXlt format
febpower$Global_active_power<-as.numeric(as.character(febpower$Global_active_power))
#converts Global_active_power column to numeric
febpower <- febpower %>% mutate(date_time = paste(febpower$Date, febpower$Time,sep=' '))
#creates new column date_time to combine Date and Time columns
febpower$date_time <- strptime(febpower$date_time, '%Y-%m-%d %H:%M:%S')
#converts date_time column to POSIXlt format
febpower[,7] <- as.numeric(as.character(febpower[,7]))
febpower[,8] <- as.numeric(as.character(febpower[,8]))
#converts sub_metering_1&2 from factor variables to numeric variables
dev.off
#sets default parameters
par(mfrow=c(2,2),mar=c(4,4,1,1))
#sets new plot dimensions 2x2
with(febpower,plot(date_time,Global_active_power,type='l',xlab='',
                      ylab='Global Active Power'))
#creates topleft plot
febpower$Voltage <- as.numeric(as.character(febpower$Voltage))
#converts factor variable Voltage to numeric
with(febpower,plot(date_time,Voltage,type='l',xlab='datetime'))
#creates topright plot
with(febpower,plot(date_time,Sub_metering_1,type='n',xlab='',ylab='Energy sub metering'))
#creates empty plot
points(febpower$date_time,febpower$Sub_metering_1,type='l')
points(febpower$date_time,febpower$Sub_metering_2,type='l',col='red')
points(febpower$date_time,febpower$Sub_metering_3,type='l',col='blue')
#adds three columns of data in different colors
legend('topright', pch = '_' , col = c('black','red','blue') , bty='n' , cex=0.8, 
       legend =c('Sub_metering_1','Sub_metering_2','Sub_metering_3'))
#creates bottomleft plot
febpower$Global_reactive_power <- as.numeric(as.character(febpower$Global_reactive_power))
#converts reactive power from factor to numeric
with(febpower , plot(date_time,Global_reactive_power,type='l',xlab='datetime',yaxt='n'))
axis(2, at = seq(0.0, 0.5, by = 0.10) , cex.axis=0.8)
#creates bottomright plot
#(4) 4 plots on one screen
dev.copy(png,file='plot4.png',width=480,height=480)
dev.off()     