# COVID-19: Cases and Deaths in Germany

*Last update: 15 April 2020*

This article presents a brief overview of the current development of known COVID-19 cases/deaths in Germany. I investigate the rate of growth of newly reported infections/deaths and look at short term development. Find the R source file [here](https://github.com/Bixi81/COVID-19/blob/master/covid_19_county_data_germany.r).

**1. Current Situation**

Data on known COVID-19 cases in Germany are currently published daily by the [Robert Koch-Institut (RKI)](https://www.rki.de/DE/Content/InfAZ/N/Neuartiges_Coronavirus/Fallzahlen.html).

**Find time series data on reported cases and deaths in Germany** [here](https://github.com/Bixi81/COVID-19/blob/master/covid19_germany.csv). This data is based on detailed county/patient level data as published by RKI daily [here](https://npgeo-corona-npgeo-de.hub.arcgis.com/datasets/dd4580c810204019a7b8eb3e0b329dd6_0). R source code [here](https://github.com/Bixi81/COVID-19/blob/master/covid_19_county_data_germany.r).

Around 16 March 2020, first precautionary measures have been taken on a broader scale by German States (Bundesländer), including official recommendations to stay at home if possible and to avoid unnecessary travels. From 21 March 2020 onwards, stronger regulation is in place in two States (Bayern, Saarland), basically limitating freedom of movement for most people. 

Starting 23 March 2020, similar restrictions have been implemented all over Germany. These restrictions include a ban on gatherings of more than two people in the public. All restaurants and bars and most of shops are closed. All events are called off including sport events, concerts etc. Many factories are closed (including car makers such as Daimler, BMW, Volkswagen). Many office workers work from home. These restrictions will stay in force at least until 20 April 2020, according to the Bundesregierung (as of 28 March 2020).

The testing capacity in Germany is about 360,000 per week, according to the German ministry of health. About 10% of tested persons are tested positive (as of 28 March 2020).

As of 30 March, according to [Deutsche Krankenhausgesellschaft (DKG)](https://www.dkgev.de/dkg/coronavirus-fakten-und-infos/), 7000 people are treated in hospitals in Germany because of Covid-19 infections. 1500 of the 7000 are in intensive care and 1100 are treated using ventilators. Also according to the DKG, the capacity of intensive care in Germany before Covid-19 was 28000, 20000 of which with ventilators. As of 30 March, the capacity has been increased to 40000 with 30.000 ventilators. A newly installed register gives an overview of intensive care capacities in use: [DIVI Intensivregister](https://www.intensivregister.de/#/intensivregister).

As of 31 March, the lethality of Covid-19 in Germany is about 0.8 percent according to RKI. The lethality is expected to increase within the next weeks in case more elderly are infected by Covid-19 and/or in case the number of treated patients rises. Information from South Korea imply that the lethality of Covid-19 is about 1.1%. The figure is based on broad testing in South Korea, which allows a relatively accurate assessment of the overall number of infections. After correction for the age distribution, the lethality observed in South Korea could translate to a lethality of about 1.3% in Germany.

As of 3 April, about 2300 of medical staff in German hospitals are infected with Covid-19, according to the Newspaper "Süddeutsche Zeitung" which cites RKI sources.

As of 4 April 2020, according to German [media reports](https://www.swr.de/swraktuell/corona-testkapazitaeten-gesteigert-100.html), the Covid-19 test capacity in Germany currently amounts to 100000 per day, compared to 7000 per day in early March. In South Korea, about 400000 people are tested daily.

5 April 2020: Germany's chancellery minister Helge Braun - according to media reports - says that new infections must not double in less than 10 to 14 days, in order for the German health sector, to cope with the number of patients. 

10 April 2020: The Austrian Government has conducted [Covid-19 tests](https://www.nzz.ch/wissenschaft/coronavirus-test-oesterreich-und-nrw-leisten-pionierarbeit-ld.1551267) on 1544 individuals on 6 April. The test results suggest that between 0.12 and 0.76 percent of the population carry the virus. This would be 28500 people in total (expected value) - about 2.3 times of known infections in Austria [as of 6 April](https://info.gesundheitsministerium.at).

13 April 2020: According to preliminary results of a study by Hendrik Streeck et al. in the German county of Heinsberg - one of the most affected counties in Germany - the lethality of Covid-19 is [about 0.37 percent](https://www.tagesspiegel.de/wissen/virologe-streeck-zur-coronavirus-studie-die-veroeffentlichung-zu-heinsberg-war-nicht-leichtfertig/25735672.html) in the region. 

15 April 2020: The federal government (Bundesregierung) proposes to the states (Bundesländer), that public restrictions including closure of shops, bars, restaurants, schools, a ban on public gatherings and events, closure of most borders (except for commuters and goods), should keep in force until at least 3 May 2020. These restrictions have been in force sind 23 March 2020. The detailed implementation in many aspects (e.g. closure of schools and shops) is the responsibility of the States (Bundesländer).

**2. Overall Trends**

The figure below shows growth rates of newly discovered/reported infections/deaths (estimated over a seven day "lookback" period) over time. Find a time series of growth rates [here](https://github.com/Bixi81/COVID-19/blob/master/covid19_growth_rates_germany.csv).

![growth](2020-04-15growth.jpg)


**3. Prediction of Newly Discovered/Reported Infections and Reported Deaths**

The figures below show actual cases/deaths (blue) and the predicted number of cases/deaths under the assumption of unchanged growth rate (red: linear OLS on semi-log scale).

![pred1](2020-04-15cases_trend.png)


![pred2](2020-04-15deaths_trend.png)

**4. Deaths and Known Infections by Age**

[RKI](https://npgeo-corona-npgeo-de.hub.arcgis.com/datasets/dd4580c810204019a7b8eb3e0b329dd6_0) also provides patient-level data by county. Patient information include age groups. The data shows that most infected people are 35 to 59 years old (about 48%). In the age groups 60 to 79 (18%) and 80+ (6%), there are relatively few known cases.

![infected](2020-04-04_cases_age.png)

However, when looking at deaths, the age groups 80+ (63%) and 60-79 years (31%) are extremely over-represented. This implies that - as of today - mostly older people die in consequence of a Covid-19 infection.

![infected](2020-04-04_death_age.png)

**5. Conclusion**

Stay at home!
