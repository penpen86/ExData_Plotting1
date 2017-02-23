# The First step is to create the directory where the data will be stored and 
# processed. We first do a verificaction to see if the directory exists. If not,
# create the directory. Then, we will download the file, if it doesn't exists. 
# In my Windows the way to create proper files is to set the download mode as "wb"

if(!file.exists("./dataProject1Exploratory")){
  dir.create("./dataProject1Exploratory")
}
if(!file.exists("./dataProject1Exploratory/POWER.zip")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL,destfile = "./dataProject1Exploratory/POWER.zip", mode = "wb")
}

# The second step is to unzip the file. First, we will do a verification to see if
# the file has already been unzipped. If not, unzipped.

if(!file.exists("household_power_consumption.txt")){
  unzip("dataProject1Exploratory/POWER.zip",exdir = "./dataProject1Exploratory")
}

# The third step is to get the full data from the .txt file taking in consideration
# that we need to convert the Date column in a date variable and the Time column
# in a time variable using the paste function and strptime function

fulldata <- read.csv("./dataProject1Exploratory/household_power_consumption.txt", 
                     header = T, sep = ';', na.strings = '?', stringsAsFactors = F)
fulldata$Date <- as.Date(fulldata$Date, format = "%d/%m/%Y")
fulldata$Time <- strptime(paste(fulldata$Date,fulldata$Time), format = "%Y-%m-%d %H:%M:%S")

# The fourth step is to subset the data between the dates given

data <- subset(fulldata, Date >= "2007-02-01" & Date <= "2007-02-02")

# Finally, we plot. Plot 4. We use with to get a more compact code

png("plot4.png",width = 480, height = 480)
par(mfrow = c(2,2))
with(data, {
            plot(Time,Global_active_power, type = "l",
                xlab = "", ylab = "Global Active Power")
            plot(Time,Voltage, type = "l", xlab = "datetime",
                 ylab = "Voltage")
            plot(Time,Sub_metering_1, type = "l",
                 xlab = "", ylab = "Energy sub metering", col = "black")
            lines(Time,Sub_metering_2, type = "l", col = "red")
            lines(Time,Sub_metering_3, type = "l", col = "blue")
            legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                   col = c("black","red","blue"), lty = 1, lwd = 2, bty = "n")
            plot(Time, Global_reactive_power, type = "l",
                 xlab = "datetime", ylab = "Global_reactive_power")})
dev.off()
