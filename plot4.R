##Analyses FPM as per US EPA standards: NEI- National Emissions Inventory, SCC- Source Classification Code


library(dplyr);
library(ggplot2);


NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");
DATA <- merge(NEI,SCC,by.x="SCC",by.y="SCC");

t <- grep("coal",DATA$EI.Sector,ignore.case=T,value=T);
coalData <- subset(DATA,DATA$EI.Sector %in% t);
agg <- aggregate(coalData[c("Emissions")],list(year=coalData$year),sum);

# Create Plot

png('plot4.png', width=480, height=480)
p <- ggplot(agg, aes(x=year, y=Emissions)) +
  geom_point(alpha=.3) +
  geom_smooth(alpha=.2, size=1) +
  ggtitle("Total PM2.5 Coal Combustion Emissions in the US")
print(p)
dev.off()