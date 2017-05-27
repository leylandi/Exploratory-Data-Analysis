#plot4
library(readr)
library(dplyr)
library(lubridate)

#read in entire dataset
data1 <- read_csv2("Coursera/R Specialization/4) Exploratory Data Analysis/Week 1/exdata_data_household_power_consumption/household_power_consumption.txt")

#subset the data to include relevant dates only
data2 <- data1[data1$Date %in% c("1/2/2007", "2/2/2007"),]

#change 'Date' column from character to date class
data2<- mutate(data2, Date = as.Date(Date, "%d/%m/%Y"))

#create a new column called 'datetime', which combines 'Date' and 'Time' columns into 'POSIXct' class
data2$datetime <- with (data2, as.POSIXct(paste(format(Date, "%d/%m/%Y"), Time), format="%d/%m/%Y %H:%M:%S"))

#convert specified columns to numeric values
cols <- c(3,4,5,7,8,9)
data2[,cols] <- apply(data2[,cols], 2, function(x) as.numeric(x))

#divide voltage values by 1000
v <- data2$Voltage/1000

#open PNG device and create png file called 'plot4' in working directory
png("plot4.png", width = 480, height = 480)

#set global graphics parameters to 2 rows and 2 columns
par(mfrow = c(2, 2), mar= c(5,4,2,1))

#create plots and and send to png file
with(data2, {
    plot(Global_active_power ~ datetime, type="l", ylab="Global Active Power", xlab="", main="")
    plot(v ~ datetime, type="l", ylab = "Voltage", xlab="datetime")
    plot(Sub_metering_1 ~ datetime, type="l", ylab = "Energy sub metering", xlab="")
    lines(Sub_metering_2 ~ datetime, type = "l", col = "red")
    lines(Sub_metering_3 ~ datetime, type = "l", col = "blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1.5, col=c("black", "red", "blue"), bty="n")
    plot(Global_reactive_power ~ datetime, type="l", ylab = "Global_reactive_power", xlab="datetime")
})

#close graphics device
dev.off()