if (!file.exists("./data/household_power_consumption.txt")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./data/power_data.zip", method = "wininet")
    unzip("./data/power_data.zip", overwrite = TRUE, exdir = "./data")
}

dataset <- read.table("./data/household_power_consumption.txt", sep = ";", na.strings = "?", header = TRUE, stringsAsFactors = FALSE)
dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")
begDate <- as.Date("2007-02-01", format = "%Y-%m-%d")
endDate <- as.Date("2007-02-02", format = "%Y-%m-%d")
dataset <- dataset[dataset$Date %in% c(begDate, endDate),]
dataset$Global_active_power <- as.numeric(dataset$Global_active_power)
dataset$Time <- as.POSIXct(paste(dataset$Date,dataset$Time), format="%Y-%m-%d %H:%M:%S")
png(file = "plot4.png")
par(mfrow=c(2,2))
with(dataset, {
  plot(x=Time, y=Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  plot(x=Time, y=Voltage,type="l", xlab="datetime", ylab="Voltage")
  with(dataset, plot(x=Time, y=Sub_metering_1, type="l", ylab="Energy sub metering"))
  with(dataset, lines(x=Time, y=Sub_metering_2, type="l", col="Red"))
  with(dataset, lines(x=Time, y=Sub_metering_3, type="l", col="Blue"))
  legend("topright", lty=1, col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
  plot(x=Time, y=Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
})
dev.off()