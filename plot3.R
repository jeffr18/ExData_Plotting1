# Plot 3 - Create plot based on example 3 - Multi-line graph showing the 3 different submetering
# values across the subsetted timeframe.

# File-wide variables (constants).  These are used throughout the rest of the code
dataFilePath <- "./data/household_power_consumption.txt"
pngFilePath <- "./plot3.png"
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
       col=c(sm1LineColor, sm2LineColor, sm3LineColor))


# Close PNG graphics device
dev.off()