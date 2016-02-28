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

####### Plot 3 ######################
bc <- NEI[NEI$fips=="24510",]
d1 <- aggregate(bc[, 4], list(bc$year, bc$type), sum)
names(d1) <- c("Year", "Type", "Total.Emissions")

png(filename="plot3.png", width=480, height=480)
p <- ggplot(d1, aes(Year, Total.Emissions, color = Type))
p <- p + geom_line() +
    xlab("Year") +
    ylab("Emissions in Baltimore City")
print(p)
dev.off()
