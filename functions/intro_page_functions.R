####################### Intro Page functions #######################

intro_plot <- function(dataset, board, specialty){

  dataset$Indicator <- factor(dataset$Indicator,
                           levels=c("25 - 28 weeks",
                                    "29 - 32 weeks",
                                    "33 - 36 weeks",
                                    "37 - 40 weeks",
                                    "41 - 44 weeks",
                                    "45 - 48 weeks",
                                    "49 - 52 weeks")
  )
  
  # Create filtered dataset from params
  distribution <- dataset |>
    filter(`NHS Board` == board) |>
    filter(`Specialty` == specialty)
  
  # Define colours for stacked sections
  waiting_times_palette <- phs_colours(c("phs-blue-80","phs-blue-50", "phs-blue-30", "phs-purple-50","phs-purple-80","phs-rust-50","phs-rust-80"))
  
  
  intro_plot <- plot_ly(distribution,
                        x = ~`Month end`,
                        y = ~`Value`,
                        hoverinfo = 'text',
                        # Format the hovertext for the chart to be pretty
                        hovertext = ~paste(paste("Month end:", format(`Month end`, "%b-%y")),
                                           paste("Number:", formatC(`Value`, big.mark=",")),
                                           paste("Distribution band:", Indicator),
                                           sep = "\n"),
                        type = "bar",
                        color = ~Indicator,
                        colors = waiting_times_palette)
    
  intro_plot <- intro_plot |> layout(barmode = 'stack',
                                     legend = list(orientation = 'h',
                                                   traceorder = 'normal',
                                                   x = 0.0,
                                                   y = -0.2,
                                                   font = list(size = 12)),
                                     yaxis = list(title = 'Number',
                                                  tickformat = ",d",
                                                  showline = T,
                                                  linewidth=2,
                                                  linecolor = 'black',
                                                  ticks = "outside",
                                                  tickfont = list(size = 14)),
                                     xaxis = list(title = '',
                                                  # Define x-axis ticks as the default is incorrect
                                                  tickvals = c("2023-03-31", "2023-06-30", "2023-09-30", "2023-12-31", "2024-03-31"),
                                                  tickformat = "%b-%y",
                                                  ticks = "outside",
                                                  showline = T,
                                                  linewidth = 2,
                                                  linecolor = 'black',
                                                  tickfont = list(size = 14)))
  
  # Remove unused buttons from plotly
  intro_plot <- intro_plot |> config(modeBarButtonsToRemove = bttn_remove)
  return(intro_plot)
}
