# Read the CSV file from a folder in a working directory
file <- "exdata-data-household_power_consumption/household_power_consumption.txt" 
data = read.csv(file, header=TRUE, sep=";", stringsAsFactors=FALSE)

# Convert needed columns to specified types
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# Set locale to english to assure correct date texts
Sys.setlocale("LC_TIME", "English")

# Select values between 2007-02-01 and 2007-02-02
data <- data[data$Date >= as.Date("2007-02-01",  "%Y-%m-%d") 
             & data$Date <= as.Date("2007-02-02",  "%Y-%m-%d"), ]

# Merge Date and time values to get exact time
DateTime <- paste(data$Date, data$Time)
data <- cbind(data, DateTime, stringsAsFactors = FALSE)
data$DateTime <- strptime(data$DateTime, format = "%Y-%m-%d %H:%M:%S")


# Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
library(datasets)
par(mfrow=c(1,1)) 
png(filename="plot3.png", width=480, height=480)

plot(data$DateTime, data$Sub_metering_1, ylab="Energy sub metering", 
     xlab="", main="", type="l")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
