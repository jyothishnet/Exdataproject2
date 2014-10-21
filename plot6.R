##Analyses FPM as per US EPA standards: NEI- National Emissions Inventory, SCC- Source Classification Code


library(dplyr);
library(ggplot2);

NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");

cityLabels <- c("Baltimore","Los Angels");

DATA <- merge(NEI,SCC,by.x="SCC",by.y="SCC");

citiesData <- DATA[DATA$fips=='24510'|DATA$fips=='06037',];

citiesData <- citiesData[citiesData$year>=1999 & citiesData$year<=2008,];
agg <- aggregate(citiesData[c("Emissions")],list(fips=citiesData$fips,year=citiesData$year),sum);
agg$city <- rep(NA,nrow(agg));
agg[agg$fips=="24510",][,"city"] <- "Baltimore city";
agg[agg$fips=="06037",][,"city"] <- "Los Angels city";


# Plotting Graph Below 

#png('plot6.png', width=480, height=480)
p <- ggplot(agg, aes(x=year, y=Emissions, colour=city)) +
  geom_point(alpha=.3) +
  geom_smooth(alpha=.2, size=1, method="loess") +
  ggtitle("Vehicle Emissions in Baltimore vs. LA");
print(p);
dev.off()