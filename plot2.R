##Analyses FPM as per US EPA standards: NEI- National Emissions Inventory, SCC- Source Classification Code


library(dplyr);


NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");

DATA <- merge(NEI,SCC,by.x="SCC",by.y="SCC");

dataMaryLand <- DATA[DATA$fips=='24510',];

dataMaryLand <- dataMaryLand[dataMaryLand$year>=1999 & dataMaryLand$year<=2008,]
agg <- aggregate(dataMaryLand$Emissions ~ dataMaryLand$year,dataMaryLand,sum);

plot(agg,col="red",type="l",xlab="Year",ylab="Total PM25 Emissions")