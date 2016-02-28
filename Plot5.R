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

####### Plot 5 ######################
bc <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

d1 <- aggregate(bc[, 4], list(bc$year), sum)
names(d1) <- c("Year", "Total.Emissions")

png("plot5.png", width=640, height=480)
p <- ggplot(d1, aes(Year, Total.Emissions), Total.Emissions)
p <- p + geom_line() +
    xlab("Year") +
    ylab("ON-ROAD Emissions in US")
print(p)
dev.off()
