####################### Page 1 #######################

output$page_1_ui <-  renderUI({

  div(
	     fluidRow(
            h3("This is a header"),
	           p("This is some text"),
	           p(strong("This is some bold text"))

	      ) #fluidrow
   ) # div
}) # renderUI


# Plotly plot example
output$top_plot <- renderPlotly({
  area_plot(data, "Scotland", "Physiotherapy")
})

output$bottom_plot <- renderPlotly({
  area2_plot(data, "Scotland", "52+ weeks")
})