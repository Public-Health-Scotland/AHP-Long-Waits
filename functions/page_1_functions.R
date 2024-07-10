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
                  fillcolor = 'rgba(131, 187, 38, 0.5)'
  )
  
  area <- area |> add_trace(x = ~sub3$`Month end`,
                            y = ~sub3$Value,
                            line = list(color = phs_colors("phs-purple")),
                            name = '156+ Weeks',
                            fill = 'tonexty',
                            fillcolor = 'rgba(63, 54, 133, 0.5)')
  
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
  
  area <- area |> layout(xaxis = list(title = '', 
                                      tickvals = c("2023-03-31", "2023-06-30", "2023-09-30", "2023-12-31", "2024-03-31"), 
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
                                      tickfont = list(size = 14)),
                         hovermode = "x unified")
  area <- area |> config(modeBarButtonsToRemove = bttn_remove)
  return(area)
}

area2_plot <- function(data, board, indicator){
  podiatry <- data |> filter(`NHS Board` %in% board) |> filter(Indicator %in% indicator) |> 
    filter(Specialty %in% "Podiatry")
  
  ot <- data |> filter(`NHS Board` %in% board) |> filter(Indicator %in% indicator) |> 
    filter(Specialty %in% "Occupational Therapy")
  
  ortho <- data |> filter(`NHS Board` %in% board) |> filter(Indicator %in% indicator) |> 
    filter(Specialty %in% "Orthotics")
  
  physio <- data |> filter(`NHS Board` %in% board) |> filter(Indicator %in% indicator) |> 
    filter(Specialty %in% "Physiotherapy")
  
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
  
  area2 <- area2 |>  layout(xaxis = list(title = '', 
                                         tickvals = c("2023-03-31", "2023-06-30", "2023-09-30", "2023-12-31", "2024-03-31"), 
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
                                         tickfont = list(size = 14)),
                            hovermode = "x unified")
  area2 <- area2 |> config(modeBarButtonsToRemove = bttn_remove)
  
  return(area2)
}