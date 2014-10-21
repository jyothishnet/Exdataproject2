##Analyses FPM as per US EPA standards: NEI- National Emissions Inventory, SCC- Source Classification Code


library(dplyr);
library(ggplot2);


NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");

DATA <- merge(NEI,SCC,by.x="SCC",by.y="SCC");

dataMaryLand <- DATA[DATA$fips=='24510',];

dataMaryLand <- dataMaryLand[dataMaryLand$year>=1999 & dataMaryLand$year<=2008,];
agg <- aggregate(dataMaryLand[c("Emissions")],list(type=dataMaryLand$type,year=dataMaryLand$year),sum);

## Create PNG File
png(filename = "plot3.png",
    width = 960, height = 960, units = "px", bg = "white");
p <- ggplot(agg, aes(x=year, y=Emissions, colour=type)) +
  geom_point(alpha=.3) +
  geom_smooth(alpha=.2, size=1, method="loess") +
  ggtitle("Total Emissions by Type in Baltimore City");
print(p)

#dev.off();