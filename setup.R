####################### Setup #######################

if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr,
               shiny,
               shinycssloaders,
               lubridate,
               readxl,
               tidyverse,
               here,
               plotly,
               phsstyles)

# Use remotes to install phsstyles from GitHub if pacman installation fails.
if (!require("phsstyles")) remotes::install_github("Public-Health-Scotland/phsstyles")

# Load core functions ----
source("functions/core_functions.R")

# Buttons to remove from plotly plots
bttn_remove <-  list('select2d', 'lasso2d', 'zoomIn2d', 'zoomOut2d',
                     'autoScale2d',   'toggleSpikelines',  'hoverCompareCartesian',
                     'hoverClosestCartesian')

# Load in data
data <- read_excel(here("data", "Waiting Monthly [New Time-Bands] Snapshot ---Extended---.xlsx")) |> 
  mutate(`Specialty` = str_remove(`Specialty`, "Chiropody/")) |> # Remove the word 'Chiropody' from 'Podiatry' as this is no longer used.
  filter(Indicator %in% c("25 - 28 weeks", # Filter out the irrelevant shorter timebands to only show patients waiting longer than 24 weeks.
                          "29 - 32 weeks",
                          "33 - 36 weeks",
                          "37 - 40 weeks",
                          "41 - 44 weeks",
                          "45 - 48 weeks",
                          "49 - 52 weeks",
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
                          "4+ weeks",
                          "16+ weeks",
                          "24+ weeks",
                          "52+ weeks",
                          "104+ weeks",
                          "156+ weeks",
                          "208+ weeks"
                          ))

