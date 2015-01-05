#Plot 3

## Download the file to the R workspace and unzip it
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="power_consumption.zip")
unzip("power_consumption.zip")

## Read the data from household_power_consumption.txt to R memory
d <- read.table("household_power_consumption.txt", sep=";", na.strings = "?", stringsAsFactors=F)

## Extract the data related to the specified dates
power.data <- d[d$V1 == "1/2/2007" | d$V1 == "2/2/2007",]

## Set the column names from the first row of the table
colnames(power.data) <- as.character(unlist(d[1,]))

## Create a new data frame with a new Date.Time column which combines the data and time field of the original data
## Convert the Date.Time column to be of POSIXlt class and remove the individual Date and Time column from the original data frame
library(plyr)
power.data <- mutate(power.data[,c(-1,-2)], "Date.Time" = paste(power.data$Date,power.data$Time,sep=" "))
power.data$Date.Time <- strptime(power.data$Date.Time, "%d/%m/%Y %H:%M:%S")

## Open the png graphic device for plotting
png("plot3.png")

## Plot the combined line graphs with the legends as given in the assignment
with(power.data, plot(power.data$Date.Time,as.numeric(power.data$Sub_metering_1),xlab="",ylab="Energy sub metering", type="n"))
lines(power.data$Date.Time,as.numeric(power.data$Sub_metering_1), col="black")
lines(power.data$Date.Time,as.numeric(power.data$Sub_metering_2), col="red")
lines(power.data$Date.Time,as.numeric(power.data$Sub_metering_3), col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)

## Close the graphic device for storing the png file in R workspace
dev.off()