require(data.table)
require(ggplot2)

options(scipen=999)

if (!(exists("NEI")&exists("SCC"))) { 
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "data.zip",method="curl")
    dateDownloaded <- date()
    unzip("data.zip", exdir = "." )
    list.files(".", recursive=TRUE )

    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
}

####### Plot 1 ######################
d1 <- aggregate(NEI[, 4], list(NEI$year), sum)
png(filename="plot1.png", width=480, height=480)
names(d1) <- c("Year", "Total.Emissions")
plot(d1$Year, d1$Total.Emissions, type="l", xlab="Years", ylab = "Total Emissions in US")
dev.off()
