##Generates graph for Energey submetering of 3 submeters over 2 days


#Read semi-colon separated text file as a dataframe with missing values coded as ?
##Assumes that the file is in the current working directory
##All fields/columns are read as characters
hpc<-read.table("household_power_consumption.txt",header=TRUE, sep=";",na.strings = "?") 


##Add 2 new columns (ParsedDate & ParsedDateTime) in the data frame from existing fields Date & Time
##ParsedDate is used for filtering data for dates 2007/02/01 & 2007/02/02
##ParsedDateTime is used for creation of plots
hpc$ParsedDateTime<-strptime (paste(hpc$Date,hpc$Time),"%d/%m/%Y %H:%M:%S")
hpc$ParsedDate<-as.Date(strptime (hpc$Date,"%d/%m/%Y"))
date1 <- as.Date(strptime ("2007/02/01","%Y/%m/%d"))
date2 <- as.Date(strptime ("2007/02/02","%Y/%m/%d"))

##Created reduced filter set based on date
hpcsubset <- subset (hpc, ParsedDate == date1 | ParsedDate == date2)

##Convert relevant fields/columns from character to numeric 
hpcsubset$Sub_metering_1 <- as.numeric(hpcsubset$Sub_metering_1)
hpcsubset$Sub_metering_2 <- as.numeric(hpcsubset$Sub_metering_2)
hpcsubset$Sub_metering_3 <- as.numeric(hpcsubset$Sub_metering_3)


##Create png file device of 480x480
png(file = "Plot3.png", width = 480, height = 480)

##Draw graph for given dates - Energy Submetering  vs Datetime for 3 submeters with legend for each submeter
##with appropriate color
plot(hpcsubset$ParsedDateTime,hpcsubset$Sub_metering_1,type="l",xlab="Datetime",ylab="Energy sub metering",col="black" )
lines(hpcsubset$ParsedDateTime,hpcsubset$Sub_metering_2,type="l",col="red" )
lines(hpcsubset$ParsedDateTime,hpcsubset$Sub_metering_3,type="l",col="blue" )
legendcol=c("black","red","blue")
legendtext=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
legend("topright", legendtext, lty=c(1,1,1), col=legendcol)

#close the png file device
dev.off()