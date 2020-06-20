##Downloading the file from the internet and making sure that we don't repeat it
##if the code is run multiple times

        filename = "coursera4.zip"

        if(!file.exists(filename)){
                fileurl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
                download.file(fileurl, destfile = filename)
        }
        if(!file.exists("household_power_consumption.txt")){
                unzip(filename)
        }
        ##Reading the dataset
                dataset <- read.table("household_power_consumption.txt",sep = ";",header = TRUE, na.strings = "?")

        ##Changing the date to the right format
                dataset$Date <- as.Date(dataset$Date,"%d/%m/%Y")
        ##Remove incomplete observation
                dataset <- dataset[complete.cases(dataset), ]
        ##Subset to the required values 2007-02-01 and 2007-02-02
                reqdata <- subset(dataset, Date>=as.Date("2007-02-01") & Date<=as.Date("2007-02-02"))
        ## we need a column that stores the combine data and time variables because we 
        ##need plotting information at all time
                dateTime <- paste(reqdata$Date,reqdata$Time)
                dateTime <- as.POSIXct(dateTime)
        ##binding the values
                reqdata <- cbind(reqdata,dateTime)
        ##opening the file
                png("plot4.png",width = 480 ,height = 480)
        ##Plot
                par(mfrow=c(2,2))
                plot(reqdata$Global_active_power~reqdata$dateTime, type="l", ylab = "Global Active Power (kilowatts)",xlab="")
                plot(reqdata$Voltage ~ reqdata$dateTime, type = "l" , ylab = "Voltage", xlab = "datetime" )
                plot(reqdata$Sub_metering_1~reqdata$dateTime,type = "l",col = "black" , ylab = "Every sub metering")
                lines(reqdata$Sub_metering_2~reqdata$dateTime, type="l", col="red")
                lines(reqdata$Sub_metering_3~reqdata$dateTime, type="l", col="blue")
                legend("topright",col=c("black","red","blue"),legend = c("sub_metering1","sub_metering2","sub_metering3"),lwd = c(1,1,1))
                plot(reqdata$Global_reactive_power~reqdata$dateTime , type = "l", ylab = "Global_reactive_power", xlab = "datetime") 
                dev.off()