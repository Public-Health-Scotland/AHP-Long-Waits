# 1. Set up ----################################################################

# Load Packages ----
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr,
               lubridate,
               readxl,
               tidyverse,
               here,
               plotly,
               phsstyles)

data <- read_excel(here("data", "Waiting Monthly [New Time-Bands] Snapshot ---Extended---.xlsx")) %>%
  filter(`Indicator` %in% c("Patients waiting",
         "43 - 56 weeks",
         "57 - 60 weeks",
         "61 - 64 weeks",
         "65 - 68 weeks",
         "69 - 72 weeks",
         "73 - 76 weeks",
         "77 - 80 weeks",
         "81 - 84 weeks",
         "85 - 88 weeks",
         "89 - 92 weeks",
         "93 - 96 weeks",
         "97 - 100 weeks",
         "100 - 104 weeks",
         "104+ weeks",
         "52+ weeks",
         "156+ weeks",
         "208+ weeks"))

scotland <- data %>% filter(`NHS Board` == "Scotland") %>% filter(Indicator %in% c("52+ weeks", 
                                                                                   "104+ weeks",
                                                                                   "156+ weeks",
                                                                                   "208+ weeks"
                                                                                   )) %>% 
  filter(Specialty == "All AHP MSK Specialties")


scotland %>%
  plot_ly() %>% 
  add_bars( 
           x = ~`Month end`,
           y = ~Value, color = ~Indicator,
           colors = phs_colors(c("phs-blue", "phs-rust", "phs-purple", "phs-green")),
           stroke = I("black"))
