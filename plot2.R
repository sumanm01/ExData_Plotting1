# Plot 2

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
png("plot2.png")

## Plot the line graph as given in the assignment
plot(power.data$Date.Time,as.numeric(power.data$Global_active_power),xlab="",ylab="Global Active Power (kilowatts)", type="l")

## Close the graphic device for storing the png file in R workspace
dev.off()