## Plot 1

## Download the file to the R workspace and unzip it
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile="power_consumption.zip")
unzip("power_consumption.zip")

## Read the data from household_power_consumption.txt to R memory
d <- read.table("household_power_consumption.txt", sep=";", na.strings = "?", stringsAsFactors=F)

## Extract the data related to the specified dates
power.data <- d[d$V1 == "1/2/2007" | d$V1 == "2/2/2007",]

## Set the column names from the first row of the table
colnames(power.data) <- as.character(unlist(d[1,]))

## Open the png graphic device for plotting
png("plot1.png")

## Plot the histogram as given in the assignment
hist(as.numeric(power.data$Global_active_power), xlab="Global Active Power (kilowatts)", main = "Global Active Power", col = "red")

## Close the graphic device for storing the png file in R workspace
dev.off()