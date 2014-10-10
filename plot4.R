data <- read.delim("household_power_consumption.txt", sep = ";", header=TRUE,
                   colClasses="character", na.strings ="?")
png("plot4.png", width=480, height = 480)


time_list <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

trim_list <- (time_list - strptime("2007-02-01", "%Y-%m-%d")) >= 0 & 
  (strptime("2007-02-03", "%Y-%m-%d") - time_list) >= 0

time_list <- time_list[trim_list]

data <- data[trim_list,]

#r <- as.Date(round(range(as.Date(time_list))), "days")

#axis.Date(1, at=seq(r[1], r[2], by="day"),  format="%a")
par(mfrow = c(2,  2))  

plot(x=time_list, y=data$Global_active_power, xlab="", type="l", 
     ylab="Global Active Power")


plot(x=time_list, y=data$Voltage, xlab="datetime", type="l", 
     ylab="Voltage")

with(data,{
    plot(x=c(time_list, time_list, time_list), 
       y=c(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3), 
      type="n", xlab="", ylab="Energy sub metering")
    points(x=time_list, y=data$Sub_metering_1, type="l", col ="black")
    points(x=time_list, y=data$Sub_metering_2, type="l", col ="red")
    points(x=time_list, y=data$Sub_metering_3, type="l", col="blue")

    legend("topright", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       bty="n", lwd=1)
})

plot(x=time_list, y=data$Global_reactive_power, xlab="datetime", type="l",
     ylab="Global_reactive_power")

dev.off()