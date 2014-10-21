##Analyses FPM as per US EPA standards: NEI- National Emissions Inventory, SCC- Source Classification Code


library(dplyr);
library(ggplot2);


NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");

DATA <- merge(NEI,SCC,by.x="SCC",by.y="SCC");

dataMaryLand <- DATA[DATA$fips=='24510',];

dataMaryLand <- dataMaryLand[dataMaryLand$year>=1999 & dataMaryLand$year<=2008,];


## Create PNG File
#png(filename = "plot3.png",
    width = 960, height = 960, units = "px", bg = "white");
qplot(year,Emissions,data=dataMaryLand,facets=.~ type,main="Pollution in Maryland",geom=c("line","smooth"),method="lm");

#dev.off();