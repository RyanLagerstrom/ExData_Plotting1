plot4 <- function( filename = "plot4.png") {
  
  # load power data (assumed to be in the working directory)
  powerData <- read.table("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", stringsAsFactors = FALSE)
  
  # create a date variable
  temp <- as.Date(powerData$Date, "%d/%m/%Y")
  dates <- format(temp, "%m %d %Y")
  
  # subset the power data to the 1st and 2nd Feb 2007
  ind <- (dates == "02 01 2007") | (dates == "02 02 2007")
  powerDataSub <- powerData[ind,]
  
  # set up a datetime varaible
  temp <- paste(powerDataSub$Date, powerDataSub$Time)
  dateTime <- strptime( temp, "%d/%m/%Y %H:%M:%S")
  
  # set up png graphics device
  png(filename, width = 480, height = 480)
  
  # produce for plots in a 2 x 2 layout
  par(mfrow = c(2,2))
  plot(dateTime, powerDataSub$Global_active_power, typ="l", ylab = "Global Active Power", xlab = "")
  plot(dateTime, powerDataSub$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
  plot(dateTime, powerDataSub$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(dateTime, powerDataSub$Sub_metering_2, col = "red")
  lines(dateTime, powerDataSub$Sub_metering_3, col = "blue")
  legend("topright", lty = 1, col = c("black","red","blue"), bty = "n", legend = names(powerDataSub)[7:9], pt.cex=1,cex=0.9)
  plot(dateTime, powerDataSub$Global_reactive_power, xlab = "datetime", ylab = names(powerDataSub)[4], type = "l")
  
  # close device
  dev.off()
  
}
  