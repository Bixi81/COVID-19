# COVID-19 cases Germany (Source: RKI / https://www.rki.de/DE/Content/InfAZ/N/Neuartiges_Coronavirus/Fallzahlen.html)

time = c("29-02-2020","01-03-2020","02-03-2020","03-03-2020","04-03-2020","05-03-2020","06-03-2020","07-03-2020","08-03-2020",
         "09-03-2020","10-03-2020","11-03-2020","12-03-2020","13-03-2020","14-03-2020","15-03-2020","16-03-2020","17-03-2020",
         "18-03-2020","19-03-2020","20-03-2020","21-03-2020","22-03-2020","23-03-2020","24-03-2020","25-03-2020","26-03-2020",
         "27-03-2020", "28-03-2020","29-03-2020","30-03-2020","31-03-2020","01-04-2020","02-04-2020","03-04-2020","04-04-2020")

cases=c(66,117,150,188,262,349,639,795,902,1139,1296,1567,2369,3062,3795,4838,6012,7156,8198,10999,13957,16662,18610,22672,27436,31554,36508,
        42288,48582,52547,57298,61913,67366,73522,79696,85778)

death=c(0,0,0,0,0,0,0,0,0,2,2,3,3,4,8,8,12,12,12,20,31,47,55,86,114,149,198,253,325,389,455,583,732,872,1017,1158)

df=data.frame(time,cases,death)
df$time<- as.Date(df$time, "%d-%m-%Y")
write.csv(x=df, file=paste0("C:/Users/User/Documents/R/corona/",Sys.Date(),"_covid19_germany.csv"),row.names = FALSE)
basedf=df

today = format(Sys.Date(),"%d-%m-%Y")
tomor = format(Sys.Date()+10,"%d-%m-%Y")

# CASES: Plot on log scale 
png(filename=paste0("C:/Users/User/Pictures/", Sys.Date(),"_cases_log_scale.png"), width = 800, height = 600)
plot(log(cases) ~ time, df, xaxt = "n", type="b", main="COVID-19: Cases Germany (log-scale)",xlab="Date", ylab="Log of cases")
axis(1, df$time, format(df$time, "%d.%m"), cex.axis = .8,las = 2)
dev.off()

# DEATH: Plot on log scale 
png(filename=paste0("C:/Users/User/Pictures/", Sys.Date(),"_deaths_log_scale.png"), width = 800, height = 600)
plot(log(death) ~ time, df, xaxt = "n", type="b", main="COVID-19: Deaths Germany (log-scale)",xlab="Date", ylab="Log of cases")
axis(1, df$time, format(df$time, "%d.%m"), cex.axis = .8,las = 2)
dev.off()

# Subset df to last week
df = df[(nrow(df)-6):nrow(df),]
df$ntime = seq(1:nrow(df))

# Linear regression to find average growth rate
reg = lm(log(cases)~ntime, data=df)
summary(reg)
reg2 = lm(log(death)~ntime, data=df)
summary(reg2)

# Compare actual values and prediction
pred = predict(reg, newdata=df)
pred2 = predict(reg2, newdata=df)
res = data.frame(pred, pred2,log(df$cases),log(df$death), df$ntime, df$cases,df$death, round(exp(pred)), round(exp(pred2)))
colnames(res)<-c("pred", "pred2","logcases","logdeaths", "ntime", "cases","deaths", "exp_pred", "exp_pred_death")

# CASES: Plot actual values and prediction
png(filename=paste0("C:/Users/User/Pictures/", Sys.Date(),"cases_trend.png"), width = 800, height = 600)
plot(res$ntime,res$logcases, xlab = "Days", ylab="Log of cases", main="COVID-19: Cases in Germany last seven days (log-scale and trend)")
lines(res$ntime,res$pred,col="blue")
dev.off()

# DEATH: Plot actual values and prediction
png(filename=paste0("C:/Users/User/Pictures/", Sys.Date(),"deaths_trend.png"), width = 800, height = 600)
plot(res$ntime,res$logdeaths, xlab = "Days", ylab="Log of deaths", main="COVID-19: Deaths in Germany last seven days (log-scale and trend)")
lines(res$ntime,res$pred2,col="blue")
dev.off()

# Predict cases over longer period assuming growth rates
ntime = seq(1:17)
mydates = seq(as.Date(paste0(min(df$time),"%d-%m-%Y")), by = "day", length.out = length(ntime))
ltp = data.frame(ntime,mydates)
ltp$mod1 = round(exp(predict(reg, newdata=ltp)))
ltp$mod2 = round(exp(predict(reg2, newdata=ltp)))

