# 1. Set up ----################################################################

# Load Packages ----
if (!require("pacman")) install.packages("pacman")
pacman::p_load(dplyr,
               lubridate,
               readxl,
               here,
               plotly,
               stringr,
               phsstyles)

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

get_ticks <- function(data){
  min <- unique(data$`Month end`)
  ticks <- min[seq(1, length(min), 3)]
  return(ticks)
}

waiting_times_palette <- phs_colours(c("phs-green-80",  "phs-rust-80", "phs-teal-80","phs-purple-80"))

# Data Frames ----
scotland1 <- data |> filter(`NHS Board` == "Scotland") |> filter(Indicator == "52+ weeks") |> 
  filter(Specialty == "All AHP MSK Specialties")

scotland2 <- data |> filter(`NHS Board` == "Scotland") |> filter(Indicator == "104+ weeks") |> 
  filter(Specialty == "All AHP MSK Specialties")

physio <- data |> filter(Specialty == "Physiotherapy") |> filter(Indicator == "52+ weeks") |> 
  filter(`NHS Board` != "Scotland")

# Experiment ----
experiment <- function(dataset, board, indicator){
  podiatry <- dataset |> filter(`NHS Board` == board) |> filter(Indicator == indicator) |> 
    filter(Specialty == "Podiatry")
  
  ot <- dataset |> filter(`NHS Board` == board) |> filter(Indicator == indicator) |> 
    filter(Specialty == "Occupational Therapy")
  
  ortho <- dataset |> filter(`NHS Board` == board) |> filter(Indicator == indicator) |> 
    filter(Specialty == "Orthotics")
  
  physio <- dataset |> filter(`NHS Board` == board) |> filter(Indicator == indicator) |> 
    filter(Specialty == "Physiotherapy")
  
  exp <- plot_ly(x = ~podiatry$`Month end`,
             y = ~podiatry$Value,
             type = 'bar',
             name = 'Podiatry',
             colors = waiting_times_palette,
             color = ~podiatry$Specialty)
  
  exp <- exp |> add_bars(x = ~ot$`Month end`,
                         y = ~ot$Value,
                         type = 'bar',
                         name = 'Occupational Therapy',
                         colors = waiting_times_palette,
                         color = ~ot$Specialty)
  
  exp <- exp |> add_bars(x = ~ortho$`Month end`,
                         y = ~ortho$Value,
                         type = 'bar',
                         name = 'Orthotics',
                         colors = waiting_times_palette,
                         color = ~ortho$Specialty)
  
  exp <- exp |> add_bars(x = ~physio$`Month end`,
                         y = ~physio$Value,
                         type = 'bar',
                         name = 'Physiotherapy',
                         colors = waiting_times_palette,
                         color = ~physio$Specialty)
  
  exp <- exp |> layout(xaxis = list(title = '',
                                      # Define x-axis ticks because the default is incorrect
                                      tickvals = get_ticks(dataset), 
                                      tickformat = "%b-%y",
                                      showline = T, 
                                      linewidth=2,
                                      linecolor = 'black',
                                      ticks = "outside",
                                      tickfont = list(size = 14)),
                         yaxis = list(title = 'Number', 
                                      tickformat = ",d", 
                                      showline = T, 
                                      linewidth=2, 
                                      linecolor = 'black', 
                                      ticks = "outside",
                                      tickfont = list(size = 14)))
  
  return(exp)
}
experiment(data, "Scotland", "52+ weeks")


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
  podiatry <- data |> filter(`NHS Board` == board) |> filter(Indicator == indicator) |> 
    filter(Specialty == "Podiatry")
  
  ot <- data |> filter(`NHS Board` == board) |> filter(Indicator == indicator) |> 
    filter(Specialty == "Occupational Therapy")
  
  ortho <- data |> filter(`NHS Board` == board) |> filter(Indicator == indicator) |> 
    filter(Specialty == "Orthotics")
  
  physio <- data |> filter(`NHS Board` == board) |> filter(Indicator == indicator) |> 
    filter(Specialty == "Physiotherapy")
  
  area2 <- plot_ly(x = ~podiatry$`Month end`,
                   y = ~podiatry$Value,
                   type = 'scatter',
                   mode = 'lines',
                   line = list(color = phs_colors("phs-green")),
                   name = 'Podiatry',
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

# Distribution ----

# Set order of levels for Indicator column
data$Indicator <- factor(data$Indicator,
                                        levels=c("25 - 28 weeks",
                                                 "29 - 32 weeks",
                                                 "33 - 36 weeks",
                                                 "37 - 40 weeks",
                                                 "41 - 44 weeks",
                                                 "45 - 48 weeks",
                                                 "49 - 52 weeks")
)

# Create filtered_data to use in the distribution of wait chart

waiting_times_palette <- phs_colours(c("phs-blue-80","phs-blue-50", "phs-blue-30", "phs-graphite-80","phs-graphite-50", "phs-graphite-30","phs-magenta-80","phs-magenta-50"))

distribution_number_filtered <- data |>
  filter(`NHS Board` == "Scotland") |>
  filter(Specialty == "All AHP MSK Specialties")


# Create chart using plotly
  plot_ly(distribution_number_filtered, 
          x = ~`Month end`,
          y = ~`Value`,
          hoverinfo = 'text',
          hovertext = ~paste(paste("Month end:", `Month end`),
                             paste("Value:",`Value`),
                             paste("Distribution band:", Indicator),
                             sep = "\n"),
          type = "bar",
          color = ~Indicator,
          colors = waiting_times_palette) |>
    layout(legend = list(orientation = 'h', 
                         traceorder = 'normal',
                         x = 0.0, 
                         y = -0.2,
                         font = list(size = 14)),
           yaxis = list(title = 'Number', 
                        tickformat = ",d", 
                        showline = T, 
                        linewidth=2, 
                        linecolor = 'black', 
                        ticks = "outside",
                        tickfont = list(size = 14)), 
           barmode = 'stack', 
           xaxis = list(title = '', 
                        tickvals = c("2023-03-31", "2023-06-30", "2023-09-30", "2023-12-31", "2024-03-31"),
                        tickformat = "%b-%y", 
                        ticks = "outside", 
                        showline = T, 
                        linewidth = 2, 
                        linecolor = 'black',
                        tickfont = list(size = 14))
           
    ) #|>
    #config(displaylogo = F, displayModeBar = TRUE, modeBarButtonsToRemove = bttn_remove )  


