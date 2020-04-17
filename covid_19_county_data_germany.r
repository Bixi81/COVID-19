
# RKI data on county level over time
# Source (old): https://npgeo-corona-npgeo-de.hub.arcgis.com/datasets/dd4580c810204019a7b8eb3e0b329dd6_0
# Source (new): https://www.arcgis.com/home/item.html?id=f10774f1c63e40168479a1feb6c7ca74

mypath = "C:/Users/User/Documents/R/corona/"

# Lead data
library(readr)
co <- read_csv(paste0(mypath,"data/200417_RKI_COVID19.csv"))
co$Meldedatum <- as.Date(co$Meldedatum, format = "%m/%d/%Y")

# Assumption negative entries are corrections
co$AnzahlFall[co$AnzahlFall<0]=0
co$AnzahlTodesfall[co$AnzahlTodesfall<0]=0

# Deaggregate counts to long
l <- co[rep(1:nrow(co), co$AnzahlFall),]

# Correct, data matches official RKI figures (https://www.rki.de/DE/Content/InfAZ/N/Neuartiges_Coronavirus/Fallzahlen.html)
# Each case is now in one row, so replace all freq. = 1
l$AnzahlFall=1
# Also replace deaths = 1 if > 0 (each row is one case now)
l$AnzahlTodesfall[l$AnzahlTodesfall>0]=1

# Separate data frame for deaths
d = l[l$AnzahlTodesfall==1,]

# This should match: https://www.rki.de/DE/Content/InfAZ/N/Neuartiges_Coronavirus/Fallzahlen.html

########################
# Generate timeseries of infections and deaths
library(dplyr)
da = d %>%
  group_by(Meldedatum) %>%
  summarise(Anzahl=n())
la = l %>%
  group_by(Meldedatum) %>%
  summarise(Anzahl=n())

la$Meldedatum = as.character(la$Meldedatum)
da$Meldedatum = as.character(da$Meldedatum)

# Sequence of dates since 5 Jan 20
basedf = data.frame(seq(as.Date("05-01-2020", "%d-%m-%Y"),as.Date(Sys.Date()-1, "%d-%m-%Y"),by = 1))
colnames(basedf)<-"Meldedatum"
basedf$Meldedatum = as.character(basedf$Meldedatum)

# Merge data on dates
basedf = merge(basedf,la,by="Meldedatum",all.x = T)
basedf = merge(basedf,da,by="Meldedatum",all.x = T)
colnames(basedf)<-c("date","cases","deaths")
basedf[is.na(basedf)] <- 0
basedf$cases_all = cumsum(basedf$cases)
basedf$deaths_all = cumsum(basedf$deaths)
rm(da,la,co)

########################
# Growth rate (seven days) over time
basedf$date=as.Date(basedf$date)

mintime = as.Date("2020-03-04")
maxdate = mintime+7

i = 1
cases = list()
death = list()
minlist = list()
maxlist = list()
while(maxdate<=as.Date(Sys.Date()-2)){
  df = basedf[(basedf$date>mintime & basedf$date<=maxdate),]
  df$ntime = seq(1:nrow(df))
  reg1 = lm(log(cases_all)~ntime, data=df)
  reg2 = lm(log(deaths_all)~ntime, data=df)
  cases[[i]]=exp(reg1$coefficients[2])-1
  death[[i]]=exp(reg2$coefficients[2])-1
  minlist[[i]]=mintime
  maxlist[[i]]=maxdate
  mintime = mintime + 1
  maxdate = mintime+7
  i=i+1
}

library(tidyverse)
gr=map2_dfr(cases, death, ~ tibble(Infections=.x, Deaths=.y))
da=map2_dfr(minlist, maxlist, ~ tibble(mintime=.x, maxdate=.y)) 
growth=cbind(da,gr)
rm(da,gr,minlist,maxlist,cases,death,i)

# Melt data for plotiting
library(reshape)
molten <- melt(growth, id.vars = c("mintime","maxdate"))

