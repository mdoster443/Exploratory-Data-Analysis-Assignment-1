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
#converts date_time column to POSIXlt formate
dev.off()
#reset default parameters
with(febpower,plot(date_time,Global_active_power,type='l',xlab='',
                   ylab='Global Active Power (kilowatts)'))
#(2) constructs 2nd plot
dev.copy(png,file='plot2.png',width=480,height=480)
#copies plot to PNG file
dev.off() 