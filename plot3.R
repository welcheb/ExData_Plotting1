# plot3.R

# finding begin and end line is easy with some *nix commands
#
# cat -n household_power_consumption.txt | grep '1/2/2007' | head -n 1
# 66638  1/2/2007;00:00:00;0.326;0.128;243.150;1.400;0.000;0.000;0.000
#
# cat -n household_power_consumption.txt | grep '[[:space:]]2/2/2007' | tail -n 1
# 69517  2/2/2007;23:59:00;3.680;0.224;240.370;15.200;0.000;2.000;18.000

# set working directory
setwd('~/Copy/Coursera/ExploratoryDataAnalysis/Project 1/')

# load data
line_start = 66638
line_stop = 69517
row_count = line_stop - line_start + 1

# get column 
header_names = read.delim('household_power_consumption.txt', nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
data = read.delim('household_power_consumption.txt', header=F, sep=";", skip=(line_start-1), nrows=row_count)
colnames(data) = unlist(header_names)

# convert Date and Time text data to an actual date_time
data$DateTime = strptime( apply( data[ , c("Date","Time") ], 1, paste, collapse=" "), "%d/%m/%Y %H:%M:%S")

# make Plot 3
plot(data[,"DateTime"], data[,"Sub_metering_1"], col='black',
     type='l', main='', xlab='', ylab='Energy sub metering' )
lines(data[,"DateTime"], data[,"Sub_metering_2"], col='red')
lines(data[,"DateTime"], data[,"Sub_metering_3"], col='blue')
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)

# Copy my plot to a PNG file
dev.copy(png, file = "./ExData_Plotting1/plot3.png")

# Don't forget to close the PNG device!
dev.off()
