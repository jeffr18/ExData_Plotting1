# Plot 2 - Create plot based on example 2 - Line graph showing the global active power values
# across the subsetted timeframe

# File-wide variables (constants).  These are used throughout the rest of the code
dataFilePath <- "./data/household_power_consumption.txt"
pngFilePath <- "./plot2.png"
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

# Create plot (line graph)
plot(filteredData$DateTime, filteredData$Global_active_power, xlab="",ylab="Global Active Power (kilowatts)", type="l")

# Close PNG graphics device
dev.off()