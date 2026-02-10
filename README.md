# Housing-Vulnerability-Integrity-Audit
Logistic Regression model analyzing housing vulnerability for n=177 households in Danao City.

📊 Project Overview

This repository executes a Socio-Economic Risk Audit of housing destruction in Danao City following Typhoon Tino ($n=177$). The framework investigates the causal relationship between household income and structural failure, focusing on detecting "High-Signal" indicators in small-sample disaster datasets. 

🛠️ Technical Workflow (The Universal Logic)
Environment: Built in R using tidyverse for ETL and pwr for sensitivity analysis. 

The ETL (Logical Audit): * Normalization: Addressed non-standard survey entries (e.g., "5.5K") using mathematical multipliers to preserve economic variance and prevent data loss. 

Binary Transformation: Structured housing outcomes into a binary "Total Destruction" success/failure model. 

Modeling & Validation:Logistic Regression: Utilized to calculate Adjusted Odds Ratios for income-based structural risk. 

Nonparametric Pivot: Implemented Fisher’s Exact Test to handle small-sample sparsity and mitigate parametric bias. 

Integrity Check: Flagged $p = 0.096$ as a high-signal indicator requiring a power-based roadmap for policy conversion. 

Key Results:

The Risk Multiplier: Low-income households exhibited a 2.01x higher risk (Odds Ratio) of total housing destruction compared to higher-income counterparts. 

The Policy Roadmap: Post-hoc Power Analysis determined that an expansion to $N \approx 500$ is required to transition this signal into a 95% Confidence Policy Mandate. 
