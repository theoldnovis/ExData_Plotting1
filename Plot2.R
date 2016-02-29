##Generates graph for Global Active Power over 2 days


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

##Created reduced filter set based on given dates
hpcsubset <- subset (hpc, ParsedDate == date1 | ParsedDate == date2)

##Convert relevant field/column from character to numeric 
hpcsubset$Global_active_power <- as.numeric(hpcsubset$Global_active_power)



##Create png file device of 480x480
png(file = "Plot2.png", width = 480, height = 480)

#Draw graph for given dates - Global Active Power vs Datetime
plot(hpcsubset$ParsedDateTime,hpcsubset$Global_active_power,type="l",xlab="Datetime",ylab="Global Active Power (kilowatts)")

#close the png file device
dev.off()
