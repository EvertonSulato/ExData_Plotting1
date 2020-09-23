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
# Plot line plot of Global_active_power as a function of Date_Time in energy_data dataframe
plot(Global_active_power~Date_Time, energy_data,type="l",names=c("Thu", "Fri", "Sat"), ylab="Global Active Power (kilowatts)", xlab="")
#Save .png file of 480X480 px
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()

