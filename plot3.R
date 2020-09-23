# Loads required libraries
library(tidyr)
# Loads the data by read.csv, considering that missing values are represented as ? 
energy_data <- read.csv("household_power_consumption.txt", na.strings="?", header=T, sep = ";", quote = "")
# Subset only data from the days 1/2/2007 and 2/2/2007
energy_data <- subset(energy_data, Date %in% c("1/2/2007","2/2/2007"))
# Unite multiple columns (Date,Time) into one, called Date_Time
energy_data<- unite(energy_data, Date_Time, c(Date,Time), sep = " ", remove=F)
# Set data as as.POSIXct objetic
energy_data$Date_Time <- as.POSIXct(energy_data$Date_Time, format= "%d/%m/%Y %H:%M:%S") #it won't work with strptime()
# Set the margins of the painel by passing a 4-long vector into par()
par(mar=c(4,4,2,2))
# Plot line plots of Sub_metering_1/2/3 as a function of Date_Time in energy_data dataframe
plot(Sub_metering_1~Date_Time, energy_data, type="l",ylab="Global Active Power (kilowatts)", xlab="")
lines(Sub_metering_2~Date_Time,energy_data,type="l",col="red")
lines(Sub_metering_3~Date_Time,energy_data,type="l", col="blue")
legend(legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),"topright", col=c("black", "red", "blue"), lty=1, xjust = 0.5, yjust = 0.5)
#Save .png file of 480X480 px
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
