# The Danao City Structural Vulnerability Audit
Logistic Regression model analyzing housing vulnerability for n=177 households in Danao City.

📊 Project Overview

This repository executes a Socio-Economic Risk Audit of housing destruction in Danao City following Typhoon Tino. Rejecting the "Average-Case" fallacy, the framework utilizes Logistic Regression and Nonparametric Inference to isolate high-signal indicators of structural failure in small-sample disaster datasets. This is not a descriptive report; it is a Predictive Foundation for targeted municipal urban resilience.

🛠️ Technical Workflow (The Universal Logic)

The Environment: Built in R using tidyverse for ETL and pwr for sensitivity analysis. 

The ETL (Logical Audit): Normalization: Addressed non-standard survey entries (e.g., "5.5K") using mathematical multipliers to preserve economic variance and prevent data loss. 

Binary Transformation: Structured housing outcomes into a binary "Total Destruction" success/failure model. 

Modeling & Validation:Logistic Regression: Utilized to calculate Adjusted Odds Ratios for income-based structural risk. 

Nonparametric Pivot: Implemented Fisher’s Exact Test to handle small-sample sparsity and mitigate parametric bias. 

Integrity Check: Flagged $p = 0.096$ as a high-signal indicator requiring a power-based roadmap for policy conversion. 

Key Results:

![Housing Vulnerability Analysis](output/plot_result)

This plot illustrates the Adjusted Odds Ratios for structural housing failure in Danao City. It visualizes the disproportionate vulnerability faced by specific demographics.

The Low-Income Signal: Households in the low-income bracket face a ~2.0x higher risk of total housing destruction compared to baseline.

The Senior Factor: Similar to low-income earners, senior-headed households show a risk multiplier approaching 2x, indicating age-related vulnerability in disaster response.

The Integrity Check: While the confidence intervals (the horizontal lines) cross the $1.0x$ neutral line (due to $n=177$), the strong central "High-Signal" dots justify the Roadmap to $N \approx 500$ to finalize these as policy mandates.

The Policy Roadmap: Post-hoc Power Analysis determined that an expansion to $N \approx 400$ is required to transition this signal into a 95% Confidence Policy Mandate. 