########################
# Plot growth rates over time
library(ggplot2)
gplot = ggplot(molten, aes(x = maxdate, y = value, colour = variable)) + 
  geom_smooth() + geom_point() +
  xlab("") + ylab("Growth rate") +
  ggtitle("Growth rate (seven day trend) of Covid-19 infections and deaths in Germany") +
  labs(color='Type') +
  scale_x_date(breaks = molten$maxdate, date_labels = "%d.%m.%y") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  #geom_hline(aes(yintercept=0.015),color="grey20") + geom_text(aes(as.Date("2020-03-14"),0.015,label = "Doubles in 46 days", vjust= -0.5),color="grey15")+
  geom_hline(aes(yintercept=0.025),color="grey20") + geom_text(aes(as.Date("2020-03-14"),0.025,label = "Doubles in 28 days", vjust= -0.5),color="grey15")+
  geom_hline(aes(yintercept=0.05),color="grey20") + geom_text(aes(as.Date("2020-03-14"),0.05,label = "Doubles in 14 days", vjust= -0.5),color="grey20")+
  geom_hline(aes(yintercept=0.07),color="grey30") + geom_text(aes(as.Date("2020-03-14"),0.07,label = "Doubles in 10 days", vjust= -0.5),color="grey30")+
  geom_hline(aes(yintercept=0.1),color="grey35") + geom_text(aes(as.Date("2020-03-14"),0.1,label = "Doubles in 7 days", vjust = -0.51),color="grey35")+
  geom_hline(aes(yintercept=0.15),color="grey40") + geom_text(aes(as.Date("2020-03-14"),0.15,label = "Doubles in 5 days", vjust = -0.5),color="grey40")+
  geom_hline(aes(yintercept=0.19),color="grey45") + geom_text(aes(as.Date("2020-03-14"),0.19,label = "Doubles in 4 days", vjust = -0.5),color="grey45")+
  geom_hline(aes(yintercept=0.26),color="grey50") + geom_text(aes(as.Date("2020-03-14"),0.26,label = "Doubles in 3 days", vjust = -0.5),color="grey50")+
  geom_hline(aes(yintercept=0.41),color="grey60") + geom_text(aes(as.Date("2020-03-14"),0.41,label = "Doubles in 2 days", vjust = -0.5),color="grey60") 

ggsave(filename=paste0(mypath, "out/",Sys.Date(),"growth.jpg"), plot=last_plot())

########################
# Plot how fast cases double
# Create df
growth$infections_double = round(log(2)/log(1+growth$Infections))
growth$deaths_double = round(log(2)/log(1+growth$Deaths))
growth2 = growth
growth$infections_double=NULL
growth$deaths_double=NULL
growth2$Infections=NULL
growth2$Deaths=NULL
colnames(growth2)<-c("mintime","maxdate","Infections","Deaths")
# Reshape for plotting
molten2 <- melt(growth2, id.vars = c("mintime","maxdate"))

plot_double = ggplot(molten2, aes(x = maxdate, y = value, colour = variable)) + 
  geom_smooth() + geom_point() +
  xlab("") + ylab("Days until infections/deaths double") +
  ggtitle("Days until Covid-19 infections/deaths in Germany double") +
  labs(color='Type') +
  scale_x_date(breaks = molten2$maxdate, date_labels = "%d.%m.%y") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))

plot_double

########################

# Predict based on last seven day trend
ntime = seq(1:17)
mydates = seq(as.Date(mintime), by = "day", length.out = length(ntime))
preddf = data.frame(ntime,mydates)
preddf$pred_cases = round(exp(predict(reg1, newdata=preddf)))
preddf$pred_deaths = round(exp(predict(reg2, newdata=preddf)))

## Don't pull actual cases/deaths from basedf since there might be unreported cases (last few days)

# Plot cases (actual/predicted)
png(filename=paste0(mypath, "out/",Sys.Date(),"cases_trend.png"), width = 800, height = 600)
plot(pred_cases ~ format(as.Date(mydates),"%d.%m"), xaxt = "n",preddf, type="b", main="COVID-19: Cases in Germany (actual [blue] and prediction [red])",xlab="Date", ylab="Cases", col = "red", yaxt='n')
axis(2,cex.axis=1)
# Actual cases
lines(cases_all ~ format(as.Date(date),"%d.%m"), df, type = "o", col = "blue")
axis(1,format(as.Date(preddf$mydates),"%d.%m"), cex.axis = .8,las = 2)
dev.off()

# Plot deaths (actual/predicted)
png(filename=paste0(mypath, "out/",Sys.Date(),"deaths_trend.png"), width = 800, height = 600)
plot(pred_deaths ~ format(as.Date(mydates),"%d.%m"), xaxt = "n",preddf, type="b", main="COVID-19: Deaths in Germany (actual [blue] and prediction [red])",xlab="Date", ylab="Cases", col = "red", yaxt='n')
axis(2,cex.axis=1)
# Actual cases
lines(deaths_all ~ format(as.Date(date),"%d.%m"), df, type = "o", col = "blue")
axis(1,format(as.Date(preddf$mydates),"%d.%m"), cex.axis = .8,las = 2)
dev.off()

########################
# Manage data
rm(ntime,mydates,mintime,maxdate,reg1,reg2,molten,gplot,df)
# Write data
write.csv(x=basedf, file=paste0(mypath,"out/covid19_germany.csv"),row.names = FALSE)
write.csv(x=growth, file=paste0(mypath,"out/covid19_growth_rates_germany.csv"),row.names = FALSE)

table(d$Altersgruppe)

# 2-Way Cross Tabulation
library(gmodels)
CrossTable(d$Altersgruppe)
CrossTable(l$Altersgruppe)

