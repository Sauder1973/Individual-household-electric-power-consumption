### Exploratory Data Analysis - March 6, 2015
### Plot2.R

library(data.table)
library(sqldf)
library(datasets)

### set working directory appropriately - should be the same as where your data is stored.
setwd("C:\\Users\\Wes\\Documents\\RWorkingDirectory\\Exploratory Data Analysis\\ProjectONE\\Individual-household-electric-power-consumption")
#------------------------------------------------------------------------------------



#Step 1: Read the Household Electric Power Consumption Data into a dataframe.
#------------------------------------------------------------------------------------

data_file <- "./household_power_consumption.txt"

power_consumptionDF <- read.table(
        data_file,
        na.strings=c(NULL,"?",""),
        header = TRUE,
        sep= ";",
        colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
       
)


#Step 2: Subset the Data to speed up task
#------------------------------------------------------------------------------------

range_power_consDF<- subset(power_consumptionDF,
                            Date=="1/2/2007"| Date=="2/2/2007")

#Step 3: Convert to Date and Determine Weekday.  Add vector of weekdays to data.frame
#------------------------------------------------------------------------------------

range_power_consDF$DateTime <-strptime(
        paste(range_power_consDF$Date,
              range_power_consDF$Time),
        "%d/%m/%Y %H:%M:%S")

range_power_consDF$Date <-strptime(
        range_power_consDF$Date,
        "%d/%m/%Y")

range_power_consDF$weekday<- weekdays(as.Date(range_power_consDF$DateTime))



#Step 4: Create Graph to Screen and Save Graph
#------------------------------------------------------------------------------------

png("plot2.png",width = 480, height = 480)
plot(range_power_consDF$DateTime,range_power_consDF$Global_active_power,
     ylab="Global Active Power (kilowatts)",
     xlab="",
     type = "l")


dev.off()
