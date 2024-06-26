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

scotland1 <- data %>% filter(`NHS Board` == "Scotland") %>% filter(Indicator == "52+ weeks") %>% 
  filter(Specialty == "All AHP MSK Specialties")

scotland2 <- data %>% filter(`NHS Board` == "Scotland") %>% filter(Indicator == "104+ weeks") %>% 
  filter(Specialty == "All AHP MSK Specialties")

physio <- data %>% filter(Specialty == "Physiotherapy") %>% filter(Indicator == "52+ weeks") %>% 
  filter(`NHS Board` != "Scotland")

# Lines ----
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

# Area ----
area <- plot_ly(x = ~scotland2$`Month end`,
               y = ~scotland2$Value,
               type = 'scatter',
               mode = 'lines',
               line = list(color = phs_colors("phs-green")),
               name = '104+ Weeks',
               fill = 'tonexty',
               #stackgroup = 'one',
               fillcolor = 'rgba(131, 187, 38, 0.25)'
               )

area <- area %>% add_trace(x = ~scotland1$`Month end`,
                         y = ~scotland1$Value,
                         line = list(color = phs_colors("phs-purple")),
                         name = '52+ Weeks',
                         fill = 'tonexty',
                         fillcolor = 'rgba(63, 54, 133, 0.25)')
area <- area %>% layout(xaxis = list(title = 'Month End'),
                      yaxis = list(title = 'Patients Waiting'))
area


scotland_CP <- data %>% filter(`NHS Board` == "Scotland") %>% filter(Indicator == "52+ weeks") %>% 
  filter(Specialty == "Chiropody/Podiatry")

scotland_OT <- data %>% filter(`NHS Board` == "Scotland") %>% filter(Indicator == "52+ weeks") %>% 
  filter(Specialty == "Occupational Therapy")

scotland_OR <- data %>% filter(`NHS Board` == "Scotland") %>% filter(Indicator == "52+ weeks") %>% 
  filter(Specialty == "Physiotherapy")

scotland_PH <- data %>% filter(`NHS Board` == "Scotland") %>% filter(Indicator == "52+ weeks") %>% 
  filter(Specialty == "Physiotherapy")

area2 <- plot_ly(x = ~scotland_CP$`Month end`,
                y = ~scotland_CP$Value,
                type = 'scatter',
                mode = 'lines',
                line = list(color = phs_colors("phs-green")),
                name = 'Chiropody/Podiatry',
                stackgroup = 'one',
                fillcolor = 'rgba(131, 187, 38, 0.5)')

area2 <- area2 %>% add_trace(x = ~scotland_OT$`Month end`,
                           y = ~scotland_OT$Value,
                           line = list(color = phs_colors("phs-purple")),
                           name = 'Occupational Therapy',
                           fillcolor = 'rgba(63, 54, 133, 0.5)')

area2 <- area2 %>% add_trace(x = ~scotland_OR$`Month end`,
                             y = ~scotland_OR$Value,
                             line = list(color = phs_colors("phs-rust")),
                             name = 'Orthorics',
                             fillcolor = 'rgba(199, 57, 24, 0.5)')

area2 <- area2 %>% add_trace(x = ~scotland_PH$`Month end`,
                             y = ~scotland_PH$Value,
                             line = list(color = phs_colors("phs-teal")),
                             name = 'Physiotherapy',
                             fillcolor = 'rgba(30, 127, 132, 0.5)')

area2 <- area2 %>% layout(xaxis = list(title = 'Month End'),
                        yaxis = list(title = 'Patients Waiting'))

area2





