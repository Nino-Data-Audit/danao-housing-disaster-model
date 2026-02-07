---
title: 'Disaster Risk Modeling: Housing Damage Prediction in Danao City'
author: "Nino Jay Talingting"
date: "`r Sys.Date()`"
output:
  pdf_document: default
  html_document: default
editor_options:
  chunk_output_type: console
---

# --- 1. ENVIRONMENT & SETUP ---
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = FALSE, message = FALSE, warning = FALSE)
library(readxl)
library(kableExtra)
library(pwr)
library(tidyverse)

# --- 2. IMPORT ---
df_raw <- read_excel("typhoon_data.xlsx")

# ---3. ETL ---
# Logic: Address the 'K' multiplier and binary outcomes mathematically.
df_clean <- df_raw %>%
  mutate(
    # Clean Income: Handle decimals like "5.5K" correctly
    INCOME_RAW = str_to_upper(`MONTHLY FAMILY INCOME`),
    INCOME_NUM = case_when(
      str_detect(INCOME_RAW, "K") ~ as.numeric(str_remove_all(INCOME_RAW, "[^0-9.]")) * 1000,
      INCOME_RAW %in% c("NONE", "0", "N/A") ~ 0,
      TRUE ~ as.numeric(str_remove_all(INCOME_RAW, "[^0-9.]"))
    ),
    # Binary Predictor: Use 'Above Low' as the Reference Level
    INCOME_SIMPLIFIED = factor(ifelse(INCOME_NUM < 5000, "Low", "Above Low"), 
                               levels = c("Above Low", "Low")),
    # Binary Outcome: Isolate Total Destruction
    IS_TOTAL_DAMAGE = case_when(
      str_detect(REMARKS, "TOTALLY") ~ 1,
      str_detect(REMARKS, "PARTIALLY|NONE|NO DAMAGE") ~ 0,
      TRUE ~ NA_real_
    )
  ) %>%
  drop_na(IS_TOTAL_DAMAGE, INCOME_SIMPLIFIED) # Audit: Remove rows that break the model logic

# --- 4. MODELING ---
# Logic: Fit the Logistic Regression to quantify the Risk Multiplier (OR).
final_model <- glm(IS_TOTAL_DAMAGE ~ INCOME_SIMPLIFIED, 
                   data = df_clean, 
                   family = binomial)

# --- 5. AUDIT REPORT ---
# Logic: Extracting the Odds Ratio for 'Low Income'
summary_table <- data.frame(
  Variable = "Low Income (Relative to Above Low)",
  `Odds Ratio` = exp(coef(final_model)[2]),
  `P_Value` = summary(final_model)$coefficients[2, 4]
)

summary_table %>%
  kbl(digits = 3, caption = "Risk Multipliers: Socio-Economic Impact") %>%
  kable_styling(bootstrap_options = c("striped", "condensed"), full_width = F) %>%
  column_spec(3, color = ifelse(summary_table$P_Value < 0.1, "red", "black"), bold = T)

# Logic: Validating findings with Fisher's Exact Test due to small N (177).
income_damage_tab <- table(df_clean$INCOME_SIMPLIFIED, df_clean$IS_TOTAL_DAMAGE)
fisher_results <- fisher.test(income_damage_tab)

rownames(income_damage_tab) <- c("Above Low Income", "Low Income")
colnames(income_damage_tab) <- c("Partial/No Damage", "Total Destruction")

income_damage_tab %>%
  kbl(caption = "Contingency Table: Income vs. Housing Destruction") %>%
  kable_classic(full_width = F) %>%
  add_header_above(c(" " = 1, "Housing Outcome" = 2))

cat("Fisher's Exact P-Value:", round(fisher_results$p.value, 4))

# Logic: Determine required N to achieve 80% Power for the LGU.
p_above <- 10 / 84
p_low <- 20 / 89
h_val <- pwr::ES.h(p_above, p_low)
p_calc <- pwr::pwr.2p.test(h = h_val, sig.level = 0.05, power = 0.80)

power_results <- data.frame(
  Metric = c("Effect Size (h)", "Current Sample Size", "Target Confidence Power", "Required N (per group)"),
  Value = c(round(h_val, 3), nrow(df_clean), "80%", ceiling(p_calc$n))
)

#Logic: Powe Analysis
power_results %>%
  kbl(caption = "Required Sample Size for Policy Mandate") %>%
  kable_styling(full_width = F, bootstrap_options = "striped")
