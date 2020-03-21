# COVID-19 cases Germany (Source: RKI / https://www.rki.de/DE/Content/InfAZ/N/Neuartiges_Coronavirus/Fallzahlen.html)

time = c("29-02-2020","01-03-2020","02-03-2020","03-03-2020","04-03-2020","05-03-2020","06-03-2020","07-03-2020","08-03-2020",
         "09-03-2020","10-03-2020","11-03-2020","12-03-2020","13-03-2020","14-03-2020","15-03-2020","16-03-2020","17-03-2020","18-03-2020",
         "19-03-2020","20-03-2020","21-03-2020")
ntime = seq(1:length(time))
cases=c(66,117,150,188,262,349,639,795,902,1139,1296,1567,2369,3062,3795,4838,6012,7156,8198,10999,13957,16662)

df=data.frame(time,cases,ntime)
df$time<- as.Date(df$time, "%d-%m-%Y")

# Plot absolute cases
plot(cases ~ time, df, xaxt = "n", type="b", main="COVID-19: Fallzahlen in Deutschland",xlab="Datum", ylab="Fälle")
axis(1, df$time, format(df$time, "%d.%m"), cex.axis = .8,las = 2)

# Plot on log scale
plot(log(cases) ~ time, df, xaxt = "n", type="b", main="COVID-19: Fallzahlen DE (Log-Skala)",xlab="Datum", ylab="Fälle")
axis(1, df$time, format(df$time, "%d.%m"), cex.axis = .8,las = 2)

# Linear regression to find average growth rate
reg = lm(log(cases)~ntime, data=df)
summary(reg)

# Compare actual values and prediction
pred = predict(reg, newdata=df)
res = data.frame(pred, log(cases), ntime, cases, round(exp(pred)))
colnames(res)<-c("pred", "logcases", "ntime", "cases", "exp_pred")

# Plot actual values and prediction
plot(res$ntime,res$logcases, xlab = "Days", ylab="Log of cases")
lines(res$ntime,res$pred,col="blue")

# Predict cases over longer period assuming growth rates
mydays = seq(1:40)
mydates = seq(as.Date("29-02-2020","%d-%m-%Y"), by = "day", length.out = length(mydays))
ltp = data.frame(mydays,mydates)
ltp$mycases1 = round(exp(reg$coefficients[1]+ltp$mydays*reg$coefficients[2]))
ltp$mycases2 = round(exp(reg$coefficients[1]+ltp$mydays*(reg$coefficients[2]-0.02) ))
ltp

# Plot prediction with different growth rates
plot(mycases1 ~ mydates, ltp, xaxt = "n", type="b", main="COVID-19: Cases in Germany (actual and prediction)",xlab="Date", ylab="Cases", col = "red")
lines(mycases2 ~ mydates, ltp, type="o", col="green")
lines(cases ~ time, df, type = "o", col = "blue")
axis(1, ltp$mydates, format(ltp$mydates, "%d.%m"), cex.axis = .6,las = 2)
abline(v=as.Date("21-03-2020","%d-%m-%Y"), col=c("black"),lty=2)
