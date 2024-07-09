####################### Page 1 functions #######################


area_plot <- function(dataset, board, specialty){
  
  sub1 <- dataset |> filter(`NHS Board` %in% board) |> filter(Indicator %in% "52+ weeks") |> 
    filter(Specialty %in% specialty)
  
  sub2 <- dataset |> filter(`NHS Board` %in% board) |> filter(Indicator %in% "104+ weeks") |> 
    filter(Specialty %in% specialty)
  
  sub3 <- dataset |> filter(`NHS Board` %in% board) |> filter(Indicator %in% "156+ weeks") |> 
    filter(Specialty %in% specialty)
  
  sub4 <- dataset |> filter(`NHS Board` %in% board) |> filter(Indicator %in% "208+ weeks") |> 
    filter(Specialty %in% specialty)
  
  
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
  area <- area |> config(modeBarButtonsToRemove = bttn_remove)
  return(area)
}

area2_plot <- function(data, board, indicator){
  chiro <- data |> filter(`NHS Board` %in% board) |> filter(Indicator %in% indicator) |> 
    filter(Specialty %in% "Chiropody/Podiatry")
  
  ot <- data |> filter(`NHS Board` %in% board) |> filter(Indicator %in% indicator) |> 
    filter(Specialty %in% "Occupational Therapy")
  
  ortho <- data |> filter(`NHS Board` %in% board) |> filter(Indicator %in% indicator) |> 
    filter(Specialty %in% "Orthotics")
  
  physio <- data |> filter(`NHS Board` %in% board) |> filter(Indicator %in% indicator) |> 
    filter(Specialty %in% "Physiotherapy")
  
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
  area2 <- area2 |> config(modeBarButtonsToRemove = bttn_remove)
  
  return(area2)
}