data <- read.delim("household_power_consumption.txt", sep = ";", header=TRUE,
                   colClasses="character", na.strings ="?")
png("plot2.png", width=480, height = 480)


time_list <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

trim_list <- (time_list - strptime("2007-02-01", "%Y-%m-%d")) >= 0 & 
  (strptime("2007-02-03", "%Y-%m-%d") - time_list) >= 0

time_list <- time_list[trim_list]

data <- data[trim_list,]

#r <- as.Date(round(range(as.Date(time_list))), "days")

#axis.Date(1, at=seq(r[1], r[2], by="day"),  format="%a")
             
plot(x=time_list, y=data$Global_active_power, type="l", 
     ylab="Global Active Power (kilowatts)", xlab="")
dev.off()