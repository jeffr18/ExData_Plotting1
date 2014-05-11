# Plot 4 - Create plot based on example 4 - Four plots showing:
# 1) Line graph showing the global active power values across the subsetted timeframe
# 2) Line graph showing the voltage value across subsetted timeframe
# 3) Multi-line graph showing the 3 different submetering values across the subsetted timeframe.
# 4) Line graph showing the global reactive power values across the subsetted timeframe

# File-wide variables (constants).  These are used throughout the rest of the code
dataFilePath <- "./data/household_power_consumption.txt"
pngFilePath <- "./plot4.png"
pngFileWidth <- 480
pngFileHeight <- 480
dateFromFilter <- strptime("2007-02-01 00:00:00", format="%Y-%m-%d %H:%M:%S") 
dateToFilter <- strptime("2007-02-02 23:59:59", format="%Y-%m-%d %H:%M:%S") 
readInRowCount <- -1    #adjust this to read in sample data. -1 will read in all data.

# Read in data into a data frame
rawData <- read.table(dataFilePath, header=TRUE, sep=";", na.strings="?", nrows=readInRowCount)

# Convert date and time factor variables to proper date/time class - Save in new DateTime column
rawData$DateTime <- strptime(paste(rawData$Date, rawData$Time), format="%d/%m/%Y %H:%M:%S")

# Subset data between date filters defined above
filteredData <- subset(rawData, rawData$DateTime >= dateFromFilter & rawData$DateTime <= dateToFilter)


# Open PNG graphics device
png(file = pngFilePath, width=pngFileWidth, height=pngFileHeight)

# Configure plot layout - 2 rows, 2 columns
par(mfrow=c(2,2))


# Upper-Left - (same as plot2.R)
plot(filteredData$DateTime, filteredData$Global_active_power, xlab="",ylab="Global Active Power", type="l")


# Upper-Right
plot(filteredData$DateTime, filteredData$Voltage, xlab="datetime",ylab="Voltage", type="l")


# Lower-Left - (same as plot3.R)
# Define line colors
sm1LineColor <- "black"
sm2LineColor <- "Red"
sm3LineColor <- "Blue"

# Create plot (multi-line graph)
plot(filteredData$DateTime, filteredData$Sub_metering_1, xlab="",ylab="Energy sub metering", type="n")
points(filteredData$DateTime, filteredData$Sub_metering_1, col=sm1LineColor, type="l")
points(filteredData$DateTime, filteredData$Sub_metering_2, col=sm2LineColor, type="l")
points(filteredData$DateTime, filteredData$Sub_metering_3, col=sm3LineColor, type="l")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, 
       col=c(sm1LineColor, sm2LineColor, sm3LineColor), bty="n")


# Lower-Right
plot(filteredData$DateTime, filteredData$Global_reactive_power, xlab="datetime",ylab="Global_reactive_power", type="l")


# Close PNG graphics device
dev.off()