# COVID-19 cases Germany (Source: RKI / https://www.rki.de/DE/Content/InfAZ/N/Neuartiges_Coronavirus/Fallzahlen.html)

time = c("29-02-2020","01-03-2020","02-03-2020","03-03-2020","04-03-2020","05-03-2020","06-03-2020","07-03-2020","08-03-2020",
         "09-03-2020","10-03-2020","11-03-2020","12-03-2020","13-03-2020","14-03-2020","15-03-2020","16-03-2020","17-03-2020","18-03-2020",
         "19-03-2020","20-03-2020","21-03-2020","22-03-2020","23-03-2020","24-03-2020","25-03-2020","26-03-2020","27-03-2020", "28-03-2020")

cases=c(66,117,150,188,262,349,639,795,902,1139,1296,1567,2369,3062,3795,4838,6012,7156,8198,10999,13957,16662,18610,22672,27436,31554,36508,42288,48582)

df=data.frame(time,cases)
df$time<- as.Date(df$time, "%d-%m-%Y")
today = format(Sys.Date(),"%d-%m-%Y")
tomor = format(Sys.Date()+10,"%d-%m-%Y")

# Plot on log scale
png(filename=paste0("C:/Users/User/Pictures/", Sys.Date(),"_cases_log_scale.png"), width = 800, height = 600)
plot(log(cases) ~ time, df, xaxt = "n", type="b", main="COVID-19: Cases Germany (log-scale)",xlab="Date", ylab="Log of cases")
axis(1, df$time, format(df$time, "%d.%m"), cex.axis = .8,las = 2)
dev.off()

# Subset df to last week
df = df[(nrow(df)-6):nrow(df),]
df$ntime = seq(1:nrow(df))

# Linear regression to find average growth rate
reg = lm(log(cases)~ntime, data=df)
reg2 = lm(log(cases)~poly(ntime,4),data=df)
g = gam(log(cases)~s(ntime,5),data=df)
summary(reg)
summary(reg2)

# Compare actual values and prediction
pred = predict(reg, newdata=df)
pred2 = predict(reg2, newdata=df)
res = data.frame(pred,pred2, log(df$cases), df$ntime, df$cases, round(exp(pred)), round(exp(pred2)))
colnames(res)<-c("pred", "pred2","logcases", "ntime", "cases", "exp_pred", "exp_pred2")

# Plot actual values and prediction
png(filename=paste0("C:/Users/User/Pictures/", Sys.Date(),"_trend.png"), width = 800, height = 600)
plot(res$ntime,res$logcases, xlab = "Days", ylab="Log of cases", main="COVID-19: Cases in Germany last seven days (log-scale and trend)")
lines(res$ntime,res$pred,col="blue")
lines(res$ntime,res$pred2,col="black")
dev.off()

# Predict cases over longer period assuming growth rates
ntime = seq(1:17)
mydates = seq(as.Date(paste0(min(df$time),"%d-%m-%Y")), by = "day", length.out = length(ntime))
ltp = data.frame(ntime,mydates)
ltp$mod1 = round(exp(predict(reg, newdata=ltp)))
ltp$mod2 = round(exp(predict(reg2, newdata=ltp)))

# Plot prediction with different growth rates
png(filename=paste0("C:/Users/User/Pictures/", Sys.Date(),"_pred.png"), width = 800, height = 600)
plot(mod1 ~ mydates, ltp, xaxt = "n", type="b", main="COVID-19: Cases in Germany (actual [blue] and prediction [red/black])",xlab="Date", ylab="Cases", col = "red", yaxt='n')
axis(2,cex.axis=1)
lines(mod2 ~ mydates, ltp, type = "o", col = "black")
# Actual cases
lines(cases ~ time, df, type = "o", col = "blue")
axis(1, ltp$mydates, format(ltp$mydates, "%d.%m"), cex.axis = .8,las = 2)
abline(v=as.Date(paste0(today),"%d-%m-%Y"), col=c("black"),lty=2)
abline(v=as.Date(paste0(tomor),"%d-%m-%Y"), col=c("black"),lty=2)
dev.off()

# Growth rate (last seven days)
print(paste0("From: ", min(df$time), " to: ", max(df$time)))
print(paste0("Data since: ", min(df$time)," | Growth rate: ",exp(reg$coefficients[2])-1))
