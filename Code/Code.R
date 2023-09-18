library(stringr)
library(xts)
library(tseries)
library(TSA)
library(lmtest)

set.seed(121)
#----------daily data-------------

data = read.csv('LA_pollution.csv')
head(data)


datats=ts(data[14],start=c(2000,1,1), frequency=365.25)
plot(datats, xlab = 'Year', ylab = 'AQI', main = 'Air Pollution Index (Daily)')

#----------weekly data-------------

dataw = read.csv('pollution_week.csv')

head(dataw)

datats=ts(dataw,start=c(2000,1,1), frequency=365.25/7)
plot(datats, xlab = 'Year', ylab = 'AQI', main = 'Air Pollution Index (Weekly)')

#----------monthly-----------------

datam = read.csv('pollution_monthly.csv')

head(datam)

datamts=ts(datam$X1[1:117],start=c(2000,1), frequency=12)
datamts.new=ts(datam$X1[118:131],start=c(2010,1), frequency=12)
plot(datamts, xlab = 'Year', ylab = 'AQI', main = 'Air Pollution Index (Monthly)')

adf.test(datamts)
#time series is stationary

acf(datamts,lag.max=60,main="ACF of AQI Time Series")
# Period 3 with MA

pacf(datamts,lag.max=60,main="PACF of AQI Time Series")
#peroid 3 with AR

# obvuois seasonality at period 12
sd_datamts=diff(datamts,12)
plot(sd_datamts,xlab = 'Year', ylab = 'AQI', main = 'Air Pollution Index Series with Seasonal Difference')

acf(sd_datamts,lag.max=60,main="ACF of AQI Time Series with Seasonal Difference")
pacf(sd_datamts,lag.max=60,main="PACF of AQI Time Series with Seasonal Difference")

n=length(datamts)

out = arima(datamts,c(0,0,0),xreg =1:n,seasonal = list(order = c(1, 1, 1), period = 12))
out
coeftest(out)

out1 = arima(datamts,c(0,0,0),xreg =1:n,seasonal = list(order = c(0, 1, 1), period = 12))
out1
coeftest(out1)

out2 = arima(datamts,c(0,0,0),xreg =1:n,seasonal = list(order = c(1, 1, 0), period = 12))
out2
coeftest(out2)

Box.test(out$residuals, type = 'Ljung',lag = 60)

acf(out$residuals,lag.max=60,main="ACF of Residuals of Seasonal Model")
pacf(out$residuals,lag.max=60,main="PACF of Residuals of Seasonal Model")
eacf(out$residuals)


outf = arima(datamts,c(0,0,0),xreg =1:n,seasonal = list(order = c(1, 1, 1), period = 12))
outf
coeftest(outf)

source("rolling.forecast.R")

rolling.forecast(datamts, 3, length(datamts)-10, c(0,0,0),seasonal = list(order = c(1, 1, 1)))


outf1 = arima(datamts,c(1,0,1),xreg =1:n,seasonal = list(order = c(1, 1, 1), period = 12))
outf1
coeftest(outf1)
rolling.forecast(datamts, 3, length(datamts)-10,c(1,0,1),seasonal = list(order = c(1, 1, 1)))


Box.test(outf$residuals, type = 'Ljung',lag = 60)

acf(outf$residuals,lag.max=60,main = "ACF of Residuals of Final Model")
pacf(outf$residuals,lag.max=60, main = "PACF of Residuals of Final Model")


fit = ts(fitted.values(outf), start = 2000, frequency = 12)


#pdf('fit_0417.pdf',width=8,heigh t=4)
par(mfrow = c(1,1))
plot(datamts, ylim=c(min(datamts), max(fit)), xlab = 'Year', ylab = 'AQI', main = 'Air Pollution Index')
points(fit, col = 'red', pch = 2)
lines(fit, col = 'red', lty = 2)
legend.text=c("Actual values", "Fitted values")
legend("bottomleft", legend.text, lty = rep(1,2), col = 1:2, pch = 1:2)
#dev.off()

#pdf('pred_0417.pdf',height=5,width=8)
time.pred = time(datamts)[118:length(datamts)]
pp = predict(outf, 12)
pred = ts(pp$pred, start =2010 , frequency = 12)
pred.upp = ts(pp$pred+2*pp$se, start = 2010, frequency = 12)
pred.low = ts(pp$pred-2*pp$se, start = 2010, frequency = 12)

plot(datamts, type = 'o',xlim = c(2000,2011), xlab = 'Year', ylab = 'AQI', main = 'Air Pollution Index')
lines(pred, col = 'red')
points(pred, col = 'red', pch = 2)
lines(pred.low, col = 'red', lty = 2)
lines(pred.upp, col = 'red', lty = 2)
lines(datamts.new, col = 'blue', type = 'o')
legend.text=c("Past Values", "Prediction","Actual Values")
legend("bottomleft", legend.text, lty = rep(1,2,3), col = c(1,'red','blue'), pch = c(1,2,1))
#dev.off()



