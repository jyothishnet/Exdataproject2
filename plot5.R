##Analyses FPM as per US EPA standards: NEI- National Emissions Inventory, SCC- Source Classification Code

library(dplyr);
library(ggplot2);

NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");
DATA <- merge(NEI,SCC,by.x="SCC",by.y="SCC");
dataMaryLand <- DATA[DATA$fips=='24510',];
dataMaryLand <- dataMaryLand[dataMaryLand$year>=1999 & dataMaryLand$year<=2008,];

veh <- grep("vehicle",dataMaryLand$EI.Sector,value=T,ignore.case=T);
baltimoreMotorVeh <- subset(dataMaryLand,dataMaryLand$EI.Sector %in% veh);

agg <- aggregate(baltimoreMotorVeh[c("Emissions")],list(year=baltimoreMotorVeh$year),sum);


# Create Plot

png('plot5.png', width=480, height=480)

plot(agg$year, agg$Emissions, type = "l",
     main = "Total Vehicle Emissions in Baltimore City",
     xlab = "Year", ylab = "Emissions",size=2,colour="blue");
p <- ggplot(agg, aes(x=year, y=Emissions)) +
  geom_point(alpha=.3) +
  geom_smooth(alpha=.2, size=1) +
  ggtitle("Total Vehicle Emissions in Baltimore City")
print(p)

dev.off()