# COVID-19 Cases in Germany

21 March 2020

This article presents a brief overview of the current development of COVID-19 cases in Germany as of 21 March 2020. I identify the rate of growth in new infections per day and look at short term development of cases (overall numer of infected people) under different growth assumtions.

**1. Data and Basic Trends**

Data on COVID-19 cases are currently published daily by [Robert Koch-Institut (RKI)](https://www.rki.de/DE/Content/InfAZ/N/Neuartiges_Coronavirus/Fallzahlen.html).


|Date| Cases| 
|---|---|
|  2020-02-29  |     66|
|  2020-03-01  |    117|
|  2020-03-02   |   150|
|  2020-03-03    |  188|
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

Around March 16th, first precautionary measures have been taken on a broader scale by German States (Bundesländer), including official recommendations to stay at home if possible and to avoid unnecessary travels. From March 21th onwards stronger regulation is in place in two States (Bayern, Saarland), basically restricting freedom of movement for most people.

Between February 29th and March 21st, the growth of cases showed a linear trend over time on a semi-log scale.


![trend](2020_03_21_covid19_log_and_trend_germany.JPG)


**2. Linear Regression**

It is easy to get an estimate of the current growth of COVID-19 infections in Germany. Simply run a linear regression on the log of cases (y) with the number of days on the right hand side of the equation (x). I use only the last week to estimate the current trend in new infections in order to capture the latest developments.

![equ](https://latex.codecogs.com/gif.latex?log(y)=\beta_0&space;&plus;&space;\beta_1&space;x&space;&plus;&space;u.)

The regression results are:

```
Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 8.042650   0.030129  266.94 1.87e-13 ***
ntime       0.209543   0.005966   35.12 3.55e-08 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.03867 on 6 degrees of freedom
Multiple R-squared:  0.9952,	Adjusted R-squared:  0.9944 
F-statistic:  1233 on 1 and 6 DF,  p-value: 3.552e-08
```

The results imply that the growth rate of COVID-19 cases in Germany over the last week was about 23% [on average](https://www.uni-regensburg.de/wirtschaftswissenschaften/vwl-tschernig/medien/mitarbeiter/rameseder/interpretation.pdf).


**3. Prediction**

Because the incubation period of the corona virus is relatively long, we can reasonably assume, that the current trend will continue for the next ten or so days.

Under the assumtion that the growth of newly infected people will be unchanged (compared to last week), we will see a strong increase in the total number of cases in Germany until the end of March (this is the red line in the figure below). 

If we *could* have knocked off only a few percentage points from the growth rate - say 17% instead of 23% - the situation would be entirely different!

Under the assumtion of a 17% growth rate of newly infected people, the total number of infections would be much lower (green line in the plot below).

**Thus, it is extremely immportant, to do anything that can be done, to slow down the current pace of new infections.** If the current trend would continue over a longer period (say 4-6 weeks), the consequences could be extreme.

![pred](2020_03_21_covid19_prediction_germany.JPG)

The figure shows actual cases (until 21 March 2020) and the predicted number of cases (from 21 March onwards) under the assumption of unchanged growth rate of 23% (red) and a lower growth rate (green) of 17%.

**4. Conclusion**

Stay at home!
