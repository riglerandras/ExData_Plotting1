library(dplyr); library(data.table)

cl <- c("character", "character",rep("numeric",7))
d <- read.table("./data/household_power_consumption.txt",
                header=T, sep=";", dec=".", stringsAsFactors=F, 
                colClasses=cl, na.strings="?")

dt <- data.table(d)
rm(d)
saveRDS(dt, "./data/fullSet.RDS")

dt <- readRDS("./data/fullSet.RDS")
ds <- filter(dt, Date=="1/2/2007" | Date=="2/2/2007")
saveRDS(ds, "./data/shortSet.RDS")

ds <- readRDS("./data/shortSet.RDS")

png("plot1.png")
with(ds, hist(Global_active_power, col="red", main="Global Active Power",
              xlab="Global Active Power (kilowatts)",
              cex.lab = .9, cex.axis=.9, cex.main=.9))
dev.off()



