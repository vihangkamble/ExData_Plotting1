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
par(mfrow = c(1, 1) )
#Open png file with appropriate height and width in which plot should be saved
png(file="plot3.png",width = 480, height = 480)
# plot which is followed by lines so that all the three appear in the same plot
with(mydata1, {
  plot(mydata1$Sub_metering_1,type="l",xlab = "",xaxt = 'n',ylab = "Energy sub metering")
  lines(mydata1$Sub_metering_2,type="l",col="red")
  lines(mydata1$Sub_metering_3,type="l",col="blue")
  # Create custom X-label
  axis(1, c(1,1440,2880), c("Thu","Fri","Sat")) 
  # create legend
  legend("topright", lty=c(1,1,1),col = c("black","red","blue"),
         legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  })
# Close the device
dev.off()