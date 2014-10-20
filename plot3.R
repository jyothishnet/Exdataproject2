##Analyses FPM as per US EPA standards: NEI- National Emissions Inventory, SCC- Source Classification Code


library(dplyr);
library(ggplot2);


NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");

DATA <- merge(NEI,SCC,by.x="SCC",by.y="SCC");

dataMaryLand <- DATA[DATA$fips=='24510',];

dataMaryLand <- dataMaryLand[dataMaryLand$year>=1999 & dataMaryLand$year<=2008,];

qplot(dataMaryLand$year,dataMaryLand$Emissons,colour=dataMaryLand$type, data=dataMaryLand, alpha=I(.5),
      main="Emissons in Maryland", xlab="Year",
      ylab="Total Emissions")