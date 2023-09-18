<p align="center">
  <img src="replace_with_image_url" alt="Air Quality Trend Analysis - Los Angeles" width="300">
</p>

# Air Quality Trend Analysis - Los Angeles 🌆📊

## Table of Contents 📋

1. [Introduction](#introduction)
2. [Executive Summary](#executive-summary)
3. [Data Preparation](#data-preparation)
4. [Exploring the Data](#exploring-the-data)
5. [Model Planning](#model-planning)
6. [Model Building](#model-building)
7. [Forecasting](#forecasting)
8. [Conclusion](#conclusion)
9. [References](#references)
10. [Appendix](#appendix)

---

## Introduction 📚

The Air Quality Index (AQI) is a crucial metric for assessing the quality of air in a specific area and understanding the potential hazards associated with it. Air pollution, driven by factors such as vehicular emissions, industrial activities, and natural disasters, poses significant health risks. This report delves into the trend analysis of AQI in the Los Angeles Long Beach metropolitan area for the years 2000 to 2010.

## Executive Summary 📈📉

Key Events Related to Air Quality in Los Angeles Long Beach (2000-2010):

1. **California Energy Crisis (2000-2001):** Increased use of diesel-powered generators led to higher particulate matter and nitrogen oxide emissions, impacting air quality.

2. **Clean Air Act Amendments (2003):** Amendments established new emission standards for diesel engines and nonroad vehicles, contributing to reduced emissions.

3. **South Coast Air Basin 2007 Plan:** Developed to reduce air pollution, this plan included measures like emission reductions and vehicle scrappage programs.

4. **Porter Ranch Gas Leak (2015):** A significant gas leak caused environmental damage and health issues in the region.

5. **California Wildfires (2003 and 2007):** Wildfires released pollutants into the air, affecting air quality and public health.

6. **Recession (2008-2009):** Economic slowdown led to reduced industrial activity, improving air quality.

The AQI in Los Angeles Long Beach gradually improved during this period. The highest AQI was in 2003, while the lowest was in 2010, attributed to stricter emission standards, cleaner fuels, and expanded public transportation. However, challenges like wildfires and ongoing efforts to reduce emissions persist.

## Data Preparation 🧹📊

- Data Source: [Kaggle - US Pollution Data](https://www.kaggle.com/datasets/sogun3/uspollution)
- Filtering: Focused on a specific location, '3648 N. LONG BEACH BLVD. LONG BEACH,' and selected 'NO2 AQI' for analysis.
- Data Aggregation: Aggregated data into weekly and monthly averages to explore trends at different granularities.

## Exploring the Data 🔍📈

- Daily and weekly data showed noise and variability, likely due to weather and location-specific factors.
- Monthly averages revealed clearer seasonality patterns, making it suitable for modeling.

## Model Planning 📈📊

- Unit Root Test (Augmented Dickey-Fuller): Confirmed stationarity of the series.
- Seasonality Effect: Detected seasonality with a period of 12 months.
- Seasonal Differencing: Seasonal differences removed seasonality from the data.
- Model Selection: Considered Seasonal ARMA(1,1,1) model based on AIC.

## Model Building 🛠️🔍

- Coefficient Tests: Evaluated coefficients and confirmed model adequacy.
- Residual Analysis: Box-Ljung test and ACF/PACF of residuals confirmed white noise.
- Best Model: ARIMA(0,0,0) x SARIMA(1,1,1) was chosen based on AIC and rolling forecasts.

## Forecasting 📈📉

- Fitted Values vs. Actual Values: Model fitted well with some exceptions due to events like wildfires.
- Predicting Values: Model predicted AQI for 2010, reflecting a gradual decline.

## Conclusion 📝🔮

- The AQI in Los Angeles Long Beach improved from 2000 to 2010, with noticeable seasonality.
- Legislation, economic factors, and wildfires influenced air quality trends.
- Ongoing efforts are needed to maintain and further improve air quality in the region.

## References 📚🔗

1. [Reference 1](https://www.energy.ca.gov/2001publications/CEC-500-2001-082/CEC-500-2001-082.PDF)
2. [Reference 2](https://www.epa.gov/sites/production/files/2016-09/documents/caaa_2003_summary.pdf)
3. [Reference 3](https://www.aqmd.gov/docs/default-source/clean-air-plans/2007-air-quality-management-plan.pdf)
4. [Reference 4](https://www.nytimes.com/2016/07/15/us/porter-ranch-gas-leak-california-biggest-worlds.HTML)
5. [Reference 5](https://ww3.arb.ca.gov/ei/wildfire)

