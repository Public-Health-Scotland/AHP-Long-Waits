####################### Intro Page #######################

output$intro_page_ui <-  renderUI({

  div(
	     fluidRow(
	       h1("AHP-MSK Long Waits"),
	       h2("Notes"),
	       p("This dashboard has been created to assist with conversations around long patient waits for AHP-MSK services."),
	       p("The chart below shows the monthly distribution of patients waits from 25 weeks up to 52 weeks from March 2023 to March 2024."),
	       p("The Breakdown tab contains two charts which provide alternative views of these figures.
	         The first shows waits from 52+ weeks up to 208+ weeks, and can be be filtered by Board and Specialty.
	         The second shows the breakdown of all 4 specialties and can be filtered by Board and Time Band."),
	       
	       plotlyOutput("intro_plot")
	      ) #fluidrow
   ) # div
}) # renderUI

output$intro_plot <- renderPlotly({
  intro_plot(data, "Scotland", "All AHP MSK Specialties")
})