####################### Page 1 #######################

output$page_1_ui <-  renderUI({
  
  div(
    fluidRow(
      h1("AHP MSK Long Waits"),
      div(style="display:inline-block",inputPanel(selectInput("board",
                                                              label = "Select a Board",
                                                              choices = unique(data$`NHS Board`),
                                                              selected = "Scotland"))),
      div(style="display:inline-block",inputPanel(selectInput("specialty",
                                                              label = "Select a Specialty",
                                                              choices = unique(data$Specialty),
                                                              selected = "All AHP MSK Specialties"))),
      
      linebreaks(2),
      h2("Breakdown of Length of Wait"),
      plotlyOutput("top_plot"),
      linebreaks(2),
      fluidRow(
        div(style="display:inline-block",inputPanel(selectInput("indicator",
                                                                label = "Select an Indicator",
                                                                choices = c("25 - 28 weeks",
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
                                                                            "208+ weeks"),
                                                                selected = "52+ weeks"))),
        h2("Breakdown of Specialty for 52+ week wait"),
        plotlyOutput("bottom_plot"),
        linebreaks(2)
      ) #fluidrow
    ) # div
    
    
  )
}) # renderUI


# Plotly plot example
output$top_plot <- renderPlotly({
  area_plot(data, input$board, input$specialty)
})

output$bottom_plot <- renderPlotly({
  area2_plot(data, input$board, input$indicator)
})