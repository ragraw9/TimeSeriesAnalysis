# Load necessary libraries
library(dplyr)
library(ggplot2)
library(ggfortify)
library(TSstudio)
library(forecast)
library(tseries)

# Load the S&P500 dataset
sp500_data <- read.csv("./data/sp500_index.csv")

# Display the first 20 rows of the dataset
head(sp500_data, 20)

# Check data types for each column
sapply(sp500_data, class)

# Convert the Date column from character to Date type
sp500_data <- sp500_data %>%
  mutate(Date = as.Date(Date))

# Verify the data types after conversion
sapply(sp500_data, class)

# Add a Year-Month column for grouping purposes
sp500_data$Year_Month <- format(as.Date(sp500_data$Date), "%Y-%m")

# Print the structure of the transformed dataset
sapply(sp500_data, class)
head(sp500_data, 20)

# Calculate monthly averages and create a new dataframe
monthly_avg_sp500 <- sp500_data %>%
  group_by(Year_Month) %>%
  summarise(Average_SP500 = mean(S.P500))

# Extract the monthly average values into a new list
monthly_avg_values <- monthly_avg_sp500$Average_SP500

# Plot the monthly average values
plot(monthly_avg_values, type = 'l', main = "Monthly Average of S&P 500", xlab = "Months", ylab = "Average Index")

# Create a Time Series object from the monthly average values
ts_sp500 <- ts(monthly_avg_values, start = c(2012, 12), end = c(2022, 12), frequency = 12)

# Plot the Time Series object
plot(ts_sp500, main = "S&P 500 Time Series", xlab = "Year", ylab = "Index")
autoplot(ts_sp500)

# Provide information about the time series
ts_info(ts_sp500)

# Subset the time series using the window function
subset_ts_sp500 <- window(ts_sp500, start = c(2017, 5), end = c(2020, 6))
autoplot(subset_ts_sp500)

# Apply a moving average function
plot(ts_sp500, main = "Raw vs. Moving Average")
lines(ma(ts_sp500, order = 3), col = "red")
lines(ma(ts_sp500, order = 5), col = "blue")

# Demonstrate the use of ggtsdisplay for diagnostic plotting
ggtsdisplay(ts_sp500)

# Seasonal decomposition using both multiplicative and additive approaches
fit_multiplicative <- decompose(ts_sp500, type = "multiplicative")
plot(fit_multiplicative)

fit_additive <- decompose(ts_sp500, type = "additive")
plot(fit_additive)

# Seasonal decomposition using STL
fit_stl <- stl(ts_sp500, s.window = "periodic")
plot(fit_stl)

# Display ACF to analyze autocorrelations
ggAcf(ts_sp500)

# Example of simple time series models
# Mean model
fcast_mean <- meanf(ts_sp500, h = 3)
plot(fcast_mean)

# Naive model
fcast_naive <- naive(ts_sp500, h = 3)
plot(fcast_naive)

# Seasonal naive model
fcast_seasonal_naive <- snaive(ts_sp500, h = 3)
plot(fcast_seasonal_naive)

# Drift model
fcast_drift <- rwf(ts_sp500, h = 3, drift = TRUE)
plot(fcast_drift)

# Simple Exponential Smoothing model
ses_model <- ses(ts_sp500, h = 3)
plot(ses_model)

# Holt's linear model
holt_model <- holt(ts_sp500, h = 3)
plot(holt_model)

# ETS model
ets_model <- ets(ts_sp500, model = "ZZZ")
plot(ets_model)

# ARIMA model
arima_model <- auto.arima(ts_sp500)
forecasts <- forecast(arima_model, h = 6)
plot(forecasts)
