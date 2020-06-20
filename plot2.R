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
                png("plot2.png",width = 480 ,height = 480)
        ##Plot
                plot(reqdata$Global_active_power~reqdata$dateTime, type = "l", ylab = "Global Active Power (kilowatts)", xlab="")
                dev.off()    