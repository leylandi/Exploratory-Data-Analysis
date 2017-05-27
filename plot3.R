#plot3
library(readr)
library(dplyr)
library(lubridate)

#read in entire dataset
data1 <- read_csv2("C:/Users/Nese/Documents/Coursera/R Specialization/4) Exploratory Data Analysis/Week 1/exdata_data_household_power_consumption/household_power_consumption.txt")

#subset the data to include relevant dates only
data2 <- data1[data1$Date %in% c("1/2/2007", "2/2/2007"),]

#convert sub metering columns to numeric values
x <- as.numeric(data2$Sub_metering_1)
y <- as.numeric(data2$Sub_metering_2)
z <- as.numeric(data2$Sub_metering_3)

#change 'Date' column from character to date class
data2<- mutate(data2, Date = as.Date(Date, "%d/%m/%Y"))

#create a new column called 'datetime', which combines 'Date' and 'Time' columns into 'POSIXct' class
data2$datetime <- with (data2, as.POSIXct(paste(format(Date, "%d/%m/%Y"), Time), format="%d/%m/%Y %H:%M:%S"))

#open PNG device and create png file called 'plot3' in working directory
png("plot3.png", width = 480, height = 480)

#create plot and and send to png file
with(data2, {
    plot(x ~ datetime, type="l", ylab = "Energy sub metering", xlab="", ylim = c(0, max(x, y, z)))
    lines(y ~ datetime, type = "l", col = "red")
    lines(z ~ datetime, type = "l", col = "blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1.5, col=c("black", "red", "blue"))
})

#close graphics device
dev.off()