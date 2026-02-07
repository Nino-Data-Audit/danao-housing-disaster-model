# danao-housing-disaster-model
Logistic Regression model analyzing housing vulnerability for n=177 households in Danao City.

I. The Objective

This repository contains a Socio-Economic Risk Audit of housing destruction in Danao City following Typhoon Tino. The goal was to determine if household income serves as a statistically significant predictor of structural failure.

II. The Universal Workflow
Environment: Built in R using tidyverse for ETL and pwr for sensitivity analysis.

The ETL (Logical Audit): * Income Normalization: Addressed non-standard survey entries (e.g., "5.5K") using mathematical multipliers to preserve economic variance.

Binary Transformation: Categorized housing outcomes into a "Total Destruction" success/failure model.

Modeling & Validation:Logistic Regression: Utilized to calculate Adjusted Odds Ratios.

Fisher’s Exact Test: Implemented as a nonparametric pivot to handle small-sample sparsity ($n=177$).

Finding: Households in the "Low Income" bracket faced a 2.01x higher risk of total housing destruction compared to higher-income counterparts.

Audit: The p-value of 0.096 was flagged as a "High-Signal/Small-Sample" indicator.The Roadmap: Post-hoc Power Analysis determined that an expansion to $N \approx 500$ is required to transition this signal into a $95\%$ confidence policy mandate.
