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
png(file="plot2.png",width = 480, height = 480)
# plot the line with y label and no x axis
with(mydata1, {
  plot( Global_active_power, type = "l",
        ylab = "Global Active Power (kilowatts)",xlab = "",xaxt = 'n')
  # create custom x-axis
  axis(1, c(1,1440,2880), c("Thu","Fri","Sat"))
})
# Close the device
dev.off()