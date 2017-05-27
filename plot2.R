#plot2
library(readr)
library(dplyr)
library(lubridate)

#read in entire dataset
data1 <- read_csv2("C:/Users/Nese/Documents/Coursera/R Specialization/4) Exploratory Data Analysis/Week 1/exdata_data_household_power_consumption/household_power_consumption.txt")

#subset the data to relevant dates
data2 <- data1[data1$Date %in% c("1/2/2007", "2/2/2007"),]

#changing 'Date' column from character to date class
data2 <- mutate(data2, Date = as.Date(Date, "%d/%m/%Y"))

#add new column called 'datetime', which combines 'Date' and 'Time' values into 'POSIXct' class
data2$datetime <- with (data2, as.POSIXct(paste(format(Date, "%d/%m/%Y"), Time), format="%d/%m/%Y %H:%M:%S"))

#convert 'Global active power' values to numeric
z <- as.numeric(data2$Global_active_power)

#open PNG device and create png file called 'plot2' in my working directory
png("plot2.png", width = 480, height = 480)

#create plot and and send to png file
plot(z ~ data2$datetime, data2, type="l", ylab="Global Active Power (kilowatts)", xlab="", main="")

#close graphics device
dev.off()
    