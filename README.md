# COVID-19 Cases in Germany

Last update: 1 April 2020

This article presents a brief overview of the current development of COVID-19 cases in Germany. I investigate the rate of growth of newly discovered/reported infections in Germany and look at short term development of cases, assuming an unchanged growth rate. Find the R source code [here](https://github.com/Bixi81/COVID-19/blob/master/2020_03_28_covid19.r).

**1. Current Situation**

Data on known COVID-19 cases in Germany are currently published daily by the [Robert Koch-Institut (RKI)](https://www.rki.de/DE/Content/InfAZ/N/Neuartiges_Coronavirus/Fallzahlen.html).


|Date| Cases| 
|---|---|
|  2020-02-29  |     66|
|  2020-03-01  |    117|
|  2020-03-02   |   150|
|  2020-03-03   |   188|
|  2020-03-04   |   262|
|  2020-03-05   |   349|
|  2020-03-06   |   639|
|  2020-03-07   |   795|
|  2020-03-08   |   902|
| 2020-03-09    | 1139|
| 2020-03-10    | 1296|
| 2020-03-11    | 1567|
| 2020-03-12|     2369|
| 2020-03-13|     3062|
| 2020-03-14|     3795|
| 2020-03-15|     4838|
| 2020-03-16|     6012|
| 2020-03-17|     7156|
| 2020-03-18|     8198|
| 2020-03-19|    10999|
| 2020-03-20|    13957|
| 2020-03-21|    16662|
| 2020-03-22|    18610|    
| 2020-03-23|    22672|    
| 2020-03-24|    27436|    
| 2020-03-25|    31554|    
| 2020-03-26|    36508|    
| 2020-03-27|    42288|    
| 2020-03-28|    48582|   
|2020-03-29| 52547|
|2020-03-30| 57298|
|2020-03-31| 61913|
|2020-04-01| 67366|
|2020-04-02| 75522|

Around 16 March 2020, first precautionary measures have been taken on a broader scale by German States (Bundesländer), including official recommendations to stay at home if possible and to avoid unnecessary travels. From 21 March 2020 onwards, stronger regulation is in place in two States (Bayern, Saarland), basically limitating freedom of movement for most people. 

Starting 23 March 2020, similar restrictions have been implemented all over Germany. These restrictions include a ban on gatherings of more than two people in the public. All restaurants and bars and most of shops are closed. All events are called off including sport events, concerts etc. Many factories are closed (including car makers such as Daimler, BMW, Volkswagen). Many office workers work from home. These restrictions will stay in force at least until 20 April 2020, according to the Bundesregierung (as of 28 March 2020).

The testing capacity in Germany is about 360,000 per week, according to the German ministry of health. About 10% of tested persons are tested positive (as of 28 March 2020).

As of 30 March, according to [Deutsche Krankenhausgesellschaft (DKG)](https://www.dkgev.de/dkg/coronavirus-fakten-und-infos/), 7000 people are treated in hospitals in Germany because of Covid-19 infections. 1500 of the 7000 are in intensive care and 1100 are treated using ventilators. Also according to the DKG, the capacity of intensive care in Germany before Covid-19 was 28000, 20000 of which with ventilators. As of 30 March, the capacity has been increased to 40000 with 30.000 ventilators. A newly installed register gives an overview of intensive care capacities in use: [DIVI Intensivregister](https://www.divi.de/register/intensivregister).

As of 31 March, the lethality of Covid-19 in Germany is about 0.8 percent according to RKI. The lethality is expected to increase within the next weeks in case more elderly are infected by Covid-19 and/or in case the number of treated patients rises. Information from South Korea imply that the lethality of Covid-19 is about 1.1%. The figure is based on broad testing in South Korea, which allows a relatively accurate assessment of the overall number of infections. After correction for the age distribution, the lethality observed in South Korea could translate to a lethality of about 1.3% in Germany.

As of 3 April, about 2300 of medical staff in German hospitals are infected with Covid-19, according to the Newspaper "Süddeutsche Zeitung" which cites RKI sources.

As of 4 April 2020, according to German [media reports](https://www.swr.de/swraktuell/corona-testkapazitaeten-gesteigert-100.html), the Covid-19 test capacity in Germany currently amounts to 100000 per day, compared to 7000 per day in early March. In South Korea, about 400000 people are tested daily.

**2. Overall Trends**

On a semi-log scale, the number of newly discovered/reported infections keeps growing. However, there is a slight decrease of the growth rate over time on average.

![trend1](2020-04-01_cases_log_scale.png)

Since 26 March, the growth of newly discovered/reported infections shows a linear trend on a semi-log scale. But more recent observations are below the linear trend line, indicating a falling rate.

![trend2](2020-04-01_trend.png)


**3. Growth Rate**

The current growth of COVID-19 infections in Germany (last seven days) is estimated using a linear regression on the log of cases (y) with the number of days as independent variable (x). The estimation is based on the last seven days, to capture the current trend in newly discovered/reported infections.

![equ](https://latex.codecogs.com/gif.latex?log(y)=\beta_0&space;&plus;&space;\beta_1&space;x&space;&plus;&space;u.)

The regression results are:

```
Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) 10.451447   0.027452  380.72 2.37e-12 ***
ntime        0.098760   0.006138   16.09 1.69e-05 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.03248 on 5 degrees of freedom
Multiple R-squared:  0.9811,	Adjusted R-squared:  0.9773 
F-statistic: 258.9 on 1 and 5 DF,  p-value: 1.69e-05
```

The results imply that the growth rate of COVID-19 cases in Germany over the last week was about 10% [on average](https://www.uni-regensburg.de/wirtschaftswissenschaften/vwl-tschernig/medien/mitarbeiter/rameseder/interpretation.pdf).

The growth rate kept falling over the last few days:


|Date| Seven day growth trend| 
|---|---|
|24.03. | 0.21 |
|25.03. | 0.19|
|26.03 | 0.18|
|27.03. | 0.17|
|28.03. | 0.17|
|29.03 | 0.15|
|30.3 | 0.13|
|31.3 | 0.12|
|1.4 | 0.10|


**4. Prediction of Newly Discovered/Reported Infections**

Under the assumtion that the growth of newly discovered/reported infections will be unchanged (compared to last week), it is possible to predict the number of newly discovered/reported infections over the next few days. 

Provided that the current trend continues, the number of infected people would double in about seven to eight days.

![pred](2020-04-01_pred.png)

The figure shows actual cases (blue) and the predicted number of cases under the assumption of unchanged growth rate (red: linear OLS on semi-log scale).

**5. Deaths and Known Infections by Age**

[RKI](https://npgeo-corona-npgeo-de.hub.arcgis.com/datasets/dd4580c810204019a7b8eb3e0b329dd6_0) also provides patient-level data by county. Patient information include age groups. The data shows that most infected people are 35 to 59 years old (about 48%). In the age groups 60 to 79 (18%) and 80+ (6%), there are relatively few known cases.

![infected](2020-04-01_cases_age.png)

However, when looking at deaths, the age groups 80+ (63%) and 60-79 years (31%) are extremely over-represented. This implies that - as of today - mostly older people die in consequence of a Covid-19 infection.

![infected](2020-04-01_death_age.png)

**6. Conclusion**

Stay at home!
