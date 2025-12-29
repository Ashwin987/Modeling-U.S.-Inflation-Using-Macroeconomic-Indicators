
setwd("C:/UCLA/404/Final Projext")


library(mgcv)

inflation_data <- read.csv("Final_Inflation_Dataset__USA_.csv", stringsAsFactors = FALSE)


# inflation_data columns: Year, Inflation, GDP_Growth, Interest_Rate, Unemployment_Rate

# Load libraries
library(ggplot2)
library(dplyr)
library(corrplot)
library(GGally)
library(gridExtra)

# 1. Summary Statistics
summary(inflation_data)
sapply(inflation_data[, -1], sd)  # Standard deviation (excluding Year)
#Plots
# Time Series Plots with Year on x-axis
p1 <- ggplot(inflation_data, aes(x = Inflation, y = GDP_Growth)) +
  geom_line(color = "steelblue") +
  labs(title = "Inflation Rate Over Time", x = "Year", y = "GDP Growth (%)")

p3 <- ggplot(inflation_data, aes(x = Inflation, y = Interest_Rate)) +
  geom_line(color = "red") +
  labs(title = "Interest Rate Over Time", x = "Year", y = "Interest Rate (%)")

p4 <- ggplot(inflation_data, aes(x = Inflation, y = Unemployment_Rate)) +
  geom_line(color = "purple") +
  labs(title = "Unemployment Rate Over Time", x = "Year", y = "Unemployment Rate (%)")

# Arrange in 2x2 layout
grid.arrange(p1, p3, p4, ncol = 2)


# 3. Correlation Matrix
cor_matrix <- cor(inflation_data[, -1], use = "complete.obs")
corrplot(cor_matrix, method = "circle", type = "upper", tl.cex = 0.8)




# 6. Check for missing data
colSums(is.na(inflation_data))


str(inflation_data)

summary(inflation_data)

inflation_data <- inflation_data[, 1:5]  







#Linear Model

model_lm <- lm(GDP_Growth ~ Interest_Rate + Unemployment_Rate + Year, data = inflation_data)
summary(model_lm)

# Diagnostic plots
par(mfrow = c(2, 2))
plot(model_lm)




#Kernel Regression
par(mfrow = c(1, 3))  

# Unemployment vs Inflation
loess_unemp <- loess(Inflation ~ Unemployment_Rate, data = inflation_data, span = 0.6)
x_unemp <- seq(min(inflation_data$Unemployment_Rate), max(inflation_data$Unemployment_Rate), length.out = 100)
pred_unemp <- predict(loess_unemp, newdata = data.frame(Unemployment_Rate = x_unemp), se = TRUE)

plot(inflation_data$Unemployment_Rate, inflation_data$Inflation,
     main = "Kernel Regression: Unemployment vs Inflation",
     xlab = "Unemployment Rate (%)", ylab = "Inflation by Year", pch = 19, col = "gray")
lines(x_unemp, pred_unemp$fit, col = "blue", lwd = 2)
lines(x_unemp, pred_unemp$fit + 1.96 * pred_unemp$se.fit, col = "blue", lty = 2)
lines(x_unemp, pred_unemp$fit - 1.96 * pred_unemp$se.fit, col = "blue", lty = 2)

# Interest Rate vs Inflation
loess_int <- loess(Inflation ~ Interest_Rate, data = inflation_data, span = 0.6)
x_int <- seq(min(inflation_data$Interest_Rate), max(inflation_data$Interest_Rate), length.out = 100)
pred_int <- predict(loess_int, newdata = data.frame(Interest_Rate = x_int), se = TRUE)

plot(inflation_data$Interest_Rate, inflation_data$Inflation,
     main = "Kernel Regression: Interest Rate vs Inflation",
     xlab = "Interest Rate (%)", ylab = "Inflation by Year", pch = 19, col = "gray")
lines(x_int, pred_int$fit, col = "red", lwd = 2)
lines(x_int, pred_int$fit + 1.96 * pred_int$se.fit, col = "red", lty = 2)
lines(x_int, pred_int$fit - 1.96 * pred_int$se.fit, col = "red", lty = 2)

# GDP Growth vs Inflation
loess_gdp <- loess(Inflation ~ GDP_Growth, data = inflation_data, span = 0.6)
x_gdp <- seq(min(inflation_data$GDP_Growth), max(inflation_data$GDP_Growth), length.out = 100)
pred_gdp <- predict(loess_gdp, newdata = data.frame(GDP_Growth = x_gdp), se = TRUE)

plot(inflation_data$GDP_Growth, inflation_data$Inflation,
     main = "Kernel Regression: GDP Growth vs Inflation",
     xlab = "GDP Growth (%)", ylab = "Inflation by Year", pch = 19, col = "gray")
lines(x_gdp, pred_gdp$fit, col = "darkgreen", lwd = 2)
lines(x_gdp, pred_gdp$fit + 1.96 * pred_gdp$se.fit, col = "darkgreen", lty = 2)
lines(x_gdp, pred_gdp$fit - 1.96 * pred_gdp$se.fit, col = "darkgreen", lty = 2)


#  GAM
library(mgcv)
model_gam <- gam(GDP_Growth ~ s(Interest_Rate) + s(Unemployment_Rate) + s(Year), data = inflation_data)

summary(model_gam)

par(mfrow = c(1, 3))
plot(model_gam, se = TRUE, col = "darkgreen")






