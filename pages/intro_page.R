####################### Intro Page #######################

output$intro_page_ui <-  renderUI({

  div(
	     fluidRow(
	       h1("AHP-MSK Long Waits"),
	       h2("Notes"),
	       p(""),
	       
	       plotlyOutput("intro_plot")
	      ) #fluidrow
   ) # div
}) # renderUI

output$intro_plot <- renderPlotly({
  intro_plot(data, "Scotland", "All AHP MSK Specialties")
})