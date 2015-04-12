library(dplyr); library(data.table); library(lubridate)

cl <- c("character", "character",rep("numeric",7))
d <- read.table("./data/household_power_consumption.txt",
                header=T, sep=";", dec=".", stringsAsFactors=F, 
                colClasses=cl, na.strings="?")

dt <- data.table(d)
rm(d)
saveRDS(dt, "./data/fullSet.RDS")

dt <- readRDS("./data/fullSet.RDS")
ds <- filter(dt, Date=="1/2/2007" | Date=="2/2/2007")
Sys.setlocale("LC_ALL", "English")
ds[, dDate:=as.Date(Date, "%d/%m/%Y")]
ds[, datetime:=dmy_hms(paste(Date, Time) )]
ds[, wd:=weekdays(as.Date(Date, "%d/%m/%Y"), abbreviate=T)]
saveRDS(ds, "./data/shortSet.RDS")


ds <- readRDS("./data/shortSet.RDS")



png("plot3.png")


with(ds, plot(datetime, Sub_metering_1, type="l",
              xlab = "", ylab="Energy sub metering",
              cex.axis=.9, cex.lab=.9))
with(ds, points(datetime, Sub_metering_2, type="l",col="red"))
with(ds, points(datetime, Sub_metering_3, type="l",col="blue"))
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", 
                            "Sub_metering_3"), 
       cex=.9, lty=1, col = c("black", "red", "blue"))

dev.off()



