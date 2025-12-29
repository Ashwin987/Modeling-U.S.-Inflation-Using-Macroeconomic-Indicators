# Set working directory
setwd("C:/UCLA/404/Final Projext")

# Load the DLL
dyn.load("rolling_average.dll")

# Define R wrapper
rolling_average <- function(x, w) {
  .Call("rolling_average", as.numeric(x), as.integer(w))
}

# Ensure Year is numeric
inflation_data$Year <- as.numeric(inflation_data$Year)

# Apply rolling average from C function
inflation_data$RollingAvg_Inflation <- rolling_average(inflation_data$Inflation, 3)


inflation_data$Year <- seq(1991, 2023)  

plot(inflation_data$Year, inflation_data$RollingAvg_Inflation,
     type = "l", col = "blue", lwd = 2,
     xlab = "Year", ylab = "3-Year Rolling Avg of Inflation",
     main = "3-Year Rolling Average of U.S. Inflation (via C Function)")
