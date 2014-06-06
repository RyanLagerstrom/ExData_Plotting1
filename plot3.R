plot3 <- function( filename = "plot3.png") {
  
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
  
  # plote dateTime versus the 3 sub metering readings
  plot(dateTime, powerDataSub$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(dateTime, powerDataSub$Sub_metering_2, col = "red")
  lines(dateTime, powerDataSub$Sub_metering_3, col = "blue")
  legend("topright", lty = 1, col = c("black","red","blue"), legend = names(powerDataSub)[7:9])

  # close device
  dev.off()
  
}