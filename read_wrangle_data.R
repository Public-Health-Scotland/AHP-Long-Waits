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

scotland1 <- data %>% filter(`NHS Board` == "Scotland") %>% filter(Indicator %in% c("52+ weeks")) %>% 
  filter(Specialty == "All AHP MSK Specialties")

scotland2 <- data %>% filter(`NHS Board` == "Scotland") %>% filter(Indicator %in% c("104+ weeks")) %>% 
  filter(Specialty == "All AHP MSK Specialties")

lines1 <- plot_ly() %>%
  add_lines(
    x = ~scotland1$`Month end`,
    y = ~scotland1$Value,
    color = ~scotland1$Indicator,
    colors = phs_colors(c("phs-green", "phs-rust"))
  )
lines1 <- lines1 %>%
  add_lines(
    x = ~scotland2$`Month end`,
    y = ~scotland2$Value,
    color = ~scotland2$Indicator
  )
lines1

fig <- plot_ly(x = ~scotland1$`Month end`,
               y = ~scotland1$Value,
               type = 'scatter',
               mode = 'lines',
               line = list(color = phs_colors("phs-green")),
               name = '52+ Weeks',
               #fill = 'tozeroy',
               stackgroup = 'one',
               fillcolor = 'rgba(131, 187, 38, 0.25)'
               )

fig <- fig %>% add_trace(x = ~scotland2$`Month end`,
                         y = ~scotland2$Value,
                         line = list(color = phs_colors("phs-purple")),
                         name = '104+ Weeks',
                         #fill = 'tozeroy',
                         fillcolor = 'rgba(63, 54, 133, 0.25)')
fig <- fig %>% layout(xaxis = list(title = 'Month End'),
                      yaxis = list(title = 'Patients Waiting'))

fig
