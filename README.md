# S&P 500 Index Time Series Analysis (2012-2022)

This documentation outlines the analytical process and forecasting methodologies applied to a time series dataset of the S&P 500 index, covering daily closing values from December 2012 to December 2022.

## Overview
The objective was to dissect the time series data to understand its characteristics, fit various forecasting models, and identify the most accurate model based on empirical data. The final aim was to project future index values using the selected model.

## Data Overview
The dataset comprised the S&P 500 daily closing prices over a decade. To normalize the dataset for time series analysis, monthly averages are computed due to the varying number of trading days in each month.

## Data Preprocessing
Preprocessing involved transforming daily data points into a consistent monthly average, facilitating the creation of a uniform time series.

## Time Series Analysis
The analysis was initiated by plotting the data to visualize trends and patterns. It was observed that the series exhibited a clear upward trend without obvious seasonality or cyclical behavior. Decomposition of the series using the classical method confirmed the absence of seasonality, indicating an additive model was most appropriate.

## Model Selection
A suite of models was explored to forecast future values:

- **Simple Methods**: Average, Naive, Seasonal Naive, and Drift methods were evaluated, with Drift providing the most promising initial results.
- **Exponential Smoothing Functions**: Methods including Single, Double, and Triple Exponential Smoothing were tested. Despite the inherent trend in the data, the Holt-Winters method emerged as a front-runner.
- **ARIMA**: A thorough ARIMA model-building process was employed, including stationarity checks, differencing, and ACF/PACF analysis. Parameters were fine-tuned, and an auto.arima function was used to determine the best fit based on the Akaike Information Criterion (AIC).

## Model Evaluation
Residual diagnostics played a critical role in model evaluation. The ideal model's residuals would exhibit no autocorrelation, zero mean, constant variance, and normal distribution. The Ljung-Box test was applied to assess autocorrelation in the residuals.

## Model Implementation and Iterations
Over three iterations, models were constructed and assessed. Each iteration incorporated increasingly sophisticated techniques, culminating in the ARIMA model selection.

## Forecasting
Utilizing the ARIMA model identified as the best fit, a six-period forecast was generated, complete with 80% and 95% confidence intervals.

## Conclusion
The ARIMA model selected through the auto.arima function yielded the most reliable forecast. The Average method was the least effective, while the ARIMA model proved superior, as evidenced by its lower RMSE and improved residual characteristics. The forecast produced by this model serves as a quantitative basis for potential investment strategies moving forward.
