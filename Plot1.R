##Generates histogram for Global Active Power over 2 days

#Read semi-colon separated text file as a dataframe with missing values coded as ?
##Assumes that the file is in the current working directory
##All fields/columns are read as characters
hpc<-read.table("household_power_consumption.txt",header=TRUE, sep=";",na.strings = "?") 

##Add 1 new column (ParsedDate) in the data frame from existing field Date
##ParsedDate is used for filtering data for dates 2007/02/01 & 2007/02/02
##as well as for creation of plots
hpc$ParsedDate<-as.Date(strptime (hpc$Date,"%d/%m/%Y"))
date1 <- as.Date(strptime ("2007/02/01","%Y/%m/%d"))
date2 <- as.Date(strptime ("2007/02/02","%Y/%m/%d"))

##Created reduced filter set based on given dates
hpcsubset <- subset (hpc, ParsedDate == date1 | ParsedDate == date2)

##Convert relevant field/column from character to numeric 
hpcsubset$Global_active_power <- as.numeric(hpcsubset$Global_active_power)

##Create png file device of 480x480
png(file = "Plot1.png", width = 480, height = 480)

#Draw histogram of Global Active Power for given dates
hist(hpcsubset$Global_active_power,col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

#close the png file device
dev.off()