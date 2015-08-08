# Since the file is huge, try to optimize the filer reading.
# Read only 100 lines and figure out the class of the columns
initial <- read.table("household_power_consumption.txt", header = TRUE, nrows = 100,sep = ";")
classes <-sapply(initial,class)
# optimize reading time by passing colClasses, comment.char.
mydata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";",
                     colClasses = classes,na.strings="?",comment.char = "")
#select only that part of the table which corresponds to between 2007-02-01 and 2007-02-02
condition <- as.Date(mydata$Date, "%d/%m/%Y") >= "2007-02-01" & 
  as.Date(mydata$Date, "%d/%m/%Y") <="2007-02-02"
#mydata1 has the shortlisted data
mydata1 <- mydata[condition,]
#Open png file with appropriate height and width in which plot should be saved
png(file="plot1.png",width = 480, height = 480)
par(mfrow = c(1, 1) )
# plot the histogram with red color, title and x label
hist(mydata1$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
# Close the device
dev.off()
