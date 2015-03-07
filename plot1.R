### Exploratory Data Analysis - March 6, 2015
### Plot1.R

library(data.table)
library(sqldf)
library(datasets)

### set working directory appropriately - should be the same as where your data is stored.
setwd("C:\\Users\\Wes\\Documents\\RWorkingDirectory\\Exploratory Data Analysis\\ProjectONE\\Individual-household-electric-power-consumption")
#------------------------------------------------------------------------------------



#Step 1: Read the Household Electric Power Consumption Data into a dataframe.
#------------------------------------------------------------------------------------

data_file <- "./household_power_consumption.txt"

power_consumptionDF <- fread(
        data_file,
        header = TRUE,
        sep= ";",
        #colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"),
        data.table = FALSE #Return as a data.frame
)

#Step 2: Subset the Data
#------------------------------------------------------------------------------------
        
        range_power_consDF<- subset(power_consumptionDF,
                                    Date=="1/2/2007"| Date=="2/2/2007")
        range_power_consDF$Global_active_power = as.numeric(range_power_consDF$Global_active_power)

#Step 3: Convert to Date and Determine Weekday.  Add vector of weekdays to data.frame
#------------------------------------------------------------------------------------
        
weekday<- weekdays(as.Date(range_power_consDF$Date))
range_power_consDF$Date <- as.Date(range_power_consDF$Date, format="%d/%m/%Y")
range_power_consDF <- cbind(range_power_consDF,
                            weekday)


#Step 4: Create Graph to Screen and Save Graph
#------------------------------------------------------------------------------------

png("plot1.png",width = 480, height = 480)
hist(range_power_consDF$Global_active_power,
                main="Global Active Power",
                xlab="Global Active Power (kilowatts)",
                col=c("red")
                )
dev.off()

