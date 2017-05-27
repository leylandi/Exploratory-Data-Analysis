#plot1
library(readr)

#read in entire dataset
data1 <- read_csv2("C:/Users/Nese/Documents/Coursera/R Specialization/4) Exploratory Data Analysis/Week 1/exdata_data_household_power_consumption/household_power_consumption.txt")

#subset the data to relevant dates
data2 <- data1[data1$Date %in% c("1/2/2007", "2/2/2007"),]

#convert 'global active power' values from character to numeric
z <- as.numeric(data2$Global_active_power)

#open PNG device and create png file called 'plot1' in working directory
png("plot1.png", width = 480, height = 480)

#create histogram and send to png file
hist(z, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#close png graphics device
dev.off()