# CASES: Plot prediction with different growth rates
png(filename=paste0("C:/Users/User/Pictures/", Sys.Date(),"cases_pred.png"), width = 800, height = 600)
plot(mod1 ~ mydates, ltp, xaxt = "n", type="b", main="COVID-19: Cases in Germany (actual [blue] and prediction [red])",xlab="Date", ylab="Cases", col = "red", yaxt='n')
axis(2,cex.axis=1)
# Actual cases
lines(cases ~ time, df, type = "o", col = "blue")
axis(1, ltp$mydates, format(ltp$mydates, "%d.%m"), cex.axis = .8,las = 2)
abline(v=as.Date(paste0(today),"%d-%m-%Y"), col=c("black"),lty=2)
abline(v=as.Date(paste0(tomor),"%d-%m-%Y"), col=c("black"),lty=2)
dev.off()

# DEATHS: Plot prediction with different growth rates
png(filename=paste0("C:/Users/User/Pictures/", Sys.Date(),"deaths_pred.png"), width = 800, height = 600)
plot(mod2 ~ mydates, ltp, xaxt = "n", type="b", main="COVID-19: Deaths in Germany (actual [blue] and prediction [red])",xlab="Date", ylab="Cases", col = "red", yaxt='n')
axis(2,cex.axis=1)
# Actual cases
lines(death ~ time, df, type = "o", col = "blue")
axis(1, ltp$mydates, format(ltp$mydates, "%d.%m"), cex.axis = .8,las = 2)
abline(v=as.Date(paste0(today),"%d-%m-%Y"), col=c("black"),lty=2)
abline(v=as.Date(paste0(tomor),"%d-%m-%Y"), col=c("black"),lty=2)
dev.off()

# Growth rate (last seven days)
print(paste0("From: ", min(df$time), " to: ", max(df$time)))
print(paste0("Data since: ", min(df$time)," | CASES  Growth rate: ",exp(reg$coefficients[2])-1))
print(paste0("Data since: ", min(df$time)," | DEATHS Growth rate: ",exp(reg2$coefficients[2])-1))

##################################
# Growth rates over time
rm(list=setdiff(ls(), c("basedf")))
basedf$time=as.Date(basedf$time)

mindate = as.Date("10-03-2020","%d-%m-%Y")
maxdate = mindate+7
i = 1
cases = list()
death = list()
minlist = list()
maxlist = list()
while(maxdate<=as.Date(Sys.Date(),"%d-%m-%Y")){
  df = basedf[(basedf$time>mindate & basedf$time<=maxdate),]
  df$ntime = seq(1:nrow(df))
  reg1 = lm(log(cases)~ntime, data=df)
  reg2 = lm(log(death)~ntime, data=df)
  cases[[i]]=exp(reg1$coefficients[2])-1
  death[[i]]=exp(reg2$coefficients[2])-1
  minlist[[i]]=mindate
  maxlist[[i]]=maxdate
  mindate = mindate + 1
  maxdate = mindate+7
  i=i+1
}

library(tidyverse)
gr=map2_dfr(cases, death, ~ tibble(Infections=.x, Deaths=.y))
da=map2_dfr(minlist, maxlist, ~ tibble(mindate=.x, maxdate=.y)) 
growth=cbind(da,gr)
write.csv(x=df, file="C:/Users/User/Documents/R/corona/growth_covid19_germany.csv",row.names = FALSE)

# Melt data for plotiting
library(reshape)
molten <- melt(growth, id.vars = c("mindate","maxdate"))
library(ggplot2)
png(filename=paste0("C:/Users/User/Pictures/", Sys.Date(),"growth_rates.png"), width = 800, height = 600)
ggplot(molten, aes(x = maxdate, y = value, colour = variable)) + 
  geom_smooth() + geom_point() +
  geom_vline(aes(xintercept = as.integer(as.POSIXct("2020-03-16"))), linetype=4, colour="black") +
  geom_vline(aes(xintercept = as.integer(as.POSIXct("2020-03-23"))), linetype=4, colour="black") +
  xlab("") +
  ylab("Growth rate") +
  ggtitle("Growth rate of Covid-19 infections and deaths in Germany") +
  labs(color='Type') +
  scale_x_date(breaks = molten$maxdate, date_labels = "%d.%m.%y") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
dev.off()


