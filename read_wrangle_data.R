# 1. Set up ----################################################################

# Load Packages ----
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr,
               readr,
               lubridate,
               readxl,
               tidyverse,
               openxlsx,
               here)

file <- here("data", "Waiting Monthly [New Time-Bands] Snapshot ---Extended---.xlsx")
test <- read_excel(file)
