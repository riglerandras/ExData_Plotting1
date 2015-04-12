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



png("plot2.png")


with(ds, plot(datetime, Global_active_power, type="l",
              xlab = "", ylab="Global Active Power (kilowatts)",
              cex.axis=.9, cex.lab=.9))

dev.off()



