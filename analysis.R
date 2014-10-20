##Analyses FPM as per US EPA standards: NEI- National Emissions Inventory, SCC- Source Classification Code


library(dplyr);


NEI <- readRDS("summarySCC_PM25.rds");
SCC <- readRDS("Source_Classification_Code.rds");

DATA <- merge(NEI,SCC,by.x="SCC",by.y="SCC");
agg <- aggregate(DATA$Emissions ~ DATA$year,DATA,sum);

plot(agg,col="red",type="l",xlab="Year",ylab="Total Emissions")