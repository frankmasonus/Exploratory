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

####### Plot 6 ######################
bc <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]


d1 <- aggregate(bc[, 4], list(bc$year, bc$fips), sum)
names(d1) <- c("Year", "City", "Total.Emissions")
d1$City[d1$City=="24510"] <- "Baltimore, MD"
d1$City[d1$City=="06037"] <- "Los Angeles, CA"

png(filename="plot6.png", width=480, height=480)
p <- ggplot(d1, aes(Year, Total.Emissions, color = City))
p <- p + geom_line() +
    xlab("Year") +
    ylab("ON-ROAD Emissions in cities")
print(p)
dev.off()
