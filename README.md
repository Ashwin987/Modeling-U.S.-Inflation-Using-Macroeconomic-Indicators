Modeling U.S. Inflation Using Macroeconomic Indicators

Author: Ashwin Ramaseshan
Course: STAT 404

Overview

This project analyzes U.S. inflation from 1991–2023 and examines how key macroeconomic indicators relate to inflation trends. The goal is to identify which variables best explain inflation behavior over time using both linear and nonlinear statistical models.

Data

Inflation rate (%)

GDP growth (%)

Interest rate (%)

Unemployment rate (%)

Data were compiled from publicly available sources including Kaggle and the World Bank.

Methods

Exploratory Data Analysis (EDA)

Linear Regression

Kernel Regression (LOESS)

Generalized Additive Models (GAM)

A custom C implementation was used to compute a rolling average of inflation and integrated into R.

Key Findings

Linear regression performed poorly and failed to capture the complexity of the data.

Nonlinear methods (GAM and kernel regression) provided a much better fit.

Unemployment rate showed the most consistent and interpretable relationship with inflation, supporting Phillips Curve–style dynamics.

Files

code.r – Main R analysis

Inflation_Project_404_Final_Report.pdf – Final report

CSV files – Macroeconomic datasets

rolling_average.c – C implementation for rolling average

Notes

This project was completed as part of STAT 404 and focuses on modeling and interpretation rather than forecasting.
