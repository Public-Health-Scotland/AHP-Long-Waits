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

data <- read_excel(here("data", "Waiting Monthly [New Time-Bands] Snapshot ---Extended---.xlsx")) |>
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

# Data Frames ----
scotland1 <- data |> filter(`NHS Board` == "Scotland") |> filter(Indicator == "52+ weeks") |> 
  filter(Specialty == "All AHP MSK Specialties")

scotland2 <- data |> filter(`NHS Board` == "Scotland") |> filter(Indicator == "104+ weeks") |> 
  filter(Specialty == "All AHP MSK Specialties")

physio <- data |> filter(Specialty == "Physiotherapy") |> filter(Indicator == "52+ weeks") |> 
  filter(`NHS Board` != "Scotland")

# Lines ----
lines1 <- plot_ly() |>
  add_lines(
    x = ~scotland1$`Month end`,
    y = ~scotland1$Value,
    color = ~scotland1$Indicator,
    colors = phs_colors(c("phs-green", "phs-rust"))
  )
lines1 <- lines1 |>
  add_lines(
    x = ~scotland2$`Month end`,
    y = ~scotland2$Value,
    color = ~scotland2$Indicator
  )
lines1

# Area ----

area_plot <- function(dataset, board, specialty){
  
  sub1 <- dataset |> filter(`NHS Board` == board) |> filter(Indicator == "52+ weeks") |> 
    filter(Specialty == specialty)
  
  sub2 <- dataset |> filter(`NHS Board` == board) |> filter(Indicator == "104+ weeks") |> 
    filter(Specialty == specialty)
  
  sub3 <- dataset |> filter(`NHS Board` == board) |> filter(Indicator == "156+ weeks") |> 
    filter(Specialty == specialty)
  
  sub4 <- dataset |> filter(`NHS Board` == board) |> filter(Indicator == "208+ weeks") |> 
    filter(Specialty == specialty)
  
  
  area <- plot_ly(x = ~sub4$`Month end`,
                 y = ~sub4$Value,
                 type = 'scatter',
                 mode = 'lines',
                 line = list(color = phs_colors("phs-green")),
                 name = '208+ Weeks',
                 fill = 'tonexty',
                 #stackgroup = 'one',
                 fillcolor = 'rgba(131, 187, 38, 0.25)'
                 )
  
  area <- area |> add_trace(x = ~sub3$`Month end`,
                           y = ~sub3$Value,
                           line = list(color = phs_colors("phs-purple")),
                           name = '156+ Weeks',
                           fill = 'tonexty',
                           fillcolor = 'rgba(63, 54, 133, 0.25)')
  
  area <- area |> add_trace(x = ~sub2$`Month end`,
                            y = ~sub2$Value,
                            line = list(color = phs_colors("phs-rust")),
                            name = '104+ Weeks',
                            fill = 'tonexty',
                            fillcolor = 'rgba(199, 57, 24, 0.5)')
  
  area <- area |> add_trace(x = ~sub1$`Month end`,
                            y = ~sub1$Value,
                            line = list(color = phs_colors("phs-teal")),
                            name = '52+ Weeks',
                            fill = 'tonexty',
                            fillcolor = 'rgba(30, 127, 132, 0.5)')
  
  area <- area |> layout(xaxis = list(title = 'Month End'),
                        yaxis = list(title = 'Patients Waiting'))
  return(area)
}
area_plot(data, "Scotland", "Physiotherapy")

# Area 2 ----
area2_plot <- function(data, board, indicator){
  chiro <- data |> filter(`NHS Board` == board) |> filter(Indicator == indicator) |> 
    filter(Specialty == "Chiropody/Podiatry")
  
  ot <- data |> filter(`NHS Board` == board) |> filter(Indicator == indicator) |> 
    filter(Specialty == "Occupational Therapy")
  
  ortho <- data |> filter(`NHS Board` == board) |> filter(Indicator == indicator) |> 
    filter(Specialty == "Orthotics")
  
  physio <- data |> filter(`NHS Board` == board) |> filter(Indicator == indicator) |> 
    filter(Specialty == "Physiotherapy")
  
  area2 <- plot_ly(x = ~chiro$`Month end`,
                   y = ~chiro$Value,
                   type = 'scatter',
                   mode = 'lines',
                   line = list(color = phs_colors("phs-green")),
                   name = 'Chiropody/Podiatry',
                   stackgroup = 'one',
                   fillcolor = 'rgba(131, 187, 38, 0.5)')
  
  area2 <- area2 |> add_trace(x = ~ot$`Month end`,
                              y = ~ot$Value,
                              line = list(color = phs_colors("phs-purple")),
                              name = 'Occupational Therapy',
                              fillcolor = 'rgba(63, 54, 133, 0.5)')
  
  area2 <- area2 |> add_trace(x = ~ortho$`Month end`,
                              y = ~ortho$Value,
                              line = list(color = phs_colors("phs-rust")),
                              name = 'Orthorics',
                              fillcolor = 'rgba(199, 57, 24, 0.5)')
  
  area2 <- area2 |> add_trace(x = ~physio$`Month end`,
                              y = ~physio$Value,
                              line = list(color = phs_colors("phs-teal")),
                              name = 'Physiotherapy',
                              fillcolor = 'rgba(30, 127, 132, 0.5)')
  
  area2 <- area2 |>  layout(xaxis = list(title = 'Month End'),
                            yaxis = list(title = 'Patients Waiting'))
  
  return(area2)
}
  
area2_plot(data, "Scotland", "208+ weeks")




